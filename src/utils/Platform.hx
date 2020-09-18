package utils;

import js.Browser;
import openfl.system.Capabilities;

class Platform {

	@:isVar public static var os(get, null): String = '';

	public static function get_os(): String {
		var userAgent: String = Browser.navigator.userAgent,
			platform: String = Browser.navigator.platform;
		if (~/Mac|iPhone|iPod|iPad|Pike v/.match(platform)) return 'Mac OS';
		else if (~/Linux/.match(platform)) return 'Linux';
		else if (~/Win|Windows|Pocket PC|OS\/2/.match(platform)) return 'Windows';
		return '';
	}

	public static var isDesktop: Bool = Capabilities.playerType == 'Desktop';
	public static var isMacOS: Bool = Platform.os == 'Mac OS';
	public static var isLinux: Bool = Platform.os == 'Linux';
	public static var isWindows: Bool = Platform.os == 'Windows';
	public static var isPlugin: Bool = Capabilities.playerType == 'PlugIn';
}