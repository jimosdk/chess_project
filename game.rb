require_relative 'display.rb'
require_relative 'player.rb'

class Game
    attr_reader :board,:display,:players,:current_player
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
        
        until @board.checkmate?(@current_player.color) 
            @current_player.make_move(@board) 
            @current_player = @players.rotate!.first
        end
        display.render 
    end
end