extends Node2D


func show_text():
	await modulate_node($A)
	await modulate_node($B)

func modulate_node(node : Node2D):
	print(node)
	var tween := create_tween();
	node.visible = true;
	tween.tween_property(node, "modulate", Color.WHITE, .5)
	await tween.finished;
	await get_tree().create_timer(1).timeout
	tween = create_tween()
	tween.tween_property(node, "modulate", Color.TRANSPARENT, .5)
	await tween.finished;

