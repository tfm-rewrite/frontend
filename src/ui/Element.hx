package ui;

import utils.Language;
import js.html.Node;
import haxe.Constraints.Function;
import js.html.CSSStyleDeclaration;
import haxe.extern.Rest;
import js.html.Element;
import js.Browser;

typedef Size = {
    width: Int,
    height: Int
}

typedef Position = {
    x: Float,
    y: Float
}

class Element {
	
    private var element: js.html.Element;
    private var parentElement: js.html.Element;
    public var childs: Array<Element> = [];
    
	@:isVar public var size(default, set): Size;
    @:isVar public var position(default, set): Position;
    @:isVar public var events(default, set): Map<String, Function> = [];
    @:isVar public var index(default, set): Int;
    @:isVar public var attrs(get, set): Map<String, Dynamic> = [];
    @:isVar public var style(get, null): CSSStyleDeclaration;

    private var options: Map<String, Dynamic>;
    private var listenedEvents: Map<String, Function> = [];

	public function new(tag: String, ?options: Map<String, Dynamic>) {
        this.element = switch (tag) {
            case 'input': Browser.document.createInputElement();
            case 'div': Browser.document.createDivElement();
            case 'a': Browser.document.createAnchorElement();
            case 'textarea': Browser.document.createTextAreaElement();
            case 'span': Browser.document.createSpanElement();
            case 'select': Browser.document.createSelectElement();
            case 'options': Browser.document.createOptionElement();
            case 'p': Browser.document.createParagraphElement();
            case 'button': Browser.document.createButtonElement();
            default: 
                Browser.document.createElement(tag);
        }
		this.options = options == null ? [] : options;
		this.position = get('position') != null ? get('position') : {
			x: get('x', null),
			y: get('y', null)
        };
        if (this.position.x != null && this.position.y != null)
            this.style.position = 'absolute';
        this.size = get('size') != null ? get('size') : {
            width: get('width', -1), 
            height: get('hieght', -1)
        };
        if (get('class') != null) {
            var classes: Array<String> = get('class');
            this.setAttribute('class', classes.join(' '));
        }
        if (get('hidden') != null)
            this.element.hidden = get('hidden') == true;
        if (get('attrs') != null)
            this.attrs = get('attrs');
	}

	public function get(key: String, ?defaultValue: Dynamic): Dynamic {
		if (this.options.exists(key)) 
			return this.options.get(key);

		return defaultValue != null ? defaultValue : null;
	}

	public function set_size(value: Size): Size {
		this.style.width = '${value.width}px';
		this.style.height = '${value.height}px';
		return this.size = value;
	}

	public function set_position(value: Position): Position {
		this.style.left = '${value.x}px';
        this.style.top = '${value.y}px';
        if (this.style.position != 'absolute' && value.x != null && value.y != null) this.style.position = 'absolute';
		return this.position = value;
    }
    
    public function set_events(value: Map<String, Function>): Map<String, Function> {
        for (iter in this.listenedEvents.keyValueIterator())
            this.removeEventListener(iter.key);
        for (iter in value.keyValueIterator())
            this.addEventListener(iter.key, iter.value);

        return this.events = value;
    }

    public function set_index(value: Int): Int {
        this.element.style.zIndex = '${value}';
        return this.index = value;
    }

    public function set_attrs(value: Map<String, Dynamic>): Map<String, Dynamic> {
        for (iter in value.keyValueIterator())
            this.element.setAttribute(iter.key, iter.value);
        return this.attrs;
    }

    public function get_attrs(): Map<String, Dynamic> {
        var map: Map<String, Dynamic> = []; 
        for (i in 0...this.element.attributes.length) {
            var attr = this.element.attributes[i];
            map[attr.nodeName] = attr.nodeValue;
        }
        return map;
    }

    public function get_style(): CSSStyleDeclaration {
        return this.element.style;
    }

    public function addEventListener(eventName: String, callback: Function): Element {
        if (this.listenedEvents.exists(eventName))
            this.removeEventListener(eventName);
        this.element.addEventListener(eventName, callback);
        this.listenedEvents[eventName] = callback;
        return this;
    }

    public function removeEventListener(eventName: String): Element {
        if (this.listenedEvents.exists(eventName))
            this.element.removeEventListener(eventName, this.listenedEvents[eventName]);
        return this;
    }

    public function addChild(element: Element): Element {
        element.style.direction = Transformice.language.code == 'ar' ? 'rtl' : 'ltr';
        this.childs.push(element);
        this.element.appendChild(element.element);
        return this;
    }

    public function addChildAt(element: Element, index: Int): Element {
        element.index = index;
        this.addChild(element);
        return this;
    }

    public function removeChild(element: Element): Void {
        this.element.removeChild(element.element);
    }

    public function removeChildAt(index: Int): Void {
        var child: Element = Lambda.find(this.childs, (item: Element) -> item.index == index);
        child != null ? this.removeChild(child) : null;
    }

    public function setAttribute(attr: String, value: Dynamic): Element {
        this.element.setAttribute(attr, value);
        return this;
    }

    public function removeAttribute(attr: String): Void {
        this.element.removeAttribute(attr);
    }

    public function getAttribute(attr: String): String {
        return this.element.getAttribute(attr);
    }

    public function destroy(): Void {
        this.parentElement = this.element.parentElement;
        this.element.remove();
    }

    public function render(): Void {
        if (Browser.document.body.contains(this.parentElement))
            this.parentElement.appendChild(this.element);
        else
            Browser.document.body.appendChild(this.element);
        this.parentElement = this.element.parentElement;
    }

    public function toggle(hide: Bool = false): Void {
        if (hide) {
            this.element.hidden = !this.element.hidden;
            return;
        }
        this.element.parentElement != null ? this.destroy() : this.render();
    }

    public function centeralize(): Void {
        this.style.transform = 'translate(-50%, -50%)';
        this.style.top = '50%';
        this.style.left = '50%';
    }

    public function clearChilds(): Void {
        for (child in this.childs)
            child.destroy();
    }

    public function translate(): Void {
        Language.translate(this.element);
    }

    public function defineText(keyword: String, ?args: Array<Any>, type: String = 'textContent'): Void {
        Language.defineText(keyword, this.element, args, type);    
    }
}
