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
    @title = "Main Menu"
    erb :index
  end

  get '/contacts' do
    raise 'No Rolodex!' if $rolodex.nil?
    @title = "All Contacts"
    erb :contact_list

  end


  get '/contacts/new' do
    @title = "New Contact"
    erb :new_contact
  end

  post '/contacts/new' do
    puts "PARAMS #{params}"
    contact = Contact.new(params[:first_name], params[:last_name], params[:id], params[:email_address], params[:notes])
    $rolodex.add_contact(contact)
    redirect to('/contacts')
  end

  get '/contacts/:id' do
    contact = $rolodex.search_by_id(params[:id])
    if contact
      @title = "#{contact.first_name} #{contact.last_name}"
      erb :contact_page, locals: {contact: contact}
    else
      redirect to('/contacts')
    end
  end

  get '/contacts/:pkid/edit' do
    contact = $rolodex.search_by_id(params[:pkid])
    if contact
      @title = "Edit #{contact.first_name} #{contact.last_name}"
      erb :edit_page, locals: {contact: contact}
    else
      redirect to('/contacts')
    end
  end

  post '/contacts/:pkid/update' do
    contact = $rolodex.search_by_id(params[:pkid])
    if contact
      contact.first_name = params[:first_name]
      contact.last_name = params[:last_name]
      contact.email = params[:email]
      contact.notes = params[:notes]
      contact.id = params[:id]
    end
    redirect to('/contacts')
  end

  get '/contacts/:pkid/delete' do
    contact = $rolodex.search_by_id(params[:pkid])
    if contact
      $rolodex.delete_contact(contact)
      redirect to('/contacts')
    else
      redirect to('/contacts')
    end
  end



  run! if app_file = $0
end