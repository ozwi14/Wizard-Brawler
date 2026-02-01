class_name UpgradeSpellSlot extends Control

var player_1_selected: bool = false
var player_2_selected: bool = false
var player_3_selected: bool = false
var player_4_selected: bool = false

@onready var player_color_1: ColorRect = $"HBoxContainer/Player Color 1"
@onready var player_color_2: ColorRect = $"HBoxContainer/Player Color 2"
@onready var player_color_3: ColorRect = $"HBoxContainer/Player Color 3"
@onready var player_color_4: ColorRect = $"HBoxContainer/Player Color 4"

func _ready() -> void:
	player_color_1.color.a = 0
	player_color_2.color.a = 0
	player_color_3.color.a = 0
	player_color_4.color.a = 0

func _process(_delta: float) -> void:
	if player_1_selected:
		player_color_1.color.a = 1
	else:
		player_color_1.color.a = 0
	if player_2_selected:
		player_color_2.color.a = 1
	else:
		player_color_2.color.a = 0
	if player_3_selected:
		player_color_3.color.a = 1
	else:
		player_color_3.color.a = 0
	if player_4_selected:
		player_color_4.color.a = 1
	else:
		player_color_4.color.a = 0
