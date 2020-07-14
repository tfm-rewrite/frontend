package ui;

import js.Browser;
import haxe.Constraints.Function;
import js.html.InputElement;

class Input {
	public static var listInputs: Array<Input> = [];
	public var options: Map<String, Any>;
	public var events: Map<String, Function>;
	public var element: InputElement;

	@:isVar public var value(get, set): String;
	@:isVar public var x(get, set): Int;
	@:isVar public var y(get, set): Int;
	@:isVar public var classes(get, set): Array<String>;
	@:isVar public var width(get, set): Int;
	@:isVar public var height(get, set): Int;

	public function new(options: Map<String, Any> = null) {
		this.element = Browser.document.createInputElement();
		this.options = options != null ? options : [];
		this.x = this.options.exists('x') ? this.options.get('x') : 0;
		this.y = this.options.exists('y') ? this.options.get('y') : 0;
		this.events = this.options.exists('events') ? this.options.get('events') : [];
		this.classes = this.options.exists('classes') ? this.options.get('classes') : [];
		this.element.hidden = this.options.exists('hidden') && this.options.get('hidden') == true;
		this.element.style.position = 'absolute';
		this.element.style.zIndex = Std.string(Component.listComponents.length + Input.listInputs.length);
		for (key in this.events.keys())
			this.element.addEventListener(key.toLowerCase(), this.events.get(key));
		Input.listInputs.push(this);
	}

	public function set_classes(value: Array<String>): Array<String> {
		this.element.className = value.join(' ');
		return this.classes = value;
	}

	public function get_classes(): Array<String> {
		return this.classes;
	}

	public function set_value(value: String): String {
		this.element.value = value;
		return this.value = value;
	}

	public function get_value(): String {
		return this.element.value;
	}

	public function set_x(value: Int): Int {
		this.element.style.top = value + 'px';
		return this.x = value;
	}

	public function get_x(): Int {
		return this.x;
	}

	public function set_y(value: Int): Int {
		this.element.style.left = value + 'px';
		return this.y = value;
	}

	public function get_y(): Int {
		return this.y;
	}

	public function set_width(value: Int): Int {
		this.element.style.minWidth = value + 'px';
		return this.width = value;
	}

	public function get_width(): Int {
		return this.width;
	}
	public function set_height(value: Int): Int {
		this.element.style.minHeight = value + 'px';
		return this.height = value;
	}

	public function get_height(): Int {
		return this.height;
	}

	public function centralize(): Void {
		this.element.style.top = '50%';
		this.element.style.left = '50%';
		this.element.style.transform = 'translate(-50%, -50%)';
	}

	public function delete(): Void {
		this.element.remove();
	}
}