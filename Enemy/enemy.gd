extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = get_node("/root/Game/Player")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	#Get Player Location
	var playerLocation = player.global_position

	#Get Direction to Player
	var direction = atan((playerLocation.z - position.z)/(playerLocation.x - position.x))
	
	if playerLocation.z < global_position.z and playerLocation.x < global_position.x:
		direction *= -1
	elif playerLocation.z < global_position.z and playerLocation.x > global_position.x:
		direction *= -1
		direction += deg_to_rad(180)
	elif playerLocation.z > global_position.z and playerLocation.x < global_position.x:
		direction *= -1
	elif playerLocation.z > global_position.z and playerLocation.x > global_position.x:
		direction *= -1
		direction += deg_to_rad(180)

	rotation.y = direction - deg_to_rad(90)
	print(rad_to_deg(direction))
	#velocity.z = SPEED
	

	move_and_slide()
