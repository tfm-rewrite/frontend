package;

import haxe.Constraints.Function;
import openfl.utils.Dictionary;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.utils.Object;

class Config {
	public static var configures: Dictionary<String, Config> = new Dictionary();

	public var data: Object;
	public var dataString: String;
	private var path: String;
	private var callback: Function = null;

	public function new(path: String, callback: Function = null) {
		this.path = path;
		this.callback = callback;
		this.readJson();
	}

	public function readJson(): Void {
		var loader: URLLoader = new URLLoader();
		loader.addEventListener(Event.COMPLETE, onFileLoaded);
		loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		loader.load(new URLRequest(this.path));
	}

	private  function onIOError(event: IOErrorEvent): Void {
		trace("Couldn't load the file", this.path);
	}

	private function onFileLoaded(event: Event): Void {
		var loader: URLLoader = cast event.target;
		this.data = haxe.Json.parse(loader.data);
		this.dataString = loader.data;
		Config.configures[Utils.basename(this.path)] = this;
		if (this.callback != null)
			this.callback(this.data, this.dataString);
	}

	public function getValue(keyName: String): String
	{
		return this.data.hasOwnProperty(keyName) ? this.data[keyName] : null;
	}

	public static function getValueFrom(file: String, keyName: String): String {
		if (Config.configures[file] == null)
			return null;
		return Config.configures[file].getValue(keyName);
	}
}