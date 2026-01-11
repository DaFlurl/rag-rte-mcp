// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.NumberRegulate

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.Event;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class NumberRegulate extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1074075990minBtn:Button;
        public var dis:Number;
        public var onValueChange:Function;
        private var _1460037496currentValue:int;
        public var valueMax:int;
        private var _1081166248maxBtn:Button;
        public var onDataChange:Function;
        private var _358134206buttonFlag:int = 0;
        public var type:int;
        private var _1303569266preValue:int;
        public var isProduce:Boolean;
        private var _1474385094txtInput:TextInput;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":76,
                    "height":25,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                            this.horizontalGap = 0;
                            this.horizontalAlign = "center";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"txtInput",
                                    "events":{"change":"__txtInput_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":56,
                                            "height":20,
                                            "restrict":"0-9",
                                            "styleName":"textInput"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 0;
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"maxBtn",
                                                "events":{"mouseDown":"__maxBtn_mouseDown"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"numericStepperUpBtn",
                                                        "width":20,
                                                        "height":10
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"minBtn",
                                                "events":{"mouseDown":"__minBtn_mouseDown"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"numericStepperDownBtn",
                                                        "width":20,
                                                        "height":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NumberRegulate()
        {
            mx_internal::_document = this;
            this.width = 76;
            this.height = 25;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NumberRegulate._watcherSetupUtil = _arg_1;
        }


        public function __minBtn_mouseDown(_arg_1:MouseEvent):void
        {
            onBtnSwitch(_arg_1);
        }

        public function set txtInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1474385094txtInput;
            if (_local_2 !== _arg_1)
            {
                this._1474385094txtInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "txtInput", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:NumberRegulate;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NumberRegulate_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_NumberRegulateWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        private function onBtnSwitch(_arg_1:MouseEvent):void
        {
            if (Button(_arg_1.target).id == "maxBtn")
            {
                if (this.valueMax >= 0)
                {
                    this.txtInput.text = String(this.valueMax);
                    this.currentValue = this.valueMax;
                }
                else
                {
                    this.txtInput.text = "0";
                    this.currentValue = 0;
                };
            }
            else
            {
                if (Button(_arg_1.target).id == "minBtn")
                {
                    this.txtInput.text = "0";
                    this.currentValue = 0;
                };
            };
            this.preValue = this.currentValue;
            if (this.onDataChange != null)
            {
                this.onDataChange.apply(this, [this.currentValue]);
            };
            if (this.onValueChange != null)
            {
                this.onValueChange.call(this, this.currentValue, type, this.dis);
            };
        }

        [Bindable(event="propertyChange")]
        public function get preValue():int
        {
            return (this._1303569266preValue);
        }

        public function __maxBtn_mouseDown(_arg_1:MouseEvent):void
        {
            onBtnSwitch(_arg_1);
        }

        public function set preValue(_arg_1:int):void
        {
            var _local_2:Object = this._1303569266preValue;
            if (_local_2 !== _arg_1)
            {
                this._1303569266preValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "preValue", _local_2, _arg_1));
            };
        }

        private function _NumberRegulate_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (buttonFlag == 1);
            _local_1 = (buttonFlag == 2);
        }

        [Bindable(event="propertyChange")]
        public function get minBtn():Button
        {
            return (this._1074075990minBtn);
        }

        public function set maxBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1081166248maxBtn;
            if (_local_2 !== _arg_1)
            {
                this._1081166248maxBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buttonFlag():int
        {
            return (this._358134206buttonFlag);
        }

        public function set valueInit(_arg_1:int):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get txtInput():TextInput
        {
            return (this._1474385094txtInput);
        }

        public function set minBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1074075990minBtn;
            if (_local_2 !== _arg_1)
            {
                this._1074075990minBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get maxBtn():Button
        {
            return (this._1081166248maxBtn);
        }

        public function refresh():void
        {
            this.txtInput.text = "0";
            this.currentValue = 0;
            this.preValue = 0;
            if (this.onDataChange != null)
            {
                this.onDataChange.apply(this, [0]);
            };
            if (this.onValueChange != null)
            {
                this.onValueChange.call(this, this.currentValue, type, this.dis);
            };
        }

        public function set value(_arg_1:int):void
        {
            this.txtInput.text = _arg_1.toString();
            if (_arg_1 != this.currentValue)
            {
                onChange();
            };
        }

        public function set currentValue(_arg_1:int):void
        {
            var _local_2:Object = this._1460037496currentValue;
            if (_local_2 !== _arg_1)
            {
                this._1460037496currentValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentValue", _local_2, _arg_1));
            };
        }

        public function set myText(_arg_1:String):void
        {
            this.txtInput.text = _arg_1;
        }

        public function __txtInput_change(_arg_1:Event):void
        {
            onChange();
        }

        [Bindable(event="propertyChange")]
        public function get currentValue():int
        {
            return (this._1460037496currentValue);
        }

        public function get myText():String
        {
            return (this.txtInput.text);
        }

        public function set buttonFlag(_arg_1:int):void
        {
            var _local_2:Object = this._358134206buttonFlag;
            if (_local_2 !== _arg_1)
            {
                this._358134206buttonFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonFlag", _local_2, _arg_1));
            };
        }

        private function onChange():void
        {
            if (((int(this.txtInput.text) > this.valueMax) && (isProduce == true)))
            {
                this.currentValue = this.valueMax;
                this.txtInput.text = String(this.valueMax);
            }
            else
            {
                this.currentValue = int(this.txtInput.text);
            };
            this.preValue = this.currentValue;
            if (this.onDataChange != null)
            {
                this.onDataChange.apply(this, [this.currentValue]);
            };
            if (this.onValueChange != null)
            {
                this.onValueChange.call(this, this.currentValue, type, this.dis);
            };
        }

        private function _NumberRegulate_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (buttonFlag == 1);
            }, function (_arg_1:Boolean):void
            {
                maxBtn.enabled = _arg_1;
            }, "maxBtn.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (buttonFlag == 2);
            }, function (_arg_1:Boolean):void
            {
                minBtn.enabled = _arg_1;
            }, "minBtn.enabled");
            result[1] = binding;
            return (result);
        }


    }
}//package view.ui

