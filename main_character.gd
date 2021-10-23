extends KinematicBody2D
const Compass = preload("compass.gd")

export (int) var speed = 500

export (String) var left = "left"
export (String) var right = "right"
export (String) var up = "up"
export (String) var down = "down"

onready var animations = {
    Compass.LEFT: left,
    Compass.RIGHT: right,
    Compass.UP: up,
    Compass.DOWN: down
}

onready var sprite = $AnimatedSprite

func get_input_direction():
    return Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    ).clamped(1)

func update_sprite(velocity):
    if velocity != Vector2(0, 0):
        var direction = Compass.get_direction(atan2(-velocity.y, velocity.x))
        sprite.play(animations[direction])
    else:
        sprite.stop()

func _physics_process(_delta):
    var velocity = get_input_direction() * speed
    velocity = move_and_slide(velocity)
    update_sprite(velocity)
