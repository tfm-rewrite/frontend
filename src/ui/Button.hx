package ui;

import ui.TextField;
import utils.Sounds;

class Button extends Element {

    @:isVar public var content(default, set): TextField;

    public function new(content: TextField, ?options: Map<String, Dynamic>) {
        super('button', options);
        this.content = content;
        this.addEventListener('mousedown', Sounds.MOUSE_CLICK.play);
    }

    public function set_content(value: TextField): TextField {
        this.removeChildAt(0);
        this.content = value;
        this.content.style.position = 'relative';
        this.addChildAt(this.content, 0);
        return value;
    }
}