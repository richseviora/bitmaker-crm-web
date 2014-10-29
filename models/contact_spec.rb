require 'rspec'
require_relative 'contact'

describe 'Contacts' do
  last_name = 'Seviora'
  first_name = 'Rich'
  id = '623292'
  email = 'richard.seviora@gmail.com'
  notes = 'Bearded.'

  before :each do
    @contact = Contact.new(first_name, last_name, id, email, notes)
  end
  context 'Creating an Object' do
    it 'Should Create a Contact' do
      expect(@contact).to be_an_instance_of(Contact)
    end

    it 'Should have the correct first name' do
      expect(@contact.first_name).to eq first_name
    end

    it 'Should have the correct last name' do
      expect(@contact.last_name).to eq last_name
    end
    it 'Should have the correct ID' do
      expect(@contact.id).to eq id
    end

    it 'Should have the correct email' do
      expect(@contact.email).to eq email
    end

    it 'Should have the correct notes' do
      expect(@contact.notes).to eq notes
    end

    it 'Should contain all variables in the description.' do
      expect(@contact.describe.include?(last_name)).to eq true
      expect(@contact.describe.include?(first_name)).to eq true
      expect(@contact.describe.include?(id)).to eq true
      expect(@contact.describe.include?(email)).to eq true
      expect(@contact.describe.include?(notes)).to eq true
    end
  end

  context 'Matching' do
    it 'Should fail to match correctly' do
      expect(@contact.match?('John')).to eq FALSE
    end

    it 'Should match on first name' do
      expect(@contact.match?('Rich')).to eq TRUE
    end

    it 'Should match on last name' do
      expect(@contact.match?('Seviora')).to eq TRUE
    end

    it 'Should match on ID' do
      expect(@contact.match?('623292')).to eq TRUE
    end

    it 'Should match on email' do
      expect(@contact.match?('richard.seviora@gmail.com')).to eq TRUE
    end

    it 'Should match on notes' do
      expect(@contact.match?('Bearded.')).to eq TRUE
    end
  end


end