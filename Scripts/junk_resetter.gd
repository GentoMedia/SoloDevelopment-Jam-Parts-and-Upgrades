extends StaticBody3D
signal update_junk


func hit_machine(_damage : int):
	if $Timer.is_stopped():
		update_junk.emit()
		$AnimationPlayer.play("hit")
		$AudioStreamPlayer3D.play()
		$Timer.start()
