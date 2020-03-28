extends Spatial

var l = 1 # limb length

export var target = Vector3(0, 0, 0)
var internal_target = Vector3(0, 0, 0)

func _ready():
    pass

func _process(delta):
    internal_target = lerp(internal_target, target, 0.4)
    $Pivot.look_at(internal_target, Vector3(0, 1, 0))
    var d = internal_distance()
    var alpha = 0
    if d <= 2*l:
        alpha = acos(d/(2*l))
    $Pivot/UpperLeg.rotation = Vector3(-alpha, PI, 0)
    $Pivot/UpperLeg/LowerLeg.rotation = Vector3(2*alpha, 0, 0)

func distance():
    return (target - get_global_transform().origin).length()

func internal_distance():
    return (internal_target - get_global_transform().origin).length()

func rot():
    return $Pivot.rotation.y
