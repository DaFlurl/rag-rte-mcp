// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.barrack.Barrack

package view.module.barrack
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import mx.containers.Tile;
    import mx.controls.Label;
    import mx.containers.Canvas;
    import com.evony.common.beans.BuildingBean;
    import mx.core.UIComponentDescriptor;
    import view.ui.MyHRule;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import com.evony.common.beans.TroopProduceListBean;
    import com.evony.common.module.troop.TroopProduceListResponse;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.events.Event;
    import com.evony.Context;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.MsgDispacther;
    import com.evony.common.beans.ProduceBean;
    import com.evony.util.UIUtil;
    import mx.events.FlexEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import com.evony.events.CommonProduceEvent;
    import com.evony.Lang;
    import com.evony.common.constants.TFConstants;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.common.beans.AllProduceBean;
    import view.castle.TownView;
    import com.evony.common.module.troop.ProduceQueueResponse;
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

    public class Barrack extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Barrack.show";
        public static const EVENT_PRODUCE:String = "Barrack.produce";
        public static const EVENT_SPEEDUP:String = "Barrack.speedUp";
        public static const EVENT_CANCEL:String = "Barrack.cancel";
        public static const EVENT_REFRESH:String = "Barrack.refresh";
        public static const EVENT_FREE_SPEEDUP:String = "free.speedup";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _93839704produceAmount:int;
        public var _Barrack_SWTypeUI12:SWTypeUI;
        private var _1269329178curProduceTroopUi:SWProduceUI;
        public var _Barrack_SWTypeUI10:SWTypeUI;
        public var _Barrack_SWTypeUI11:SWTypeUI;
        private var _1974405520queueContainer:VBox;
        private var sWEnlist:SWEnlist;
        private var ttoopAry:ArrayCollection;
        private var _670137828remainAmount:int = 0;
        private var _1368160669SWTypeContainer:Tile;
        public var _Barrack_SWTypeUI1:SWTypeUI;
        public var _Barrack_SWTypeUI2:SWTypeUI;
        public var _Barrack_SWTypeUI3:SWTypeUI;
        public var _Barrack_SWTypeUI4:SWTypeUI;
        public var _Barrack_SWTypeUI5:SWTypeUI;
        public var _Barrack_SWTypeUI6:SWTypeUI;
        public var _Barrack_SWTypeUI7:SWTypeUI;
        public var _Barrack_SWTypeUI8:SWTypeUI;
        public var _Barrack_SWTypeUI9:SWTypeUI;
        private var aryLength:int = 10;
        private var _1693588840needAllTime:String = "";
        public var _Barrack_Label1:Label;
        public var _Barrack_Label2:Label;
        public var _Barrack_Label3:Label;
        private var oldLevel:int;
        private var _949911571labelContainer:Canvas;
        private var _982966140buildingBean:BuildingBean;
        private var sWDisband:SWDisband;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"labelContainer",
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":315,
                                "x":0,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Barrack_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "width":230
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Barrack_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "40";
                                        this.left = "10";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Barrack_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.left = "10";
                                        this.top = "120";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "width":150
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "2";
                                        this.top = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":95});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":117,
                                            "percentWidth":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":SWProduceUI,
                                    "id":"curProduceTroopUi",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"y":67});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"queueContainer",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "140";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"SWTypeContainer",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.bottom = "35";
                            this.top = "0";
                            this.paddingLeft = 5;
                            this.horizontalGap = 5;
                            this.paddingTop = 5;
                            this.paddingBottom = 5;
                            this.verticalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"greyBackground",
                                "width":435,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI1"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI2"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI3"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI4"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI5"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI6"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI7"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI8"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI9"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI10"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI11"
                                }), new UIComponentDescriptor({
                                    "type":SWTypeUI,
                                    "id":"_Barrack_SWTypeUI12"
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1894017992queueArray:ArrayCollection = new ArrayCollection();
        private var swTypeUiMap:Object = new Object();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Barrack()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Barrack_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Barrack._watcherSetupUtil = _arg_1;
        }


        private function onGetTroopProduceList(_arg_1:TroopProduceListResponse):void
        {
            var _local_2:int;
            var _local_3:TroopProduceListBean;
            var _local_4:SWTypeUI;
            if (_arg_1.ok)
            {
                _local_2 = 0;
                while (_local_2 < _arg_1.troopListArray.length)
                {
                    _local_3 = _arg_1.getTroopList(_local_2);
                    _local_4 = (this.swTypeUiMap[_local_3.typeId] as SWTypeUI);
                    _local_4.bean = _local_3;
                    _local_2++;
                };
            }
            else
            {
                trace(((this.className + "onGetTroopProduceList error: ") + _arg_1.errorMsg));
            };
        }

        private function set buildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._982966140buildingBean;
            if (_local_2 !== _arg_1)
            {
                this._982966140buildingBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingBean", _local_2, _arg_1));
            };
        }

        private function onSpeedResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refreshQueue();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function init():void
        {
            var onRefreshEvent:Function;
            var onRefreshBuildingEvent:Function;
            var swTypeUi:SWTypeUI;
            onRefreshEvent = function (_arg_1:Event):void
            {
                refreshQueue();
            };
            onRefreshBuildingEvent = function (_arg_1:BuildComplate):void
            {
                if ((((_arg_1.castleId == Context.getInstance().getCurCastle().id) && (_arg_1.buildingBean.positionId == buildingBean.positionId)) && (!(_arg_1.buildingBean.level == oldLevel))))
                {
                    oldLevel = _arg_1.buildingBean.level;
                    refreshTypeList();
                };
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_GET_TROOP_PRODUCE_LIST, onGetTroopProduceList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_GET_PRODUCE_QUEUE, onGetProduceQueue);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, onRefreshEvent);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onRefreshBuildingEvent);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_PRODUCE_TROOP, onProduceTroopResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_CANCEL_TROOP_PRODUCE, onCancelResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_ACC_TROOP_PRODUCE, onSpeedResponse);
            MsgDispacther.getInstance().addEventListener(EVENT_CANCEL, doCancel);
            MsgDispacther.getInstance().addEventListener(EVENT_SPEEDUP, doSpeedUp);
            MsgDispacther.getInstance().addEventListener(EVENT_FREE_SPEEDUP, doSpeedUp);
            MsgDispacther.getInstance().addEventListener(EVENT_PRODUCE, doProduce);
            MsgDispacther.getInstance().addEventListener(EVENT_REFRESH, onRefreshEvent);
            for each (swTypeUi in this.SWTypeContainer.getChildren())
            {
                trace(((this.className + "init() addswTypeUI") + swTypeUi.bakTypeId));
                this.swTypeUiMap[swTypeUi.bakTypeId] = swTypeUi;
            };
        }

        private function produceQueue(_arg_1:ArrayCollection):void
        {
            var _local_4:int;
            var _local_5:SWProduceUI;
            var _local_2:Number = 0;
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = (_local_2 + ProduceBean(_arg_1[_local_3]).costTime);
                _local_3++;
            };
            this.needAllTime = UIUtil.timeToString(_local_2);
            if (_arg_1.length > 0)
            {
                this.curProduceTroopUi.produceBean = _arg_1[0];
                this.curProduceTroopUi.visible = true;
                this.remainAmount = (_arg_1.length - 1);
                produceAmount = 1;
            }
            else
            {
                this.curProduceTroopUi.visible = false;
                this.remainAmount = 0;
                produceAmount = 0;
            };
            queueContainer.removeAllChildren();
            this.uiCache.reset();
            if (_arg_1.length > 1)
            {
                _local_4 = 1;
                while (_local_4 < _arg_1.length)
                {
                    _local_5 = (this.uiCache.getUI(SWProduceUI) as SWProduceUI);
                    _local_5.produceBean = _arg_1[_local_4];
                    queueContainer.addChild(_local_5);
                    _local_4++;
                };
            };
        }

        public function ___Barrack_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set needAllTime(_arg_1:String):void
        {
            var _local_2:Object = this._1693588840needAllTime;
            if (_local_2 !== _arg_1)
            {
                this._1693588840needAllTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needAllTime", _local_2, _arg_1));
            };
        }

        private function doSpeedUp(_arg_1:CommonProduceEvent):void
        {
            var _local_2:int = Context.getInstance().getCurCastle().id;
            if (_arg_1.eventName == Barrack.EVENT_SPEEDUP)
            {
                ActionFactory.getInstance().getTroopCommands().accTroopProduce(_local_2, getBuildingBean().positionId, _arg_1.produceBean.queueId, _arg_1.speedUpItem.id);
            }
            else
            {
                ActionFactory.getInstance().getTroopCommands().accTroopProduce(_local_2, getBuildingBean().positionId, _arg_1.produceBean.queueId, CommonConstants.FREE_SPEED_ITEM_ID);
            };
        }

        private function onProduceTroopResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refreshQueue();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _Barrack_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Lang.msg("总训练时间") + ": ") + needAllTime);
            _local_1 = Lang.msg("正在训练");
            _local_1 = ((((Lang.msg("等待队列") + ": ") + this.remainAmount) + "/") + (this.buildingBean.level - this.produceAmount));
            _local_1 = TFConstants.T_PEASANTS;
            _local_1 = TFConstants.T_MILITIA;
            _local_1 = TFConstants.T_SCOUTER;
            _local_1 = TFConstants.T_PIKEMAN;
            _local_1 = TFConstants.T_SWORDSMEN;
            _local_1 = TFConstants.T_ARCHER;
            _local_1 = TFConstants.T_LIGHTCAVALRY;
            _local_1 = TFConstants.T_HEAVYCAVALRY;
            _local_1 = TFConstants.T_CARRIAGE;
            _local_1 = TFConstants.T_BALLISTA;
            _local_1 = TFConstants.T_BATTERINGRAM;
            _local_1 = TFConstants.T_CATAPULT;
        }

        [Bindable(event="propertyChange")]
        private function get produceAmount():int
        {
            return (this._93839704produceAmount);
        }

        private function _Barrack_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("总训练时间") + ": ") + needAllTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Barrack_Label1.text = _arg_1;
            }, "_Barrack_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("正在训练");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Barrack_Label2.text = _arg_1;
            }, "_Barrack_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((Lang.msg("等待队列") + ": ") + this.remainAmount) + "/") + (this.buildingBean.level - this.produceAmount));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Barrack_Label3.text = _arg_1;
            }, "_Barrack_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PEASANTS);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI1.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI1.bakTypeId");
            result[3] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_MILITIA);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI2.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI2.bakTypeId");
            result[4] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SCOUTER);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI3.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI3.bakTypeId");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PIKEMAN);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI4.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI4.bakTypeId");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SWORDSMEN);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI5.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI5.bakTypeId");
            result[7] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_ARCHER);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI6.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI6.bakTypeId");
            result[8] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_LIGHTCAVALRY);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI7.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI7.bakTypeId");
            result[9] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_HEAVYCAVALRY);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI8.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI8.bakTypeId");
            result[10] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CARRIAGE);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI9.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI9.bakTypeId");
            result[11] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BALLISTA);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI10.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI10.bakTypeId");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BATTERINGRAM);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI11.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI11.bakTypeId");
            result[13] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CATAPULT);
            }, function (_arg_1:int):void
            {
                _Barrack_SWTypeUI12.bakTypeId = _arg_1;
            }, "_Barrack_SWTypeUI12.bakTypeId");
            result[14] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get SWTypeContainer():Tile
        {
            return (this._1368160669SWTypeContainer);
        }

        [Bindable(event="propertyChange")]
        public function get queueContainer():VBox
        {
            return (this._1974405520queueContainer);
        }

        [Bindable(event="propertyChange")]
        private function get buildingBean():BuildingBean
        {
            return (this._982966140buildingBean);
        }

        override public function initialize():void
        {
            var target:Barrack;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Barrack_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_barrack_BarrackWatcherSetupUtil");
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

        private function onCancelResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                refreshQueue();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get needAllTime():String
        {
            return (this._1693588840needAllTime);
        }

        private function onGetProduceQueue(_arg_1:ProduceQueueResponse):void
        {
            var _local_4:ArrayCollection;
            var _local_2:ArrayCollection = _arg_1.allProduceQueueArray;
            var _local_3:int;
            while (_local_3 < _local_2.length)
            {
                if (AllProduceBean(_local_2.getItemAt(_local_3)).positionId == this.buildingBean.positionId)
                {
                    _local_4 = AllProduceBean(_local_2.getItemAt(_local_3)).allProduceQueueArray;
                    if (_local_4.length > 0)
                    {
                        TownView.setBuildingStatus(Context.getInstance().getCurCastle().id, getBuildingBean().positionId, true);
                    }
                    else
                    {
                        TownView.setBuildingStatus(Context.getInstance().getCurCastle().id, getBuildingBean().positionId, false);
                    };
                    produceQueue(_local_4);
                };
                _local_3++;
            };
        }

        private function set produceAmount(_arg_1:int):void
        {
            var _local_2:Object = this._93839704produceAmount;
            if (_local_2 !== _arg_1)
            {
                this._93839704produceAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceAmount", _local_2, _arg_1));
            };
        }

        private function set queueArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1894017992queueArray;
            if (_local_2 !== _arg_1)
            {
                this._1894017992queueArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueArray", _local_2, _arg_1));
            };
        }

        public function set SWTypeContainer(_arg_1:Tile):void
        {
            var _local_2:Object = this._1368160669SWTypeContainer;
            if (_local_2 !== _arg_1)
            {
                this._1368160669SWTypeContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SWTypeContainer", _local_2, _arg_1));
            };
        }

        private function set remainAmount(_arg_1:int):void
        {
            var _local_2:Object = this._670137828remainAmount;
            if (_local_2 !== _arg_1)
            {
                this._670137828remainAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainAmount", _local_2, _arg_1));
            };
        }

        public function set curProduceTroopUi(_arg_1:SWProduceUI):void
        {
            var _local_2:Object = this._1269329178curProduceTroopUi;
            if (_local_2 !== _arg_1)
            {
                this._1269329178curProduceTroopUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curProduceTroopUi", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get queueArray():ArrayCollection
        {
            return (this._1894017992queueArray);
        }

        private function doProduce(_arg_1:CommonProduceEvent):void
        {
            var _local_3:int;
            var _local_2:int;
            if (_arg_1.isShareTroop)
            {
                _local_2 = 0;
            }
            else
            {
                _local_2 = getBuildingBean().positionId;
            };
            if (_arg_1.produceNum > 0)
            {
                _local_3 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getTroopCommands().produceTroop(_local_3, _local_2, _arg_1.typeId, _arg_1.produceNum, _arg_1.isShareTroop, _arg_1.toIdle);
            };
        }

        override public function refresh():void
        {
            trace((this.className + " refresh()"));
            this.buildingBean = this.getBuildingBean();
            oldLevel = buildingBean.level;
            this.refreshTypeList();
            this.refreshQueue();
        }

        [Bindable(event="propertyChange")]
        private function get remainAmount():int
        {
            return (this._670137828remainAmount);
        }

        private function doCancel(event:CommonProduceEvent):void
        {
            var onCancleOk:Function;
            onCancleOk = function (_arg_1:Boolean):void
            {
                var _local_2:int;
                trace((((className + ".onCancleOk(") + _arg_1) + ")"));
                if (_arg_1)
                {
                    _local_2 = Context.getInstance().getCurCastle().id;
                    ActionFactory.getInstance().getTroopCommands().cancelTroopProduce(_local_2, getBuildingBean().positionId, event.produceBean.queueId);
                };
            };
            AlertWin.show(Lang.msg("确定取消"), onCancleOk);
        }

        public function set queueContainer(_arg_1:VBox):void
        {
            var _local_2:Object = this._1974405520queueContainer;
            if (_local_2 !== _arg_1)
            {
                this._1974405520queueContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueContainer", _local_2, _arg_1));
            };
        }

        public function set labelContainer(_arg_1:Canvas):void
        {
            var _local_2:Object = this._949911571labelContainer;
            if (_local_2 !== _arg_1)
            {
                this._949911571labelContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "labelContainer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get labelContainer():Canvas
        {
            return (this._949911571labelContainer);
        }

        private function refreshTypeList():void
        {
            var _local_1:SWTypeUI;
            for each (_local_1 in this.SWTypeContainer.getChildren())
            {
                _local_1.btnEnable = false;
            };
            ActionFactory.getInstance().getTroopCommands().getTroopProduceList(Context.getInstance().getCurCastle().id, this.getBuildingBean().positionId);
        }

        [Bindable(event="propertyChange")]
        public function get curProduceTroopUi():SWProduceUI
        {
            return (this._1269329178curProduceTroopUi);
        }

        private function refreshQueue():void
        {
            this.curProduceTroopUi.visible = false;
            ActionFactory.getInstance().getTroopCommands().getProduceQueue(Context.getInstance().getCurCastle().id);
        }


    }
}//package view.module.barrack

