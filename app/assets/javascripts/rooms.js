$(document).ready(function() {
  console.log('rooms.js has loaded');
  listenForClick();
});

function listenForClick() {
  $('.all_rooms').on('click', function(event) {
    event.preventDefault();
    getRooms();
  })
};

function getRooms() {
  $.ajax({
    url: 'https://localhost:3000/rooms',
    method: 'get',
    dataType: 'json'
  }).done(function(data) {

    console.log("Data: ", data);
  });
};
