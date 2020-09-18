package utils;
import openfl.utils.Object;

class GameData {

	public static function parseXMLSettings(xml: Xml): Packet {
		var booleans: Array<String> = ['A', 'AIE', 'bh', 'C', 'Ca', 'mc', 'N', 'P'];
		var images: Array<String> = ['D', 'd'];
		var integers: Array<String> = ['F', 'mgoc', 'H', 'L'];
		var intlist: Array<String> = ['defilante', 'G'];
		var settings: Packet = new Packet();
		for (i in 0...booleans.length) 
			if (xml.exists(booleans[i])) 
				settings.write8(i);
		

		for (i in 0...images.length) {
			if (xml.exists(images[i])) {
				var imgs: Array<String> = xml.get(images[i]).split(',');
				settings.write8(i + booleans.length);
				settings.write8(images.length);
				for (img in imgs) {
					var url = img.split(',')[0];
					var x = Std.parseInt(img.split(',')[1]);
					var y = Std.parseInt(img.split(',')[2]);
					settings.writeString(url);
					settings.write32(x);
					settings.write32(y);
				}
			}
		}

		for (i in 0...integers.length) {
			if (xml.exists(integers[i])) {
				settings.write8(i + booleans.length + images.length);
				settings.write16(Std.parseInt(xml.get(integers[i])));
			}
		}
		
		for (i in 0...intlist.length) {
			if (xml.exists(intlist[i])) {
				settings.write8(i + booleans.length + images.length + integers.length);
				for (value in xml.get(intlist[i]).split(','))
					settings.write16(Math.round(Std.parseFloat(value)));
			}
		}

		if (xml.exists('DS')) {
			var mode = xml.get('DS').split(';')[0];
			var coordinates = xml.get('DS').split(';')[1].split(',');
			settings.write8(booleans.length + images.length + integers.length);
			settings.write8(mode == 'm' ? 0 : mode == 'x' ? 1 : 2);
			settings.write8(coordinates.length);
			for (coordinate in coordinates) 
				settings.write16(Std.parseInt(coordinate));
		}
		return settings;
	}

	public static function parseXMLGrounds(packet: Packet, element: Xml): Void {
		var booleans: Array<String> = ['m', 'N', 'nosync'];
		var images: Array<String> = ['i'];
		var integers: Array<String> = ['c', 'H', 'L', 'lua', 'v', 'X', 'Y', 'T'];
		packet.write8(254);
		for (i in 0...booleans.length) 
			if (element.exists(booleans[i])) 
				packet.write8(i);
		for (i in 0...images.length) {
			if (element.exists(images[i])) {
				var img = element.get(images[i]);
				var x = Std.parseInt(img.split(',')[0]);
				var y = Std.parseInt(img.split(',')[1]);
				var url = img.split(',')[2];
				packet.write8(i + booleans.length);
				packet.write16(x);
				packet.write16(y);
				packet.writeString(url);
			}
		}
		for (i in 0...integers.length) {
			if (element.exists(integers[i])) {
				packet.write8(i + booleans.length + integers.length);
				packet.write16(Std.parseInt(element.get(integers[i])));
			}
		}
		if (element.exists('P')) {
			var data = element.get('P').split(',');
			while (data.length > 8)
				data.splice(8, 1);
			var dyn = data[0] == '1', mass = data[1],  fric = data[2], res = data[3], angle = data[4], fixrot = data[5] == '1', lindamp = data[6], angdamp = data[7];
			packet.write8(booleans.length + images.length + integers.length);
			packet.writeBool(dyn);
			
			if (fric.indexOf('e') != -1)
				packet.write16(0xFFFF);
			else
				packet.write16(Std.parseInt(fric) * 100);
			if (res.indexOf('q') != -1) 
				packet.write16(0xFFFF);
			else
				packet.write16(Std.parseInt(res) * 100);
			packet.write16(Std.parseInt(angle) * 100);
			if (dyn) {
				if (mass.indexOf('e') != -1)
					packet.write16(0xFFFFF);
				else
					packet.write16(Std.parseInt(mass));
				packet.writeBool(fixrot);
				packet.write16(Std.parseInt(lindamp) * 100);
				packet.write16(Std.parseInt(angdamp) * 100);
			}
		}
		if (element.exists('o') && element.get('o') != '') {
			packet.write8(booleans.length + images.length + integers.length + 1);
			packet.write8((Std.parseInt('0x' + element.get('o')) >>> 16) & 0xFF);
			packet.write16(Std.parseInt('0x' + element.get('o')));
		}
	}

	public static function parseXMLShaman(packet: Packet, element: Xml): Void {
		var booleans: Array<String> = ['nosync'];
		var integers: Array<String> = ['C', 'Mp', 'Mv', 'X', 'Y'];
		packet.write8(254);
		for (i in 0...booleans.length)
			if (element.exists(booleans[i]))
				packet.write8(i);
		for (i in 0...integers.length) {
			if (element.exists(integers[i])) {
				packet.write8(i + booleans.length);
				packet.write16(Std.parseInt(element.get(integers[i])));
			}
		}
		if (element.exists('P')) {
			packet.write8(booleans.length + integers.length);
			var data = element.get('P').split(',');
			packet.write16(Std.parseInt(data[0]));
			packet.writeBool(data.length > 1 && data[1] == '1'); // Ghost
		}
	}

	public static function parseXMLJoints(packet: Packet, element: Xml): Void {
		// trace(element);
	}

	public static function xml2gd(x: String): Packet {
		var root: Xml = Xml.parse(x);
		if (root.firstChild() != null && root.firstChild().nodeName != 'C')
			return null;

		var grounds: Packet = new Packet();
		var decorations: Packet = new Packet();
		var shaman: Packet = new Packet();
		var joints: Packet = new Packet();

		var settings: Packet = new Packet();
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
		var packet: Packet = new Packet();
		packet.writeBuffer(settings.buffer);
		packet.write8(0xff);
		packet.writeBuffer(grounds.buffer);
		packet.write8(0xff);
		packet.writeBuffer(decorations.buffer);
		packet.write8(0xff);
		packet.writeBuffer(shaman.buffer);
		packet.write8(0xff);
		packet.writeBuffer(joints.buffer);
		return packet;

	}
}