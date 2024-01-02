extends Node2D



var play_button_active : bool;



func _ready():
	$fade_transition.enter_scene();
	await $fade_transition.scene_entered
	randomize()
	$Play/Area2D.mouse_entered.connect(
		func():
			play_button_active = true;
	);
	$Play/Area2D.mouse_exited.connect(
		func():
			play_button_active = false;
	);
	$Timer.timeout.connect(
		func():
			$RotationPlataform.do_rotation();
			$Timer.wait_time = randf_range(.5, 4)
			$Timer.start();
	)

func _input(event):
	if Input.is_action_just_pressed("click") and play_button_active:
		$fade_transition.exit_scene();
		await $fade_transition.scene_exited
		get_tree().change_scene_to_file("res://levels/level_a/world.tscn")
