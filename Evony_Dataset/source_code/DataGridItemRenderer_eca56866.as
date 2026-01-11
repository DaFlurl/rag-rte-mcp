// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.dataGridClasses.DataGridItemRenderer

package mx.controls.dataGridClasses
{
    import mx.core.UITextField;
    import mx.core.IDataRenderer;
    import mx.controls.listClasses.IDropInListItemRenderer;
    import mx.managers.ILayoutManagerClient;
    import mx.controls.listClasses.IListItemRenderer;
    import mx.styles.IStyleClient;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.ToolTipEvent;
    import mx.core.UIComponent;
    import flash.utils.getQualifiedClassName;
    import mx.styles.StyleManager;
    import flash.utils.getQualifiedSuperclassName;
    import flash.utils.getDefinitionByName;
    import mx.core.UIComponentGlobals;
    import flash.geom.Rectangle;
    import mx.events.InterManagerRequest;
    import mx.core.IToolTip;
    import mx.managers.ISystemManager;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import mx.events.FlexEvent;
    import mx.controls.listClasses.BaseListData;
    import mx.controls.DataGrid;
    import mx.core.IFlexDisplayObject;
    import mx.styles.StyleProtoChain;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class DataGridItemRenderer extends UITextField implements IDataRenderer, IDropInListItemRenderer, ILayoutManagerClient, IListItemRenderer, IStyleClient 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var invalidateSizeFlag:Boolean = false;
        private var _data:Object;
        private var _listData:DataGridListData;
        private var invalidatePropertiesFlag:Boolean = false;
        private var _styleDeclaration:CSSStyleDeclaration;

        public function DataGridItemRenderer()
        {
            tabEnabled = false;
            mouseWheelEnabled = false;
            ignorePadding = false;
            addEventListener(ToolTipEvent.TOOL_TIP_SHOW, toolTipShowHandler);
            inheritingStyles = (nonInheritingStyles = UIComponent.STYLE_UNINITIALIZED);
        }

        override public function initialize():void
        {
            regenerateStyleCache(false);
        }

        public function validateDisplayList():void
        {
            validateNow();
        }

        public function getClassStyleDeclarations():Array
        {
            var s:CSSStyleDeclaration;
            var className:String = getQualifiedClassName(this);
            className = className.replace("::", ".");
            var decls:Array = [];
            while ((((!(className == null)) && (!(className == "mx.core.UIComponent"))) && (!(className == "mx.core.UITextField"))))
            {
                s = StyleManager.getStyleDeclaration(className);
                if (s)
                {
                    decls.unshift(s);
                };
                try
                {
                    className = getQualifiedSuperclassName(getDefinitionByName(className));
                    className = className.replace("::", ".");
                }
                catch(e:ReferenceError)
                {
                    className = null;
                };
            };
            return (decls);
        }

        public function notifyStyleChangeInChildren(_arg_1:String, _arg_2:Boolean):void
        {
        }

        public function regenerateStyleCache(_arg_1:Boolean):void
        {
            initProtoChain();
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        public function get styleDeclaration():CSSStyleDeclaration
        {
            return (_styleDeclaration);
        }

        override public function set nestLevel(_arg_1:int):void
        {
            super.nestLevel = _arg_1;
            UIComponentGlobals.layoutManager.invalidateProperties(this);
            invalidatePropertiesFlag = true;
            UIComponentGlobals.layoutManager.invalidateSize(this);
            invalidateSizeFlag = true;
        }

        public function validateSize(_arg_1:Boolean=false):void
        {
            invalidateSizeFlag = false;
            validateNow();
        }

        protected function toolTipShowHandler(_arg_1:ToolTipEvent):void
        {
            var _local_5:Rectangle;
            var _local_8:InterManagerRequest;
            var _local_2:IToolTip = _arg_1.toolTip;
            var _local_3:ISystemManager = systemManager.topLevelSystemManager;
            var _local_4:DisplayObject = _local_3.getSandboxRoot();
            var _local_6:Point = new Point(0, 0);
            _local_6 = localToGlobal(_local_6);
            _local_6 = _local_4.globalToLocal(_local_6);
            _local_2.move(_local_6.x, (_local_6.y + ((height - _local_2.height) / 2)));
            if (_local_3 != _local_4)
            {
                _local_8 = new InterManagerRequest(InterManagerRequest.SYSTEM_MANAGER_REQUEST, false, false, "getVisibleApplicationRect");
                _local_4.dispatchEvent(_local_8);
                _local_5 = Rectangle(_local_8.value);
            }
            else
            {
                _local_5 = _local_3.getVisibleApplicationRect();
            };
            var _local_7:Number = (_local_5.x + _local_5.width);
            _local_6.x = _local_2.x;
            _local_6.y = _local_2.y;
            _local_6 = _local_4.localToGlobal(_local_6);
            if ((_local_6.x + _local_2.width) > _local_7)
            {
                _local_2.move((_local_2.x - ((_local_6.x + _local_2.width) - _local_7)), _local_2.y);
            };
        }

        public function set styleDeclaration(_arg_1:CSSStyleDeclaration):void
        {
            _styleDeclaration = _arg_1;
        }

        override public function validateNow():void
        {
            var _local_1:Number;
            if (((data) && (parent)))
            {
                if (DataGridBase(_listData.owner).isItemHighlighted(_listData.uid))
                {
                    _local_1 = getStyle("textRollOverColor");
                }
                else
                {
                    if (DataGridBase(_listData.owner).isItemSelected(_listData.uid))
                    {
                        _local_1 = getStyle("textSelectedColor");
                    }
                    else
                    {
                        _local_1 = getStyle("color");
                    };
                };
                if (_local_1 != explicitColor)
                {
                    styleChangedFlag = true;
                    explicitColor = _local_1;
                    invalidateDisplayList();
                };
            };
            super.validateNow();
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        public function clearStyle(_arg_1:String):void
        {
            setStyle(_arg_1, undefined);
        }

        public function registerEffects(_arg_1:Array):void
        {
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        public function validateProperties():void
        {
            var _local_1:DataGrid;
            var _local_2:DataGridColumn;
            var _local_3:Boolean;
            invalidatePropertiesFlag = false;
            if (_listData)
            {
                _local_1 = DataGrid(_listData.owner);
                _local_2 = _local_1.columns[_listData.columnIndex];
                text = _listData.label;
                if ((_data is DataGridColumn))
                {
                    wordWrap = _local_1.columnHeaderWordWrap(_local_2);
                }
                else
                {
                    wordWrap = _local_1.columnWordWrap(_local_2);
                };
                if (DataGrid(_listData.owner).variableRowHeight)
                {
                    multiline = true;
                };
                _local_3 = _local_1.showDataTips;
                if (_local_2.showDataTips == true)
                {
                    _local_3 = true;
                };
                if (_local_2.showDataTips == false)
                {
                    _local_3 = false;
                };
                if (_local_3)
                {
                    if (((!(_data is DataGridColumn)) && (((((textWidth > width) || (_local_2.dataTipFunction)) || (_local_2.dataTipField)) || (_local_1.dataTipFunction)) || (_local_1.dataTipField))))
                    {
                        toolTip = _local_2.itemToDataTip(_data);
                    }
                    else
                    {
                        toolTip = null;
                    };
                }
                else
                {
                    toolTip = null;
                };
            }
            else
            {
                text = " ";
                toolTip = null;
            };
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = DataGridListData(_arg_1);
            if (((nestLevel) && (!(invalidatePropertiesFlag))))
            {
                UIComponentGlobals.layoutManager.invalidateProperties(this);
                invalidatePropertiesFlag = true;
                UIComponentGlobals.layoutManager.invalidateSize(this);
                invalidateSizeFlag = true;
            };
        }

        public function initProtoChain():void
        {
            var _local_1:CSSStyleDeclaration;
            var _local_7:Object;
            var _local_8:CSSStyleDeclaration;
            styleChangedFlag = true;
            if (styleName)
            {
                if ((styleName is CSSStyleDeclaration))
                {
                    _local_1 = CSSStyleDeclaration(styleName);
                }
                else
                {
                    if ((styleName is IFlexDisplayObject))
                    {
                        StyleProtoChain.initProtoChainForUIComponentStyleName(this);
                        return;
                    };
                    if ((styleName is String))
                    {
                        _local_1 = StyleManager.getStyleDeclaration(("." + styleName));
                    };
                };
            };
            var _local_2:Object = StyleManager.stylesRoot;
            var _local_3:IStyleClient = (parent as IStyleClient);
            if (_local_3)
            {
                _local_7 = _local_3.inheritingStyles;
                if (_local_7 == UIComponent.STYLE_UNINITIALIZED)
                {
                    _local_7 = _local_2;
                };
            }
            else
            {
                _local_7 = StyleManager.stylesRoot;
            };
            var _local_4:Array = getClassStyleDeclarations();
            var _local_5:int = _local_4.length;
            var _local_6:int;
            while (_local_6 < _local_5)
            {
                _local_8 = _local_4[_local_6];
                _local_7 = _local_8.addStyleToProtoChain(_local_7, this);
                _local_2 = _local_8.addStyleToProtoChain(_local_2, this);
                _local_6++;
            };
            if (_local_1)
            {
                _local_7 = _local_1.addStyleToProtoChain(_local_7, this);
                _local_2 = _local_1.addStyleToProtoChain(_local_2, this);
            };
            inheritingStyles = ((styleDeclaration) ? styleDeclaration.addStyleToProtoChain(_local_7, this) : _local_7);
            nonInheritingStyles = ((styleDeclaration) ? styleDeclaration.addStyleToProtoChain(_local_2, this) : _local_2);
        }

        override public function getStyle(_arg_1:String):*
        {
            return ((StyleManager.inheritingStyles[_arg_1]) ? inheritingStyles[_arg_1] : nonInheritingStyles[_arg_1]);
        }

        override public function setStyle(_arg_1:String, _arg_2:*):void
        {
            if (_arg_1 == "styleName")
            {
                styleName = _arg_2;
                return;
            };
            var _local_3:Boolean = StyleManager.isInheritingStyle(_arg_1);
            var _local_4:* = (!(inheritingStyles == UIComponent.STYLE_UNINITIALIZED));
            if (_local_3)
            {
                if (((getStyle(_arg_1) == _arg_2) && (_local_4)))
                {
                    return;
                };
                if (!styleDeclaration)
                {
                    styleDeclaration = new CSSStyleDeclaration();
                    styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
                    if (_local_4)
                    {
                        regenerateStyleCache(true);
                    };
                }
                else
                {
                    styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
                };
            }
            else
            {
                if (((getStyle(_arg_1) == _arg_2) && (_local_4)))
                {
                    return;
                };
                if (!styleDeclaration)
                {
                    styleDeclaration = new CSSStyleDeclaration();
                    styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
                    if (_local_4)
                    {
                        regenerateStyleCache(false);
                    };
                }
                else
                {
                    styleDeclaration.mx_internal::setStyle(_arg_1, _arg_2);
                };
            };
            if (_local_4)
            {
                styleChanged(_arg_1);
                notifyStyleChangeInChildren(_arg_1, _local_3);
            };
        }


    }
}//package mx.controls.dataGridClasses

