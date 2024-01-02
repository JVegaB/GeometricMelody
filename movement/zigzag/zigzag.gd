class_name MovementZigZag extends Movement;


@export var move_speed : float = 100;
@export var max_offset : float = 2;
@export var dur_offset : float = 1;


var offset : float;
var first_iteration_done : bool;


func _ready() -> void:
	tween_offset();

func tween_offset(invert = false) -> void:
	var tween := create_tween();
	var _offset := -max_offset if invert else max_offset;
	if first_iteration_done:
		_offset = _offset * 2;
	else:
		first_iteration_done = true;
	tween.tween_property(self, "offset", _offset, dur_offset)
	await tween.finished
	tween_offset(not invert)

func _physics_process(delta : float) -> void:
	var move_velocity := Vector2(1, offset).rotated(
		context.global_rotation) * delta * move_speed;
	context.global_position += move_velocity
