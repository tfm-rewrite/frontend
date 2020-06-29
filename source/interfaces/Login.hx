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
		var titles = ['', 'Transformice', '', 'HTML5', ''];
		for (i in 0...5) {
			var pop: Window = new Window(
				new TextField('Hiii', ['classes' => ['x_text'], 'color' => 0xfbffb3]),
				titles[i],
				[
					'classes' => ['x_window'],
					'width' => Math.floor(Math.random()*600),
					'height' => Math.floor(Math.random()*400),
					'x' => 150 + (i*2),
					'y' => 200 * i,
					'closable' => true
				]
			);
			Browser.document.body.appendChild(pop.element);
		}
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