// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.DragManager

package mx.managers
{
    import mx.core.Singleton;
    import mx.managers.dragClasses.DragProxy;
    import mx.core.IUIComponent;
    import mx.core.DragSource;
    import flash.events.MouseEvent;
    import mx.core.IFlexDisplayObject;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DragManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const NONE:String = "none";
        public static const COPY:String = "copy";
        public static const MOVE:String = "move";
        public static const LINK:String = "link";
        private static var implClassDependency:DragManagerImpl;
        private static var _impl:IDragManager;


        private static function get impl():IDragManager
        {
            if (!_impl)
            {
                _impl = IDragManager(Singleton.getInstance("mx.managers::IDragManager"));
            };
            return (_impl);
        }

        mx_internal static function get dragProxy():DragProxy
        {
            return (Object(impl).dragProxy);
        }

        public static function showFeedback(_arg_1:String):void
        {
            impl.showFeedback(_arg_1);
        }

        public static function acceptDragDrop(_arg_1:IUIComponent):void
        {
            impl.acceptDragDrop(_arg_1);
        }

        public static function doDrag(_arg_1:IUIComponent, _arg_2:DragSource, _arg_3:MouseEvent, _arg_4:IFlexDisplayObject=null, _arg_5:Number=0, _arg_6:Number=0, _arg_7:Number=0.5, _arg_8:Boolean=true):void
        {
            impl.doDrag(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8);
        }

        mx_internal static function endDrag():void
        {
            impl.endDrag();
        }

        public static function get isDragging():Boolean
        {
            return (impl.isDragging);
        }

        public static function getFeedback():String
        {
            return (impl.getFeedback());
        }


    }
}//package mx.managers

