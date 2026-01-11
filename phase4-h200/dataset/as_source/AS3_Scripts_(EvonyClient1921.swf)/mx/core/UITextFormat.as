// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.UITextFormat

package mx.core
{
    import flash.text.TextFormat;
    import mx.managers.ISystemManager;
    import flash.text.TextLineMetrics;
    import flash.text.TextField;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class UITextFormat extends TextFormat 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;
        private static var _textFieldFactory:ITextFieldFactory;

        private var systemManager:ISystemManager;
        public var sharpness:Number;
        public var gridFitType:String;
        public var antiAliasType:String;
        public var thickness:Number;
        private var cachedEmbeddedFont:EmbeddedFont = null;
        private var _moduleFactory:IFlexModuleFactory;

        public function UITextFormat(_arg_1:ISystemManager, _arg_2:String=null, _arg_3:Object=null, _arg_4:Object=null, _arg_5:Object=null, _arg_6:Object=null, _arg_7:Object=null, _arg_8:String=null, _arg_9:String=null, _arg_10:String=null, _arg_11:Object=null, _arg_12:Object=null, _arg_13:Object=null, _arg_14:Object=null)
        {
            this.systemManager = _arg_1;
            super(_arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8, _arg_9, _arg_10, _arg_11, _arg_12, _arg_13, _arg_14);
        }

        private static function get embeddedFontRegistry():IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            };
            return (_embeddedFontRegistry);
        }

        private static function get textFieldFactory():ITextFieldFactory
        {
            if (!_textFieldFactory)
            {
                _textFieldFactory = ITextFieldFactory(Singleton.getInstance("mx.core::ITextFieldFactory"));
            };
            return (_textFieldFactory);
        }


        public function set moduleFactory(_arg_1:IFlexModuleFactory):void
        {
            _moduleFactory = _arg_1;
        }

        mx_internal function copyFrom(_arg_1:TextFormat):void
        {
            font = _arg_1.font;
            size = _arg_1.size;
            color = _arg_1.color;
            bold = _arg_1.bold;
            italic = _arg_1.italic;
            underline = _arg_1.underline;
            url = _arg_1.url;
            target = _arg_1.target;
            align = _arg_1.align;
            leftMargin = _arg_1.leftMargin;
            rightMargin = _arg_1.rightMargin;
            indent = _arg_1.indent;
            leading = _arg_1.leading;
            letterSpacing = _arg_1.letterSpacing;
            blockIndent = _arg_1.blockIndent;
            bullet = _arg_1.bullet;
            display = _arg_1.display;
            indent = _arg_1.indent;
            kerning = _arg_1.kerning;
            tabStops = _arg_1.tabStops;
        }

        private function getEmbeddedFont(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):EmbeddedFont
        {
            if (cachedEmbeddedFont)
            {
                if (((cachedEmbeddedFont.fontName == _arg_1) && (cachedEmbeddedFont.fontStyle == EmbeddedFontRegistry.getFontStyle(_arg_2, _arg_3))))
                {
                    return (cachedEmbeddedFont);
                };
            };
            cachedEmbeddedFont = new EmbeddedFont(_arg_1, _arg_2, _arg_3);
            return (cachedEmbeddedFont);
        }

        public function measureText(_arg_1:String, _arg_2:Boolean=true):TextLineMetrics
        {
            return (measure(_arg_1, false, _arg_2));
        }

        private function measure(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):TextLineMetrics
        {
            if (!_arg_1)
            {
                _arg_1 = "";
            };
            var _local_4:Boolean;
            var _local_5:IFlexModuleFactory = embeddedFontRegistry.getAssociatedModuleFactory(getEmbeddedFont(font, bold, italic), moduleFactory);
            _local_4 = (!(_local_5 == null));
            if (_local_5 == null)
            {
                _local_5 = systemManager;
            };
            var _local_6:TextField;
            _local_6 = TextField(textFieldFactory.createTextField(_local_5));
            if (_arg_2)
            {
                _local_6.htmlText = "";
            }
            else
            {
                _local_6.text = "";
            };
            _local_6.defaultTextFormat = this;
            if (font)
            {
                _local_6.embedFonts = ((_local_4) || ((!(systemManager == null)) && (systemManager.isFontFaceEmbedded(this))));
            }
            else
            {
                _local_6.embedFonts = false;
            };
            _local_6.antiAliasType = antiAliasType;
            _local_6.gridFitType = gridFitType;
            _local_6.sharpness = sharpness;
            _local_6.thickness = thickness;
            if (_arg_2)
            {
                _local_6.htmlText = _arg_1;
            }
            else
            {
                _local_6.text = _arg_1;
            };
            var _local_7:TextLineMetrics = _local_6.getLineMetrics(0);
            if (indent != null)
            {
                _local_7.width = (_local_7.width + indent);
            };
            if (_arg_3)
            {
                _local_7.width = Math.ceil(_local_7.width);
                _local_7.height = Math.ceil(_local_7.height);
            };
            return (_local_7);
        }

        public function measureHTMLText(_arg_1:String, _arg_2:Boolean=true):TextLineMetrics
        {
            return (measure(_arg_1, true, _arg_2));
        }

        public function get moduleFactory():IFlexModuleFactory
        {
            return (_moduleFactory);
        }


    }
}//package mx.core

