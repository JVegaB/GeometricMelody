class_name SpinSpawner extends Node2D

@export_file var enemy_path : String;
@export var rings : int = 6;
@export var arms : int = 12;
@export var speed : float = 40;
@export var direction : int = 1;


@onready var pivot : Node2D = $pivot;

func _ready():
	if enemy_path:
		$pivot/base.enemy_path = enemy_path
	var base : Node2D = $pivot/base;
	base.rotate_enemy = direction != -1
	base.steps = rings;
	var step_degress : float = 360.0 / float(arms);
	var current_degrees : float;
	for i in range(arms - 1):
		current_degrees += step_degress;
		var new : Node2D = base.duplicate();
		pivot.add_child.call_deferred(new)
		await pivot.child_entered_tree
		new.rotation_degrees = current_degrees;
		await new.ready
		new.spawn()
	base.spawn();

func _physics_process(delta : float) -> void:
	pivot.rotation_degrees += delta * speed * direction;
