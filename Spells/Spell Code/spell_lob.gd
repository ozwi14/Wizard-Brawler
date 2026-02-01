class_name spell_lob extends CharacterBody2D

var direction : Vector2
const SPEED = 1000
var chain_list : Array[SpellItemData]
signal collision_wall
var player_id : int


#func _init(dir : Vector2) -> void:
#	direction = dir

func _ready() -> void:
	#
	#velocity = transform.x * SPEED
	#position = Vector2(10,400)
	
	velocity = direction * SPEED
	position = position
	
	
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	velocity.x -= velocity.x*.015
	rotation = velocity.angle()
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var col = collision.get_collider()
			if col.name == "Solid walls":
				emit_signal("collision_wall")
			if col.name == "Permiable Floors":
				emit_signal("collision_wall")
			if col.has_method("_player_jump"):
				var player: Player = col
				if player_id != player.player_data.player_id:
					player.queue_free()
				
