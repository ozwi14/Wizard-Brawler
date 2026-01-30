extends CharacterBody2D

@export var GROUND_ACC = 200
@export var AIR_ACC = 25
@export var AIR_FRICTION = 10
@export var GROUND_FRICTION = 70
@export var MAX_WALKSPEED = 600
@export var JUMP_VELOCITY = 1000
var CAN_DOUBLEJUMP = 0
var FIRE_ANGLE : Vector2
var end_pos : Vector2 = Vector2(150, 150)
var line_color : Color = Color.BLACK
var line_thickness : float = 30.0

#controls
var key_jump : String
var key_left : String
var key_right : String

func _ready() -> void:
	#set players controls
	key_jump = "p1 jump"
	key_left = "p1 left"
	key_right = "p1 right"

func _player_jump(input) -> void:
		# Handle jump.
	if Input.is_action_just_pressed(input) : 
		var JUMP_DIR = _player_get_movement_input(key_left,key_right)
		JUMP_DIR.y = -1
		if is_on_floor():
			velocity.y = JUMP_DIR.y * JUMP_VELOCITY
			velocity.x += JUMP_DIR.x * JUMP_VELOCITY*.3
			# if were on the floor reset our ability to double jump
			if CAN_DOUBLEJUMP != 1 : 
				CAN_DOUBLEJUMP = 1
		elif CAN_DOUBLEJUMP == 1:
			velocity.y = JUMP_DIR.y * JUMP_VELOCITY
			velocity.x += JUMP_DIR.x * JUMP_VELOCITY*.3
			CAN_DOUBLEJUMP = 0

func _player_get_movement_input(key_left,key_right) -> Vector2:
	var input_dir = Vector2(Input.get_axis(key_left,key_right),0)
	return input_dir

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#Do jump
	_player_jump(key_jump) 
	
	#get player inputs
	var input_direction : Vector2
	var CUR_FRICTION = GROUND_FRICTION
	var CUR_ACC = GROUND_ACC
	input_direction = _player_get_movement_input(key_left, key_right)
	
	#try to move horizontally based on if you are flying or on ground
	if input_direction : 
		#set our accleeration and friction based on if we are in the air or ground
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
		
	#Determing the direction the player is intending to travle and fire
	FIRE_ANGLE = Vector2(Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")*1000)
	#print(FIRE_ANGLE)
	
	move_and_slide()
	queue_redraw()
	
	
	
	
#func _draw():
	draw_line(Vector2(0,0),FIRE_ANGLE,line_color,line_thickness)
	
	
