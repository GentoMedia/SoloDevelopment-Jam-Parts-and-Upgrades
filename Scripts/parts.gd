extends Area3D

var material = "parts"

func _ready() -> void:
	$AnimationPlayer.play("Powerup")

func _on_body_entered(_body: Node3D) -> void:
	get_node("/root/Main").update_materials(material, 1)
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
	visible = false
	$AudioStreamPlayer3D.play()

func update_material():
	get_node("Part/" + material).show()
	
