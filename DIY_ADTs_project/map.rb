class Map

    def initialize
        @kv_pairs = []
    end

    def set(key, value)
        *new_pair = key, value
        if @kv_pairs.empty?
            @kv_pairs << new_pair
        else 
            if @kv_pairs.none? { |kv| kv[0] == key }
                @kv_pairs << new_pair
            else
                @kv_pairs.each_with_index do |kv, i| 
                    @kv_pairs[i][1] = value if kv[0] == key 
                end
            end
        end
    end

    def get(key)
        index = @kv_pairs.index { |kv| kv[0] == key }
        @kv_pairs[index].last
    end

    def delete(key)
        index = @kv_pairs.index { |kv| kv[0] == key }
        @kv_pairs.delete_at(index)
    end

    def show
        @kv_pairs.each { |kv| p "#{kv.first} => #{kv.last}" }
    end
end

if $PROGRAM_NAME == __FILE__
    color_code = Map.new
    p color_code
    color_code.set("apple", "red")
    color_code.set("sky", "blue")
    color_code.set("snow", "white")
    color_code.set("apple", "green")
    p color_code
    p color_code.get("apple")
    color_code.delete("sky")
    p color_code
    color_code.show
end