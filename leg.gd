extends Spatial

var l = 1 # limb length

export var target = Vector3(0, 0, 0)

func _ready():
    pass

func _process(delta):
    $Pivot.look_at(target, Vector3(0, 1, 0))
    var d = (target - get_global_transform().origin).length()
    var alpha = 0
    if d <= 2*l:
        alpha = acos(d/(2*l))
    $Pivot/UpperLeg.rotation = Vector3(-alpha, PI, 0)
    $Pivot/UpperLeg/LowerLeg.rotation = Vector3(2*alpha, 0, 0)
