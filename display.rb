require_relative 'board.rb'
require_relative 'cursor.rb'


class Display 
    LIGHT_BLUE = "   ".colorize(:background => :light_blue)
    BLUE= "   ".colorize(:background => :blue)
    LIGHT_BLACK = "   ".colorize(:background => :light_black)
    BLACK = "   ".colorize(:background => :black)
    #attempting to reduce calls to to_s and to colorize
    EMPTY_TILE_COLORS = {:blue => BLUE,:black => BLACK,:light_black => LIGHT_BLACK, :light_blue => LIGHT_BLUE}

    attr_reader :cursor,:board
    def initialize(board = Board.set_board)
        @board = board
        @cursor = Cursor.new([0,0],@board)
    end



    def render
        letters = "    a  b  c  d  e  f  g  h ".colorize(:color => :light_black)
        print_board = [letters]
        7.downto(0) do |idx|
            print_row = []
            tile_color = idx % 2 == 0 ? :black: :light_black
            number = " #{idx + 1} ".colorize(:color => :light_black)
            print_row << number
            @board.grid[idx].each.with_index do |ele,idx_2|
                if  [idx,idx_2] == @cursor.cursor_pos && [idx,idx_2] == @cursor.selected
                    tile_color = tile_color == :black ? :cyan : :light_cyan 
                elsif [idx,idx_2] == @cursor.selected
                    tile_color = tile_color == :black ? :red : :light_red 
                elsif [idx,idx_2] == @cursor.cursor_pos
                    tile_color = tile_color == :black ? :blue : :light_blue
                end
                if @board.empty?([idx,idx_2])
                    print_ele = EMPTY_TILE_COLORS[tile_color] #attempt at reducing calls to colorize and to to_s
                else
                    print_ele = (' ' + ele.to_s + ' ').colorize( :background => tile_color)
                end
                print_row <<  print_ele
                tile_color = tile_color == :black || tile_color == :blue || tile_color == :red || tile_color == :cyan ? :light_black : :black
            end
            print_row << number
            print_board << print_row.join('')                                 
        end 
        system('clear')
        print_board << letters
        puts print_board 
        nil
    end
 
end