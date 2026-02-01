class_name Player extends CharacterBody2D

@export var GROUND_ACC = 200
@export var AIR_ACC = 25
@export var AIR_FRICTION = 10
@export var GROUND_FRICTION = 70
@export var MAX_WALKSPEED = 600
@export var JUMP_VELOCITY = 1000

@export var max_jumps : int = 2

var _jumps_remaining : int

@onready var player_spell_spawner = $"Arrow/Player Spell Spawner"
@export var direction : Vector2 = Vector2.RIGHT

var FIRE_ANGLE : Vector2
var end_pos : Vector2 = Vector2(150, 150)
var line_color : Color = Color.BLACK
var line_thickness : float = 30.0

@export var player_data : PlayerData

var direction_last_pointed : Vector2 = Vector2.RIGHT

func _ready() -> void:
	print("Player %d exists", player_data.player_id)
	print("Player at: ", position)
	#set players controls
	_jumps_remaining = max_jumps
	pass

var holding_jump: bool = false

func _player_jump() -> void:
	# Handle jump.
	if is_on_floor():
		_jumps_remaining = max_jumps

	if Input.is_joy_button_pressed(player_data.device_id, JOY_BUTTON_A) : 
		var JUMP_DIR = _player_get_movement_input()
		JUMP_DIR.y = -1
		
		if is_on_floor():
			velocity.y = JUMP_DIR.y * JUMP_VELOCITY
			velocity.x += JUMP_DIR.x * JUMP_VELOCITY*.3
			holding_jump = true
			_jumps_remaining -= 1
			# if were on the floor reset our ability to double jump
		elif not holding_jump and _jumps_remaining > 0:
			velocity.y = JUMP_DIR.y * JUMP_VELOCITY
			velocity.x += JUMP_DIR.x * JUMP_VELOCITY*.3
			holding_jump = true
			_jumps_remaining -= 1
	else:
		holding_jump = false

func _player_get_movement_input() -> Vector2:
	var input_dir = Vector2(
		Input.get_joy_axis(player_data.device_id,JOY_AXIS_LEFT_X),
		Input.get_joy_axis(player_data.device_id,JOY_AXIS_LEFT_Y)
		)
	return input_dir

var was_x_pressed = false
var was_b_pressed = false
var was_y_pressed = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	#Do jump
	_player_jump()
	if Input.is_joy_button_pressed(player_data.device_id, JOY_BUTTON_X):
		if not was_x_pressed:
			was_x_pressed = true
			if Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down") != Vector2(0,0):
				var dir = Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")
				player_spell_spawner.spawn_children(player_data.spells[0],dir)
	else:
		was_x_pressed = false
	if Input.is_joy_button_pressed(player_data.device_id, JOY_BUTTON_B):
		if not was_b_pressed:
			was_b_pressed = true
			if Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down") != Vector2(0,0):
				var dir = Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")
				player_spell_spawner.spawn_children(player_data.spells[1],dir)
	else:
		was_b_pressed = false
	if Input.is_joy_button_pressed(player_data.device_id, JOY_BUTTON_Y):
		if not was_y_pressed:
			was_y_pressed = true
			if Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down") != Vector2(0,0):
				var dir = Input.get_vector("p1 left", "p1 right", "p1 up", "p1 down")
				player_spell_spawner.spawn_children(player_data.spells[2],dir)
	else:
		was_y_pressed = false
	
	#get player inputs
	var input_direction : Vector2
	var CUR_FRICTION = GROUND_FRICTION
	var CUR_ACC = GROUND_ACC
	input_direction = _player_get_movement_input()
	
	direction_last_pointed = input_direction
	
	#try to move horizontally based on if you are flying or on ground
	if input_direction : 
		#set our accleeration and friction based on if we are in the air or ground
		if is_on_floor():
			CUR_FRICTION = GROUND_FRICTION
			CUR_ACC = GROUND_ACC
		else:
			CUR_FRICTION = AIR_FRICTION
			CUR_ACC = AIR_ACC
	#add velocity based on character inputs
		if velocity.x + input_direction.x * CUR_ACC < MAX_WALKSPEED and velocity.x + input_direction.x * CUR_ACC > -MAX_WALKSPEED: 
			velocity.x +=  input_direction.x * CUR_ACC
		
		#do friction in horizontal direction
	var horizontal_velocity = Vector2(velocity.x,0)
	if horizontal_velocity.length() >0 :
		velocity.x = move_toward(velocity.x,0,CUR_FRICTION)
		
	
	#Determing the direction the player is intending to travle and fire
	FIRE_ANGLE = input_direction*1000
	#print(FIRE_ANGLE)
	
	move_and_slide()
	#queue_redraw()
	
	
	
	
#func _draw():
	#draw_line(Vector2(0,0),FIRE_ANGLE,line_color,line_thickness)
	
	
