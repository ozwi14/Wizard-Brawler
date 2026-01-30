extends Node2D

@export var child_spell : PackedScene
@export var direction : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("spawn_children")
	
	
func spawn_children():
	if child_spell == null :
		return
	var subspell = child_spell.instantiate()
	subspell.global_position = global_position
	subspell.global_rotation = global_rotation
	get_parent().add_child(subspell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_timer_timeout() -> void:
	print("im spawning")
	spawn_children()
