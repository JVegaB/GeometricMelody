extends StateNode


var target_position : Vector2;


func enter(from : String, payload : Variant = null) -> void:
	super.enter(from, payload);
	target_position = Globals.get_position_on_screen();

func physics_process(delta: float) -> String:
	var enemy : Enemy = context.context;
	if enemy.global_position.distance_to(target_position) <= 10:
		return "charge";
	var vel : Vector2 = enemy.global_position.direction_to(
		target_position) * delta * context.movement_speed;
	enemy.global_position += vel
	return ""
