// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.preloaders.IPreloaderDisplay

package mx.preloaders
{
    import flash.events.IEventDispatcher;
    import flash.display.Sprite;

    public interface IPreloaderDisplay extends IEventDispatcher 
    {

        function set backgroundAlpha(_arg_1:Number):void;
        function get stageHeight():Number;
        function get stageWidth():Number;
        function set backgroundColor(_arg_1:uint):void;
        function set preloader(_arg_1:Sprite):void;
        function get backgroundImage():Object;
        function get backgroundSize():String;
        function get backgroundAlpha():Number;
        function set stageHeight(_arg_1:Number):void;
        function get backgroundColor():uint;
        function set stageWidth(_arg_1:Number):void;
        function set backgroundImage(_arg_1:Object):void;
        function set backgroundSize(_arg_1:String):void;
        function initialize():void;

    }
}//package mx.preloaders

