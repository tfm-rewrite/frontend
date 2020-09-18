package utils;

import js.lib.Error;
import js.html.TextDecoder;
import js.html.TextEncoder;
import js.lib.Math;
import js.lib.ArrayBuffer;
import js.lib.Uint8Array;

class Packet {
	public var readable: Bool;
	public var length: Int = 0;

	public var buffer: Uint8Array;

	public var pointer: Int;

	public var ciphered: Bool;
	public var allocated: Int;

	public function new(data: Any = null, cc: Int = -1, size: Int = 2) {
		if(Std.isOfType(data, Int)) { // writable packet
			this.readable = false;
			this.ciphered = false;
			this.allocated = 0;
			this.buffer = new Uint8Array(0);
			this.allocate(size, false); // approximate size of the packet (to make this faster)

			if(cc == -1) {
				this.write16(data); // ccc
			} else {
				this.write8(data).write8(cc); // c, cc
			}
		} else { // readable packet
			this.readable = true;
			this.pointer = 0;
			this.buffer = new Uint8Array(data); // ArrayBuffer to Uint8Array
			this.length = this.buffer.length;
		}
	}


	public function destroy() {
		this.length = 0;
		this.buffer = new Uint8Array(0);

		if(this.readable) {
			this.pointer = 0;
		} else {
			this.ciphered = false;
			this.allocated = 0;
		}
	}

	/***********************************/
	/*         WRITE FUNCTIONS         */
	/***********************************/

	public function allocate(size: Int, extra: Bool = true): Void {
		// This function allocates extra bytes in the buffer
		// We allocate `size` which is the needed size plus some extra bytes
		// this way, we have the size to write the data we need and
		// some possible allocations can be skipped.

		// using a big number will make it faster, but use more memory (call less allocations)
		// using a small number will make it slower, but use less memory (call more allocations)
		if(extra) {
			this.allocated += size + 30;
		} else {
			this.allocated += size;
		}

		var data: Uint8Array = this.buffer;
		this.buffer = new Uint8Array(this.allocated);
		this.buffer.set(data, 0);
	}

	public function grow(size: Int): Void {
		// This function grows the length pointer and allocates bytes if needed.

		this.length += size;
		if(this.length > this.allocated) {
			this.allocate(this.length - this.allocated);
		}
	}

	// These write functions support both signed and unsigned writes.
	public function write8(byte: Int): Packet {
		this.grow(1);
		this.buffer[this.length - 1] = byte & 0xff;
		return this;
	}

	public function write16(short: Int): Packet {
		this.grow(2);

		this.buffer[this.length - 2] = (short >> 8) & 0xff;
		this.buffer[this.length - 1] = short & 0xff;

		return this;
	}

	public function write24(word: Int): Packet {
		this.grow(3);

		this.buffer[this.length - 3] = (word >> 16) & 0xff;
		this.buffer[this.length - 2] = (word >> 8) & 0xff;
		this.buffer[this.length - 1] = word & 0xff;

		return this;
	}

	public function write32(int: Int): Packet {
		this.grow(4);

		this.buffer[this.length - 4] = (int >> 24) & 0xff;
		this.buffer[this.length - 3] = (int >> 16) & 0xff;
		this.buffer[this.length - 2] = (int >> 8) & 0xff;
		this.buffer[this.length - 1] = int & 0xff;

		return this;
	}

	public function writeBool(bool: Bool): Packet {
		return this.write8(bool ? 1 : 0);
	}

	public function writeBuffer(buffer: Uint8Array) {
		this.grow(buffer.length);
		this.buffer.set(buffer, this.length - buffer.length);
		return this;
	}
	    
	public function writeRawString(string: String) {
		return this.writeBuffer(Utils.stringToBuffer(string));
	}

	public function writeString(string: String): Packet {
		var desired: Int = this.length + string.length + 2;
		if(desired > this.allocated) {
			this.allocate(desired - this.allocated);
		}

		this.write16(string.length);
		this.buffer.set(Utils.stringToBuffer(string), this.length);
		this.length += string.length;

		return this;
	}

	public function writeLongString(string: String): Packet {
		var desired: Int = this.length + string.length + 3;
		if(desired > this.allocated) {
			this.allocate(desired - this.allocated);
		}

		this.write24(string.length);
		this.buffer.set(Utils.stringToBuffer(string), this.length);
		this.length += string.length;

		return this;
	}

	public function writeBigString(string: String): Packet {
		var desired: Int = this.length + string.length + 4;
		if(desired > this.allocated) {
			this.allocate(desired - this.allocated);
		}

		this.write32(string.length);
		this.buffer.set(Utils.stringToBuffer(string), this.length);
		this.length += string.length;

		return this;
	}

	public function cipher(?sequenceId: Int, ?key: Array<Int>): Packet {
		if(sequenceId == null || key == null) {
			this.ciphered = true;
		} else {
			for(index in 2...this.length) {
				this.buffer[index] ^= key[(index + sequenceId - 1) % key.length];
			}
		}

		return this;
	}

	public function export(sequenceId: Int, ?key: Array<Int>): Uint8Array {
		if(this.ciphered && key != null) {
			this.cipher(sequenceId, key);
		}

		var size: Int = this.length;
		var size_type: Int = size >> 7;
		var header: Array<Int> = [];

		while(size_type != 0) {
			header.push(size & 0x7f | 0x80);
			size = size_type;
			size_type >>= 7;
		}
		header.push(size & 0x7f);
		header.push(sequenceId);

		var packet: Uint8Array = new Uint8Array(header.length + this.length);
		packet.set(header, 0);
		if(this.allocated > this.length) {
			packet.set(this.buffer.slice(0, this.length), header.length);
		} else {
			packet.set(this.buffer, header.length);
		}
		return packet;
	}


	/***********************************/
	/*          READ FUNCTIONS         */
	/***********************************/

	public function read(size: Int): Void {
		// This function checks if you can read this quantity of bytes
		// Throws an error if you can't.

		this.pointer += size;
		if(this.pointer > this.length) {
			throw new Error("Reading past packet end");
		}
	}

	// Even if when writing we use a single function for writing both
	// signed and unsigned integers, we need to use one function or the other to read.
	public function read8(): Int {
		this.read(1);
		return (
			this.buffer[this.pointer - 1]
		);
	}

	public function read16(): Int {
		this.read(2);
		return (
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);
	}

	public function read24(): Int {
		this.read(3);
		return (
			(this.buffer[this.pointer - 3] << 16) +
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);
	}

	public function read32(): Int {
		this.read(4);
		return (
			(this.buffer[this.pointer - 4] << 24) +
			(this.buffer[this.pointer - 3] << 16) +
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);
	}

	public function readS8(): Int {
		this.read(1);
		var byte: Int = (
			this.buffer[this.pointer - 1]
		);

		if((byte & 0x80) > 0) {
			return -0x80 + (byte & 0x7f); // invert the bits
		}
		return byte;
	}

	public function readS16(): Int {
		this.read(2);
		var short: Int = (
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);

		if((short & 0x8000) > 0) {
			return -0x8000 + (short & 0x7fff);
		}
		return short;
	}

	public function readS24(): Int {
		this.read(3);
		var word: Int = (
			(this.buffer[this.pointer - 3] << 16) +
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);

		if((word & 0x800000) > 0) {
			return -0x800000 + (word & 0x7fffff);
		}
		return word;
	}

	public function readS32(): Int {
		this.read(4);
		var int: Int = (
			(this.buffer[this.pointer - 4] << 24) +
			(this.buffer[this.pointer - 3] << 16) +
			(this.buffer[this.pointer - 2] << 8) +
			this.buffer[this.pointer - 1]
		);

		if((int & 0x80000000) > 0) {
			return -0x80000000 + (int & 0x7fffffff);
		}
		return int;
	}

	public function readBool(): Bool {
		return this.read8() == 1;
	}

	public function readString(): String {
		var length: Int = this.read16();

		this.read(length);
		return Utils.bufferToString(
			this.buffer.slice(this.pointer - length, this.pointer)
		);
	}

	public function readLongString(): String {
		var length: Int = this.read24();

		this.read(length);
		return Utils.bufferToString(
			this.buffer.slice(this.pointer - length, this.pointer)
		);
	}

	public function readBigString(): String {
		var length: Int = this.read32();

		this.read(length);
		return Utils.bufferToString(
			this.buffer.slice(this.pointer - length, this.pointer)
		);
	}

	public function toString(): String {
		var s: String = '';
		for (i in 0...this.length)
			s += ( '0' + StringTools.hex(this.buffer[i])).substr(-2,2) + ' ';
		
		return s;
	}
}