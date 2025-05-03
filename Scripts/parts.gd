extends Area3D

var material = "parts"

func _ready() -> void:
	update_material(material)
	$AnimationPlayer.play("Powerup")

func _on_body_entered(body: Node3D) -> void:
	get_node("/root/Main").materials[material] += 1
	print(get_node("/root/Main").materials)
	queue_free()

func update_material(new_material : String):
	get_node("Part/" + material).show()
	
