require_relative 'piece.rb'
require 'byebug.rb'

class Board
    def initialize 
        @grid = Array.new(8) {Array.new(8)}
        (0..1).each do |idx|
            @grid[idx].map!.with_index {|ele,idx_2| Piece.new([idx,idx_2])}
        end
        (6..7).each do |idx|
            @grid[idx].map!.with_index {|ele,idx_2| Piece.new([idx,idx_2])}
        end
    end

     def [](pos)
        x,y = pos
        @grid[x][y].dup
    end

    def []=(pos,piece)
        x,y = pos
        @grid[x][y] = piece
    end

    def move_piece(start_pos,end_pos)
        row1,col1 = start_pos
        raise StandardError.new("There is no piece at #{row1},#{col1}") if @grid[row1][col1].nil?
        row2,col2 = end_pos
        raise StandardError.new("The piece cannot move to #{row2},#{col2}") unless row2.between?(0,7) && col2.between?(0,7) && @grid[row2][col2].nil?
        @grid[row2][col2],@grid[row1][col1] = @grid[row1][col1],nil
    end

   
end