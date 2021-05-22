module Stepable
    
    def moves
        possible_moves = move_diffs
        row,col = @pos
        possible_moves.map! {|dx,dy| [row + dx,col + dy]}
        moves = possible_moves.select do |row,col| 
            row.between?(0,7) && col.between?(0,7) && 
            (@board[[row,col]].is_a?(NullPiece) || 
            !@board[[row,col]].is_a?(NullPiece) && @color != @board[[row,col]].color)
        end
        moves
    end

    def move_diffs
    end
end