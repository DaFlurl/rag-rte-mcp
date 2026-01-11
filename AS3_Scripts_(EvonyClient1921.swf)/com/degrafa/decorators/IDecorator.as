// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.decorators.IDecorator

package com.degrafa.decorators
{
    import com.degrafa.geometry.command.CommandStack;

    public interface IDecorator 
    {

        function initialize(_arg_1:CommandStack):void;
        function end(_arg_1:CommandStack):void;

    }
}//package com.degrafa.decorators

