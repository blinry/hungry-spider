extends Spatial

func _ready():
    pass


func _on_collision(area):
    queue_free()
