extends CharacterBody3D


const SPEED = 5
const JUMP_VELOCITY = 4.5
var player
var following
var health

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = get_node("/root/Game/Player")
	following = false
	health = 100


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	#Get Player Location
	var playerLocation = player.global_position
	var distance = sqrt(abs(playerLocation.x - global_position.x) ** 2 + abs(playerLocation.z - global_position.z) ** 2)
	if distance < 10:
		following = true

	#Get Direction to Player
	var direction = atan((playerLocation.z - position.z)/(playerLocation.x - position.x))
	
	#Making enemy face player
	if playerLocation.x < global_position.x:
		direction *= -1
	elif playerLocation.x > global_position.x:
		direction *= -1
		direction += deg_to_rad(180)

	rotation.y = direction - deg_to_rad(90)
	
	#Calculate Velocity
	if following:
		var inputDir = Vector2()
		if rotation.y > 0:
			inputDir.x = 1
			#velocity.x = SPEED
		else:
			inputDir.x = -1
			#velocity.x = SPEED * -1
		if abs(rad_to_deg(rotation.y)) > 90:
			inputDir.y = 1
			#velocity.z = SPEED * -1
		else:
			inputDir.y = 1
			#velocity.z = SPEED
		
		var angle = (transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
		if angle:
			velocity.x = angle.x * SPEED
			velocity.z = angle.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		print(body.health)
		body.health -= 10
		if body.health < 0:
			body.queue_free()

func damage(d):
	var global = get_node("/root/Global")
	health -= d
	if health <= 0:
		global.addScore(10)
		queue_free()
