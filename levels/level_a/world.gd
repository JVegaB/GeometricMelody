extends Node2D


@onready var spawn_container : Node2D = $RotationPlataform;

const particles_scene : PackedScene = preload("res://particles/onhit.tscn")
var level_finished : bool;
var failed : bool;
var hordes_scenes := [
	[
		preload("res://levels/level_a/hordes/stage_a/1/1.tscn"),
		preload("res://levels/level_a/hordes/stage_a/2/2.tscn"),
		preload("res://levels/level_a/hordes/stage_a/3/3.tscn"),
	],
	[
		preload("res://levels/level_a/hordes/stage_b/1/1.tscn"),
		preload("res://levels/level_a/hordes/stage_b/2/2.tscn"),
		preload("res://levels/level_a/hordes/stage_b/3/3.tscn"),
	],
	[
		preload("res://levels/level_a/hordes/stage_b/2/2.tscn"),
		preload("res://levels/level_a/hordes/stage_c/1/1_spin.tscn"),
		preload("res://levels/level_a/hordes/stage_c/2/2.tscn"),
	],
	[
	 	preload("res://levels/level_a/hordes/stage_b/2/2.tscn"),
	 	preload("res://levels/level_a/hordes/stage_c/2/2.tscn"),
	 	preload("res://levels/level_a/hordes/stage_d/1.tscn"),
		preload("res://levels/level_a/hordes/stage_b/3/3.tscn"),
	]
];
var current_hordes_scenes := [];
var hordes_wait_time_spawn := [4.0, 5.0, 10.0, 10.0];


func _do_beat_on_ring():
	var tween := create_tween();
	tween.tween_property(
		$RotationPlataform/Dotted,
		"modulate",
		Color.from_string("ffffff81", Color.WHITE),
		.1,
	);
	await tween.finished
	tween = create_tween()
	tween.tween_property(
		$RotationPlataform/Dotted,
		"modulate",
		Color.from_string("ffffff35", Color.GRAY),
		.1
	);

func _ready():
	# preload of asset
	var particles : Node2D = particles_scene.instantiate();
	$RotationPlataform.add_child(particles);
	particles.global_position = Vector2.ZERO;
	particles.particles.emitting = true;
	$fade_transition.enter_scene();
	await $fade_transition.scene_entered
	randomize();
	Globals.player_died.connect(
		func():
			failed = true;
			$CurrentLevelDisplay.stop();
			$failure.show_text();
	)
	Globals.level_timer_done.connect(do_infinite_mode)
	Globals.add_particle.connect(
		func(particle : Node2D, position : Vector2, look_position : Vector2):
			$RotationPlataform.add_child(particle)
			particle.global_position = position;
			particle.look_at(look_position)
			particle.particles.emitting = true;
	)
	Globals.drum_required.connect(
		_do_beat_on_ring
	)
	if hordes_scenes.size():
		current_hordes_scenes = hordes_scenes[0];
	$CurrentLevelDisplay.start() 
	Globals.level_timer_step.connect(_on_level_timer_step);
	Globals.rotation_required.connect(func(): $RotationPlataform.do_rotation());
	$SpawnTimer.timeout.connect(
		func():
			spawn()
	)

func _on_level_timer_step(idx : int):
	if not level_finished:
		$SpawnTimer.stop()
		$SpawnTimer.wait_time = hordes_wait_time_spawn[idx];
		$SpawnTimer.start()
		if idx < hordes_scenes.size():
			current_hordes_scenes = hordes_scenes[idx];
	if idx == 0:
		$DAW.play();
	else:
		$DAW.start_next_track();
	spawn()
 
func spawn() -> void:
	if current_hordes_scenes.is_empty():
		return;
	var scene : PackedScene = current_hordes_scenes.pick_random();
	var generator : Node2D = scene.instantiate();
	generator.spawn_target_container = $RotationPlataform
	spawn_container.add_child.call_deferred(generator);
	await spawn_container.child_entered_tree;
	generator.look_at(Globals.get_center_screen())

func do_infinite_mode():
	level_finished = true;
	$Player.make_inmortal();
	await $success.show_text();

func _input(event):
	if Input.is_action_just_pressed("esc") and failed:
		$fade_transition.exit_scene();
		await $fade_transition.scene_exited
		get_tree().reload_current_scene()
