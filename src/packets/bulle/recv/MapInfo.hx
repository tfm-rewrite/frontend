package packets.bulle.recv;

import connection.Connection;
import utils.Packet;

// C 4

class ChangeMap {
	public static var ccc: Int = 4 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var code: UInt = packet.read32();
		var author: String = packet.readString();
		var perm: Int = packet.read8();
		var flipped: Bool = packet.readBool();
		var compressed: Bool = packet.readBool();
		var gd: String = packet.readBigString();

		if(compressed) {
			// gd = zlib deflate on gd;
		}

		// load map
	}
}

class TimeLeft {
	public static var ccc: Int = 4 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var time: Int = packet.read16();

		// set time left
	}
}

class Countdown {
	public static var ccc: Int = 4 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		// start 3, 2, 1 countdown
	}
}

class AllShamans {
	public static var ccc: Int = 4 << 8 | 4;

	public static function handle(conn: Connection, packet: Packet) {
		var survivor: Bool = packet.readBool(); // true = show cannons first
		var quantity: Int = packet.read16();

		for(i in 0...quantity) {
			var pid: UInt = packet.read32();
			var name: String = packet.readString();
			var pink: Bool = packet.readBool();

			// do something with the player
		}
	}
}