package interfaces;

import ui.Component;
import js.html.Element;
import js.Browser;
import openfl.display.Sprite;
import resources.ResourcesImages;
import ui.*;
import openfl.net.Socket;

class Login extends Interface 
{

	private var backgroundUrl: String;

	public function new()
	{
		super("login");
		this.renderBackground();
		this.renderLoginButtons();
	}

	private function renderLoginButtons(): Void
	{
		var main: Window = new Window(new TextField(''), 'Login', [
			'classes' => ['x_window'],
			'width' => 400,
			'height' => 300
		]);
		var logo: Component = new Component('div', [
			'classes' => ['x_transformiceLogo'],
			'width' => 150,
			'height' => 100,
			'x' => -120,
			'y' => 150
		]);
		var username: Input = new Input([
			'classes' => ['x_login']
		]);
		username.centralize();
		logo.element.innerHTML = '<a href="https://www.transformice.com">Transformice</a>';
		main.element.appendChild(logo.element);
		main.element.appendChild(username.element);
		var loginButton: Button = new Button(new TextField('Login', ['color' => 0xC2C2DA, 'align' => 'center']), function() {
			var sock: Socket = new Socket('127.0.0.1', 666);
			sock.addEventListener('connect', function(a) {
				trace('connected', a);
				sock.writeShort(666);
			});
			trace("Login");	
		}, ['classes' => ['x_btn'], 'width' => main.width, 'x' => main.height - 20, 'y' => 12]);
		main.element.appendChild(loginButton.element);
		main.centralize();
		Browser.document.body.appendChild(main.element);
	
	}

	private function renderBackground(): Void 
	{
		var element: Element = Browser.document.createElement('div');
		element.className = 'x_loginBg';
		Browser.document.body.appendChild(element);
	}

	private function renderLoginContainer(): Void
	{
		var container: Sprite = new Sprite();
		container.graphics.beginFill(0x243b4d, 1);
		container.graphics.drawRoundRect(50, 50, 700, 200, 10);
		container.graphics.endFill();
		addChild(container);
	}
}