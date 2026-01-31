class_name spell_lob extends CharacterBody2D

var direction : Vector2
const SPEED = 1000


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
			print("Collided with: ", collision.get_collider().name)
			if collision.get_collider().name == "Solid walls":
					queue_free()
			if collision.get_collider().name == "Permiable Floors":
					queue_free()
			if collision.get_collider().name == "Player":
					queue_free()
