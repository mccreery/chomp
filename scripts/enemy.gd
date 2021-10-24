extends Character
class_name Enemy

const EPS = 2

export (NodePath) var _nav
onready var nav: Navigation2D = get_node(_nav)

export (NodePath) var _patrol_route
onready var patrol_route: Polygon2D = get_node(_patrol_route)

var patrol_index = 0

var point_of_interest: Vector2
var chase_target: Node2D

export var wait_at_post = 3

enum Activity {
    # Walk through a defined path
    PATROL,
    # Look around for the source of a sound
    INVESTIGATE,
    # Attempt to catch the monster
    CHASE,
    # Run around randomly alerting friends for a while
    PANIC
}
var activity = Activity.PATROL setget set_activity

func set_activity(value):
    activity = value
    match value:
        Activity.PATROL:
            set_path(nav.get_simple_path(global_position, patrol_route.polygon[patrol_index], false))

func _on_path_finished():
    patrol_index = (patrol_index + 1) % patrol_route.polygon.size()
    set_activity(activity)

func _ready():
    connect("path_finished", self, "_on_path_finished")

export (NodePath) var torch
func update_torch(angle):
    get_node(torch).rotation = -angle

var path : = PoolVector2Array() setget set_path

var line
func set_path(value : PoolVector2Array) -> void:
    path = value
    path.remove(0)

    if line == null:
        line = Line2D.new()
        line.width = 1
        get_tree().get_root().add_child(line)
    line.points = value

signal path_finished

func _physics_process(_delta):
    if path.empty():
        walk_direction = Vector2(0, 0)
        set_physics_process(false)
        yield(get_tree().create_timer(wait_at_post), "timeout")
        emit_signal("path_finished")
        set_physics_process(true)
    else:
        var ab = path[0] - position
        if ab.length_squared() < EPS * EPS:
            path.remove(0)

        walk_direction = ab.normalized()
