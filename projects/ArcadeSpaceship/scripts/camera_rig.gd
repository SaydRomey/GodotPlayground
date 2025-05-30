extends Node3D

@export var target_path: NodePath
@export var follow_distance := Vector3(0, 3, -10)
@export var follow_speed := 5.0

var target: Node3D

func _ready() -> void:
	target = get_node(target_path)


func _process(delta: float) -> void:
	if !target:
		return
	
	var target_position = target.global_transform.origin
	var desired_position = target_position + target.global_transform.basis * follow_distance
	global_transform.origin = global_transform.origin.lerp(desired_position, delta * follow_speed)
	
	look_at(target_position, Vector3.UP)
