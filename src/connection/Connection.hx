package connection;

import js.html.Blob;
import utils.Packet;
import js.Browser;
import js.html.MessageEvent;
import js.html.WebSocket;
import js.lib.ArrayBuffer;
import js.html.Event;

class Connection {
	public static var secure: Bool = Browser.location.protocol.indexOf('https') == 0;

	public var sequenceId: Int;

	public var name: String;
	public var client: Transformice;

	public var port: Int;

	public var protocol: Protocol;
	public var transport: WebSocket;

	public var open: Bool;

	public function new(name: String, client: Transformice) {
		this.name = name;
		this.client = client;

		this.protocol = new Protocol(this);
		this.sequenceId = 0;
	}

	public function connect(host: String, port: Int, gitpod: Bool): Void {
		var address: String;
		this.port = port;

		if(gitpod) {
			address = "wss://" + port + "-" + host;
		} else if (Connection.secure) {
			address = "wss://" + host + ":" + port;
		} else {
			address = "ws://" + host + ":" + port;
		}

		this.transport = new WebSocket(address);
		this.transport.onmessage = this.on_message;
		this.transport.onopen = this.on_connected;
		this.transport.onerror = this.on_error;
		this.transport.onclose = this.on_close;
	}

	public function send(packet: Packet, destroy: Bool = true): Void {
		if(!this.open) {
			if(destroy)
				packet.destroy();
			return;
		}

		this.transport.send(packet.export(this.sequenceId));
		this.sequenceId = (this.sequenceId + 1) % 256;

		if(destroy)
			packet.destroy();
	}

	public function on_message(msg: MessageEvent): Void {
		if (Std.isOfType(msg.data, Blob)) {
			msg.data.arrayBuffer().then(function(buff) {
				this.protocol.data_received(buff);
			});
		}
	}

	public function on_connected(evt: Event): Void {
		this.protocol.connection_made();
	}

	public function on_error(evt: Event): Void {
		this.protocol.connection_lost();
	}

	public function on_close(): Void {
		this.protocol.connection_lost();
	}

	public function close(): Void {
		if(!this.open)
			return;

		this.transport.close();
	}
}