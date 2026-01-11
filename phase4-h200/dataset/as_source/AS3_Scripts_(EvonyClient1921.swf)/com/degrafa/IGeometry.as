// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.IGeometry

package com.degrafa
{
    import com.degrafa.core.IGraphicsStroke;
    import com.degrafa.core.IGraphicsFill;
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public interface IGeometry 
    {

        function set stroke(_arg_1:IGraphicsStroke):void;
        function get fill():IGraphicsFill;
        function draw(_arg_1:Graphics, _arg_2:Rectangle):void;
        function set fill(_arg_1:IGraphicsFill):void;
        function get stroke():IGraphicsStroke;
        function get data():String;
        function set data(_arg_1:String):void;
        function endDraw(_arg_1:Graphics):void;

    }
}//package com.degrafa

