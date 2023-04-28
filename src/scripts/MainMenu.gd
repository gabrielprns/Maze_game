extends Control

export var mainGameScene: PackedScene;


func _on_PlayButton_button_up():
	get_tree().change_scene(mainGameScene.resource_path);


func _on_ExitButton_button_up():
	get_tree().quit();
