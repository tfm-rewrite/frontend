package connection;

import utils.InterfaceDebug;
import js.lib.Error;
import haxe.Timer;
import js.lib.Uint8Array;
import js.lib.ArrayBuffer;
import js.lib.Promise;
import js.html.Blob;
import js.html.MessageEvent;
import packets.main.send.information.Identification;
import utils.Packet;
import js.html.Event;
import js.Browser;
import js.html.Location;
import utils.Utils;
import js.html.WebSocket;

class Connection {

	public var protocol: Protocol;
	public var name: String;
	public var address: String;
	public var fingerprint: Int = 0;
	public var open: Bool = false;
	public var transport: WebSocket;
	public static var main: Connection = new Connection('main');
	public static var bulle: Connection;

	public function new(name: String) {
		this.protocol = new Protocol(this);
		this.name = name.toLowerCase();
	}

	public function connect(host: String = '', port: Int = 6666): Void {
		try {
			if (Utils.gitpod != '')	 
				this.address = 'wss://$port-${Utils.gitpod}';
			else
				this.address = '${Browser.location.protocol.indexOf('https') == 0 ? 'wss' : 'ws'}://${host == '' ? Utils.host : host}:$port';
			this.transport = new WebSocket(this.address);

			this.transport.onmessage = this.messageReceived;
			this.transport.onerror = this.errorHandler;
			this.transport.onopen = this.ready;
			this.transport.onclose = function() {
				this.open = false;
				Interface.list.map(function(inter) {
					inter.element.remove();
					return null;
				});
				Transformice.instance.world.removeChildren();
				Transformice.instance.removeChildren();
				InterfaceDebug.instance = null;
				InterfaceDebug.display();
			};
		} catch (error: Error) {
			trace(error);
		}
	}

	public function messageReceived(msg: MessageEvent): Void {
		if (Std.isOfType(msg.data, Blob)) {
			var promise: Promise<Any> = msg.data.arrayBuffer();
			promise.then(function(buff) {
				var ab: ArrayBuffer = buff;
				this.protocol.dataRecieve(new Uint8Array(ab));
			}).catchError(function(err) {});
		}
	}

	public function errorHandler(err: Event): Void {
		this.open = false;
	}

	public function ready(event: Event): Void {

		this.open = true;
		this.send(new Identification());
	}

	public function send(packet: Packet, cipher: Bool = false): Void {
		if (!this.open) 
			return;
		if (cipher)
			return;
		this.transport.send(packet.export(this.fingerprint));
		this.fingerprint = (this.fingerprint + 1) % 100;
	}
}