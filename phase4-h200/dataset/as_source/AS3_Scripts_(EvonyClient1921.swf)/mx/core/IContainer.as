// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IContainer

package mx.core
{
    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.text.TextSnapshot;
    import flash.geom.Point;
    import flash.media.SoundTransform;
    import mx.managers.IFocusManager;
    import flash.geom.Rectangle;

    public interface IContainer extends IUIComponent 
    {

        function set hitArea(_arg_1:Sprite):void;
        function swapChildrenAt(_arg_1:int, _arg_2:int):void;
        function getChildByName(_arg_1:String):DisplayObject;
        function get doubleClickEnabled():Boolean;
        function get graphics():Graphics;
        function get useHandCursor():Boolean;
        function addChildAt(_arg_1:DisplayObject, _arg_2:int):DisplayObject;
        function set mouseChildren(_arg_1:Boolean):void;
        function set creatingContentPane(_arg_1:Boolean):void;
        function get textSnapshot():TextSnapshot;
        function getChildIndex(_arg_1:DisplayObject):int;
        function set doubleClickEnabled(_arg_1:Boolean):void;
        function getObjectsUnderPoint(_arg_1:Point):Array;
        function get creatingContentPane():Boolean;
        function setChildIndex(_arg_1:DisplayObject, _arg_2:int):void;
        function get soundTransform():SoundTransform;
        function set useHandCursor(_arg_1:Boolean):void;
        function get numChildren():int;
        function contains(_arg_1:DisplayObject):Boolean;
        function get verticalScrollPosition():Number;
        function set defaultButton(_arg_1:IFlexDisplayObject):void;
        function swapChildren(_arg_1:DisplayObject, _arg_2:DisplayObject):void;
        function set horizontalScrollPosition(_arg_1:Number):void;
        function get focusManager():IFocusManager;
        function startDrag(_arg_1:Boolean=false, _arg_2:Rectangle=null):void;
        function set mouseEnabled(_arg_1:Boolean):void;
        function getChildAt(_arg_1:int):DisplayObject;
        function set soundTransform(_arg_1:SoundTransform):void;
        function get tabChildren():Boolean;
        function get tabIndex():int;
        function set focusRect(_arg_1:Object):void;
        function get hitArea():Sprite;
        function get mouseChildren():Boolean;
        function removeChildAt(_arg_1:int):DisplayObject;
        function get defaultButton():IFlexDisplayObject;
        function stopDrag():void;
        function set tabEnabled(_arg_1:Boolean):void;
        function get horizontalScrollPosition():Number;
        function get focusRect():Object;
        function get viewMetrics():EdgeMetrics;
        function set verticalScrollPosition(_arg_1:Number):void;
        function get dropTarget():DisplayObject;
        function get mouseEnabled():Boolean;
        function set tabChildren(_arg_1:Boolean):void;
        function set buttonMode(_arg_1:Boolean):void;
        function get tabEnabled():Boolean;
        function get buttonMode():Boolean;
        function removeChild(_arg_1:DisplayObject):DisplayObject;
        function set tabIndex(_arg_1:int):void;
        function addChild(_arg_1:DisplayObject):DisplayObject;
        function areInaccessibleObjectsUnderPoint(_arg_1:Point):Boolean;

    }
}//package mx.core

