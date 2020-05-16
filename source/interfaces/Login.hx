package interfaces;

import js.Browser;
import js.html.Text;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.filters.BitmapFilterQuality;
import openfl.filters.BlurFilter;
import openfl.filters.BitmapFilter;
import openfl.utils.Dictionary;
import openfl.display.Sprite;
import resources.ResourcesImages;

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
		var x = Browser.document.createElement("div");
		x.classList.add("window");
		x.innerHTML = "Test";
		var y = Browser.document.createElement("div");
		y.classList.add("borders");
		var title = Browser.document.createElement("span");
		title.classList.add("title");
		title.innerHTML = "Transformice";
		x.appendChild(title);
		x.appendChild(y);
		Browser.document.body.appendChild(x);
	}

	private function renderBackground(bg_id: String): Void 
	{
		var url: String = Config.getValueFrom("config", "url");
		var imagesDir: String = Config.getValueFrom("config", "imagesDirectory");
		this.backgroundUrl = '$url/$imagesDir/x_login_screen/x_$bg_id.jpg';
		var img = ResourcesImages.getRemoteImage(this.backgroundUrl, "", {
			var x: Dictionary<String, Any> = new Dictionary();
			x["round"] = 20;
			x;
		});
		addChildAt(img, 0);
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