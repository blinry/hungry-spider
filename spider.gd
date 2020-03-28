extends Spatial

var maxd = 2
var mind = 0.5
var maxrot = PI/4
var radius = 1.3

var leg = preload("res://leg.tscn")
var legs = []

func _ready():
    for i in range(0,8):
        var l = leg.instance()
        l.target = Vector3(sin(i/8.0*2*PI)*radius, 0, cos(i/8.0*2*PI)*radius)
        l.rotation.y = PI+atan2(l.target.x, l.target.z)
        var r2 = 0.35
        l.translation = Vector3(sin(i/8.0*2*PI)*r2, 0, cos(i/8.0*2*PI)*r2)
        add_child(l)
        legs.push_back(l)

func _process(delta):
    for i in range(legs.size()):
        var l = legs[i]
        if l.distance() > maxd or l.distance() < mind or abs(l.rot()) > maxrot or randi() % 200 == 0:
            var new_target = Vector3(translation.x+sin(i/8.0*2*PI)*radius, 0, translation.z+cos(i/8.0*2*PI)*radius)
            #$Tween.interpolate_property(l, "target", l.target, , 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
            l.target = new_target

    $Shadow.translate(Vector3(0,-$Shadow.get_global_transform().origin.y,0))
