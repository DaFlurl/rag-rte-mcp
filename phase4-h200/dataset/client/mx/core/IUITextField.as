// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.IUITextField

package mx.core
{
    import mx.styles.ISimpleStyleClient;
    import mx.managers.IToolTipManagerClient;
    import flash.display.DisplayObject;
    import flash.text.StyleSheet;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;
    import flash.text.TextLineMetrics;

    public interface IUITextField extends IIMESupport, IFlexModule, IInvalidating, ISimpleStyleClient, IToolTipManagerClient, IUIComponent 
    {

        function replaceText(_arg_1:int, _arg_2:int, _arg_3:String):void;
        function get doubleClickEnabled():Boolean;
        function get nestLevel():int;
        function get caretIndex():int;
        function set doubleClickEnabled(_arg_1:Boolean):void;
        function get maxScrollH():int;
        function set nestLevel(_arg_1:int):void;
        function get numLines():int;
        function get scrollH():int;
        function setColor(_arg_1:uint):void;
        function get maxScrollV():int;
        function getImageReference(_arg_1:String):DisplayObject;
        function get scrollV():int;
        function get border():Boolean;
        function get text():String;
        function get styleSheet():StyleSheet;
        function getCharBoundaries(_arg_1:int):Rectangle;
        function get background():Boolean;
        function set scrollH(_arg_1:int):void;
        function getFirstCharInParagraph(_arg_1:int):int;
        function get type():String;
        function replaceSelectedText(_arg_1:String):void;
        function set borderColor(_arg_1:uint):void;
        function get alwaysShowSelection():Boolean;
        function get sharpness():Number;
        function get tabIndex():int;
        function get textColor():uint;
        function set defaultTextFormat(_arg_1:TextFormat):void;
        function get condenseWhite():Boolean;
        function get displayAsPassword():Boolean;
        function get autoSize():String;
        function setSelection(_arg_1:int, _arg_2:int):void;
        function set scrollV(_arg_1:int):void;
        function set useRichTextClipboard(_arg_1:Boolean):void;
        function get selectionBeginIndex():int;
        function get selectable():Boolean;
        function set border(_arg_1:Boolean):void;
        function set multiline(_arg_1:Boolean):void;
        function set background(_arg_1:Boolean):void;
        function set embedFonts(_arg_1:Boolean):void;
        function set text(_arg_1:String):void;
        function get selectionEndIndex():int;
        function set mouseWheelEnabled(_arg_1:Boolean):void;
        function appendText(_arg_1:String):void;
        function get antiAliasType():String;
        function set styleSheet(_arg_1:StyleSheet):void;
        function set nonInheritingStyles(_arg_1:Object):void;
        function set textColor(_arg_1:uint):void;
        function get wordWrap():Boolean;
        function getLineIndexAtPoint(_arg_1:Number, _arg_2:Number):int;
        function get htmlText():String;
        function set tabIndex(_arg_1:int):void;
        function get thickness():Number;
        function getLineIndexOfChar(_arg_1:int):int;
        function get bottomScrollV():int;
        function set restrict(_arg_1:String):void;
        function set alwaysShowSelection(_arg_1:Boolean):void;
        function getTextFormat(_arg_1:int=-1, _arg_2:int=-1):TextFormat;
        function set sharpness(_arg_1:Number):void;
        function set type(_arg_1:String):void;
        function setTextFormat(_arg_1:TextFormat, _arg_2:int=-1, _arg_3:int=-1):void;
        function set gridFitType(_arg_1:String):void;
        function getUITextFormat():UITextFormat;
        function set inheritingStyles(_arg_1:Object):void;
        function setFocus():void;
        function get borderColor():uint;
        function set condenseWhite(_arg_1:Boolean):void;
        function get textWidth():Number;
        function getLineOffset(_arg_1:int):int;
        function set displayAsPassword(_arg_1:Boolean):void;
        function set autoSize(_arg_1:String):void;
        function get defaultTextFormat():TextFormat;
        function get useRichTextClipboard():Boolean;
        function get nonZeroTextHeight():Number;
        function set backgroundColor(_arg_1:uint):void;
        function get embedFonts():Boolean;
        function set selectable(_arg_1:Boolean):void;
        function get multiline():Boolean;
        function set maxChars(_arg_1:int):void;
        function get textHeight():Number;
        function get nonInheritingStyles():Object;
        function getLineText(_arg_1:int):String;
        function set focusRect(_arg_1:Object):void;
        function get mouseWheelEnabled():Boolean;
        function get restrict():String;
        function getParagraphLength(_arg_1:int):int;
        function set mouseEnabled(_arg_1:Boolean):void;
        function get gridFitType():String;
        function get inheritingStyles():Object;
        function set ignorePadding(_arg_1:Boolean):void;
        function set antiAliasType(_arg_1:String):void;
        function get backgroundColor():uint;
        function getCharIndexAtPoint(_arg_1:Number, _arg_2:Number):int;
        function set tabEnabled(_arg_1:Boolean):void;
        function get maxChars():int;
        function get focusRect():Object;
        function get ignorePadding():Boolean;
        function get mouseEnabled():Boolean;
        function get length():int;
        function set wordWrap(_arg_1:Boolean):void;
        function get tabEnabled():Boolean;
        function set thickness(_arg_1:Number):void;
        function getLineLength(_arg_1:int):int;
        function truncateToFit(_arg_1:String=null):Boolean;
        function set htmlText(_arg_1:String):void;
        function getLineMetrics(_arg_1:int):TextLineMetrics;
        function getStyle(_arg_1:String):*;

    }
}//package mx.core

