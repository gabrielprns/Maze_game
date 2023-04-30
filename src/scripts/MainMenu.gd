extends Control

export var mainGameScene: PackedScene;

func _on_PlayButton_button_up():
	var _result = get_tree().change_scene(mainGameScene.resource_path);


func _on_ExitButton_button_up():
	get_tree().quit();


func _on_Button_hover():
	$HoverSound.play();


func _on_Button_click():
	$ClickSound.play();
