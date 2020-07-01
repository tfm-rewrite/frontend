package ui;

import utils.Sounds;
import haxe.Constraints.Function;
import haxe.ds.Map;
import js.Browser;
import js.html.Element;
class Button extends Component
{



	public var textField: TextField;
	@:isVar public var callback(get, set): Function;

	public function new(text: TextField, callback: Function, options: Map<String, Any> = null)
	{
		super('button', options);
		this.options = options != null ? options : [];
		this.textField = text;
		this.textField.element.style.position = 'relative';
		this.element.appendChild(this.textField.element);
		this.callback = callback;
		this.element.addEventListener('mousedown', Sounds.MOUSE_CLICK.play);
	}

	public function set_callback(func: Function): Function {
		this.element.onclick = func;
		return this.callback = func;
	}

	public function get_callback(): Function {
		return this.callback;
	}

}