package packets.main.recv;

import utils.Packet;
import connection.Connection;

// C 4
class EditLanguage {
    public static var ccc: Int = 4 << 8 | 2;

    public static function handle(conn: Connection, packet: Packet) {
        var quantity: Int = packet.read16();
        for (i in 0...quantity) {
            var deletion: Bool = packet.readBool();
            var field: String = packet.readString();
            if (deletion) {
                return;
            }
            // packet.readString()
        }
    }
}