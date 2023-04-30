extends ColorRect

onready var animator: AnimationPlayer = $AnimationPlayer;

func unpause() -> void:
	animator.play("Unpause");
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


func pause() -> void:
	animator.play("Pause");
	get_tree().paused = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);


func _on_ResumeButton_button_up() -> void:
	unpause();
	get_parent().get_child(7).show();


func _on_BackToMenuButton_button_up():
	var _result = get_tree().change_scene("res://src/MainMenu.tscn");


func _on_QuitPauseButton_button_up():
	get_tree().quit();


func _on_Button_hover():
	$HoverSound.play();


func _on_Button_click():
	$ClickSound.play();
