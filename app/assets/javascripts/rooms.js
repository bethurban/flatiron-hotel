$(document).ready(function() {
  console.log('rooms.js has loaded');
  listenForRoomsClick();
});

function listenForRoomsClick() {
  $('.all_rooms').on('click', function(event) {
    event.preventDefault();
    getRooms();
  });
};

function getRooms() {
  $.ajax({
    url: 'https://localhost:3000/rooms',
    method: 'get',
    dataType: 'json'
  }).done(function(data) {

    console.log("Data: ", data);
    document.getElementById('rooms_div').innerHTML = `<h2>All Rooms</h2>`;
    data.forEach(function(room) {
      let myRoom = new Room(room);
      let myRoomHTML = myRoom.roomHTML();
      document.getElementById('rooms_div').innerHTML += myRoomHTML;
    });
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
  return (`<div>
    <h3>Room #${ this.room_number }</h3>
    <img src="${ this.image.image.thumb.url }">
    <ul>
      <li>Cost: $${ this.cost }</li>
      <li>Capacity: ${ this.capacity } guests</li>
    </ul>
    </div>
    `);
};
