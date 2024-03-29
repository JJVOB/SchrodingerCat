extends Actor

func _physics_process(delta: float) -> void:
	var jump_was_interrupted = Input.is_action_just_released("move_jump") and velocity.y < 0
	var direction = get_direction()
	velocity = calculate_velocity(direction, jump_was_interrupted)
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - 
		Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("move_jump") and is_on_floor() else 1.0
	)

func calculate_velocity(direction: Vector2, jump_was_interruted: bool) -> Vector2:
	var new_velocity = velocity
	new_velocity.y += calculate_gravity()
	
	if direction.y < 0:
		new_velocity.y = speed.y * direction.y

	if jump_was_interruted:
		new_velocity.y = 0
	
	new_velocity.x = direction.x * speed.x
	return new_velocity
