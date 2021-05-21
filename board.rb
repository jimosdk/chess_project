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

   












#USED FOR DEBUGGING!
    def render
        system('clear')
        puts "  a b c d e f g h ".colorize(:color => :light_green)
        puts " -----------------"
        @grid.reverse.each_with_index do |row,idx|
            print "#{8 - idx}".colorize(:color => :light_cyan)
            print "|"
            print row.map(&:to_s).join('|')
            print "|"
            print "#{8 - idx}".colorize(:color => :light_cyan)
            puts "\n -----------------\n"
        end
        puts "  a b c d e f g h ".colorize(:color => :light_green)
        nil
    end
end