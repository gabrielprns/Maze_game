extends Spatial

onready var navmesh = $NavigationMeshInstance;
onready var map = $NavigationMeshInstance/Map;

var Player = preload("res://src/Player.tscn");
var Enemy = preload("res://src/Enemy.tscn");
var Box = preload("res://src/ItemBox.tscn");

var player: KinematicBody;
var enemy: KinematicBody;

func _ready():
	randomize();
	
	var room_ammount = map.ROOM_AMOUNT;
	var room_size = map.ROOM_SIZE;
	var rooms = map.rooms;

	var vertices = $NavigationMeshInstance/Map/GridMap.get_used_cells_by_item(1);

	var player_point = rand_range(0, len(vertices));
	var enemy_point = rand_range(0, len(vertices));
	
	var player_start_point = vertices[player_point];
	var enemy_start_point = vertices[enemy_point];
	
	player_start_point.y = 2;
	enemy_start_point.y = 2;

	for i in room_ammount:
		var pos = rand_range(0, len(vertices));
		var box_pos = vertices[pos];
		box_pos.y = 0.25;
		var box = Box.instance();
		box.get_child(0).name = "collect_area" + str(i);
		box.transform.origin = box_pos;
		add_child(box);


	player = Player.instance();
	enemy = Enemy.instance();

	player.set_pos(player_start_point);
	enemy.set_pos(enemy_start_point);

	navmesh.add_child(player);
	navmesh.add_child(enemy);
	navmesh.bake_navigation_mesh(false);


func _physics_process(_delta):
	var loc = player.global_transform.origin;
	enemy.call_deferred("set_target", loc);
	
	if player.itens == map.ROOM_AMOUNT:
		player.win();
		enemy.SPEED += 0.2;
