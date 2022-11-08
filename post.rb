require 'sqlite3'

class Post
  SQLITE_DB_FILE = File.join(__dir__, 'notepad.sqlite')

  def self.post_types
    {'Memo' => Memo, 'Task' => Task, 'Link' => Link}
  end

  def self.create(type)
    post_types[type].new
  end

  def self.find_by_id(id)
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = true

    begin
      result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)
    rescue SQLite3::SQLException => error
      return "Не удалось выполнить запрос в базе notepad.sqlite: #{error.message}"
    end

    db.close

    return "Запись с id - #{id} не найдена" if result.empty?

    post = create(result.first['type'])

    post.load_data(result.first)

    post
  end

  def self.find(limit, type)
    db = SQLite3::Database.open(SQLITE_DB_FILE)

    db.results_as_hash = false

    query = 'SELECT rowid, * FROM posts '

    query += 'WHERE type = :type ' unless type.nil?
    query += 'ORDER by rowid DESC '

    query += 'LIMIT :limit ' unless limit.nil?

    statement = db.prepare(query)

    statement.bind_param('type', type) unless type.nil?
    statement.bind_param('limit', limit) unless limit.nil?

    begin
      result = statement.execute!
    rescue SQLite3::SQLException => error
      return "Не удалось выполнить запрос в базе notepad.sqlite: #{error.message}"
    end

    statement.close
    db.close

    result
  end

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def read_from_console
  end

  def to_strings
  end

  def save
    file = File.new(file_path, 'w:UTF-8')

    to_strings.each do |string|
      file.puts(string)
    end

    file.close
  end

  def file_path
    File.join(__dir__, 'notes', @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt"))
  end

  def save_to_db
    db = SQLite3::Database.open(SQLITE_DB_FILE)
    db.results_as_hash = true

    begin
      db.execute(
        'INSERT INTO posts (' +
          to_db_hash.keys.join(',') +
          ')' +
          ' VALUES (' +
          ('?,' * to_db_hash.keys.size).chomp(',') +
          ')',
        to_db_hash.values
      )
    rescue SQLite3::SQLException => error
      return "Не удалось выполнить запрос в базе notepad.sqlite: #{error.message}"
    end

    insert_row_id = db.last_insert_row_id

    db.close

    insert_row_id
  end

  def to_db_hash
    {'type' => self.class.name, 'created_at' => @created_at.to_s}
  end

  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
  end
end
