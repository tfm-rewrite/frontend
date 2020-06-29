package interfaces;

import js.Browser;
import openfl.display.Sprite;
import resources.ResourcesImages;
import ui.Window;
import ui.TextField;

class Login extends Interface 
{

	private var backgroundUrl: String;

	public function new()
	{
		super("login");
		this.renderBackground(Config.getValueFrom("config", "background"));
		this.renderLoginButtons();
	}

	private function renderLoginButtons(): Void
	{
		var popupWithTitle: Window = new Window(
			new TextField('Heyoooooo', ['classes' => ['x_text']]), 'Transformice', [
			'width' => 800,
			'height' => 200,
			'draggable' => true,
		]);
		popupWithTitle.x = 100;
		popupWithTitle.y = 200;
		var popup: Window = new Window(new TextField('Hellooooo', [
			'classes' => ['x_text']
		]), '', [
			'width' => 800,
			'height' => 200,
			'draggable' => true,
		]);
		popup.x = 200;
		popup.y = 400;
		Browser.document.body.appendChild(popupWithTitle.element);
		Browser.document.body.appendChild(popup.element);
	}

	private function renderBackground(bg_id: String): Void 
	{
		var url: String = Config.getValueFrom("config", "url");
		var imagesDir: String = Config.getValueFrom("config", "imagesDirectory");
		

		// addChildAt(img, 0);
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