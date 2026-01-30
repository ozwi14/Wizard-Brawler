extends Sprite2D

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body
	scale = Vector2(2,2) #scale of object for testing



#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#points toward last direction pushed
	if Vector2(Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")*50) != Vector2(0, 0):
		position = lerp(position,Vector2(Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down").normalized()*50),.3)
		look_at($"..".position)
		rotation_degrees += -90
	pass
