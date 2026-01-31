extends BaseGetDirection

@export var player: Player

func getDirection() -> Vector2:
	return player.direction_last_pointed
