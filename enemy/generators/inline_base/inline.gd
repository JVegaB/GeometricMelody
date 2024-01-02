class_name SpawnerA extends Node2D;


@export var rotate_enemy : bool;
@export var steps : int = 10;
@export_file var enemy_path : String;
@export var automated : bool;
@export var wait_time : float = 1;
@export var wait_start_time : float = 0;
@export var remaining_iterations : float = 1;


@onready var enemy_scene : PackedScene = load(enemy_path);
@onready var timer : Timer = $Timer;


var positions : Array[Marker2D];
var enabled : bool;


func _ready() -> void:
	for child in get_children():
		if child is Marker2D:
			positions.append(child);
	enabled = positions.size() >= 2
	if automated:
		timer.timeout.connect(
			func():
				if remaining_iterations > 0:
					spawn();
					remaining_iterations -= 1
					timer.start();
					
		)
		timer.wait_time = wait_time;
		await get_tree().create_timer(wait_start_time).timeout
		timer.start();

func spawn() -> void:
	if not enabled:
		return
	for pos in get_spawn_positions():
		var enemy_scene : PackedScene = load(enemy_path);
		var enemy : Node2D = enemy_scene.instantiate();
		add_child(enemy);
		if rotate_enemy:
			enemy.rotation_degrees += 180.0
		enemy.global_position = pos;

func get_spawn_positions() -> Array[Vector2]:
	var from : Vector2 = positions[0].global_position;
	var to : Vector2 = positions[1].global_position;
	var pos : Array[Vector2];
	for i in range(1, steps + 1):
		var curr_step : float = (1.0 / float(steps) * i);
		pos.append(lerp(from, to, curr_step));
	return pos
