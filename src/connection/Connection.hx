package connection;

// import utils.InterfaceDebug;
import haxe.Json;
import js.html.CloseEvent;
import js.lib.Promise;
import js.html.Blob;
import utils.Packet;
import js.Browser;
import js.html.MessageEvent;
import js.html.WebSocket;
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

	public function connect(host: String, port: Int, gitpod: Bool): Promise<WebSocket> {
		var address: String;
		this.port = port;
		return new Promise(function(resolve: (WebSocket) -> Void, reject: (Dynamic) -> Void) {
			if (gitpod) 
				address = 'wss://${port}-${host}';
			else if (Connection.secure)
				address = 'wss://${host}:${port}';
			else
				address = 'ws://${host}:${port}';
			this.transport = new WebSocket(address);
			this.transport.onopen = (event: Event) -> {
				var ws: WebSocket = cast event.target;
				resolve(ws);
				ws.removeEventListener('error', ws.onerror);
				this.on_connected(event);
				ws.onclose = this.on_close;
				ws.onmessage = this.on_message;
				ws.onerror = this.on_error;
			}
			this.transport.onerror = (event: Event) -> {
				var target: WebSocket = cast event.target;
				if (target.readyState != 1)
					reject("Couldn't connect to server.");
			}
		});
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