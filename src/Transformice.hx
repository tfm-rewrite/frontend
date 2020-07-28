package;

import box2D.dynamics.B2DebugDraw;
import openfl.display.DisplayObject;
import box2D.dynamics.B2Body;
import openfl.utils.AssetManifest;
import map.Ground;
import haxe.CallStack;
import haxe.Exception;
import utils.Utils;
import connection.Connection;
import interfaces.Login;
import openfl.events.Event;
import openfl.net.URLLoader;
import utils.Community;
import openfl.net.URLRequest;
import map.MapCustomization;
import openfl.utils.AssetLibrary;
import openfl.utils.Assets;
import openfl.utils.AssetType;
import openfl.system.Security;
import utils.InterfaceDebug;
import box2D.common.math.B2Vec2;
import openfl.Lib;
import box2D.dynamics.B2World;
import flash.system.Capabilities;
import flash.display.Sprite;
import utils.AssetsManager;

import packets.main.MainHandler;
import packets.bulle.BulleHandler;

class Transformice extends Sprite {
	public static var instance: Transformice;
	public static var isAzerty: Bool = Capabilities.language.toLowerCase() == 'fr';
	public static var community: Community = Community.ENGLISH;
	@:isVar public static var defaultFrameRate(get, set): Float = 30;
	

	public var physicWorld: B2World;
	public var world: Sprite;
	public var playerList: Array<Player>;

	public var pid: UInt;
	public var bulleToken: UInt;

	public var initializations = [
		[
			"name" => "resources",
			"extra" => function() {
			}
		],
		[
			"name" => "transformice",
			"extra" => function() {
			}
		],
		[
			"name" => "mapictures",
			"extra" => function() {
				MapCustomization.initialization();
			}
		],
		[
			"name" => "equipments",
			"extra" => function() {
			}
		],
		[
			"name" => "furs",
			"extra" => function() {
			}
		],
		[
			"name" => "animations",
			"extra" => function() {
			}
		]
	];

	public var main: Connection;
	public var bulle: Connection;

	public var mainHandler: MainHandler;
	public var bulleHandler: BulleHandler;

	public function new() {
		super();

		Transformice.instance = this;
		this.main = new Connection("main", this);

		this.mainHandler = new MainHandler();
		this.bulleHandler = new BulleHandler();

		this.physicWorld = new B2World(new B2Vec2(0, 10), true);
		this.world = new Sprite();

		stage.addChild(this.world);
		stage.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);

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
		if(conn.name == "main") {
			InterfaceDebug.hide();
		} else { // bulle
		}
	}

	public function on_connection_lost(conn: Connection): Void {
		if(conn.name == "main") {
			this.bulle.close();

			Interface.list.map(function(inter) {
				inter.element.remove();
				return null;
			});

			this.world.removeChildren();
			this.removeChildren();

			InterfaceDebug.instance = null;
			InterfaceDebug.display();
			InterfaceDebug.setText("Connection lost.");
		}
	}

	private function start(): Void {
		for(index in 0...Utils.ports.length) {
			try {
				InterfaceDebug.setText("Connecting to port " + Utils.ports[index] + "...");

				if(Utils.useGitpod)
					this.main.connect(Utils.gitpod, Utils.ports[index], true);
				else
					this.main.connect(Utils.host, Utils.ports[index], false);

				return;
			} catch (err) {
			}
		}

		InterfaceDebug.setText('Failed to connect to the servers.');
	}

	private function initializeResource(index: Int): Void {
		if(index >= this.initializations.length)
			return this.start();

		var resource = this.initializations[index];
		AssetLibrary.loadFromFile("../assets/swf/" + resource.name + ".bundle")
		.onProgress(function(a: Int, b: Int) {
			InterfaceDebug.setText("Initializing " + resource.name + "...");
		})
		.onComplete(function(lib: AssetLibrary) {
			Assets.registerLibrary(resource.name, lib);
			AssetsManager.additional.push(resource.name);
			resource.extra();
			InterfaceDebug.setText("Initialized " + resource.name + ".");

			this.initializeResource(index + 1);
		});
	}

	private function initializationResources(): Void {
		InterfaceDebug.display();
		InterfaceDebug.setText("Initialization...");
		this.initializeResource(0);
	}
}