extends KinematicBody

onready var nav: NavigationAgent = $NavigationAgent;

const SPEED: float = 5.0;

func _physics_process(_delta: float) -> void:
	if nav.is_navigation_finished():
		return

	var next_location = nav.get_next_location();
	#var current_location = global_transform.origin;
	var direction = global_transform.origin.direction_to(next_location);
	var velocity = direction * nav.max_speed;

	#var new_velocity = (next_location - current_location).normalized() * SPEED;
	var _vel = move_and_slide(velocity, Vector3.UP);


func set_target(target: Vector3) -> void:
	print(target);
	nav.set_target_location(target);
