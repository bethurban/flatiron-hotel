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
    var data = data;
    let myRoom = new Room(data[0]);
    let myRoomHTML = myRoom.roomHTML();
    document.getElementById('rooms_div').innerHTML = myRoomHTML;
  });
};

class Room {
  constructor(obj) {
    this.id = obj.id;
    this.room_number = obj.room_number;
    this.cost = obj.cost;
    this.capacity = obj.capacity;
    this.image = obj.image;
  };
};

Room.prototype.roomHTML = function() {
  return (`<h3>Room #${ this.room_number }</h3>`);
};
