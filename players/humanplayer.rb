require_relative 'player.rb'

class HumanPlayer < Player

    def make_move(board)
        move = []
        loop do
            @display.render
            puts "#{@color}'s turn"
            input = @display.cursor.get_input(@color)
            move << input unless input.nil?
            if move.length == 2
                begin
                    board.move_piece(move.first,move.last)
                    break
                rescue => e  
                puts e.message
                sleep(1.5)
                ensure
                    move = []
                end
            end 
        end
    end
end