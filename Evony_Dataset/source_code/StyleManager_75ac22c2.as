// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.StyleManager

package mx.styles
{
    import mx.core.mx_internal;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.events.IEventDispatcher;
    import mx.core.Singleton;

    use namespace mx_internal;

    public class StyleManager 
    {

        mx_internal static const VERSION:String = "3.6.0.21751";
        public static const NOT_A_COLOR:uint = 0xFFFFFFFF;
        private static var implClassDependency:StyleManagerImpl;
        private static var _impl:IStyleManager2;


        public static function isParentSizeInvalidatingStyle(_arg_1:String):Boolean
        {
            return (impl.isParentSizeInvalidatingStyle(_arg_1));
        }

        public static function registerInheritingStyle(_arg_1:String):void
        {
            impl.registerInheritingStyle(_arg_1);
        }

        mx_internal static function set stylesRoot(_arg_1:Object):void
        {
            impl.stylesRoot = _arg_1;
        }

        mx_internal static function get inheritingStyles():Object
        {
            return (impl.inheritingStyles);
        }

        mx_internal static function styleDeclarationsChanged():void
        {
            impl.styleDeclarationsChanged();
        }

        public static function setStyleDeclaration(_arg_1:String, _arg_2:CSSStyleDeclaration, _arg_3:Boolean):void
        {
            impl.setStyleDeclaration(_arg_1, _arg_2, _arg_3);
        }

        public static function registerParentDisplayListInvalidatingStyle(_arg_1:String):void
        {
            impl.registerParentDisplayListInvalidatingStyle(_arg_1);
        }

        mx_internal static function get typeSelectorCache():Object
        {
            return (impl.typeSelectorCache);
        }

        mx_internal static function set inheritingStyles(_arg_1:Object):void
        {
            impl.inheritingStyles = _arg_1;
        }

        public static function isColorName(_arg_1:String):Boolean
        {
            return (impl.isColorName(_arg_1));
        }

        public static function isParentDisplayListInvalidatingStyle(_arg_1:String):Boolean
        {
            return (impl.isParentDisplayListInvalidatingStyle(_arg_1));
        }

        public static function isSizeInvalidatingStyle(_arg_1:String):Boolean
        {
            return (impl.isSizeInvalidatingStyle(_arg_1));
        }

        public static function getColorName(_arg_1:Object):uint
        {
            return (impl.getColorName(_arg_1));
        }

        mx_internal static function set typeSelectorCache(_arg_1:Object):void
        {
            impl.typeSelectorCache = _arg_1;
        }

        public static function unloadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true):void
        {
            impl.unloadStyleDeclarations(_arg_1, _arg_2);
        }

        public static function getColorNames(_arg_1:Array):void
        {
            impl.getColorNames(_arg_1);
        }

        public static function loadStyleDeclarations(_arg_1:String, _arg_2:Boolean=true, _arg_3:Boolean=false, _arg_4:ApplicationDomain=null, _arg_5:SecurityDomain=null):IEventDispatcher
        {
            return (impl.loadStyleDeclarations2(_arg_1, _arg_2, _arg_4, _arg_5));
        }

        private static function get impl():IStyleManager2
        {
            if (!_impl)
            {
                _impl = IStyleManager2(Singleton.getInstance("mx.styles::IStyleManager2"));
            };
            return (_impl);
        }

        public static function isValidStyleValue(_arg_1:*):Boolean
        {
            return (impl.isValidStyleValue(_arg_1));
        }

        mx_internal static function get stylesRoot():Object
        {
            return (impl.stylesRoot);
        }

        public static function isInheritingStyle(_arg_1:String):Boolean
        {
            return (impl.isInheritingStyle(_arg_1));
        }

        mx_internal static function initProtoChainRoots():void
        {
            impl.initProtoChainRoots();
        }

        public static function registerParentSizeInvalidatingStyle(_arg_1:String):void
        {
            impl.registerParentSizeInvalidatingStyle(_arg_1);
        }

        public static function get selectors():Array
        {
            return (impl.selectors);
        }

        public static function registerSizeInvalidatingStyle(_arg_1:String):void
        {
            impl.registerSizeInvalidatingStyle(_arg_1);
        }

        public static function clearStyleDeclaration(_arg_1:String, _arg_2:Boolean):void
        {
            impl.clearStyleDeclaration(_arg_1, _arg_2);
        }

        public static function registerColorName(_arg_1:String, _arg_2:uint):void
        {
            impl.registerColorName(_arg_1, _arg_2);
        }

        public static function isInheritingTextFormatStyle(_arg_1:String):Boolean
        {
            return (impl.isInheritingTextFormatStyle(_arg_1));
        }

        public static function getStyleDeclaration(_arg_1:String):CSSStyleDeclaration
        {
            return (impl.getStyleDeclaration(_arg_1));
        }


    }
}//package mx.styles

