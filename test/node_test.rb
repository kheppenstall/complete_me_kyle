require_relative '../lib/node'
require "minitest/autorun"
require "minitest/pride"

class NodeTest < Minitest::Test

  def test_it_exists
    assert Node.new('a')
  end

  def test_it_knows_its_letter
    node = Node.new('a')
    assert_equal 'a', node.letter
  end

  def test_it_inserts_links
    node = Node.new('a')
    node.insert_link('b')
    assert_equal ['b'], node.links.keys
  end

  def test_it_inserts_multiple_links
    node = Node.new('a')
    node.insert_link('b')
    node.insert_link('c')
    assert_equal ['b','c'], node.links.keys
  end

  def test_it_links_to_a_node_given_a_letter
    node = Node.new('a')
    node.insert_link('b')
    assert_equal 'b', node.link_to('b').letter
  end

  def test_it_knows_its_one_link
    node = Node.new('a')
    node.insert_link('b')
    assert_equal true, node.includes_link?('b')
  end

  def test_it_inserts_multiple_links
    node = Node.new('a')
    node.insert_link('b')
    node.insert_link('c')
    assert_equal true, node.includes_link?('b')
    assert_equal true, node.includes_link?('c')
  end

  def test_by_default_it_is_not_a_terminator
    node = Node.new('a')
    assert_equal false, node.terminator
  end

  def test_make_terminator_makes_it_a_terminator
    node = Node.new('a')
    node.make_terminator
    assert_equal true, node.terminator
  end
  
end