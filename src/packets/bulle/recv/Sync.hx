package packets.bulle.recv;

import connection.Connection;
import utils.Packet;

// C 5

class Movement {
	public static var ccc: Int = 5 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var pid: UInt = packet.read32();
		var x: Int = packet.read16();
		var y: Int = packet.read16();
		var vx: Int = packet.read16();
		var vy: Int = packet.read16();

		// move the player
	}
}

class Death {
	public static var ccc: Int = 5 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var pid: UInt = packet.read32();

		// kill the player
	}
}