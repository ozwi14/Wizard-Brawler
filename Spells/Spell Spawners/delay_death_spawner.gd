extends Node2D
@export var child_spell : PackedScene
var direction : Vector2
@export var timer_time := 0.5  # editable in Inspector
var timer : Timer
var spell_spawners : Array[spell_spawner] = []
var chain_list : Array[PackedScene]
var player_id :int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_children():
		if child is spell_spawner:
			spell_spawners.append(child)
	
	var parent = get_parent()
	player_id = parent.player_id
	chain_list = parent.chain_list
	timer = Timer.new()
	timer.wait_time = timer_time
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if child_spell != null :
		for i in spell_spawners:
			var dir = i.global_transform.x
			i.spawn_children(child_spell,dir,chain_list,player_id)
	get_parent().queue_free()
