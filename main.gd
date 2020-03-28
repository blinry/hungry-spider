extends Spatial

onready var camera = $Camera

func _ready():
    var leg = preload("res://leg.tscn")
    for i in range(1,8):
        var l = leg.instance()
        l.target = Vector3(sin(i/8.0*2*PI), 0, cos(i/8.0*2*PI))
        $Spider.add_child(l)
    
func _process(delta):
    var plane = Plane(Vector3(0, 0, 1), 0)
    var mouse = get_viewport().get_mouse_position()
    var pos = plane.intersects_ray(camera.project_ray_origin(mouse), camera.project_ray_normal(mouse))
    $Spider.translation = pos
