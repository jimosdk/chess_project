require 'byebug'


module Slideable
    DIAGONAL_DIRS  = [[-1,-1],[-1,1],[1,-1],[1,1]]
    HORIZONTAL_DIRS = [[1,0],[-1,0],[0,1],[0,-1]]

    def moves
        possible_moves = move_dirs

        moves = possible_moves.map {|dx,dy| grow_unblocked_moves_in_dir(dx,dy)}.flatten(1)
    end

    def move_dirs
    end

    def grow_unblocked_moves_in_dir(dx,dy)
        row,col = @pos
        row += dx
        col += dy
        moves = []
        while  row.between?(0,7) && col.between?(0,7) && @board[[row,col]].is_a?(NullPiece)
            moves << [row,col]
            row += dx
            col += dy
        end
        moves
    end
end