require 'sinatra/base'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
  include DataMapper::Resource
  property :pkid, Serial
  property :first_name, String
  property :last_name, String
  property :email, String
  property :notes, String
  property :id, String

end

DataMapper.finalize
DataMapper.auto_upgrade!

class CRMWeb < Sinatra::Base
  configure do


  end


  get '/' do
    @title = "Main Menu"
    erb :index
  end

  get '/contacts' do
    @title = "All Contacts"
    @contacts = Contact.all
    erb :contact_list

  end


  get '/contacts/new' do
    @title = "New Contact"
    erb :new_contact
  end

  post '/contacts/new' do
    puts "PARAMS #{params}"
    contact = Contact.create(
        first_name: params[:first_name],
        last_name: params[:last_name],
        id: params[:ID],
        email: params[:email_address],
        notes: params[:notes])
    redirect to('/contacts')
  end

  get '/contacts/:pkid' do
    contact = Contact.get(params[:pkid].to_i)
    if contact
      @title = "#{contact.first_name} #{contact.last_name}"
      erb :contact_page, locals: {contact: contact}
    else
      redirect to('/contacts')
    end
  end

  get '/contacts/:pkid/edit' do
    contact = Contact.get(params[:pkid].to_i)
    if contact
      @title = "Edit #{contact.first_name} #{contact.last_name}"
      erb :edit_page, locals: {contact: contact}
    else
      redirect to('/contacts')
    end
  end

  post '/contacts/:pkid/update' do
    contact = Contact.get(params[:pkid].to_i)
    if contact
      contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], notes: params[:notes], id: params[:id])
    end
    redirect to('/contacts')
  end

  get '/contacts/:pkid/delete' do
    contact = Contact.get(params[:pkid].to_i)
    if contact
      contact.destroy
      redirect to('/contacts')
    else
      redirect to('/contacts')
    end
  end



  run! if app_file = $0
end