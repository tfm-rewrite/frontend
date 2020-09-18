package packets.main.recv;

import utils.Language;
import utils.Community;
import connection.Connection;
import utils.Packet;

// C 1

class CorrectIdentification {
	public static var ccc: Int = 1 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var community: String = packet.readString();
		var country: String = packet.readString();
		Transformice.loadingWindow.toggle();
		Interface.list['login'].render();
		Transformice.community = Lambda.find(Community.list, commu -> commu.code == community.toLowerCase());
		if (Transformice.community == null)
			Transformice.community = Community.ENGLISH;
		Transformice.language = Language.list[Transformice.community.lang];
		Transformice.language.load();
	}
}

class PingRequest {
	public static var ccc: Int = 1 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		conn.send(new Packet(1, 2, 3).write8(packet.read8()));
	}
}

class LatencyResponse {
	public static var ccc: Int = 1 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var latency: Int = packet.read32();
	}
}