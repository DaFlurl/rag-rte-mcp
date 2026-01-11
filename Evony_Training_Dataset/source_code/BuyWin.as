// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.BuyWin

package view.module.shop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.ItemEum;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import com.evony.util.EvonyImage;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.Label;
    import mx.controls.Image;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import view.ui.AddFundWin;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import view.ui.DescribeTooltip;
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

    public class BuyWin extends Canvas implements IBindingClient 
    {

        private static var instancePopup:BuyWin = new (BuyWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1844090955_ItemEum:ItemEum;
        private var _891535336submit:Button;
        private var _109446num:TextInput;
        public var _BuyWin_EvonyImage1:EvonyImage;
        private var instance:ResponseDispatcher;
        public var _BuyWin_Label1:Label;
        public var _BuyWin_Label3:Label;
        public var _BuyWin_Label4:Label;
        public var _BuyWin_Label6:Label;
        public var _BuyWin_Label2:Label;
        private var _738344555iconFile:Image;
        private var _488962728wareName:Label;
        private var _3079825desc:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":450,
                    "height":340,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"desc",
                        "stylesFactory":function ():void
                        {
                            this.backgroundAlpha = 0;
                            this.left = "20";
                            this.right = "20";
                            this.top = "103";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":120,
                                "styleName":"ParamgraphText1",
                                "editable":false,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"submit",
                        "events":{"click":"__submit_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":279,
                                "styleName":"b95"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "228";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.bottom = "5";
                                        this.left = "5";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_BuyWin_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"PropertyName1"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_BuyWin_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"PropertyName1"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"num",
                                                            "events":{"enter":"__num_enter"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"1",
                                                                    "restrict":"0-9",
                                                                    "styleName":"textInput",
                                                                    "width":160,
                                                                    "maxChars":3
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.horizontalAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":50,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BuyWin_Label3",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyValue1"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_BuyWin_EvonyImage1",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"iconFile",
                        "events":{
                            "mouseOver":"__iconFile_mouseOver",
                            "mouseOut":"__iconFile_mouseOut",
                            "mouseMove":"__iconFile_mouseMove",
                            "complete":"__iconFile_complete"
                        },
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":64,
                                "height":64
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "89";
                            this.top = "33";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":57,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":0,
                                            "percentWidth":100,
                                            "height":23,
                                            "x":2,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_BuyWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({"type":VRule})]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":2,
                                            "y":31,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"wareName",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":20,
                                                        "styleName":"focusColor"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuyWin_Label6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___BuyWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
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

        public function BuyWin()
        {
            mx_internal::_document = this;
            this.width = 450;
            this.height = 340;
            this.addEventListener("creationComplete", ___BuyWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuyWin._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():BuyWin
        {
            return (instancePopup);
        }

        public static function show(_arg_1:ItemEum):void
        {
            if (!instancePopup.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instancePopup);
                MinePopupManager.instance.addPopup(instancePopup, MainFrame.instance, true);
                if ((Application.application.width - instancePopup.width) > 0)
                {
                    instancePopup.x = (((Application.application.width - instancePopup.width) / 2) - 150);
                    instancePopup.y = (((Application.application.height - instancePopup.height) / 2) - 30);
                    PopUpManager.bringToFront(instancePopup);
                }
                else
                {
                    PopUpManager.centerPopUp(instancePopup);
                };
            };
            instancePopup.num.setFocus();
            instancePopup._ItemEum = _arg_1;
            instancePopup.num.text = "";
            if (instancePopup._ItemEum.id == "player.key.silver")
            {
                instancePopup.desc.text = "You can use this key to open ANY chest in your Items inventory. The Silver Key is very fragile, and can only be used to open one chest before it breaks, so choose wisely!                                      (Time-Limited Offer)";
            };
        }


        public function __submit_click(_arg_1:MouseEvent):void
        {
            submitHandel();
        }

        private function _BuyWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._ItemEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                desc.text = _arg_1;
            }, "desc.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submit.label = _arg_1;
            }, "submit.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_Label1.text = _arg_1;
            }, "_BuyWin_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买总价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_Label2.text = _arg_1;
            }, "_BuyWin_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int((int(num.text) * _ItemEum.price));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_Label3.text = _arg_1;
            }, "_BuyWin_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int((int(num.text) * _ItemEum.price)) > 0);
            }, function (_arg_1:Boolean):void
            {
                _BuyWin_Label3.visible = _arg_1;
            }, "_BuyWin_Label3.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int((int(num.text) * _ItemEum.price)) > 0);
            }, function (_arg_1:Boolean):void
            {
                _BuyWin_Label3.includeInLayout = _arg_1;
            }, "_BuyWin_Label3.includeInLayout");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_EvonyImage1.toolTip = _arg_1;
            }, "_BuyWin_EvonyImage1.toolTip");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int((int(num.text) * _ItemEum.price)) > 0);
            }, function (_arg_1:Boolean):void
            {
                _BuyWin_EvonyImage1.visible = _arg_1;
            }, "_BuyWin_EvonyImage1.visible");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int((int(num.text) * _ItemEum.price)) > 0);
            }, function (_arg_1:Boolean):void
            {
                _BuyWin_EvonyImage1.includeInLayout = _arg_1;
            }, "_BuyWin_EvonyImage1.includeInLayout");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this._ItemEum.iconUrl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_Label4.text = _arg_1;
            }, "_BuyWin_Label4.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._ItemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                wareName.text = _arg_1;
            }, "wareName.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuyWin_Label6.text = _arg_1;
            }, "_BuyWin_Label6.text");
            result[13] = binding;
            return (result);
        }

        public function set num(_arg_1:TextInput):void
        {
            var _local_2:Object = this._109446num;
            if (_local_2 !== _arg_1)
            {
                this._109446num = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "num", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get num():TextInput
        {
            return (this._109446num);
        }

        private function submitHandel():void
        {
            if (num.text != "")
            {
                if (UIUtil.checkItem(this._ItemEum.id, 1))
                {
                    ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SHOP_BUY, shopBuyResponse, false, 0, true);
                    ActionFactory.getInstance().getShopCommands().buy(this._ItemEum.id, int(this.num.text));
                }
                else
                {
                    AddFundWin.show();
                };
            }
            else
            {
                AlertWin.show(Lang.msg("请填入购买数量"), null);
            };
        }

        private function shopBuyResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameBuy", "1", int((int(num.text) * _ItemEum.price)), this._ItemEum.id, this._ItemEum.name, this._ItemEum.itemType, this._ItemEum.price, int(num.text));
                };
            };
            onClose();
        }

        override public function initialize():void
        {
            var target:BuyWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuyWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_BuyWinWatcherSetupUtil");
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
        public function get desc():TextArea
        {
            return (this._3079825desc);
        }

        public function set desc(_arg_1:TextArea):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        private function set _ItemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._1844090955_ItemEum;
            if (_local_2 !== _arg_1)
            {
                this._1844090955_ItemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_ItemEum", _local_2, _arg_1));
            };
        }

        public function ___BuyWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get submit():Button
        {
            return (this._891535336submit);
        }

        public function init():void
        {
        }

        public function set submit(_arg_1:Button):void
        {
            var _local_2:Object = this._891535336submit;
            if (_local_2 !== _arg_1)
            {
                this._891535336submit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submit", _local_2, _arg_1));
            };
        }

        public function ___BuyWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get wareName():Label
        {
            return (this._488962728wareName);
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get _ItemEum():ItemEum
        {
            return (this._1844090955_ItemEum);
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function set wareName(_arg_1:Label):void
        {
            var _local_2:Object = this._488962728wareName;
            if (_local_2 !== _arg_1)
            {
                this._488962728wareName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wareName", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function _BuyWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._ItemEum.desc;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("购买数量");
            _local_1 = Lang.msg("购买总价");
            _local_1 = int((int(num.text) * _ItemEum.price));
            _local_1 = (int((int(num.text) * _ItemEum.price)) > 0);
            _local_1 = (int((int(num.text) * _ItemEum.price)) > 0);
            _local_1 = Lang.msg("铜币");
            _local_1 = (int((int(num.text) * _ItemEum.price)) > 0);
            _local_1 = (int((int(num.text) * _ItemEum.price)) > 0);
            _local_1 = this._ItemEum.iconUrl;
            _local_1 = Lang.msg("宝物");
            _local_1 = this._ItemEum.name;
            _local_1 = Lang.msg("购买宝物");
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        private function cancelHandel():void
        {
            PopUpManager.removePopUp(this);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(this._ItemEum.name, this._ItemEum.itemDesc, _arg_1);
        }

        private function checkItOut(_arg_1:Boolean):void
        {
        }

        public function __num_enter(_arg_1:FlexEvent):void
        {
            submitHandel();
        }


    }
}//package view.module.shop

