// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.IGraphicsFill

package com.degrafa.core
{
    import mx.graphics.IFill;
    import com.degrafa.IGeometryComposition;
    import flash.geom.Rectangle;

    public interface IGraphicsFill extends IDegrafaObject, IFill 
    {

        function set requester(_arg_1:IGeometryComposition):void;
        function get lastRectangle():Rectangle;
        function get lastArgs():Array;
        function get restartFunction():Function;

    }
}//package com.degrafa.core

