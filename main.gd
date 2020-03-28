extends Spatial

onready var camera = $Camera

var internal_height = 0.3
#var height = 0.3
var acc = 0

var person = preload("res://person.tscn")

func _ready():
    var leg = preload("res://leg.tscn")
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
    for i in range(0, 50):
        var p = person.instance()
        p.translation = Vector3(rand_range(-5, 5), 0, rand_range(-5, 5))
        add_child(p)
    
func _process(delta):
    var plane = Plane(Vector3(0, 1, 0), 0.4)
    var mouse = get_viewport().get_mouse_position()
    var pos = plane.intersects_ray(camera.project_ray_origin(mouse), camera.project_ray_normal(mouse))
    
    #internal_height = 0.5
    
    var lerpval = 0.3
    if Input.is_action_just_released("lower"):
        acc = 25
        
    #internal_height = lerp(internal_height, height, 0.8)
    
    internal_height += acc*delta
    acc -= 100*delta
        
    if internal_height < 0.3:
        internal_height = 0.3
    
    if Input.is_action_pressed("lower"):
        internal_height = 0.1
        #lerpval = 0.05
        
    if pos:
        pos.y = internal_height
        $Spider.translation = lerp($Spider.translation, pos, lerpval)
        
    for p in get_tree().get_nodes_in_group("person"):
        var d = (p.translation - $Spider.translation)
        d.y = 0
        var dir = d.normalized()
        if d.length() < 3:
            p.translation += delta*d
#    var dir = ($Spider2.translation - $Spider.translation).normalized()
#    dir.y = 0
#    var speed = 200
#
#    if $Spider2.translation.distance_to($Spider.translation) < 5:
#        $Spider2.translation = lerp($Spider2.translation, $Spider2.translation+delta*dir*speed, 0.05)
#    #if $Spider2.translation.distance_to($Spider.translation) > 3:
#    #    $Spider2.translation = lerp($Spider2.translation, $Spider2.translation-delta*dir*speed, 0.05)
#
#    $Spider2.look_at($Spider.translation, Vector3(0,1,0))
