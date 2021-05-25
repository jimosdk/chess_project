require_relative 'piece.rb'

class Pawn < Piece
    def symbol
        '♟'#"x"
    end

    def moves 
        possible_moves = []
        possible_moves += side_attacks
        possible_moves += forward_steps
    end

    private

    def at_start_row?
        @color == :black && @pos.first == 6 || 
        @color == :white && @pos.first == 1
    end

    def forward_dir
        @color == :white ? 1 : -1
    end

    def side_attacks
        row,col = @pos
        x = forward_dir
        attacks = [[row + x,col + 1],[row + x,col - 1]]
        attacks.select {|r,c| r.between?(0,7) && c.between?(0,7) && !@board[[r,c]].empty? && @board[[r,c]].color != @color}
    end

    def forward_steps
        row,col = @pos
        steps = []
        x = forward_dir
        step1 = row + x
        step2 = row + 2*x
        if step1.between?(0,7) && @board[[step1,col]].empty?
            steps << [step1,col] 
            steps << [step2,col] if at_start_row? && step2.between?(0,7) && @board[[step2,col]].empty?
        end
        steps
    end
            
end