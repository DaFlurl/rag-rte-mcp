// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.SpeedupItemSelector

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.collections.ArrayCollection;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.BuildingBean;
    import com.evony.eum.ItemEum;
    import mx.containers.VBox;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.beans.ArmyBean;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Button;
    import mx.containers.HBox;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import com.evony.util.MinePopupManager;
    import com.evony.Context;
    import view.castle.MainFrame;
    import com.evony.util.UIUtil;
    import flash.display.DisplayObject;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.beans.PlayerInfoBean;
    import view.AllWindows;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.tech.ResearchResponse;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import com.evony.events.WindowChangeEvent;
    import mx.events.FlexEvent;
    import com.evony.events.ItemSelectEvent;
    import flash.external.ExternalInterface;
    import com.evony.common.module.shop.UseItemResultResponse;
    import view.castle.BuildingInfoWin;
    import mx.controls.HRule;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.beans.ItemBean;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
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

    public class SpeedupItemSelector extends Canvas implements IBindingClient 
    {

        private static var itemArray:ArrayCollection;
        private static var instance:SpeedupItemSelector = new (SpeedupItemSelector)();
        public static const ON_COIN_TECH_SPEED:String = "on.coin.tech.speed";
        public static const ON_COIN_BUILD_SPEED:String = "on.coin.build.speed";
        public static const ON_COIN_EQUIP_SPEED:String = "on.coin.equip.speed";
        public static const ON_COIN_BUILD_QUEUE_SPEED:String = "on.coin.build.queue.speed";
        public static const ON_JM_APPLY:String = "on.coin.jm";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _bean:BuildingBean;
        public var speedType:String;
        private var itemEum:ItemEum;
        private var _1177154070itemHbox:VBox;
        private var isSpeedType:Boolean = false;
        private var _buildQueueBean:BuildingQueueBean;
        private var func:Function;
        private var _teachBean:AvailableResearchListBean;
        private var _armyBean:ArmyBean;
        private var selectedItem:ItemEum;
        public var _SpeedupItemSelector_Label1:Label;
        private var itemiIdArray:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":290,
                    "width":610,
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
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "35";
                            this.top = "60";
                            this.left = "38";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"auto",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"itemHbox",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "0";
                                        this.top = "0";
                                        this.left = "0";
                                        this.verticalGap = 2;
                                        this.right = "0";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SpeedupItemSelector_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":1,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "9";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SpeedupItemSelector_Label1",
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
                    })]
                });
            }
        });
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SpeedupItemSelector()
        {
            mx_internal::_document = this;
            this.height = 290;
            this.width = 610;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___SpeedupItemSelector_Canvas1_creationComplete);
        }

        public static function destroy():void
        {
            MinePopupManager.instance.removePopup();
        }

        public static function getInstance():SpeedupItemSelector
        {
            if (instance == null)
            {
                instance = new (SpeedupItemSelector)();
            };
            return (instance);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SpeedupItemSelector._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:ArrayCollection, _arg_2:Function=null, _arg_3:DisplayObject=null):void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            if (_arg_3 == null)
            {
                _arg_3 = MainFrame.instance;
            };
            var _local_4:int = _arg_1.length;
            if (_local_4 > 6)
            {
                _local_4 = 6;
            };
            if (((((instance.speedType == SpeedupItemSelector.ON_COIN_BUILD_SPEED) || (instance.speedType == SpeedupItemSelector.ON_COIN_BUILD_QUEUE_SPEED)) || (instance.speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)) || (instance.speedType == SpeedupItemSelector.ON_COIN_EQUIP_SPEED)))
            {
                instance.isSpeedType = false;
                instance.height = (((_local_4 + 1) * 65) + 100);
            }
            else
            {
                instance.isSpeedType = true;
                instance.height = ((_local_4 * 65) + 100);
            };
            if (_local_4 == 1)
            {
                instance.height = (instance.height + 40);
            };
            instance.func = _arg_2;
            instance.itemiIdArray = _arg_1;
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, _arg_3, true);
            MinePopupManager.instance.centerPopUp();
            instance.onShowEvent();
        }


        public function ___SpeedupItemSelector_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        override public function initialize():void
        {
            var target:SpeedupItemSelector;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SpeedupItemSelector_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_SpeedupItemSelectorWatcherSetupUtil");
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

        private function getMedalUI():MedalUI
        {
            var _local_1:UICache = new UICache(20);
            _local_1.reset();
            var _local_2:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            var _local_3:MedalUI = (_local_1.getUI(MedalUI) as MedalUI);
            _local_3.medalAmount = _local_2.medal;
            _local_3.coinSpeed = this.speedType;
            _local_3.beans = this._bean;
            _local_3.buildQueueBean = this._buildQueueBean;
            if (!_local_3.hasEventListener(AllWindows.EVENT_CHANGE))
            {
                _local_3.addEventListener(AllWindows.EVENT_CHANGE, onSelectHandler);
            };
            return (_local_3);
        }

        private function onSelectHandler(event:WindowChangeEvent):void
        {
            var onMedalSpeed:Function;
            var onTeachResearch:Function;
            onMedalSpeed = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    trace("coin.speed");
                    close();
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            onTeachResearch = function (_arg_1:ResearchResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    trace("teach.speed in coin");
                    close();
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            var cid:int = Context.getInstance().getCurCastle().id;
            if (event.getId() != "medal")
            {
                return;
            };
            if (((!(this._bean == null)) && (this._bean.positionId == 32)))
            {
                this._bean.positionId = -1;
            };
            if (this.speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)
            {
                ActionFactory.getInstance().getTechCommand().speedUpResearch(cid, CommonConstants.COINS_SPEED_ITEM_ID, onTeachResearch);
            }
            else
            {
                if (this.speedType == SpeedupItemSelector.ON_COIN_EQUIP_SPEED)
                {
                    ActionFactory.getInstance().getEquipmenttechCommands().speedUpResearch(cid, CommonConstants.COINS_SPEED_ITEM_ID, onTeachResearch);
                }
                else
                {
                    if (this.speedType == SpeedupItemSelector.ON_COIN_BUILD_QUEUE_SPEED)
                    {
                        ActionFactory.getInstance().getCastleCommands().speedupBuildingQueue(cid, this._buildQueueBean.id, CommonConstants.COINS_SPEED_ITEM_ID, onMedalSpeed);
                    }
                    else
                    {
                        ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(cid, this._bean.positionId, CommonConstants.COINS_SPEED_ITEM_ID, onMedalSpeed);
                    };
                };
            };
        }

        private function init():void
        {
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get itemHbox():VBox
        {
            return (this._1177154070itemHbox);
        }

        public function set buildQueueBean(_arg_1:BuildingQueueBean):void
        {
            this._buildQueueBean = _arg_1;
        }

        public function ___SpeedupItemSelector_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onSelect(_arg_1:ItemSelectEvent):void
        {
            trace((((this.className + ".onSelect(") + _arg_1.item.name) + ")"));
            itemEum = _arg_1.item;
            if (UIUtil.checkItem(_arg_1.item.id, 1))
            {
                if (this.func != null)
                {
                    func.apply(this, [_arg_1.item]);
                    this.close();
                }
                else
                {
                    this.useNow(_arg_1.item.id);
                };
            }
            else
            {
                AddFundWin.show();
            };
        }

        private function onUseItemResponse(_arg_1:UseItemResultResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", this.itemEum.id, this.itemEum.name, this.itemEum.itemType, this.itemEum.price);
                };
                close();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function get buildBean():BuildingBean
        {
            return (this._bean);
        }

        public function get teachBean():AvailableResearchListBean
        {
            return (this._teachBean);
        }

        public function set teachbean(_arg_1:AvailableResearchListBean):void
        {
            this._teachBean = _arg_1;
        }

        private function useGoodResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", this.itemEum.id, this.itemEum.name, this.itemEum.itemType, this.itemEum.price);
                };
                close();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function useNow(_arg_1:String):void
        {
            if (((_arg_1 == "player.heart.1.a") || (_arg_1 == "player.pop.1.a")))
            {
                ActionFactory.getInstance().getShopCommands().useCastleGoods(Context.getInstance().getCurCastle().id, _arg_1, useGoodResponse);
            }
            else
            {
                ActionFactory.getInstance().getShopCommands().useGoods(Context.getInstance().getCurCastle().id, _arg_1, 1, onUseItemResponse);
            };
        }

        private function onClose():void
        {
            this.close();
            BuildingInfoWin.instance.setStructingVsTrue();
        }

        public function set armyBean(_arg_1:ArmyBean):void
        {
            this._armyBean = _arg_1;
        }

        private function refresh():void
        {
            var _local_3:String;
            var _local_4:ItemEum;
            var _local_5:ItemUI;
            var _local_6:HRule;
            var _local_7:AskForHelpUI;
            this.itemHbox.removeAllChildren();
            this.uiCache.reset();
            if (((((this.speedType == SpeedupItemSelector.ON_COIN_BUILD_SPEED) || (this.speedType == SpeedupItemSelector.ON_COIN_BUILD_QUEUE_SPEED)) || (this.speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)) || (this.speedType == SpeedupItemSelector.ON_COIN_EQUIP_SPEED)))
            {
                this.itemHbox.addChild(getMedalUI());
            };
            var _local_1:Array = [];
            var _local_2:int;
            while (_local_2 < this.itemiIdArray.length)
            {
                if ((((this.speedType == SpeedupItemSelector.ON_COIN_BUILD_SPEED) || (this.speedType == SpeedupItemSelector.ON_COIN_TECH_SPEED)) || (this.speedType == SpeedupItemSelector.ON_COIN_EQUIP_SPEED)))
                {
                    _local_6 = new HRule();
                    _local_6.setStyle("strokeColor", 0xFFFFFF);
                    _local_6.setStyle("strokeWidth", 1);
                    _local_6.percentWidth = 96;
                };
                _local_3 = this.itemiIdArray[_local_2];
                _local_4 = ItemEumDefine.getItemEum(_local_3);
                _local_5 = (this.uiCache.getUI(ItemUI) as ItemUI);
                if (_local_5 != null)
                {
                    _local_5.itemEum = _local_4;
                    _local_5.bean = this.getItemBeanFromPlayer(_local_4.id);
                    if (!_local_5.hasEventListener(ItemSelectEvent.NAME))
                    {
                        _local_5.addEventListener(ItemSelectEvent.NAME, onSelect);
                    };
                    this.itemHbox.addChild(_local_5);
                    if (_local_2 < (this.itemiIdArray.length - 1))
                    {
                        _local_6 = new HRule();
                        _local_6.setStyle("strokeColor", 0xFFFFFF);
                        _local_6.setStyle("strokeWidth", 1);
                        _local_6.percentWidth = 96;
                    };
                };
                _local_2++;
            };
            if ((((Context.getInstance().isBuildHelp) && (!(this.speedType == SpeedupItemSelector.ON_COIN_EQUIP_SPEED))) && (!(this.isSpeedType))))
            {
                _local_7 = (this.uiCache.getUI(AskForHelpUI) as AskForHelpUI);
                if (_local_7 != null)
                {
                    this.itemHbox.addChildAt(_local_7, 1);
                    _local_7.refresh();
                };
            };
        }

        public function set bean(_arg_1:BuildingBean):void
        {
            this._bean = _arg_1;
        }

        private function getItemBeanFromPlayer(_arg_1:String):ItemBean
        {
            var _local_3:ItemBean;
            var _local_2:ItemBean;
            for each (_local_3 in Context.getInstance().getPlayerBean().itemsArray)
            {
                if (_local_3.id == _arg_1)
                {
                    _local_2 = _local_3;
                };
            };
            return (_local_2);
        }

        public function set itemHbox(_arg_1:VBox):void
        {
            var _local_2:Object = this._1177154070itemHbox;
            if (_local_2 !== _arg_1)
            {
                this._1177154070itemHbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemHbox", _local_2, _arg_1));
            };
        }

        private function _SpeedupItemSelector_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("请选择");
        }

        private function _SpeedupItemSelector_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SpeedupItemSelector_Label1.text = _arg_1;
            }, "_SpeedupItemSelector_Label1.text");
            result[0] = binding;
            return (result);
        }

        private function close():void
        {
            if (this.speedType != null)
            {
                this.speedType = null;
            };
            MinePopupManager.instance.removePopup();
        }

        public function onShowEvent():void
        {
            trace((this.className + " onShowEvent()"));
            if (this.initialized)
            {
                this.refresh();
            };
        }


    }
}//package view.ui

