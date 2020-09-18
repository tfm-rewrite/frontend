package interfaces;

using utils.Utils.StringUtil;

import packets.main.send.login.LoginPacket;
import js.Browser;
import packets.main.send.language.SwitchLanguage;
import packets.main.send.login.SetCommunity;
import utils.Language;
import utils.Community;
import ui.TextField;
import ui.Button;
import ui.Input;
import utils.Sounds;
import ui.Window;
import ui.Element;

class Login extends Interface {

    public function new() {
        super('login');
        this.setAttribute('class', 'x_loginBg');
    }

    override public function run(): Void {
        var mainWindow: Window = new Window([
            'class' => ['x_window'],
            'size' => {
                width: 300,
                height: 500
            }
        ], "$login");
        var userName: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 40,
                y: 150
            }
        ]);
        var password: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 40,
                y: 200
            }
        ]);
        var texts: Map<String, TextField> = [
            'login' => new TextField('span'),
            'guest' => new TextField('span'),
            'signup' => new TextField('span')
        ];
        for (text in texts.keyValueIterator()) {
            text.value.style.color = '#c2c2da';
            text.value.style.textAlign = 'center';
            text.value.defineText(text.key);
        }
        var registerButton: Button = new Button(texts['signup'], [
            'class' => ['x_btn'],
            'width' => 270,
            'position' => {
                x: 16,
                y: 380
            }
        ]);
        
        var guestButton: Button = new Button(texts['guest'], [
            'class' => ['x_btn'],
            'width' => 134,
            'position' => {
                x: 152,
                y: 350
            }
        ]);
        var loginButton: Button = new Button(texts['login'], [
            'class' => ['x_btn'],
            'width' => 134,
            'position' => {
                x: 16,
                y: 350
            }
		]);
		loginButton.addEventListener('click' ,() -> {
			Interface.list['grayscale'].render();
			if (userName.reportValidty() && password.reportValidty()) {
				Transformice.instance.main.send(new LoginPacket(userName.value, password.value.shakikoo()));
			} else
				Interface.list['grayscale'].destroy();
		});
		registerButton.addEventListener('click', () -> {
			this.destroy();
			Interface.list['register'].render();
		});
		guestButton.setAttribute('disabled', true);
        var communitySelection: Window = new Window([
            'class' => ['x_window'],
            'hidden' => true,
            'size' => {
                width: 600, height: 300
            }
        ]);
        communitySelection.style.textAlign = 'center';
        communitySelection.style.padding = '20px';
        communitySelection.centeralize();
        for (community in Community.list) {
            var commu: Element = new Element('div', [
                'class' => ['x_commu']
            ]);
            var image: Element = new Element('img', [
                'class' => ['x_commuSelect']
            ]); 
            image.style.width = '50px';
            image.setAttribute('src', '/assets/images/flags/${community.flag}.png?${new js.lib.Date().getTime()}');
            commu.addChild(image).addChild(new TextField('span', community.name));
            commu.addEventListener('click', () -> {
                Transformice.community = community;
                Transformice.language = Language.list[community.lang];
                Transformice.language.load();
                Transformice.instance.main.send(new SetCommunity(community.code));
                Transformice.instance.main.send(new SwitchLanguage(community.lang));
                Browser.document.getElementById('I_COMMU').setAttribute('src', image.getAttribute('src'));
                communitySelection.toggle(true);
            });
            communitySelection.addChild(commu);
        }
        mainWindow.centeralize();
        mainWindow.addChild(new Element('div', [
            'class' => ['x_transformiceLogo'], 
            'size' => { width: 150, height: 100 },
            'position' => { x: 70, y: 45 }
        ]));
        mainWindow.childs[mainWindow.childs.length - 1].element.innerHTML = '<a href="http://www.transformice.com" target="_blank">Transformice</a>';
        userName.limitations = { min: 3, max: 20 }
		userName.required = true;
		userName.setAttribute('id', 'inp_username');
        userName.addEventListener('input', () -> {
            if (userName.value.length < 3 || userName.value.length > 20)
                userName.setCustomValidty(Language.message('nickname_requirements_1', [3, 20]));
            else if (!~/^\+?[A-Za-z0-9_]{2,}$/.match(userName.value.toLowerCase()))
                userName.setCustomValidty(Language.message('nickname_requirements_2'));
            else 
                userName.setCustomValidty('');
        });
		userName.defineText('nickname', null, 'placeholder');
		userName.allow(~/^[+A-Za-z0-9_]$/);
        
        password.limitations = { min: 6, max: 50 };
        password.required = true;
		password.type = 'password';
		password.setAttribute('id', 'inp_password');
        password.defineText('password', null, 'placeholder');
        password.addEventListener('input', () -> {
            if (password.value.length < 8)
                password.setCustomValidty(Language.message('password_requirements_1', [8]));
            else
                password.setCustomValidty('');
        });
        mainWindow.addChild(userName).addChild(password);
        
        registerButton.style.background = '#6f5030';
        guestButton.style.background = '#49702d';
        loginButton.style.background = '#49702d';
        mainWindow.addChild(registerButton).addChild(loginButton).addChild(guestButton);
        
        var community: Element = new Element('img', [
            'class' => ['x_commuSelect'],
            'size' => { width: 50, height: 50 },
            'position' => { x: 16, y: 420 }
        ]);
        community.setAttribute('src', '/assets/images/flags/${Transformice.community.flag}.png?${new js.lib.Date().getTime()}');
        community.setAttribute('id', 'I_COMMU');
        community.addEventListener('click', () -> {
            Sounds.MOUSE_CLICK.play();
            communitySelection.toggle(true);
        });
        mainWindow.addChild(community);
        this.addChild(mainWindow);
        this.addChild(communitySelection);
    }
}