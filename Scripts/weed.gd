extends StaticBody3D

func hit_machine(_damage : int):
	$AnimationPlayer.play("hit")
