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
  $.ajax({
    url: 'https://localhost:3000/users/1/bookings',
    method: 'get',
    dataType: 'json'
  }).done(function(data) {

    console.log("Data: ", data);
  });
};
