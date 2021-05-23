require_relative 'piece.rb'
require 'byebug.rb'
require 'colorize.rb'

class Board
    attr_accessor :grid
    def initialize 
        @grid = Array.new(8) {Array.new(8)}
        (0..7).each do |idx|
            @grid[idx].map!.with_index {|ele,idx_2| Piece.place([idx,idx_2],self)}
        end
    end

     def [](pos)
        x,y = pos
        @grid[x][y]
    end

    def []=(pos,piece)
        x,y = pos
        @grid[x][y] = piece
    end

    def valid_pos?(pos)
        row,col = pos
        row.between?(0,7) && col.between?(0,7)
    end

    def empty?(pos)
        x,y = pos
        @grid[x][y].empty?
    end

    def move_piece(start_pos,end_pos)
        row1,col1 = start_pos
        raise StandardError.new("There is no piece at #{row1},#{col1}") if @grid[row1][col1].nil? || @grid[row1][col1].is_a?(NullPiece)
        piece = @grid[row1][col1]
        moves = piece.moves
        row2,col2 = end_pos
        raise StandardError.new("Illegal move , #{piece.class.to_s} can't move to #{row2},#{col2}" ) unless moves.include?(end_pos)
        @grid[row2][col2] = NullPiece.instance unless @grid[row2][col2].is_a?(NullPiece)
        @grid[row2][col2],@grid[row1][col1] = @grid[row1][col1],@grid[row2][col2]
        piece.pos = [row2,col2]
    end

   
    def in_check?(color)  
        king_pos = find_king(color)
        color = color == :white ? :black : :white
        valid_moves(color).include?(king_pos)
    end
    def find_king(color)
        king = nil
        @grid.any? {|row| king = row.find{|piece| piece.is_a?(King) && piece.color == color}}
        king.pos
    end

    def valid_moves(color)
        debugger
        @grid.inject([]) do |acc,row|
            acc += row.inject([]) do |acc_2,tile|
                tile.empty? || tile.color != color ? acc_2 : acc_2 += tile.moves
            end
        end
    end

    def checkmate?
    end
end