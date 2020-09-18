package packets.main.send.login;


import utils.Packet;

class SetCommunity extends Packet {	
	public function new(community: String) {
		super(2, 1, 6);
		this.writeString(community);
		
	}
}