package utils;

import js.Syntax;

class Async {
    extern public static inline function async(func: Void -> Void): Void {
        Syntax.code('async {0}', func)();
    }

    extern public static inline function await<M, T:js.lib.Promise<M>>(t: T): M {
        return Syntax.code('await {0}', t);
    }
}