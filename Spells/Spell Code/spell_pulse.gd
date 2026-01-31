class_name spell_pulse extends CharacterBody2D

var direction : Vector2
const SPEED = 0

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
			if collision.get_collider().name == "Player":
					print("woob")
