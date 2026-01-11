// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.UIComponentGlobals

package mx.core
{
    import mx.managers.ILayoutManager;
    import flash.display.InteractiveObject;
    import flash.geom.Matrix;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UIComponentGlobals 
    {

        mx_internal static var layoutManager:ILayoutManager;
        mx_internal static var callLaterSuspendCount:int = 0;
        mx_internal static var callLaterDispatcherCount:int = 0;
        mx_internal static var nextFocusObject:InteractiveObject;
        mx_internal static var tempMatrix:Matrix = new Matrix();
        mx_internal static var designTime:Boolean = false;
        private static var _catchCallLaterExceptions:Boolean = false;


        public static function set catchCallLaterExceptions(_arg_1:Boolean):void
        {
            _catchCallLaterExceptions = _arg_1;
        }

        public static function get designMode():Boolean
        {
            return (designTime);
        }

        public static function set designMode(_arg_1:Boolean):void
        {
            designTime = _arg_1;
        }

        public static function get catchCallLaterExceptions():Boolean
        {
            return (_catchCallLaterExceptions);
        }


    }
}//package mx.core

