extends KinematicBody2D

export (NodePath) var nav
export (NodePath) var target

export var speed : = 200.0
var path : = PoolVector2Array() setget set_path

func _physics_process(_delta):
    if !path.empty():
        move_along_path(speed)

func _ready() -> void:
    path = get_node(nav).get_simple_path(global_position, get_node(target).global_position, false)
    $"../Line2D".points = path

const EPS := 4
func move_along_path(speed : float) -> void:
    var ab = path[0] - position

    if ab.length_squared() < EPS * EPS:
        path.remove(0)

    var velocity = ab.normalized() * speed
    velocity = move_and_slide(velocity)

func set_path(value : PoolVector2Array) -> void:
    path = value
    path.remove(0)
