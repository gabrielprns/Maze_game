extends Spatial

onready var navmesh = $NavigationMeshInstance;
onready var map = $NavigationMeshInstance/Map;

var Player = preload("res://src/Player.tscn");
var Enemy = preload("res://src/Enemy.tscn");
var Box = preload("res://src/ItemBox.tscn");

var player: KinematicBody;
var enemy: KinematicBody;

func _ready():

	var room_ammount = map.ROOM_AMOUNT;
	var room_size = map.ROOM_SIZE;
	var rooms = map.rooms;

	for i in room_ammount:
		var box_pos = Vector3(rooms[i+ i*room_size*room_size].x-int(map.WIDTH/2), 0.25, rooms[i+ i*room_size*room_size].y-int(map.HEIGHT/2));
		var box = Box.instance();
		box.get_child(0).name = "collect_area" + str(i);
		box.transform.origin = box_pos;
		add_child(box);

	navmesh.bake_navigation_mesh(false);

	player = Player.instance();
	enemy = Enemy.instance();

	player.set_pos(map.start_room);
	enemy.set_pos(map.end_room);

	add_child(player);
	add_child(enemy);



func _physics_process(_delta):
	var loc = player.global_transform.origin;
	enemy.call_deferred("set_target", loc);
	
	if player.itens == map.ROOM_AMOUNT:
		player.win();
		enemy.SPEED += 0.2;
