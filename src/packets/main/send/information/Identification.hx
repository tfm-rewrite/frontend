package packets.main.send.information;

import utils.Packet;

class Identification extends Packet {	
	public function new() {
		super(1, 1, 5);
		this.writeBool(false);
		this.writeBool(false);
		this.writeBool(Transformice.isAzerty);
	}
}