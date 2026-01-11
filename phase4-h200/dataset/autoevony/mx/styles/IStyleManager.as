// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.IStyleManager

package mx.styles
{
    import flash.events.IEventDispatcher;

    public interface IStyleManager 
    {

        function isColorName(_arg_1:String):Boolean;
        function registerParentDisplayListInvalidatingStyle(_arg_1:String):void;
        function registerInheritingStyle(_arg_1:String):void;
        function set stylesRoot(_arg_1:Object):void;
        function get typeSelectorCache():Object;
        function styleDeclarationsChanged():void;
        function setStyleDeclaration(_arg_1:String, _arg_2:CSSStyleDeclaration, _arg_3:Boolean):void;
        function isParentDisplayListInvalidatingStyle(_arg_1:String):Boolean;
        function isSizeInvalidatingStyle(_arg_1:String):Boolean;
        function get inheritingStyles():Object;
        function isValidStyleValue(_arg_1:*):Boolean;
        function isParentSizeInvalidatingStyle(_arg_1:String):Boolean;
        function getColorName(_arg_1:Object):uint;
        function set typeSelectorCache(_arg_1:Object):void;
        function unloadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true):void;
        function getColorNames(_arg_1:Array):void;
        function loadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false):IEventDispatcher;
        function isInheritingStyle(_arg_1:String):Boolean;
        function set inheritingStyles(_arg_1:Object):void;
        function get stylesRoot():Object;
        function initProtoChainRoots():void;
        function registerColorName(_arg_1:String, _arg_2:uint):void;
        function registerParentSizeInvalidatingStyle(_arg_1:String):void;
        function registerSizeInvalidatingStyle(_arg_1:String):void;
        function clearStyleDeclaration(_arg_1:String, _arg_2:Boolean):void;
        function isInheritingTextFormatStyle(_arg_1:String):Boolean;
        function getStyleDeclaration(_arg_1:String):CSSStyleDeclaration;

    }
}//package mx.styles

