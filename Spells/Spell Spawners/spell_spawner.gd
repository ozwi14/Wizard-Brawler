class_name spell_spawner extends Node2D

var child_spell : PackedScene
@export var direction : Vector2 = Vector2.RIGHT
var chain_list : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#call_deferred("spawn_children")

	
	
func spawn_children(child_spell: PackedScene,dir : Vector2,chain_list : Array[SpellItemData],player_id :int):
	var subspell = child_spell.instantiate()
	subspell.direction = dir
	subspell.global_position = global_position
	subspell.chain_list = chain_list
	subspell.player_id = player_id
	subspell.top_level = true
	
	get_tree().current_scene.add_child(subspell)
	
	#subspell.global_rotation = global_rotation
	
	#get_parent().add_child(subspell)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
