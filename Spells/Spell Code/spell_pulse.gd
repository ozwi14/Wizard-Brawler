class_name spell_pulse extends CharacterBody2D

var direction : Vector2
const SPEED = 0
var chain_list : Array[PackedScene]
var player_id : int

@export var min_scale := Vector2.ONE
@export var max_scale := Vector2(5, 5)
@export var duration := 0.4

#func _init(dir : Vector2) -> void:
	#direction = dir

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops() # infinite loop
	tween.tween_property(self, "scale", max_scale, duration)
	tween.tween_property(self, "scale", min_scale, duration)
	direction = direction.normalized()

func _physics_process(delta: float) -> void:
#	velocity = transform.x * SPEED
	rotation = velocity.angle()
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.get_collider().name)
			var col = collision.get_collider()
			if col.has_method("_player_jump"):
				var player: Player = col
				if player_id != player.player_data.player_id:
					player.queue_free()
