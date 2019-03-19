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

class Room {
  constructor(obj) {
    this.id = obj.id;
    this.room_number = obj.room_number;
    this.cost = obj.cost;
    this.capacity = obj.capacity;
    this.image = obj.image;
  };
};

Room.prototype.postHTML = function() {
  return (`
    <div>
      <h3>${link_to "Room #{this.room_number}", room_path(this)}</h3>
      ${image_tag this.image.thumb.url}
        <ul>
          <li>Cost: $${ this.cost } per night</li>
          <li>Capacity: ${ this.capacity } guests</li>
        </ul>
    </div>
    `);
};
