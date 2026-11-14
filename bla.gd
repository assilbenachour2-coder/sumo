extends CharacterBody2D

var push_velocity := Vector2.ZERO

func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	var move_velocity = input_direction * 400
	velocity = move_velocity + push_velocity
	push_velocity = push_velocity.move_toward(Vector2.ZERO, 800 * delta)
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is CharacterBody2D and "push_velocity" in collider:
			var dir = -collision.get_normal()
			var strength = max(move_velocity.dot(dir), 0.0)
			collider.push_velocity = dir * strength

func _on_disappear_area_entered(area):
	if area.is_in_group("bla"):
		print("character 2 wins!")
		queue_free()
