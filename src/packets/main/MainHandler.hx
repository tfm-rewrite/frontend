package packets.main;

import connection.Connection;
import utils.Packet;

import packets.main.recv.Information;
import packets.main.recv.Login;
import packets.main.recv.Bulle;

class MainHandler {
	public static var packets: Map<Int, (Connection, Packet) -> Void> = [];

	public function new() {
		var packetInitializers: Array<Dynamic> = [
			// C 1 (Information)
			CorrectIdentification,
			PingRequest,
			LatencyResponse,

			// C 2 (Login)
			CorrectLogin,
			IncorrectLogin,
			RegisterResult,

			// C 3 (Bulle)
			SwitchBulle,
			RoomPassword
		];

		for(i in 0 ... packetInitializers.length) {
			MainHandler.packets[packetInitializers[i].ccc] = packetInitializers[i].handle;
		}
	}

	public function handle(conn: Connection, ccc: Int, packet: Packet) {
		if (MainHandler.packets[ccc] != null) {
			// it'd be better to use a separate thread or something to run this
			MainHandler.packets[ccc](conn, packet);
		}
	}
}