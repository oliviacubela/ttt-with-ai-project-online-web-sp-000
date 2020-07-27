module Players
  class Computer < Player
    def move(token)
      position.select{|p|p == valid_move?}
    end
  end
end
