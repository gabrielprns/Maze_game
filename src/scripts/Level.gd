extends Spatial

onready var enemy = $Navigation/Enemy;
onready var player: KinematicBody = $Navigation/Player;
onready var nav = $Navigation

func _ready():
	var map = $Navigation/NavigationMeshInstance/Map;
	var player_pos = map.start_room;
	var enemy_pos = map.end_room;
	
	player.global_transform.origin = player_pos;
	enemy.global_transform.origin = enemy_pos;

func _physics_process(delta):
	enemy.set_nav(nav)
	enemy.set_target(player)
