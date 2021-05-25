require_relative 'piece.rb'
require 'byebug.rb'
require 'colorize.rb'

class Board
    attr_accessor :grid

    def self.set_board 
        board = Board.new 

        (0..7).each do |idx|
            board.grid[idx].map!.with_index {|ele,idx_2| Piece.initial_position([idx,idx_2],board)}
        end

        board
    end

    def initialize
        @grid = Array.new(8) {Array.new(8,NullPiece.instance)}
    end

     def [](pos)
        x,y = pos
        @grid[x][y]
    end

    def []=(pos,piece)
        x,y = pos
        @grid[x][y] = piece
    end

    def dup
        board_dup = Board.new
        board_dup.grid = self.grid.dup
        board_dup.grid.map! do |row|
            row_dup = row.dup
            row_dup.map! do |piece|
                unless piece.is_a?(NullPiece)
                    piece_dup = piece.dup
                    piece_dup.pos = piece.pos.dup
                    piece_dup.board = board_dup
                else
                    piece_dup = piece
                end
                piece_dup
            end
            row_dup
        end
        board_dup
    end

    def valid_pos?(pos)
        row,col = pos
        row.between?(0,7) && col.between?(0,7)
    end

    def empty?(pos)
        x,y = pos
        @grid[x][y].empty?
    end

    def in_check?(color)  
        king_pos = find_king(color)
        color = color == :white ? :black : :white
        all_moves_for(color).include?(king_pos)
    end
    def find_king(color)
        king = nil
        @grid.any? {|row| king = row.find{|piece| piece.is_a?(King) && piece.color == color}}
        king.pos
    end

    def all_moves_for(color)
        @grid.inject([]) do |acc,row|
            acc += row.inject([]) do |acc_2,tile|
                tile.empty? || tile.color != color ? acc_2 : acc_2 += tile.moves
            end
        end
    end


    #checking if a piece moves in check and for checkmate by dupping board
    #making move on dupped board and calling in_check?

    def move_piece(start_pos,end_pos)
        row1,col1 = start_pos
        raise StandardError.new("There is no piece at #{row1},#{col1}") if !valid_pos?(start_pos) || self[start_pos].empty? #@grid[row1][col1].nil? || @grid[row1][col1].is_a?(NullPiece)
        piece = @grid[row1][col1]
        moves = piece.valid_moves
        row2,col2 = end_pos
        raise StandardError.new("Illegal move , #{piece.class.to_s} can't move to #{row2},#{col2}" ) unless moves.include?(end_pos)
        @grid[row2][col2] = NullPiece.instance unless @grid[row2][col2].is_a?(NullPiece)
        @grid[row2][col2],@grid[row1][col1] = @grid[row1][col1],@grid[row2][col2]
        piece.pos = [row2,col2]
    end

    def move_piece!(start_pos,end_pos)
        piece = self[start_pos]
        self[end_pos] = NullPiece.instance unless self[end_pos].is_a?(NullPiece)
        self[end_pos],self[start_pos] = self[start_pos],self[end_pos]
        piece.pos = end_pos
    end

    def checkmate?(color)
        in_check?(color) && @grid.none? do |row|
            row.any? do |piece|
                !piece.empty? && piece.color == color &&
                piece.valid_moves != []
            end
        end
    end

    def draw?(color)
        !in_check?(color) && @grid.none? do |row|
            row.any? do |piece|
                !piece.empty? && piece.color == color &&
                piece.valid_moves != []
            end
        end
    end


    #ALTERNATIVE SOLUTION TO THE ONE ABOVE
    #checking for move into check and checkmate by making move on actual board
    #calling in_check? and reverting move

    # def move_piece(start_pos,end_pos)
    #     row1,col1 = start_pos
    #     raise StandardError.new("There is no piece at #{row1},#{col1}") if !valid_pos?(start_pos) || self[start_pos].empty? #@grid[row1][col1].nil? || @grid[row1][col1].is_a?(NullPiece)
    #     piece = @grid[row1][col1]
    #     moves = piece.moves
    #     row2,col2 = end_pos
    #     raise StandardError.new("Illegal move , #{piece.class.to_s} can't move to #{row2},#{col2}" ) unless moves.include?(end_pos)
    #     raise StandardError.new("Illegal move , #{piece.class.to_s} to #{row2},#{col2} moves in check") if test_check(start_pos,end_pos)
    #     @grid[row2][col2] = NullPiece.instance unless @grid[row2][col2].is_a?(NullPiece)
    #     @grid[row2][col2],@grid[row1][col1] = @grid[row1][col1],@grid[row2][col2]
    #     piece.pos = [row2,col2]
    # end

    # def test_check(start_pos,end_pos)
    #     row1,col1 = start_pos
    #     row2,col2 = end_pos
    #     piece = self[start_pos]
    #     saved_piece = NullPiece.instance
    #     unless @grid[row2][col2].is_a?(NullPiece)
    #         saved_piece = @grid[row2][col2]
    #         @grid[row2][col2] = NullPiece.instance 
    #     end
    #     @grid[row2][col2],@grid[row1][col1] = @grid[row1][col1],@grid[row2][col2]
    #     piece.pos = [row2,col2]
    #     check = in_check?(self[end_pos].color)
    #     @grid[row1][col1],@grid[row2][col2] = @grid[row2][col2],saved_piece
    #     piece.pos = [row1,col1]
    #     check
    # end

    # def checkmate?(color)
    #     in_check?(color) && 
    #     @grid.none? do |row|
    #         row.any? do |tile|
    #             !tile.empty? && tile.color == color && 
    #             tile.moves.any? do |move|
    #                 !test_check(tile.pos,move)
    #             end
    #         end
    #     end
    # end
end