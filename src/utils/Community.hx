package utils;

import haxe.Json;
import openfl.events.Event;
import openfl.net.URLLoader;
import openfl.net.URLRequest;
import openfl.net.URLLoaderDataFormat;
import haxe.Exception;

class Community {
	public static final list: Array<Community> = [];
	private static var currentLoadingLang: String = '';

	public var id: Int;
	public var code: String;
	public var flag: String = '';
	public var lang: String = '';
	public var data: Map<String, String>;

	public static final ENGLISH: Community = new Community('en', 0, 'gb');
	public static final ARABIC: Community = new Community('ar', 1, 'eg');

	public function new(code: String, id: Int, flag: String = '') {
		this.code = code.toLowerCase();
		this.flag = flag;
		if (this.code == 'xx')
			this.lang = 'en';
		else 
			this.lang = this.code;
		if (this.flag == '')
			this.flag = this.code;
		this.id = id;
		for (commu in list)
			if (commu.id == this.id || commu.code == this.code)
				throw new Exception('This community already exists.');
		list.push(this);
	}

	public static function get(by: String, value: Any): Community {
		for (commu in list) {
			var b: Any = by.toLowerCase() == 'flag' ? commu.flag : by.toLowerCase() == 'code' ? commu.code : by.toLowerCase() == 'id' ? commu.id : commu.lang;
			if (b == value)
				return commu;
		}
		return ENGLISH;
	}

	public static function loadLanguage(code: String): Void {
		code = code.toLowerCase();
		var req: URLRequest = new URLRequest('${Utils.languagesURI}$code.json?d=${js.lib.Date.now()}');
		var loader: URLLoader = new URLLoader();
		currentLoadingLang = code.toLowerCase();
		loader.dataFormat = URLLoaderDataFormat.TEXT;
		loader.addEventListener(Event.COMPLETE, onLoadedLanguage);
		loader.load(req);
	}

	private static function onLoadedLanguage(event: Event): Void {
		var loader: URLLoader = event.target;
		trace(loader.data);
		trace(Json.parse(loader.data));
	}	
}