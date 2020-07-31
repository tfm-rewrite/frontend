package packets.main.recv;

import connection.Connection;
import utils.Packet;
import utils.Utils;

// C 3

class SwitchBulle {
	public static var ccc: Int = 3 << 8 | 1;

	public static function handle(conn: Connection, packet: Packet) {
		var host: String = packet.readString();
		var quantity: Int = packet.read8();
		var ports: Array<Int> = [for(i in 0...quantity) packet.read16()];
		var token: Int = packet.read32();

		Transformice.bulleToken = token;

		if(host == "127.0.0.1")
			host = Utils.host; // use main host

		Transformice.instance.bulle = new Connection("bulle", Transformice.instance);
		for(index in 0...ports.length) {
			try {
				if(Utils.useGitpod)
					Transformice.instance.bulle.connect(Utils.gitpod, ports[index], true);
				else
					Transformice.instance.bulle.connect(host, ports[index], false);

				return;
			} catch (err) {
			}
		}
	}
}

class RoomPassword {
	public static var ccc: Int = 3 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var room: String = packet.readString();
	}
}