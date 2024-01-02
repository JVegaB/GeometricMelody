extends Movement


@onready var target : Vector2 = Globals.get_position_on_screen();


@export var max_speed : Vector2 = Vector2(5, 5);
@export var acceleration : float = 1;
@export var offset_val : float = 2


var curr_velocity : Vector2;
var offset : Vector2;


func _ready():
	tween_offset()


func tween_offset():
	var tween := create_tween();
	tween.tween_property(
		self,
		"offset",
		Vector2(
			randf_range(-offset_val, offset_val),
			randf_range(-offset_val, offset_val)
		),
		1,
	);
	await tween.finished
	tween_offset();

func _physics_process(delta : float) -> void:
	if context.global_position.distance_to(target) <= 10:
		target = Globals.get_position_on_screen();
		return;
	var direction : Vector2 = context.global_position.direction_to(target) + offset;
	#
	curr_velocity += direction * delta * acceleration;
	curr_velocity = curr_velocity.clamp(-max_speed, max_speed);
	context.global_position += curr_velocity
	curr_velocity = lerp(curr_velocity, Vector2.ZERO, delta)

