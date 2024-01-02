class_name AudioTrack;
extends AudioStreamPlayer;


signal drum_needed(idx : int);
signal rotation_needed(idx : int);


@export var drum_times : Array[float];
@export var rotation_times : Array[float];
@export var max_iterations : int;


var _current_iterations : int;
var replayed : bool;


func play_custom(count_as_iteration : bool = false):
	stop();
	if count_as_iteration:
		_current_iterations += 1;
	else:
		_current_iterations = 1;
	if max_iterations > 0 and _current_iterations > max_iterations:
		return;
	start_drums();
	start_rotations();
	play();
	replayed = false;

func start_drums():
	var tree := get_tree()
	for idx in drum_times.size():
		tree.create_timer(drum_times[idx]).timeout.connect(
			func():
				drum_needed.emit(idx);
		)

func start_rotations():
	var tree := get_tree()
	for idx in rotation_times.size():
		tree.create_timer(rotation_times[idx]).timeout.connect(
			func():
				rotation_needed.emit(idx);
		)

func _process(delta) -> void:
	if not replayed and (stream.get_length() - get_playback_position()) <= delta:
		replayed = true;
		play_custom(true)
