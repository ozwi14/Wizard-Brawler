class_name spell_bolt extends CharacterBody2D

var direction : Vector2
const SPEED = 300
var chain_list : Array[SpellItemData]
signal collision_wall
var player_id : int

#func _init(dir : Vector2) -> void:
	#direction = dir

func _ready() -> void:
	direction = direction.normalized()
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
#	velocity = transform.x * SPEED
	rotation = velocity.angle()
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.get_collider().name)
			var col = collision.get_collider()
			if col.name == "Solid walls":
				emit_signal("collision_wall")
			if col.name == "Permiable Floors":
				emit_signal("collision_wall")
			if col.has_method("_player_jump"):
				var player: Player = col
				if player_id != player.player_data.player_id:
					GameManager.playerDied.emit()
					player.queue_free()
				
