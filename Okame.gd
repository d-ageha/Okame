extends StaticBody2D

# つついてる時間
@export var peck_duration = 0.1

func stand():
	$AnimatedSprite2D.animation = "standing"

func walk():
	$AnimatedSprite2D.animation = "walking"

func eat():
	$AnimatedSprite2D.animation = "eating"
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play()
	$CollisionShape2D.set_deferred("disabled", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("eat"):
		# つついたときに当たり判定を有効化する
		eat()
		$EatingTimer.start(peck_duration)
		$CollisionShape2D.set_deferred("disabled", false)
		
		
func _on_eating_timer_timeout():
	walk()
	$CollisionShape2D.set_deferred("disabled", true)
