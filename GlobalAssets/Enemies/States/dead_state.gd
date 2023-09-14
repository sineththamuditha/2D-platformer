extends State

class_name DeathState

func on_enter():
	playback.stop()
	playback.travel("death")
