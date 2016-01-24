require 'pry'
require 'pg'
require 'active_record'
require_relative 'contact_list'
require_relative 'contact'


# ActiveRecord::Base.establish_connection(
#   adapter: :postgresql,
#   database: 'contactlist'
#   )

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contactlist',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
list = ContactList.new
list.Interact_with_user
