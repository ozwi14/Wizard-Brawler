extends Node2D

var old_position = get_global_position().x
var older_position = get_global_position().x
var olderer_position = get_global_position().x
var oldest_position = get_global_position().x




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$AnimationPlayer.play("Idle")
	
	pass
func _animation_player(movement_speed: float) ->void:
	
	var min_speed = 1
	if movement_speed > 5:
		scale.x = -1
	elif movement_speed < -5:
		scale.x = 1
	
	if abs(movement_speed) < min_speed : 
		$AnimationPlayer.play("Idle")
	elif abs(movement_speed)  > min_speed:
		$AnimationPlayer.play("Forward")
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	_animation_player(oldest_position-get_global_position().x)
	oldest_position = olderer_position
	olderer_position = older_position
	older_position = old_position
	old_position = get_global_position().x

	
