extends Control


func win_screen() -> void:
	show();
	get_tree().paused = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);

func _on_Quit_button_up():
	get_tree().quit();


func _on_Restart_button_up():
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	var _result = get_tree().reload_current_scene();


func _on_NextLevel_button_up():
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	var _result = get_tree().reload_current_scene();
