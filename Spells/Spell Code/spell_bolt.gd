class_name Spell extends CharacterBody2D

var direction : Vector2
const SPEED = 300.0

#func _init(dir : Vector2) -> void:
	#direction = dir

func _ready() -> void:
	#
	direction = direction.normalized()
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
#	velocity = transform.x * SPEED
	rotation = velocity.angle()
	move_and_slide()
