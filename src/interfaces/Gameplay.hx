package interfaces;

import js.Browser;
import ui.Element;

class Gameplay extends Interface {

    public function new() {
        super('gameplay');
    }

    override public function run() {
        var width = 800;
        var height = 600;
        
        var xOffset = (Browser.document.body.offsetWidth - width) / 2;
        var yOffset = (Browser.document.body.offsetHeight - height) / 2;
        
        var chat: Element = new Element('div', [
            'size' => { width: 800, height: 210 },
            'position' => { x: xOffset, y: yOffset + 400 }
        ]);
        var top: Element = new Element('div', [
            'size' => { width: 800, height: 30 },
            'position' => { x: xOffset, y: yOffset }
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
