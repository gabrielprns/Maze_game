extends Spatial

onready var enemy: Spatial = $Enemy;
onready var player: Spatial = $Player;

func _physics_process(delta):
	enemy.call_deferred("set_target", player.global_transform.origin);
