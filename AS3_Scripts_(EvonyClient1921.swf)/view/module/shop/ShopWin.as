// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.ShopWin

package view.module.shop
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.market.WalletShowAll;
    import mx.controls.Button;
    import mx.controls.ToggleButtonBar;
    import mx.controls.Label;
    import mx.containers.Tile;
    import com.evony.client.response.ResponseDispatcher;
    import mx.containers.HBox;
    import com.evony.eum.ItemEum;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.controls.Spacer;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import com.evony.common.constants.CommonConstants;
    import mx.core.mx_internal;
    import com.evony.common.beans.PackageBean;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.common.GetPackageListResponse;
    import mx.managers.PopUpManager;
    import mx.events.PropertyChangeEvent;
    import mx.events.FlexEvent;
    import com.evony.MsgDispacther;
    import com.evony.eum.ItemEumDefine;
    import com.evony.client.action.ActionFactory;
    import mx.events.ItemClickEvent;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import com.evony.GameConfig;
    import view.AllWindows;
    import view.module.playerInfo.MyTreasure;
    import com.evony.common.beans.ItemBean;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import flash.events.Event;
    import view.ui.AddFundWin;
    import view.MainWin;
    import mx.core.Application;
    import view.ui.AlertWin;
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

    public class ShopWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "ShopWin.open";
        public static var instance:ShopWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ShopWin_WalletShowAll1:WalletShowAll;
        private var _1427963198goldIncrease:Button;
        private var _11548545buttonBar:ToggleButtonBar;
        private var _1607799334toLeftBtn:Button;
        public var _ShopWin_Label1:Label;
        private var _1084694894treasureContainer:Tile;
        public var _ShopWin_Label2:Label;
        private var responseDispatcherInstance:ResponseDispatcher;
        private var _1456175557toRightBtn:Button;
        public var _ShopWin_Button3:Button;
        public var _ShopWin_HBox1:HBox;
        private var itemEum:ItemEum;
        private var _1844258939myTreasure:Button;
        public var _ShopWin_Array1:Array;
        private var _577409037totalPage:int;
        private var _1125923055curPage:int = 1;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_ShopWin_HBox1",
                        "stylesFactory":function ():void
                        {
                            this.top = "70";
                            this.right = "18";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toLeftBtn",
                                    "events":{"click":"__toLeftBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ShopWin_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14f"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toRightBtn",
                                    "events":{"click":"__toRightBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"next"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "35";
                            this.top = "105";
                            this.bottom = "75";
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
                                        this.left = "9";
                                        this.horizontalGap = 9;
                                        this.verticalGap = 19;
                                        this.top = "19";
                                        this.right = "5";
                                        this.bottom = "5";
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"buttonBar",
                        "events":{"itemClick":"__buttonBar_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "63";
                            this.left = "35";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":685,
                                "dataProvider":_ShopWin_Array1_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "32";
                            this.right = "35";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ShopWin_Button3",
                                    "events":{"click":"___ShopWin_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":2});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"goldIncrease",
                                    "events":{"click":"__goldIncrease_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":2});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"myTreasure",
                                    "events":{"click":"__myTreasure_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "32";
                            this.left = "30";
                            this.horizontalAlign = "left";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ShopWin_Label2",
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
                                    "id":"_ShopWin_WalletShowAll1"
                                })]});
                        }
                    })]});
            }
        });
        private var _2095520559playerInfo:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
        public var hotSellPath:Class = ShopWin_hotSellPath;
        public var onSellPath:Class = ShopWin_onSellPath;
        private var _665031982curTreasureArr:ArrayCollection = new ArrayCollection();
        private var _872795882specialGood:ArrayCollection = new ArrayCollection();
        private var _1178659807usualGood:ArrayCollection = new ArrayCollection();
        public var tejiaArr:ArrayCollection = new ArrayCollection();
        public var remaiArr:ArrayCollection = new ArrayCollection();
        public var baowuArr:ArrayCollection = new ArrayCollection();
        public var jiasuArr:ArrayCollection = new ArrayCollection();
        public var shengchanArr:ArrayCollection = new ArrayCollection();
        public var baoxiangArr:ArrayCollection = new ArrayCollection();
        public var jimouArr:ArrayCollection = new ArrayCollection();
        public var cailiaoArr:ArrayCollection = new ArrayCollection();
        private var curMonth:String = String((CommonConstants.ITEM_FOR_GAMBLING_BOX + Context.getInstance().getPlayerBean().gamblingItemIndex));
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ShopWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___ShopWin_BaseFunctionWindowEx1_creationComplete);
            this.addEventListener("removedFromStage", ___ShopWin_BaseFunctionWindowEx1_removedFromStage);
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
            ShopWin._watcherSetupUtil = _arg_1;
        }


        override public function destroy():void
        {
            if (FillGift.instance)
            {
                PopUpManager.removePopUp(FillGift.instance);
            };
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

        private function setCurArr(_arg_1:ArrayCollection):ArrayCollection
        {
            curTreasureArr = _arg_1;
            if (curTreasureArr.length > 0)
            {
                totalPage = Math.ceil((curTreasureArr.length / 9));
            }
            else
            {
                curPage = 0;
                totalPage = 0;
            };
            return (curTreasureArr);
        }

        public function ___ShopWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function init():void
        {
            var _local_3:ArrayCollection;
            var _local_4:int;
            var _local_5:int;
            var _local_6:WareContainer;
            var _local_7:int;
            var _local_8:WareContainer;
            instance = this;
            MsgDispacther.getInstance().addEventListener(Context.EVENT_PLAYER_LOGIN, onPlayerLogin);
            playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            specialGood = Context.getInstance().getPlayerBean().saleItemBeansArray;
            var _local_1:int;
            while (_local_1 < specialGood.length)
            {
                if (specialGood[_local_1].saleType == 0)
                {
                    tejiaArr.addItem(specialGood[_local_1].items);
                };
                if (specialGood[_local_1].saleType == 1)
                {
                    remaiArr.addItem(specialGood[_local_1].items);
                };
                _local_1++;
            };
            usualGood = Context.getInstance().getPlayerBean().saleTypeBeansArray;
            var _local_2:int;
            while (_local_2 < usualGood.length)
            {
                switch (usualGood[_local_2].typeName)
                {
                    case "宝物":
                        baowuArr = releaseArr(usualGood[_local_2].items);
                        break;
                    case "加速":
                        jiasuArr = releaseArr(usualGood[_local_2].items);
                        break;
                    case "生产":
                        shengchanArr = releaseArr(usualGood[_local_2].items);
                        break;
                    case "宝箱":
                        _local_3 = new ArrayCollection();
                        _local_3 = releaseArr(usualGood[_local_2].items);
                        _local_4 = 0;
                        while (_local_4 < _local_3.length)
                        {
                            if (checkBaoxiangArr(_local_3[_local_4]) == true)
                            {
                                baoxiangArr.addItem(_local_3[_local_4]);
                            };
                            _local_4++;
                        };
                        break;
                    case "计谋":
                        jimouArr = releaseArr(usualGood[_local_2].items);
                        break;
                    case "材料":
                        cailiaoArr = releaseArr(usualGood[_local_2].items);
                        break;
                };
                _local_2++;
            };
            responseDispatcherInstance = ResponseDispatcher.getInstance();
            responseDispatcherInstance.addEventListener(ResponseDispatcher.SHOP_BUY, upDate);
            if (tejiaArr.length > 0)
            {
                _local_5 = 0;
                while (_local_5 < tejiaArr.length)
                {
                    _local_6 = new WareContainer();
                    _local_6.itemEum = ItemEumDefine.getItemEum(tejiaArr[_local_5]);
                    _local_6.itemSellStatus = "onSell";
                    _local_6.specialWindow = true;
                    this.treasureContainer.addChild(_local_6);
                    _local_5++;
                };
            };
            if (remaiArr.length > 0)
            {
                _local_7 = 0;
                while (_local_7 < remaiArr.length)
                {
                    _local_8 = new WareContainer();
                    _local_8.itemEum = ItemEumDefine.getItemEum(remaiArr[_local_7]);
                    _local_8.itemSellStatus = "hotSell";
                    _local_8.specialWindow = true;
                    this.treasureContainer.addChild(_local_8);
                    _local_7++;
                };
            };
            if (baowuArr.length > 0)
            {
                addGoodContaier(baowuArr);
            };
            if (jiasuArr.length > 0)
            {
                addGoodContaier(jiasuArr);
            };
            if (shengchanArr.length > 0)
            {
                addGoodContaier(shengchanArr);
            };
            if (baoxiangArr.length > 0)
            {
                addGoodContaier(baoxiangArr);
            };
            if (jimouArr.length > 0)
            {
                addGoodContaier(jimouArr);
            };
            if (cailiaoArr.length > 0)
            {
                addGoodContaier(cailiaoArr);
            };
            getMyTreasure();
            buttonBar.selectedIndex = 0;
            setItemVisible(0);
            ActionFactory.getInstance().getCommonCommands().getPackageList(packgetListRosponse);
        }

        [Bindable(event="propertyChange")]
        private function get specialGood():ArrayCollection
        {
            return (this._872795882specialGood);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get usualGood():ArrayCollection
        {
            return (this._1178659807usualGood);
        }

        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(-1);
        }

        private function setItemVisible(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 0:
                    itemVisible("onSell", setCurArr(tejiaArr), curPage, "");
                    return;
                case 1:
                    itemVisible("hotSell", setCurArr(remaiArr), curPage, "");
                    return;
                case 2:
                    itemVisible("normalSell", setCurArr(baowuArr), curPage, CommonConstants.ITEM_TYPE_TREASURE);
                    return;
                case 3:
                    itemVisible("normalSell", setCurArr(jiasuArr), curPage, CommonConstants.ITEM_TYPE_SPEEDUP);
                    return;
                case 4:
                    itemVisible("normalSell", setCurArr(shengchanArr), curPage, CommonConstants.ITEM_TYPE_RESOURCE);
                    return;
                case 5:
                    itemVisible("normalSell", setCurArr(baoxiangArr), curPage, CommonConstants.ITEM_TYPE_PACKET);
                    return;
                case 6:
                    itemVisible("normalSell", setCurArr(cailiaoArr), curPage, CommonConstants.ITEM_TYPE_MATERIALS);
                    return;
                case 7:
                    itemVisible("normalSell", setCurArr(jimouArr), curPage, CommonConstants.ITEM_TYPE_TRICK);
                    return;
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
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        private function _ShopWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("商城");
            _local_1 = ((this.totalPage > 1) ? true : false);
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = Lang.msg("热卖");
            _local_1 = Lang.msg("宝物");
            _local_1 = Lang.msg("加速");
            _local_1 = Lang.msg("生产");
            _local_1 = Lang.msg("宝箱");
            _local_1 = Lang.msg("材料");
            _local_1 = Lang.msg("计谋");
            _local_1 = Lang.msg("ChargeBonus");
            _local_1 = Lang.msg("元宝充值");
            _local_1 = GameConfig.instance.ButtonFlag;
            _local_1 = Lang.msg("我的宝物");
            _local_1 = (Lang.msg("帐户") + ": ");
            _local_1 = this.playerInfo.medal;
        }

        public function ___ShopWin_Button3_click(_arg_1:MouseEvent):void
        {
            goCentsPage();
        }

        private function addGoodContaier(_arg_1:ArrayCollection):void
        {
            var _local_3:WareContainer;
            var _local_4:int;
            var _local_5:int;
            var _local_2:int;
            while (_local_2 < _arg_1.length)
            {
                _local_3 = new WareContainer();
                _local_3.itemEum = ItemEumDefine.getItemEum(_arg_1[_local_2]);
                _local_3.itemSellStatus = "normalSell";
                _local_3.specialWindow = false;
                if (tejiaArr.length > 0)
                {
                    _local_4 = 0;
                    while (_local_4 < tejiaArr.length)
                    {
                        if (_arg_1[_local_2] == tejiaArr[_local_4])
                        {
                            _local_3.itemSellStatus = "onSell";
                            break;
                        };
                        _local_4++;
                    };
                };
                if (remaiArr.length > 0)
                {
                    _local_5 = 0;
                    while (_local_5 < remaiArr.length)
                    {
                        if (_arg_1[_local_2] == remaiArr[_local_5])
                        {
                            _local_3.itemSellStatus = "hotSell";
                            break;
                        };
                        _local_5++;
                    };
                };
                this.treasureContainer.addChild(_local_3);
                _local_2++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
        }

        private function checkBaoxiangArr(_arg_1:String):Boolean
        {
            var _local_2:Boolean = true;
            if (((((((((_arg_1 == "player.box.gambling.medal.300") || (_arg_1 == "consume.key.1")) || (_arg_1 == "consume.key.2")) || (_arg_1 == "consume.key.3")) || (_arg_1 == "player.box.1")) || (_arg_1 == "player.box.2")) || (_arg_1 == "player.box.3")) || (_arg_1 == "player.box.present.3")))
            {
                _local_2 = false;
            };
            if ((((((((((((_arg_1 == "player.box.gambling.1") || (_arg_1 == "player.box.gambling.2")) || (_arg_1 == "player.box.gambling.4")) || (_arg_1 == "player.box.gambling.5")) || (_arg_1 == "player.box.gambling.6")) || (_arg_1 == "player.box.gambling.7")) || (_arg_1 == "player.box.gambling.8")) || (_arg_1 == "player.box.gambling.9")) || (_arg_1 == "player.box.gambling.10")) || (_arg_1 == "player.box.gambling.11")) || (_arg_1 == "player.box.gambling.12")))
            {
                _local_2 = false;
            };
            return (_local_2);
        }

        private function set specialGood(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._872795882specialGood;
            if (_local_2 !== _arg_1)
            {
                this._872795882specialGood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "specialGood", _local_2, _arg_1));
            };
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(1);
        }

        private function showMyTreasureWindow():void
        {
            AllWindows.switchToFuncWindow(MyTreasure.EVENT_SHOW);
        }

        private function getMyTreasure():void
        {
            var _local_3:WareContainer;
            var _local_4:ItemBean;
            var _local_5:ItemBean;
            var _local_1:Object = new Object();
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_2);
                _local_1[_local_4.id] = _local_4;
                _local_2++;
            };
            for each (_local_3 in this.treasureContainer.getChildren())
            {
                if (_local_3.itemEum != null)
                {
                    _local_5 = (_local_1[_local_3.itemEum.id] as ItemBean);
                    _local_3.setItemBean(_local_5);
                };
            };
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
        public function get myTreasure():Button
        {
            return (this._1844258939myTreasure);
        }

        private function showFillGiftWindow():void
        {
            FillGift.show();
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        public function set toRightBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1456175557toRightBtn;
            if (_local_2 !== _arg_1)
            {
                this._1456175557toRightBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toRightBtn", _local_2, _arg_1));
            };
        }

        private function changePageNo(_arg_1:int):void
        {
            var _local_2:int = (this.curPage + _arg_1);
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.curPage = _local_2;
                setItemVisible(buttonBar.selectedIndex);
            };
        }

        public function set goldIncrease(_arg_1:Button):void
        {
            var _local_2:Object = this._1427963198goldIncrease;
            if (_local_2 !== _arg_1)
            {
                this._1427963198goldIncrease = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldIncrease", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ShopWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ShopWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_ShopWinWatcherSetupUtil");
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
        public function get treasureContainer():Tile
        {
            return (this._1084694894treasureContainer);
        }

        private function _ShopWin_Array1_i():Array
        {
            var _local_1:Array = ["Special", null, null, null, null, null, null, null];
            _ShopWin_Array1 = _local_1;
            BindingManager.executeBindings(this, "_ShopWin_Array1", _ShopWin_Array1);
            return (_local_1);
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            curPage = 1;
            setItemVisible(_arg_1.index);
        }

        public function __myTreasure_click(_arg_1:MouseEvent):void
        {
            showMyTreasureWindow();
        }

        private function onPlayerLogin(_arg_1:Event):void
        {
            playerInfo = Context.getInstance().getPlayerBean().playerInfo;
        }

        private function rechargeHandle():void
        {
            AddFundWin.gotoPurchasePage();
        }

        public function __goldIncrease_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        private function set curTreasureArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._665031982curTreasureArr;
            if (_local_2 !== _arg_1)
            {
                this._665031982curTreasureArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curTreasureArr", _local_2, _arg_1));
            };
        }

        public function set toLeftBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1607799334toLeftBtn;
            if (_local_2 !== _arg_1)
            {
                this._1607799334toLeftBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toLeftBtn", _local_2, _arg_1));
            };
        }

        private function set usualGood(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1178659807usualGood;
            if (_local_2 !== _arg_1)
            {
                this._1178659807usualGood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "usualGood", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get goldIncrease():Button
        {
            return (this._1427963198goldIncrease);
        }

        public function ___ShopWin_BaseFunctionWindowEx1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        private function get curTreasureArr():ArrayCollection
        {
            return (this._665031982curTreasureArr);
        }

        private function showBuyWin(_arg_1:MouseEvent):void
        {
        }

        override public function refresh():void
        {
            trace((this.className + " refresh()"));
            getMyTreasure();
            MainWin.instance.addMoneyPic.x = ((this.x + this.width) + 80);
            if (Application.application.width >= 1300)
            {
                MainWin.instance.addMoneyPic.x = (((this.x + this.width) + 230) + ((Application.application.width - 1600) / 2));
            }
            else
            {
                if (Application.application.width > 0x0500)
                {
                    MainWin.instance.addMoneyPic.x = ((((this.x + this.width) + 80) + Application.application.width) - 0x0500);
                };
            };
            MainWin.instance.addMoneyPic.y = (this.y + 220);
            MainWin.instance.addMoneyPic.visible = true;
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

        private function itemVisible(_arg_1:String, _arg_2:ArrayCollection, _arg_3:int, _arg_4:String):void
        {
            var _local_5:WareContainer;
            for each (_local_5 in this.treasureContainer.getChildren())
            {
                _local_5.setItemVisible(_arg_1, _arg_2, _arg_3, _arg_4);
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

        private function onGetKey():void
        {
            navigateToURL(new URLRequest(((GameConfig.instance.giftKey + "&user=") + Context.getInstance().userName)), "_blank");
        }

        private function releaseArr(_arg_1:String):ArrayCollection
        {
            var _local_4:int;
            var _local_2:ArrayCollection = new ArrayCollection();
            var _local_3:Array = new Array();
            _local_3 = _arg_1.split("#");
            if (_local_3.length > 0)
            {
                _local_4 = 0;
                while (_local_4 < _local_3.length)
                {
                    if (_local_3[_local_4] == "player.experience.1.a")
                    {
                        _local_3[_local_4] = "player.experience.1.c";
                    }
                    else
                    {
                        if (_local_3[_local_4] == "player.experience.1.c")
                        {
                            _local_3[_local_4] = "player.queue.building";
                        }
                        else
                        {
                            if (_local_3[_local_4] == "player.queue.building")
                            {
                                _local_3[_local_4] = "player.experience.1.a";
                            };
                        };
                    };
                    _local_2.addItem(_local_3[_local_4]);
                    _local_4++;
                };
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function upDate(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                getMyTreasure();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function goCentsPage():void
        {
            navigateToURL(new URLRequest(((((GameConfig.instance.MiniFavorable + "&user=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID)), "_blank");
        }

        private function _ShopWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("商城");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.totalPage > 1) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ShopWin_HBox1.visible = _arg_1;
            }, "_ShopWin_HBox1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ShopWin_Label1.text = _arg_1;
            }, "_ShopWin_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("热卖"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[1] = _arg_1;
            }, "_ShopWin_Array1[1]");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("宝物"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[2] = _arg_1;
            }, "_ShopWin_Array1[2]");
            result[4] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("加速"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[3] = _arg_1;
            }, "_ShopWin_Array1[3]");
            result[5] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("生产"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[4] = _arg_1;
            }, "_ShopWin_Array1[4]");
            result[6] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("宝箱"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[5] = _arg_1;
            }, "_ShopWin_Array1[5]");
            result[7] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("材料"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[6] = _arg_1;
            }, "_ShopWin_Array1[6]");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("计谋"));
            }, function (_arg_1:*):void
            {
                _ShopWin_Array1[7] = _arg_1;
            }, "_ShopWin_Array1[7]");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("ChargeBonus");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ShopWin_Button3.label = _arg_1;
            }, "_ShopWin_Button3.label");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("元宝充值");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                goldIncrease.label = _arg_1;
            }, "goldIncrease.label");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GameConfig.instance.ButtonFlag);
            }, function (_arg_1:Boolean):void
            {
                goldIncrease.visible = _arg_1;
            }, "goldIncrease.visible");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我的宝物");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myTreasure.label = _arg_1;
            }, "myTreasure.label");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("帐户") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ShopWin_Label2.text = _arg_1;
            }, "_ShopWin_Label2.text");
            result[14] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.playerInfo.medal);
            }, function (_arg_1:int):void
            {
                _ShopWin_WalletShowAll1.medal = _arg_1;
            }, "_ShopWin_WalletShowAll1.medal");
            result[15] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        public function set myTreasure(_arg_1:Button):void
        {
            var _local_2:Object = this._1844258939myTreasure;
            if (_local_2 !== _arg_1)
            {
                this._1844258939myTreasure = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTreasure", _local_2, _arg_1));
            };
        }

        private function goIEvonyPage():void
        {
            if (GameConfig.instance.preminumRewardPage.indexOf("?") >= 0)
            {
                navigateToURL(new URLRequest(((GameConfig.instance.iEvonyPage + "&user=") + Context.getInstance().userName)), "_blank");
            }
            else
            {
                navigateToURL(new URLRequest(((GameConfig.instance.iEvonyPage + "?user=") + Context.getInstance().userName)), "_blank");
            };
        }


    }
}//package view.module.shop

