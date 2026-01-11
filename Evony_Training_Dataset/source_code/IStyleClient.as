// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.IStyleClient

package mx.styles
{
    public interface IStyleClient extends ISimpleStyleClient 
    {

        function regenerateStyleCache(_arg_1:Boolean):void;
        function get className():String;
        function clearStyle(_arg_1:String):void;
        function getClassStyleDeclarations():Array;
        function get inheritingStyles():Object;
        function set nonInheritingStyles(_arg_1:Object):void;
        function setStyle(_arg_1:String, _arg_2:*):void;
        function get styleDeclaration():CSSStyleDeclaration;
        function set styleDeclaration(_arg_1:CSSStyleDeclaration):void;
        function get nonInheritingStyles():Object;
        function set inheritingStyles(_arg_1:Object):void;
        function getStyle(_arg_1:String):*;
        function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void;
        function registerEffects(_arg_1:Array):void;

    }
}//package mx.styles

