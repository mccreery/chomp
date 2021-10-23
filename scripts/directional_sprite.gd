extends AnimatedSprite

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

func update_angle(angle):
    var facing = Compass.get_facing(angle)
    animation = animations[facing]

func update_velocity(velocity, max_speed):
    if velocity != Vector2(0, 0):
        playing = true
        speed_scale = velocity.length() / max_speed
    else:
        playing = false
        frame = 0
