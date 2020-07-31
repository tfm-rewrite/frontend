package packets.bulle.send.information;

import utils.Packet;

class Identification extends Packet {	
	public function new() {
		super(1, 1, 10);
		this.write32(Transformice.pid);
		this.write32(Transformice.bulleToken);
	}
}