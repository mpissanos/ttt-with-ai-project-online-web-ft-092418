class Board
    attr_accessor :cells
    
    def initialize
        self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display
        puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} \n-----------\n #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} \n-----------\n #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
    end

    def position(input)
        self.cells[input.to_i - 1]
    end

    def update(input, player)
        self.cells[input.to_i - 1] = player.token
    end

    def full?
        !self.cells.include?(" ")
    end

    def turn_count
        self.cells.find_all {|cell| cell != " "}.size
    end

    def taken?(input)
        position(input) == "X" || position(input) == "O"
    end

    def valid_move?(input)        
        !taken?(input) && input.to_i > 0 && input.to_i < 10
    end

    def reset!
        self.cells = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end
end