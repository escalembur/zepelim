extends Node

var player: Player
var airship: Airship
var time_manager: Timer
var pickables: Array[Pickable] = []
var delivery_manager: DeliveryManager
var interact_manager: InteractManager

enum Floor { GONDOLA, HULL }
