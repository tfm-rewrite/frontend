package packets.main.recv;

import connection.Connection;
import utils.Packet;

// C 1

class CorrectIdentification {
	public static var ccc: Int = 1 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var community: String = packet.readString();
		var country: String = packet.readString();

		// show login screen
	}
}

class PingRequest {
	public static var ccc: Int = 1 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		conn.send(new Packet(1, 2).write8(packet.read8()));
	}
}

class LatencyResponse {
	public static var ccc: Int = 1 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var latency: UInt = packet.read32();
	}
}