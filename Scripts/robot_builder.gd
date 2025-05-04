extends StaticBody3D

@export var cost = {"parts":20, "rubber":12, "oil":4, "water":4}

@onready var main = get_node("/root/Main")
@onready var robot = preload("res://Scenes/robot.tscn")

func _ready() -> void:
	$AnimationPlayer.play("Normal")

func hit_machine(damage : int):
	$AnimationPlayer.play("Hit")
	if main.materials["parts"] >= cost["parts"]:
		if main.materials["rubber"] >= cost["rubber"]:
			if main.materials["oil"] >= cost["oil"]:
				if main.materials["water"] >= cost["water"]:
					make_robot()
					main.update_materials("parts", -cost["parts"])
					main.update_materials("rubber", -cost["rubber"])
					main.update_materials("oil", -cost["oil"])
					main.update_materials("water", -cost["water"])
	

func make_robot():
	var new_robot = robot.instantiate()
	get_node("/root/Main/Garden/Robots").add_child(new_robot)
	new_robot.position = Vector3(-15.0, 0.5, -1.0)

func reset_animation():
	$AnimationPlayer.play("Normal")
