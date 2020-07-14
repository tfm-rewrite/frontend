package;

import haxe.Timer;
import js.html.WebSocket;
import utils.InterfaceDebug;
import interfaces.Login;
import utils.Utils;
import utils.Packet;
import connection.Connection;

class Client {

	public static var playerName: String;
	public static var id: Int = 0;
	public static var pid: Int = 0;

	public function new() {

	}

	public static function handleMainPackets(con: Connection, packet: Packet): Void {
		var C: Int = packet.read8();
		var CC: Int = packet.read8();
		if (C == 1 && CC == 1) {
			new Login();
			InterfaceDebug.hide();
			Interface.get('login').render();
			var community: String = packet.readString();
			var country: String = packet.readString();
		} else if (C == 1 && CC == 2) {
			var pingId: Int = packet.read8();
			con.send(new Packet(1, 2).write8(pingId));
		} else if (C == 2 && CC == 2) {
			Client.playerName = packet.readString();
			Client.id = packet.read32();
			Client.pid = packet.read32();
		} else if (C == 3 && CC == 1) {
			// var host: String = packet.readString();
			var ports: Array<Int> = [];
			var x = packet.read16();
			trace(x);
			trace(packet.read_position);
			trace(packet.readRawString(x));
			trace(packet.read_position);
			trace(packet.read16());
			trace(packet.read_position);
			// trace(packet)
			// connectBulle(host, ports);
		} else {
			trace('Unhandled main [$C, $CC]', Utils.fromByteArray(packet.buffer.subarray(2)));
		}
	}

	public static function connectBulle(host: String, ports: Array<Int>, index: Int = 0): Void {
		trace(index, ports.length);
		if (index >= ports.length)
			return InterfaceDebug.setText('Failed to connect to the bulle server.');
		for (i in index...ports.length) {
			InterfaceDebug.setText('Connecting to bulle server ${ports[i]}...');
			Connection.bulle.connect(host, ports[i]);
			Timer.delay(function() {
				if (Connection.bulle.transport.readyState != WebSocket.OPEN) {
					Connection.bulle.transport.close();
					connectBulle(host, ports, index + 1);
				}	
			}, 3000);
		}
	}

	public static function handleBullePackets(con: Connection, packet: Packet): Void {
		var C: Int = packet.read8();
		var CC: Int = packet.read8();
	}
}