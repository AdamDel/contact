require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.
  def Interact_with_user


    case ARGV[0] 
      

      when nil
        menu = File.open('Main_menu.txt', "r").readlines.each do |line|
         puts line
        end
      
      when "new"
        ARGV.shift
        puts "What is the name of the contact?"
        name = gets.chomp
        puts "what is the email?"
        email = gets.chomp
        Contact.create(name,email)
      
      when "list"
        Contact.all
      
      when "show"
        ARGV.shift
        id = ARGV[0].to_s + " " + ARGV[1].to_s + " " + ARGV[2].to_s
        Contact.find(id)
      when "search"
        ARGV.shift
        term = ARGV[0]
        Contact.search(term)
      else 
      puts "Not a valid input"
      
    end  
  end
end

list = ContactList.new
list.Interact_with_user
