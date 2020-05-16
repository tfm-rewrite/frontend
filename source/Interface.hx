package;

import starling.text.TextField;
import openfl.display.Sprite;
import openfl.utils.Dictionary;

class Interface extends Sprite
{
	public static final list: Dictionary<String, Interface> = new Dictionary();

	public var interfaceName: String;

	public function new(name: String) {
		super();
		this.interfaceName = name;
		Interface.list[name] = this;
	}
}