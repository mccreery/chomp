extends KinematicBody2D

export (int) var speed = 500

func get_input_direction():
    return Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    ).clamped(1)

func _physics_process(_delta):
    var velocity = get_input_direction() * speed
    velocity = move_and_slide(velocity)
