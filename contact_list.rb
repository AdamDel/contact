#!/usr/local/rvm/rubies/ruby-2.1.3/bin/ruby
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
        name = gets.chomp.downcase.capitalize
        puts "what is the email?"
        email = gets.chomp.downcase

        Contact.create(name: name, email: email)
        when "update"
        ARGV.shift
        id = ARGV[0].to_i #+ " " + ARGV[1].to_s + " " + ARGV[2].to_s
        ARGV.shift
        puts "What is the new name of the contact?"
        name = gets.chomp.downcase.capitalize
        puts "what is the new email?"
        email = gets.chomp.downcase
        contact_to_update = Contact.find(id)
        contact_to_update.update(name: name, email: email)
      when "list"
        contactlist = Contact.all.order(:id)
        contactlist.each { |contact| puts "#{contact[:id]}: #{contact[:name]} -> email: #{contact[:email]}" }
      when "destroy"
         ARGV.shift
          id = ARGV[0].to_i
          contact_to_delete = Contact.find(id)
          contact_to_delete.destroy    
      when "show"
        ARGV.shift
        id = ARGV[0].to_i #+ " " + ARGV[1].to_s + " " + ARGV[2].to_s
        contact_to_show = Contact.find(id)
        puts "#{contact_to_show[:id]}: #{contact_to_show[:name]} -> email: #{contact_to_show[:email]}"
      when "search"
        ARGV.shift
        term = ARGV[0]
        search_results = Contact.where('name LIKE ? OR email LIKE ?',"%#{term}%", "%#{term}%")
        search_results.each { |contact| puts "#{contact[:id]}: #{contact[:name]} -> email: #{contact[:email]}" }
      else 
      puts "Not a valid input"
      
    end  
  end
end

# list = ContactList.new
# list.Interact_with_user
