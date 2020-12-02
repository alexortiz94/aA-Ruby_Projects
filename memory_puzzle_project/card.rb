require 'byebug'

class Card
attr_reader :face_value, :face_up
    VALUES = [6, 7, 8, 9, 'J', 'Q', 'K', 'A']

    def initialize
        @face_value = VALUES.sample
        @face_up = false
    end

    def hide
        @face_up = false
    end

    def reveal
        @face_up = true
    end

    def to_s
        @face_value.to_s
    end

    def ==(other_card)
        @face_value == other_card.face_value
    end

end


if $PROGRAM_NAME == __FILE__
    card = Card.new
    p card
    card.hide
    p card
    card.reveal
    p card
end
