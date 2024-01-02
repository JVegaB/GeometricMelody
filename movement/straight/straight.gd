class_name Straight extends Movement;


@export var move_speed : float = 300;
@export var enabled : bool = true;


func _physics_process(delta : float) -> void:
	if not enabled:
		return
	var move_velocity := Vector2.RIGHT.rotated(
		context.global_rotation) * delta * move_speed;
	context.global_position += move_velocity;
