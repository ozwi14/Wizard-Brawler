class_name SpellSpawner extends Node2D

@export var child_spell : PackedScene
@export var direction_component : BaseGetDirection
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready")
	#call_deferred("spawn_children")
	
	
func spawn_children(child_spell: PackedScene):
	var direction = direction_component.getDirection()
	
	var subspell = child_spell.instantiate()
	
	subspell.direction = direction
	subspell.global_position = global_position
	subspell.top_level = true
	#subspell.global_rotation = global_rotation
	
	get_parent().add_child(subspell)
