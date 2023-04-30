extends KinematicBody

const SPEED = 5.0;

onready var agent = $NavigationAgent;

func _physics_process(_delta) -> void:
	var current_location = global_transform.origin;
	var next_location = agent.get_next_location();
	var velocity = (next_location - current_location).normalized() * SPEED;
	var _result = move_and_slide(velocity);


func set_target(target: Vector3) -> void:
	agent.set_target_location(target);


func set_pos(pos: Vector3) -> void:
	transform.origin = pos;
