package ui;

import ui.TextField;

class Window extends Element {

    public function new(?options: Map<String, Dynamic>, title: String = '') {
        super('div', options);
        if (this.size.width < 100) this.size = {width:100, height:this.size.height};
        if (this.size.height < 100) this.size = {width:this.size.width, height:100};
        var borders: Element = new Element('div', [
            'position' => { x: -50, y: -50 }
        ]);
        borders.attrs = ['class' => 'borders_${title != '' ? 2 : 1}'];
        this.addChild(borders);
        this.attrs = ['class' => 'x_window'];
        if (title != '') {
            var titleField: TextField = new TextField('span', title, [
                'size' => {
                    width: this.size.width + 20,
                    height: 45
                },
                'position' => { x: -10, y: 0 }
            ]);
            titleField.attrs = ['class' => 'title'];
            titleField.style.textAlign = 'center';
            titleField.style.fontSize = '25px';
            if (title.charAt(0) == '$')
                titleField.defineText(title.substr(1));
            this.addChild(titleField);
            this.style.backgroundImage = 'url(/assets/images/x_ui/wood.png)';
        }
        if (this.get('closeable', false)) {
            var closeTF: TextField = new TextField('span', '');
            closeTF.style.color = '#c2c2da';
            closeTF.style.textAlign = 'center';
            closeTF.defineText('close');
            var btn: Button = new Button(closeTF, [
                'size' => { width: this.size.width - 30 }, 
                'position' => { x: this.size.height - 40, y: 15 }
            ]);
            btn.addEventListener('click', this.destroy);
            btn.attrs = ['class' => 'x_btn'];
            this.addChild(btn); 
        }
    }
}