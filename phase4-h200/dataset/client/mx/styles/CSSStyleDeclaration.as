// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.styles.CSSStyleDeclaration

package mx.styles
{
    import flash.events.EventDispatcher;
    import mx.core.mx_internal;
    import flash.utils.Dictionary;
    import mx.core.Singleton;
    import flash.display.DisplayObject;
    import mx.managers.SystemManagerGlobals;

    use namespace mx_internal;

    public class CSSStyleDeclaration extends EventDispatcher 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static const NOT_A_COLOR:uint = 0xFFFFFFFF;
        private static const FILTERMAP_PROP:String = "__reserved__filterMap";

        mx_internal var effects:Array;
        protected var overrides:Object;
        public var defaultFactory:Function;
        public var factory:Function;
        mx_internal var selectorRefCount:int = 0;
        private var styleManager:IStyleManager2;
        private var clones:Dictionary = new Dictionary(true);

        public function CSSStyleDeclaration(_arg_1:String=null)
        {
            if (_arg_1)
            {
                styleManager = (Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2);
                styleManager.setStyleDeclaration(_arg_1, this, false);
            };
        }

        mx_internal function addStyleToProtoChain(chain:Object, target:DisplayObject, filterMap:Object=null):Object
        {
            var p:String;
            var emptyObjectFactory:Function;
            var filteredChain:Object;
            var filterObjectFactory:Function;
            var i:String;
            var nodeAddedToChain:Boolean;
            var originalChain:Object = chain;
            if (filterMap)
            {
                chain = {};
            };
            if (defaultFactory != null)
            {
                defaultFactory.prototype = chain;
                chain = new defaultFactory();
                nodeAddedToChain = true;
            };
            if (factory != null)
            {
                factory.prototype = chain;
                chain = new factory();
                nodeAddedToChain = true;
            };
            if (overrides)
            {
                if (((defaultFactory == null) && (factory == null)))
                {
                    emptyObjectFactory = function ():void
                    {
                    };
                    emptyObjectFactory.prototype = chain;
                    chain = new (emptyObjectFactory)();
                    nodeAddedToChain = true;
                };
                for (p in overrides)
                {
                    if (overrides[p] === undefined)
                    {
                        delete chain[p];
                    }
                    else
                    {
                        chain[p] = overrides[p];
                    };
                };
            };
            if (filterMap)
            {
                if (nodeAddedToChain)
                {
                    filteredChain = {};
                    filterObjectFactory = function ():void
                    {
                    };
                    filterObjectFactory.prototype = originalChain;
                    filteredChain = new (filterObjectFactory)();
                    for (i in chain)
                    {
                        if (filterMap[i] != null)
                        {
                            filteredChain[filterMap[i]] = chain[i];
                        };
                    };
                    chain = filteredChain;
                    chain[FILTERMAP_PROP] = filterMap;
                }
                else
                {
                    chain = originalChain;
                };
            };
            if (nodeAddedToChain)
            {
                clones[chain] = 1;
            };
            return (chain);
        }

        public function getStyle(_arg_1:String):*
        {
            var _local_2:*;
            var _local_3:*;
            if (overrides)
            {
                if (((_arg_1 in overrides) && (overrides[_arg_1] === undefined)))
                {
                    return (undefined);
                };
                _local_3 = overrides[_arg_1];
                if (_local_3 !== undefined)
                {
                    return (_local_3);
                };
            };
            if (factory != null)
            {
                factory.prototype = {};
                _local_2 = new factory();
                _local_3 = _local_2[_arg_1];
                if (_local_3 !== undefined)
                {
                    return (_local_3);
                };
            };
            if (defaultFactory != null)
            {
                defaultFactory.prototype = {};
                _local_2 = new defaultFactory();
                _local_3 = _local_2[_arg_1];
                if (_local_3 !== undefined)
                {
                    return (_local_3);
                };
            };
            return (undefined);
        }

        public function clearStyle(_arg_1:String):void
        {
            public::setStyle(_arg_1, undefined);
        }

        public function setStyle(_arg_1:String, _arg_2:*):void
        {
            var _local_7:int;
            var _local_8:Object;
            var _local_3:Object = getStyle(_arg_1);
            var _local_4:Boolean;
            if ((((((selectorRefCount > 0) && (factory == null)) && (defaultFactory == null)) && (!(overrides))) && (!(_local_3 === _arg_2))))
            {
                _local_4 = true;
            };
            if (_arg_2 !== undefined)
            {
                mx_internal::setStyle(_arg_1, _arg_2);
            }
            else
            {
                if (_arg_2 == _local_3)
                {
                    return;
                };
                mx_internal::setStyle(_arg_1, _arg_2);
            };
            var _local_5:Array = SystemManagerGlobals.topLevelSystemManagers;
            var _local_6:int = _local_5.length;
            if (_local_4)
            {
                _local_7 = 0;
                while (_local_7 < _local_6)
                {
                    _local_8 = _local_5[_local_7];
                    _local_8.regenerateStyleCache(true);
                    _local_7++;
                };
            };
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_8 = _local_5[_local_7];
                _local_8.notifyStyleChangeInChildren(_arg_1, true);
                _local_7++;
            };
        }

        private function clearStyleAttr(_arg_1:String):void
        {
            var _local_2:*;
            if (!overrides)
            {
                overrides = {};
            };
            overrides[_arg_1] = undefined;
            for (_local_2 in clones)
            {
                delete _local_2[_arg_1];
            };
        }

        mx_internal function createProtoChainRoot():Object
        {
            var _local_1:Object = {};
            if (defaultFactory != null)
            {
                defaultFactory.prototype = _local_1;
                _local_1 = new defaultFactory();
            };
            if (factory != null)
            {
                factory.prototype = _local_1;
                _local_1 = new factory();
            };
            clones[_local_1] = 1;
            return (_local_1);
        }

        mx_internal function clearOverride(_arg_1:String):void
        {
            if (((overrides) && (overrides[_arg_1])))
            {
                delete overrides[_arg_1];
            };
        }

        mx_internal function setStyle(_arg_1:String, _arg_2:*):void
        {
            var _local_3:Object;
            var _local_4:*;
            var _local_5:Number;
            var _local_6:Object;
            if (_arg_2 === undefined)
            {
                clearStyleAttr(_arg_1);
                return;
            };
            if ((_arg_2 is String))
            {
                if (!styleManager)
                {
                    styleManager = (Singleton.getInstance("mx.styles::IStyleManager2") as IStyleManager2);
                };
                _local_5 = styleManager.getColorName(_arg_2);
                if (_local_5 != NOT_A_COLOR)
                {
                    _arg_2 = _local_5;
                };
            };
            if (defaultFactory != null)
            {
                _local_3 = new defaultFactory();
                if (_local_3[_arg_1] !== _arg_2)
                {
                    if (!overrides)
                    {
                        overrides = {};
                    };
                    overrides[_arg_1] = _arg_2;
                }
                else
                {
                    if (overrides)
                    {
                        delete overrides[_arg_1];
                    };
                };
            };
            if (factory != null)
            {
                _local_3 = new factory();
                if (_local_3[_arg_1] !== _arg_2)
                {
                    if (!overrides)
                    {
                        overrides = {};
                    };
                    overrides[_arg_1] = _arg_2;
                }
                else
                {
                    if (overrides)
                    {
                        delete overrides[_arg_1];
                    };
                };
            };
            if (((defaultFactory == null) && (factory == null)))
            {
                if (!overrides)
                {
                    overrides = {};
                };
                overrides[_arg_1] = _arg_2;
            };
            for (_local_4 in clones)
            {
                _local_6 = _local_4[FILTERMAP_PROP];
                if (_local_6)
                {
                    if (_local_6[_arg_1] != null)
                    {
                        _local_4[_local_6[_arg_1]] = _arg_2;
                    };
                }
                else
                {
                    _local_4[_arg_1] = _arg_2;
                };
            };
        }


    }
}//package mx.styles

