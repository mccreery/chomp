extends Character

var max_health = 4

var health = 4 setget set_health

func set_health(value):
    health = clamp(value, 0, max_health)
    if value <= 0:
        die()

var game_over_sound = preload("res://sfx/game_over.wav")

func get_input_direction():
    return Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    ).clamped(1)

func _process(_delta):
    walk_direction = get_input_direction()

func die():
    set_process(false)
    if !$AudioStreamPlayer2D.is_playing():
        $AudioStreamPlayer2D.stream = game_over_sound
        $AudioStreamPlayer2D.play()

func _on_AudioStreamPlayer2D_finished():
    get_tree().call_deferred("change_scene", "res://scenes/menu.tscn")
