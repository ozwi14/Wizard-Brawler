class_name Spell extends CharacterBody2D

var direction : Vector2
const SPEED = 0

#func _init(dir : Vector2) -> void:
	#direction = dir

func _ready() -> void:
	#
	direction = direction.normalized()
	#velocity = direction * SPEED

func _physics_process(delta: float) -> void:
#	velocity = transform.x * SPEED
	rotation = velocity.angle()
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.get_collider().name)
			if collision.get_collider().name == "Player":
					queue_free()
