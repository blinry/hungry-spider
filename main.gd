extends Spatial

onready var camera = $Camera

var legs = []

var maxd = 2
var mind = 0.5
var maxrot = PI/4
var radius = 1.3

func _ready():
    var leg = preload("res://leg.tscn")
    for i in range(0,8):
        var l = leg.instance()
        l.target = Vector3(sin(i/8.0*2*PI)*radius, 0, cos(i/8.0*2*PI)*radius)
        l.rotation.y = PI+atan2(l.target.x, l.target.z)
        $Spider.add_child(l)
        legs.push_back(l)
    
func _process(delta):
    var plane = Plane(Vector3(0, 1, 0), 0.4)
    var mouse = get_viewport().get_mouse_position()
    var pos = plane.intersects_ray(camera.project_ray_origin(mouse), camera.project_ray_normal(mouse))
    
    if pos:
        $Spider.translation = lerp($Spider.translation, pos, 0.3)
    
    for i in range(legs.size()):
        var l = legs[i]
        if l.distance() > maxd or l.distance() < mind or abs(l.rot()) > maxrot:
            var new_target = Vector3($Spider.translation.x+sin(i/8.0*2*PI)*radius, 0, $Spider.translation.z+cos(i/8.0*2*PI)*radius)
            #$Tween.interpolate_property(l, "target", l.target, , 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
            l.target = new_target
