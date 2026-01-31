class_name SpellSelectionBox extends Control

var possible_spells : Array[SpellSelectionDataWrapper]

var index_top : int = 0
var index_middle : int = 0
var index_bottom : int = 0

var current_layer_selected : int = 0

@onready var top_color_rect: ColorRect = $"VBoxContainer/Top Mask Box/Middle Image/ColorRect"
@onready var top_texture_rect: TextureRect = $"VBoxContainer/Top Mask Box/Middle Image/ColorRect/TextureRect"

@onready var middle_color_rect: ColorRect = $"VBoxContainer/Middle Mask Box/Middle Image/ColorRect"
@onready var middle_texture_rect: TextureRect = $"VBoxContainer/Middle Mask Box/Middle Image/ColorRect/TextureRect"

@onready var bottom_color_rect: ColorRect = $"VBoxContainer/Bottom Mask Box/Middle Image/ColorRect"
@onready var bottom_texture_rect: TextureRect = $"VBoxContainer/Bottom Mask Box/Middle Image/ColorRect/TextureRect"

func move_left() -> void:
	var index : int = 0
	if current_layer_selected == 0:
		index = index_top
	elif current_layer_selected == 1:
		index = index_middle
	elif current_layer_selected == 2:
		index = index_bottom
	
	index -= 1
	
	if index < 0:
		index = possible_spells.size() - 1
	
	while true:
		var spell_wrapper := possible_spells[index]
		if spell_wrapper.selected:
			index -= 1
			
			if index < 0:
				index = possible_spells.size() - 1
			continue
		
		if current_layer_selected == 0:
			possible_spells[index_top].selected = false
			index_top = index
			possible_spells[index_top].selected = true
		elif current_layer_selected == 1:
			possible_spells[index_middle].selected = false
			index_middle = index
			possible_spells[index_middle].selected = true
		elif current_layer_selected == 2:
			possible_spells[index_bottom].selected = false
			index_bottom = index
			possible_spells[index_bottom].selected = true
		break
	update_image()

func move_right() -> void:
	var index : int = 0
	if current_layer_selected == 0:
		index = index_top
	elif current_layer_selected == 1:
		index = index_middle
	elif current_layer_selected == 2:
		index = index_bottom
	
	index += 1
	
	if index >= possible_spells.size():
		index = 0
	
	while true:
		var spell_wrapper := possible_spells[index]
		if spell_wrapper.selected:
			index += 1
			
			if index >= possible_spells.size():
				index = 0
			continue
		
		if current_layer_selected == 0:
			possible_spells[index_top].selected = false
			index_top = index
			possible_spells[index_top].selected = true
		elif current_layer_selected == 1:
			possible_spells[index_middle].selected = false
			index_middle = index
			possible_spells[index_middle].selected = true
		elif current_layer_selected == 2:
			possible_spells[index_bottom].selected = false
			index_bottom = index
			possible_spells[index_bottom].selected = true
		break
	update_image()

func move_up() -> void:
	current_layer_selected -= 1
	if current_layer_selected < 0:
		current_layer_selected = 2
	update_image()

func move_down() -> void:
	current_layer_selected += 1
	if current_layer_selected > 2:
		current_layer_selected = 0
	update_image()

func update_image():
	var index: int
	if current_layer_selected == 0:
		index = index_top
	elif current_layer_selected == 1:
		index = index_middle
	elif current_layer_selected == 2:
		index = index_bottom

	var selected_spell := possible_spells[index]

	if current_layer_selected == 0:
		top_color_rect.color.a = 1
		middle_color_rect.color.a = 0
		bottom_color_rect.color.a = 0
		top_texture_rect.texture = selected_spell.spell_data.icon
	elif current_layer_selected == 1:
		top_color_rect.color.a = 0
		middle_color_rect.color.a = 1
		bottom_color_rect.color.a = 0
		middle_texture_rect.texture = selected_spell.spell_data.icon
	elif current_layer_selected == 2:
		top_color_rect.color.a = 0
		middle_color_rect.color.a = 0
		bottom_color_rect.color.a = 1
		bottom_texture_rect.texture = selected_spell.spell_data.icon
