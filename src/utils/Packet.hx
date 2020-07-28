package utils;

import js.lib.Error;
import js.html.TextDecoder;
import js.html.TextEncoder;
import js.lib.Math;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;

class Packet {

	public var buffer: Uint8Array = new Uint8Array(0);
	public var length: Int = 0;
	public var read_position: Int = 0;
	public var write_position: Int = 0;
	
	public function new(v: Any = null, CC: Int = -1) {
		if (Std.isOfType(v, ArrayBuffer)) {
			this.buffer = new Uint8Array(v);
			this.length = this.buffer.length;
			this.write_position = this.length;
		} else if (Std.isOfType(v, Uint8Array)) {
			this.buffer = cast(v, Uint8Array);
			this.length = this.buffer.length;
			this.write_position = this.length;
		} else if (Std.isOfType(v, Int) && CC == -1) 
			this.write16(v);
		else if (Std.isOfType(v, Int) && CC > 0)
			this.write8(v).write8(CC);
	}

	public function writeBool(value: Bool): Packet {
		this.expand(1);
		this.buffer[this.write_position++] = value ? 1 : 0;
		return this;
	}

	public function write8(value: Int): Packet {
		this.expand(1);
		this.buffer[this.write_position++] = value & 0xff;
		return this;
	}

	public function write16(value: Int): Packet {
		this.expand(1);
		this.buffer[this.write_position++] = value >> 8 & 0xff;
		this.write8(value);
		return this;
	}

	public function write24(value: Int): Packet {
		this.expand(1);
		this.buffer[this.write_position++] = value >> 16 & 0xff;
		this.write16(value);
		return this;
	}

	public function write32(value: UInt): Packet {
		this.expand(1);
		this.buffer[this.write_position++] = value >> 24 & 0xff;
		this.write24(value);
		return this;
	}

	public function writeBytes(value: Uint8Array, offset: Int = -1): Packet {
		this.expand(value.length);
		this.buffer.set(value, offset == -1 ? this.write_position : offset);
		this.write_position += value.length;
		return this;
	}

	public function writeRawSrting(value: String): Packet {
		var strarr: Uint8Array = new TextEncoder().encode(value);
		this.expand(strarr.length);
		this.buffer.set(strarr, this.write_position);
		this.write_position += strarr.length;
		return this;
	}
	
	public function writeString(value: String): Packet {
		this.write16(value.length);
		this.writeRawSrting(value);
		return this;
	}

	public function read8(): Int {
		this.overflow(1);
		return this.buffer[this.read_position++] & 0xff;
	}

	public function readBool(): Bool {
		return this.read8() == 1;
	}
	public function read16(): Int {
		return this.read8() << 8 | this.read8(); 
	}

	public function read24(): Int {
		return this.read8() << 16 | this.read16();
	}

	public function read32(): UInt {
		return this.read8() << 24 | this.read24();
	}

	public function readBytes(length: Int, start: Int = -1, end: Int = -1): Uint8Array {
		this.overflow(length);
		this.read_position += length;
		return this.buffer.subarray(start == -1 ? this.read_position - length : start, end == -1 ? this.length : end);
	}

	public function readRawString(size: Int): String {
		this.overflow(size);
		this.read_position += size;
		return new TextDecoder().decode(this.buffer.subarray(this.read_position - size, this.read_position));
	}

	public function readString(): String {
		return this.readRawString(this.read16());
	}

	private function overflow(size: Int): Void {
		if (this.read_position + size > this.length)
			throw new Error('Packet overflow');
	}

	private function expand(size: Int): Void {
		this.length = this.write_position + size;
		if (this.length > this.buffer.length) {
			var buff: Uint8Array = new Uint8Array(this.length);
			buff.set(this.buffer);
			this.buffer = buff;
		}
	}

	public function export(fingerprint: Int): ArrayBuffer {
		var pack: Packet = new Packet();
		var size: Int = this.length;
		var sizeType: Int = size >>> 7;
		while (sizeType != 0) {
			pack.write8(size & 0x7F | 0x80);
			size = sizeType;
			sizeType >>= 7;
		}
		pack.write8(size & 0x7F);
		pack.write8(fingerprint);
		var ret: Packet = new Packet();
		ret.writeBytes(pack.buffer).writeBytes(this.buffer);
		return ret.buffer.buffer;
	}

	public function toString(): String {
		var s: String = '';
		for (i in 0...this.buffer.length)
			s += ( '0' + StringTools.hex(this.buffer[i])).substr(-2,2) + ' ';
		
		return s;
	}
}