package utils;
import openfl.Lib;
import openfl.text.TextFormat;
import openfl.geom.ColorTransform;
import openfl.text.TextField;
import openfl.display.Sprite;
import openfl.text.TextFormatAlign;

class InterfaceDebug extends Sprite {

	public static var instance: InterfaceDebug;
	public static var fontName: String = 'Lucida Console';
	
	public var textField: TextField;
	public var text: String;

	inline public function new() {
		super();
		this.text = '';
		var pop: Sprite = new Sprite();
		pop.cacheAsBitmap = true;
		pop.graphics.beginFill(6976661);
		pop.graphics.drawRoundRect(0, 0, 300, 150, 20);
		pop.graphics.endFill();
		pop.transform.colorTransform = new ColorTransform(0.8, 0.8, 0.8);
		addChild(pop);
		try {
			if (Platform.isLinux)
				InterfaceDebug.fontName = 'Liberation Mono';
			else if (Platform.isMacOS)
				InterfaceDebug.fontName = 'Courier New';
		} catch (err) {};
		this.textField = new TextField();
		this.textField.defaultTextFormat = new TextFormat(InterfaceDebug.fontName, 14, 6976661, null, null, null, null, null, TextFormatAlign.CENTER);
		this.textField.multiline = true;
		this.textField.wordWrap = true;
		this.textField.x = 10;
		this.textField.y = 10;
		this.textField.width = 280;
		this.textField.height = 130;
		this.textField.transform.colorTransform = new ColorTransform(1.2, 1.2, 1.2);
		addChild(this.textField);
	}

	public static function append(text: String): Void {
		if (InterfaceDebug.instance == null) return;
		InterfaceDebug.instance.text = InterfaceDebug.instance.text + text;
		InterfaceDebug.instance.textField.htmlText = InterfaceDebug.instance.text;
		InterfaceDebug.instance.align();
	}

	public static function setText(text: String): Void {
		if (InterfaceDebug.instance == null) return;
		InterfaceDebug.instance.text = text;
		InterfaceDebug.instance.textField.htmlText = text;
		InterfaceDebug.instance.align();
	}

	public static function display(): Void {
		if (InterfaceDebug.instance != null) return;
		InterfaceDebug.instance = new InterfaceDebug();
		InterfaceDebug.instance.x = Lib.application.window.width/2.5;
		InterfaceDebug.instance.y = Lib.application.window.height/3;
		Transformice.instance.stage.addChild(InterfaceDebug.instance);
	}

	public static function hide(): Void {
		if (InterfaceDebug.instance == null) return;
		InterfaceDebug.instance.parent.removeChild(InterfaceDebug.instance);
	}

	public function align(): Void{
		if (InterfaceDebug.instance == null) return;
		InterfaceDebug.instance.textField.height = InterfaceDebug.instance.textField.textHeight + 5;
		InterfaceDebug.instance.textField.y = (150 - InterfaceDebug.instance.textField.height) / 2 - 10;
	}
}