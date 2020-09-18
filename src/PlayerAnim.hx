package;

import openfl.geom.ColorTransform;
import openfl.display.Sprite;
import openfl.utils.AssetType;
import openfl.Assets;
import openfl.display.MovieClip;

class PlayerAnim {
	public static final DEFAULT_FUR_ID: Int = 1;
	private static final LOOK_SLOT: Map<String, Array<Int>> = {
		var face: Array<Int> = [0, 3, 5, 4]; // head, mouth, hairstyle, neck
		var ears: Array<Int> = [2];
		var eye: Array<Int> = [7, 1]; // contact lenses, eye
		var other: Array<Int> = [1];
		var tail: Array<Int> = [6];
		var arm: Array<Int> = [9];
		var shield: Array<Int> = [10];
		var hands: Array<Int> = [8];
		[
			'Tete_1' => face, 
			'OreilleD_1' => ears,
			'Oeil_1' => eye,
			'OeilVide_1' => other,
			'Oeil2_1' => other,
			'Oeil3_1' => other,
			'Oeil4_1' => other,
			'Boule_1' => tail,
			'Arme_1' => arm,
			'Bouclier_1' => shield,
			'Gant_1' => hands
		];
	};

	public static function getAnim(lib: String, fur: Int, animName: String, colors: Array<Int> = null): MovieClip {
		var assetLib = Assets.getLibrary(lib);
		if (assetLib == null) return null;
		var clip: MovieClip = null;
		var colorsLength: Int = colors != null ? colors.length : 0;

		if (assetLib.exists(animName, cast AssetType.MOVIE_CLIP)) {
			clip = Assets.getMovieClip('$lib:$animName');
			if (clip == null) return null;
		}
		var furLib = Assets.getLibrary(fur == 1 ? 'resources' : 'furs');
		for (i in 0...clip.numChildren) {
			var child: Sprite = cast clip.getChildAt(i);
			if (child != null) {
				if (child.name.indexOf('instnace') != 0) {
					var furClip: MovieClip;
					var furString: String = '${fur == 1 ? 'resources' : 'furs'}:_${child.name}_${fur}_1';
					if (furLib.exists(furString.split(':')[1], cast AssetType.MOVIE_CLIP))
						furClip = Assets.getMovieClip(furString);
					else continue;
					child.addChild(furClip);
					if (colorsLength == 0) continue;
					else {
						for (num in 0...furClip.numChildren) {
							var shape = furClip.getChildAt(num);
							if (shape.name.charAt(0) == 'c') {
								var x: Int = Std.parseInt(child.name.charAt(1));
								if (x < colorsLength) {
									var color = colors[x];
									var rgb = [(color >> 16) & 0xff, (color >> 8) & 0xff, color & 0xff];
									shape.transform.colorTransform = new ColorTransform(rgb[0] / 0x80, rgb[1] / 0x80, rgb[2] / 0x80);
								}
							}
						}
					}
				}
			}
		}
		return clip;
	}
}