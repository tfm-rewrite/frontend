package packets.main.send.login;


import utils.Packet;

class LoginPacket extends Packet {	
	public function new(username: String, password: String, room: String = '1') {
		super(2, 2);
		this.writeBool(password == '');
		this.writeString(room);
		this.writeString(username.toLowerCase());
		if (password != '')
			this.writeString(password);
	}
}