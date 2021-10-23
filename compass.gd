class_name Compass

enum {LEFT, RIGHT, UP, DOWN}

static func get_facing(angle):
    angle = fposmod(angle, PI * 2)

    if angle < PI / 4:
        return RIGHT
    elif angle < PI * 3 / 4:
        return UP
    elif angle < PI * 5 / 4:
        return LEFT
    elif angle < PI * 7 / 4:
        return DOWN
    else:
        return RIGHT
