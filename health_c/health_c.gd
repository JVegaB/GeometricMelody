class_name HealthC
extends Node2D


signal depleted;


@export var health : int = 1;

var inital : int;
var done : bool;



func _ready():
	inital = health;

func damage(value):
	health -= value;
	health = clampi(health, 0, health);
	if health == 0 and not done:
		done = true;
		emit_signal("depleted");
