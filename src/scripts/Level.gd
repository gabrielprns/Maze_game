extends Spatial

onready var navmesh = $NavigationMeshInstance;
onready var map = $NavigationMeshInstance/Map;

var Player = preload("res://src/Player.tscn");
var Enemy = preload("res://src/Enemy.tscn");

var player: KinematicBody;
var enemy: KinematicBody;

func _ready():
	navmesh.bake_navigation_mesh(false);
	
	player = Player.instance();
	enemy = Enemy.instance();
	
	player.set_pos(map.start_room);
	enemy.set_pos(map.end_room);
	
	add_child(player);
	add_child(enemy);
	

func _physics_process(delta):
	var loc = player.global_transform.origin;
	enemy.call_deferred("set_target", loc);
