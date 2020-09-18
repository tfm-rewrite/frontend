package interfaces;

import js.Browser;

class Grayscale extends Interface {
    
    public function new() {
        super('grayscale');
    }

    override public function render(): Void {
        Browser.document.body.style.filter = 'grayscale(1)';
        Browser.document.body.appendChild(this.element);
    }

    override public function destroy(): Void {
        Browser.document.body.style.filter = '';
        this.element.remove();
    }
}