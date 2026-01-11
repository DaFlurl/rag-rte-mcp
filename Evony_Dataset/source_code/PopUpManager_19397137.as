// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.PopUpManager

package mx.managers
{
    import mx.core.Singleton;
    import mx.core.IFlexDisplayObject;
    import flash.display.DisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class PopUpManager 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var implClassDependency:PopUpManagerImpl;
        private static var _impl:IPopUpManager;


        private static function get impl():IPopUpManager
        {
            if (!_impl)
            {
                _impl = IPopUpManager(Singleton.getInstance("mx.managers::IPopUpManager"));
            };
            return (_impl);
        }

        public static function removePopUp(_arg_1:IFlexDisplayObject):void
        {
            impl.removePopUp(_arg_1);
        }

        public static function addPopUp(_arg_1:IFlexDisplayObject, _arg_2:DisplayObject, _arg_3:Boolean=false, _arg_4:String=null):void
        {
            impl.addPopUp(_arg_1, _arg_2, _arg_3, _arg_4);
        }

        public static function centerPopUp(_arg_1:IFlexDisplayObject):void
        {
            impl.centerPopUp(_arg_1);
        }

        public static function bringToFront(_arg_1:IFlexDisplayObject):void
        {
            impl.bringToFront(_arg_1);
        }

        public static function createPopUp(_arg_1:DisplayObject, _arg_2:Class, _arg_3:Boolean=false, _arg_4:String=null):IFlexDisplayObject
        {
            return (impl.createPopUp(_arg_1, _arg_2, _arg_3, _arg_4));
        }


    }
}//package mx.managers

