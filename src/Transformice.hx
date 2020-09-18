package;

import utils.Language;
import utils.DebugPanel;
import ui.TextField;
import ui.Window;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2Body;
import utils.Utils;
import connection.Connection;
import openfl.events.Event;
import utils.Community;
import map.MapCustomization;
import openfl.utils.AssetLibrary;
import openfl.utils.Assets;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flash.system.Capabilities;
import flash.display.Sprite;
import utils.AssetsManager;
import js.lib.Uint8Array;

import utils.Packet;
import packets.main.MainHandler;
import packets.bulle.BulleHandler;

class Transformice extends Sprite {
	public static var instance: Transformice;
	public static var isAzerty: Bool = Capabilities.language.toLowerCase() == 'fr';
	public static var community: Community = Community.ENGLISH;
	public static var language: Language = Language.list[Community.ENGLISH.lang];
	public static var loadingWindow: Window = {
		var win: Window = new Window([
			'size' => { width: 300, height: 200 }
		]);
		win.setAttribute('class', 'x_window');
		var tf: TextField = new TextField('p', '', [
			'size' => {
				width: win.size.width,
				height: win.size.height
			}
		]);
		tf.style.textAlign = 'center';
		tf.style.wordBreak = 'break-word';
		tf.style.verticalAlign = 'middle';
		tf.style.display = 'table-cell';
		win.addChild(tf);
		win.style.padding = '10px';
		
		win;
	}
	@:isVar public static var defaultFrameRate(get, set): Float = 30;
	

	public var physicWorld: B2World;
	public var world: Sprite;
	public var playerList: Array<Player>;
	public var cheatCode: String = '';
	public var cheatCodeTime: Int = Lib.getTimer();

	public static var pid: Int;
	public static var bulleToken: Int;

	public var initializations: Array<Map<String, Dynamic>> = [
		[
			"name" => "resources",
			"extra" => () -> {
			}
		],
		[
			"name" => "transformice",
			"extra" => () -> {
			}
		],
		[
			"name" => "equipments",
			"extra" => () -> {
			}
		],
		[
			"name" => "furs",
			"extra" => () -> {
			}
		],
		[
			"name" => "animations",
			"extra" => () -> {
			}
		],
		[
			"name" => "mapictures",
			"extra" => MapCustomization.initialization
		]
	];

	public var main: Connection;
	public var bulle: Connection;

	public var mainHandler: MainHandler;
	public var bulleHandler: BulleHandler;

	public function new() {
		super();

		Transformice.instance = this;

		new interfaces.Login();
		new interfaces.Grayscale();
		new interfaces.Register();
		new interfaces.Gameplay();

		this.main = new Connection("main", this);

		this.mainHandler = new MainHandler();
		this.bulleHandler = new BulleHandler();

		this.physicWorld = new B2World(new B2Vec2(0, 10), true);
		this.world = new Sprite();

		stage.addChild(this.world);
		stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
		var dbgDraw:B2DebugDraw = new B2DebugDraw();
		var dbgSprite:Sprite = new Sprite();

		this.world.addChild(dbgSprite);

		dbgDraw.setSprite(dbgSprite);
		dbgDraw.setDrawScale(30);
		dbgDraw.setFillAlpha(0.5);
		dbgDraw.setLineThickness(2.0);
		dbgDraw.setFlags(B2DebugDraw.e_shapeBit | B2DebugDraw.e_jointBit | B2DebugDraw.e_pairBit);

		this.physicWorld.setDebugDraw(dbgDraw);
	
		this.initializationResources();
		
	}

	private function onEnterFrame(event: Event): Void {
		var body: B2Body = this.physicWorld.getBodyList();
		while (body != null) {
			if (body.m_xf.position.x > 50 || body.m_xf.position.y > 50) 
				this.physicWorld.destroyBody(body);
			var player: Player = cast body.getUserData();
			if (player != null) {
				player.x = body.m_xf.position.x * 30;
				player.y = body.m_xf.position.y * 30;
			}
			body = body.m_next;
		}
		this.physicWorld.drawDebugData();
	}

	private function onKeyDown(event: KeyboardEvent): Void {
		if (String.fromCharCode(event.charCode) == '~' || this.cheatCode.indexOf('~') == 0) {
			if (this.cheatCode.indexOf('~') == 0 && String.fromCharCode(event.charCode) == '~')
				this.cheatCode = '';
			if (Lib.getTimer() - this.cheatCodeTime < 1700 || this.cheatCode == '') {
				this.cheatCodeTime = Lib.getTimer();
				this.cheatCode += String.fromCharCode(event.charCode);
			} else {
				this.cheatCode = '';
				this.cheatCodeTime = Lib.getTimer();
				this.cheatCode += String.fromCharCode(event.charCode);
			}
			switch (this.cheatCode) {
				case '~debug':
					if (DebugPanel.instance != null)
						DebugPanel.instance.toggle();
			}
		}
	}

	public static function set_defaultFrameRate(rate: Float): Float {
		return Transformice.defaultFrameRate = Transformice.instance.stage.frameRate = rate;
	}

	public static function get_defaultFrameRate(): Float {
		return Transformice.defaultFrameRate;
	}

	public function on_data_received(buffer: Uint8Array, conn: Connection): Void {
		var packet: Packet = new Packet(buffer);
		var ccc: Int = packet.read16();

		if(conn.name == "main") {
			this.mainHandler.handle(conn, ccc, packet);
		} else {
			this.bulleHandler.handle(conn, ccc, packet);
		}
	}

	public function on_connection_made(conn: Connection): Void {
		if(conn.name == "main") 
			conn.send(
				new Packet(1, 1, 5)
				.writeBool(false)
				.writeBool(false)
				.writeBool(Transformice.isAzerty)
			);
		else // bulle
			conn.send(
				new Packet(1, 1, 10)
				.write32(Transformice.pid)
				.write32(Transformice.bulleToken)
			);
	}

	public function on_connection_lost(conn: Connection): Void {
		if (conn.name == "main" && conn.open) {
			if (this.bulle != null)
				this.bulle.close();
			for (interf in Interface.list.keyValueIterator())
				interf.value.destroy();
			this.world.removeChildren();
			this.removeChildren();
		}
	}

	private function start(index: Int = 0): Void {
		if (index < Utils.ports.length) {
			setLoadingWindowText('Connecting to server port ${Utils.ports[index]}...');
			this.main.connect(Utils.useGitpod ? Utils.gitpod : Utils.host, Utils.ports[index], Utils.useGitpod)
				.then(ws -> {
					/* Connected */
				})
				.catchError(err -> {
					start(index + 1);
				});
		} else 
			setLoadingWindowText('Cannot connect to the servers, they might be closed or under maintenance.');
	}

	private function initializeResource(index: Int): Void {
		if(index >= this.initializations.length)
			return this.start();

		var resource = this.initializations[index];
		AssetLibrary.loadFromFile("../assets/swf/" + resource["name"] + ".bundle")
		.onProgress(function(a: Int, b: Int) {
			setLoadingWindowText('Loading ${resource['name']}...');
		})
		.onError(function(err: Dynamic) {
		})
		.onComplete(function(lib: AssetLibrary) {
			Assets.registerLibrary(resource["name"], lib);
			AssetsManager.additional.push(resource["name"]);
			resource["extra"]();
			this.initializeResource(index + 1);
		});
	}

	public static function setLoadingWindowText(text: String): Void {
		var textField: TextField = cast loadingWindow.childs[1];
		textField.text = text;
	}

	private function initializationResources(): Void {
		DebugPanel.instance = new DebugPanel();
		loadingWindow.render();
		loadingWindow.centeralize();
		
		this.initializeResource(0);
	}
}