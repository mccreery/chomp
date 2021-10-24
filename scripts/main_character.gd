extends Character

var max_health = 4
var health = 4
var game_over_sound = preload("res://sfx/game_over.wav")

func get_input_direction():
    return Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    ).clamped(1)

func _process(_delta):
    walk_direction = get_input_direction()
    if health < 1:
        die()

func wait_for_sound(play_time):
    var t = Timer.new()
    t.set_wait_time(play_time)
    t.set_one_shot(true)
    self.add_child(t)
    t.start()
    yield(t, "timeout")
    t.queue_free()

func die():
    set_process(false)
    if !$AudioStreamPlayer2D.is_playing():
        $AudioStreamPlayer2D.stream = game_over_sound
        $AudioStreamPlayer2D.play()
        var play_time = $AudioStreamPlayer2D.stream.get_length()
        wait_for_sound(play_time)
        get_tree().change_scene("res://scenes/menu.tscn")
