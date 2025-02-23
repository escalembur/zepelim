extends DirectionalLight2D

@export var on_energy : float = 0.9
@export var off_energy : float = 0.0
@export var interval_minutes : float = 2.5
@export var transition_duration_seconds : float = 1.0  # Duration of the gradual transition

var time_elapsed : float = 0.0
var is_on : bool = false
var interval_seconds : float

var is_transitioning : bool = false
var transition_time_elapsed_internal : float = 0.0 # Tracks transition time using 'delta'
var transition_end_energy : float # Target energy level at the end of transition
var transition_start_energy : float # Energy level at the beginning of transition


func _ready():
	interval_seconds = interval_minutes * 60.0 # Convert minutes to seconds
	energy = off_energy # Initially start off


func _process(delta):
	time_elapsed += delta

	if is_transitioning:
		transition_time_elapsed_internal += delta # Increment transition timer using delta
		if transition_time_elapsed_internal >= transition_duration_seconds:
			is_transitioning = false
			transition_time_elapsed_internal = 0.0 # Reset transition timer for next transition
			energy = transition_end_energy # Ensure it reaches the target energy exactly
		else:
			var progress = transition_time_elapsed_internal / transition_duration_seconds # 0 to 1 progress
			energy = lerp(transition_start_energy, transition_end_energy, progress)
	else:
		if time_elapsed >= interval_seconds:
			time_elapsed -= interval_seconds # Reset the timer
			is_on = !is_on # Flip the state

			is_transitioning = true
			transition_time_elapsed_internal = 0.0 # Reset transition timer for new transition
			transition_start_energy = energy # Current energy is the starting point
			if is_on:
				transition_end_energy = on_energy
			else:
				transition_end_energy = off_energy
