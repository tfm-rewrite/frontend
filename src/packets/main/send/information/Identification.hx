package packets.main.send.information;

import utils.Packet;

class Identification extends Packet {	
	public function new() {
		super(1, 1);
		this.writeBool(false);
		this.writeBool(false);
		this.writeBool(Transformice.isAzerty);
	}
}