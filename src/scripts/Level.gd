extends Spatial

onready var player = $Player;
onready var enemy = $Enemy;
onready var navmesh = $NavigationMeshInstance;
onready var map = $NavigationMeshInstance/Map;

var prepared = false;

func _physics_process(delta):
	var loc = player.global_transform.origin;
	enemy.call_deferred("set_target", loc);


func _ready():
	var player_pos = map.start_room;
	var enemy_pos = map.end_room;
	
	#player.global_transform.origin = player_pos;
	enemy.global_transform.origin = enemy_pos;
	
	navmesh.bake_navigation_mesh(false);
