extends KinematicBody;

const GRAVITY = -24.8
var vel = Vector3()
const MAX_SPEED = 10
const JUMP_SPEED = 18
const ACCEL = 4.5

var itens = 0;

var dir = Vector3()

const DEACCEL= 16
const MAX_SLOPE_ANGLE = 40

var camera
var rotation_helper

var MOUSE_SENSITIVITY = 0.05


func _ready():
	camera = $CameraPivot/Camera
	rotation_helper = $CameraPivot

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		$DeathScreen.hide();
		$PauseMenu.pause();


func _physics_process(delta) -> void:
	process_input(delta);
	process_movement(delta);


func process_input(_delta):

	# Walking
	dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2()

	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_right"):
		input_movement_vector.x += 1

	input_movement_vector = input_movement_vector.normalized()

	# Basis vectors are already normalized.
	dir += -cam_xform.basis.z * input_movement_vector.y
	dir += cam_xform.basis.x * input_movement_vector.x

	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY

	var hvel = vel
	hvel.y = 0

	var target = dir
	target *= MAX_SPEED

	var accel
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	vel.x = hvel.x
	vel.z = hvel.z
	vel = move_and_slide(vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(MAX_SLOPE_ANGLE))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_helper.rotation_degrees = camera_rot


func _on_DeathScreen_restart():
	$DeathScreen.restart();
	#get_tree().reload_current_scene();


func set_pos(pos: Vector3) -> void:
	transform.origin = pos;


func _on_EnvironmentColision_area_entered(area):
	if area.name == "enemy_colision":
		$DeathScreen.show();
		$DeathScreen.gameOver();
	elif area.name == "collect_area":
		itens += 1;
