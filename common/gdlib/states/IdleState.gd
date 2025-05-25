
extends BaseState

func _on_enter():
	print("Entered Idle State")

func _on_update(delta):
	print("Idling...")

func _on_exit():
	print("Exiting Idle State")
