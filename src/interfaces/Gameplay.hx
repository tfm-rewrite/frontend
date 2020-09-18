package interfaces;

import js.Browser;
import ui.Element;

class Gameplay extends Interface {

    public function new() {
        super('gameplay');
    }

    override public function run() {
        var chat: Element = new Element('div', [
            'size' => { width: 800, height: 210 },
            'position' => { x: (Browser.document.body.offsetWidth-800)/2, y: ((Browser.document.body.offsetHeight-800)/2) + 400 }
        ]);
        var top: Element = new Element('div', [
            'size' => { width: 800, height: 30 },
            'position' => { x: (Browser.document.body.offsetWidth-800)/2, y: (Browser.document.body.offsetHeight-800)/2 }
        ]);
        chat.addChild(new Element('img', [
            'position' => { x: 0, y: 10 },
            'attrs' => ['src' => '/assets/images/x_ui/x_game/chatbar.jpg']
        ]))
            .addChild(new Element('img', [
                'attrs' => ['src' => '/assets/images/x_ui/x_game/chatbar_2.png'],
                'position' => { x: 0, y: 0 }
            ]));
        top.addChild(new Element('img', [
            'attrs' => ['src' => '/assets/images/x_ui/x_game/topbar.jpg']
        ]))
            .addChild(new Element('img', [
                'position' => { x: 0, y: 20 },
                'attrs' => ['src' => '/assets/images/x_ui/x_game/topbar_2.png']
            ]));
        this.addChild(chat).addChild(top);
    }
}