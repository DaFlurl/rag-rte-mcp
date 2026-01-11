// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.listClasses.TileListItemRenderer

package mx.controls.listClasses
{
    import mx.core.UIComponent;
    import mx.core.IDataRenderer;
    import mx.core.IFontContextComponent;
    import mx.core.IUITextField;
    import mx.core.IFlexDisplayObject;
    import mx.events.ToolTipEvent;
    import mx.core.IFlexModuleFactory;
    import flash.geom.Rectangle;
    import mx.events.InterManagerRequest;
    import mx.core.IToolTip;
    import mx.managers.ISystemManager;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import mx.events.FlexEvent;
    import mx.core.UITextField;
    import mx.core.FlexVersion;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class TileListItemRenderer extends UIComponent implements IDataRenderer, IDropInListItemRenderer, IListItemRenderer, IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        private var iconOnly:Boolean = false;
        private var _listData:ListData;
        private var _data:Object;
        protected var label:IUITextField;
        private var listOwner:TileBase;
        protected var icon:IFlexDisplayObject;
        private var iconClass:Class;

        public function TileListItemRenderer()
        {
            addEventListener(ToolTipEvent.TOOL_TIP_SHOW, toolTipShowHandler);
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_6:Number;
            var _local_9:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            var _local_3:Number = ((iconOnly) ? 0 : getStyle("verticalGap"));
            var _local_4:Number = getStyle("paddingLeft");
            var _local_5:Number = getStyle("paddingRight");
            if (icon)
            {
                icon.width = Math.min((_arg_1 - (_local_4 + _local_5)), icon.measuredWidth);
                icon.height = Math.min(Math.max(((_arg_2 - _local_3) - label.getExplicitOrMeasuredHeight()), 0), icon.measuredHeight);
                icon.x = (_local_4 + ((((_arg_1 - _local_4) - _local_5) - icon.width) / 2));
            };
            label.width = (_arg_1 - (_local_4 + _local_5));
            label.height = Math.min(label.getExplicitOrMeasuredHeight(), ((icon) ? Math.max(((_arg_2 - _local_3) - icon.height), 0) : _arg_2));
            label.x = _local_4;
            if (((listOwner) && (listOwner.showDataTips)))
            {
                if ((((label.textWidth > label.width) || ((listOwner.dataTipField) && (!(listOwner.dataTipField == "label")))) || (!(listOwner.dataTipFunction == null))))
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
            var _local_7:Number = label.height;
            if (icon)
            {
                _local_7 = (_local_7 + (icon.height + _local_3));
            };
            var _local_8:String = getStyle("verticalAlign");
            if (_local_8 == "top")
            {
                _local_6 = 0;
                if (icon)
                {
                    icon.y = _local_6;
                    _local_6 = (_local_6 + (_local_3 + icon.height));
                };
                label.y = _local_6;
            }
            else
            {
                if (_local_8 == "bottom")
                {
                    _local_6 = (_arg_2 - label.height);
                    label.y = _local_6;
                    if (icon)
                    {
                        _local_6 = (_local_6 - (_local_3 + icon.height));
                        icon.y = _local_6;
                    };
                }
                else
                {
                    _local_6 = ((_arg_2 - _local_7) / 2);
                    if (icon)
                    {
                        icon.y = _local_6;
                        _local_6 = (_local_6 + (_local_3 + icon.height));
                    };
                    label.y = _local_6;
                };
            };
            if (((data) && (parent)))
            {
                if (!enabled)
                {
                    _local_9 = getStyle("disabledColor");
                }
                else
                {
                    if (listOwner.isItemSelected(listData.uid))
                    {
                        _local_9 = getStyle("textSelectedColor");
                    }
                    else
                    {
                        if (listOwner.isItemHighlighted(listData.uid))
                        {
                            _local_9 = getStyle("textRollOverColor");
                        }
                        else
                        {
                            _local_9 = getStyle("color");
                        };
                    };
                };
                label.setColor(_local_9);
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

        mx_internal function getLabel():IUITextField
        {
            return (label);
        }

        public function set listData(_arg_1:BaseListData):void
        {
            _listData = ListData(_arg_1);
            invalidateProperties();
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            var _local_2:Class;
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(label == null))))
            {
                _local_1 = getChildIndex(DisplayObject(label));
                removeLabel();
                createLabel(_local_1);
            };
            if (((icon) && (!(_data))))
            {
                removeChild(DisplayObject(icon));
                icon = null;
                iconClass = null;
            };
            if (_data)
            {
                listOwner = TileBase(_listData.owner);
                if (_listData.icon)
                {
                    _local_2 = _listData.icon;
                    if (iconClass != _local_2)
                    {
                        iconClass = _local_2;
                        if (icon)
                        {
                            removeChild(DisplayObject(icon));
                        };
                        icon = new iconClass();
                        addChild(DisplayObject(icon));
                    };
                };
                label.text = _listData.label;
                label.multiline = listOwner.variableRowHeight;
                label.wordWrap = listOwner.wordWrap;
            }
            else
            {
                label.text = " ";
                toolTip = null;
            };
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
            invalidateProperties();
            dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
        }

        mx_internal function createLabel(_arg_1:int):void
        {
            if (!label)
            {
                label = IUITextField(createInFontContext(UITextField));
                label.styleName = this;
                if (_arg_1 == -1)
                {
                    addChild(DisplayObject(label));
                }
                else
                {
                    addChildAt(DisplayObject(label), _arg_1);
                };
            };
        }

        override public function get baselinePosition():Number
        {
            if (FlexVersion.compatibilityVersion < FlexVersion.VERSION_3_0)
            {
                super.baselinePosition;
            };
            if (!validateBaselinePosition())
            {
                return (NaN);
            };
            return (label.y + label.baselinePosition);
        }

        override protected function measure():void
        {
            var _local_2:Number;
            var _local_3:Number;
            super.measure();
            var _local_1:Number = 0;
            if (icon)
            {
                _local_1 = (_local_1 + icon.measuredHeight);
            };
            if ((((label.text == "") || (label.text == " ")) || (label.text == null)))
            {
                label.explicitHeight = 0;
                iconOnly = true;
            }
            else
            {
                label.explicitHeight = NaN;
                _local_1 = (_local_1 + getStyle("verticalGap"));
                iconOnly = false;
            };
            measuredHeight = (label.getExplicitOrMeasuredHeight() + _local_1);
            _local_2 = getStyle("paddingLeft");
            _local_3 = getStyle("paddingRight");
            measuredWidth = ((label.getExplicitOrMeasuredWidth() + _local_2) + _local_3);
            if (((icon) && (((icon.measuredWidth + _local_2) + _local_3) > measuredWidth)))
            {
                measuredWidth = ((icon.measuredWidth + _local_2) + _local_3);
            };
        }

        mx_internal function removeLabel():void
        {
            if (label)
            {
                removeChild(DisplayObject(label));
                label = null;
            };
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        override protected function createChildren():void
        {
            super.createChildren();
            createLabel(-1);
        }

        [Bindable("dataChange")]
        public function get listData():BaseListData
        {
            return (_listData);
        }

        [Bindable("dataChange")]
        public function get data():Object
        {
            return (_data);
        }


    }
}//package mx.controls.listClasses

