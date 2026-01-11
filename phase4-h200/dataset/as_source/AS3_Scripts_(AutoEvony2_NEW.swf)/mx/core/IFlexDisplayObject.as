// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IFlexDisplayObject

package mx.core
{
    import flash.display.IBitmapDrawable;
    import flash.events.IEventDispatcher;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.accessibility.AccessibilityProperties;
    import flash.display.DisplayObjectContainer;
    import flash.display.DisplayObject;
    import flash.geom.Transform;
    import flash.display.LoaderInfo;
    import flash.display.Stage;

    public interface IFlexDisplayObject extends IBitmapDrawable, IEventDispatcher 
    {

        function get visible():Boolean;
        function get rotation():Number;
        function localToGlobal(_arg_1:Point):Point;
        function get name():String;
        function set width(_arg_1:Number):void;
        function get measuredHeight():Number;
        function get blendMode():String;
        function get scale9Grid():Rectangle;
        function set name(_arg_1:String):void;
        function set scaleX(_arg_1:Number):void;
        function set scaleY(_arg_1:Number):void;
        function get measuredWidth():Number;
        function get accessibilityProperties():AccessibilityProperties;
        function set scrollRect(_arg_1:Rectangle):void;
        function get cacheAsBitmap():Boolean;
        function globalToLocal(_arg_1:Point):Point;
        function get height():Number;
        function set blendMode(_arg_1:String):void;
        function get parent():DisplayObjectContainer;
        function getBounds(_arg_1:DisplayObject):Rectangle;
        function get opaqueBackground():Object;
        function set scale9Grid(_arg_1:Rectangle):void;
        function setActualSize(_arg_1:Number, _arg_2:Number):void;
        function set alpha(_arg_1:Number):void;
        function set accessibilityProperties(_arg_1:AccessibilityProperties):void;
        function get width():Number;
        function hitTestPoint(_arg_1:Number, _arg_2:Number, _arg_3:Boolean=false):Boolean;
        function set cacheAsBitmap(_arg_1:Boolean):void;
        function get scaleX():Number;
        function get scaleY():Number;
        function get scrollRect():Rectangle;
        function get mouseX():Number;
        function get mouseY():Number;
        function set height(_arg_1:Number):void;
        function set mask(_arg_1:DisplayObject):void;
        function getRect(_arg_1:DisplayObject):Rectangle;
        function get alpha():Number;
        function set transform(_arg_1:Transform):void;
        function move(_arg_1:Number, _arg_2:Number):void;
        function get loaderInfo():LoaderInfo;
        function get root():DisplayObject;
        function hitTestObject(_arg_1:DisplayObject):Boolean;
        function set opaqueBackground(_arg_1:Object):void;
        function set visible(_arg_1:Boolean):void;
        function get mask():DisplayObject;
        function set x(_arg_1:Number):void;
        function set y(_arg_1:Number):void;
        function get transform():Transform;
        function set filters(_arg_1:Array):void;
        function get x():Number;
        function get y():Number;
        function get filters():Array;
        function set rotation(_arg_1:Number):void;
        function get stage():Stage;

    }
}//package mx.core

