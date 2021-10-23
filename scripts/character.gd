extends KinematicBody2D
class_name Character

signal angle(angle)
signal velocity(velocity, max_speed)

export (int) var speed = 100

var walk_direction: Vector2 = Vector2(0, 0) setget set_walk_direction

func set_walk_direction(value):
    walk_direction = value.clamped(1)

func _physics_process(_delta):
    if walk_direction != Vector2(0, 0):
        var angle = atan2(-walk_direction.y, walk_direction.x)
        emit_signal("angle", angle)

    var velocity = walk_direction * speed
    velocity = move_and_slide(velocity)
    emit_signal("velocity", velocity, speed)
