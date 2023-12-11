extends CharacterBody3D


const SPEED = 7.5
const JUMP_VELOCITY = 4.5
var MOUSE_SENSITIVITY = .01
var MOUSE_RANGE = 1
var health
var bullet

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	health = 100
	bullet = load("res://Player/bullet.tscn")

func _unhandled_input(event):
	# if the mouse has moved
	if event is InputEventMouseMotion:
		# up-down motion, applied to the $Pivot
		$Camera3D.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		# make sure we can't look inside ourselves :)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -MOUSE_RANGE, MOUSE_RANGE)
		# left-right motion, applied to the Player
		rotate_y(-event.relative.x * MOUSE_SENSITIVITY)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Handling Shooting
	if Input.is_action_just_pressed("Shoot"):
		var projectiles = get_node("/root/Game/Projectiles")
		var newBullet = bullet.instantiate()
		newBullet.global_position = $Camera3D/BulletPos.global_position
		projectiles.add_child(newBullet)
		
func damage(d):
	health -= d
	if health <= 0:
		queue_free()
