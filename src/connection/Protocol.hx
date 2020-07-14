package connection;

import js.lib.Uint8Array;
import utils.Packet;
import utils.Utils;

class Protocol {

	
	private var bytes: Packet = new Packet();
	private var length: Int = 0;
	public var client: Client;
	public var connection: Connection;


	public function new(con: Connection) {
		this.connection = con;
	}

	public function dataRecieve(bytes: Uint8Array): Void {
		trace('RECV', Utils.fromByteArray(bytes));
		this.bytes.writeBytes(bytes);
		while (this.bytes.length > this.length) {
			if (this.length == 0) {
				for (i in 0...5) {
					var byte: Int = this.bytes.read8();
					this.length |= (byte & 0x7F) << (i * 7);
					if ((byte & 0x80) == 0) break;
				}
			}
			if (this.bytes.length >= this.length) {
				var data: Uint8Array = this.bytes.readBytes(this.length);
				if (this.connection.name == 'main')
					Client.handleMainPackets(this.connection, new Packet(data));
				else
					Client.handleBullePackets(this.connection, new Packet(data));
				this.length = 0;
			}
		}		
	}

}