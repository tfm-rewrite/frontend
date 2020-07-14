package interfaces;

import js.html.Event;
import packets.main.send.login.LoginPacket;
import packets.main.send.login.SetCommunity;
import connection.Connection;
import ui.Button;
import js.html.Element;
import ui.Input;
import ui.Component;
import ui.TextField;
import ui.Window;

class Login extends Interface {

	public function new() {
		super('login');
		this.classes = ['x_loginBg'];	
	}

	override public function main(): Element {
		var main: Window = new Window(new TextField(), 'Login', [
			'classes' => ['x_window'],
			'width' => 400,
			'height' => 200
		]);
		var logo: Component = new Component('div', [
			'classes' => ['x_transformiceLogo'],
			'width' => 150,
			'height' => 100,
			'x' => -120,
			'y' => 150
		]);
		
		var username: Input = new Input([
			'classes' => ['x_login', 'x_borders']
		]);
		username.element.minLength = 3;
		username.element.maxLength = 25;
		username.element.required = true;
		username.element.oninput = function(event) {
			if (username.value.length < 3)
				username.element.setCustomValidity('Username must be 3 or more characters.');
			else if (username.value.length > 25)
				username.element.setCustomValidity('Username must be less than 25 characters.');
			else if (!~/^\+?[a-zA-Z][a-zA-Z0-9_]{2,}$/.match(username.value.toLowerCase()))
				username.element.setCustomValidity('Username contains wrong characters.');
			else
				username.element.setCustomValidity('');
		}
		username.centralize();

		logo.element.innerHTML = '<a href="https://www.transformice.com">Transformice</a><a href="https://www.transformice.com">Transformice</a>';
		var loginButton: Button = new Button(new TextField('Login', ['color' => 0xC2C2DA, 'align' => 'center']), function() {
			Connection.main.send(new SetCommunity(Transformice.community.code));
			if (username.element.reportValidity()) {
				if (username.value.length >= 3 && username.value.length <= 25)
					Connection.main.send(new LoginPacket(username.value, ''));
			}
		}, ['classes' => ['x_btn'], 'width' => main.width, 'x' => main.height - 20, 'y' => 12]);
		
		main.element.appendChild(logo.element);
		main.element.appendChild(username.element);
		main.element.appendChild(loginButton.element);
		main.centralize();
		return main.element;
	}
}