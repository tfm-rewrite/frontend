package packets.main.send.information;

import utils.Packet;

class Identification extends Packet {	
	public function new() {
		super(1, 1);
		this.writeBool(false);
		if (false)
			this.writeString('??');
		this.writeBool(false);
		this.writeBool(Transformice.isAzerty);
	}
}