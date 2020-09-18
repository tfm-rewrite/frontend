package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":"mapictures","assets":"aoy4:pathy11:swflite.biny4:sizei100y4:typey4:TEXTy2:idR1gh","rootPath":"assets/swf/mapictures.bundle","version":2,"libraryArgs":["swflite.bin","puuAbALqK3iUi7H2xc6A"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/mapictures.bundle", library);
		data = '{"name":"equipments","assets":"aoy4:pathy11:swflite.biny4:sizei100y4:typey4:TEXTy2:idR1gh","rootPath":"assets/swf/equipments.bundle","version":2,"libraryArgs":["swflite.bin","PLhIWAYEPTd3WAMZivOA"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/equipments.bundle", library);
		data = '{"name":"transformice","assets":"aoy4:pathy17:symbols%2F641.pngy4:sizei100y4:typey5:IMAGEy2:idR1goR0y17:symbols%2F165.pngR2i100R3R4R5R6goR0y17:symbols%2F192.pngR2i100R3R4R5R7goR0y17:symbols%2F638.pngR2i100R3R4R5R8goR0y17:symbols%2F162.pngR2i100R3R4R5R9goR0y17:symbols%2F189.pngR2i100R3R4R5R10goR0y16:symbols%2F21.pngR2i100R3R4R5R11goR0y16:symbols%2F20.pngR2i100R3R4R5R12goR0y17:symbols%2F159.jpgR2i100R3R4R5R13goR0y16:symbols%2F19.pngR2i100R3R4R5R14goR0y17:symbols%2F186.pngR2i100R3R4R5R15goR0y16:symbols%2F18.pngR2i100R3R4R5R16goR0y16:symbols%2F17.pngR2i100R3R4R5R17goR0y17:symbols%2F156.pngR2i100R3R4R5R18goR0y16:symbols%2F16.pngR2i100R3R4R5R19goR0y17:symbols%2F183.pngR2i100R3R4R5R20goR0y16:symbols%2F15.pngR2i100R3R4R5R21goR0y16:symbols%2F14.pngR2i100R3R4R5R22goR0y17:symbols%2F153.pngR2i100R3R4R5R23goR0y16:symbols%2F13.pngR2i100R3R4R5R24goR0y18:symbols%2F1020.jpgR2i100R3R4R5R25goR0y17:symbols%2F180.pngR2i100R3R4R5R26goR0y16:symbols%2F12.pngR2i100R3R4R5R27goR0y16:symbols%2F11.jpgR2i100R3R4R5R28goR0y18:symbols%2F1018.jpgR2i100R3R4R5R29goR0y17:symbols%2F150.pngR2i100R3R4R5R30goR0y16:symbols%2F10.pngR2i100R3R4R5R31goR0y17:symbols%2F177.pngR2i100R3R4R5R32goR0y15:symbols%2F9.pngR2i100R3R4R5R33goR0y18:symbols%2F1016.jpgR2i100R3R4R5R34goR0y15:symbols%2F8.pngR2i100R3R4R5R35goR0y17:symbols%2F147.pngR2i100R3R4R5R36goR0y15:symbols%2F7.pngR2i100R3R4R5R37goR0y18:symbols%2F1014.jpgR2i100R3R4R5R38goR0y17:symbols%2F174.pngR2i100R3R4R5R39goR0y15:symbols%2F6.pngR2i100R3R4R5R40goR0y15:symbols%2F5.pngR2i100R3R4R5R41goR0y18:symbols%2F1012.jpgR2i100R3R4R5R42goR0y17:symbols%2F144.pngR2i100R3R4R5R43goR0y15:symbols%2F4.pngR2i100R3R4R5R44goR0y17:symbols%2F171.pngR2i100R3R4R5R45goR0y15:symbols%2F3.pngR2i100R3R4R5R46goR0y15:symbols%2F2.pngR2i100R3R4R5R47goR0y15:symbols%2F1.pngR2i100R3R4R5R48goR0y17:symbols%2F168.jpgR2i100R3R4R5R49goR0y18:symbols%2F168a.pngR2i100R3R4R5R50goR0y11:swflite.binR2i100R3y4:TEXTR5R51gh","rootPath":"assets/swf/transformice.bundle","version":2,"libraryArgs":["swflite.bin","YLNRorQRCxVEZTNqHY6V"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/transformice.bundle", library);
		data = '{"name":"resources","assets":"aoy4:pathy18:symbols%2F1063.pngy4:sizei100y4:typey5:IMAGEy2:idR1goR0y17:symbols%2F376.pngR2i100R3R4R5R6goR0y15:symbols%2F5.pngR2i100R3R4R5R7goR0y17:symbols%2F368.pngR2i100R3R4R5R8goR0y18:symbols%2F1275.jpgR2i100R3R4R5R9goR0y17:symbols%2F372.pngR2i100R3R4R5R10goR0y11:swflite.binR2i100R3y4:TEXTR5R11gh","rootPath":"assets/swf/resources.bundle","version":2,"libraryArgs":["swflite.bin","yiGtFABqBIOyA1kcJlqp"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/resources.bundle", library);
		data = '{"name":"furs","assets":"aoy4:pathy11:swflite.biny4:sizei100y4:typey4:TEXTy2:idR1gh","rootPath":"assets/swf/furs.bundle","version":2,"libraryArgs":["swflite.bin","ydMcp1wKHEfQpgPRzaVU"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/furs.bundle", library);
		data = '{"name":"animations","assets":"aoy4:pathy11:swflite.biny4:sizei100y4:typey4:TEXTy2:idR1gh","rootPath":"assets/swf/animations.bundle","version":2,"libraryArgs":["swflite.bin","1XRzKmvWZ0uDIh6wZhWJ"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("assets/swf/animations.bundle", library);
		data = '{"name":null,"assets":"aoy4:pathy41:assets%2Fimages%2Fx_ui%2Fdecoration_3.pngy4:sizei7499y4:typey5:IMAGEy2:idR1y7:preloadtgoR0y33:assets%2Fimages%2Fx_ui%2Fwood.pngR2i60457R3R4R5R7R6tgoR0y44:assets%2Fimages%2Fx_ui%2Fx_game%2Ftopbar.jpgR2i4732R3R4R5R8R6tgoR0y45:assets%2Fimages%2Fx_ui%2Fx_game%2Fchatbar.jpgR2i15254R3R4R5R9R6tgoR0y47:assets%2Fimages%2Fx_ui%2Fx_game%2Fchatbar_2.pngR2i793R3R4R5R10R6tgoR0y46:assets%2Fimages%2Fx_ui%2Fx_game%2Ftopbar_2.pngR2i716R3R4R5R11R6tgoR0y36:assets%2Fimages%2Fx_ui%2Faclouds.pngR2i97542R3R4R5R12R6tgoR0y41:assets%2Fimages%2Fx_ui%2Fdecoration_2.pngR2i2449R3R4R5R13R6tgoR0y35:assets%2Fimages%2Fx_ui%2Fclouds.pngR2i94704R3R4R5R14R6tgoR0y38:assets%2Fimages%2Fx_ui%2Fborders_2.pngR2i14573R3R4R5R15R6tgoR0y39:assets%2Fimages%2Fx_ui%2Fcheese.png.pngR2i20598R3R4R5R16R6tgoR0y34:assets%2Fimages%2Fx_ui%2Ftitle.pngR2i288R3R4R5R17R6tgoR0y36:assets%2Fimages%2Fx_ui%2Fborders.pngR2i20918R3R4R5R18R6tgoR0y35:assets%2Fimages%2Fx_ui%2Fcheese.pngR2i4321R3R4R5R19R6tgoR0y39:assets%2Fimages%2Fx_ui%2Fdecoration.pngR2i1671R3R4R5R20R6tgoR0y32:assets%2Fimages%2Fflags%2Fgb.pngR2i30498R3R4R5R21R6tgoR0y32:assets%2Fimages%2Fflags%2Fsa.pngR2i35842R3R4R5R22R6tgoR0y35:assets%2Fimages%2Fx_grounds%2F0.pngR2i2158R3R4R5R23R6tgoR0y36:assets%2Fimages%2Fx_grounds%2F12.pngR2i2029R3R4R5R24R6tgoR0y35:assets%2Fimages%2Fx_grounds%2F5.pngR2i2086R3R4R5R25R6tgoR0y35:assets%2Fimages%2Fx_grounds%2F4.pngR2i2231R3R4R5R26R6tgoR0y46:assets%2Fimages%2Fx_login_screen%2Fx_beach.jpgR2i92208R3R4R5R27R6tgoR2i22208R3y5:MUSICR5y32:assets%2Fsounds%2Fmouseclick.mp3y9:pathGroupaR29hR6tgoR2i954107R3R28R5y27:assets%2Fsounds%2Fintro.mp3R30aR31hR6tgoR0y29:assets%2Ffonts%2Fsoopafre.ttfR2i51352R3y6:BINARYR5R32R6tgoR0y23:assets%2Fcss%2Fmain.cssR2i5687R3R33R5R34R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_wood_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_topbar_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_chatbar_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_chatbar_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_topbar_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_aclouds_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_clouds_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_borders_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_cheese_png_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_title_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_borders_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_cheese_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_flags_gb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_flags_sa_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_x_login_screen_x_beach_jpg extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_mouseclick_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_intro_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_soopafre_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_mapictures_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_mapictures_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_equipments_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_equipments_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_641_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_165_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_192_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_638_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_162_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_189_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_21_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_20_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_159_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_19_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_186_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_18_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_17_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_156_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_16_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_183_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_15_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_14_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_153_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_13_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1020_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_180_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_12_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_11_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1018_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_150_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_10_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_177_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_9_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1016_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_8_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_147_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_7_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1014_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_174_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_6_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_5_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1012_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_144_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_4_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_171_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_3_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_2_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_168_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_168a_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_1063_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_376_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_5_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_368_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_1275_jpg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_372_png extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_furs_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_furs_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_animations_bundle_library_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_swf_animations_bundle_swflite_bin extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_css_main_css extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:image("assets/images/x_ui/decoration_3.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/wood.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_wood_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/x_game/topbar.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_topbar_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/x_game/chatbar.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_chatbar_jpg extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/x_game/chatbar_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_chatbar_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/x_game/topbar_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_x_game_topbar_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/aclouds.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_aclouds_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/decoration_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/clouds.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_clouds_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/borders_2.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_borders_2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/cheese.png.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_cheese_png_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/title.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_title_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/borders.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_borders_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/cheese.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_cheese_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_ui/decoration.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_ui_decoration_png extends lime.graphics.Image {}
@:keep @:image("assets/images/flags/gb.png") @:noCompletion #if display private #end class __ASSET__assets_images_flags_gb_png extends lime.graphics.Image {}
@:keep @:image("assets/images/flags/sa.png") @:noCompletion #if display private #end class __ASSET__assets_images_flags_sa_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_grounds/0.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_grounds/12.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_12_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_grounds/5.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_5_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_grounds/4.png") @:noCompletion #if display private #end class __ASSET__assets_images_x_grounds_4_png extends lime.graphics.Image {}
@:keep @:image("assets/images/x_login_screen/x_beach.jpg") @:noCompletion #if display private #end class __ASSET__assets_images_x_login_screen_x_beach_jpg extends lime.graphics.Image {}
@:keep @:file("assets/sounds/mouseclick.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_mouseclick_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/intro.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_intro_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/fonts/soopafre.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_soopafre_ttf extends haxe.io.Bytes {}
@:keep @:file("assets/swf/mapictures.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_mapictures_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/mapictures.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_mapictures_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/swf/equipments.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_equipments_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/equipments.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_equipments_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/641.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_641_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/165.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_165_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/192.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_192_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/638.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_638_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/162.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_162_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/189.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_189_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/21.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_21_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/20.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_20_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/159.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_159_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/19.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_19_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/186.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_186_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/18.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_18_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/17.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_17_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/156.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_156_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/16.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_16_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/183.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_183_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/15.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_15_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/14.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_14_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/153.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_153_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/13.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_13_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1020.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1020_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/180.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_180_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/12.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_12_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/11.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_11_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1018.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1018_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/150.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_150_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/10.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_10_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/177.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_177_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/9.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_9_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1016.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1016_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/8.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_8_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/147.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_147_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/7.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_7_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1014.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1014_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/174.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_174_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/6.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_6_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/5.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_5_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1012.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1012_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/144.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_144_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/4.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_4_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/171.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_171_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/3.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_3_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/2.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_2_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/1.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_1_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/168.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_168_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/symbols/168a.png") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_symbols_168a_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/transformice.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_transformice_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/1063.png") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_1063_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/376.png") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_376_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/5.png") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_5_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/368.png") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_368_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/1275.jpg") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_1275_jpg extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/symbols/372.png") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_symbols_372_png extends haxe.io.Bytes {}
@:keep @:file("assets/swf/resources.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_resources_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/swf/furs.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_furs_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/furs.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_furs_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/swf/animations.bundle/library.json") @:noCompletion #if display private #end class __ASSET__assets_swf_animations_bundle_library_json extends haxe.io.Bytes {}
@:keep @:file("assets/swf/animations.bundle/swflite.bin") @:noCompletion #if display private #end class __ASSET__assets_swf_animations_bundle_swflite_bin extends haxe.io.Bytes {}
@:keep @:file("assets/css/main.css") @:noCompletion #if display private #end class __ASSET__assets_css_main_css extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end
