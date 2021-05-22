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
        puts "   a  b  c  d  e  f  g  h ".colorize(:color => :light_black)
        @grid.reverse.each_with_index do |row,idx|
            print "#{8 - idx} ".colorize(:color => :light_black)
            print_row = row.map.with_index do |ele,idx_2|
                print_ele = ' ' + ele.to_s + ' '
                if (idx % 2 == 0 || idx == 0) && (idx_2 % 2 == 0 || idx_2 == 0) || idx % 2 != 0 && idx_2 % 2 != 0
                    print_ele.colorize( :background => :light_black)  
                else
                    print_ele.colorize(:background => :black) 
                end
            end.join('')
            print print_row
            puts " #{8 - idx}".colorize(:color => :light_black)                                   
        end
        puts "   a  b  c  d  e  f  g  h ".colorize(:color => :light_black)
        nil
    end
end