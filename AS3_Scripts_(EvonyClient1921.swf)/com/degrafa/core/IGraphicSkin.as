// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.IGraphicSkin

package com.degrafa.core
{
    import com.degrafa.IGraphic;
    import com.degrafa.core.collections.GeometryCollection;

    public interface IGraphicSkin extends IGraphic 
    {

        function get geometryCollection():GeometryCollection;
        function get geometry():Array;
        function set geometry(_arg_1:Array):void;
        function invalidateDisplayList():void;

    }
}//package com.degrafa.core

