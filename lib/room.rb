module Hotel
  class Room
    attr_reader :room_num, :cost
    attr_accessor :date_range

    def initialize(
      room_num:, 
      date_range: []

    )

      @room_num = room_num
      @cost = 200


      if date_range
        @date_range = date_range
      end
    end #initialize end
  end #class Room end
  
end #module Hotel end


# parse the dates for comparison later