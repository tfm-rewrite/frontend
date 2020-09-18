package map;

import openfl.Assets;
import openfl.utils.AssetType;
import openfl.display.BlendMode;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.display.DisplayObject;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.display.MovieClip;
import utils.AssetsManager;
import openfl.display.Sprite;

class MapCustomization extends Sprite {

	private static final terres: Array<String> = ['T4', 'T5'];
	private static final herbes: Array<String> = ['T6', 'T7'];
	private static final herbesNeige: Array<String> = ['T25', 'T26'];
	private static final herbesAutomne: Array<String> = ['T29', 'T30'];
	private static final herbesRose: Array<String> = ['T35', 'T36'];
	private static final pierres: Array<String> = ['T17', 'T18'];
	private static final pierres2: Array<String> = ['T20'];
	private static final toile: Array<String> = ['T28'];
	private static final sables: Array<String> = ['T0', 'T12'];
	private static final laves: Array<String> = ['T1', 'T2', 'T3'];
	private static final eaux: Array<String> = ['T13', 'T14'];
	private static final eaux2: Array<String> = ['T15', 'T16'];

	public static var background: Sprite = new Sprite();
	public static var foreground: Sprite = new Sprite();
	public static var textures: Map<String, Texture> = [];
	public static var grounds: Array<BitmapData> = [];
	public static var grounds2: Array<BitmapData> = [];
	private static var currentVector: Array<Sprite>;
	private static var texturesTemp: Array<Any> = [];
	private static var picturesTemp: Array<Sprite> = [];
	private static var groundsTemp: Array<Sprite> = [];
	private static var length: Int = 0;
	
	public static function initialization(): Void {
		var grounds: Array<String> = Assets.list(AssetType.IMAGE);
		for (i in 0...0xFFFF) {
			if (AssetsManager.image('assets/images/x_grounds/$i.png') != null) {
				texturesTemp.push(AssetsManager.image('assets/images/x_grounds/$i.png'));
				continue;
			}
			var clip: MovieClip = AssetsManager.clip("$T_"+ i);
			if (clip == null) break;
			texturesTemp.push(clip);
		}
		
		for (i in 0...0xFFFF) {
			var clip: MovieClip = AssetsManager.clip("$P_"+ i);
			if (clip == null) break;
			picturesTemp.push(clip);
		}
		groundsTemp.push(AssetsManager.clip("$Sol_Dur"));
		groundsTemp.push(AssetsManager.clip("$Glacon"));
		groundsTemp.push(AssetsManager.clip("$Transparent"));
		groundsTemp.push(AssetsManager.clip("$Sol_Rebond"));
		groundsTemp.push(AssetsManager.clip("$Sol_Chocolat"));
		Transformice.instance.stage.addEventListener(Event.ENTER_FRAME, initializationLoop);
	}

	public static function forceFinishInitialization(): Void {
		while (length < texturesTemp.length + picturesTemp.length + groundsTemp.length)
			initializationLoop(null);
	}

	public static function initializationLoop(event: Event): Void {
		if (length >= texturesTemp.length + picturesTemp.length + groundsTemp.length)
			Transformice.instance.stage.removeEventListener(Event.ENTER_FRAME, initializationLoop);
		if (length < texturesTemp.length) {
			for (i in 0...texturesTemp.length) {
				textures['T$i'] = new Texture(cast texturesTemp[i], 40, 40);
				length++;
			}
		} else if (length == texturesTemp.length) {
			for (i in 0...picturesTemp.length) {
				textures['P${i + texturesTemp.length}'] = new Texture(cast picturesTemp[i], 0, 0, 2);
				length++;
			}
		} else if (length == texturesTemp.length + picturesTemp.length) {
			for (i in 0...groundsTemp.length) {
				var clip: MovieClip = cast groundsTemp[i];
				var data: BitmapData = new BitmapData(400, 400, true, 0);
				clip.x = (clip.y = 2);
				clip.width = (clip.height = 396);
				var sprite: Sprite = new Sprite();
				sprite.addChild(clip);
				data.draw(sprite);
				grounds.push(data);
				
				data = new BitmapData(100, 100, true, 0);
				sprite = new Sprite();
				clip = cast groundsTemp[i];
				clip.width = (clip.height = 100);
				sprite.addChild(clip);
				data.draw(sprite);
				grounds2.push(data);
				length++;
			}
		}
	}

	public static function getGround(type: Int, width: Int, height: Int, blank: Bool = false, color: Int = 0x324650): DisplayObject {
		var data: BitmapData;
		var img: Bitmap;
		var sprite: Sprite = new Sprite();
		var w: Int;
		var h: Int;
		switch (type) {
			case Ground.WOOD: 
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				if (width < 20 || height < 20) 
					img = new Bitmap(grounds2[0], 'auto', true);
				else
					img = new Bitmap(grounds[0], 'auto', true);
				img.width = width;
				img.height = height;
				img.x = -(width/2);
				img.y = -(height/2);
				return img;
			case Ground.ICE:
				if (blank) {
					sprite.graphics.beginFill(0x89A7F5);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				if (width < 20 || height < 20) 
					img = new Bitmap(grounds2[1], 'auto', true);
				else
					img = new Bitmap(grounds[1], 'auto', true);
				img.width = width;
				img.height = height;
				img.x = -(width/2);
				img.y = -(height/2);
				return img;
			case Ground.TRAMPOLINE:
				if (blank) {
					sprite.graphics.beginFill(0x6D4E94);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				if (width < 20 || height < 20) 
					img = new Bitmap(grounds2[3], 'auto', true);
				else
					img = new Bitmap(grounds[3], 'auto', true);
				img.width = width;
				img.height = height;
				img.x = -(width/2);
				img.y = -(height/2);
				return img;
			case Ground.LAVA:
				if (blank) {
					sprite.graphics.beginFill(0xD84801);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, laves, w, h);
				sprite.addChild(new Bitmap(data));
			case Ground.CHOCOLATE:
				if (blank) {
					sprite.graphics.beginFill(0x2E190C);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				if (width < 20 || height < 20) 
					img = new Bitmap(grounds2[4], 'auto', true);
				else
					img = new Bitmap(grounds[4], 'auto', true);
				img.width = width;
				img.height = height;
				img.x = -(width/2);
				img.y = -(height/2);
				return img;
			case Ground.EARTH:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, terres, w, h);
				sprite.addChild(new Bitmap(data));
			case Ground.GRASS:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, terres, w, h);
				if (width % 40 == 0) 
					fillBorders(data, herbes, w, h, ['T9', 'T8', 'T10', 'T11']);
				else
					fillTop(data, herbes, w);
				sprite.addChild(new Bitmap(data));
			case Ground.SAND:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, sables, w, h);
				sprite.addChild(new Bitmap(data));
			case Ground.CLOUD:
				if (blank) {
					sprite.graphics.beginFill(0xCDE1E2, 0.3);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				if (width < 20 || height < 20) 
					img = new Bitmap(grounds2[2], 'auto', true);
				else
					img = new Bitmap(grounds[2], 'auto', true);
				img.width = width;
				img.height = height;
				img.x = -(width/2);
				img.y = -(height/2);
				return img;
			case Ground.WATER:
				if (blank) {
					sprite.graphics.beginFill(0x6DA7AF);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, eaux2, w, h);
				sprite.addChild(new Bitmap(data));			
			case Ground.STONE:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, pierres, w, h);
				if (width % 40 == 0) 
					fillBorders(data, pierres2, w, h, ['T19', 'T21', 'T22', 'T23']);
				else
					fillTop(data, pierres2, w);
				sprite.addChild(new Bitmap(data));
			case Ground.SNOW:
				if (blank) {
					sprite.graphics.beginFill(0xE7F0F2);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, terres, w, h);
				if (width % 40 == 0) 
					fillBorders(data, herbesNeige, w, h, ['T24', 'T27', 'T10', 'T11']);
				else
					fillTop(data, herbesNeige, w);
				sprite.addChild(new Bitmap(data));
			case Ground.RECTANGLE:
				sprite.graphics.beginFill(color);
				sprite.graphics.drawRect(0, 0, width, height);
				sprite.graphics.endFill();
				return sprite;
			case Ground.CIRCLE:
				sprite.graphics.beginFill(color);
				sprite.graphics.drawCircle(0, 0, width);
				sprite.graphics.endFill();
				return sprite;
			case Ground.INVISIBLE:
				sprite.graphics.beginFill(0, 0);
				sprite.graphics.drawRect(0, 0, width, height);
				sprite.graphics.endFill();
				return sprite;
			case Ground.WEB:
				if (blank) {
					sprite.graphics.beginFill(0x919A9C, 0.3);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillTop(data, toile, w);
				fillGround(data, toile, w, h, 0, 1);
				sprite.addChild(new Bitmap(data));
			case Ground.AUTUMN_GRASS:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, terres, w, h);
				if (width % 40 == 0) 
					fillBorders(data, herbesAutomne, w, h, ['T32', 'T31', 'T33', 'T34']);
				else
					fillTop(data, herbesAutomne, w);
				sprite.addChild(new Bitmap(data));
			case Ground.PINK_GRASS:
				if (blank) {
					sprite.graphics.beginFill(0x324650);
					sprite.graphics.drawRect(0, 0, width, height);
					sprite.graphics.endFill();
					return sprite;
				}
				data = new BitmapData(width, height, true, 0);
				w = Std.int(Math.ceil(width / 40));
				h = Std.int(Math.ceil(height / 40));
				fillGround(data, terres, w, h);
				if (width % 40 == 0) 
					fillBorders(data, herbesRose, w, h, ['T38', 'T37', 'T39', 'T40']);
				else
					fillTop(data, herbesRose, w);
				sprite.addChild(new Bitmap(data));
			
		}
		sprite.x = - (width / 2);
		sprite.y = - (height / 2);
		return sprite;
	}

	public static function fillTop(bmpData: BitmapData, texturesList: Array<String>, w: Int): BitmapData {
		var data: BitmapData;
		for (i in 0...w) {
			data = textures[texturesList[Std.int(Math.random() * texturesList.length)]].data;
			bmpData.copyPixels(data, new Rectangle(0, 0, 40, 40), new Point((i*40) - 1, -1), null, null, true);
		}
		return bmpData;
	}

	public static function fillGround(bmpData: BitmapData, texturesList: Array<String>, w: Int, h: Int, x: Int = 0, y: Int = 0): BitmapData {
		var data: BitmapData;
		var xx: Int = x;
		var yy: Int;
		while (xx < w) {
			yy = y;
			while (yy < h) {
				data = textures[texturesList[Std.int(Math.random() * texturesList.length)]].data;
				bmpData.copyPixels(data, new Rectangle(0, 0, 40, 40), new Point(xx * 40, yy * 40), null, null, true);
				yy++;
			}
			xx++;
		}
		return bmpData;
	}

	public static function fillBorders(bmpData: BitmapData, texturesList: Array<String>, w: Int, h: Int, t: Array<String>): BitmapData {
		var data: BitmapData;
		for (i in 1...(w-1)) {
			data = textures[texturesList[Std.int(Math.random() * texturesList.length)]].data;
			bmpData.copyPixels(data, new Rectangle(0, 0, 40, 40), new Point(i * 40, 0), null, null, true);
		}
		bmpData.copyPixels(textures[t[0]].data, new Rectangle(0, 0, 40, 40), new Point(0, 0), null, null, true);
		bmpData.copyPixels(textures[t[1]].data, new Rectangle(0, 0, 40, 40), new Point((w-1) * 40, 0), null, null, true);
		var a: Texture = textures[t[2]];
		var b: Texture = textures[t[3]];
		var i: Int = 1;
		while (i < h) {
			bmpData.copyPixels(a.data, new Rectangle(0, 0, 40, 40), new Point(0, i * 40), null, null, true);
			bmpData.copyPixels(b.data, new Rectangle(0, 0, 40, 40), new Point((w-1) * 40, i * 40), null, null, true);
			i++;
		}
		return bmpData;
	}

	// public function addGroundSprite() {
	// 	var clip: MovieClip = new MovieClip();
	// 	switch (this.ground.type) {
	// 		case 1:
	// 			clip = AssetsManager.clip("$Sol_Dur");
	// 	}
	// 	clip.width = this.ground.width;
	// 	clip.height = this.ground.width;
	// 	this.zero = new Zero(clip, false);
	// 	this.particle = new Particle(this.zero, false, Math.ceil(this.width), Math.ceil(this.height));
	// 	this.addChild(this.particle);
	// }
}