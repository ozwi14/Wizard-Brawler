class_name Spell_spawner extends Node2D

@export var child_spell : PackedScene
@export var direction : Vector2 = Vector2.RIGHT
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready")
	#call_deferred("spawn_children")
	
	
func spawn_children(child_spell: PackedScene,dir : Vector2):
	var subspell = child_spell.instantiate()
	subspell.direction = dir
	subspell.global_position = global_position
	subspell.top_level = true
	
	get_tree().current_scene.add_child(subspell)
	
	#subspell.global_rotation = global_rotation
	
	#get_parent().add_child(subspell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
