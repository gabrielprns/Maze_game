extends Spatial;

const WIDTH: int = 30;
const HEIGHT: int = 30;
const ROOM_AMOUNT: int = 5;
const ROOM_SIZE: int = 5;

var game_map: Array = [];
var rooms: Array = [];
var start_room = Vector3();

onready var grid: GridMap = get_node("GridMap");

func _ready():
	randomize();
	
	for x in WIDTH:
		game_map.append([]);
		for y in HEIGHT:
			game_map[x].append(true);
	
	for _i in range(ROOM_AMOUNT):
		generate_rooms(game_map);
	generate_corridor(game_map);

	generate_map(game_map);


func generate_rooms(map: Array) -> void:
	randomize();
	var aux: int = int(ROOM_SIZE/2);
	var x_pos: int = rand_range(ROOM_SIZE-aux+1, WIDTH-ROOM_SIZE-aux);
	var y_pos: int = rand_range(ROOM_SIZE-aux+1, HEIGHT-ROOM_SIZE-aux);

	if rooms.has(Vector2(x_pos, y_pos)) or\
	rooms.has(Vector2(x_pos + aux, y_pos - aux)) or\
	rooms.has(Vector2(x_pos - aux, y_pos + aux)) or\
	rooms.has(Vector2(x_pos + aux, y_pos + aux)):
		generate_rooms(map);
	else:
		for x in range(x_pos-aux, x_pos+aux+1):
			for y in range(y_pos-aux, y_pos+aux+1):
				rooms.append(Vector2(x, y));
				map[x][y] = false;


func generate_corridor(map: Array) -> void:
	for corridor_amount in range(ROOM_AMOUNT-1):
		var coin = randi() > 0.5;
		var aux = int(ROOM_SIZE/2);

		var p1_x = rooms[ROOM_SIZE*ROOM_SIZE * corridor_amount].x+aux;
		var p1_y = rooms[ROOM_SIZE*ROOM_SIZE * corridor_amount].y+aux;
		var p2_x = rooms[ROOM_SIZE*ROOM_SIZE * (corridor_amount+1)].x+aux;
		var p2_y = rooms[ROOM_SIZE*ROOM_SIZE * (corridor_amount+1)].y+aux;

		var displace: Vector2 = Vector2(0, 1);

		var point: Vector2 = Vector2(p1_x , p1_y);
		var point1: Vector2 = Vector2(p2_x, p2_y);

		if point.x > point1.x:
			point.x += point1.x;
			point1.x = point.x - point1.x;
			point.x = point.x - point1.x;
			displace.y = 0;
		if point.y > point1.y:
			point.y += point1.y;
			point1.y = point.y - point1.y;
			point.y = point.y - point1.y;
			displace.x = 1;

		var h_length: int = abs(point1.x - point.x);
		var v_length: int =  abs(point1.y - point.y);

		for corridor_block in range(h_length):
			if point.x+corridor_block < WIDTH:
				map[point.x+corridor_block][point.y+(v_length*displace.x)] = false;
		for corridor_block in range(v_length):
			if point.y+corridor_block < HEIGHT:
				map[point.x+(h_length*displace.y)][point.y+corridor_block] = false;


func generate_map(map: Array) -> void:
	var aux = int(ROOM_SIZE/2);
	start_room = Vector3(rooms[0].x, 10, rooms[0].y);

	for x in WIDTH:
		for z in HEIGHT:
			if map[x][z]:
				grid.set_cell_item(x-int(WIDTH/2), 0, z-int(HEIGHT/2), 0);
				#yield(get_tree().create_timer(0.005), "timeout");
