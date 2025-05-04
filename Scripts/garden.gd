extends Node3D


@onready var weed = preload("res://Scenes/weed.tscn")


func make_weed():
	var new_weed = weed.instantiate()
	$Ground/Weeds.add_child(new_weed)
	var new_pos = Vector3(randi_range(-7, 7), 0, randi_range(0, 3))
	new_weed.position = new_pos
