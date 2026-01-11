// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AmountInputUI

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Button;
    import view.module.guide.GuideArrow;
    import mx.controls.Label;
    import com.evony.eum.ItemEum;
    import view.module.market.WalletShowAll;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.Context;
    import view.module.guide.GuideStep;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import mx.collections.ArrayCollection;
    import view.module.playerInfo.UseGoodWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import view.module.shop.Turntable;
    import com.evony.common.module.shop.UseItemResultResponse;
    import com.evony.eum.ItemEumDefine;
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

    public class AmountInputUI extends Canvas implements IBindingClient 
    {

        public static var instance:AmountInputUI = new (AmountInputUI)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _100358090input:NumberInput;
        public var _AmountInputUI_Text1:Text;
        private var itemId:String = "player.box.gambling.3";
        private var isTurn:Boolean;
        private var _348630820submitBtn:Button;
        private var itemAmount:int;
        public var _AmountInputUI_GuideArrow1:GuideArrow;
        public var _AmountInputUI_Label1:Label;
        public var _AmountInputUI_Label2:Label;
        public var _AmountInputUI_Label3:Label;
        private var _2116180394itemEum:ItemEum;
        private var _1948316758initNum:String = "1";
        public var _AmountInputUI_WalletShowAll1:WalletShowAll;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":450,
                    "height":280,
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
                                    "id":"_AmountInputUI_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AmountInputUI_Label2",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "70";
                            this.left = "50";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ParamgraphText1",
                                "width":177
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":NumberInput,
                        "id":"input",
                        "events":{"change":"__input_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.bottom = "70";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":80,
                                "maxChars":3,
                                "x":217
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"submitBtn",
                        "events":{"mouseDown":"__submitBtn_mouseDown"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "70";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"_AmountInputUI_Text1",
                        "stylesFactory":function ():void
                        {
                            this.top = "82";
                            this.left = "50";
                            this.right = "50";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ParamgraphText1",
                                "height":100,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "27";
                            this.left = "50";
                            this.horizontalGap = 0;
                            this.horizontalAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AmountInputUI_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WalletShowAll,
                                    "id":"_AmountInputUI_WalletShowAll1"
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AmountInputUI_Button2_click"},
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
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_AmountInputUI_GuideArrow1",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "83";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AmountInputUI()
        {
            mx_internal::_document = this;
            this.width = 450;
            this.height = 280;
            this.addEventListener("creationComplete", ___AmountInputUI_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AmountInputUI._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
                PopUpManager.bringToFront(instance);
            };
            if (!ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.SHOP_USE_GOODS))
            {
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SHOP_USE_GOODS, instance.useGoodsResponse);
            };
            instance.isTurn = false;
            instance.initNum = "1";
            trace(instance.initialized);
        }


        public function ___AmountInputUI_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        override public function initialize():void
        {
            var target:AmountInputUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AmountInputUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_AmountInputUIWatcherSetupUtil");
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

        public function set input(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._100358090input;
            if (_local_2 !== _arg_1)
            {
                this._100358090input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input", _local_2, _arg_1));
            };
        }

        private function _AmountInputUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AmountInputUI_Label1.text = _arg_1;
            }, "_AmountInputUI_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请输入使用数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AmountInputUI_Label2.text = _arg_1;
            }, "_AmountInputUI_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.initNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                input.text = _arg_1;
            }, "input.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用物品");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用轮盘提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AmountInputUI_Text1.text = _arg_1;
            }, "_AmountInputUI_Text1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("帐户") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AmountInputUI_Label3.text = _arg_1;
            }, "_AmountInputUI_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (Context.getInstance().getPlayerBean().playerInfo.medal);
            }, function (_arg_1:int):void
            {
                _AmountInputUI_WalletShowAll1.medal = _arg_1;
            }, "_AmountInputUI_WalletShowAll1.medal");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 130);
            }, function (_arg_1:Boolean):void
            {
                _AmountInputUI_GuideArrow1.includeInLayout = _arg_1;
            }, "_AmountInputUI_GuideArrow1.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 130);
            }, function (_arg_1:Boolean):void
            {
                _AmountInputUI_GuideArrow1.visible = _arg_1;
            }, "_AmountInputUI_GuideArrow1.visible");
            result[8] = binding;
            return (result);
        }

        private function _AmountInputUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemEum.name;
            _local_1 = Lang.msg("请输入使用数量");
            _local_1 = this.initNum;
            _local_1 = Lang.msg("使用物品");
            _local_1 = Lang.msg("使用轮盘提示");
            _local_1 = (Lang.msg("帐户") + ": ");
            _local_1 = Context.getInstance().getPlayerBean().playerInfo.medal;
            _local_1 = (GuideStep.getInstance().currentStep == 130);
            _local_1 = (GuideStep.getInstance().currentStep == 130);
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        public function ___AmountInputUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function openAddMoneyUrl():void
        {
            var _local_1:int = Context.getInstance().getPlayerBean().playerInfo.medal;
            getItemAmount();
            if ((this.itemAmount + int((_local_1 / 5))) <= 0)
            {
                PopUpManager.removePopUp(this);
                AddFundWin.show();
                return;
            };
            if (int(this.input.text) > (this.itemAmount + int((_local_1 / 5))))
            {
                this.input.text = String((this.itemAmount + int((_local_1 / 5))));
            };
        }

        private function init():void
        {
            getItemAmount();
            getItemEum();
        }

        private function setValue(_arg_1:Event):void
        {
            trace("请输入数字");
            this.openAddMoneyUrl();
            if (int(this.input.text) < 1)
            {
                AlertWin.show(Lang.msg("请至少输入一个"));
                input.text = "1";
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemEum():ItemEum
        {
            return (this._2116180394itemEum);
        }

        public function __submitBtn_mouseDown(_arg_1:MouseEvent):void
        {
            useChest(_arg_1);
        }

        public function __input_change(_arg_1:Event):void
        {
            setValue(_arg_1);
        }

        private function getItemAmount():void
        {
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().itemsArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (_local_1.getItemAt(_local_2).id == itemId)
                {
                    this.itemAmount = _local_1.getItemAt(_local_2).count;
                };
                _local_2++;
            };
        }

        public function set submitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._348630820submitBtn;
            if (_local_2 !== _arg_1)
            {
                this._348630820submitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submitBtn", _local_2, _arg_1));
            };
        }

        private function set initNum(_arg_1:String):void
        {
            var _local_2:Object = this._1948316758initNum;
            if (_local_2 !== _arg_1)
            {
                this._1948316758initNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "initNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input():NumberInput
        {
            return (this._100358090input);
        }

        private function set itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
            };
        }

        public function removeListener():void
        {
            if (((isTurn == true) && (ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.SHOP_USE_GOODS) == true)))
            {
                ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SHOP_USE_GOODS, useGoodsResponse);
            };
        }

        private function useChest(_arg_1:MouseEvent):void
        {
            isTurn = true;
            UseGoodWin.getInstance().turnAmount = int(this.input.text);
            UseGoodWin.getInstance()._itemEum = itemId;
            var _local_2:String = UIUtil.checkItemAmulet();
            if (_local_2 != null)
            {
                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, _local_2, 1);
                if (Context.getInstance().needUserGuide)
                {
                    if (GuideStep.getInstance().currentStep == 130)
                    {
                        GuideStep.getInstance().step130();
                    };
                };
            }
            else
            {
                AddFundWin.show();
            };
            this.close();
        }

        [Bindable(event="propertyChange")]
        private function get initNum():String
        {
            return (this._1948316758initNum);
        }

        private function useGoodsResponse(_arg_1:UseItemResultResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", itemId, "Amulet", "宝箱", 5);
                };
                if (((!(_arg_1.gamblingItemsBeansArray == null)) && (_arg_1.gamblingItemsBeansArray.length > 0)))
                {
                    Turntable.turntableShow(_arg_1);
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function getItemEum():void
        {
            this.itemEum = ItemEumDefine.getItemEum(itemId);
        }

        private function close():void
        {
            if (((isTurn == false) && (ResponseDispatcher.getInstance().hasEventListener(ResponseDispatcher.SHOP_USE_GOODS) == true)))
            {
                ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SHOP_USE_GOODS, useGoodsResponse);
            };
            PopUpManager.removePopUp(this);
        }


    }
}//package view.ui

