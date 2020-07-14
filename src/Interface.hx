package;

import haxe.Exception;
import haxe.macro.Expr.Error;
import openfl.Lib;
import js.html.Element;
import js.Browser;
import ui.Component;

class Interface extends Component {
	public static final list: Array<Interface> = [];

	public var name: String;
	@:isVar public var rendered(get, set): Bool = false;

	public function new(name: String) {
		super('div');
		for (interf in list) {
			if (interf.name.toLowerCase() == name.toLowerCase())
				return;
		}
		this.element.id = 'I_${name.toUpperCase()}';
		this.x = 0;
		this.y = 0;
		this.width = Browser.window.innerWidth;
		this.height = Browser.window.innerHeight;
		this.name = name;
		list.push(this);
	}
	
	public function get_rendered(): Bool {
		return Browser.document.getElementById('I_${this.name.toUpperCase()}') != null;
	}

	public function set_rendered(val: Bool): Bool {
		return this.rendered;
	}

	public function main(): Element {return null;}
	public function render(): Void {
		this.element.appendChild(this.main());
		Browser.document.body.appendChild(this.element);
	}

	public static function get(name: String): Interface {
		for (interf in list) 
			if (interf.name.toLowerCase() == name.toLowerCase())
				return interf;
		return null;
	}
}