require_relative 'slideable'
require_relative 'stepable'
require_relative 'board'
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
end

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

class Queen < Piece
    include Slideable
    

    def symbol
        '♛'#"Q"
    end

    private

    def move_dirs
        HORIZONTAL_DIRS.dup + DIAGONAL_DIRS.dup
    end
end

class Rook < Piece
    include Slideable
    

    def symbol
        '♜'#"R"
    end

    private

    def move_dirs
        HORIZONTAL_DIRS.dup
    end
end

class Pawn < Piece
    def symbol
        '♟'#"x"
    end

    def moves 
        possible_moves = []
        possible_moves += side_attacks
        possible_moves += forward_steps
    end

    private

    def at_start_row?
        @color == :black && @pos.first == 6 || 
        @color == :white && @pos.first == 1
    end

    def forward_dir
        @color == :white ? 1 : -1
    end

    def side_attacks
        row,col = @pos
        x = forward_dir
        attacks = [[row + x,col + 1],[row + x,col - 1]]
        attacks.select {|r,c| r.between?(0,7) && c.between?(0,7) && !@board[[r,c]].empty? && @board[[r,c]].color != @color}
    end

    def forward_steps
        row,col = @pos
        steps = []
        x = forward_dir
        step1 = row + x
        step2 = row + 2*x
        if step1.between?(0,7) && @board[[step1,col]].empty?
            steps << [step1,col] 
            steps << [step2,col] if at_start_row? && step2.between?(0,7) && @board[[step2,col]].empty?
        end
        steps
    end
            
end

class King < Piece
    include Stepable
    def symbol
        '♚'#"K"
    end

    protected

    def move_diffs
        [[1,-1],[1,0],[1,1],
         [0,-1],       [0,1],
         [-1,-1],[-1,0],[-1,1]]
    end
end

class Knight < Piece
    include Stepable
    def symbol
        '♞'#"N"
    end

    protected 

    def move_diffs
        [[2,-1],[2,1],
         [1,-2],[1,2],
         [-1,-2],[-1,2],
         [-2,-1],[-2,1]]
    end
end

class NullPiece < Piece
    include Singleton
    def self.instance
        @@instance ||=new
    end

    def initialize
        @color = nil
    end

    def symbol
        " "
    end
end