package packets.bulle.send.information;

import utils.Packet;

class Identification extends Packet {	
	public function new() {
		super(1, 1);
		this.write32(Client.pid);
		this.write32(Client.token);
	}
}