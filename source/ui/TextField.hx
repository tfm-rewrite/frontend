package ui;

import openfl.utils.Object;

class TextField
{

	public var text: String;
	public var type: String;
	public var width: String;
	public var height: String;
	public var options: Object;

	public function new(text: String = "", type: String = "normal", options: Object = null)
	{
		this.text = text;
		this.type = type;
		this.options = options != null ? options : new Object();
		this.width = this.options.hasOwnProperty("width") ? this.options["width"] : "10px";
		this.height = this.options.hasOwnProperty("height") ? this.options["height"] : "10px";
		this.checkType();
	}

	public function display(): Void
	{

	}

	public function checkType(): Void
	{
		switch (this.type)
		{
			case "X":
		}
	}
}