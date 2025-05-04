extends CharacterBody3D

var robot_type = "collect"
@export var speed = 1.0
var right_targets = []
var left_targets = []

var punching = false
var attack = 1
var input_dir = Vector2(1,0)

var target = null


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_wall():
		input_dir = Vector2(randf_range(-1.0,1.0),randf_range(-1.0,1.0))
	elif target != null:
		input_dir = Vector2(target.global_position.x - global_position.x,
		target.global_position.z - global_position.z).normalized()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		$AnimatedSprite3D.play(robot_type)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		$AnimatedSprite3D.pause()
		
	# Animation
	if velocity.x > 0:
		$AnimatedSprite3D.flip_h = false
	if velocity.x < 0:
		$AnimatedSprite3D.flip_h = true

	move_and_slide()
	
	if not punching:
		punch()

func hit_object():
	if $AnimatedSprite3D.flip_h:
		for body in left_targets:
			body.hit_machine(attack)
	else:
		for body in right_targets:
			body.hit_machine(attack)
	target = null


func _on_hit_right_body_entered(body: Node3D) -> void:
	if body.is_in_group("Destroyable"):
		right_targets.append(body)


func _on_hit_right_body_exited(body: Node3D) -> void:
	if body.is_in_group("Destroyable"):
		right_targets.erase(body)


func _on_hit_left_body_entered(body: Node3D) -> void:
	if body.is_in_group("Destroyable"):
		left_targets.append(body)


func _on_hit_left_body_exited(body: Node3D) -> void:
	if body.is_in_group("Destroyable"):
		left_targets.erase(body)


func _on_punch_timer_timeout() -> void:
	if punching:
		punching = false

func punch():
	hit_object()
	punching = true
	$PunchTimer.start()


func _on_detector_body_entered(body: Node3D) -> void:
	if body.is_in_group("Destroyable"):
		target = body
