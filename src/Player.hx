package;

class Player {
	public static var players: Array<Player> = new Array();
	public static var instance: Player;

	public var playerName: String;
	public var pid: Int;
	public var id: Int; 

	public var sprite: PlayerSprite;
	
	@:isVar public var x(get, set): Float = 0;
	@:isVar public var y(get, set): Float = 0;

	public function new() {
		this.sprite = new PlayerSprite(this, 0, 0);
	}

	public function get_x(): Float {
		return this.sprite.x;
	}
	
	public function set_x(value: Float): Float {
		return this.x = this.sprite.x = value;
	}

	public function get_y(): Float {
		return this.sprite.y;
	}
	
	public function set_y(value: Float): Float {
		return this.y = this.sprite.y = value;
	}
}