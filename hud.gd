extends Control

var score
var global

func _ready():
	score = 0
	global = get_node("/root/Global")
	
func _physics_process(delta):
	$Score.text = "Score: " + str(global.score)
