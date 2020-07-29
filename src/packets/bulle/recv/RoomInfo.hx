package packets.bulle.recv;

import connection.Connection;
import utils.Packet;

// C 2

class JoinRoom {
	public static var ccc: Int = 2 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var name: String = packet.readString();

		// change current room name
	}
}

class PlayerUpdate {
	public static var ccc: Int = 2 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var inRoom: Bool = packet.readBool();
		var pid: UInt = packet.read32();
		var name: String = packet.readString();

		// update the player
	}
}

class PlayerList {
	public static var ccc: Int = 2 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var quantity: Int = packet.read16();
		
		for(i in 0...quantity) {
			var pid: UInt = packet.read32();
			var name: String = packet.readString();
			var score: Int = packet.read16(); // note: has to be signed

			// do something with the player
		}
	}
}