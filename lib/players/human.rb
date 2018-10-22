require_relative '../player.rb'


class Players::Human < Player

    def move(board)
        puts "   please enter the index where you'd like to play: "
        gets.chomp
    end

end