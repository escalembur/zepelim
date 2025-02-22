extends Label

var airship := Global.airship


func _process(_delta: float) -> void:
	match airship.thrust_value:
		3: text = "<<<"
		2: text = "<<"
		1: text = "<"
		0: text = "="
		-1: text = ">"
