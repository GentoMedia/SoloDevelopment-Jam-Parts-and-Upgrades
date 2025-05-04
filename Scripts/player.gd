extends CharacterBody3D


@export var speed = 5.0
var right_targets = []
var left_targets = []

var punching = false
var attack = 1

@onready var robot = preload("res://Scenes/robot.tscn")

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

	if Input.is_action_pressed("ui_accept") and !punching:
		if not $RobotIndicator.visible:
			hit_object()
			$AnimatedSprite3D.play("punch")
			punching = true
			$PunchTimer.start()
		else:
			var new_robot = robot.instantiate()
			get_node("/root/Main/Garden/Robots").add_child(new_robot)
			if $AnimatedSprite3D.flip_h:
				new_robot.position = position + Vector3(-1, 0 ,0)
			else:
				new_robot.position = position + Vector3(1, 0 ,0)
			$RobotIndicator.visible = false
		
		

	if punching:
		$AnimatedSprite3D.play("punch")

	move_and_slide()

	
func hit_object():
	if $AnimatedSprite3D.flip_h:
		for body in left_targets:
			if body.is_in_group("Destroyable"):
				body.hit_machine(attack)
			if body.is_in_group("Robot") and not $RobotIndicator.visible:
				body.queue_free()
				$RobotIndicator.visible = true
	else:
		for body in right_targets:
			if body.is_in_group("Destroyable"):
				body.hit_machine(attack)
			if body.is_in_group("Robot") and not $RobotIndicator.visible:
				body.queue_free()
				$RobotIndicator.visible = true
				


func _on_hit_right_body_entered(body: Node3D) -> void:
	if body.is_in_group("Destroyable") or body.is_in_group("Robot"):
		right_targets.append(body)


func _on_hit_right_body_exited(body: Node3D) -> void:
	if body.is_in_group("Destroyable") or body.is_in_group("Robot"):
		right_targets.erase(body)


func _on_hit_left_body_entered(body: Node3D) -> void:
	if body.is_in_group("Destroyable") or body.is_in_group("Robot"):
		left_targets.append(body)


func _on_hit_left_body_exited(body: Node3D) -> void:
	if body.is_in_group("Destroyable") or body.is_in_group("Robot"):
		left_targets.erase(body)


func _on_punch_timer_timeout() -> void:
	if punching:
		punching = false
		$AnimatedSprite3D.play("idle")
