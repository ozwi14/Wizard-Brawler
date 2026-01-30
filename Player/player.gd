extends CharacterBody2D

var SPEED : float
var JUMP_VELOCITY : float
var CAN_DOUBLEJUMP = 0

func _ready() -> void:
	SPEED = get_parent().SPEED
	JUMP_VELOCITY = get_parent().JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif CAN_DOUBLEJUMP == 0 :
		CAN_DOUBLEJUMP = 1

	# Handle jump.
	if Input.is_action_just_pressed("p1 jump") :
		if is_on_floor():
			velocity.y = -JUMP_VELOCITY
		elif CAN_DOUBLEJUMP == 1:
			velocity.y = -JUMP_VELOCITY
			CAN_DOUBLEJUMP = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("p1 left", "p1 right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
