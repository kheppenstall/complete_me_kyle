require_relative '../lib/node'
require_relative '../lib/complete_me.rb'
require "minitest/autorun"
require "minitest/pride"

class CompleteMeTest < Minitest::Test

  def test_it_exists
    assert CompleteMe.new
  end

  def test_complete_mes_initialize_with_a_root_node
    completion = CompleteMe.new
    assert_equal "root", completion.root_node.letter
  end

  def test_it_inserts_the_word_pizza
    completion = CompleteMe.new
    completion.insert('pizza')
    result = completion.root_node.includes_link?('p')
    assert_equal true, result
  end

  def test_it_keeps_track_of_words_inserted
    completion = CompleteMe.new
    completion.insert('pizza')
    assert_equal 1, completion.count
  end

  def test_it_inserts_multiple_words
    completion = CompleteMe.new
    completion.insert('pizza')
    completion.insert('hello')
    completion.insert('world')
    assert_equal 3, completion.count
  end

  def test_find_suggestions_finds_nt_nd_t_from_ant_and_at
    completion = CompleteMe.new
    completion.insert('ant')
    completion.insert('and')
    completion.insert('at')
    node_at_a = completion.root_node.link_to('a')
    suggestions = completion.find_suggestions(node_at_a)

    assert_equal ['nt', 'nd', 't'], suggestions
  end

  def test_find_suggestions_finds_izza_zaz_and_izzeria_from_piz
    completion = CompleteMe.new
    completion.insert('pizza')
    completion.insert('pizzeria')
    completion.insert('pizzaz')
    node_at_z = completion.root_node.link_to('p').link_to('i').link_to('z')
    suggestions = completion.find_suggestions(node_at_z)
    assert_equal ['za','zaz', 'zeria'], suggestions
  end

  def test_find_node_z_given_fragment_piz
    completion = CompleteMe.new
    completion.insert('pizza')
    result = completion.node_finder('piz').letter
    assert_equal 'z', result
  end

  def test_it_suggests_an_from_a
    completion = CompleteMe.new
    completion.insert('an')
    suggestion = completion.suggest('a')
    assert_equal ['an'], suggestion
  end

  def test_it_suggests_at_and_an_from_a
    completion = CompleteMe.new
    completion.insert('an')
    completion.insert('at')
    suggestion = completion.suggest('a')
    assert_equal ['an', 'at'], suggestion
  end

  def test_it_suggests_ant_from_an
    completion = CompleteMe.new
    completion.insert('ant')
    suggestion = completion.suggest('an')
    assert_equal ['ant'], suggestion
  end

  def test_it_suggests_pizzeria_and_pizza_from_piz
    completion = CompleteMe.new
    completion.insert('pizza')
    completion.insert('pizzeria')
    suggestion = completion.suggest('piz')
    assert_equal ['pizza', 'pizzeria'], suggestion
  end

  def test_it_suggests_pizzeria_pizza_pizzaz_from_piz
    completion = CompleteMe.new
    completion.insert('pizza')
    completion.insert('pizzeria')
    completion.insert('pizzaz')
    suggestion = completion.suggest('piz')
    assert_equal ['pizza', 'pizzaz','pizzeria'], suggestion
  end

  def test_it_populates_an_input_file
    completion = CompleteMe.new
    completion.populate('./test/simple_words.txt')
    assert completion.count > 5
  end

  def test_it_populates_an_input_file_and_makes_suggestions
    completion = CompleteMe.new
    completion.populate('./test/simple_words.txt')
    suggestion = completion.suggest('he')
    assert_equal ['hell','hello'] , suggestion
  end

  def test_it_populates_and_doesnt_suggest_its_fragment
    completion = CompleteMe.new
    completion.populate('./test/simple_words.txt')
    suggestion = completion.suggest('mass')
    assert_equal ['massive','massif'] , suggestion
  end

  def test_it_populates_huge_file
    completion = CompleteMe.new
    completion.populate('./test/words.txt')
    assert_equal 235886, completion.count
  end

  def test_it_populates_huge_number_of_words_and_makes_suggestions
    completion = CompleteMe.new
    completion.populate('./test/words.txt')
    suggestion = completion.suggest('aar')
    assert_equal ["aardvark", "aardwolf"], suggestion
  end

  def test_it_suggests_nothing_when_no_words_are_there
    completion = CompleteMe.new
    suggestion = completion.suggest('a')
    assert_equal [], suggestion
  end

  def test_it_suggests_nothing_given_crazy_fragment
    completion = CompleteMe.new
    completion.populate('./test/simple_words.txt')
    suggestion = completion.suggest('zzzzzzzz')
    assert_equal [], suggestion
  end

end