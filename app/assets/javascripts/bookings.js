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
  });
};
