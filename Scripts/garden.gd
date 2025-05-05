extends Node3D


@onready var weed = preload("res://Scenes/weed.tscn")
var upgrades = {"PlayerSpeed": 0, "PlayerAttack": 0, "RobotEfficiency": 0}
signal upgraded(upgrades : int)
@onready var junk_spawners = preload("res://Scenes/junk_spawners.tscn")


func make_weed():
	var new_weed = weed.instantiate()
	$Ground/Weeds.add_child(new_weed)
	var new_pos = Vector3(randi_range(-7, 7), 0, randi_range(0, 3))
	new_weed.position = new_pos


func activate_upgrade(upgrade : String):
	if $UpgradeSpot/UpgradeIndicator.visible and upgrades[upgrade] <= 4:
		upgrades[upgrade] += 1
		get_node("UpgradeTree/TreeTrunk/" + upgrade + "/Upgrade" + str(upgrades[upgrade])).visible = true
		
		if upgrade == "PlayerAttack":
			$Player.attack += 1
		if upgrade == "PlayerSpeed":
			$Player.speed += 0.5
		if upgrade == "RobotEfficiency":
			update_robots()
		$UpgradeSpot/UpgradeIndicator.visible = false
		upgraded.emit(upgrades["PlayerAttack"] + upgrades["PlayerSpeed"] + upgrades["RobotEfficiency"])

func update_robots():
	for robot in $Robots.get_children():
		robot.attack = 1 + upgrades["RobotEfficiency"]
		robot.speed = 1.0 + (0.25 * float(upgrades["RobotEfficiency"]))

func reset_junk():
	$JunkSpawners.queue_free()
	var new_junk = junk_spawners.instantiate()
	add_child(new_junk)
	
