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
    console.log("Booking clicked!");
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

class Booking {
  constructor(obj) {
    this.id = obj.id;
    this.group_size = obj.group_size;
    this.checkin = obj.checkin;
    this.checkout = obj.checkout;
    this.room_number = obj.room.room_number
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
    Check in on ${checkin}, check out on ${checkout} - <a href="#" booking="${this.id}" class="booking_link">see details</a>
    </p>
    `);
};
