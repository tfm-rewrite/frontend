package utils;
import haxe.http.HttpJs;
import haxe.Json;

class Community {
	public static final list: Array<Community> = [];
	private static var currentLoadingLang: String = '';

	public var id: Int;
	public var code: String;
	public var flag: String = '';
	public var lang: String = '';
	public var name: String = '';

	public static final ENGLISH: Community = new Community('en', 0, 'English', 'gb');
	public static final ARABIC: Community = new Community('ar', 1, 'العربية', 'sa');
	
	public function new(code: String, id: Int, name: String, flag: String = '') {
		this.code = code.toLowerCase();
		this.name = name;
		this.flag = flag == '' ? this.code : flag;
		this.lang = this.code == 'xx' ? 'en' : this.code;
		this.id = id;
		new Language(this.lang);
		for (commu in list)
			if (commu.id == this.id || commu.code == this.code)
				throw 'This community already exists.';
		list.push(this);
	}
}