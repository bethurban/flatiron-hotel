$(document).ready(function() {
  console.log('bookings.js has loaded');
  listenForBookingsClick();
});

function listenForBookingsClick() {
  $('.all_bookings').on('click', function(event) {
    event.preventDefault();
    getBookings();
  });
};

function listenForBookingClick() {
  $('.booking_link').on('click', function(event) {
    event.preventDefault();
    getBooking(this.href);
  })
}

function listenForDetailsClick() {
  $('.details_link').on('click', function(event) {
    event.preventDefault();
    getDetails(this.href);
  })
}

function getBookings() {
  var url = window.location.href.split("/");
  var id = url[url.length - 1];
  $.ajax({
    url: `https://localhost:3000/users/${id}/bookings`,
    method: 'get',
    dataType: 'json'
  }).done(function(data) {

    console.log("Data: ", data);
    data.forEach(function(booking) {
      let myBooking = new Booking(booking);
      let myBookingHTML = myBooking.bookingHTML();
      document.getElementById('bookings_div').innerHTML += myBookingHTML;
    });
    listenForBookingClick();
  });
};

function getBooking(booking) {
  var userURL = window.location.href.split("/");
  var userId = userURL[userURL.length - 1];
  var bookingURL = booking.split("/");
  var bookingId = bookingURL[bookingURL.length - 1];
  $.ajax({
    url: `https://localhost:3000/users/${userId}/bookings/${bookingId}`,
    method: 'get',
    dataType: 'json'
  }).done(function(data) {
    console.log("This booking's data: ", data);
    let myBooking = new Booking(data);
    let myBookingHTML = myBooking.bookingDetailsHTML();
    document.getElementById(`booking_details_${bookingId}`).innerHTML += myBookingHTML;
    listenForDetailsClick();
  });
};

function getDetails(room) {
  var roomURL = room.split("/");
  var roomId = roomURL[roomURL.length - 1];
  $.ajax({
    url: `https://localhost:3000/rooms/${roomId}`,
    method: 'get',
    dataType: 'json'
  }).done(function(data) {
    console.log("This room's data: ", data);
  });
};

class Booking {
  constructor(obj) {
    this.id = obj.id;
    this.group_size = obj.group_size;
    this.checkin = obj.checkin;
    this.checkout = obj.checkout;
    this.room_number = obj.room.room_number;
    this.room_id = obj.room.id;
  };
};

Booking.prototype.bookingHTML = function() {
  var checkinParts = this.checkin.split('-');
  var checkoutParts = this.checkout.split('-');
  var checkinDate = new Date(checkinParts[0], checkinParts[1] - 1, checkinParts[2]);
  var checkoutDate = new Date(checkoutParts[0], checkoutParts[1] - 1, checkoutParts[2]);
  var checkin = checkinDate.toDateString();
  var checkout = checkoutDate.toDateString();
  return (`<p>
    Check in on ${checkin}, check out on ${checkout} - <a href="${this.id}" class="booking_link">see details</a>
    </p>
    <div id="booking_details_${this.id}"></div>
    `);
};

Booking.prototype.bookingDetailsHTML = function() {
  return (`<ul>
    <li>Room #${this.room_number} - <a href="${this.room_id}" class="details_link">see photo</a></li>
    <li>Group size: ${this.group_size}</li>
    </ul>
    `);
};
