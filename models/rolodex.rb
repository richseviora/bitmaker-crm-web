class Rolodex
  attr_reader :contacts

  def initialize
    @contacts = []
  end

  def add_contact(contact_to_add)
    @contacts << contact_to_add
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
