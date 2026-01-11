// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.IGraphic

package com.degrafa
{
    import com.degrafa.core.IGraphicsFill;
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import com.degrafa.core.IGraphicsStroke;
    import flash.display.DisplayObjectContainer;

    public interface IGraphic 
    {

        function get percentWidth():Number;
        function set percentWidth(_arg_1:Number):void;
        function get fill():IGraphicsFill;
        function draw(_arg_1:Graphics, _arg_2:Rectangle):void;
        function get width():Number;
        function get stroke():IGraphicsStroke;
        function removeEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false):void;
        function get name():String;
        function set width(_arg_1:Number):void;
        function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void;
        function set height(_arg_1:Number):void;
        function get fills():Array;
        function get target():DisplayObjectContainer;
        function get percentHeight():Number;
        function get measuredHeight():Number;
        function set fill(_arg_1:IGraphicsFill):void;
        function set name(_arg_1:String):void;
        function set percentHeight(_arg_1:Number):void;
        function set fills(_arg_1:Array):void;
        function set target(_arg_1:DisplayObjectContainer):void;
        function get height():Number;
        function get parent():DisplayObjectContainer;
        function get measuredWidth():Number;
        function set x(_arg_1:Number):void;
        function set y(_arg_1:Number):void;
        function set strokes(_arg_1:Array):void;
        function set stroke(_arg_1:IGraphicsStroke):void;
        function get x():Number;
        function get y():Number;
        function get strokes():Array;
        function endDraw(_arg_1:Graphics):void;

    }
}//package com.degrafa

