extends Node2D

func _process(delta):
    if hurt_character != null:
        var distance = global_position.distance_to(hurt_character.global_position)
        var strength = range_lerp(distance, 0, max_distance, light_strength, 0)
        if strength > 0:
            hurt_character.light_exposure += strength * delta

func has_line_of_sight(node):
    var space_state = get_world_2d().direct_space_state
    var collision = space_state.intersect_ray(global_position, node.global_position)
    return collision.empty()

export var light_strength = 1.0
export var max_distance = 96.0

var hurt_character = null

func _on_Area2D_body_entered(body):
    print(body.name == "main_character")
    print(hurt_character == null)
    print(has_line_of_sight(body))

    if body.name == "main_character":# && hurt_character == null:# && has_line_of_sight(body):
        hurt_character = body

func _on_Area2D_body_exited(body):
    if hurt_character == body:
        hurt_character = null
