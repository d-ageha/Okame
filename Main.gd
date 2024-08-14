extends Node

@export var seed_scene: PackedScene

var point: int
var health: int
var isGameOver: bool

func start_game():
	point = 0
	health = 10
	isGameOver = false
	$GameOverLabel.hide()
	$RestartButton.hide()
	$SeedTimer.start()
	$Okame.walk()
	update_score()
	update_health()

func game_over():
	if isGameOver:
		return
	isGameOver = true
	$GameOverLabel.show()
	$RestartButton.show()
	$RestartButton.disabled = true
	$SeedTimer.stop()
	$Okame.stand()
	get_tree().call_group("seeds", "queue_free")
	await get_tree().create_timer(1.0).timeout
	$RestartButton.disabled = false
		

func update_score():
	$ScoreLabel.text = "SCORE: " + str(point)

func update_health():
	$HealthLabel.text = "LIFE: " + str(health)

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_seed_timer_timeout():
	if randi_range(0, 99) < 30:
		var new_seed = seed_scene.instantiate()
		new_seed.position = $SeedSpawnPosition.position
		new_seed.linear_velocity = Vector2(-300, 0)
		new_seed.eaten.connect(_on_seed_eaten)
		new_seed.screen_exited.connect(_on_seed_screen_out)
		add_child(new_seed)
	pass # Replace with function body.

func _on_seed_screen_out():
	health -= 1
	update_health()
	if health <= 0:
		game_over()

func _on_seed_eaten(_val):
	point += 10
	update_score()

func _on_restart_button_pressed():
	start_game()
