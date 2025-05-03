extends Area3D

var material = "parts"

func _ready() -> void:
	$AnimationPlayer.play("Powerup")

func _on_body_entered(body: Node3D) -> void:
	get_node("/root/Main").materials[material] += 1
	print(get_node("/root/Main").materials)
	queue_free()

func update_material():
	get_node("Part/" + material).show()
	
