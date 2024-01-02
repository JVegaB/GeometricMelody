extends CanvasLayer;


signal scene_entered;
signal scene_exited;


@onready var animation : AnimationPlayer = $AnimationPlayer;
@onready var start_timer : Timer = $Timer;


func _ready():
	start_timer.timeout.connect(_on_timeout);
	animation.animation_finished.connect(_on_animation_finished);

func set_initial_wait_time(wait_time : float):
	start_timer.wait_time = wait_time;

func _on_timeout():
	animation.play("fade_in");

func enter_scene() -> void:
	start_timer.start();

func exit_scene() -> void:
	show();
	animation.play("fade_out");

func _on_animation_finished(animation_name: StringName) -> void:
	match animation_name:
		"fade_in":
			hide();
			scene_entered.emit();
		"fade_out":
			scene_exited.emit();
