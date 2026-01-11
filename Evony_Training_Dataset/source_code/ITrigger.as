// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.degrafa.triggers.ITrigger

package com.degrafa.triggers
{
    import com.degrafa.states.IDegrafaStateClient;
    import flash.events.IEventDispatcher;

    public interface ITrigger 
    {

        function get triggerParent():IDegrafaStateClient;
        function set triggerParent(_arg_1:IDegrafaStateClient):void;
        function set source(_arg_1:IEventDispatcher):void;
        function get source():IEventDispatcher;
        function get id():String;
        function set id(_arg_1:String):void;

    }
}//package com.degrafa.triggers

