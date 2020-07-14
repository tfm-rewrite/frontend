package utils;

import js.lib.Uint8Array;
import openfl.utils.ByteArray;

class Utils {
	public static var gitpod: String = 'e0b367be-e3a4-4b4d-aec2-1cc984477096.ws-eu01.gitpod.io';
	public static var host: String = '127.0.0.1';
	public static var ports: Array<Int> = [6666];
	public static var languagesURI: String = 'http://127.0.0.1:801/languages/';

	public static function fromByteArray(array: Uint8Array): String {
		var s: String = '';
		for (i in 0...array.length)
			s += ( '0' + StringTools.hex(array[i])).substr(-2,2) + ' ';
		
		return s;
	}

	public static function subytearray(array: ByteArray, start: Int, end: Int = 0): ByteArray {
		if (end == 0)
			end = array.length;
		var arr: ByteArray = new ByteArray();
		for (i in start...end) {
			if (array[i] == null) break;
			arr.writeByte(array[i]);
		}
		return arr;
	}
}