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

class Transformice extends Sprite {
	public static var instance: Transformice;
	public static var isAzerty: Bool = Capabilities.language.toLowerCase() == 'fr';
	public static var community: Community = Community.ENGLISH;
	@:isVar public static var defaultFrameRate(get, set): Float = 30;
	

	public var physicWorld: B2World;
	public var world: Sprite;
	public var playerList: Array<Player>;

	public function new() {
		super();
		Transformice.instance = this;
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

	private function start(): Void {
		// MapCustomization.forceFinishInitialization(); to force initialize map customization things ( we should use it when player login and assets not loaded yet )
		// InterfaceDebug.hide();

		// var gg: Ground = new Ground(Ground.EARTH, 200, 200, 200, 200);
		// var player: Player = new Player();
		// player.x = 200;
		// player.y = 200;
		
		InterfaceDebug.setText('Connecting...');
		this.connect();
	}

	private function connect(index: Int = 0): Void {
		if (index >= Utils.ports.length)
			return InterfaceDebug.setText('Failed to connect to the servers.');
		try { 
			for (i in index...Utils.ports.length) {
				InterfaceDebug.setText('Connecting to server ${Utils.ports[i]}...');
				Connection.main.connect('', Utils.ports[i]);
				// Timer.delay(function() {
				// 	if (Connection.main.transport.readyState != WebSocket.OPEN) {
				// 		Connection.main.transport.close();
				// 		this.connect(index + 1);
				// 	}	
				// }, 5000);
			}
		} catch (err) {
			Connection.main.transport.close();
			this.connect(index + 1);
			trace('err', CallStack.toString(CallStack.exceptionStack()));
		}
	}

	private function initializationResources(): Void {
		InterfaceDebug.display();
		InterfaceDebug.setText('Initialization...');
		AssetLibrary.loadFromFile('../assets/swf/resources.bundle')
		.onProgress(function(a: Int, b: Int) {
			InterfaceDebug.setText('Initializing resources...');
		})
		.onComplete(function(lib: AssetLibrary) {
			Assets.registerLibrary('resources', lib);
			AssetsManager.additional.push('resources');
			InterfaceDebug.setText('Initialized resources.');
			AssetLibrary.loadFromFile('../assets/swf/transformice.bundle')
			.onProgress(function(a: Int, b: Int) {
				InterfaceDebug.setText('Initializing transofrmice...');
			})
			.onComplete(function(lib: AssetLibrary) {
				Assets.registerLibrary('transformice', lib);
				AssetsManager.additional.push('transformice');
				InterfaceDebug.setText('Initialized transformice.');
				AssetLibrary.loadFromFile('../assets/swf/mapictures.bundle')
				.onProgress(function(a: Int, b: Int) {
					InterfaceDebug.setText('Initializing maps...');
				})
				.onComplete(function(lib: AssetLibrary) {
					Assets.registerLibrary('mapictures', lib);
					AssetsManager.additional.push('mapictures');
					MapCustomization.initialization();
					InterfaceDebug.setText('Initialized maps.');
					AssetLibrary.loadFromFile('../assets/swf/equipments.bundle')
					.onProgress(function(a: Int, b: Int) {
						InterfaceDebug.setText('Initializing equipments...');
					})
					.onComplete(function(lib: AssetLibrary) {
						Assets.registerLibrary('equipments', lib);
						AssetsManager.additional.push('equipments');
						InterfaceDebug.setText('Initialized equipments.');
						AssetLibrary.loadFromFile('../assets/swf/furs.bundle')
						.onProgress(function(a: Int, b: Int) {
							InterfaceDebug.setText('Initializing furs...');
						})
						.onComplete(function(lib: AssetLibrary) {
							Assets.registerLibrary('furs', lib);
							AssetsManager.additional.push('furs');
							InterfaceDebug.setText('Initialized furs.');
							AssetLibrary.loadFromFile('../assets/swf/animations.bundle')
							.onProgress(function(a: Int, b: Int) {
								InterfaceDebug.setText('Initializing animations');
							})
							.onComplete(function(lib: AssetLibrary) {
								Assets.registerLibrary('animations', lib);
								AssetsManager.additional.push('animations');
								InterfaceDebug.setText('Initialized animations.');
								this.start();
							});
						});
					});
				});
			});
		});
		
	}
}