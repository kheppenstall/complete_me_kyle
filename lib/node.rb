class Node

  attr_reader :letter,
              :links,
              :terminator

  def initialize(letter = 'root')
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

end