extends StaticBody3D


var machines = {
	0:"fridge1", 
	1: "fridge2", 
	2:"menu", 
	3:"oven", 
	4:"stove1", 
	5:"stove2"}

var health = 4

func _ready() -> void:
	var machine = machines[randi_range(0, 5)]
	update_machine(machine)

func update_machine(new_machine: String):
	get_node("Machines/" + new_machine).show()

func hit_machine(damage : int):
	health -= damage
	if health <= 0:
		$AnimationPlayer.play("destroy")
