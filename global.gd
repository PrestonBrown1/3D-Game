extends Node
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func addScore(s):
	score += s

func win():
	get_tree().change_scene_to_file("res://UI/win.tscn")
	
func lose():
	get_tree().change_scene_to_file("res://UI/lose.tscn")
