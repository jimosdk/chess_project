require_relative 'slideable'
require_relative 'stepable'
require_relative '../board'
require 'singleton.rb'
require 'colorize.rb'
class Piece
    attr_reader :color
    attr_accessor :pos,:board

    def self.initial_position(pos,board)
        case pos
        when [1,0],[1,1],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7]
            Pawn.new(:white,pos,board)
        when [6,0],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6],[6,7]
            Pawn.new(:black,pos,board)
        when [0,1],[0,6]
            Knight.new(:white,pos,board)
        when [7,1],[7,6]
            Knight.new(:black,pos,board)
        when [0,2],[0,5]
            Bishop.new(:white,pos,board)
        when [7,2],[7,5]
            Bishop.new(:black,pos,board)
        when [0,0],[0,7]
            Rook.new(:white,pos,board)
        when [7,0],[7,7]
            Rook.new(:black,pos,board)
        when [0,3]
            Queen.new(:white,pos,board)
        when [7,3]
            Queen.new(:black,pos,board)
        when [0,4]
            King.new(:white,pos,board)
        when [7,4]
            King.new(:black,pos,board)
        else
            NullPiece.instance
        end
    end

    def initialize(color,pos,board)
        @pos = pos
        @board = board
        @color = color
    end

    def to_s
        if @color == :white
            symbol.colorize(:color => :green)
        elsif @color == :black
            symbol.colorize(:color => :light_magenta)
        else
            symbol
        end
    end

    def pos=(pos)
        @pos = pos
    end

    def empty?
        self.is_a?(NullPiece)
    end



    def valid_moves
        moves.reject {|move| moves_into_check?(move)}
    end

    def moves_into_check?(end_pos)
        board_dup = @board.dup
        board_dup.move_piece!(@pos,end_pos)
        board_dup.in_check?(@color)
    end
end













