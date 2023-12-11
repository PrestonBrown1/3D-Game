extends Node3D
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/Game/Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.get_class() == "CharacterBody3D":
		body.damage(10)
		queue_free()


func _on_timer_timeout():
	queue_free()
