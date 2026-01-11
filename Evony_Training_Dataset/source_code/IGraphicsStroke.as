// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.IGraphicsStroke

package com.degrafa.core
{
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public interface IGraphicsStroke extends IDegrafaObject 
    {

        function get caps():String;
        function set caps(_arg_1:String):void;
        function get joints():String;
        function set pixelHinting(_arg_1:Boolean):void;
        function get lastArgs():Array;
        function set miterLimit(_arg_1:Number):void;
        function get scaleMode():String;
        function apply(_arg_1:Graphics, _arg_2:Rectangle):void;
        function set weight(_arg_1:Number):void;
        function set joints(_arg_1:String):void;
        function get reApplyFunction():Function;
        function get pixelHinting():Boolean;
        function get miterLimit():Number;
        function get weight():Number;
        function get lastRectangle():Rectangle;
        function set scaleMode(_arg_1:String):void;

    }
}//package com.degrafa.core

