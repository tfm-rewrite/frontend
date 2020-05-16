package resources;

import openfl.display.DisplayObject;
import openfl.display.Graphics;
import openfl.geom.Rectangle;
import openfl.display.Sprite;
import openfl.display.LoaderInfo;
import openfl.system.ApplicationDomain;
import openfl.system.LoaderContext;
import haxe.Resource;
import haxe.Constraints.Function;
import haxe.io.Error;
import openfl.net.URLRequest;
import openfl.events.IOErrorEvent;
import openfl.events.Event;
import openfl.display.Loader;
import openfl.display.BitmapData;
import openfl.utils.Dictionary;
import openfl.display.Bitmap;

class ResourcesImages
{
	public static var loadedUrls: Dictionary<Loader, String> = new Dictionary();
	private static var loaders: Array<Loader>;
	private static var bitmapsData: Dictionary<String, BitmapData> = new Dictionary();
	private static var bitmaps: Array<Bitmap> = new Array();
	private static var loaded: Bool = false;
	private static var queuedImages: Dictionary<String, Array<Bitmap>> = new Dictionary();
	private static var queuedUrls: Array<String> = new Array();
	private static var loaderCtx: LoaderContext;
	private static var completeEvent: Event = new Event(Event.COMPLETE);
	private static var options: Dictionary<String, Any> = new Dictionary();

	public static function getRemoteImage(imgName: String, imgDirectory: String = "", options: Dictionary<String, Any> = null): Bitmap 
	{
		if (options == null) options = new Dictionary();
		ResourcesImages.options = options;
		var loader: Loader;
		if (loaders == null) {
			loaders = new Array();
			for (i in 0...10) 
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoad);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onImageLoadError);
				loaders.push(loader);
			}
		}
		var full_url: String = imgDirectory == "" ? imgName : '$imgDirectory/$imgName';
		var img: Bitmap = new Bitmap();
		if (bitmapsData[full_url] != null) {
			img.bitmapData = bitmapsData[full_url];
			bitmaps.push(img);
			if (!loaded) {
				loaded = true;
				Transformice.instance.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		} else
		{
			if (queuedImages[full_url] != null)
				queuedImages[full_url].push(img);
			else 
			{
				queuedImages[full_url] = new Array();
				queuedImages[full_url].push(img);
				queuedUrls.push(full_url);
				loadQueuedImages();
			}
		}
		
		return img;
	}

	private static function loadQueuedImages(): Void
	{
		if (queuedUrls.length == 0 || loaders.length == 0) return;
		var currentURL: String;
		var currentLoader: Loader;
		try 
		{
			currentURL = queuedUrls.shift();
			currentLoader = loaders.shift();
			loadedUrls[currentLoader] = currentURL;
			if (loaderCtx == null)
				loaderCtx = new LoaderContext(true, ApplicationDomain.currentDomain);
			currentLoader.load(new URLRequest(currentURL), loaderCtx);
			loadQueuedImages();
		} catch (err: Error)
		{
			loadQueuedImages();
			throw err;
		}
	}

	private static function onEnterFrame(evnt: Event): Void 
	{
		while (bitmaps.length > 0)
			bitmaps.shift().dispatchEvent(completeEvent);
		Transformice.instance.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		loaded = false;
	}

	private static function onImageLoad(event: Event): Void
	{
		var bmpData: BitmapData;
		var loader: Loader = null;
		var url: String;
		var queued: Array<Bitmap>;
		var img: Bitmap;
		try {
			loader = cast(event.currentTarget, LoaderInfo).loader;
			bmpData = new BitmapData(Math.ceil(loader.content.getRect(loader.content).width), Math.ceil(loader.content.getRect(loader.content).height), true, 0);
			bmpData.draw(loader.content);
			url = loadedUrls[loader];
			trace(options);
			if (options["round"] != null) 
				bmpData = Utils.roundImageRect(bmpData, Std.int(options["round"]));
			
			bitmapsData[url] = bmpData;
			queued = queuedImages[url];
			if (queued != null)
			{
				queuedImages.remove(url);
				for (i in 0...queued.length) {
					img = queued[i];
					img.bitmapData = bmpData;
					img.dispatchEvent(completeEvent);
				}
			}
			loadQueuedImages();
		} catch (err: Error) {
			if (loader != null)
				loaders.push(loader);
			loadQueuedImages();
			throw err;
		}
	}

	private static function onImageLoadError(event: IOErrorEvent): Void
	{
		var loader: Loader = cast(event.currentTarget, LoaderInfo).loader;
		var url: String = loadedUrls[loader];
		queuedImages.remove(url);
		loaders.push(loader);
		loadQueuedImages();
	}
}