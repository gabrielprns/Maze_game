extends Node2D

func change_item_count(value: int) -> void:
	$ItemCount.mesh.text = str(value);
