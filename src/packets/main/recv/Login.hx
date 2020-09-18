package packets.main.recv;

import utils.Language;
import js.html.InputElement;
import js.Browser;
import connection.Connection;
import utils.Packet;

// C 2

class CorrectLogin {
	public static var ccc: Int = 2 << 8 | 2;

	public static function handle(conn: Connection, packet: Packet) {
		var name: String = packet.readString();
		var id: Int = packet.read32();
		var pid: Int = packet.read32();
		var ranks: Int = packet.read32();

		Transformice.pid = pid;
		for (interf in Interface.list.keyValueIterator())
			interf.value.destroy();
		Interface.list['gameplay'].render();
	}
}

class IncorrectLogin {
	public static var ccc: Int = 2 << 8 | 3;

	public static function handle(conn: Connection, packet: Packet) {
		var code: Int = packet.read8();
		Interface.list['grayscale'].destroy();
		var inp: InputElement = cast Browser.document.getElementById('inp_password');
		switch code {
			case 0: /* Already logged in */
				inp.setCustomValidity(Language.message('already_logged'));
				inp.reportValidity();
			case 1: /* Invalid details */
				inp.setCustomValidity(Language.message('invalid_details'));
				inp.reportValidity();
		}
		inp.value = '';
	}
}

class RegisterResult {
	public static var ccc: Int = 2 << 8 | 4;

	public static function handle(conn: Connection, packet: Packet) {
		var code: Int = packet.read8();
		Interface.list['grayscale'].destroy();
		var inp: InputElement = cast Browser.document.getElementById('inp_username');
		switch code {
			case 0: /* Nickname already taken */
				inp.setCustomValidity(Language.message('nickname_taken'));
				inp.reportValidity();
		}
		inp.value = '';
	}
}