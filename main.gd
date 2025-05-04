extends Node3D

var materials = {"parts":0, "rubber":0, "oil":0, "water":0}
var upgrades = 0
var time_to_upgrade = 60
var upgrade_available = false

func _ready() -> void:
	randomize()



func update_materials(resource : String, amount : int):
	materials[resource] += amount
	$HUD/ResourceLabels/GearsLabel.text = "Gears: " + str(materials["parts"])
	$HUD/ResourceLabels/RubberLabel.text = "Rubber: " + str(materials["rubber"])
	$HUD/ResourceLabels/OilLabel.text = "Oil: " + str(materials["oil"])
	$HUD/ResourceLabels/WaterLabel.text = "Water: " + str(materials["water"])


func _on_timer_timeout() -> void:
	if !upgrade_available:
		var weeds = $Garden/Ground/Weeds.get_child_count()
		if randi_range(1, maxi(1, time_to_upgrade)) > weeds:
			time_to_upgrade -= 1
		if time_to_upgrade <= 0:
			time_to_upgrade = 0
			upgrade_available = true
		$HUD/ProgressBar.value = (1 - time_to_upgrade/(float(60*(upgrades+1))))*100
	
	if randi_range(1, 10 + upgrades) >= 10:
		$Garden.make_weed()
