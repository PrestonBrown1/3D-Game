extends CharacterBody3D
var player
var camera
const SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")
	camera = get_node("/root/Game/Player/Camera3D")
	self.velocity = -1 * player.global_transform.basis.z * SPEED
	self.velocity.y = camera.global_rotation.x * SPEED
	self.velocity += player.velocity

func _physics_process(delta):
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.get_class() == "CharacterBody3D":
		body.damage(10)
		queue_free()


func _on_timer_timeout():
	queue_free()
