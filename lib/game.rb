class Game
    WIN_COMBINATIONS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[6,4,2]]

    attr_accessor :board, :player_1, :player_2, :winning_combo

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board=Board.new)
        self.player_1 = player_1
        self.player_2 = player_2
        self.board = board
        self.winning_combo = nil
    end

    def current_player 
        self.board.turn_count.even? ? self.player_1 : self.player_2
    end 

    def won? 
        WIN_COMBINATIONS.each do |combo|
            
            if ["X", "X", "X"] == combo.map {|c| self.board.cells[c]}
                self.winning_combo = combo
            elsif ["O", "O", "O"] == combo.map {|c| self.board.cells[c]}
                self.winning_combo = combo 
            end 
        end 
        self.winning_combo
    end

    def draw?
        !won?
    end

    def over?
        won? || self.board.full?
    end

    def winner
        self.won?
        self.board.cells[self.winning_combo[0]] unless self.winning_combo == nil
    end

    def turn
        input = self.current_player.move(self.board).to_i
        if self.board.valid_move?(input) 
            self.board.cells[input-1] = self.current_player.token
        else self.turn
        end
    end

    def play 
      until self.over? 
        turn
      end
      if won?
        winner
      else
        draw?
      end
    end
  end
      
      
      
      
      
      
      
      
      
      
