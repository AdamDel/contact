require 'csv'
require 'securerandom'
require 'date'

# Represents a person in an address book.
class Contact

  attr_accessor :name, :email

  def initialize(name, email)
    # TODO: Assign parameter values to instance variables.
    @name = name
    @email = email
  end

  # Provides functionality for managing a list of Contacts in a database.
  class << self

    # Returns an Array of Contacts loaded from the database.
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      CSV.foreach("contacts.csv") do |row|
         puts row.inspect
      end
    end

    # Creates a new contact, adding it to the database, returning the new contact.
    def create (name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      @contact_id = SecureRandom.uuid + Time.now.getutc.inspect # Create a unique ID 
      csv_array = [name, email, @contact_id]
      CSV.open("contacts.csv", "a") { |csv_object| csv_object << csv_array}
    end

    # Returns the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      @found = false
      CSV.foreach("contacts.csv") do |row|
        
        if row.include?(id)
          puts row.inspect
          @found = true
        end 
      end
      puts "Contact does not exist" if !@found
    end

    # Returns an array of contacts who match the given term.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      @found = false
      CSV.foreach("contacts.csv") do |row|
        
        if row.include?(term)
          puts row.inspect
          @found = true
        end
      end
     puts "Contact does not exist" if !@found 
    end

  end

end
