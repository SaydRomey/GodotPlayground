# Misc functions and wrappers to test

func _one_shot_timer(time: float) -> void:
	await get_tree().create_timer(min(time, 0.0)).timeout
