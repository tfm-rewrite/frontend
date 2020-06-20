package utils;
import openfl.utils.Object;
import openfl.utils.ByteArray;

class GameData {

	public static function parseXMLSettings(xml: Xml): ByteArray {
		var booleans: Array<String> = ['A', 'AIE', 'bh', 'C', 'Ca', 'mc', 'N', 'P'];
		var images: Array<String> = ['D', 'd'];
		var integers: Array<String> = ['F', 'mgoc', 'H', 'L'];
		var intlist: Array<String> = ['defilante', 'G'];
		var settings: ByteArray = new ByteArray();
		trace(xml);
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
	
	public static function xml2gd(x: String) {
		var root: Xml = Xml.parse(x);
		if (root.firstChild() != null && root.firstChild().nodeName != 'C')
			return;

		var grounds: ByteArray = new ByteArray();
		var decorations: ByteArray = new ByteArray();
		var shaman: ByteArray = new ByteArray();
		var joints: ByteArray = new ByteArray();

		var settings: ByteArray = new ByteArray();

		for (element in root.firstChild().elements()) {
			if (element.nodeName == 'P') 
				settings = GameData.parseXMLSettings(element);
			else if (element.nodeName == 'Z')
				trace('ZZZ');
		}
	}

}