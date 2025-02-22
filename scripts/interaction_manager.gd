extends Node2D

@onready var player := Global.player
@onready var airship := Global.airship
@onready var button := $Button

var active_areas = []

func _init() -> void:
	Global.interaction_manager = self


func register_area(area: InteractionArea) -> void:
	active_areas.push_back(area)


func unregister_area(area: InteractionArea) -> void:
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)


func _process(_delta) -> void:
	if active_areas.size() > 0:
		active_areas.sort_custom(_sort_by_distance_to_player)
		button.global_position = active_areas[0].global_position
		button.show()
	elif player.last_interact:
		button.global_position = player.last_interact.global_position
		button.show()
	else:
		button.hide()

func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_squared_to(area1.global_position)
	var area2_to_player = player.global_position.distance_squared_to(area2.global_position)
	return area1_to_player < area2_to_player


func _input(event):
	if event.is_action_pressed("interact"):
		if active_areas.size() > 0:
			button.hide()
			active_areas[0].interact.call()
