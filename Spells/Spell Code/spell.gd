class_name Spell extends CharacterBody2D

@export var direction : Vector2
const SPEED = 30.0

#func _init(dir : Vector2) -> void:
	#direction = dir

func _ready() -> void:
	#
	velocity = direction * SPEED

func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	move_and_slide()
