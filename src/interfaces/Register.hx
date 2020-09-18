package interfaces;

using utils.Utils.StringUtil;
import utils.Language;
import ui.TextField;
import ui.Button;
import ui.Input;
import ui.Window;

class Register extends Interface {

    public function new() {
        super('register');
        this.setAttribute('class', 'x_loginBg');
    }

    override public function run(): Void {
        var mainWindow: Window = new Window([
            'class' => ['x_window'],
            'size' => {
                width: 400,
                height: 400
            }
        ], "$signup");
        var userName: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 90,
                y: 70
            }
        ]);
        var password: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 90,
                y: 110
            }
        ]);
        var passwordConfirm: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 90,
                y: 150
            }
        ]);
        var emailAdd: Input = new Input([
            'class' => ['x_login', 'x_borders_in'],
            'position' => {
                x: 90,
                y: 190
            }
        ]);
        userName.limitations = { min: 3, max: 20 };
        userName.required = true;
        userName.defineText('nickname', null, 'placeholder');
        password.type = 'password';
        password.limitations = { min: 8, max: 50 };
        password.defineText('password', null, 'placeholder');
        password.required = true;
        passwordConfirm.limitations = { min: 8, max: 50 };
        passwordConfirm.required = true;
        passwordConfirm.defineText('password_confirm', null, 'placeholder');
        passwordConfirm.type = 'password';
        password.style.color = passwordConfirm.style.color = '#3dbfff';
        emailAdd.required = true;
        emailAdd.defineText('email', null, 'placeholder');
        emailAdd.type = 'email';
        emailAdd.style.color = '#66ff55';
        var texts: Map<String, TextField> = [
            'back_login' => new TextField('span'),
            'signup' => new TextField('span')
        ];
        for (text in texts.keyValueIterator()) {
            text.value.style.color = '#c2c2da';
            text.value.style.textAlign = 'center';
            text.value.defineText(text.key);
        }
        var loginButton: Button = new Button(texts['back_login'], [
            'class' => ['x_btn'],
            'width' => 370,
            'position' => {
                x: 16,
                y: 360
            }
        ]);
        var registerButton: Button = new Button(texts['signup'], [
            'class' => ['x_btn'],
            'width' => 370,
            'position' => {
                x: 16,
                y: 330
            }
        ]);
        userName.addEventListener('input', () -> {
            if (userName.value.length < 3 || userName.value.length > 20)
                userName.setCustomValidty(Language.message('nickname_requirements_1', [3, 20]));
            else if (!~/^\+?[A-Za-z0-9_]{2,}$/.match(userName.value.toLowerCase()))
                userName.setCustomValidty(Language.message('nickname_requirements_2'));
            else 
                userName.setCustomValidty('');
        });
        password.addEventListener('input', () -> {
            if (password.value.length < 8)
                password.setCustomValidty(Language.message('password_requirements_1', [8]));
            else if (password.value.indexOf(userName.value.toLowerCase()) != -1)
                password.setCustomValidty(Language.message('password_requirements_2'));
            else
                password.setCustomValidty('');
        });
        emailAdd.setAttribute('disabled', '');
        passwordConfirm.addEventListener('input', () -> {
            if (password.value != passwordConfirm.value)
                password.setCustomValidty(Language.message('passwords_not_match'));
            else
                password.setCustomValidty('');
        });

        registerButton.addEventListener('click', () -> {
			Interface.list['grayscale'].render();
            if (userName.reportValidty() && password.reportValidty()) {
				Transformice.instance.main.send(new packets.main.send.login.Register(userName.value, password.value.shakikoo()));
			} else
				Interface.list['grayscale'].destroy();
        });
        loginButton.addEventListener('click', () -> {
            Interface.list['register'].destroy();
            Interface.list['login'].render();
        });
        userName.setAttribute('id', 'inp_username');
        loginButton.style.background = '#6f5030';
		userName.allow(~/^[+A-Za-z0-9_]$/);
        registerButton.style.background = '#49702d';
        mainWindow.addChild(userName)
            .addChild(password)
            .addChild(passwordConfirm)
            .addChild(emailAdd)
            
            .addChild(loginButton)
            .addChild(registerButton);

        mainWindow.centeralize();
        this.addChild(mainWindow);
    }
}