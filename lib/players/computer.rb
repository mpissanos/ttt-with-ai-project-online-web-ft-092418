require_relative '../player.rb'

class Players::Computer < Player
    
    attr_reader :token, :enemy_token
    attr_accessor :win_combos, :trap_combos


    
    def initialize(token)
        @token = token
        self.token == "X" ? @enemy_token = "O" : @enemy_token = "X"
        self.win_combos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

        self.trap_combos = [["O", "X", " ", " ", "X", " ", " ", "O", " "]]
    end

    #WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]
    
    def move(board)
        
        self.win_combos.delete_if { |combo|
            !combo.map{|pos| board.cells[pos]}.include?(" ")
        }

        my_move = nil
        #step 1
            #check our positions, see if we have any 2 of a winning combo
        my_move = self.check_wins_and_move(self.token, my_move, board)
        
        #step 2
            #check if opponent needs to be blocked from winning
        if my_move == nil 
            my_move = self.check_wins_and_move(enemy_token, my_move, board)
        end        

        if my_move == nil 
            # play any avail move STUPID WAY
            return "5" if board.valid_move?(5)
            if self.trap_combos.include?(board.cells)
                return "7"
            end
            for i in 0..8
                return i.to_s if board.valid_move?(i)
            end
        end

        my_move.to_s
    end

    def check_wins_and_move(temp_token, my_move, board)
        win_combos.each do |combo|
            arr = combo.map{|pos| board.cells[pos]}
            if arr.count(temp_token) == 2 
                my_move = combo.find {|i| board.valid_move?(i+1)}
            end            
        end
        (my_move + 1).to_s if my_move
    end
end


# 1. check if we can win
# 2. check to see which winning combos the other player has 2 pieces of
# 3. if found, play in the 3rd spot
######## ((((((((((5. otherwise play a second in line off mine in a place where there's still the 3rd option open))))))
# 6. if we have one down && the other two of that combo are open THEN play in one of thse other spots, prioritizing corners
# 7. else choose a corner
# 8. find open spot 

