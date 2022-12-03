extends KinematicBody

# Emitted when the player jumped on the mob.
signal squashed

# minimum speed of the mob in metres per second
export var min_speed = 10

# maximum speed of the mob in metres per second
export var max_speed = 18

var velocity = Vector3.ZERO

# called from the main scene
func initialize(start_position: Vector3, player_position: Vector3):
	# position and turn mob so it looks at player
	look_at_from_position(start_position, player_position, Vector3.UP)

	# and rotate randomly
	rotate_y(rand_range(-PI / 4, PI / 4))

	# calculate random speed
	var random_speed = rand_range(min_speed, max_speed)
	
	# get forward velocity
	velocity = Vector3.FORWARD * random_speed
	
	# rotate based upon mob's angle
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	$AnimationPlayer.playback_speed = random_speed / min_speed

func _physics_process(delta):
	move_and_slide(velocity)

func _on_VisibilityNotifier_screen_exited():
	queue_free()

func squash():
	emit_signal("squashed")
	queue_free()
