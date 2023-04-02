extends Spatial;

const WIDTH: int = 30;
const HEIGHT: int = 30;
const ROOM_AMOUNT: int = 6;
const ROOM_SIZE: int = 4;

var game_map: Array = [];
var rooms: Array = [];

onready var grid: GridMap = get_node("GridMap");

func _ready():
	randomize();
	
	for x in WIDTH:
		game_map.append([]);
		for y in HEIGHT:
			game_map[x].append(true);
	
	for _i in range(ROOM_AMOUNT):
		generate_rooms(game_map);
	generate_map(game_map);

func generate_rooms(map: Array) -> void:
	var aux: int = int(ROOM_SIZE/2);
	var x_pos: int = rand_range(ROOM_SIZE-aux+1, WIDTH-ROOM_SIZE-aux);
	var y_pos: int = rand_range(ROOM_SIZE-aux+1, HEIGHT-ROOM_SIZE-aux);

	if rooms.has(Vector2(x_pos, y_pos)) or\
	rooms.has(Vector2(x_pos + ROOM_SIZE, y_pos)) or\
	rooms.has(Vector2(x_pos, y_pos + ROOM_SIZE)) or\
	rooms.has(Vector2(x_pos + ROOM_SIZE, y_pos + ROOM_SIZE)):
		generate_rooms(map);
	else:
		#rooms.append(Vector2(x_pos, y_pos));

		for x in range(x_pos-aux, x_pos+ROOM_SIZE):
			for y in range(y_pos-aux, y_pos+ROOM_SIZE):
				rooms.append(Vector2(x, y));
				map[x][y] = false;

func generate_corridor(map: Array) -> void:
	for corridor_amount in range(ROOM_AMOUNT):
		var coin = randi() > 0.5;

func generate_map(map: Array) -> void:
	for x in WIDTH:
		for z in HEIGHT:
			if map[x][z]:
				grid.set_cell_item(x-int(WIDTH/2), 0, z-int(HEIGHT/2), 0);
				#yield(get_tree().create_timer(0.005), "timeout");
