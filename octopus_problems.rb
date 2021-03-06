require "byebug"

# fishes_array = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

class SluggishOctopus

    def find(fish_array)
        biggest = nil
        fish_array.each_with_index do |fish_1, idx_1|
            fish_array.each_with_index do | fish_2, idx_2|
                next if idx_2 <= idx_1
                bigger = fish_1.length > fish_2.length ? fish_1 : fish_2

                biggest = bigger if biggest.nil? || (bigger.length > biggest.length)
            end
        end
        biggest
    end

end

class DominantOctopus

    def find(fish_array)
        # debugger 
        return fish_array if fish_array.size <= 1


        mid_idx = (fish_array.size/2).round
        # debugger
        left, right = fish_array.take(mid_idx), fish_array.drop(mid_idx)
        sorted_fish = merge(dominant_octopus_find(left),  dominant_octopus_find(right))

        biggest = sorted_fish.last
    end

    def merge(left, right)
        # debugger
        merged_array = []
        if (left.is_a? String) && (right.is_a? String)
            left, right = left.split, right.split
        end

        until left.empty? || right.empty?
            # debugger
            case left.first.length <=> right.first.length
            when -1
                merged_array << left.shift
            when 0
                merged_array << left.shift
            when 1
                merged_array << right.shift
            end
        end
        merged_array + left + right
    end
end

class CleverOctopus

    def find(fish_array)
        return nil if fish_array.empty?
        biggest = fish_array.first
        i = 1
        while i <= (fish_array.length - 1)
            new_fish = fish_array[i]
            biggest = new_fish if new_fish.length > biggest.length
            i += 1
        end
        biggest
    end

end
    

# tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# move_hash = { "up"=>0, "right-up"=>1, "right"=>2, "right-down"=>3, "down"=>4, "left-down"=>5, "left"=>6, "left-up"=>7 }
class DancingOctopus

    def slow_dance(tile_direction, tiles)
        tiles.each_index { |idx| return idx if tiles[idx] == tile_direction }
    end

    def fast_dance(tile_direction, hash_map)
        hash_map[tile_direction]
    end
end

# slow_dance("up", tiles_array)
# > 0

# slow_dance("right-down", tiles_array)
# > 3
# fast_dance("up", new_tiles_data_structure)
# > 0

# fast_dance("right-down", new_tiles_data_structure)
# > 3








    

            
            

