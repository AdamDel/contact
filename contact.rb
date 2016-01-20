require 'csv'
require 'securerandom'
require 'date'
require 'pg'
# Represents a person in an address book.

class EmailExistsAlready < StandardError  
end


class Contact

  attr_accessor :name, :email, :id
  def save 
    if !id.nil?
      #do an update
      self.class.connect.exec_params("UPDATE contacts SET name='#{name}', email='#{email}' WHERE id=#{id}")
    else
      #insert data into contacts table
      res = self.class.connect.exec_params("INSERT INTO contacts(name, email) VALUES ('#{name}', '#{email}') RETURNING id;")
      self.id = res[0]['id']
    end
  end
  # def initialize(name, email)
  #   # TODO: Assign parameter values to instance variables.
  #   @name = name
  #   @email = email
  #   @phone_number = phone_number
  #   @result = []
  # end

  # Provides functionality for managing a list of Contacts in a database.
  class << self
    # Returns an Array of Contacts loaded from the database.
    def connect
      PG.connect(
        host: 'localhost',
        dbname: 'contactlist',
        user: 'development',
        password: 'development'
        )
    end
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
        
        connect.exec('SELECT * FROM contacts;') do |results|
        results.each do |contact|
        puts contact.inspect
        end
      end
    connect.close
    end
    def update(id, new_name, new_email)
       the_contact = Contact.find(id)
       the_contact.name = new_name
       the_contact.email = new_email
       the_contact.save
       
      #connect.exec("UPDATE contacts SET name='#{new_name}', email='#{new_email}' WHERE id=#{id}")
    end
    def destroy(id)
       connect.exec("DELETE FROM contacts WHERE id = #{id}")
      #connect.exec("UPDATE contacts SET name='#{new_name}', email='#{new_email}' WHERE id=#{id}")
    end

  
    def makesure_enter
      input = STDIN.gets.chomp
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create (name, email, id = nil)
       new_contact = Contact.new
       new_contact.name = name
       new_contact.email = email
       new_contact.id = id
       new_contact.save
       new_contact
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      res = connect.exec_params("SELECT * FROM contacts where id = #{id}::int;")
      contact = Contact.new
      contact.id = res[0]['id']
      contact.name = res[0]['name']
      contact.email = res[0]['email']
      puts res[0]
      contact

    end

    # Returns an array of contacts who match the given term.
    def search(term)
       connect.exec("SELECT * FROM contacts where name = '#{term}' OR email = '#{term}';")do |results|
        results.each do |contact|
        puts contact.inspect
        end
      end
        connect.close
    end

  end

end
