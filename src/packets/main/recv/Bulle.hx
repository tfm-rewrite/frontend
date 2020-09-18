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
		startConnection(host, ports, 0);
	}
	
	private static function startConnection(host: String, ports: Array<Int>, index: Int): Void {
		if (index < Utils.ports.length) {
			Transformice.instance.bulle.connect(Utils.useGitpod ? Utils.gitpod : host, ports[index], Utils.useGitpod)
				.then(ws -> {
					/* Connected */
				})
				.catchError(err -> {
					/* Failed */
					startConnection(host, ports, index + 1);
				});
		} else {
			/* Couldn't connect to servers */
		} 

	}
}

class RoomPassword {
	public static var ccc: Int = 3 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var room: String = packet.readString();
	}
}