extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var player
var body

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = get_node("/root/Game/Player")
	body = get_parent_node_3d()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	#Get Player Location
	var playerLocation = player.global_position

	#Get Direction to Player
	var direction = atan((playerLocation.z - body.position.z)/(playerLocation.x - body.position.x))
	body.rotation.x = direction
	print(rad_to_deg(direction))
	body.velocity.z = SPEED
	

	move_and_slide()
