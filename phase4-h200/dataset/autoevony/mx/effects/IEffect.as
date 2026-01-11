// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.effects.IEffect

package mx.effects
{
    import flash.events.Event;

    public interface IEffect extends IAbstractEffect 
    {

        function captureMoreStartValues(_arg_1:Array):void;
        function get triggerEvent():Event;
        function set targets(_arg_1:Array):void;
        function captureStartValues():void;
        function get hideFocusRing():Boolean;
        function get customFilter():EffectTargetFilter;
        function get effectTargetHost():IEffectTargetHost;
        function set triggerEvent(_arg_1:Event):void;
        function set hideFocusRing(_arg_1:Boolean):void;
        function captureEndValues():void;
        function get target():Object;
        function set customFilter(_arg_1:EffectTargetFilter):void;
        function get duration():Number;
        function get perElementOffset():Number;
        function get targets():Array;
        function set effectTargetHost(_arg_1:IEffectTargetHost):void;
        function get relevantStyles():Array;
        function set relevantProperties(_arg_1:Array):void;
        function set target(_arg_1:Object):void;
        function get className():String;
        function get isPlaying():Boolean;
        function deleteInstance(_arg_1:IEffectInstance):void;
        function set duration(_arg_1:Number):void;
        function createInstances(_arg_1:Array=null):Array;
        function end(_arg_1:IEffectInstance=null):void;
        function set perElementOffset(_arg_1:Number):void;
        function resume():void;
        function stop():void;
        function set filter(_arg_1:String):void;
        function createInstance(_arg_1:Object=null):IEffectInstance;
        function play(_arg_1:Array=null, _arg_2:Boolean=false):Array;
        function pause():void;
        function get relevantProperties():Array;
        function get filter():String;
        function reverse():void;
        function getAffectedProperties():Array;
        function set relevantStyles(_arg_1:Array):void;

    }
}//package mx.effects

