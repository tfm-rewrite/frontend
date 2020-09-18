package utils;

import openfl.display.GraphicsShader;
import js.Browser;
import js.html.Element;
import js.lib.Promise;
using utils.Utils.StringUtil;

import haxe.Json;
import haxe.http.HttpJs;

class Language {

    public static final list: Map<String, Language> = [];
    public static var data: Map<String, String> = [];
    public var code: String;

    public function new(code: String) {
        this.code = code.toLowerCase();
        list[this.code] = this;
    }

    public function load(): Promise<Language> {
        return new Promise((resolve, reject) -> {
            var request: HttpJs = new HttpJs(Utils.languagesURI + this.code);
            request.async = true;
            Interface.list['grayscale'].render();
            request.onData = data -> {
                Language.data = cast Utils.object2map(Json.parse(data));
                Interface.list['grayscale'].destroy();
                translate(Browser.document.body);
                resolve(this);
            }
            request.onError = err -> reject(err);
            request.request();
        });
    }

    public static function unload(): Void {
        data.clear();
    }

    public static function message(keyword: String, ?args: Array<Dynamic>): String {
        keyword = keyword.toLowerCase();
        if (data.exists(keyword))
            return data[keyword].format(args);
        return "$" + keyword;
    }

    public static function defineText(keyword: String, element: Element, ?args: Array<Any>, type: String = 'textContent'): Void {
        
        js.Syntax.code('{0}.dataset.trans = {2}, {0}.dataset.transType = {1}, {0}[{1}] = {3}', element, type, keyword, message(keyword, args));
        if (args != null)
            js.Syntax.code('{0}.dataset.transParams = {1}', element, args.join('%-%'));
    }

    public static function translate(element: Element): Void {
        var list = element.querySelectorAll('[data-trans]');
        for (i in 0...list.length) {
            var el: Element = cast list.item(i);
            el.style.direction = Transformice.language.code == 'ar' ? 'rtl' : 'ltr';
            if (el.getAttribute('data-trans') != '') 
                js.Syntax.code('let keyword = {0}.dataset.trans, type = {0}.dataset.transType; {0}[type] = {1}(keyword, {0}.dataset.transParams);', el, message);
        }
    }
}