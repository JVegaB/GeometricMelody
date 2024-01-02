extends StaticBody2D


@onready var line : Line2D = $Line2D;
@onready var collision : CollisionPolygon2D = $CollisionPolygon2D;


func _ready() -> void:
	var polygon : PackedVector2Array = [];
	for point in line.points:
		polygon.append(line.to_global(point))
	collision.polygon = line.points;
