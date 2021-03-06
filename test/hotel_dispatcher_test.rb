require_relative 'test_helper'


describe "HotelDispatcher class" do
  describe "initialize" do
    it "@rooms will have a length of 20" do
    dispatcher = Hotel::HotelDispatcher.new()
    expect(dispatcher.rooms.length).must_equal 20
    end

    it "@reservations will be empty" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect(dispatcher.reservations).must_be_empty
      end

  end 

  describe "make a new reservation" do
    it "@reservations should be length one" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      dispatcher.make_reservation(Date.new(2020, 04, 01), Date.new(2020, 04, 05))
      dispatcher.make_reservation(Date.new(2020, 05, 01), Date.new(2020, 05, 05))
      expect(dispatcher.reservations.length).must_equal 3
    end

    it "is an array" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect(dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))).must_be_kind_of Array
    end

    it "raises ArgumentError when start date is greater than end date" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect{ dispatcher.make_reservation(Date.new(2020, 03, 15), Date.new(2020, 03, 01)) }.must_raise ArgumentError
    end

  end 

  describe "find all reservations by room num and date range" do
    it "finds all reservations for a room given room_num and date range" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2020, 03, 03), Date.new(2020, 03, 07))).must_be_kind_of Array
    end

    it "returns a reservation when the given start_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2020, 03, 04), Date.new(2020, 03, 10)).length).must_equal 1
    end

    it "returns a reservation when the given end_date falls into the reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2020, 02, 28), Date.new(2020, 03, 03)).length).must_equal 1
    end

    it "does NOT return a reservation when the given date_range does NOT overlap with reservation date range" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.find_all_res_for_room(1, Date.new(2020, 03, 07), Date.new(2020, 03, 10))).must_be_empty
    end

  end 

  describe "find all reservations for a single date" do
     it "finds all reservations for a single date" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 07))
      dispatcher.make_reservation(Date.new(2019, 03, 06), Date.new(2019, 03, 10))
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 06))
      expect(dispatcher.find_all_reservations(Date.new(2019, 03, 06)).length).must_equal 2
      expect(dispatcher.find_all_reservations(Date.new(2019, 04, 01)).length).must_equal 0
    end
  end

  describe "find available rooms" do
    it "will have 20 rooms on a new Hotel Dispatcher object and all rooms are available" do
      dispatcher = Hotel::HotelDispatcher.new()
      expect(dispatcher.find_available_rooms(Date.new(2020, 03, 06), Date.new(2020, 03, 10)).length).must_equal 20
    end

    it "returns 19 rooms when input_s_date >= res_s_date && input_e_date < res_e_date" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.find_available_rooms(Date.new(2020, 03, 02), Date.new(2020, 03, 04)).length).must_equal 19
    end

    it "returns 19 rooms when input_s_date < res_s_date && input_e_date < res_e_date" do 
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 04, 04), Date.new(2020, 04, 14))
      expect(dispatcher.find_available_rooms(Date.new(2020, 04, 01), Date.new(2020, 04, 06)).length).must_equal 19
    end

    it "returns 19 rooms when input_s_date < res_e_date && input_e_date > res_e_date" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2019, 03, 01), Date.new(2019, 03, 05))
      expect(dispatcher.find_available_rooms(Date.new(2019, 03, 03), Date.new(2019, 03, 06)).length).must_equal 19
    end

  end

  describe "book available room with date range" do
    it "will book a specific room on specific dates" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.make_reservation(Date.new(2020, 03, 01), Date.new(2020, 03, 05))
      expect(dispatcher.reservations.length).must_equal 1

      dispatcher.make_reservation(Date.new(2020, 04, 01), Date.new(2020, 04, 12))
      expect(dispatcher.reservations.length).must_equal 2
      
      dispatcher.book_avail_room_w_date_range(5, Date.new(2020, 03, 15), Date.new(2020, 03, 20))
      expect(dispatcher.reservations.length).must_equal 3

    end

    it "will raise an ArgumentError if room is unavailable for specific date" do
      dispatcher = Hotel::HotelDispatcher.new()
      dispatcher.book_avail_room_w_date_range(5, Date.new(2020, 03, 16), Date.new(2020, 03, 19))
      expect{ dispatcher.book_avail_room_w_date_range(5, Date.new(2020, 03, 15), Date.new(2020, 03, 21)) }.must_raise ArgumentError
    end
  
  end 

end 
