require_relative 'post'
require_relative 'lib/link'
require_relative 'lib/task'
require_relative 'lib/memo'

puts 'Привет, я твой блокнот!'
puts 'Что хотите записать в блокноте?'

choices = Post.post_types

choice = -1

until (0..choices.size - 1).include?(choice)
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end

  choice = $stdin.gets.chomp.to_i
end

entry = Post.create(choice)

entry.read_from_console

entry.save

puts 'Запись сохранена'
