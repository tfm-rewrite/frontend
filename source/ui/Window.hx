package ui;

import js.Browser;
import js.html.Event;
import js.html.Element;
import haxe.ds.Map;

class Window extends Component
{
	@:isVar public var title(get, set): String;
	public var closable: Bool = false;
	public var titleField: TextField;
	public var textField: TextField;

	public function new(text: TextField, title: String = '', options: Map<String, Any> = null)
	{
		super('div', options);
		this.classes = ['x_window'];
		this.options = options != null ? options : [];
		this.width = this.options.exists('width') ? this.options.get('width') : 100;
		this.height = this.options.exists('height') ? this.options.get('height') : 100;
		this.closable = this.options.exists('closable') && this.options.get('closable') == true;
		this.width = js.lib.Math.max(100, this.width);
		this.height = js.lib.Math.max(100, this.height);
		var borders: Component = new Component('div', [
			'classes' => ['borders_' + (title != '' ? '2' : '1')],
			'x' => -50,
			'y' => -50
		]);
		if (title != '') {	
			this.titleField = new TextField(title, [
				'classes' => ['title'], 
				'width' => this.width + 45, 
				'height' => 50,
				'x' => -5,
				'y' => -10,
				'align' => TextField.CENTER,
				'size' => 25
			]);

			this.element.appendChild(titleField.element);
			this.title = title;
			this.element.style.backgroundImage = 'url(/assets/images/x_ui/wood.png)';
		}
		this.textField = text;
		this.textField.y = 10;
		this.textField.x = title != '' ? 50 : 10;
		var closeButton: Button = new Button(new TextField('Close', ['color' => 0xC2C2DA, 'align' => 'center']), this.delete, ['classes' => ['x_btn'], 'width' => this.width, 'x' => this.height - 20, 'y' => 12]);
		this.element.appendChild(closeButton.element);
		this.element.appendChild(borders.element);
		this.element.appendChild(this.textField.element);
	}

	public function set_title(value): String {
		if (this.titleField != null)
			this.element.getElementsByClassName('title').item(0).innerText = value;
		return this.title = value;
	}

	public function get_title(): String {
		return this.title;
	}


}