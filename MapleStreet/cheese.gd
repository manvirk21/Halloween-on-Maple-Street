extends Area2D

func _on_body_entered(_body):
	var cheese_node = get_node("CheeseSprite")
	cheese_node.visible = false
