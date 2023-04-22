extends Spatial

onready var enemy = $Navigation/Enemy;
onready var player: KinematicBody = $Navigation/Player;
onready var nav = $Navigation

func _ready():
	var map = $Navigation/NavigationMeshInstance/Map;
	var pos = map.start_room;
	
	player.global_transform.origin = pos;

func _physics_process(delta):
	enemy.set_nav(nav)
	enemy.set_target(player)
