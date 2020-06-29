package ui;

import haxe.Constraints.Function;
import haxe.ds.Map;
import js.Browser;
import js.html.Element;
class TextField extends Component
{

	public static var CENTER: String = 'center';
	public static var LEFT: String = 'left';
	public static var RIGHT: String = 'right';


	public var isHTML: Bool = false;

	@:isVar public var text(get, set): String;
	@:isVar public var color(get, set): Int;
	@:isVar public var size(get, set): Int;
	@:isVar public var align(get, set): String;

	public function new(text: String = '', options: Map<String, Any> = null)
	{
		super('div', options);
		this.options = options != null ? options : [];
		this.text = text;
		this.isHTML = this.options.exists('isHTML') && this.options.get('HTML') == true;
		this.width = this.options.exists('width') ? this.options.get('width') : text.length + 20;
		this.height = this.options.exists('height') ? this.options.get('height') : 20;
		this.color = this.options.exists('color') ? this.options.get('color') : 0xffffff;
		this.size = this.options.exists('size') ? this.options.get('size') : 16;
		this.align = this.options.exists('align') ? this.options.get('align') : 'left';
	}


	public function set_align(value): String {
		this.element.style.textAlign = value == 'right' || value == 'left' || value == 'center' ? value : 'left';
		this.element.style.direction = value == 'right' ? 'rtl' : 'ltr';
		return this.align = value;
	}

	public function get_align(): String {
		return this.align;
	}


	public function set_size(value: Int): Int {
		this.element.style.fontSize = value + 'px';
		return this.size = value;
	}

	public function get_size(): Int {
		return this.size;
	}

	public function set_color(value: Int): Int {
		var colorHex: String = '#' + StringTools.hex(value);
		this.element.style.color = colorHex;
		return this.color = value;
	}

	public function get_color(): Int {
		return this.color;
	}

	public function set_text(value): String {
		this.isHTML ? this.element.innerHTML = value : this.element.innerText = value;
		return this.text = value;
	}

	public function get_text(): String {
		return this.text;
	}
}