require_relative 'piece.rb'

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