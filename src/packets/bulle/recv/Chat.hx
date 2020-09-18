package packets.bulle.recv;

import connection.Connection;
import utils.Packet;

// C 3

class RoomMessage {
	public static var ccc: Int = 3 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var pid: Int = packet.read32();
		var name: String = packet.readString();
		var message: String = packet.readString();

		// show message
	}
}