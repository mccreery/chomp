extends AudioStreamPlayer2D

var ending = false

func _ready():
    connect("finished", self, "_on_AudioStreamPlayer2D_finished")

func _on_AudioStreamPlayer2D_finished():
    if ending:
        get_tree().paused = false
        get_tree().call_deferred("change_scene", "res://scenes/menu.tscn")
