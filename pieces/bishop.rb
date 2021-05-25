require_relative 'piece.rb'
#require_relative 'slideable.rb'

class Bishop < Piece
    include Slideable
    

    def symbol
        '♝'#"B"
    end

    private

    def move_dirs
        DIAGONAL_DIRS.dup
    end
end