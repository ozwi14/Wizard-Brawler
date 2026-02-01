class_name SpellChainSelectionBox extends Control

var player_data : PlayerData

var enabled : bool = false

@export var chain_user_selected : SpellItemData

var selected_level : int = 0

var upgradeSpellSlots : Array[UpgradeSpellSlot]

@onready var top_first_chain_colour_box: ColorRect = $"VBoxContainer/Top Spell Chain Box/First Chain Colour Box"
@onready var top_first_chain_box: TextureRect = $"VBoxContainer/Top Spell Chain Box/First Chain Colour Box/First Chain Box"
@onready var top_second_chain_colour_box: ColorRect = $"VBoxContainer/Top Spell Chain Box/Second Chain Colour Box"
@onready var top_second_chain_box: TextureRect = $"VBoxContainer/Top Spell Chain Box/Second Chain Colour Box/Second Chain Box"

@onready var middle_first_chain_colour_box: ColorRect = $"VBoxContainer/Middle Spell Chain Box/First Chain Colour Box"
@onready var middle_first_chain_box: TextureRect = $"VBoxContainer/Middle Spell Chain Box/First Chain Colour Box/First Chain Box"
@onready var middle_second_chain_colour_box: ColorRect = $"VBoxContainer/Middle Spell Chain Box/Second Chain Colour Box"
@onready var middle_second_chain_box: TextureRect = $"VBoxContainer/Middle Spell Chain Box/Second Chain Colour Box/Second Chain Box"

@onready var bottom_first_chain_colour_box: ColorRect = $"VBoxContainer/Bottom Spell Chain Box/First Chain Colour Box"
@onready var bottom_first_chain_box: TextureRect = $"VBoxContainer/Bottom Spell Chain Box/First Chain Colour Box/First Chain Box"
@onready var bottom_second_chain_colour_box: ColorRect = $"VBoxContainer/Bottom Spell Chain Box/Second Chain Colour Box"
@onready var bottom_second_chain_box: TextureRect = $"VBoxContainer/Bottom Spell Chain Box/Second Chain Colour Box/Second Chain Box"

@onready var spell_box_top: TextureRect = $"VBoxContainer/Top Spell Chain Box/Spell Box"
@onready var spell_box_middle: TextureRect = $"VBoxContainer/Middle Spell Chain Box/Spell Box"
@onready var spell_box_bottom: TextureRect = $"VBoxContainer/Bottom Spell Chain Box/Spell Box"

func set_static_images() -> void:
	spell_box_top.texture = player_data.spells[0].icon_top
	spell_box_middle.texture = player_data.spells[1].icon_middle
	spell_box_bottom.texture = player_data.spells[2].icon_bottom

func _input(event: InputEvent) -> void:
	if not enabled:
		return
	if event.device != player_data.device_id:
		return
	
	if event.is_action_pressed("ui_up"):
		move_up()
	if event.is_action_pressed("ui_down"):
		move_down()

func clear_colour() -> void:
	top_first_chain_colour_box.color.a = 0
	top_second_chain_colour_box.color.a = 0
	
	middle_first_chain_colour_box.color.a = 0
	middle_second_chain_colour_box.color.a = 0
	
	bottom_first_chain_colour_box.color.a = 0
	bottom_second_chain_colour_box.color.a = 0

func clear_image() -> void:
	top_first_chain_box.texture = null
	top_second_chain_box.texture = null
	
	middle_first_chain_box.texture = null
	middle_second_chain_box.texture = null
	
	bottom_first_chain_box.texture = null
	bottom_second_chain_box.texture = null

func _can_select_level() -> bool:
	var selected_chain : Array[SpellItemData]
	if selected_level == 0:
		selected_chain = player_data.x_spell_chains
	if selected_level == 1:
		selected_chain = player_data.y_spell_chains
	if selected_level == 2:
		selected_chain = player_data.b_spell_chains
	
	if selected_chain.size() >= 2:
		return false
	return true

func increase_selected_level() -> void:
	selected_level -= 1
	if (selected_level < 0):
		selected_level = 2

func decrease_selected_level() -> void:
	selected_level += 1
	if (selected_level > 2):
		selected_level = 0

func move_up() -> void:
	var tries: int = 0
	while true:
		tries += 1
		if tries > 3:
			return
		
		increase_selected_level()
		if _can_select_level():
			break
	
	update()

func move_down() -> void:
	var tries: int = 0
	while true:
		tries += 1
		if tries > 3:
			return
		
		decrease_selected_level()
		if _can_select_level():
			break
	update()

var held_time_required : float = 0.5
var held_time : float = 0.0

func _process(delta: float) -> void:
	if not enabled:
		return
	
	if Input.is_joy_button_pressed(player_data.device_id, JOY_BUTTON_START):
		held_time += delta
		
		if held_time >= held_time_required:
			enabled = false
			
			var selected_chain : Array[SpellItemData]
			if selected_level == 0:
				selected_chain = player_data.x_spell_chains
			if selected_level == 1:
				selected_chain = player_data.y_spell_chains
			if selected_level == 2:
				selected_chain = player_data.b_spell_chains
			
			selected_chain.append(chain_user_selected)
			
			GameManager.PlayerFinishedUpgrading.emit()
	else:
		held_time = 0

func update():
	clear_colour()
	clear_image()
	highlight_selected()
	
	var array_length: int
	array_length = player_data.x_spell_chains.size()
	if array_length > 0:
		top_first_chain_box.texture = player_data.x_spell_chains[0].icon_top
	if array_length > 1:
		top_second_chain_box.texture = player_data.x_spell_chains[1].icon_top
	
	array_length = player_data.y_spell_chains.size()
	if array_length > 0:
		middle_first_chain_box.texture = player_data.y_spell_chains[0].icon_middle
	if array_length > 1:
		middle_second_chain_box.texture = player_data.y_spell_chains[1].icon_middle
	
	array_length = player_data.b_spell_chains.size()
	if array_length > 0:
		bottom_first_chain_box.texture = player_data.b_spell_chains[0].icon_bottom
	if array_length > 1:
		bottom_second_chain_box.texture = player_data.b_spell_chains[1].icon_bottom
	
	if selected_level == 0:
		array_length = player_data.x_spell_chains.size()
		if array_length == 0:
			top_first_chain_box.texture = chain_user_selected.icon_top
		if array_length == 1:
			top_second_chain_box.texture = chain_user_selected.icon_top
	if selected_level == 1:
		array_length = player_data.y_spell_chains.size()
		if array_length == 0:
			middle_first_chain_box.texture = chain_user_selected.icon_middle
		if array_length == 1:
			middle_second_chain_box.texture = chain_user_selected.icon_middle
	if selected_level == 2:
		array_length = player_data.b_spell_chains.size()
		if array_length == 0:
			bottom_first_chain_box.texture = chain_user_selected.icon_bottom
		if array_length == 1:
			bottom_second_chain_box.texture = chain_user_selected.icon_bottom

func highlight_selected():
	var array_length: int
	if selected_level == 0:
		array_length = player_data.x_spell_chains.size()
		if array_length > 0:
			top_first_chain_colour_box.color.a = 1
		if array_length > 1:
			top_second_chain_colour_box.color.a = 1
	if selected_level == 1:
		array_length = player_data.y_spell_chains.size()
		if array_length > 0:
			middle_first_chain_colour_box.color.a = 1
		if array_length > 1:
			middle_second_chain_colour_box.color.a = 1
	if selected_level == 2:
		array_length = player_data.b_spell_chains.size()
		if array_length > 0:
			bottom_first_chain_colour_box.color.a = 1
		if array_length > 1:
			bottom_second_chain_colour_box.color.a = 1
