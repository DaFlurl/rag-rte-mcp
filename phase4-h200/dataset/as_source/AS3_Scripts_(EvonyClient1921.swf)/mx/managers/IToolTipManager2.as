// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.managers.IToolTipManager2

package mx.managers
{
    import flash.display.DisplayObject;
    import mx.effects.IAbstractEffect;
    import mx.core.IUIComponent;
    import mx.core.IToolTip;

    public interface IToolTipManager2 
    {

        function registerToolTip(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void;
        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;
        function get scrubDelay():Number;
        function set hideEffect(_arg_1:IAbstractEffect):void;
        function createToolTip(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:String=null, _arg_5:IUIComponent=null):IToolTip;
        function set scrubDelay(_arg_1:Number):void;
        function set hideDelay(_arg_1:Number):void;
        function get currentTarget():DisplayObject;
        function set showDelay(_arg_1:Number):void;
        function get showDelay():Number;
        function get showEffect():IAbstractEffect;
        function get hideDelay():Number;
        function get currentToolTip():IToolTip;
        function get hideEffect():IAbstractEffect;
        function set currentToolTip(_arg_1:IToolTip):void;
        function get toolTipClass():Class;
        function registerErrorString(_arg_1:DisplayObject, _arg_2:String, _arg_3:String):void;
        function destroyToolTip(_arg_1:IToolTip):void;
        function set toolTipClass(_arg_1:Class):void;
        function sizeTip(_arg_1:IToolTip):void;
        function set currentTarget(_arg_1:DisplayObject):void;
        function set showEffect(_arg_1:IAbstractEffect):void;

    }
}//package mx.managers

