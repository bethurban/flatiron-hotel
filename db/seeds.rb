User.create!(name: "Beth Urban", phone_number: "555-234-8943", email: "beth@beth.com", admin: false, password_digest: BCrypt::Password.create('password') )
User.create!(name: "Bea Urban", phone_number: "555-234-6543", email: "bea@bea.com", admin: false, password_digest: BCrypt::Password.create('password') )
User.create!(name: "Maya Salam", phone_number: "555-532-8982", email: "maya@flatironhotel.com", admin: true, password_digest: BCrypt::Password.create('password') )

Room.create!(room_number: "1", cost: 300, capacity: 3, image: File.new(File.join(Rails.root, "public/uploads/room/image/1/LuxuriousHawaiiHotelSuites_HERO.jpg")) )
Room.create!(room_number: "2", cost: 400, capacity: 4, image: File.new(File.join(Rails.root, "public/uploads/room/image/2/room2.jpg")) )

Booking.create!(room_id: 1, user_id: 1, group_size: 2, checkin: DateTime.new(2020,1,1), checkout: DateTime.new(2020,1,4) )
Booking.create!(room_id: 2, user_id: 1, group_size: 4, checkin: DateTime.new(2020,1,13), checkout: DateTime.new(2020,1,16) )
Booking.create!(room_id: 1, user_id: 2, group_size: 3, checkin: DateTime.new(2020,1,28), checkout: DateTime.new(2020,1,31) )
