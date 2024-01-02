extends StateNode


@export var multiplicator : float = 1.5;


var target_position : Vector2;


func enter(from : String, payload : Variant = null) -> void:
	super.enter(from, payload);
	if payload != null:
		target_position = payload;

func physics_process(delta: float) -> String:
	var enemy : Enemy = context.context;
	if enemy.global_position.distance_to(target_position) <= 10:
		return "charge";
	var vel : Vector2 = enemy.global_position.direction_to(
		target_position) * delta * context.movement_speed * multiplicator;
	enemy.global_position += vel;
	return "attack"
