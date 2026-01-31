class_name spell_totem extends CharacterBody2D

var direction : Vector2
const SPEED = 200

#func _init(dir : Vector2) -> void:
#	direction = dir

func _ready() -> void:
	#
	#velocity = transform.x * SPEED
	# Need to add the players momentum to this so it kinda come out more like a bomb
	velocity = direction * SPEED
	
	
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	velocity.x -= velocity.x*.01
	rotation = velocity.angle() - 33
	if move_and_slide():
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.get_collider().name)
			if collision.get_collider().name == "Solid walls":
					queue_free()
			if collision.get_collider().name == "Permiable Floors":
					queue_free()
			if collision.get_collider().name == "Player":
					queue_free()
