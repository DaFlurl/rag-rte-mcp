// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.IEffectInstance

package mx.effects
{
    import flash.events.Event;
    import mx.effects.effectClasses.PropertyChanges;

    public interface IEffectInstance 
    {

        function get playheadTime():Number;
        function get triggerEvent():Event;
        function set triggerEvent(_arg_1:Event):void;
        function get hideFocusRing():Boolean;
        function initEffect(_arg_1:Event):void;
        function set startDelay(_arg_1:int):void;
        function get effectTargetHost():IEffectTargetHost;
        function finishEffect():void;
        function set hideFocusRing(_arg_1:Boolean):void;
        function finishRepeat():void;
        function set repeatDelay(_arg_1:int):void;
        function get effect():IEffect;
        function startEffect():void;
        function get duration():Number;
        function get target():Object;
        function get startDelay():int;
        function stop():void;
        function set effectTargetHost(_arg_1:IEffectTargetHost):void;
        function set propertyChanges(_arg_1:PropertyChanges):void;
        function set effect(_arg_1:IEffect):void;
        function get className():String;
        function set duration(_arg_1:Number):void;
        function set target(_arg_1:Object):void;
        function end():void;
        function resume():void;
        function get propertyChanges():PropertyChanges;
        function set repeatCount(_arg_1:int):void;
        function reverse():void;
        function get repeatCount():int;
        function pause():void;
        function get repeatDelay():int;
        function set suspendBackgroundProcessing(_arg_1:Boolean):void;
        function play():void;
        function get suspendBackgroundProcessing():Boolean;

    }
}//package mx.effects

