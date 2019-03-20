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
  });
};

class Booking {
  constructor(obj) {
    this.id = obj.id;
    this.group_size = obj.group_size;
    this.checkin = obj.checkin;
    this.checkout = obj.checkout;
  };
};

Booking.prototype.bookingHTML = function() {
  return (`<p>
    Check in: ${this.checkin}, check out: ${this.checkout}, group size: ${this.group_size}
    </p>
    `);
};
