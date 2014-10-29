class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = []
    @current_pkid = 1
  end

  def add_contact(contact_to_add)
    contact_to_add.pkid = @current_pkid
    @current_pkid       += 1
    @contacts << contact_to_add
  end

  def search_by_id(id)
    pkid = id.to_i
    results = @contacts.select { |contact| contact.pkid == pkid}
    results.first
  end

  def search_for_contact(search_text)
    raise "Invalid Argument" unless search_text.is_a?(String)
    results = @contacts.select { |contact_to_match| contact_to_match.match?(search_text) }
    results.first
  end

  def delete_contact(contact_to_delete)
    @contacts.delete(contact_to_delete)
  end

end
