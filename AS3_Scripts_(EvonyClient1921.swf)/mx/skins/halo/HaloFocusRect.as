// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.skins.halo.HaloFocusRect

package mx.skins.halo
{
    import mx.skins.ProgrammaticSkin;
    import mx.styles.IStyleClient;
    import mx.styles.CSSStyleDeclaration;
    import flash.display.Graphics;
    import mx.utils.GraphicsUtil;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class HaloFocusRect extends ProgrammaticSkin implements IStyleClient 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _focusColor:Number;


        public function get inheritingStyles():Object
        {
            return (styleName.inheritingStyles);
        }

        public function set inheritingStyles(_arg_1:Object):void
        {
        }

        public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
        }

        public function registerEffects(_arg_1:Array):void
        {
        }

        public function regenerateStyleCache(_arg_1:Boolean):void
        {
        }

        public function get styleDeclaration():CSSStyleDeclaration
        {
            return (CSSStyleDeclaration(styleName));
        }

        public function getClassStyleDeclarations():Array
        {
            return ([]);
        }

        public function get className():String
        {
            return ("HaloFocusRect");
        }

        public function clearStyle(_arg_1:String):void
        {
            if (_arg_1 == "focusColor")
            {
                _focusColor = NaN;
            };
        }

        public function setStyle(_arg_1:String, _arg_2:*):void
        {
            if (_arg_1 == "focusColor")
            {
                _focusColor = _arg_2;
            };
        }

        public function set nonInheritingStyles(_arg_1:Object):void
        {
        }

        public function get nonInheritingStyles():Object
        {
            return (styleName.nonInheritingStyles);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Number;
            var _local_15:Number;
            var _local_16:Number;
            var _local_17:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:String = getStyle("focusBlendMode");
            var _local_4:Number = getStyle("focusAlpha");
            var _local_5:Number = getStyle("focusColor");
            var _local_6:Number = getStyle("cornerRadius");
            var _local_7:Number = getStyle("focusThickness");
            var _local_8:String = getStyle("focusRoundedCorners");
            var _local_9:Number = getStyle("themeColor");
            var _local_10:Number = _local_5;
            if (isNaN(_local_10))
            {
                _local_10 = _local_9;
            };
            var _local_11:Graphics = graphics;
            _local_11.clear();
            if (_local_3)
            {
                blendMode = _local_3;
            };
            if (((!(_local_8 == "tl tr bl br")) && (_local_6 > 0)))
            {
                _local_12 = 0;
                _local_13 = 0;
                _local_14 = 0;
                _local_15 = 0;
                _local_16 = (_local_6 + _local_7);
                if (_local_8.indexOf("tl") >= 0)
                {
                    _local_12 = _local_16;
                };
                if (_local_8.indexOf("tr") >= 0)
                {
                    _local_14 = _local_16;
                };
                if (_local_8.indexOf("bl") >= 0)
                {
                    _local_13 = _local_16;
                };
                if (_local_8.indexOf("br") >= 0)
                {
                    _local_15 = _local_16;
                };
                _local_11.beginFill(_local_10, _local_4);
                GraphicsUtil.drawRoundRectComplex(_local_11, 0, 0, _arg_1, _arg_2, _local_12, _local_14, _local_13, _local_15);
                _local_12 = ((_local_12) ? _local_6 : 0);
                _local_14 = ((_local_14) ? _local_6 : 0);
                _local_13 = ((_local_13) ? _local_6 : 0);
                _local_15 = ((_local_15) ? _local_6 : 0);
                GraphicsUtil.drawRoundRectComplex(_local_11, _local_7, _local_7, (_arg_1 - (2 * _local_7)), (_arg_2 - (2 * _local_7)), _local_12, _local_14, _local_13, _local_15);
                _local_11.endFill();
                _local_16 = (_local_6 + (_local_7 / 2));
                _local_12 = ((_local_12) ? _local_16 : 0);
                _local_14 = ((_local_14) ? _local_16 : 0);
                _local_13 = ((_local_13) ? _local_16 : 0);
                _local_15 = ((_local_15) ? _local_16 : 0);
                _local_11.beginFill(_local_10, _local_4);
                GraphicsUtil.drawRoundRectComplex(_local_11, (_local_7 / 2), (_local_7 / 2), (_arg_1 - _local_7), (_arg_2 - _local_7), _local_12, _local_14, _local_13, _local_15);
                _local_12 = ((_local_12) ? _local_6 : 0);
                _local_14 = ((_local_14) ? _local_6 : 0);
                _local_13 = ((_local_13) ? _local_6 : 0);
                _local_15 = ((_local_15) ? _local_6 : 0);
                GraphicsUtil.drawRoundRectComplex(_local_11, _local_7, _local_7, (_arg_1 - (2 * _local_7)), (_arg_2 - (2 * _local_7)), _local_12, _local_14, _local_13, _local_15);
                _local_11.endFill();
            }
            else
            {
                _local_11.beginFill(_local_10, _local_4);
                _local_17 = (((_local_6 > 0) ? (_local_6 + _local_7) : 0) * 2);
                _local_11.drawRoundRect(0, 0, _arg_1, _arg_2, _local_17, _local_17);
                _local_17 = (_local_6 * 2);
                _local_11.drawRoundRect(_local_7, _local_7, (_arg_1 - (2 * _local_7)), (_arg_2 - (2 * _local_7)), _local_17, _local_17);
                _local_11.endFill();
                _local_11.beginFill(_local_10, _local_4);
                _local_17 = (((_local_6 > 0) ? (_local_6 + (_local_7 / 2)) : 0) * 2);
                _local_11.drawRoundRect((_local_7 / 2), (_local_7 / 2), (_arg_1 - _local_7), (_arg_2 - _local_7), _local_17, _local_17);
                _local_17 = (_local_6 * 2);
                _local_11.drawRoundRect(_local_7, _local_7, (_arg_1 - (2 * _local_7)), (_arg_2 - (2 * _local_7)), _local_17, _local_17);
                _local_11.endFill();
            };
        }

        override public function getStyle(_arg_1:String):*
        {
            return ((_arg_1 == "focusColor") ? _focusColor : super.getStyle(_arg_1));
        }

        public function set styleDeclaration(_arg_1:CSSStyleDeclaration):void
        {
        }


    }
}//package mx.skins.halo

