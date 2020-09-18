package;

import ui.Element;
import js.Browser;

class Interface extends Element {
	public static final list: Map<String, Interface> = [];

	private var alreadyRun: Bool = false;
	public var name: String;
	@:isVar public var rendered(get, set): Bool = false;

	public function new(name: String) {
		super('div', [ 'position' => { x: 0, y: 0 }]);
		if (list.exists(name.toLowerCase()))
				return;
		this.attrs = ['id' => 'I_${name.toUpperCase()}'];
		this.style.width = '100%';
		this.style.height = '100%';
		this.name = name;
		list[this.name.toLowerCase()] = this;
	}
	
	public function get_rendered(): Bool {
		return Browser.document.getElementById('I_${this.name.toUpperCase()}') != null;
	}

	public function set_rendered(val: Bool): Bool {
		return this.rendered;
	}

	public function run(): Void {}
	
	override public function render(): Void {
		this.clearChilds();
		this.run();
		Browser.document.body.appendChild(this.element);
	}

	public static function getInterface(name: String): Interface {
		for (interf in list) 
			if (interf.name.toLowerCase() == name.toLowerCase())
				return interf;
		return null;
	}
}