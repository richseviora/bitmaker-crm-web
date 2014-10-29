require 'rspec'
require_relative 'rolodex'
require_relative 'contact'


describe 'Rolodex Behaviour' do
  before :each do
    @rolodex = Rolodex.new
    contacts_to_add = [
        {first_name: 'Rich',\
         last_name: 'Seviora',\
         id: '623292',\
         email: 'richard.seviora@gmail.com',\
         notes: 'Bearded.'}\
    , {first_name: 'Matt',\
       last_name: 'Schnarr',\
       id: '000123',\
       email: 'matt@gmail.com',\
       notes: 'Skinny.'}\
    , {first_name: 'Dan',\
       last_name: 'Cunningham',\
       id: '123456',\
       email: 'dan@gmail.com',\
       notes: 'Irish.'}
    ]
    contacts_to_add.each do |contact_to_add|
      new_contact = Contact.new(contact_to_add[:first_name],contact_to_add[:last_name], contact_to_add[:id], contact_to_add[:email], contact_to_add[:notes])
      @rolodex.add_contact new_contact
    end
  end

  context 'Adding/Removing Objects' do
    it 'Should have the correct contacts count once added' do
      expect(@rolodex.contacts.count).to eq(3)
    end

    it 'Should Delete Objects Properly' do
      contact_to_delete = @rolodex.contacts[-1]
      @rolodex.delete_contact(contact_to_delete)
      expect(@rolodex.contacts.count).to eq(2)
    end

  end

  context 'Searching' do
    it 'Should Return a Result' do
    expect(@rolodex.search_for_contact('Rich').is_a?(Contact)).to eq TRUE
    end

    it 'Should Not Return a Result' do
      expect(@rolodex.search_for_contact('Ximena').is_a?(Contact)).to eq FALSE
    end
  end

end
