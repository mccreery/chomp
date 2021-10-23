extends Control


export (Resource) var scene

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_StartButton_pressed():
    get_tree().change_scene(scene.resource_path)


func _on_QuitButton_pressed():
    get_tree().quit()


func _on_HowToPlayButton_pressed():
    get_tree().change_scene("res://HowToPlayMenu.tscn")
