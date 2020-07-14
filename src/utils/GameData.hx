package utils;
import js.html.ElementCreationOptions;
import openfl.utils.Object;
import openfl.utils.ByteArray;

class GameData {

	public static function parseXMLSettings(xml: Xml): ByteArray {
		var booleans: Array<String> = ['A', 'AIE', 'bh', 'C', 'Ca', 'mc', 'N', 'P'];
		var images: Array<String> = ['D', 'd'];
		var integers: Array<String> = ['F', 'mgoc', 'H', 'L'];
		var intlist: Array<String> = ['defilante', 'G'];
		var settings: ByteArray = new ByteArray();
		for (i in 0...booleans.length) 
			if (xml.exists(booleans[i])) 
				settings.writeByte(i);
		

		for (i in 0...images.length) {
			if (xml.exists(images[i])) {
				var imgs: Array<String> = xml.get(images[i]).split(',');
				settings.writeByte(i + booleans.length);
				settings.writeByte(images.length);
				for (img in imgs) {
					var url = img.split(',')[0];
					var x = Std.parseInt(img.split(',')[1]);
					var y = Std.parseInt(img.split(',')[2]);
					settings.writeUTF(url);
					settings.writeInt(x);
					settings.writeInt(y);
				}
			}
		}

		for (i in 0...integers.length) {
			if (xml.exists(integers[i])) {
				settings.writeByte(i + booleans.length + images.length);
				settings.writeShort(Std.parseInt(xml.get(integers[i])));
			}
		}
		
		for (i in 0...intlist.length) {
			if (xml.exists(intlist[i])) {
				settings.writeByte(i + booleans.length + images.length + integers.length);
				for (value in xml.get(intlist[i]).split(','))
					settings.writeShort(Math.round(Std.parseFloat(value)));
			}
		}

		if (xml.exists('DS')) {
			var mode = xml.get('DS').split(';')[0];
			var coordinates = xml.get('DS').split(';')[1].split(',');
			settings.writeByte(booleans.length + images.length + integers.length);
			settings.writeByte(mode == 'm' ? 0 : mode == 'x' ? 1 : 2);
			settings.writeByte(coordinates.length);
			for (coordinate in coordinates) 
				settings.writeShort(Std.parseInt(coordinate));
		}
		return settings;
	}

	public static function parseXMLGrounds(packet: ByteArray, element: Xml): Void {
		var booleans: Array<String> = ['m', 'N', 'nosync'];
		var images: Array<String> = ['i'];
		var integers: Array<String> = ['c', 'H', 'L', 'lua', 'v', 'X', 'Y', 'T'];
		trace(element);
		packet.writeByte(254);
		for (i in 0...booleans.length) 
			if (element.exists(booleans[i])) 
				packet.writeByte(i);
		for (i in 0...images.length) {
			if (element.exists(images[i])) {
				var img = element.get(images[i]);
				var x = Std.parseInt(img.split(',')[0]);
				var y = Std.parseInt(img.split(',')[1]);
				var url = img.split(',')[2];
				packet.writeByte(i + booleans.length);
				packet.writeShort(x);
				packet.writeShort(y);
				packet.writeUTF(url);
			}
		}
		for (i in 0...integers.length) {
			if (element.exists(integers[i])) {
				packet.writeByte(i + booleans.length + integers.length);
				packet.writeShort(Std.parseInt(element.get(integers[i])));
			}
		}
		if (element.exists('P')) {
			var data = element.get('P').split(',');
			while (data.length > 8)
				data.splice(8, 1);
			var dyn = data[0] == '1', mass = data[1],  fric = data[2], res = data[3], angle = data[4], fixrot = data[5] == '1', lindamp = data[6], angdamp = data[7];
			packet.writeByte(booleans.length + images.length + integers.length);
			packet.writeBoolean(dyn);
			
			if (fric.indexOf('e') != -1)
				packet.writeShort(0xFFFF);
			else
				packet.writeShort(Std.parseInt(fric) * 100);
			if (res.indexOf('q') != -1) 
				packet.writeShort(0xFFFF);
			else
				packet.writeShort(Std.parseInt(res) * 100);
			packet.writeShort(Std.parseInt(angle) * 100);
			if (dyn) {
				if (mass.indexOf('e') != -1)
					packet.writeShort(0xFFFFF);
				else
					packet.writeShort(Std.parseInt(mass));
				packet.writeBoolean(fixrot);
				packet.writeShort(Std.parseInt(lindamp) * 100);
				packet.writeShort(Std.parseInt(angdamp) * 100);
			}
		}
		if (element.exists('o') && element.get('o') != '') {
			packet.writeByte(booleans.length + images.length + integers.length + 1);
			packet.writeByte((Std.parseInt('0x' + element.get('o')) >>> 16) & 0xFF);
			packet.writeShort(Std.parseInt('0x' + element.get('o')));
		}
	}

	public static function parseXMLShaman(packet: ByteArray, element: Xml): Void {
		var booleans: Array<String> = ['nosync'];
		var integers: Array<String> = ['C', 'Mp', 'Mv', 'X', 'Y'];
		packet.writeByte(254);
		for (i in 0...booleans.length)
			if (element.exists(booleans[i]))
				packet.writeByte(i);
		for (i in 0...integers.length) {
			if (element.exists(integers[i])) {
				packet.writeByte(i + booleans.length);
				packet.writeShort(Std.parseInt(element.get(integers[i])));
			}
		}
		if (element.exists('P')) {
			packet.writeByte(booleans.length + integers.length);
			var data = element.get('P').split(',');
			packet.writeShort(Std.parseInt(data[0]));
			packet.writeBoolean(data.length > 1 && data[1] == '1'); // Ghost
		}
	}

	public static function parseXMLJoints(packet: ByteArray, element: Xml): Void {
		trace(element);
	}

	public static function xml2gd(x: String): ByteArray {
		var root: Xml = Xml.parse(x);
		if (root.firstChild() != null && root.firstChild().nodeName != 'C')
			return null;

		var grounds: ByteArray = new ByteArray();
		var decorations: ByteArray = new ByteArray();
		var shaman: ByteArray = new ByteArray();
		var joints: ByteArray = new ByteArray();

		var settings: ByteArray = new ByteArray();
		for (element in root.firstChild().elements()) {
			if (element.nodeName == 'P') 
				settings = GameData.parseXMLSettings(element);
			else if (element.nodeName == 'Z')
			{
				for (grandchild in element.elements()) {
					for (grandgrandchild in grandchild.elements()) {
						if (grandchild.nodeName == 'S')
							GameData.parseXMLGrounds(grounds, grandgrandchild);
						else if (grandchild.nodeName == 'O')
							GameData.parseXMLShaman(shaman, grandgrandchild);
					}
				}
			}
		}
		var packet: ByteArray = new ByteArray();
		packet.writeBytes(settings);
		packet.writeByte(0xff);
		packet.writeBytes(grounds);
		packet.writeByte(0xff);
		packet.writeBytes(decorations);
		packet.writeByte(0xff);
		packet.writeBytes(shaman);
		packet.writeByte(0xff);
		packet.writeBytes(joints);
		return packet;

	}
}