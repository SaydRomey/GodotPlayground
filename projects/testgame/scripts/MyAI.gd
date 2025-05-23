extends StateMachine

func _ready():
	var idle = preload("res://gdlib/BaseState.gd").new()
	add_state("Idle", idle)
	change_state("Idle")
