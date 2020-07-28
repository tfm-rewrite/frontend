package connection;

import js.Browser;
import js.html.MessageEvent;
import js.html.WebSocket;
import js.lib.ArrayBuffer;
import js.html.Event;
import haxe.Timer;

class Connection {
	public static var secure: Bool = Browser.location.protocol.indexOf('https') == 0;

	public var name: String;
	public var client: Transformice;

	public var port: Int;

	public var protocol: TFMProtocol;
	public var transport: WebSocket;

	public var open: Bool;

	public function new(name: String, client: Transformice) {
		this.name = name;
		this.client = client;

		this.protocol = new TFMProtocol(this);
	}

	public function connect(host: String, port: Int, gitpod: Bool): Void {
		var address: String;
		this.port = port;

		if(gitpod) {
			address = "wss://" + port + "-" + host;
		} else if (this.secure) {
			address = "wss://" + host + ":" + port;
		} else {
			address = "ws://" + host + ":" + port;
		}

		this.transport = new WebSocket(this.address);
		this.transport.onmessage = this.on_message;
		this.transport.onopen = this.on_connected;
		this.transport.onerror = this.on_error;
		this.transport.onclose = this.on_close;
	}

	public function send(): Void {
		if(!this.open)
			return;
	}

	public function on_message(msg: MessageEvent): Void {
		if (Std.isOfType(msg.data, Blob)) {
			msg.data.arrayBuffer().then(buff => {
				this.protocol.data_received(buff);
			});
		}
	}

	public function on_connected(evt: Event): Void {
		this.checkerTimer.stop();
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