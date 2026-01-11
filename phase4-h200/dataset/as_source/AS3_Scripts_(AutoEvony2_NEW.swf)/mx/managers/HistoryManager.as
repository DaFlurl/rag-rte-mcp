// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.HistoryManager

package mx.managers
{
    import mx.core.Singleton;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HistoryManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        private static var implClassDependency:HistoryManagerImpl;
        private static var _impl:IHistoryManager;


        public static function save():void
        {
            impl.save();
        }

        private static function get impl():IHistoryManager
        {
            if (!_impl)
            {
                _impl = IHistoryManager(Singleton.getInstance("mx.managers::IHistoryManager"));
            };
            return (_impl);
        }

        public static function register(_arg_1:IHistoryManagerClient):void
        {
            impl.register(_arg_1);
        }

        public static function unregister(_arg_1:IHistoryManagerClient):void
        {
            impl.unregister(_arg_1);
        }

        public static function initialize(_arg_1:ISystemManager):void
        {
        }


    }
}//package mx.managers

