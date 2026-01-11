// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.StyleProtoChain

package mx.styles
{
    import flash.display.DisplayObject;
    import mx.core.UIComponent;
    import mx.core.IUITextField;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StyleProtoChain 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";


        public static function initProtoChainForUIComponentStyleName(_arg_1:IStyleClient):void
        {
            var _local_9:CSSStyleDeclaration;
            var _local_2:IStyleClient = IStyleClient(_arg_1.styleName);
            var _local_3:DisplayObject = (_arg_1 as DisplayObject);
            var _local_4:Object = _local_2.nonInheritingStyles;
            if (((!(_local_4)) || (_local_4 == UIComponent.STYLE_UNINITIALIZED)))
            {
                _local_4 = StyleManager.stylesRoot;
                if (_local_4.effects)
                {
                    _arg_1.registerEffects(_local_4.effects);
                };
            };
            var _local_5:Object = _local_2.inheritingStyles;
            if (((!(_local_5)) || (_local_5 == UIComponent.STYLE_UNINITIALIZED)))
            {
                _local_5 = StyleManager.stylesRoot;
            };
            var _local_6:Array = _arg_1.getClassStyleDeclarations();
            var _local_7:int = _local_6.length;
            if ((_local_2 is StyleProxy))
            {
                if (_local_7 == 0)
                {
                    _local_4 = addProperties(_local_4, _local_2, false);
                };
                _local_3 = (StyleProxy(_local_2).source as DisplayObject);
            };
            var _local_8:int;
            while (_local_8 < _local_7)
            {
                _local_9 = _local_6[_local_8];
                _local_5 = _local_9.addStyleToProtoChain(_local_5, _local_3);
                _local_5 = addProperties(_local_5, _local_2, true);
                _local_4 = _local_9.addStyleToProtoChain(_local_4, _local_3);
                _local_4 = addProperties(_local_4, _local_2, false);
                if (_local_9.effects)
                {
                    _arg_1.registerEffects(_local_9.effects);
                };
                _local_8++;
            };
            _arg_1.inheritingStyles = ((_arg_1.styleDeclaration) ? _arg_1.styleDeclaration.addStyleToProtoChain(_local_5, _local_3) : _local_5);
            _arg_1.nonInheritingStyles = ((_arg_1.styleDeclaration) ? _arg_1.styleDeclaration.addStyleToProtoChain(_local_4, _local_3) : _local_4);
        }

        private static function addProperties(_arg_1:Object, _arg_2:IStyleClient, _arg_3:Boolean):Object
        {
            var _local_11:CSSStyleDeclaration;
            var _local_12:CSSStyleDeclaration;
            var _local_4:Object = (((_arg_2 is StyleProxy) && (!(_arg_3))) ? StyleProxy(_arg_2).filterMap : null);
            var _local_5:IStyleClient = _arg_2;
            while ((_local_5 is StyleProxy))
            {
                _local_5 = StyleProxy(_local_5).source;
            };
            var _local_6:DisplayObject = (_local_5 as DisplayObject);
            var _local_7:Array = _arg_2.getClassStyleDeclarations();
            var _local_8:int = _local_7.length;
            var _local_9:int;
            while (_local_9 < _local_8)
            {
                _local_11 = _local_7[_local_9];
                _arg_1 = _local_11.addStyleToProtoChain(_arg_1, _local_6, _local_4);
                if (_local_11.effects)
                {
                    _arg_2.registerEffects(_local_11.effects);
                };
                _local_9++;
            };
            var _local_10:Object = _arg_2.styleName;
            if (_local_10)
            {
                if (typeof(_local_10) == "object")
                {
                    if ((_local_10 is CSSStyleDeclaration))
                    {
                        _local_12 = CSSStyleDeclaration(_local_10);
                    }
                    else
                    {
                        _arg_1 = addProperties(_arg_1, IStyleClient(_local_10), _arg_3);
                    };
                }
                else
                {
                    _local_12 = StyleManager.getStyleDeclaration(("." + _local_10));
                };
                if (_local_12)
                {
                    _arg_1 = _local_12.addStyleToProtoChain(_arg_1, _local_6, _local_4);
                    if (_local_12.effects)
                    {
                        _arg_2.registerEffects(_local_12.effects);
                    };
                };
            };
            if (_arg_2.styleDeclaration)
            {
                _arg_1 = _arg_2.styleDeclaration.addStyleToProtoChain(_arg_1, _local_6, _local_4);
            };
            return (_arg_1);
        }

        public static function initTextField(_arg_1:IUITextField):void
        {
            var _local_3:CSSStyleDeclaration;
            var _local_2:Object = _arg_1.styleName;
            if (_local_2)
            {
                if (typeof(_local_2) == "object")
                {
                    if ((_local_2 is CSSStyleDeclaration))
                    {
                        _local_3 = CSSStyleDeclaration(_local_2);
                    }
                    else
                    {
                        if ((_local_2 is StyleProxy))
                        {
                            _arg_1.inheritingStyles = IStyleClient(_local_2).inheritingStyles;
                            _arg_1.nonInheritingStyles = addProperties(StyleManager.stylesRoot, IStyleClient(_local_2), false);
                            return;
                        };
                        _arg_1.inheritingStyles = IStyleClient(_local_2).inheritingStyles;
                        _arg_1.nonInheritingStyles = IStyleClient(_local_2).nonInheritingStyles;
                        return;
                    };
                }
                else
                {
                    _local_3 = StyleManager.getStyleDeclaration(("." + _local_2));
                };
            };
            var _local_4:Object = IStyleClient(_arg_1.parent).inheritingStyles;
            var _local_5:Object = StyleManager.stylesRoot;
            if (!_local_4)
            {
                _local_4 = StyleManager.stylesRoot;
            };
            if (_local_3)
            {
                _local_4 = _local_3.addStyleToProtoChain(_local_4, DisplayObject(_arg_1));
                _local_5 = _local_3.addStyleToProtoChain(_local_5, DisplayObject(_arg_1));
            };
            _arg_1.inheritingStyles = _local_4;
            _arg_1.nonInheritingStyles = _local_5;
        }


    }
}//package mx.styles

