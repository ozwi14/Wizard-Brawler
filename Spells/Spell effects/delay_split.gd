extends Node2D
@export var child_spell : PackedScene
var direction : Vector2

@export var timer : Timer
@export var spell_spawners : Array[Spell_spawner] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if child_spell != null :
		for i in spell_spawners:
			var dir = i.global_transform.x
			i.spawn_children(child_spell,dir)
	get_parent().queue_free()
