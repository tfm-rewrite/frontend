package ui;

import js.html.KeyboardEvent;

class TextField extends Element {
    public var isHtml: Bool = false;
    @:isVar public var text(default, set): String;

    public function new(tag: String = 'span', ?content: String, ?options: Map<String, Dynamic>) {
        super(tag, options);
        this.text = content;
    }

    public function set_text(value: String): String {
        return this.isHtml ? this.element.innerHTML = value : this.element.innerText = value;
    }
    
}