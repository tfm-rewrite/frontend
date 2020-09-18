package utils;

import haxe.crypto.Base64;
import haxe.io.BytesData;
import haxe.io.Bytes;
import haxe.crypto.Sha256;
using StringTools;

import js.lib.Object;
import js.lib.Uint8Array;
import js.html.TextEncoder;
import js.html.TextDecoder;

class Utils {
	public static var useGitpod: Bool = false;
	public static var gitpod: String = 'e97c74e5-3eda-4261-a29f-3ac3f9416fca.ws-eu01.gitpod.io/';
	public static var host: String = '127.0.0.1';
	public static var ports: Array<Int> = [2020, 2030];
	public static var languagesURI: String = 'http://127.0.0.1:2000/langs/get/';

	public static var unicodeEncoder: TextEncoder = new TextEncoder();
	public static var unicodeDecoder: TextDecoder = new TextDecoder("utf-8");

	public static function fromByteArray(array: Uint8Array): String {
		var s: String = '';
		for (i in 0...array.length)
			s += ( '0' + StringTools.hex(array[i])).substr(-2, 2) + ' ';
		
		return s;
	}

	public static function stringToBuffer(string: String): Uint8Array {
		return Utils.unicodeEncoder.encode(string);
	}

	public static function bufferToString(buffer: Uint8Array): String {
		return Utils.unicodeDecoder.decode(buffer);
	}

	public static function object2map(object: Object): Map<String, Dynamic> {
		var result: Map<String, Dynamic> = [];
		for (entry in Object.entries(object)) {
			if (Std.isOfType(entry.value, Object)) 
				result.set(entry.key, Utils.object2map(entry.value));
			else
				result.set(entry.key, entry.value);
		
		}
		return result;
	}
}

class StringUtil {
	public static function format(value: String, values: Array<Dynamic>): String {
		if (values == null) return value;
		for (i in 0...values.length)
			value =  value.replace('{$i}', values[i]);
		return value;
	}

	public static function toHex(value: String): String {
		var result: String = '';
		for (i in 0...value.length)
			result += StringTools.hex(value.charCodeAt(i));
		return result;
	}

	public static function shakikoo(value: String): String {
		var kikooHex: String = toHex(Sha256.encode(value));
		var salt: Array<Int> = [-9, 26, -90, -34, -113, 23, 118, -88, 3, -99, 50, -72, -95, 86, -78, -87, 62, -35, 67, -99, -59, -35, -50, 86, -45, -73, -92, 5, 74, 13, 8, -80];
		var kikoo: Bytes = Bytes.ofHex(kikooHex);
		var kikooBytes: Bytes = Bytes.ofData(new BytesData(kikoo.length+ salt.length));
		var saltBytes: Bytes = Bytes.ofData(new BytesData(32));
		for (i in 0...salt.length)
			saltBytes.set(i, salt[i]);
		kikooBytes.blit(0, kikoo, 0, kikoo.length);
		kikooBytes.blit(kikoo.length, saltBytes, 0, saltBytes.length);
		return Base64.encode(Sha256.make(kikooBytes));
	}
}