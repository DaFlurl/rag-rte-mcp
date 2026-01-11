// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.geometry.layout.ILayout

package com.degrafa.geometry.layout
{
    import com.degrafa.core.IDegrafaObject;
    import flash.geom.Rectangle;

    public interface ILayout extends IDegrafaObject 
    {

        function get layoutRectangle():Rectangle;
        function computeLayoutRectangle(_arg_1:Rectangle, _arg_2:Rectangle):Rectangle;

    }
}//package com.degrafa.geometry.layout

