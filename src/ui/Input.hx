package ui;

import js.html.KeyboardEvent;
import js.html.InputElement;
import js.Browser;


typedef InputLimit = {
	min: Int,
	max: Int
}

class Input extends Element {

	private var inptElement: InputElement;


	@:isVar public var type(get, set): String;
	@:isVar public var value(get, set): String;
	@:isVar public var placeholder(get, set): String;
	@:isVar public var limitations(get, set): InputLimit;
	@:isVar public var required(get, set): Bool;

	public function new(?options: Map<String, Dynamic>) {
		super('input', options);
		this.inptElement = cast this.element;
		this.inptElement.autocomplete = 'off';
	}

	public function setCustomValidty(value: String): Void {
		this.inptElement.setCustomValidity(value);
	}
	public function reportValidty(): Bool {
		return this.inptElement.reportValidity();
	}

	public function set_value(value: String): String {
		return this.inptElement.value = value;
	}
	public function get_value(): String {
		return this.inptElement.value;
	}

	public function set_placeholder(value: String): String {
		return this.inptElement.placeholder = value;
	}
	public function get_placeholder(): String {
		return this.inptElement.placeholder;
	}

	public function set_limitations(value: InputLimit): InputLimit {
		this.inptElement.maxLength = value.max;
		this.inptElement.minLength = value.min;
		return value;
	}
	public function get_limitations(): InputLimit {
		return {
			max: this.inptElement.maxLength,
			min: this.inptElement.minLength
		}
	}

	public function set_type(value: String): String {
		return this.inptElement.type = value;
	}
	public function get_type(): String {
		return this.inptElement.type;
	}

	public function set_required(value: Bool): Bool {
		return this.inptElement.required = value;
	}
	public function get_required(): Bool {
		return this.inptElement.required;
	}

	public function allow(reg: EReg): Void {
		this.inptElement.onkeypress = (e: KeyboardEvent) -> {
			if (!reg.match(String.fromCharCode(e.keyCode))) e.preventDefault();
		}
    }

    public function block(reg: EReg) {
		this.inptElement.onkeypress = (e: KeyboardEvent) -> {
			if (reg.match(String.fromCharCode(e.keyCode))) e.preventDefault();
		}
	}
	
}