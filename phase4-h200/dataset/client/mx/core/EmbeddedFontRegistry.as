// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.core.EmbeddedFontRegistry

package mx.core
{
    import flash.text.FontStyle;
    import flash.utils.Dictionary;

    use namespace mx_internal;

    public class EmbeddedFontRegistry implements IEmbeddedFontRegistry 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var fonts:Object = {};
        private static var instance:IEmbeddedFontRegistry;


        public static function registerFonts(_arg_1:Object, _arg_2:IFlexModuleFactory):void
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:String;
            var _local_7:Boolean;
            var _local_8:Boolean;
            var _local_3:IEmbeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            for (_local_4 in _arg_1)
            {
                _local_5 = _arg_1[_local_4];
                for (_local_6 in _local_5)
                {
                    if (_local_5[_local_6] != false)
                    {
                        if (_local_6 == "regular")
                        {
                            _local_7 = false;
                            _local_8 = false;
                        }
                        else
                        {
                            if (_local_6 == "boldItalic")
                            {
                                _local_7 = true;
                                _local_8 = true;
                            }
                            else
                            {
                                if (_local_6 == "bold")
                                {
                                    _local_7 = true;
                                    _local_8 = false;
                                }
                                else
                                {
                                    if (_local_6 == "italic")
                                    {
                                        _local_7 = false;
                                        _local_8 = true;
                                    };
                                };
                            };
                        };
                        _local_3.registerFont(new EmbeddedFont(String(_local_4), _local_7, _local_8), _arg_2);
                    };
                };
            };
        }

        public static function getInstance():IEmbeddedFontRegistry
        {
            if (!instance)
            {
                instance = new (EmbeddedFontRegistry)();
            };
            return (instance);
        }

        public static function getFontStyle(_arg_1:Boolean, _arg_2:Boolean):String
        {
            var _local_3:String = FontStyle.REGULAR;
            if (((_arg_1) && (_arg_2)))
            {
                _local_3 = FontStyle.BOLD_ITALIC;
            }
            else
            {
                if (_arg_1)
                {
                    _local_3 = FontStyle.BOLD;
                }
                else
                {
                    if (_arg_2)
                    {
                        _local_3 = FontStyle.ITALIC;
                    };
                };
            };
            return (_local_3);
        }

        private static function createFontKey(_arg_1:EmbeddedFont):String
        {
            return (_arg_1.fontName + _arg_1.fontStyle);
        }

        private static function createEmbeddedFont(_arg_1:String):EmbeddedFont
        {
            var _local_2:String;
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:int = endsWith(_arg_1, FontStyle.REGULAR);
            if (_local_5 > 0)
            {
                _local_2 = _arg_1.substring(0, _local_5);
                return (new EmbeddedFont(_local_2, false, false));
            };
            _local_5 = endsWith(_arg_1, FontStyle.BOLD);
            if (_local_5 > 0)
            {
                _local_2 = _arg_1.substring(0, _local_5);
                return (new EmbeddedFont(_local_2, true, false));
            };
            _local_5 = endsWith(_arg_1, FontStyle.BOLD_ITALIC);
            if (_local_5 > 0)
            {
                _local_2 = _arg_1.substring(0, _local_5);
                return (new EmbeddedFont(_local_2, true, true));
            };
            _local_5 = endsWith(_arg_1, FontStyle.ITALIC);
            if (_local_5 > 0)
            {
                _local_2 = _arg_1.substring(0, _local_5);
                return (new EmbeddedFont(_local_2, false, true));
            };
            return (new EmbeddedFont("", false, false));
        }

        private static function endsWith(_arg_1:String, _arg_2:String):int
        {
            var _local_3:int = _arg_1.lastIndexOf(_arg_2);
            if (((_local_3 > 0) && ((_local_3 + _arg_2.length) == _arg_1.length)))
            {
                return (_local_3);
            };
            return (-1);
        }


        public function getAssociatedModuleFactory(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):IFlexModuleFactory
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_3:Dictionary = fonts[createFontKey(_arg_1)];
            if (_local_3)
            {
                _local_4 = _local_3[_arg_2];
                if (_local_4)
                {
                    return (_arg_2);
                };
                for (_local_5 in _local_3)
                {
                    return (_local_5 as IFlexModuleFactory);
                };
            };
            return (null);
        }

        public function deregisterFont(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):void
        {
            var _local_5:int;
            var _local_6:Object;
            var _local_3:String = createFontKey(_arg_1);
            var _local_4:Dictionary = fonts[_local_3];
            if (_local_4 != null)
            {
                delete _local_4[_arg_2];
                _local_5 = 0;
                for (_local_6 in _local_4)
                {
                    _local_5++;
                };
                if (_local_5 == 0)
                {
                    delete fonts[_local_3];
                };
            };
        }

        public function getFonts():Array
        {
            var _local_2:String;
            var _local_1:Array = [];
            for (_local_2 in fonts)
            {
                _local_1.push(createEmbeddedFont(_local_2));
            };
            return (_local_1);
        }

        public function registerFont(_arg_1:EmbeddedFont, _arg_2:IFlexModuleFactory):void
        {
            var _local_3:String = createFontKey(_arg_1);
            var _local_4:Dictionary = fonts[_local_3];
            if (!_local_4)
            {
                _local_4 = new Dictionary(true);
                fonts[_local_3] = _local_4;
            };
            _local_4[_arg_2] = 1;
        }


    }
}//package mx.core

