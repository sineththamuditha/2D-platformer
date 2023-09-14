extends Label

@export var state_machine : PlayerStateMachine
@export var player_damageable : PlayerDamageable

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Health : " + str(player_damageable.health)
