// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.MyTreasure

package view.module.playerInfo
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import view.module.guide.GuideArrow;
    import mx.controls.ToggleButtonBar;
    import view.module.market.WalletShowAll;
    import mx.containers.ViewStack;
    import mx.containers.Tile;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import com.evony.common.beans.PlayerBean;
    import com.evony.Context;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PackageBean;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.common.GetPackageListResponse;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import flash.events.MouseEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.constants.CommonConstants;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.ItemClickEvent;
    import view.AllWindows;
    import view.module.shop.ShopWin;
    import view.ui.AddFundWin;
    import com.evony.common.beans.ItemBean;
    import com.evony.util.UIUtil;
    import com.evony.common.module.common.ChatResponse;
    import mx.events.FlexEvent;
    import com.evony.Lang;
    import view.module.guide.GuideStep;
    import view.module.accouter.ControlUI;
    import mx.binding.BindingManager;
    import flash.external.ExternalInterface;
    import view.module.shop.Turntable;
    import com.evony.common.constants.ErrorCode;
    import view.ui.AlertWin;
    import com.evony.common.module.shop.UseItemResultResponse;
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

    public class MyTreasure extends BaseFunctionWindow implements IBindingClient 
    {

        public static var instance:MyTreasure;
        public static const EVENT_SHOW:String = "MyTreasureWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _MyTreasure_Label1:Label;
        public var _MyTreasure_Button1:Button;
        public var _MyTreasure_Button2:Button;
        public var _MyTreasure_Button3:Button;
        private var _1899113898packageGuide:GuideArrow;
        private var _11548545buttonBar:ToggleButtonBar;
        public var _MyTreasure_WalletShowAll1:WalletShowAll;
        private var _1633607230AccoutCount:uint = 0;
        private var curShowType:String;
        public var _MyTreasure_Array1:Array;
        public var _MyTreasure_GuideArrow2:GuideArrow;
        private var _577409037totalPage:int;
        private var strPackageId:String = "";
        private var _1125923055curPage:int = 1;
        private var _717414672itemViewStack:ViewStack;
        private var curShowAcoutType:int;
        private var _1084694894treasureContainer:Tile;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"itemViewStack",
                        "stylesFactory":function ():void
                        {
                            this.left = "35";
                            this.bottom = "65";
                            this.top = "85";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":750,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Tile,
                                    "id":"treasureContainer",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 6;
                                        this.verticalGap = 19;
                                        this.top = "19";
                                        this.left = "2";
                                        this.right = "5";
                                        this.bottom = "5";
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"greyBackground"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                            this.bottom = "17";
                            this.right = "35";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MyTreasure_Button1",
                                    "events":{"click":"___MyTreasure_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Earn Coins",
                                            "styleName":"y125"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MyTreasure_Button2",
                                    "events":{"click":"___MyTreasure_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MyTreasure_Button3",
                                    "events":{"click":"___MyTreasure_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"buttonBar",
                        "events":{"itemClick":"__buttonBar_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "35";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":750,
                                "dataProvider":_MyTreasure_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.left = "40";
                            this.horizontalGap = 0;
                            this.horizontalAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MyTreasure_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WalletShowAll,
                                    "id":"_MyTreasure_WalletShowAll1"
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"packageGuide",
                        "stylesFactory":function ():void
                        {
                            this.top = "66";
                            this.left = "395";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_MyTreasure_GuideArrow2",
                        "stylesFactory":function ():void
                        {
                            this.top = "187";
                            this.left = "209";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    })]});
            }
        });
        private var _985752863player:PlayerBean = Context.getInstance().getPlayerBean();
        private var uiCache:UICache = new UICache(450);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MyTreasure()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___MyTreasure_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___MyTreasure_BaseFunctionWindow1_removedFromStage);
            this.addEventListener("mouseDown", ___MyTreasure_BaseFunctionWindow1_mouseDown);
        }

        public static function packgetListRosponse(_arg_1:GetPackageListResponse):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            var _local_4:int;
            var _local_5:PackageBean;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = _arg_1.packagesArray;
                _local_3 = 0;
                while (_local_4 < _local_2.length)
                {
                    _local_5 = (_local_2[_local_4] as PackageBean);
                    if (((_local_5.packageName == "Bonus Package 2") && (_local_5.status <= 3)))
                    {
                        _local_3 = 1;
                    };
                    _local_4++;
                };
            }
            else
            {
                _local_2 = null;
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MyTreasure._watcherSetupUtil = _arg_1;
        }


        public function ___MyTreasure_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        public function set buttonBar(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._11548545buttonBar;
            if (_local_2 !== _arg_1)
            {
                this._11548545buttonBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonBar", _local_2, _arg_1));
            };
        }

        private function earnCoins():void
        {
            navigateToURL(new URLRequest(((((GameConfig.instance.strOffer + "&SID=") + GameConfig.instance.SID) + "&user=") + Context.getInstance().userName)), "_blank");
        }

        public function ___MyTreasure_Button2_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        private function init():void
        {
            instance = this;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SHOP_USE_GOODS, useGoodsResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_WORLD_CHAT, onWorldCharMsgResponse);
            this.curShowType = CommonConstants.ITEM_TYPE_TREASURE;
            itemVisible();
            ActionFactory.getInstance().getCommonCommands().getPackageList(packgetListRosponse);
        }

        [Bindable(event="propertyChange")]
        public function get treasureContainer():Tile
        {
            return (this._1084694894treasureContainer);
        }

        private function set AccoutCount(_arg_1:uint):void
        {
            var _local_2:Object = this._1633607230AccoutCount;
            if (_local_2 !== _arg_1)
            {
                this._1633607230AccoutCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AccoutCount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        override public function initialize():void
        {
            var target:MyTreasure;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MyTreasure_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_MyTreasureWatcherSetupUtil");
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

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        private function onShopBtnClick():void
        {
            AllWindows.switchToFuncWindow(ShopWin.EVENT_SHOW);
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    this.curShowType = CommonConstants.ITEM_TYPE_TREASURE;
                    itemVisible();
                    return;
                case 1:
                    this.curShowType = CommonConstants.ITEM_TYPE_SPEEDUP;
                    itemVisible();
                    return;
                case 2:
                    this.curShowType = CommonConstants.ITEM_TYPE_RESOURCE;
                    itemVisible();
                    return;
                case 3:
                    this.curShowType = CommonConstants.ITEM_TYPE_PACKET;
                    itemVisible();
                    if (packageGuide.visible)
                    {
                        packageGuide.visible = false;
                        packageGuide.includeInLayout = false;
                    };
                    return;
                case 4:
                    this.curShowType = CommonConstants.ITEM_TYPE_MEDAL;
                    itemVisible();
                    return;
                case 5:
                    this.curShowType = CommonConstants.ITEM_TYPE_TASK;
                    itemVisible();
                    return;
                case 6:
                    this.curShowType = CommonConstants.ITEM_TYPE_MATERIALS;
                    itemVisible();
                    return;
                case 7:
                    this.curShowType = CommonConstants.ITEM_TYPE_TRICK;
                    itemVisible();
                    return;
                default:
                    this.curShowType = CommonConstants.ITEM_TYPE_TREASURE;
                    itemVisible();
            };
        }

        public function set treasureContainer(_arg_1:Tile):void
        {
            var _local_2:Object = this._1084694894treasureContainer;
            if (_local_2 !== _arg_1)
            {
                this._1084694894treasureContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureContainer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemViewStack():ViewStack
        {
            return (this._717414672itemViewStack);
        }

        private function rechargeHandle():void
        {
            AddFundWin.gotoPurchasePage();
        }

        private function setTreasure():void
        {
            var _local_2:ItemBean;
            var _local_3:GoodContainer;
            this.uiCache.reset();
            this.treasureContainer.removeAllChildren();
            var _local_1:int;
            while (_local_1 < this.player.itemsArray.length)
            {
                _local_2 = this.player.getItems(_local_1);
                if (_local_2.count > 0)
                {
                    _local_3 = (this.uiCache.getUI(GoodContainer) as GoodContainer);
                    _local_3.itemBean = _local_2;
                    _local_3.addEventListener(MouseEvent.CLICK, uesTreasure);
                    treasureContainer.addChild(_local_3);
                }
                else
                {
                    trace("myItem.count=0");
                };
                _local_1++;
            };
            this.uiCache.reset();
        }

        private function uesTreasure(_arg_1:MouseEvent):void
        {
            UseGoodWin.show(_arg_1.currentTarget.itemBean.id, _arg_1.currentTarget.itemBean.count);
        }

        private function onWorldCharMsgResponse(_arg_1:ChatResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (((this.initialized) && (UIUtil.isUIComponentVisible(this))))
                {
                    this.refresh();
                };
            };
        }

        public function set itemViewStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._717414672itemViewStack;
            if (_local_2 !== _arg_1)
            {
                this._717414672itemViewStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemViewStack", _local_2, _arg_1));
            };
        }

        public function ___MyTreasure_Button1_click(_arg_1:MouseEvent):void
        {
            earnCoins();
        }

        public function ___MyTreasure_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___MyTreasure_Button3_click(_arg_1:MouseEvent):void
        {
            onShopBtnClick();
        }

        private function set player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        private function _MyTreasure_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我的宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((Context.getInstance().getPlayerBean().playerInfo.userId % 10) == 7) || (Context.getInstance().userName == "myatco@adknowledge.com")) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MyTreasure_Button1.visible = _arg_1;
            }, "_MyTreasure_Button1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("元宝充值");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTreasure_Button2.label = _arg_1;
            }, "_MyTreasure_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GameConfig.instance.ButtonFlag);
            }, function (_arg_1:Boolean):void
            {
                _MyTreasure_Button2.visible = _arg_1;
            }, "_MyTreasure_Button2.visible");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTreasure_Button3.label = _arg_1;
            }, "_MyTreasure_Button3.label");
            result[4] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("宝物"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[0] = _arg_1;
            }, "_MyTreasure_Array1[0]");
            result[5] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("加速"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[1] = _arg_1;
            }, "_MyTreasure_Array1[1]");
            result[6] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("生产"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[2] = _arg_1;
            }, "_MyTreasure_Array1[2]");
            result[7] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("宝箱"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[3] = _arg_1;
            }, "_MyTreasure_Array1[3]");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("奖章"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[4] = _arg_1;
            }, "_MyTreasure_Array1[4]");
            result[9] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("任务"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[5] = _arg_1;
            }, "_MyTreasure_Array1[5]");
            result[10] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("材料"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[6] = _arg_1;
            }, "_MyTreasure_Array1[6]");
            result[11] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("计谋"));
            }, function (_arg_1:*):void
            {
                _MyTreasure_Array1[7] = _arg_1;
            }, "_MyTreasure_Array1[7]");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("帐户") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTreasure_Label1.text = _arg_1;
            }, "_MyTreasure_Label1.text");
            result[13] = binding;
            binding = new Binding(this, function ():int
            {
                return (player.playerInfo.medal);
            }, function (_arg_1:int):void
            {
                _MyTreasure_WalletShowAll1.medal = _arg_1;
            }, "_MyTreasure_WalletShowAll1.medal");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 14);
            }, function (_arg_1:Boolean):void
            {
                packageGuide.includeInLayout = _arg_1;
            }, "packageGuide.includeInLayout");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 14);
            }, function (_arg_1:Boolean):void
            {
                packageGuide.visible = _arg_1;
            }, "packageGuide.visible");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 14) && (buttonBar.selectedIndex == 3));
            }, function (_arg_1:Boolean):void
            {
                _MyTreasure_GuideArrow2.includeInLayout = _arg_1;
            }, "_MyTreasure_GuideArrow2.includeInLayout");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 14) && (buttonBar.selectedIndex == 3));
            }, function (_arg_1:Boolean):void
            {
                _MyTreasure_GuideArrow2.visible = _arg_1;
            }, "_MyTreasure_GuideArrow2.visible");
            result[18] = binding;
            return (result);
        }

        private function doAddCents(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                rechargeHandle();
            };
        }

        override public function refresh():void
        {
            this.player = Context.getInstance().getPlayerBean();
            this.setTreasure();
            itemVisible();
        }

        [Bindable(event="propertyChange")]
        public function get packageGuide():GuideArrow
        {
            return (this._1899113898packageGuide);
        }

        public function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get player():PlayerBean
        {
            return (this._985752863player);
        }

        public function ___MyTreasure_BaseFunctionWindow1_mouseDown(_arg_1:MouseEvent):void
        {
            mouseDownHandler(_arg_1);
        }

        private function mouseDownHandler(_arg_1:MouseEvent):void
        {
            ControlUI.instance.onClose();
        }

        [Bindable(event="propertyChange")]
        private function get AccoutCount():uint
        {
            return (this._1633607230AccoutCount);
        }

        public function set packageGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1899113898packageGuide;
            if (_local_2 !== _arg_1)
            {
                this._1899113898packageGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "packageGuide", _local_2, _arg_1));
            };
        }

        private function itemVisible():void
        {
            var _local_1:GoodContainer;
            for each (_local_1 in this.treasureContainer.getChildren())
            {
                _local_1.itemVisible = this.curShowType;
            };
        }

        private function _MyTreasure_Array1_i():Array
        {
            var _local_1:Array = [null, null, null, null, null, null, null, null];
            _MyTreasure_Array1 = _local_1;
            BindingManager.executeBindings(this, "_MyTreasure_Array1", _MyTreasure_Array1);
            return (_local_1);
        }

        private function goPreminumRewardPage():void
        {
            if (GameConfig.instance.preminumRewardPage.indexOf("?") >= 0)
            {
                navigateToURL(new URLRequest(((GameConfig.instance.preminumRewardPage + "&user=") + Context.getInstance().userName)), "_blank");
            }
            else
            {
                navigateToURL(new URLRequest(((GameConfig.instance.preminumRewardPage + "?user=") + Context.getInstance().userName)), "_blank");
            };
        }

        [Bindable(event="propertyChange")]
        public function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function useGoodsResponse(_arg_1:UseItemResultResponse):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:String;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (((!(UseGoodWin == null)) && (!(UseGoodWin.getInstance().itemEum == null))))
                {
                    _local_2 = UseGoodWin.getInstance().itemEum.price;
                    _local_3 = UseGoodWin.getInstance().itemEum.id;
                    _local_4 = UseGoodWin.getInstance().itemEum.itemType;
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameUse", UseGoodWin.getInstance().itemEum.id, UseGoodWin.getInstance().itemEum.name, UseGoodWin.getInstance().itemEum.itemType, UseGoodWin.getInstance().itemEum.price);
                    };
                };
                if (((!(_arg_1.gamblingItemsBeansArray == null)) && (_arg_1.gamblingItemsBeansArray.length > 0)))
                {
                    AllWindows.closeAll();
                    Turntable.turntableShow(_arg_1);
                    this.refresh();
                    return;
                };
                if (_arg_1.itemBeansArray.length > 1)
                {
                    trace("开箱子");
                    AwardShowWin.show(_arg_1);
                };
                this.refresh();
            }
            else
            {
                if (_arg_1.ok == ErrorCode.NO_CHRISTMAS_KEY_ERROR)
                {
                    if (((((GameConfig.instance.serverID.toLowerCase() == "na27") || (GameConfig.instance.serverID.toLowerCase() == "na28")) || (GameConfig.instance.serverID.toLowerCase() == "na29")) || (GameConfig.instance.serverID.toLowerCase() == "beta")))
                    {
                        AlertWin.show(_arg_1.errorMsg, doAddCents, "Get Key", Lang.msg("取消"));
                    }
                    else
                    {
                        AlertWin.show("1 Special Chest Key is required. Click Get Key for detail.", doAddCents, "Get Key", Lang.msg("取消"));
                    };
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
        }

        public function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        override public function destroy():void
        {
        }

        private function _MyTreasure_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("我的宝物");
            _local_1 = ((((Context.getInstance().getPlayerBean().playerInfo.userId % 10) == 7) || (Context.getInstance().userName == "myatco@adknowledge.com")) ? true : false);
            _local_1 = Lang.msg("元宝充值");
            _local_1 = GameConfig.instance.ButtonFlag;
            _local_1 = Lang.msg("购买宝物");
            _local_1 = Lang.msg("宝物");
            _local_1 = Lang.msg("加速");
            _local_1 = Lang.msg("生产");
            _local_1 = Lang.msg("宝箱");
            _local_1 = Lang.msg("奖章");
            _local_1 = Lang.msg("任务");
            _local_1 = Lang.msg("材料");
            _local_1 = Lang.msg("计谋");
            _local_1 = (Lang.msg("帐户") + ": ");
            _local_1 = player.playerInfo.medal;
            _local_1 = (GuideStep.getInstance().currentStep == 14);
            _local_1 = (GuideStep.getInstance().currentStep == 14);
            _local_1 = ((GuideStep.getInstance().currentStep == 14) && (buttonBar.selectedIndex == 3));
            _local_1 = ((GuideStep.getInstance().currentStep == 14) && (buttonBar.selectedIndex == 3));
        }


    }
}//package view.module.playerInfo

