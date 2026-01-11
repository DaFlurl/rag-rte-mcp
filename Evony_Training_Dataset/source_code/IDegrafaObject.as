// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.core.IDegrafaObject

package com.degrafa.core
{
    import flash.events.IEventDispatcher;

    public interface IDegrafaObject extends IEventDispatcher 
    {

        function set suppressEventProcessing(_arg_1:Boolean):void;
        function set parent(_arg_1:IDegrafaObject):void;
        function dispatchPropertyChange(_arg_1:Boolean=false, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null, _arg_5:Object=null):Boolean;
        function set enableEvents(_arg_1:Boolean):void;
        function get parent():IDegrafaObject;
        function get enableEvents():Boolean;
        function get hasEventManager():Boolean;
        function get suppressEventProcessing():Boolean;

    }
}//package com.degrafa.core

