class_name Compass

enum {LEFT, RIGHT, UP, DOWN}

static func get_facing(angle, prefer = null):
    angle = fposmod(angle, PI * 2)

    if (
        is_equal_approx(angle, PI / 4) && (prefer == RIGHT || prefer == UP)
        || is_equal_approx(angle, PI * 3 / 4) && (prefer == UP || prefer == LEFT)
        || is_equal_approx(angle, PI * 5 / 4) && (prefer == LEFT || prefer == DOWN)
        || is_equal_approx(angle, PI * 7 / 4) && (prefer == DOWN || prefer == RIGHT)
    ):
        return prefer
    elif angle < PI / 4:
        return RIGHT
    elif angle < PI * 3 / 4:
        return UP
    elif angle < PI * 5 / 4:
        return LEFT
    elif angle < PI * 7 / 4:
        return DOWN
    else:
        return RIGHT

static func get_facing_horizontal(angle, prefer = null):
    angle = fposmod(angle, PI * 2)

    if (
        (is_equal_approx(angle, PI / 2) || is_equal_approx(angle, PI * 3 / 2))
        && (prefer == LEFT || prefer == RIGHT)
    ):
        return prefer
    if angle < PI / 2:
        return RIGHT
    elif angle < PI * 3 / 2:
        return LEFT
    else:
        return RIGHT
