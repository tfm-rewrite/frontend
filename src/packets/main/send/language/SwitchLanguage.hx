package packets.main.send.language;

import utils.Packet;

class SwitchLanguage extends Packet {	
	public function new(language: String) {
		super(4, 1, 6);
		this.writeString(language);
	}
}