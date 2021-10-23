extends KinematicBody2D

export (int) var speed = 500

export (String) var left = "left"
export (String) var right = "right"
export (String) var up = "up"
export (String) var down = "down"

export (NodePath) var torchPath
onready var torch = get_node(torchPath)

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

func _physics_process(_delta):
    var direction = get_input_direction()

    if direction != Vector2(0, 0):
        var angle = atan2(-direction.y, direction.x)
        torch.rotation = -angle

        var facing = Compass.get_facing(angle)
        sprite.animation = animations[facing]

    var velocity = get_input_direction() * speed
    velocity = move_and_slide(velocity)

    if velocity != Vector2(0, 0):
        sprite.playing = true
        sprite.speed_scale = velocity.length() / speed
    else:
        sprite.playing = false
        sprite.frame = 0
