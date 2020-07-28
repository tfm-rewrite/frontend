package packets.bulle;

import connection.Connection;
import utils.Packet;

import packets.bulle.recv.Information;
import packets.bulle.recv.RoomInfo;
import packets.bulle.recv.Chat;
import packets.bulle.recv.MapInfo;
import packets.bulle.recv.Sync;

class BulleHandler {
	public static var packets: Map<Int, (Connection, Packet) -> Void>;

	public function new() {
		var packetInitializers = [
			// C 1
			PingRequest,
			LatencyResponse,

			// C 2
			JoinRoom,
			PlayerUpdate,
			PlayerList,

			// C 3
			RoomMessage,

			// C 4
			ChangeMap,
			TimeLeft,
			Countdown,
			AllShamans,

			// C 5
			Movement,
			Death
		];

		for(i in 0 ... packetInitializers.length) {
			this.packets[packetInitializers[i].ccc] = packetInitializers[i].handle;
		}
	}

	public function handle(conn: Connection, ccc: Int, packet: Packet) {
		if (this.packets[ccc] != null) {
			// it'd be better to use a separate thread or something to run this
			this.packets[ccc](conn, packet);
		}
	}
}