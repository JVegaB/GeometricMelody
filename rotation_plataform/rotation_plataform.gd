extends Node2D

@export var min_speed : float = .8;
@export var max_speed : float = 2.8;
@export var rot_degs : float = 60;


static var applied_rotation_degs : float;


var current_tween : Tween = null;
var current_direction : int;


func _ready():
	randomize()
	current_direction = 1 if randf() > .5 else -1;

func _physics_process(delta : float) -> void:
	applied_rotation_degs = global_rotation_degrees;

func do_rotation():
	if current_tween != null:
		current_tween.stop();
	var speed := randf_range(min_speed, max_speed);
	var rotation_degs := randf_range(rot_degs / 2,  rot_degs) * current_direction;
	current_direction *= -1 
	current_tween = create_tween();
	current_tween.tween_property(self, "global_rotation_degrees", global_rotation_degrees + rotation_degs, speed)
	await current_tween.finished
	current_tween = null;
