// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//mx.controls.alertClasses.AlertForm

package mx.controls.alertClasses
{
    import mx.core.UIComponent;
    import mx.core.IFontContextComponent;
    import flash.display.DisplayObject;
    import mx.core.IUITextField;
    import mx.controls.Button;
    import mx.core.IFlexModuleFactory;
    import mx.managers.ISystemManager;
    import mx.controls.Alert;
    import mx.managers.IFocusManagerContainer;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import flash.text.TextLineMetrics;
    import mx.core.UITextField;
    import flash.ui.Keyboard;
    import mx.events.CloseEvent;
    import mx.managers.PopUpManager;
    import mx.core.mx_internal; 

    use namespace mx_internal;

    public class AlertForm extends UIComponent implements IFontContextComponent 
    {

        mx_internal static const VERSION:String = "3.5.0.12683";

        mx_internal var buttons:Array = [];
        private var icon:DisplayObject;
        mx_internal var textField:IUITextField;
        mx_internal var defaultButton:Button;
        private var textWidth:Number;
        private var defaultButtonChanged:Boolean = false;
        private var textHeight:Number;

        public function AlertForm()
        {
            tabChildren = true;
        }

        override public function styleChanged(_arg_1:String):void
        {
            var _local_2:String;
            var _local_3:int;
            var _local_4:int;
            super.styleChanged(_arg_1);
            if ((((!(_arg_1)) || (_arg_1 == "styleName")) || (_arg_1 == "buttonStyleName")))
            {
                if (buttons)
                {
                    _local_2 = getStyle("buttonStyleName");
                    _local_3 = buttons.length;
                    _local_4 = 0;
                    while (_local_4 < _local_3)
                    {
                        buttons[_local_4].styleName = _local_2;
                        _local_4++;
                    };
                };
            };
        }

        public function set fontContext(_arg_1:IFlexModuleFactory):void
        {
            this.moduleFactory = _arg_1;
        }

        override protected function commitProperties():void
        {
            var _local_1:int;
            var _local_2:ISystemManager;
            super.commitProperties();
            if (((hasFontContextChanged()) && (!(textField == null))))
            {
                _local_1 = getChildIndex(DisplayObject(textField));
                removeTextField();
                createTextField(_local_1);
            };
            if (((defaultButtonChanged) && (defaultButton)))
            {
                defaultButtonChanged = false;
                Alert(parent).defaultButton = defaultButton;
                if ((parent is IFocusManagerContainer))
                {
                    _local_2 = Alert(parent).systemManager;
                    _local_2.activate(IFocusManagerContainer(parent));
                };
                defaultButton.setFocus();
            };
        }

        private function createButton(_arg_1:String, _arg_2:String):Button
        {
            var _local_3:Button = new Button();
            _local_3.label = _arg_1;
            _local_3.name = _arg_2;
            var _local_4:String = getStyle("buttonStyleName");
            if (_local_4)
            {
                _local_3.styleName = _local_4;
            };
            _local_3.addEventListener(MouseEvent.CLICK, clickHandler);
            _local_3.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
            _local_3.owner = parent;
            addChild(_local_3);
            _local_3.setActualSize(Alert.buttonWidth, Alert.buttonHeight);
            buttons.push(_local_3);
            return (_local_3);
        }

        override protected function resourcesChanged():void
        {
            var _local_1:Button;
            super.resourcesChanged();
            _local_1 = Button(getChildByName("OK"));
            if (_local_1)
            {
                _local_1.label = String(Alert.okLabel);
            };
            _local_1 = Button(getChildByName("CANCEL"));
            if (_local_1)
            {
                _local_1.label = String(Alert.cancelLabel);
            };
            _local_1 = Button(getChildByName("YES"));
            if (_local_1)
            {
                _local_1.label = String(Alert.yesLabel);
            };
            _local_1 = Button(getChildByName("NO"));
            if (_local_1)
            {
                _local_1.label = String(Alert.noLabel);
            };
        }

        override protected function createChildren():void
        {
            var _local_5:String;
            var _local_6:Button;
            super.createChildren();
            createTextField(-1);
            var _local_1:Class = Alert(parent).iconClass;
            if (((_local_1) && (!(icon))))
            {
                icon = new (_local_1)();
                addChild(icon);
            };
            var _local_2:Alert = Alert(parent);
            var _local_3:uint = _local_2.buttonFlags;
            var _local_4:uint = _local_2.defaultButtonFlag;
            if ((_local_3 & Alert.OK))
            {
                _local_5 = String(Alert.okLabel);
                _local_6 = createButton(_local_5, "OK");
                if (_local_4 == Alert.OK)
                {
                    defaultButton = _local_6;
                };
            };
            if ((_local_3 & Alert.YES))
            {
                _local_5 = String(Alert.yesLabel);
                _local_6 = createButton(_local_5, "YES");
                if (_local_4 == Alert.YES)
                {
                    defaultButton = _local_6;
                };
            };
            if ((_local_3 & Alert.NO))
            {
                _local_5 = String(Alert.noLabel);
                _local_6 = createButton(_local_5, "NO");
                if (_local_4 == Alert.NO)
                {
                    defaultButton = _local_6;
                };
            };
            if ((_local_3 & Alert.CANCEL))
            {
                _local_5 = String(Alert.cancelLabel);
                _local_6 = createButton(_local_5, "CANCEL");
                if (_local_4 == Alert.CANCEL)
                {
                    defaultButton = _local_6;
                };
            };
            if (((!(defaultButton)) && (buttons.length)))
            {
                defaultButton = buttons[0];
            };
            if (defaultButton)
            {
                defaultButtonChanged = true;
                invalidateProperties();
            };
        }

        override protected function measure():void
        {
            super.measure();
            var _local_1:String = Alert(parent).title;
            var _local_2:TextLineMetrics = Alert(parent).getTitleTextField().getUITextFormat().measureText(_local_1);
            var _local_3:int = Math.max(buttons.length, 2);
            var _local_4:Number = ((_local_3 * buttons[0].width) + ((_local_3 - 1) * 8));
            var _local_5:Number = Math.max(_local_4, _local_2.width);
            textField.width = (2 * _local_5);
            textWidth = (textField.textWidth + UITextField.TEXT_WIDTH_PADDING);
            var _local_6:Number = Math.max(_local_5, textWidth);
            _local_6 = Math.min(_local_6, (2 * _local_5));
            if (((textWidth < _local_6) && (textField.multiline == true)))
            {
                textField.multiline = false;
                textField.wordWrap = false;
            }
            else
            {
                if (textField.multiline == false)
                {
                    textField.wordWrap = true;
                    textField.multiline = true;
                };
            };
            _local_6 = (_local_6 + 16);
            if (icon)
            {
                _local_6 = (_local_6 + (icon.width + 8));
            };
            textHeight = (textField.textHeight + UITextField.TEXT_HEIGHT_PADDING);
            var _local_7:Number = textHeight;
            if (icon)
            {
                _local_7 = Math.max(_local_7, icon.height);
            };
            _local_7 = Math.min(_local_7, (screen.height * 0.75));
            _local_7 = (_local_7 + (buttons[0].height + (3 * 8)));
            measuredWidth = _local_6;
            measuredHeight = _local_7;
        }

        public function get fontContext():IFlexModuleFactory
        {
            return (moduleFactory);
        }

        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:String = Button(_arg_1.currentTarget).name;
            removeAlert(_local_2);
        }

        mx_internal function removeTextField():void
        {
            if (textField)
            {
                removeChild(DisplayObject(textField));
                textField = null;
            };
        }

        override protected function keyDownHandler(_arg_1:KeyboardEvent):void
        {
            var _local_2:uint = Alert(parent).buttonFlags;
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                if (((_local_2 & Alert.CANCEL) || (!(_local_2 & Alert.NO))))
                {
                    removeAlert("CANCEL");
                }
                else
                {
                    if ((_local_2 & Alert.NO))
                    {
                        removeAlert("NO");
                    };
                };
            };
        }

        mx_internal function createTextField(_arg_1:int):void
        {
            if (!textField)
            {
                textField = IUITextField(createInFontContext(UITextField));
                textField.styleName = this;
                textField.text = Alert(parent).text;
                textField.multiline = true;
                textField.wordWrap = true;
                textField.selectable = true;
                if (_arg_1 == -1)
                {
                    addChild(DisplayObject(textField));
                }
                else
                {
                    addChildAt(DisplayObject(textField), _arg_1);
                };
            };
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            super.updateDisplayList(_arg_1, _arg_2);
            _local_4 = (_arg_2 - buttons[0].height);
            _local_5 = ((buttons.length * (buttons[0].width + 8)) - 8);
            _local_3 = ((_arg_1 - _local_5) / 2);
            var _local_6:int;
            while (_local_6 < buttons.length)
            {
                buttons[_local_6].move(_local_3, _local_4);
                buttons[_local_6].tabIndex = (_local_6 + 1);
                _local_3 = (_local_3 + (buttons[_local_6].width + 8));
                _local_6++;
            };
            _local_5 = textWidth;
            if (icon)
            {
                _local_5 = (_local_5 + (icon.width + 8));
            };
            _local_3 = ((_arg_1 - _local_5) / 2);
            if (icon)
            {
                icon.x = _local_3;
                icon.y = ((_local_4 - icon.height) / 2);
                _local_3 = (_local_3 + (icon.width + 8));
            };
            var _local_7:Number = textField.getExplicitOrMeasuredHeight();
            textField.move(_local_3, ((_local_4 - _local_7) / 2));
            textField.setActualSize((textWidth + 5), _local_7);
        }

        private function removeAlert(_arg_1:String):void
        {
            var _local_2:Alert = Alert(parent);
            _local_2.visible = false;
            var _local_3:CloseEvent = new CloseEvent(CloseEvent.CLOSE);
            if (_arg_1 == "YES")
            {
                _local_3.detail = Alert.YES;
            }
            else
            {
                if (_arg_1 == "NO")
                {
                    _local_3.detail = Alert.NO;
                }
                else
                {
                    if (_arg_1 == "OK")
                    {
                        _local_3.detail = Alert.OK;
                    }
                    else
                    {
                        if (_arg_1 == "CANCEL")
                        {
                            _local_3.detail = Alert.CANCEL;
                        };
                    };
                };
            };
            _local_2.dispatchEvent(_local_3);
            PopUpManager.removePopUp(_local_2);
        }


    }
}//package mx.controls.alertClasses

