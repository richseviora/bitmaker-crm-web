require 'sinatra/base'
require_relative 'models/contact'
require_relative 'models/rolodex'



class CRMWeb < Sinatra::Base
  configure do
    $rolodex = Rolodex.new
    contact1 = Contact.new('Rich', 'Seviora', '623292', 'richard.seviora@gmail.com', 'Beard!')
    contact2 = Contact.new('The', 'Dude', '000000', 'the@dude.com', 'Dude')
    contact3 = Contact.new('Another Dude', 'Bob', '111111', 'meow@meow.com', 'Meow!')
    $rolodex.add_contact(contact1)
    $rolodex.add_contact(contact3)
    $rolodex.add_contact(contact2)
  end




  get '/' do
    erb :index
  end

  get '/contacts' do
    raise 'No Rolodex!' if $rolodex.nil?
    erb :contact_list
  end

  get '/contacts/new' do
    erb :new_contact
  end

  post '/contacts/new' do
    puts "PARAMS #{params}"
    contact = Contact.new(params[:first_name],params[:last_name],params[:id],params[:email_address],params[:notes])
    $rolodex.add_contact(contact)
  end

  get '/:name' do
    # All name parameters are submitted as items in the params hash.
    @name = params[:name]
    # Calling ERB with the symbol name will pass instance variables (@variableName) to the template.
    erb :people
  end


  run! if app_file = $0
end