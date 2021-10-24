extends AnimatedSprite

export (String) var left = "left"
export (String) var right = "right"
export (String) var up = "up"
export (String) var down = "down"

export var horizontal = false

func get_direction_animation(facing):
    match facing:
        Compass.LEFT: return left
        Compass.RIGHT: return right
        Compass.UP: return up
        Compass.DOWN: return down

var facing = Compass.RIGHT
func update_angle(angle):
    if horizontal:
        facing = Compass.get_facing_horizontal(angle, facing)
    else:
        facing = Compass.get_facing(angle, facing)
    update_sprite()

func update_sprite():
    var facing_animation = get_direction_animation(facing)
    if frames.has_animation(facing_animation):
        animation = facing_animation

func update_velocity(velocity, max_speed):
    if velocity != Vector2(0, 0):
        playing = true
        speed_scale = velocity.length() / max_speed
    else:
        playing = false
        frame = 0
