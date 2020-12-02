require 'byebug'
require 'colorize'

class Tile
    attr_reader :value, :given
    attr_writer :value

    def initialize(value, given=false)
        @value = value
        @given = given
    end

    def to_s
        if self.given
            @value.to_s.black.on_white
        elsif self.value == 0
            @value.to_s.light_blue.on_white
        else
            @value.to_s.magenta.on_white
        end
    end
end
    