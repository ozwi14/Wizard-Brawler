extends CharacterBody2D

var SPEED : float
var JUMP_VELOCITY : float


func _ready() -> void:
	SPEED = get_parent().SPEED
	JUMP_VELOCITY = get_parent().JUMP_VELOCITY




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p2 jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
		print("p2 Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("p2 left", "p2 right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
