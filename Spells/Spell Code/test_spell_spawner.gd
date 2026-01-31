extends Node2D

@export var child_spell : PackedScene
@export var direction : Vector2 = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready")
	call_deferred("spawn_children")
	
	
func spawn_children():
	if Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down") != Vector2(0,0):
		var dir = Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")
		if child_spell == null or dir == Vector2(0,0):
			return
		direction = dir
	
	var subspell = child_spell.instantiate()
	
	subspell.direction = direction
	subspell.global_position = global_position
	subspell.top_level = true
	#subspell.global_rotation = global_rotation
	
	get_parent().add_child(subspell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spawn() -> void:
	print("im spawning from spawn")
	spawn_children()

func _on_timer_timeout() -> void:
	print("im spawning on a timer")
	spawn_children()
