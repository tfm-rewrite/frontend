package packets.main.recv;

import connection.Connection;
import utils.Packet;

// C 2

class CorrectLogin {
	public static var ccc: Int = 2 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var name: String = packet.readString();
		var id: Int = packet.read32();
		var pid: Int = packet.read32();
		var ranks: Int = packet.read32();

		Transformice.pid = pid;
		// remove login screen, show basic interface (chat)
	}
}

class IncorrectLogin {
	public static var ccc: Int = 2 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var code: Int = packet.read8();
	}
}

class RegisterResult {
	public static var ccc: Int = 2 << 8 | 4;

	public static function handle(conn: Connection, packet: Packet) {
		var code: Int = packet.read8();
	}
}