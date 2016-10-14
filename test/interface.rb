require_relative '../lib/node'
require_relative '../lib/complete_me.rb'

puts "Type a fragment"
completion = CompleteMe.new
completion.populate('./test/words.txt')
fragment = gets
suggestion = completion.suggest(fragment.chomp)

puts "Here are some suggestions:"
puts suggestion