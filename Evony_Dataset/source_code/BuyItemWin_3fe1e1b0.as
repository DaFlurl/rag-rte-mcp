// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Items.BuyItemWin

package autoevony.gui.info.Items
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.core.mx_internal;
    import autoevony.common.Utils;
    import mx.controls.TextInput;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.gui.MainScreen;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class BuyItemWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _327260383_useBtnArea:HBox;
        public var _BuyItemWin_Label2:Label;
        private var _344839367_closeWinBtn:Button;
        private var onBuyItem:Function = null;
        private var _1177034077itemData:ObjectProxy = null;
        private var closeFunc:Function = null;
        private var _957284175_buyCountInput1:ItemCountInput;
        private var _1330884373_buyBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":115,
                    "width":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Buy Items"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":115,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "15";
                                        this.top = "50";
                                        this.right = "15";
                                        this.bottom = "15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "5";
                                                    this.bottom = "5";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":245,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"How many to buy?",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ItemCountInput,
                                                            "id":"_buyCountInput1"
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "260";
                                                    this.top = "5";
                                                    this.right = "80";
                                                    this.bottom = "5";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "left";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_BuyItemWin_Label2",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"newArmyTroop"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_useBtnArea",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":70,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_buyBtn",
                                                            "events":{"click":"___buyBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Buy",
                                                                    "styleName":"REwinBtn"
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
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_closeWinBtn",
                        "events":{"click":"___closeWinBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuyItemWin()
        {
            mx_internal::_document = this;
            this.height = 115;
            this.width = 500;
            this.addEventListener("creationComplete", this.___BuyItemWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuyItemWin._watcherSetupUtil = _arg_1;
        }


        private function init():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get _buyBtn():Button
        {
            return (this._1330884373_buyBtn);
        }

        private function _BuyItemWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this;
            _local_1 = this.enableBuyBtn(this.itemData.price);
            _local_1 = (("  Cost: " + Utils.formatInt((this.itemData.price * int(this._buyCountInput1._useCountInput.text)))) + " cents");
            _local_1 = ((this.enableBuyBtn(this.itemData.price)) && (int(this._buyCountInput1._useCountInput.text) >= 1));
        }

        public function updateInfo(_arg_1:Array, _arg_2:Function):void
        {
            this.itemData = _arg_1[0];
            this.onBuyItem = _arg_1[1];
            this.closeFunc = _arg_2;
        }

        private function moveCursorToEnd(txtCtrl:TextInput):void
        {
            Utils.callLater(50, function ():void
            {
                var _local_1:int = txtCtrl.text.length;
                if (((!(txtCtrl.selectionEndIndex == _local_1)) || (!(txtCtrl.selectionBeginIndex == _local_1))))
                {
                    txtCtrl.selectionEndIndex = (txtCtrl.selectionBeginIndex = _local_1);
                };
            });
        }

        public function set _buyCountInput1(_arg_1:ItemCountInput):void
        {
            var _local_2:Object = this._957284175_buyCountInput1;
            if (_local_2 !== _arg_1)
            {
                this._957284175_buyCountInput1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_buyCountInput1", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:BuyItemWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._BuyItemWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_BuyItemWinWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get _useBtnArea():HBox
        {
            return (this._327260383_useBtnArea);
        }

        internal function onMaxBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + Math.floor((MainScreen.getPlayer().playerInfo.medal / this.itemData.price)));
            _arg_1.setFocus();
            this.moveCursorToEnd(_arg_1);
        }

        public function set _buyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1330884373_buyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1330884373_buyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_buyBtn", _local_2, _arg_1));
            };
        }

        private function _BuyItemWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (this);
            }, function (_arg_1:*):void
            {
                _buyCountInput1.parentWin = _arg_1;
            }, "_buyCountInput1.parentWin");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.enableBuyBtn(this.itemData.price));
            }, function (_arg_1:Boolean):void
            {
                _buyCountInput1.enabled = _arg_1;
            }, "_buyCountInput1.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("  Cost: " + Utils.formatInt((this.itemData.price * int(_buyCountInput1._useCountInput.text)))) + " cents");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyItemWin_Label2.text = _arg_1;
            }, "_BuyItemWin_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.enableBuyBtn(this.itemData.price)) && (int(_buyCountInput1._useCountInput.text) >= 1));
            }, function (_arg_1:Boolean):void
            {
                _buyBtn.enabled = _arg_1;
            }, "_buyBtn.enabled");
            result[3] = binding;
            return (result);
        }

        private function onBuyBtn():void
        {
            this._buyBtn.enabled = false;
            if (int(this._buyCountInput1._useCountInput.text) < 1)
            {
                return;
            };
            this._closeWinBtn.enabled = false;
            Utils.callLater(1500, this.close);
            this.onBuyItem.apply(null, [int(this._buyCountInput1._useCountInput.text)]);
        }

        [Bindable(event="propertyChange")]
        public function get _closeWinBtn():Button
        {
            return (this._344839367_closeWinBtn);
        }

        private function set itemData(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1177034077itemData;
            if (_local_2 !== _arg_1)
            {
                this._1177034077itemData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemData", _local_2, _arg_1));
            };
        }

        public function set _useBtnArea(_arg_1:HBox):void
        {
            var _local_2:Object = this._327260383_useBtnArea;
            if (_local_2 !== _arg_1)
            {
                this._327260383_useBtnArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useBtnArea", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _buyCountInput1():ItemCountInput
        {
            return (this._957284175_buyCountInput1);
        }

        internal function onUseCountChange(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + int(_arg_1.text));
            if (int(_arg_1.text) == 0)
            {
                if ((MainScreen.getPlayer().playerInfo.medal - this.itemData.price) >= 0)
                {
                    _arg_1.text = ("" + 1);
                };
                this.moveCursorToEnd(_arg_1);
            }
            else
            {
                if (int(_arg_1.text) < 0)
                {
                    this.onMinBtn(_arg_1);
                }
                else
                {
                    if (int(_arg_1.text) > Math.floor((MainScreen.getPlayer().playerInfo.medal / this.itemData.price)))
                    {
                        _arg_1.text = ("" + Math.floor((MainScreen.getPlayer().playerInfo.medal / this.itemData.price)));
                    };
                };
            };
        }

        private function enableBuyBtn(_arg_1:int):Boolean
        {
            return ((MainScreen.getPlayer().playerInfo.medal - _arg_1) >= 0);
        }

        [Bindable(event="propertyChange")]
        private function get itemData():ObjectProxy
        {
            return (this._1177034077itemData);
        }

        public function ___BuyItemWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        internal function onMinBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + (((MainScreen.getPlayer().playerInfo.medal - this.itemData.price) >= 0) ? 1 : 0));
            _arg_1.setFocus();
            this.moveCursorToEnd(_arg_1);
        }

        public function ___closeWinBtn_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        public function set _closeWinBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._344839367_closeWinBtn;
            if (_local_2 !== _arg_1)
            {
                this._344839367_closeWinBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_closeWinBtn", _local_2, _arg_1));
            };
        }

        private function close():void
        {
            this.itemData = null;
            this.onBuyItem = null;
            this.closeFunc.apply(null, [this]);
        }

        public function ___buyBtn_click(_arg_1:MouseEvent):void
        {
            this.onBuyBtn();
        }


    }
}//package autoevony.gui.info.Items

