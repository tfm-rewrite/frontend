package;

import js.html.Animation;
import openfl.Vector;
import openfl.geom.ColorTransform;
import openfl.display.Sprite;
import lime.tools.AssetType;
import openfl.Assets;
import openfl.utils.AssetLibrary;
import openfl.display.MovieClip;
import openfl.utils.Dictionary;

class Animations {
	public static final NORMAL_FUR_ID:Int = 1;
	private static final LOOK_SLOT:Dictionary<String, Vector<Int>> = {
		var x = new Dictionary();
		var face:Vector<Int> = new Vector<Int>(4, true);
		face[0] = 0; // Head
		face[1] = 3; // Mouth
		face[2] = 5; // Hair style
		face[3] = 4; // Neck
		x["Tete_1"] = face;
		var rightEar:Vector<Int> = new Vector<Int>(1, true);
		rightEar[0] = 2; // Ears
		x["OreilleD_1"] = rightEar;
		var eye:Vector<Int> = new Vector<Int>(2, true);
		eye[0] = 7; // Contact Lenses
		eye[1] = 1; // Eye
		x["Oeil_1"] = eye;
		var other:Vector<Int> = new Vector<Int>(1, true);
		other[0] = 1;
		x["OeilVide_1"] = other;
		x["Oeil2_1"] = other;
		x["Oeil3_1"] = other;
		x["Oeil4_1"] = other;
		var tail:Vector<Int> = new Vector<Int>(1, true);
		tail[0] = 6;
		x["Boule_1"] = tail;
		var arm:Vector<Int> = new Vector<Int>(1, true);
		arm[0] = 9;
		x["Arme_1"] = arm;
		var shield:Vector<Int> = new Vector<Int>(1, true);
		shield[0] = 10;
		x["Bouclier_1"] = shield;
		var hands:Vector<Int> = new Vector<Int>(1, true);
		hands[0] = 8; // Hands
		x["Gant_1"] = hands;
		x;
	};
	private static final LIST_ANIMATIONS:Dictionary<String, Animations> = new Dictionary();
	private static final LOOK_PARTS:Dictionary<String, Bool> = new Dictionary();


	public static function getAnimation(libraryName: String, furId: Int, clipName: String, colors: Array<Int> = null): MovieClip {
		var assetLibrary = Assets.getLibrary(libraryName);
		if (assetLibrary == null)
			return null;
		var clip: MovieClip = null;
		var colorsN: Int = colors != null ? colors.length : 0;
		if (assetLibrary.exists(clipName, cast AssetType.MOVIE_CLIP)) {
			clip = Assets.getMovieClip(libraryName + ":" + clipName);
			if (clip == null)
				return null;
		}
		var furLibrary = Assets.getLibrary(furId == 1 ? "resources" : "furs");
		for (i in 0...clip.numChildren) {
			var child: Sprite = cast(clip.getChildAt(i), Sprite);
			if (child != null) {
				if (child.name.indexOf("instance") != 0) {
					var fur: MovieClip;
					var lookString: String = (furId == 1 ? "resources:" : "furs:") +"_" + child.name + "_" + furId + "_1";
					if (furLibrary.exists(lookString.split(":")[1], cast AssetType.MOVIE_CLIP))
						fur = Assets.getMovieClip(lookString);
					else 
						continue;
					child.addChild(fur);
					if (colorsN == 0)
						continue;
					for (x in 0...fur.numChildren) {
						var shape = fur.getChildAt(x);
						if (shape.name.charAt(0) == "c") {
							var r = Std.parseInt(child.name.charAt(1));
							if (r < colorsN) {
								var color = colors[r];
								var R = (color >> 16) & 0xFF;
								var G = (color >> 8) & 0xFF;
								var B = color & 0xFF;
								shape.transform.colorTransform = new ColorTransform(R / 0x80, G / 0x80, B / 0x80);
							}
						}
					}
				}
			}
		}
		return clip;
	}
}	