// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.StyleProxy

package mx.styles
{
    import mx.core.FlexVersion;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class StyleProxy implements IStyleClient 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _source:IStyleClient;
        private var _filterMap:Object;

        public function StyleProxy(_arg_1:IStyleClient, _arg_2:Object)
        {
            this.filterMap = _arg_2;
            this.source = _arg_1;
        }

        public function styleChanged(_arg_1:String):void
        {
            return (_source.styleChanged(_arg_1));
        }

        public function get filterMap():Object
        {
            return ((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) ? null : _filterMap);
        }

        public function set filterMap(_arg_1:Object):void
        {
            _filterMap = _arg_1;
        }

        public function get styleDeclaration():CSSStyleDeclaration
        {
            return (_source.styleDeclaration);
        }

        public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
            return (_source.notifyStyleChangeInChildren(_arg_1, _arg_2));
        }

        public function set inheritingStyles(_arg_1:Object):void
        {
        }

        public function get source():IStyleClient
        {
            return (_source);
        }

        public function get styleName():Object
        {
            if ((_source.styleName is IStyleClient))
            {
                return (new StyleProxy(IStyleClient(_source.styleName), filterMap));
            };
            return (_source.styleName);
        }

        public function registerEffects(_arg_1:Array):void
        {
            return (_source.registerEffects(_arg_1));
        }

        public function regenerateStyleCache(_arg_1:Boolean):void
        {
            _source.regenerateStyleCache(_arg_1);
        }

        public function get inheritingStyles():Object
        {
            return (_source.inheritingStyles);
        }

        public function get className():String
        {
            return (_source.className);
        }

        public function clearStyle(_arg_1:String):void
        {
            _source.clearStyle(_arg_1);
        }

        public function getClassStyleDeclarations():Array
        {
            return (_source.getClassStyleDeclarations());
        }

        public function set nonInheritingStyles(_arg_1:Object):void
        {
        }

        public function setStyle(_arg_1:String, _arg_2:*):void
        {
            _source.setStyle(_arg_1, _arg_2);
        }

        public function get nonInheritingStyles():Object
        {
            return ((FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0) ? _source.nonInheritingStyles : null);
        }

        public function set styleName(_arg_1:Object):void
        {
            _source.styleName = _arg_1;
        }

        public function getStyle(_arg_1:String):*
        {
            return (_source.getStyle(_arg_1));
        }

        public function set source(_arg_1:IStyleClient):void
        {
            _source = _arg_1;
        }

        public function set styleDeclaration(_arg_1:CSSStyleDeclaration):void
        {
            _source.styleDeclaration = styleDeclaration;
        }


    }
}//package mx.styles

