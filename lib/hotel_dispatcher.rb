require_relative 'room'

module Hotel
  class HotelDispatcher
    attr_accessor :reservations, :rooms

    def initialize

      @reservations = []
      create_rooms
    end #initialize end

    def create_rooms
      @rooms = []
        (1..20).each do |room_num|
          room = Hotel::Room.new(room_num: 1)
          room.room_num = room_num
          @rooms << room
        end
        return @rooms
    end # create rooms end


    def make_reservation(start_date, end_date)
      room = create_rooms[0]
      new_reservation = Hotel::Reservation.new(start_date: start_date, end_date: end_date, room: room)
      @reservations << new_reservation
      return @reservations
    end


    def find_all_res_for_room(room_num, start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      found_reservations = []
        @reservations.each  do |reservation| 
          next if reservation.room.room_num != room_num
            if ((start_date > reservation.start_date && start_date < reservation.end_date) ||
            (end_date > reservation.start_date && start_date < reservation.end_date)) || 
            (reservation.start_date < start_date && reservation.end_date > end_date)
              found_reservations << reservation
            end
        end
    
        return found_reservations
    end # find_all_res_for_room end


    def find_available_rooms(start_date, end_date)
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
      found_rooms = []
        @reservations.each do |reservation|
          if (start_date >= reservation.end_date && end_date >= reservation.end_date) ||
            (start_date < reservation.start_date && end_date <= reservation.start_date) ||
            (start_date >= reservation.end_date && end_date > reservation.end_date)
            found_rooms << reservation.room
          else 
            raise ArgumentError, "The dates you have entered are NOT available"
          end
        end
        return found_rooms
    end # find_available_rooms end


  # def all_reservations(date)
  # all_reservations_by_date = []
  # return all_reservations_by_date
  # end


  end # class end
end # module end
