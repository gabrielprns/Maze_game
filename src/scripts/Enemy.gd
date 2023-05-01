extends KinematicBody

var SPEED = 4.0;
var hunt = false;

onready var agent = $NavigationAgent;

func _physics_process(_delta) -> void:
	var current_location = global_transform.origin;
	var next_location = agent.get_next_location();
	var velocity = (next_location - current_location).normalized() * SPEED;
	if hunt:
		var _result = move_and_slide(velocity);
		$HuntSound.play();
		$IdleSound.stop();


func set_target(target: Vector3) -> void:
	agent.set_target_location(target);


func set_pos(pos: Vector3) -> void:
	transform.origin = pos;


func _on_enemy_colision_area_entered(area):
	if area.name == "HuntArea":
		hunt = true;
