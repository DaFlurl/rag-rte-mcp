// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.CursorManager

package mx.managers
{
    import mx.core.Singleton;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class CursorManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        public static const NO_CURSOR:int = 0;
        private static var implClassDependency:CursorManagerImpl;
        private static var _impl:ICursorManager;


        public static function set currentCursorYOffset(_arg_1:Number):void
        {
            impl.currentCursorYOffset = _arg_1;
        }

        mx_internal static function registerToUseBusyCursor(_arg_1:Object):void
        {
            impl.registerToUseBusyCursor(_arg_1);
        }

        public static function get currentCursorID():int
        {
            return (impl.currentCursorID);
        }

        public static function getInstance():ICursorManager
        {
            return (impl);
        }

        public static function removeBusyCursor():void
        {
            impl.removeBusyCursor();
        }

        public static function setCursor(_arg_1:Class, _arg_2:int=2, _arg_3:Number=0, _arg_4:Number=0):int
        {
            return (impl.setCursor(_arg_1, _arg_2, _arg_3, _arg_4));
        }

        public static function set currentCursorID(_arg_1:int):void
        {
            impl.currentCursorID = _arg_1;
        }

        mx_internal static function unRegisterToUseBusyCursor(_arg_1:Object):void
        {
            impl.unRegisterToUseBusyCursor(_arg_1);
        }

        private static function get impl():ICursorManager
        {
            if (!_impl)
            {
                _impl = ICursorManager(Singleton.getInstance("mx.managers::ICursorManager"));
            };
            return (_impl);
        }

        public static function removeAllCursors():void
        {
            impl.removeAllCursors();
        }

        public static function setBusyCursor():void
        {
            impl.setBusyCursor();
        }

        public static function showCursor():void
        {
            impl.showCursor();
        }

        public static function hideCursor():void
        {
            impl.hideCursor();
        }

        public static function removeCursor(_arg_1:int):void
        {
            impl.removeCursor(_arg_1);
        }

        public static function get currentCursorXOffset():Number
        {
            return (impl.currentCursorXOffset);
        }

        public static function get currentCursorYOffset():Number
        {
            return (impl.currentCursorYOffset);
        }

        public static function set currentCursorXOffset(_arg_1:Number):void
        {
            impl.currentCursorXOffset = _arg_1;
        }


    }
}//package mx.managers

