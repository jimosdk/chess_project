require_relative 'display.rb'
require_relative 'player.rb'

class Game
    attr_accessor :board,:display,:players,:current_player
    def initialize(players = [false ,false])
        @board = Board.set_board
        @display = Display.new(@board)
        colors = [:black,:white]
        @players = players.map do |ai|
            color = colors.rotate!.first
            ai ? ComputerPlayer.new(color,@display) : HumanPlayer.new(color,@display)
            
        end
        @current_player = @players.first
    end

    def play
        until @board.checkmate?(@current_player.color) || @board.draw?(@current_player.color) 
            @current_player.make_move(@board) 
            @current_player = @players.rotate!.first
        end
        display.render 
        if @board.checkmate?(@current_player.color)
            puts "Game over #{@players.rotate!.first.color} wins!"
        elsif @board.draw?(@current_player.color)
            puts "Draw"
        end 
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end