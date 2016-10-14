require_relative '../lib/node'

class CompleteMe

  attr_reader :count,
              :root_node

  def initialize
    @count = 0
    @root_node = Node.new
  end

  def insert(word, node = @root_node)
    length = word.length
    characters = word.chars
    letter = characters.delete_at(0)

    node.insert_link(letter) unless node.includes_link?(letter)

    if length == 1
      @count += 1
      node.link_to(letter).make_terminator
    else
      insert(characters.join, node.link_to(letter))
    end
  end
  
  def find_suggestions(node)
    suggestions = []
    if node != nil
      node_links = node.links.keys 

      node_links.each do |letter|
        suggestions << letter if node.link_to(letter).terminator
          
        find_suggestions(node.link_to(letter)).each do |element|
            suggestions << letter + element
        end
      end
    end
    suggestions
  end

  def suggest(fragment)
    node = node_finder(fragment)
    second_halves = find_suggestions(node)
    
    suggestions = second_halves.map do |half|
      fragment + half
    end

    suggestions 
  end

  def node_finder(fragment, node = @root_node)
    if node.includes_link?(fragment[0])
      length = fragment.length
      characters = fragment.chars
      letter = characters.delete_at(0)

      if length == 1
        node.link_to(letter)
      else
        node_finder(characters.join, node.link_to(letter))
      end
    end
  end

  def populate(file)
    words = File.readlines(file)
    words.each {|word| insert(word.gsub(/\n/, ""))}
  end

  



end
