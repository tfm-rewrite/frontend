package packets.main.send.login;

import utils.Packet;

class Register extends Packet {	
	public function new(username: String, password: String) {
		super(2, 4, 128);
		this.writeString(username.toLowerCase());
		this.writeString(password);
	}
}