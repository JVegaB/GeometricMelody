class_name RotationCamera extends Camera2D


func _ready():
	Globals.drum_required.connect(drum)

func drum():
	var duration := .25;
	var _zoom := .97;
	var tween := create_tween();
	tween.tween_property(self, "zoom", Vector2(_zoom, _zoom), duration/2);
	await tween.finished;
	tween = create_tween();
	tween.tween_property(self, "zoom", Vector2(1, 1), duration/2);
	await tween.finished;
