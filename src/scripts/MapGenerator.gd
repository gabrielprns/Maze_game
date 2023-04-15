extends Spatial;

const WIDTH: int = 30;
const HEIGHT: int = 30;
const ROOM_AMOUNT: int = 2;
const ROOM_SIZE: int = 4;

var game_map: Array = [];
var rooms: Array = [];

onready var grid: GridMap = get_node("NavigationMeshInstance/GridMap");

func _ready():
	randomize();
	
	for x in WIDTH:
		game_map.append([]);
		for y in HEIGHT:
			game_map[x].append(false);
	
	for _i in range(ROOM_AMOUNT):
		generate_rooms(game_map);
	generate_map(game_map);
	generate_corridor(game_map);

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
	#print(rooms);
	for corridor_amount in range(ROOM_AMOUNT-1):
		#var coin = randi() > 0.5;
		var point1: Vector2 = Vector2(rooms[ROOM_SIZE*ROOM_SIZE*corridor_amount].x+ROOM_SIZE, rooms[corridor_amount].y+ROOM_SIZE);
		var point2: Vector2 = Vector2(rooms[corridor_amount+1].x+ROOM_SIZE, rooms[corridor_amount].y+ROOM_SIZE);
		var length: int = abs(rooms[ROOM_SIZE*ROOM_SIZE*corridor_amount].x - rooms[ROOM_SIZE*ROOM_SIZE*(corridor_amount+1)].x);
		print(length);
		print(point1);

		for corridor_block in range(length):
			if point1.y+corridor_block < WIDTH:
				map[point1.x][point1.y+corridor_block] = false;

func generate_map(map: Array) -> void:
	for x in WIDTH:
		for z in HEIGHT:
			if map[x][z]:
				grid.set_cell_item(x-int(WIDTH/2), 0, z-int(HEIGHT/2), 0);
				#yield(get_tree().create_timer(0.005), "timeout");
