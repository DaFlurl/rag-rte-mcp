// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.decorators.IRenderDecorator

package com.degrafa.decorators
{
    import flash.display.Graphics;

    public interface IRenderDecorator extends IDecorator 
    {

        function curveTo(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Graphics):void;
        function moveTo(_arg_1:Number, _arg_2:Number, _arg_3:Graphics):void;
        function lineTo(_arg_1:Number, _arg_2:Number, _arg_3:Graphics):void;

    }
}//package com.degrafa.decorators

