class_name DAW;
extends Node;


var tracks : Array[AudioTrack];
var next_idx : int = -1;


func _ready():
	for child in get_children():
		if child is AudioTrack:
			child.drum_needed.connect(
				func(idx):
					Globals.drum_required.emit()
			);
			child.rotation_needed.connect(
				func(idx):
					Globals.rotation_required.emit()
			);
			tracks.append(child)

func play():
	start_next_track();

func start_next_track():
	next_idx += 1;
	print('start_next_track: ', next_idx)
	for idx in tracks.size():
		tracks[idx].stop()
		if idx <= next_idx:
			tracks[idx].play_custom();
