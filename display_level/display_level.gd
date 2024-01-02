extends Control


@export var times : Array[float];


var active_node : Variant;
var current_idx : int;


@onready var figures : Array = $MarginContainer/TextureProgressBar.get_children();
@onready var progress : TextureProgressBar = $MarginContainer/TextureProgressBar;


var animate_progress_tween : Tween;
var stopped : bool;


func stop():
	stopped = true;
	if animate_progress_tween != null:
		animate_progress_tween.stop();

func start():
	progress.value = 0
	var last_time : float;
	var last_idx : int;
	for idx in times.size():
		last_time = times[idx]
		last_idx = idx;
		await animate_progress(times[idx])
		if stopped: return
		if idx == times.size() - 1:
			Globals.level_timer_done.emit();
			Globals.level_timer_step.emit(idx);
		else:
			switch_figure();
			Globals.level_timer_step.emit(idx);
	$Timer.wait_time = last_time;
	$Timer.timeout.connect(
		func():
			Globals.level_timer_step.emit(last_idx)
	)
	$Timer.start();

func animate_progress(time : float) -> void:
	if stopped: return
	if animate_progress_tween != null:
		animate_progress_tween.stop();
	animate_progress_tween = create_tween();
	animate_progress_tween.tween_property(progress, "value", 100, time - .1);
	await animate_progress_tween.finished;
	animate_progress_tween = create_tween();
	animate_progress_tween.tween_property(progress, "value", 0, .1);
	await animate_progress_tween.finished;
	animate_progress_tween = null;


func previous_figure():
	current_idx -= 2;
	current_idx = max(0, current_idx)
	switch_figure()

func switch_figure() -> void:
	if stopped: return
	var tween : Tween;
	if active_node != null:
		tween = create_tween();
		tween.tween_property(active_node, "scale", Vector2.ZERO, .1);
		await tween.finished;
	if current_idx >= figures.size():
		return;
	active_node = figures[current_idx];
	tween = create_tween();
	tween.tween_property(active_node, "scale", Vector2(1, 1), .1);
	await tween.finished;
	current_idx += 1;
	
