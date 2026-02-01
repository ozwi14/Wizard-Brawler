extends Node2D
@export var child_spell : PackedScene
var direction : Vector2
var spell_spawners : Array[spell_spawner] = []
var chain_list : Array[SpellItemData]
var player_id : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_children():
		if child is spell_spawner:
			spell_spawners.append(child)
	var parent = get_parent()
	player_id = parent.player_id
	chain_list = parent.chain_list
	if parent.has_signal("collision_wall"):
		parent.collision_wall.connect(_on_collison_wall)
	chain_list = parent.chain_list

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_collison_wall() -> void:
	if chain_list.size()>0 :
		for i in spell_spawners:
			var dir = i.global_transform.x
			#print("im a peice with", chain_list[0])
			var tobespawned = chain_list[0].scene
			var local_chain_list := chain_list.duplicate()
			local_chain_list.remove_at(0)
			i.spawn_children(tobespawned,dir,local_chain_list,player_id)
	get_parent().queue_free()
