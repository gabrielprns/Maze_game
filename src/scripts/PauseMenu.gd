extends ColorRect

onready var animator: AnimationPlayer = $AnimationPlayer;

func unpause():
	animator.play("Unpause");
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


func pause():
	animator.play("Pause");
	get_tree().paused = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);

func _on_QuitButton_button_up():
	get_tree().quit();


func _on_ResumeButton_button_up():
	unpause();
