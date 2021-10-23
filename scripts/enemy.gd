extends Character

const EPS = 4

export (NodePath) var nav
export (NodePath) var target

export (NodePath) var torch
func update_torch(angle):
    get_node(torch).rotation = -angle

var path : = PoolVector2Array() setget set_path

func set_path(value : PoolVector2Array) -> void:
    path = value
    path.remove(0)

func _physics_process(_delta):
    if path.empty():
        walk_direction = Vector2(0, 0)
    else:
        var ab = path[0] - position
        if ab.length_squared() < EPS * EPS:
            path.remove(0)

        walk_direction = ab.normalized()

func _ready() -> void:
    path = get_node(nav).get_simple_path(global_position, get_node(target).global_position, false)
