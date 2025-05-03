extends StaticBody3D

var reward_material
var machines = [
	"res://Assets/Kitchen/fridge_A.gltf",
	"res://Assets/Kitchen/fridge_B.gltf",
	"res://Assets/Kitchen/oven.gltf",
	"res://Assets/Kitchen/stove_multi.gltf",
	"res://Assets/Kitchen/stove_single.gltf",
	"res://Assets/Kitchen/kitchentable_sink.gltf"
]
var counters = [
	"res://Assets/Kitchen/kitchencounter_straight_A.gltf",
	"res://Assets/Kitchen/kitchencounter_straight_A_backsplash.gltf",
	"res://Assets/Kitchen/kitchencounter_straight_A_decorated.gltf",
	"res://Assets/Kitchen/kitchencounter_straight_B.gltf",
	"res://Assets/Kitchen/kitchencounter_straight_B_backsplash.gltf",
	"res://Assets/Kitchen/kitchencounter_straight_decorated.gltf"
]

var health = 4
@onready var parts = preload("res://Scenes/parts.tscn")

func _ready() -> void:
	var machine_scene
	var machine
	if randi_range(0,3)>0:
		machine_scene = load(counters[randi_range(0, counters.size()-1)])
	else:
		machine_scene = load(machines[randi_range(0, machines.size()-1)])
		
	machine = machine_scene.instantiate()
	$Machines.add_child(machine)
	machine.scale = Vector3(0.5, 0.5, 0.5)
	machine.position.y = -0.5
	
	var reward_roll = randi_range(0, 9)
	if reward_roll > 4:
		reward_material = "parts"
	elif reward_roll > 1:
		reward_material = "rubber"
	elif reward_roll == 1:
		reward_material = "oil"
	else:
		reward_material = "water"


func hit_machine(damage : int):
	health -= damage
	if health <= 0:
		var reward = parts.instantiate()
		get_parent().add_child(reward)
		reward.position = position
		reward.material = reward_material
		reward.update_material()
		reward.material = reward_material
		$AnimationPlayer.play("destroy")
	else:
		$AnimationPlayer.play("hit")
