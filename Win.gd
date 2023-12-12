extends Control
var global

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	global = get_node("/root/Global")

func _physics_process(delta):
	$Label3.text = "Your Score: " + str(global.score)

func _on_quit_pressed():
	get_tree().quit()
