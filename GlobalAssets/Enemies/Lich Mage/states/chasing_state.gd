extends ChasingState

class_name LichChasingState

func attack_player(_player : Player):
	emit_signal("interrupt_state", attack_state)
	attack_state.attacking_character = _player
	playback.travel("attack_1")
