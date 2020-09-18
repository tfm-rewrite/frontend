package utils;

import ui.Input;
import ui.TextField;
import ui.Element;

class DebugPanel extends Element {

    public static var instance: DebugPanel;
    private var textField: TextField = new TextField();

    @:isVar public static var text(get, set): String;
    public function new() {
        super('div', [ 
            'size' => { width: 400, height: 400 },
            'position' => { x: 0, y: 0 },
            'class' => ['x_debugInterface', 'x_textCode']
        ]);
        var input: Input = new Input([ 
            'width' => this.size.width - 20,
            'position' => { x: this.size.height - 30, y: 5 },
            'class' => ['x_inptDbg']
        ]);
        input.style.border = '0';
        input.style.background = 'none';
        input.style.outline = 'none';
        this.addChild(input);
        this.textField = new TextField('span', null, [
            'size' => this.size
        ]);
        this.textField.isHtml = true;
        this.textField.style.fontSize = '14px';
        this.textField.style.wordBreak = 'break-word';
        this.addChild(this.textField);
    }

    public static function append(text: String): Void {
        if (instance == null) return;
        instance.textField.text += text;
    }

    public static function set_text(value: String): String {
        return instance == null ? null : instance.textField.text = value;
    }

    public static function get_text(): String {
        return instance == null ? null : instance.textField.text;
    }
}