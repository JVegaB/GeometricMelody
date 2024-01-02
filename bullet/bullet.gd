class_name Bullet
extends CharacterBody2D


@export var damage : int  = 1;


func _ready() -> void:
	$VisibleOnScreenEnabler2D.screen_exited.connect(queue_free)
