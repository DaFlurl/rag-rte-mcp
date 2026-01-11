// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.binding.utils.BindingUtils

package mx.binding.utils
{
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class BindingUtils 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function bindProperty(site:Object, prop:String, host:Object, chain:Object, commitOnly:Boolean=false):ChangeWatcher
        {
            var w:ChangeWatcher;
            var assign:Function;
            w = ChangeWatcher.watch(host, chain, null, commitOnly);
            if (w != null)
            {
                assign = function (_arg_1:*):void
                {
                    site[prop] = w.getValue();
                };
                w.setHandler(assign);
                (assign(null));
            };
            return (w);
        }

        public static function bindSetter(setter:Function, host:Object, chain:Object, commitOnly:Boolean=false):ChangeWatcher
        {
            var w:ChangeWatcher;
            var invoke:Function;
            w = ChangeWatcher.watch(host, chain, null, commitOnly);
            if (w != null)
            {
                invoke = function (_arg_1:*):void
                {
                    setter(w.getValue());
                };
                w.setHandler(invoke);
                (invoke(null));
            };
            return (w);
        }


    }
}//package mx.binding.utils

