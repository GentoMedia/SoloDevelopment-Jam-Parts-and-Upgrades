extends CharacterBody3D


@export var speed = 5.0

	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		$AnimatedSprite3D.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		$AnimatedSprite3D.play("idle")
		
	# Animation
	if velocity.x > 0:
		$AnimatedSprite3D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite3D.flip_h = true

	if Input.is_action_just_pressed("ui_accept"):
		hit_object()

	move_and_slide()

func hit_object():
	if $AnimatedSprite3D.flip_h:
		pass
			
