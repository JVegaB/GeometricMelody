extends Node2D


func _ready():
	$EnemyActivation.area_entered.connect(
		func(body : Node2D) -> void:
			if body.has_meta("enemy_hitbox"):
				body.get_parent().activate_side_effect = true;
	)
