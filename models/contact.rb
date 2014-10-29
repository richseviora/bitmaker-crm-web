class Contact
  attr_accessor :first_name, :last_name, :id, :email, :notes, :pkid

  def initialize(first_name, last_name, id, email, notes)
    @first_name = first_name
    @last_name = last_name
    @id = id
    @email = email
    @notes = notes
    @pkid = 0
  end

  def describe
    "#{@id}: #{@first_name} #{@last_name}\nEmail: #{@email}\nNotes: #{@notes}"
  end

  def match?(string_to_match)
    raise "Invalid Item" unless string_to_match.is_a?(String)
    case
      when string_to_match == @first_name
        return TRUE
      when string_to_match == @last_name
        return TRUE
      when string_to_match == @id
        return TRUE
      when string_to_match == @email
        return TRUE
      when string_to_match == @notes
        return TRUE
      else
        return FALSE
    end
  end

end