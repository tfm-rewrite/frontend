package utils;

import openfl.system.Capabilities;

class Platform {
	public static var isDesktop: Bool = Capabilities.playerType == 'Desktop';
	public static var isMacOS: Bool = Capabilities.os.indexOf('mac') != -1;
	public static var isLinux: Bool = Capabilities.os.toLowerCase().indexOf('linux') != -1;
	public static var isWinXP: Bool = Capabilities.os.toLowerCase().indexOf('windows xp') != -1;
	public static var isPlugin: Bool = Capabilities.playerType == 'PlugIn';	
}