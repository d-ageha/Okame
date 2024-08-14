extends RigidBody2D

signal eaten
signal screen_exited

# Called when the node enters the scene tree for the first time.
func _ready():
	self.contact_monitor = true
	self.max_contacts_reported = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(_body: Node):
	eaten.emit(self)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	screen_exited.emit()
