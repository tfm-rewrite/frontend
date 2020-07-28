package connection;

import js.lib.Uint8Array;
import js.lib.ArrayBuffer;

class Protocol {
	public var bufferLength: Int = 1024 * 1024 * 50; // 50mb

	public var buffer: Uint8Array;
	public var start: Int = 0;
	public var end: Int = 0;
	public var expecting: Int = 0;

	public var connection: Connection;

	public function new(connection: Connection) {
		this.connection = connection;
	}

	public function orderBuffer(): Void {
		if (this.start < this.end) { // if there are bytes to read
			// we move the buffer to the start
			var readable: Buffer = this.buffer.slice(this.start, this.end);
			this.buffer.set(readable, 0);
		}
		// we set the pointers to where the data is
		this.end -= this.start; // start can't be greater than end, just equal
		this.start = 0;
	}

	public function data_received(data: ArrayBuffer): Void {
		this.buffer.set(data, this.end); // add data to the buffer
		this.end += data.length; // and move the end pointer

		while(this.end - this.start > this.expecting) {
			if (this.expecting == 0) {
				for (i in 0 ... 5) {
					if(this.start + i + 1 >= this.end) {
						this.expecting = 0;
						return;
					}
					byte = this.buffer[this.start + i + 1];
					this.expecting |= (byte & 127) << (i * 7);

					if(!(byte & 0x80)) {
						this.start += i + 2;
						break;
					}
				}

				if(this.expecting == 0) {
					continue;
				} else if (this.expecting < 2) {
					// disconnect
					break;
				}
			}

			if(this.end - this.start >= this.expecting) {
				this.connection.client.on_data_received(
					this.buffer.slice(this.start, this.start + this.expecting),
					this.connection
				);
				this.start += this.expecting;
				this.expecting = 0;
			}
		}
	}

	public function connection_made(): Void {
		this.connection.open = true;
		this.connection.client.on_connection_made(this.connection);

		this.buffer = new Uint8Array(this.bufferLength);
	}

	public function connection_lost(): Void {
		this.connection.open = false;
		this.connection.client.on_connection_lost(this.connection);

		this.buffer = new Uint8Array(0);
	}
}