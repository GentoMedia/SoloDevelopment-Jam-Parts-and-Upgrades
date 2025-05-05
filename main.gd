extends Node3D

@export var upgrade_base_timer = 30
var materials = {"parts":0, "rubber":0, "oil":0, "water":0}
var upgrades = 0
var time_to_upgrade

func _ready() -> void:
	time_to_upgrade = upgrade_base_timer * (upgrades + 1)
	update_materials("parts", 0)
	randomize()
	toggle_pause()



func update_materials(resource : String, amount : int):
	materials[resource] += amount
	$HUD/ResourceLabels/GearsLabel.text = "Gears: " + str(materials["parts"])
	$HUD/ResourceLabels/RubberLabel.text = "Rubber: " + str(materials["rubber"])
	$HUD/ResourceLabels/OilLabel.text = "Oil: " + str(materials["oil"])
	$HUD/ResourceLabels/WaterLabel.text = "Water: " + str(materials["water"])


func _on_timer_timeout() -> void:
	if !$Garden/UpgradeSpot/UpgradeIndicator.visible:
		var weeds = $Garden/Ground/Weeds.get_child_count()
		if randi_range(1, maxi(1, time_to_upgrade)) > weeds:
			time_to_upgrade -= 1
		if time_to_upgrade <= 0:
			time_to_upgrade = 0
			$Garden/UpgradeSpot/UpgradeIndicator.visible = true
			if $Garden/ControlIndicator:
				$Garden/ControlIndicator.queue_free()
			$UpgradeReadyBell.play()
		$HUD/ProgressBar.value = (1 - time_to_upgrade/(float(upgrade_base_timer*(upgrades+1))))*100
	
	if randi_range(upgrades, 12) >= 10:
		$Garden.make_weed()

func upgrade_update(upgrade_amount : int):
	upgrades = upgrade_amount
	time_to_upgrade = upgrade_base_timer * (upgrades + 1)
	$HUD/ProgressBar.value = 0

func toggle_pause():
	get_tree().paused = !get_tree().paused
	$HUD/PauseScrene.visible = get_tree().paused
