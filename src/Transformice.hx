package;

import js.html.WebSocket;
import haxe.Timer;
import js.lib.Error;
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
		this.world.x = Lib.application.window.width;
		this.world.y = Lib.application.window.height;
		stage.addChild(this.world);
		this.initializationResources();
	}


	public static function set_defaultFrameRate(rate: Float): Float {
		return Transformice.defaultFrameRate = Transformice.instance.stage.frameRate = rate;
	}

	public static function get_defaultFrameRate(): Float {
		return Transformice.defaultFrameRate;
	}

	private function start(): Void {
		InterfaceDebug.setText('Connecting...');
		this.connect();
	}

	private function connect(index: Int = 0): Void {
		if (index >= Utils.ports.length)
			return InterfaceDebug.setText('Failed to connect to the servers.');
		for (i in index...Utils.ports.length) {
			InterfaceDebug.setText('Connecting to server ${Utils.ports[i]}...');
			Connection.main.connect('', Utils.ports[i]);
			Timer.delay(function() {
				if (Connection.main.transport.readyState != WebSocket.OPEN) {
					Connection.main.transport.close();
					this.connect(index + 1);
				}	
			}, 5000);
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
			InterfaceDebug.setText('Initialized resources.');
			AssetLibrary.loadFromFile('../assets/swf/transformice.bundle')
			.onProgress(function(a: Int, b: Int) {
				InterfaceDebug.setText('Initializing transofrmice...');
			})
			.onComplete(function(lib: AssetLibrary) {
				Assets.registerLibrary('transformice', lib);
				InterfaceDebug.setText('Initialized transformice.');
				AssetLibrary.loadFromFile('../assets/swf/mapictures.bundle')
				.onProgress(function(a: Int, b: Int) {
					InterfaceDebug.setText('Initializing maps...');
				})
				.onComplete(function(lib: AssetLibrary) {
					Assets.registerLibrary('mapictures', lib);
					MapCustomization.initialization();
					InterfaceDebug.setText('Initialized maps.');
					AssetLibrary.loadFromFile('../assets/swf/equipments.bundle')
					.onProgress(function(a: Int, b: Int) {
						InterfaceDebug.setText('Initializing equipments...');
					})
					.onComplete(function(lib: AssetLibrary) {
						Assets.registerLibrary('equipments', lib);
						InterfaceDebug.setText('Initialized equipments.');
						AssetLibrary.loadFromFile('../assets/swf/furs.bundle')
						.onProgress(function(a: Int, b: Int) {
							InterfaceDebug.setText('Initializing furs...');
						})
						.onComplete(function(lib: AssetLibrary) {
							Assets.registerLibrary('furs', lib);
							InterfaceDebug.setText('Initialized furs.');
							this.start();
						});
					});
				});
			});
		});
		
	}
}