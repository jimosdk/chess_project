require_relative 'piece.rb'
# require_relative 'slideable.rb'

class Queen < Piece
    include Slideable
    

    def symbol
        '♛'#"Q"
    end

    private

    def move_dirs
        HORIZONTAL_DIRS.dup + DIAGONAL_DIRS.dup
    end
end