extends Character
class_name MainCharacter

var max_health = 3
var health = 1 setget set_health

var eaten = 0 setget set_eaten
export var food_needed = 4

func set_eaten(value):
    eaten = value
    if eaten >= food_needed:
        win()

var light_exposure = 0 setget set_light_exposure
signal light_changed(light_exposure)

export var light_recover_rate = 0.1

func set_light_exposure(value):
    value = max(0, value)
    self.health -= int(value)
    light_exposure = value - int(value)
    emit_signal("light_changed", value)

func _ready():
    connect("light_changed", self, "update_meter")

func update_meter(light_exposure):
    $CanvasLayer/Control/TextureRect/TextureProgress.value = light_exposure

func play_sfx(stream):
    $AudioStreamPlayer2D.stream = stream
    $AudioStreamPlayer2D.play()

func set_health(value):
    health = clamp(value, 0, max_health)
    $AnimatedSprite.left = "left" + str(health)
    $AnimatedSprite.right = "right" + str(health)
    $AnimatedSprite.update_sprite()

    speed = range_lerp(health, 1, max_health, 70, 30)

    if value <= 0:
        die()

var game_over_sound = preload("res://sfx/game_over.wav")
var eat_sound = preload("res://sfx/chomp.wav")
var win_sound = preload("res://sfx/ded.wav")

func get_input_direction():
    return Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    ).clamped(1)

func _process(delta):
    walk_direction = get_input_direction()

    if Input.is_action_just_pressed("interact") and close_enemy != null:
        close_enemy.queue_free()
        play_sfx(eat_sound)
        self.health += 1
        self.eaten += 1

    self.light_exposure -= delta * light_recover_rate

func win():
    $CanvasLayer/Control/Label.text = "You are full... you win!"
    $AudioStreamPlayer2D.ending = true
    get_tree().paused = true
    play_sfx(win_sound)

func die():
    $CanvasLayer/Control/Label.text = "Game Over..."
    $AudioStreamPlayer2D.ending = true
    get_tree().paused = true
    play_sfx(game_over_sound)

var close_enemy = null
func _on_range_trigger_body_entered(body):
    if body is Enemy && close_enemy == null:
        close_enemy = body

func _on_range_trigger_body_exited(body):
    if body == close_enemy:
        close_enemy = null
