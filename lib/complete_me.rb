require_relative '../lib/node'

class CompleteMe

  attr_reader :count,
              :root_node

  def initialize
    @count = 0
    @root_node = Node.new
  end

  def add_other_letters(length, letter, characters, node)
    if length == 1
      @count += 1
      node.link_to(letter).make_terminator
    else
      insert(characters.join, node.link_to(letter))
    end
  end

  def insert(word, node = @root_node)
    length = word.length
    characters = word.chars
    letter = characters.delete_at(0)
    node.insert_link(letter) unless node.includes_link?(letter)
    add_other_letters(length, letter, characters, node)
  end
  
  def populate_suggestions(letter, node, suggestions)
    next_node = node.link_to(letter)
    suggestions << letter if next_node.terminator
    find_suggestions(next_node).each {|element| suggestions << letter + element}
  end
  
  def find_suggestions(node)
    suggestions = []
    node_links = node.links.keys 
    node_links.each {|letter| populate_suggestions(letter, node, suggestions)}
    suggestions
  end

  def suggest(fragment)
    node = node_finder(fragment)
    if node!= nil
      second_halves = find_suggestions(node)
      suggestions = second_halves.map {|half| fragment + half}
    end
  end

  def search(length, letter, characters, node)
    if length == 1
      node.link_to(letter)
    else
      node_finder(characters.join, node.link_to(letter))
    end
  end

  def node_finder(fragment, node = @root_node)
    length = fragment.length
    characters = fragment.chars
    letter = characters.delete_at(0)
    search(length, letter, characters, node) if node.includes_link?(fragment[0])
  end

  def populate(file)
    words = File.readlines(file)
    words.each {|word| insert(word.gsub(/\n/, ""))}
  end

end
