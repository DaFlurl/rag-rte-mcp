// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridColumn

package mx.controls.dataGridClasses
{
    import mx.styles.CSSStyleDeclaration;
    import mx.core.IIMESupport;
    import mx.core.IEmbeddedFontRegistry;
    import flash.utils.Dictionary;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.core.EmbeddedFont;
    import mx.core.IFactory;
    import mx.core.ClassFactory;
    import mx.controls.TextInput;
    import mx.core.IFlexModuleFactory;
    import mx.core.Singleton;
    import flash.events.Event;
    import mx.styles.StyleManager;
    import flash.display.DisplayObject;
    import mx.utils.StringUtil;
    import mx.core.EmbeddedFontRegistry;
    import mx.core.ContextualClassFactory;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridColumn extends CSSStyleDeclaration implements IIMESupport 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";
        private static var _embeddedFontRegistry:IEmbeddedFontRegistry;

        private var _headerText:String;
        public var editorXOffset:Number = 0;
        mx_internal var measuringObjects:Dictionary;
        private var fontPropertiesSet:Boolean = false;
        public var rendererIsEditor:Boolean = false;
        mx_internal var cachedHeaderRenderer:IListItemRenderer;
        public var sortDescending:Boolean = false;
        private var cachedEmbeddedFont:EmbeddedFont = null;
        public var editorYOffset:Number = 0;
        private var _headerWordWrap:*;
        private var _dataTipFunction:Function;
        private var _visible:Boolean = true;
        public var editorWidthOffset:Number = 0;
        public var itemEditor:IFactory = new ClassFactory(TextInput);
        public var editorUsesEnterKey:Boolean = false;
        public var editable:Boolean = true;
        private var _nullItemRenderer:IFactory;
        mx_internal var freeItemRenderersByFactory:Dictionary;
        public var editorDataField:String = "text";
        mx_internal var newlyVisible:Boolean = false;
        public var draggable:Boolean = true;
        protected var hasComplexFieldName:Boolean = false;
        private var _sortCompareFunction:Function;
        public var editorHeightOffset:Number = 0;
        public var resizable:Boolean = true;
        private var _headerRenderer:IFactory;
        mx_internal var owner:DataGridBase;
        private var _imeMode:String;
        private var _dataTipField:String;
        protected var complexFieldNameComponents:Array;
        private var _width:Number = 100;
        private var oldEmbeddedFontContext:IFlexModuleFactory = null;
        private var _wordWrap:*;
        mx_internal var preferredWidth:Number = 100;
        private var _itemRenderer:IFactory;
        mx_internal var colNum:Number;
        private var _dataField:String;
        private var _minWidth:Number = 20;
        private var _labelFunction:Function;
        private var hasFontContextBeenSaved:Boolean = false;
        public var sortable:Boolean = true;
        mx_internal var explicitWidth:Number;
        private var _showDataTips:*;

        public function DataGridColumn(_arg_1:String=null)
        {
            if (_arg_1)
            {
                dataField = _arg_1;
                headerText = _arg_1;
            };
        }

        private static function get embeddedFontRegistry():IEmbeddedFontRegistry
        {
            if (!_embeddedFontRegistry)
            {
                _embeddedFontRegistry = IEmbeddedFontRegistry(Singleton.getInstance("mx.core::IEmbeddedFontRegistry"));
            };
            return (_embeddedFontRegistry);
        }


        mx_internal function getMeasuringRenderer(_arg_1:Boolean, _arg_2:Object):IListItemRenderer
        {
            var _local_3:IFactory = getItemRendererFactory(_arg_1, _arg_2);
            if (!_local_3)
            {
                _local_3 = owner.itemRenderer;
            };
            if (!measuringObjects)
            {
                measuringObjects = new Dictionary(false);
            };
            var _local_4:IListItemRenderer = measuringObjects[_local_3];
            if (!_local_4)
            {
                _local_4 = _local_3.newInstance();
                _local_4.visible = false;
                _local_4.styleName = this;
                measuringObjects[_local_3] = _local_4;
            };
            return (_local_4);
        }

        public function get imeMode():String
        {
            return (_imeMode);
        }

        public function set imeMode(_arg_1:String):void
        {
            _imeMode = _arg_1;
        }

        public function getItemRendererFactory(_arg_1:Boolean, _arg_2:Object):IFactory
        {
            if (_arg_1)
            {
                return (replaceItemRendererFactory(headerRenderer));
            };
            if (!_arg_2)
            {
                return (replaceItemRendererFactory(nullItemRenderer));
            };
            return (replaceItemRendererFactory(itemRenderer));
        }

        public function set dataTipFunction(_arg_1:Function):void
        {
            _dataTipFunction = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
            dispatchEvent(new Event("labelFunctionChanged"));
        }

        [Bindable("nullItemRendererChanged")]
        public function get nullItemRenderer():IFactory
        {
            return (_nullItemRenderer);
        }

        public function get showDataTips():*
        {
            return (_showDataTips);
        }

        public function get headerWordWrap():*
        {
            return (_headerWordWrap);
        }

        public function set minWidth(_arg_1:Number):void
        {
            _minWidth = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
            if (_width < _arg_1)
            {
                _width = _arg_1;
            };
            dispatchEvent(new Event("minWidthChanged"));
        }

        public function set nullItemRenderer(_arg_1:IFactory):void
        {
            _nullItemRenderer = _arg_1;
            if (owner)
            {
                owner.invalidateList();
                owner.columnRendererChanged(this);
            };
            dispatchEvent(new Event("nullItemRendererChanged"));
        }

        public function set showDataTips(_arg_1:*):void
        {
            _showDataTips = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
        }

        public function set headerWordWrap(_arg_1:*):void
        {
            _headerWordWrap = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
        }

        override mx_internal function addStyleToProtoChain(_arg_1:Object, _arg_2:DisplayObject, _arg_3:Object=null):Object
        {
            var _local_6:Object;
            var _local_7:Object;
            var _local_8:Object;
            var _local_4:DataGridBase = owner;
            var _local_5:IListItemRenderer = IListItemRenderer(_arg_2);
            if (_local_6)
            {
                if ((_local_6 is String))
                {
                    _local_6 = StyleManager.getStyleDeclaration(("." + _local_6));
                };
                if ((_local_6 is CSSStyleDeclaration))
                {
                    _arg_1 = _local_6.addStyleToProtoChain(_arg_1, _arg_2);
                };
            };
            _arg_1 = super.addStyleToProtoChain(_arg_1, _arg_2);
            if (((_local_5.data) && (_local_5.data is DataGridColumn)))
            {
                _local_8 = _local_4.getStyle("headerStyleName");
                if (_local_8)
                {
                    if ((_local_8 is String))
                    {
                        _local_8 = StyleManager.getStyleDeclaration(("." + _local_8));
                    };
                    if ((_local_8 is CSSStyleDeclaration))
                    {
                        _arg_1 = _local_8.addStyleToProtoChain(_arg_1, _arg_2);
                    };
                };
                _local_8 = getStyle("headerStyleName");
                if (_local_8)
                {
                    if ((_local_8 is String))
                    {
                        _local_8 = StyleManager.getStyleDeclaration(("." + _local_8));
                    };
                    if ((_local_8 is CSSStyleDeclaration))
                    {
                        _arg_1 = _local_8.addStyleToProtoChain(_arg_1, _arg_2);
                    };
                };
            };
            if (!fontPropertiesSet)
            {
                fontPropertiesSet = true;
                saveFontContext(((owner) ? owner.moduleFactory : null));
            };
            return (_arg_1);
        }

        [Bindable("headerTextChanged")]
        public function get headerText():String
        {
            return ((_headerText != null) ? _headerText : dataField);
        }

        [Bindable("sortCompareFunctionChanged")]
        public function get sortCompareFunction():Function
        {
            return (_sortCompareFunction);
        }

        protected function complexColumnSortCompare(_arg_1:Object, _arg_2:Object):int
        {
            if (((!(_arg_1)) && (!(_arg_2))))
            {
                return (0);
            };
            if (!_arg_1)
            {
                return (1);
            };
            if (!_arg_2)
            {
                return (-1);
            };
            var _local_3:String = deriveComplexColumnData(_arg_1).toString();
            var _local_4:String = deriveComplexColumnData(_arg_2).toString();
            if (_local_3 < _local_4)
            {
                return (-1);
            };
            if (_local_3 > _local_4)
            {
                return (1);
            };
            return (0);
        }

        mx_internal function hasFontContextChanged(_arg_1:IFlexModuleFactory):Boolean
        {
            if (!hasFontContextBeenSaved)
            {
                return (false);
            };
            var _local_2:String = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _local_3:String = getStyle("fontWeight");
            var _local_4:String = getStyle("fontStyle");
            var _local_5:* = (_local_3 == "bold");
            var _local_6:* = (_local_4 == "italic");
            var _local_7:EmbeddedFont = getEmbeddedFont(_local_2, _local_5, _local_6);
            var _local_8:IFlexModuleFactory = embeddedFontRegistry.getAssociatedModuleFactory(_local_7, _arg_1);
            return (!(_local_8 == oldEmbeddedFontContext));
        }

        override public function setStyle(_arg_1:String, _arg_2:*):void
        {
            fontPropertiesSet = false;
            var _local_3:Object = getStyle(_arg_1);
            var _local_4:Boolean;
            if (((((factory == null) && (defaultFactory == null)) && (!(overrides))) && (!(_local_3 === _arg_2))))
            {
                _local_4 = true;
            };
            super.setStyle(_arg_1, _arg_2);
            if (_arg_1 == "headerStyleName")
            {
                if (owner)
                {
                    owner.regenerateStyleCache(true);
                    owner.notifyStyleChangeInChildren("headerStyleName", true);
                };
                return;
            };
            if (owner)
            {
                if (_local_4)
                {
                    owner.regenerateStyleCache(true);
                };
                if (hasFontContextChanged(owner.moduleFactory))
                {
                    owner.columnRendererChanged(this);
                };
                owner.invalidateList();
            };
        }

        public function get dataField():String
        {
            return (_dataField);
        }

        public function get visible():Boolean
        {
            return (_visible);
        }

        public function get wordWrap():*
        {
            return (_wordWrap);
        }

        [Bindable("headerRendererChanged")]
        public function get headerRenderer():IFactory
        {
            return (_headerRenderer);
        }

        mx_internal function setWidth(_arg_1:Number):void
        {
            var _local_2:Number = _width;
            _width = _arg_1;
            if (_local_2 != _arg_1)
            {
                dispatchEvent(new Event("widthChanged"));
            };
        }

        mx_internal function getEmbeddedFont(_arg_1:String, _arg_2:Boolean, _arg_3:Boolean):EmbeddedFont
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

        [Bindable("dataTipFunctionChanged")]
        public function get dataTipFunction():Function
        {
            return (_dataTipFunction);
        }

        public function set width(_arg_1:Number):void
        {
            var _local_2:Boolean;
            explicitWidth = _arg_1;
            preferredWidth = _arg_1;
            if (owner != null)
            {
                _local_2 = resizable;
                resizable = false;
                owner.resizeColumn(colNum, _arg_1);
                resizable = _local_2;
            }
            else
            {
                _width = _arg_1;
            };
            dispatchEvent(new Event("widthChanged"));
        }

        [Bindable("minWidthChanged")]
        public function get minWidth():Number
        {
            return (_minWidth);
        }

        protected function deriveComplexColumnData(_arg_1:Object):Object
        {
            var _local_3:int;
            var _local_2:Object = _arg_1;
            if (complexFieldNameComponents)
            {
                _local_3 = 0;
                while (_local_3 < complexFieldNameComponents.length)
                {
                    _local_2 = _local_2[complexFieldNameComponents[_local_3]];
                    _local_3++;
                };
            };
            return (_local_2);
        }

        private function saveFontContext(_arg_1:IFlexModuleFactory):void
        {
            hasFontContextBeenSaved = true;
            var _local_2:String = StringUtil.trimArrayElements(getStyle("fontFamily"), ",");
            var _local_3:String = getStyle("fontWeight");
            var _local_4:String = getStyle("fontStyle");
            var _local_5:* = (_local_3 == "bold");
            var _local_6:* = (_local_4 == "italic");
            var _local_7:EmbeddedFont = getEmbeddedFont(_local_2, _local_5, _local_6);
            oldEmbeddedFontContext = embeddedFontRegistry.getAssociatedModuleFactory(_local_7, _arg_1);
        }

        public function itemToLabel(data:Object):String
        {
            if (!data)
            {
                return (" ");
            };
            if (labelFunction != null)
            {
                return (labelFunction(data, this));
            };
            if (owner.labelFunction != null)
            {
                return (owner.labelFunction(data, this));
            };
            if (((typeof(data) == "object") || (typeof(data) == "xml")))
            {
                try
                {
                    if (!hasComplexFieldName)
                    {
                        data = data[dataField];
                    }
                    else
                    {
                        data = deriveComplexColumnData(data);
                    };
                }
                catch(e:Error)
                {
                    data = null;
                };
            };
            if ((data is String))
            {
                return (String(data));
            };
            try
            {
                return (data.toString());
            }
            catch(e:Error)
            {
            };
            return (" ");
        }

        public function set headerText(_arg_1:String):void
        {
            _headerText = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
            dispatchEvent(new Event("headerTextChanged"));
        }

        public function set sortCompareFunction(_arg_1:Function):void
        {
            _sortCompareFunction = _arg_1;
            dispatchEvent(new Event("sortCompareFunctionChanged"));
        }

        public function itemToDataTip(data:Object):String
        {
            var field:String;
            if (dataTipFunction != null)
            {
                return (dataTipFunction(data));
            };
            if (owner.dataTipFunction != null)
            {
                return (owner.dataTipFunction(data));
            };
            if (((typeof(data) == "object") || (typeof(data) == "xml")))
            {
                field = dataTipField;
                if (!field)
                {
                    field = owner.dataTipField;
                };
                try
                {
                    if (data[field] != null)
                    {
                        data = data[field];
                    }
                    else
                    {
                        if (data[dataField] != null)
                        {
                            data = data[dataField];
                        };
                    };
                }
                catch(e:Error)
                {
                    data = null;
                };
            };
            if ((data is String))
            {
                return (String(data));
            };
            try
            {
                return (data.toString());
            }
            catch(e:Error)
            {
            };
            return (" ");
        }

        [Bindable("widthChanged")]
        public function get width():Number
        {
            return (_width);
        }

        public function set dataTipField(_arg_1:String):void
        {
            _dataTipField = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
            dispatchEvent(new Event("dataTipChanged"));
        }

        public function set labelFunction(_arg_1:Function):void
        {
            _labelFunction = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
            dispatchEvent(new Event("labelFunctionChanged"));
        }

        public function set dataField(_arg_1:String):void
        {
            _dataField = _arg_1;
            if (_arg_1.indexOf(".") != -1)
            {
                hasComplexFieldName = true;
                complexFieldNameComponents = _arg_1.split(".");
                if (_sortCompareFunction == null)
                {
                    _sortCompareFunction = complexColumnSortCompare;
                };
            };
            if (owner)
            {
                owner.invalidateList();
            };
        }

        public function set headerRenderer(_arg_1:IFactory):void
        {
            _headerRenderer = _arg_1;
            if (owner)
            {
                owner.invalidateList();
                owner.columnRendererChanged(this);
            };
            dispatchEvent(new Event("headerRendererChanged"));
        }

        public function set wordWrap(_arg_1:*):void
        {
            _wordWrap = _arg_1;
            if (owner)
            {
                owner.invalidateList();
            };
        }

        [Bindable("dataTipFieldChanged")]
        public function get dataTipField():String
        {
            return (_dataTipField);
        }

        public function set visible(_arg_1:Boolean):void
        {
            if (_visible != _arg_1)
            {
                _visible = _arg_1;
                if (_arg_1)
                {
                    newlyVisible = true;
                };
                if (owner)
                {
                    owner.columnsInvalid = true;
                    owner.invalidateSize();
                    owner.invalidateList();
                };
            };
        }

        public function set itemRenderer(_arg_1:IFactory):void
        {
            _itemRenderer = _arg_1;
            if (owner)
            {
                owner.invalidateList();
                owner.columnRendererChanged(this);
            };
            dispatchEvent(new Event("itemRendererChanged"));
        }

        private function replaceItemRendererFactory(_arg_1:IFactory):IFactory
        {
            if (oldEmbeddedFontContext == null)
            {
                return (_arg_1);
            };
            if (((_arg_1 == null) && (!(owner == null))))
            {
                _arg_1 = owner.itemRenderer;
            };
            if ((_arg_1 is ClassFactory))
            {
                return (new ContextualClassFactory(ClassFactory(_arg_1).generator, oldEmbeddedFontContext));
            };
            return (_arg_1);
        }

        [Bindable("itemRendererChanged")]
        public function get itemRenderer():IFactory
        {
            return (_itemRenderer);
        }

        [Bindable("labelFunctionChanged")]
        public function get labelFunction():Function
        {
            return (_labelFunction);
        }


    }
}//package mx.controls.dataGridClasses

