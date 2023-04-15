extends KinematicBody

onready var nav: NavigationAgent = $NavigationAgent;

const SPEED: float = 3.0;

var velocity: Vector3 = Vector3();

func _physics_process(delta):
	var current_location = global_transform.origin;
	var next_location = nav.get_next_location();

	velocity = (next_location - current_location).normalized() * SPEED;
	print(velocity);
	velocity = move_and_slide(velocity);


func set_target(target: Vector3):
	nav.set_target_location(target);
