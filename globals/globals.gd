extends Node2D


signal spawn_rotating_entity(node: Node2D, position: Vector2);
signal drum_required;
signal rotation_required;
signal level_timer_done;
signal level_timer_step(idx : int);
signal add_particle(particle : Node2D, position : Vector2, look_position : Vector2);
signal player_died;

const vector_size := 250 * 1.2

func _enter_tree():
	randomize()

func get_position_on_screen() -> Vector2:
	var rotated := Vector2.UP.rotated(deg_to_rad(randf_range(0, 359)));
	var center := get_center_screen();
	return center + (rotated * vector_size);

func get_center_screen() -> Vector2:
	var vp_rect : Rect2 = get_viewport_rect();
	var center := Vector2(
		lerpf(vp_rect.position.x, vp_rect.end.x, .5),
		lerpf(vp_rect.position.y, vp_rect.end.y, .5),
	)
	return center;

func get_spawn_position() -> Vector2:
	var rotated := Vector2(0, 1).rotated(deg_to_rad(randf_range(0, 360)))
	var distance := vector_size * 3
	return get_center_screen() + (rotated * distance)

func get_next_target_position(container : Node2D) -> Variant:
	var target_positions : Array[Node] = container.get_children();
	if target_positions.is_empty():
		return null
	var node : Node = target_positions.filter(
		func(node : Node) -> bool:
			return node is Node2D;
	).pick_random();
	var next_pos : Vector2 = node.global_position;
	var s_size = node.shape.size;
	return Vector2(
		randf_range(next_pos.x - (s_size.x / 2), next_pos.x + (s_size.x / 2), ),
		randf_range(next_pos.y - (s_size.y / 2), next_pos.y + (s_size.y / 2), ),
	)
