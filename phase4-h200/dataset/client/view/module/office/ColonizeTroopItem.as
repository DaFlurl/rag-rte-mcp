// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.ColonizeTroopItem

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
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

    public class ColonizeTroopItem extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1074075990minBtn:Button;
        private var _109446num:int = 100;
        public var _ColonizeTroopItem_Label1:Label;
        private var _1825295072baseValue:int;
        private var _339147856showItem:Boolean = false;
        private var _1460037496currentValue:int;
        private var _331737559addHandle:Boolean;
        private var _1081166248maxBtn:Button;
        private var _1177331774itemName:String;
        private var valueMax:int = 100;
        private var _1474385094txtInput:TextInput;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":300,
                    "height":22,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":180,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ColonizeTroopItem_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.left = "30";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"tableContent1",
                                                        "width":150,
                                                        "percentHeight":100
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":120,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"txtInput",
                                                "events":{"change":"__txtInput_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                    this.left = "22";
                                                    this.fontWeight = "normal";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "maxChars":3,
                                                        "styleName":"textInput",
                                                        "width":40
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "62";
                                                    this.textAlign = "center";
                                                    this.color = 5312268;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"%",
                                                        "styleName":"PropertyValue1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.verticalAlign = "middle";
                                                    this.right = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
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
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonizeTroopItem()
        {
            mx_internal::_document = this;
            this.width = 300;
            this.height = 22;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonizeTroopItem._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get num():int
        {
            return (this._109446num);
        }

        public function set num(_arg_1:int):void
        {
            var _local_2:Object = this._109446num;
            if (_local_2 !== _arg_1)
            {
                this._109446num = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ColonizeTroopItem;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonizeTroopItem_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_ColonizeTroopItemWatcherSetupUtil");
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
                if (this.currentValue < this.valueMax)
                {
                    this.currentValue++;
                    this.txtInput.text = String(this.currentValue);
                };
            }
            else
            {
                if (Button(_arg_1.target).id == "minBtn")
                {
                    if (this.currentValue > 0)
                    {
                        this.currentValue--;
                        this.txtInput.text = String(this.currentValue);
                    };
                };
            };
        }

        public function __maxBtn_mouseDown(_arg_1:MouseEvent):void
        {
            onBtnSwitch(_arg_1);
        }

        private function _ColonizeTroopItem_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ColonizeTroopItem_Label1.text = _arg_1;
            }, "_ColonizeTroopItem_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = num;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                txtInput.text = _arg_1;
            }, "txtInput.text");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get baseValue():int
        {
            return (this._1825295072baseValue);
        }

        [Bindable(event="propertyChange")]
        public function get addHandle():Boolean
        {
            return (this._331737559addHandle);
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
        public function get showItem():Boolean
        {
            return (this._339147856showItem);
        }

        [Bindable(event="propertyChange")]
        public function get txtInput():TextInput
        {
            return (this._1474385094txtInput);
        }

        [Bindable(event="propertyChange")]
        public function get itemName():String
        {
            return (this._1177331774itemName);
        }

        private function _ColonizeTroopItem_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemName;
            _local_1 = num;
        }

        public function set baseValue(_arg_1:int):void
        {
            var _local_2:Object = this._1825295072baseValue;
            if (_local_2 !== _arg_1)
            {
                this._1825295072baseValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "baseValue", _local_2, _arg_1));
            };
        }

        public function set addHandle(_arg_1:Boolean):void
        {
            var _local_2:Object = this._331737559addHandle;
            if (_local_2 !== _arg_1)
            {
                this._331737559addHandle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addHandle", _local_2, _arg_1));
            };
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

        public function set showItem(_arg_1:Boolean):void
        {
            var _local_2:Object = this._339147856showItem;
            if (_local_2 !== _arg_1)
            {
                this._339147856showItem = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showItem", _local_2, _arg_1));
            };
        }

        public function set baseNum(_arg_1:int):void
        {
            this.baseValue = _arg_1;
            this.txtInput.text = String(_arg_1);
        }

        private function onChange():void
        {
            if (int(this.txtInput.text) > this.valueMax)
            {
                this.currentValue = this.valueMax;
                this.txtInput.text = String(this.valueMax);
            }
            else
            {
                this.currentValue = int(this.txtInput.text);
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

        public function __txtInput_change(_arg_1:Event):void
        {
            onChange();
        }

        [Bindable(event="propertyChange")]
        public function get currentValue():int
        {
            return (this._1460037496currentValue);
        }

        public function set itemName(_arg_1:String):void
        {
            var _local_2:Object = this._1177331774itemName;
            if (_local_2 !== _arg_1)
            {
                this._1177331774itemName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemName", _local_2, _arg_1));
            };
        }


    }
}//package view.module.office

