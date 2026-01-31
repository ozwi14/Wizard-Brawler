class_name Arrow extends Sprite2D

@export var direction_component: BaseGetDirection

#Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body
	scale = Vector2(2,2) #scale of object for testing

#Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#points toward last direction pushed
	var direction = direction_component.getDirection()
	
	if direction != Vector2(0, 0):
		position = lerp(position,Vector2(direction.normalized()*50),.3)
		look_at(-direction)
		rotation_degrees += -90
	pass
