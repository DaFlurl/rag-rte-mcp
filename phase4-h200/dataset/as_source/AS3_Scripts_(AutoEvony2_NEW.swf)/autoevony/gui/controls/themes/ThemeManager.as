// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.controls.themes.ThemeManager

package autoevony.gui.controls.themes
{
    import mx.styles.CSSStyleDeclaration;
    import mx.core.Application;
    import mx.styles.StyleManager;
    import mx.core.mx_internal;

    public class ThemeManager 
    {

        public static const DEFAULT_THEME:String = "Default";
        public static var themes:Themes = new Themes();
        public static var unloadGlobal:Boolean = false;
        private static var currentTheme:String = "";
        private static var effectMap:Object = new Object();
        private static var overrideMap:Object = new Object();
        private static var selectors:Array = new Array();


        public static function loadTheme(_arg_1:Object=null, _arg_2:String="Default"):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:CSSStyleDeclaration;
            var _local_6:Array;
            var _local_7:String;
            if (_arg_2 == currentTheme)
            {
                return;
            };
            currentTheme = _arg_2;
            if (_arg_1 == null)
            {
                _arg_1 = themes[(_arg_2.split(" ").join("_") + "_Theme")];
            };
            if (_arg_1 == null)
            {
                _arg_1 = themes.Default_Grey_RE_Theme;
                currentTheme = DEFAULT_THEME;
            };
            for (_local_7 in _arg_1)
            {
                if (_local_7 == "mainApp")
                {
                    for (_local_4 in _arg_1[_local_7])
                    {
                        Application.application.setStyle(_local_4, _arg_1[_local_7][_local_4]);
                    };
                }
                else
                {
                    _local_3 = ((_local_7.charAt(0) == "_") ? ("." + _local_7.substr(1)) : _local_7);
                    _local_5 = StyleManager.getStyleDeclaration(_local_3);
                    if (!_local_5)
                    {
                        _local_5 = new CSSStyleDeclaration();
                        StyleManager.setStyleDeclaration(_local_3, _local_5, false);
                        selectors.push(_local_3);
                    };
                    if ((_local_6 = overrideMap[_local_3]) == null)
                    {
                        _local_6 = new Array();
                        overrideMap[_local_3] = _local_6;
                    };
                    for (_local_4 in _arg_1[_local_7])
                    {
                        var _local_12:* = _local_5;
                        (_local_12.mx_internal::setStyle(_local_4, _arg_1[_local_7][_local_4]));
                        _local_6.push(_local_4);
                    };
                };
            };
            resetStage();
        }

        private static function unloadOverrides():void
        {
            var _local_7:String;
            var _local_1:CSSStyleDeclaration;
            var _local_2:Array;
            var _local_3:uint;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array;
            for (_local_7 in overrideMap)
            {
                if ((_local_1 = StyleManager.getStyleDeclaration(_local_7)) != null)
                {
                    _local_2 = overrideMap[_local_7];
                    if (_local_2 != null)
                    {
                        _local_3 = _local_2.length;
                        _local_4 = 0;
                        while (_local_4 < _local_3)
                        {
                            var _local_10:* = _local_1;
                            (_local_10.mx_internal::clearOverride(_local_2[_local_4]));
                            _local_4++;
                        };
                    };
                    _local_2 = effectMap[_local_7];
                    if (_local_2 != null)
                    {
                        _local_3 = _local_2.length;
                        _local_6 = _local_1.mx_internal::effects;
                        _local_4 = 0;
                        while (_local_4 < _local_3)
                        {
                            if ((_local_5 = _local_6.indexOf(_local_2[_local_4])) != -1)
                            {
                                _local_6.splice(_local_5, 1);
                            };
                            _local_4++;
                        };
                    };
                };
            };
            overrideMap = null;
            effectMap = null;
        }

        public static function getStyle(_arg_1:String, _arg_2:String):*
        {
            return (StyleManager.getStyleDeclaration(_arg_1).getStyle(_arg_2));
        }

        private static function unloadStyleDeclarations():void
        {
            var _local_1:int;
            while (_local_1 < selectors.length)
            {
                StyleManager.clearStyleDeclaration((selectors[_local_1] as String), false);
                _local_1++;
            };
            selectors = null;
        }

        private static function resetStage():void
        {
            Application.application.resetStage();
        }

        public static function unload():void
        {
            unloadOverrides();
            unloadStyleDeclarations();
            if (unloadGlobal)
            {
                StyleManager.mx_internal::stylesRoot = null;
                var _local_1:* = StyleManager;
                (_local_1.mx_internal::initProtoChainRoots());
            };
            resetStage();
        }


    }
}//package autoevony.gui.controls.themes

