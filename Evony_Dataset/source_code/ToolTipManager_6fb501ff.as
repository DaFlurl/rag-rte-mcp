// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.ToolTipManager

package mx.managers
{
    import flash.events.EventDispatcher;
    import flash.display.DisplayObject;
    import mx.core.IUIComponent;
    import mx.core.IToolTip;
    import mx.effects.IAbstractEffect;
    import mx.core.Singleton;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ToolTipManager extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var implClassDependency:ToolTipManagerImpl;
        private static var _impl:IToolTipManager2;


        mx_internal static function registerToolTip(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void
        {
            impl.registerToolTip(_arg_1, _arg_2, _arg_3);
        }

        public static function get enabled():Boolean
        {
            return (impl.enabled);
        }

        public static function set enabled(_arg_1:Boolean):void
        {
            impl.enabled = _arg_1;
        }

        public static function createToolTip(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:String=null, _arg_5:IUIComponent=null):IToolTip
        {
            return (impl.createToolTip(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5));
        }

        public static function set hideDelay(_arg_1:Number):void
        {
            impl.hideDelay = _arg_1;
        }

        public static function set showDelay(_arg_1:Number):void
        {
            impl.showDelay = _arg_1;
        }

        public static function get showDelay():Number
        {
            return (impl.showDelay);
        }

        public static function destroyToolTip(_arg_1:IToolTip):void
        {
            return (impl.destroyToolTip(_arg_1));
        }

        public static function get scrubDelay():Number
        {
            return (impl.scrubDelay);
        }

        public static function get toolTipClass():Class
        {
            return (impl.toolTipClass);
        }

        mx_internal static function registerErrorString(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void
        {
            impl.registerErrorString(_arg_1, _arg_2, _arg_3);
        }

        mx_internal static function sizeTip(_arg_1:IToolTip):void
        {
            impl.sizeTip(_arg_1);
        }

        public static function set currentTarget(_arg_1:DisplayObject):void
        {
            impl.currentTarget = _arg_1;
        }

        public static function set showEffect(_arg_1:IAbstractEffect):void
        {
            impl.showEffect = _arg_1;
        }

        private static function get impl():IToolTipManager2
        {
            if (!_impl)
            {
                _impl = IToolTipManager2(Singleton.getInstance("mx.managers::IToolTipManager2"));
            };
            return (_impl);
        }

        public static function get hideDelay():Number
        {
            return (impl.hideDelay);
        }

        public static function set hideEffect(_arg_1:IAbstractEffect):void
        {
            impl.hideEffect = _arg_1;
        }

        public static function set scrubDelay(_arg_1:Number):void
        {
            impl.scrubDelay = _arg_1;
        }

        public static function get currentToolTip():IToolTip
        {
            return (impl.currentToolTip);
        }

        public static function set currentToolTip(_arg_1:IToolTip):void
        {
            impl.currentToolTip = _arg_1;
        }

        public static function get showEffect():IAbstractEffect
        {
            return (impl.showEffect);
        }

        public static function get currentTarget():DisplayObject
        {
            return (impl.currentTarget);
        }

        public static function get hideEffect():IAbstractEffect
        {
            return (impl.hideEffect);
        }

        public static function set toolTipClass(_arg_1:Class):void
        {
            impl.toolTipClass = _arg_1;
        }


    }
}//package mx.managers

