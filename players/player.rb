require_relative '../display.rb'

class Player
    attr_reader :color 
    def initialize(color , display)
        @color = color
        @display = display
    end

end






