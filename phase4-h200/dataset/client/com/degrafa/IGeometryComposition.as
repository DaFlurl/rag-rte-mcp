// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.IGeometryComposition

package com.degrafa
{
    import flash.display.Graphics;
    import flash.geom.Rectangle;
    import com.degrafa.geometry.command.CommandStack;

    public interface IGeometryComposition 
    {

        function draw(_arg_1:Graphics, _arg_2:Rectangle):void;
        function get bounds():Rectangle;
        function preDraw():void;
        function set commandStack(_arg_1:CommandStack):void;
        function get commandStack():CommandStack;
        function endDraw(_arg_1:Graphics):void;

    }
}//package com.degrafa

