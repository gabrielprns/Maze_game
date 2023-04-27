extends KinematicBody

const SPEED = 10.0;

onready var agent = $NavigationAgent;

func _physics_process(delta):
	var current_location = global_transform.origin;
	var next_location = agent.get_next_location();
	var velocity = (next_location - current_location).normalized() * SPEED;
	move_and_slide(velocity);


func set_target(target: Vector3) -> void:
	agent.set_target_location(target);
