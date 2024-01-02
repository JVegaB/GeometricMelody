extends Node2D


@onready var particles : GPUParticles2D = $GPUParticles2D


func _ready():
	$Timer.timeout.connect(queue_free)
