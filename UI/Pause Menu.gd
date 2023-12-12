extends Control


func _ready():
	hide()

func _on_resume_pressed():
	get_tree().paused = false
	hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_quit_pressed():
	get_tree().quit()
