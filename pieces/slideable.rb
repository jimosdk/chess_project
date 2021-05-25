require 'byebug'


module Slideable
    DIAGONAL_DIRS  = [[-1,-1],[-1,1],[1,-1],[1,1]]
    HORIZONTAL_DIRS = [[1,0],[-1,0],[0,1],[0,-1]]

    def moves
        possible_moves = move_dirs

        moves = possible_moves.map {|dx,dy| grow_unblocked_moves_in_dir(dx,dy)}.flatten(1)
    end

    private
    
    def move_dirs
    end

    def grow_unblocked_moves_in_dir(dx,dy)
        row,col = @pos
        row += dx
        col += dy
        moves = []
        while  row.between?(0,7) && col.between?(0,7) && @board[[row,col]].empty?
            moves << [row,col]
            row += dx
            col += dy
        end
        moves << [row,col] if row.between?(0,7) && col.between?(0,7) && !@board[[row,col]].empty? && @board[[row,col]].color != @color
        moves
    end
end