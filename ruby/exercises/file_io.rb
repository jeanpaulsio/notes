# array_of_lines = File.readlines("text.txt")
# p array_of_lines

# File.open("text.txt", "w") do |f|
#   f.puts "This will override everything."
# end


# File.open("text.txt", "a") do |f|
#   f.puts "This will append this text."
# end

# File.rename("text.txt", "text_renamed.txt")
# File.rename("text_renamed.txt", "text.txt")

Dir.delete("temp")

puts File.expand_path("text.txt")
puts "text.txt exists!" if File.exist?("text.txt")

puts "current directory:"
puts Dir.pwd

puts "creating a directory:"
Dir.mkdir("temp")

puts "changing into temp directory:"
Dir.chdir("temp")
puts Dir.pwd
