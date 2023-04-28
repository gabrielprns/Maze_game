extends Spatial

onready var navmesh = $NavigationMeshInstance;
onready var map = $NavigationMeshInstance/Map;

var player: KinematicBody;
var enemy: KinematicBody;

func _ready():
	navmesh.bake_navigation_mesh(false);
	
	var player_scene = load("res://src/Player.tscn");
	var enemy_scene = load("res://src/Enemy.tscn");
	
	player = player_scene.instance();
	enemy = enemy_scene.instance();
	
	player.global_transform.origin = map.start_room;
	enemy.global_transform.origin = map.end_room;
	
	add_child(player);
	add_child(enemy);

func _physics_process(delta):
	var loc = player.global_transform.origin;
	enemy.call_deferred("set_target", loc);
