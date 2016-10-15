class Node

  attr_reader :letter,
              :links,
              :terminator

  def initialize(letter = "")
    @letter = letter
    @links = Hash.new
    @terminator = false
  end

  def insert_link(letter)
    @links[letter] = Node.new(letter)
  end

  def link_to(letter)
    @links[letter]
  end

  def includes_link?(letter)
    @links.keys.include?(letter)
  end

  def make_terminator
    @terminator = true
  end

  def remove_terminator
    @terminator = false
  end

  def disappear
    @letter = nil
    @links = {}
  end

  def delete_key(letter)
    @links.delete(letter)
  end

end