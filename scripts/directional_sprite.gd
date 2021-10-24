extends AnimatedSprite

export (String) var left = "left"
export (String) var right = "right"
export (String) var up = "up"
export (String) var down = "down"

export var horizontal = false

onready var animations = {
    Compass.LEFT: left,
    Compass.RIGHT: right,
    Compass.UP: up,
    Compass.DOWN: down
}

var facing = Compass.RIGHT
func update_angle(angle):
    if horizontal:
        facing = Compass.get_facing_horizontal(angle, facing)
    else:
        facing = Compass.get_facing(angle, facing)

    var facing_animation = animations[facing]
    if frames.has_animation(facing_animation):
        animation = facing_animation

func update_velocity(velocity, max_speed):
    if velocity != Vector2(0, 0):
        playing = true
        speed_scale = velocity.length() / max_speed
    else:
        playing = false
        frame = 0
