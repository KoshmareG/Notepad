class Post
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
    File.join(__dir__, @created_at.strftime("#{self.class.name}_Y%-%m-%d_%H-%M-%s.txt"))
end
