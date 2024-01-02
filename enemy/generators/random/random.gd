extends Node2D


@export var scene_to_spawn : PackedScene = preload("res://shape/triangle_a/triangle_a.tscn");
@export var rounds : int = 1;
@export var entities : int = 1;
@export var round_time_sep : float = 1;
@export var entity_time_sep : float = .25;
@export var spawn_target_container : Node2D;


func spawn():
	var tree := get_tree()
	var round_time_sep_d2 := round_time_sep / 2;
	var entity_time_sep_d2 := entity_time_sep / 2;
	for i in rounds:
		for j in entities:
			var enemy : Node2D = scene_to_spawn.instantiate();
			var pos = Globals.get_spawn_position();
			if pos != null:
				spawn_target_container.add_child.call_deferred(enemy)
				await spawn_target_container.child_entered_tree
				enemy.global_position = pos;
				enemy.look_at(Globals.get_center_screen())
			await tree.create_timer(
				randf_range(
					entity_time_sep - (entity_time_sep_d2),
					entity_time_sep + (entity_time_sep_d2),
				)
			).timeout
		await tree.create_timer(
			randf_range(
				round_time_sep - (round_time_sep_d2),
				round_time_sep + (round_time_sep_d2),
			)
		).timeout
