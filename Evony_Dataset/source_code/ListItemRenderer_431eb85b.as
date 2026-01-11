// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.ListItemRenderer

package mx.controls.listClasses
{
    import mx.core.UIComponent;
    import mx.core.IDataRenderer;
    import mx.core.IFontContextComponent;
    import mx.core.IUITextField;
    import mx.core.IFlexDisplayObject;
    import mx.events.ToolTipEvent;
    import mx.core.IFlexModuleFactory;
    import flash.display.DisplayObject;
    import mx.core.UITextField;
    import flash.geom.Rectangle;
    import mx.events.InterManagerRequest;
    import mx.core.IToolTip;
    import mx.managers.ISystemManager;
    import flash.geom.Point;
    import mx.events.FlexEvent;
    import mx.core.FlexVersion;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class ListItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var _listData:ListData;
        private var _data:Object;
        protected var label:IUITextField;
        private var listOwner:ListBase;
        protected var icon:IFlexDisplayObject;

        public function ListItemRenderer()
        {
            addEventListener(ToolTipEvent.TOOL_TIP_SHOW, toolTipShowHandler);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        mx_internal function getLabel():IUITextField
        {
            return (label);
        }

        override protected function commitProperties():void
        {
            var _local_2:Class;
            super.commitProperties();
            var _local_1:int = -1;
            if (((hasFontContextChanged()) && (!(label == null))))
            {
                _local_1 = getChildIndex(DisplayObject(label));
                removeChild(DisplayObject(label));
                label = null;
            };
            if (!label)
            {
                label = IUITextField(createInFontContext(UITextField));
                label.styleName = this;
                if (_local_1 == -1)
                {
                    addChild(DisplayObject(label));
                }
                else
                {
                    addChildAt(DisplayObject(label), _local_1);
                };
            };
            if (icon)
            {
                removeChild(DisplayObject(icon));
                icon = null;
            };
            if (_data != null)
            {
                listOwner = ListBase(_listData.owner);
                if (_listData.icon)
                {
                    _local_2 = _listData.icon;
                    icon = new (_local_2)();
                    addChild(DisplayObject(icon));
                };
                label.text = ((_listData.label) ? _listData.label : " ");
                label.multiline = listOwner.variableRowHeight;
                label.wordWrap = listOwner.wordWrap;
                if (listOwner.showDataTips)
                {
                    if (((label.textWidth > label.width) || (!(listOwner.dataTipFunction == null))))
                    {
                        toolTip = listOwner.itemToDataTip(_data);
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
                label.text = " ";
                toolTip = null;
            };
        }

        protected function toolTipShowHandler(_arg_1:ToolTipEvent):void
        {
            var _local_5:Rectangle;
            var _local_8:InterManagerRequest;
            var _local_2:IToolTip = _arg_1.toolTip;
            var _local_3:ISystemManager = systemManager.topLevelSystemManager;
            var _local_4:DisplayObject = _local_3.getSandboxRoot();
            var _local_6:Point = new Point(0, 0);
            _local_6 = label.localToGlobal(_local_6);
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

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = ListData(_arg_1);
            invalidateProperties();
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                if (!label)
                {
                    return (0);
                };
                return (label.baselinePosition);
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (label.y + label.baselinePosition);
        }

        override protected function measure():void
        {
            var _local_1:Number;
            super.measure();
            _local_1 = 0;
            if (icon)
            {
                _local_1 = icon.measuredWidth;
            };
            if (((label.width < 4) || (label.height < 4)))
            {
                label.width = 4;
                label.height = 16;
            };
            if (isNaN(explicitWidth))
            {
                _local_1 = (_local_1 + label.getExplicitOrMeasuredWidth());
                measuredWidth = _local_1;
                measuredHeight = label.getExplicitOrMeasuredHeight();
            }
            else
            {
                measuredWidth = explicitWidth;
                label.setActualSize(Math.max((explicitWidth - _local_1), 4), label.height);
                measuredHeight = label.getExplicitOrMeasuredHeight();
                if (((icon) && (icon.measuredHeight > measuredHeight)))
                {
                    measuredHeight = icon.measuredHeight;
                };
            };
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            if (!label)
            {
                label = IUITextField(createInFontContext(UITextField));
                label.styleName = this;
                addChild(DisplayObject(label));
            };
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_5:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = 0;
            if (icon)
            {
                icon.x = _local_3;
                _local_3 = (icon.x + icon.measuredWidth);
                icon.setActualSize(icon.measuredWidth, icon.measuredHeight);
            };
            label.x = _local_3;
            label.setActualSize((_arg_1 - _local_3), measuredHeight);
            var _local_4:String = getStyle("verticalAlign");
            if (_local_4 == "top")
            {
                label.y = 0;
                if (icon)
                {
                    icon.y = 0;
                };
            }
            else
            {
                if (_local_4 == "bottom")
                {
                    label.y = ((_arg_2 - label.height) + 2);
                    if (icon)
                    {
                        icon.y = (_arg_2 - icon.height);
                    };
                }
                else
                {
                    label.y = ((_arg_2 - label.height) / 2);
                    if (icon)
                    {
                        icon.y = ((_arg_2 - icon.height) / 2);
                    };
                };
            };
            if (((data) && (parent)))
            {
                if (!enabled)
                {
                    _local_5 = getStyle("disabledColor");
                }
                else
                {
                    if (listOwner.isItemHighlighted(listData.uid))
                    {
                        _local_5 = getStyle("textRollOverColor");
                    }
                    else
                    {
                        if (listOwner.isItemSelected(listData.uid))
                        {
                            _local_5 = getStyle("textSelectedColor");
                        }
                        else
                        {
                            _local_5 = getStyle("color");
                        };
                    };
                };
                label.setColor(_local_5);
            };
        }


    }
}//package mx.controls.listClasses

