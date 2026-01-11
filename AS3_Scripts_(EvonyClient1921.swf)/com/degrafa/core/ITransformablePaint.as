// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.ITransformablePaint

package com.degrafa.core
{
    import com.degrafa.transform.ITransform;

    public interface ITransformablePaint extends IDegrafaObject, IGraphicsFill 
    {

        function set transform(_arg_1:ITransform):void;
        function get transform():ITransform;

    }
}//package com.degrafa.core

