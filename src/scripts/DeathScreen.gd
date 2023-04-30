extends Control

onready var animator: AnimationPlayer = $AnimationPlayer;

func gameOver() -> void:
	animator.play("GameOver");
	get_tree().paused = true;
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);

func restart() -> void:
	animator.play("hide");
	get_tree().paused = false;
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);
	var _result = get_tree().reload_current_scene();

func _on_TryAgainButton_button_up() -> void:
	restart();


func _on_QuitDeathButton_button_up():
	get_tree().quit();


func _on_Button_hover():
	$HoverSound.play();


func _on_Button_click():
	$ClickSound.play();
