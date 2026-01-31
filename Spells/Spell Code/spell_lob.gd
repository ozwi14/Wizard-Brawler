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
	move_and_slide()
