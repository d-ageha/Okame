extends Node

@export var seed_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_seed_timer_timeout():
	if randi_range(0, 99) < 30:
		var new_seed = seed_scene.instantiate()
		new_seed.position = $SeedSpawnPosition.position
		new_seed.linear_velocity = Vector2(-300, 0)
		new_seed.eaten.connect(_on_seed_eaten)
		add_child(new_seed)
	pass # Replace with function body.

func _on_seed_eaten(val):
	print(val, "@main")
	pass ;
