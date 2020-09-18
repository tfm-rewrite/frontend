package ui;

/* WIP */
class Scrollbar extends Element {

    public static final HORIZONTAL = 1;
    public static final VERTICAL = 2;

    private var type: Int = 0;
    private var target: Element;

    public function new(target: Element, type: Int = 1) {
        super('div', [
            'size' => { width: 10, height: 100 }
        ]);
        if (target.style.overflowX != 'scroll' || target.style.overflowY != 'scroll')
            throw 'Missing css property "overflow-x" or "overflow-y" with vlaue "scroll"';
        if (target.parentElement == null)
            throw 'Couldn\'t found scroll target\'s parent.';
        switch (this.type = type) {
            case HORIZONTAL:
                this.position = { x: 0, y: target.size.height - 10 };
            case VERTICAL:
                this.position = { x: target.size.width - 10, y: 0 };
        }
        
        this.target = target;
    }

    public function calculateSize(): Float {
        var offset: Int, scroll: Int;
        if (this.type == HORIZONTAL) {
            offset = this.target.parentElement.offsetWidth;
            scroll = this.target.element.scrollWidth;
        } else {
            offset = this.target.parentElement.offsetHeight;
            scroll = this.target.element.scrollHeight;
        }
        return (offset/scroll) * offset;        
    }
}