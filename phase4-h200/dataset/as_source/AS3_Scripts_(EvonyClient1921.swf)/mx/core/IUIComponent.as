// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IUIComponent

package mx.core
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import mx.managers.ISystemManager;

    public interface IUIComponent extends IFlexDisplayObject 
    {

        function set focusPane(_arg_1:Sprite):void;
        function get enabled():Boolean;
        function set enabled(_arg_1:Boolean):void;
        function set isPopUp(_arg_1:Boolean):void;
        function get explicitMinHeight():Number;
        function get percentWidth():Number;
        function get isPopUp():Boolean;
        function get owner():DisplayObjectContainer;
        function get percentHeight():Number;
        function get baselinePosition():Number;
        function owns(_arg_1:DisplayObject):Boolean;
        function initialize():void;
        function get maxWidth():Number;
        function get minWidth():Number;
        function getExplicitOrMeasuredWidth():Number;
        function get explicitMaxWidth():Number;
        function get explicitMaxHeight():Number;
        function set percentHeight(_arg_1:Number):void;
        function get minHeight():Number;
        function set percentWidth(_arg_1:Number):void;
        function get document():Object;
        function get focusPane():Sprite;
        function getExplicitOrMeasuredHeight():Number;
        function set tweeningProperties(_arg_1:Array):void;
        function set explicitWidth(_arg_1:Number):void;
        function set measuredMinHeight(_arg_1:Number):void;
        function get explicitMinWidth():Number;
        function get tweeningProperties():Array;
        function get maxHeight():Number;
        function set owner(_arg_1:DisplayObjectContainer):void;
        function set includeInLayout(_arg_1:Boolean):void;
        function setVisible(_arg_1:Boolean, _arg_2:Boolean=false):void;
        function parentChanged(_arg_1:DisplayObjectContainer):void;
        function get explicitWidth():Number;
        function get measuredMinHeight():Number;
        function set measuredMinWidth(_arg_1:Number):void;
        function set explicitHeight(_arg_1:Number):void;
        function get includeInLayout():Boolean;
        function get measuredMinWidth():Number;
        function get explicitHeight():Number;
        function set systemManager(_arg_1:ISystemManager):void;
        function set document(_arg_1:Object):void;
        function get systemManager():ISystemManager;

    }
}//package mx.core

