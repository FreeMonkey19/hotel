module Hotel
  class Room
    attr_reader :cost
    attr_accessor :room_num

    def initialize(
      room_num:

    )

      @room_num = room_num
      @cost = 200

    end 
  end 
  
end 


