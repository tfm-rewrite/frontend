import js.html.Event;
import js.html.WebSocket;

class Connection {
	private var ws: WebSocket;

	function new(ip: String = '127.0.0.1', port: Int = 666) {
		this.ws = new WebSocket('ws://${ip}:${port}');
		this.ws.addEventListener('open', this.connectionOpen);
	}

	private function connectionOpen(event) {
		trace('connected successfully');
	}

	private function dataReceived(event) {
		trace(event.data);
	}


}