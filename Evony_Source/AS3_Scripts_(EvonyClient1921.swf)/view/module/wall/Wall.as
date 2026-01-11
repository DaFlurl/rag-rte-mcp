// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.wall.Wall

package view.module.wall
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.containers.VBox;
    import mx.binding.utils.ChangeWatcher;
    import mx.containers.Tile;
    import mx.containers.Canvas;
    import com.evony.common.beans.BuildingBean;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Image;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.beans.FortProduceListBean;
    import com.evony.common.module.fortifications.FortProduceListResponse;
    import com.evony.common.beans.AllProduceBean;
    import com.evony.common.beans.ProduceBean;
    import com.evony.common.module.troop.ProduceQueueResponse;
    import flash.events.Event;
    import com.evony.Context;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.MsgDispacther;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.util.UIUtil;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import com.evony.events.CommonProduceEvent;
    import com.evony.Lang;
    import com.evony.common.constants.TFConstants;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.utils.BindingUtils;
    import mx.events.FlexEvent;
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

    public class Wall extends BaseBuildingWindow implements IBindingClient 
    {

        public static var wallInstance:Wall;
        public static const EVENT_SHOW:String = "Wall.show";
        public static const EVENT_PRODUCE:String = "wall.produce.open";
        public static const EVENT_SPEEDUP:String = "wall.speedUp";
        public static const EVENT_CANCEL:String = "wall.cancel";
        public static const EVENT_REFRESH:String = "wall.refresh";
        public static const EVENT_FREE_SPEEDUP:String = "free.speedup";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _93839704produceAmount:int;
        public var _Wall_Label1:Label;
        public var _Wall_Label2:Label;
        public var _Wall_Label3:Label;
        public var _Wall_Label4:Label;
        public var _Wall_Label5:Label;
        public var _Wall_Label6:Label;
        private var _1269329178curProduceTroopUi:CastleDefProduceUI;
        private var _1974405520queueContainer:VBox;
        private var castleDefProduce:CastleDefProduce;
        private var _670137828remainAmount:int = 0;
        private var cw:ChangeWatcher;
        private var _1693588840needAllTime:String;
        private var castleDefDemolition:CastleDefDemolition;
        private var oldLevel:int;
        private var allWaitTime:Number;
        private var _1730759999leftSpace:int;
        private var _1748938087produceTypeContainer:Tile;
        private var _949911571labelContainer:Canvas;
        public var _Wall_CastleDefTypeUI1:CastleDefTypeUI;
        public var _Wall_CastleDefTypeUI2:CastleDefTypeUI;
        public var _Wall_CastleDefTypeUI3:CastleDefTypeUI;
        public var _Wall_CastleDefTypeUI4:CastleDefTypeUI;
        public var _Wall_CastleDefTypeUI5:CastleDefTypeUI;
        private var _982966140buildingBean:BuildingBean;
        private var currentProduceNum:int;
        private var _72490167usedSpace:int;
        private var _716599262totalSpace:int;

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
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":315,
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Wall_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "styleName":"ParamgraphText1",
                                            "width":246
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Wall_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Wall_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "120";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "width":150
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.top = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.top = "115";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"images/Controls/tab/line.png",
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"queueContainer",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "142";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CastleDefProduceUI,
                                    "id":"curProduceTroopUi",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "65";
                                        this.left = "5";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"produceTypeContainer",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "30";
                            this.horizontalGap = 5;
                            this.paddingLeft = 5;
                            this.paddingTop = 5;
                            this.paddingBottom = 5;
                            this.verticalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":435,
                                "horizontalScrollPolicy":"off",
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":CastleDefTypeUI,
                                    "id":"_Wall_CastleDefTypeUI1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"y":360});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CastleDefTypeUI,
                                    "id":"_Wall_CastleDefTypeUI2"
                                }), new UIComponentDescriptor({
                                    "type":CastleDefTypeUI,
                                    "id":"_Wall_CastleDefTypeUI3"
                                }), new UIComponentDescriptor({
                                    "type":CastleDefTypeUI,
                                    "id":"_Wall_CastleDefTypeUI4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"y":270});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CastleDefTypeUI,
                                    "id":"_Wall_CastleDefTypeUI5",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"y":180});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":435,
                                "height":25,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Wall_Label4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ParamgraphText1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Wall_Label5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ParamgraphText1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Wall_Label6",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ParamgraphText1"});
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1164508265queueAry:ArrayCollection = new ArrayCollection();
        private var castleDefTypeUiMap:Object = new Object();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Wall()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Wall_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Wall._watcherSetupUtil = _arg_1;
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

        private function init():void
        {
            var castleDefUi:CastleDefTypeUI;
            var onGetFortificationsProduceList:Function;
            var onGetProduceQueue:Function;
            var onRefreshEvent:Function;
            var onRefreshBuildingEvent:Function;
            var onProduceResponse:Function;
            var onCancelResponse:Function;
            onGetFortificationsProduceList = function (_arg_1:FortProduceListResponse):void
            {
                var _local_2:int;
                var _local_3:FortProduceListBean;
                var _local_4:CastleDefTypeUI;
                if (_arg_1.ok)
                {
                    _local_2 = 0;
                    while (_local_2 < _arg_1.fortListArray.length)
                    {
                        _local_3 = _arg_1.getFortList(_local_2);
                        _local_4 = (castleDefTypeUiMap[_local_3.typeId] as CastleDefTypeUI);
                        _local_4.bean = _local_3;
                        _local_2++;
                    };
                    produceTypeContainer.enabled = true;
                }
                else
                {
                    trace(((className + "onGetResearchList error: ") + _arg_1.errorMsg));
                };
            };
            onGetProduceQueue = function (_arg_1:ProduceQueueResponse):void
            {
                var _local_3:int;
                var _local_4:CastleDefProduceUI;
                trace(("onGetProduceQueue" + _arg_1.allProduceQueueArray.length));
                currentProduceNum = 0;
                allWaitTime = 0;
                var _local_2:ArrayCollection = AllProduceBean(_arg_1.allProduceQueueArray.getItemAt(0)).allProduceQueueArray;
                if (_local_2.length > 0)
                {
                    curProduceTroopUi.produceBean = _local_2[0];
                    curProduceTroopUi.visible = true;
                    remainAmount = (_local_2.length - 1);
                    produceAmount = 1;
                    currentProduceNum = (currentProduceNum + CastleDefProduce.getInstance().countFortSpace(_local_2[0].type, _local_2[0].num));
                }
                else
                {
                    curProduceTroopUi.visible = false;
                    remainAmount = 0;
                    produceAmount = 0;
                };
                queueContainer.removeAllChildren();
                uiCache.reset();
                if (_local_2.length > 1)
                {
                    _local_3 = 1;
                    while (_local_3 < _local_2.length)
                    {
                        _local_4 = (uiCache.getUI(CastleDefProduceUI) as CastleDefProduceUI);
                        _local_4.produceBean = _local_2[_local_3];
                        currentProduceNum = (currentProduceNum + CastleDefProduce.getInstance().countFortSpace(_local_2[_local_3].type, _local_2[_local_3].num));
                        queueContainer.addChild(_local_4);
                        allWaitTime = (allWaitTime + ProduceBean(_local_2[_local_3]).costTime);
                        _local_3++;
                    };
                };
                countSpace();
            };
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
            onProduceResponse = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    refreshQueue();
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            onCancelResponse = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    refreshQueue();
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            wallInstance = this;
            for each (castleDefUi in this.produceTypeContainer.getChildren())
            {
                trace(((this.className + ".init() addcastleDefTypeUiId=") + castleDefUi.castleDefTypeId));
                this.castleDefTypeUiMap[castleDefUi.castleDefTypeId] = castleDefUi;
            };
            MsgDispacther.getInstance().addEventListener(EVENT_CANCEL, doCancel);
            MsgDispacther.getInstance().addEventListener(EVENT_SPEEDUP, doSpeedUp);
            MsgDispacther.getInstance().addEventListener(EVENT_FREE_SPEEDUP, doSpeedUp);
            MsgDispacther.getInstance().addEventListener(EVENT_PRODUCE, doProduce);
            MsgDispacther.getInstance().addEventListener(EVENT_REFRESH, onRefreshEvent);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_GET_FORTIFICATIONS_PRODUCE_LIST, onGetFortificationsProduceList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_GET_PRODUCE_QUEUE, onGetProduceQueue);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FORTIFICATIONS_UPDATE, onRefreshEvent);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onRefreshBuildingEvent);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_PRODUCE_WALL_PROTECT, onProduceResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_CANCEL_FORTIFICATION_PRODUCE, onCancelResponse);
        }

        private function enterFrameHandler(_arg_1:Event):void
        {
            var _local_2:Number = curProduceTroopUi.getLeftTime();
            needAllTime = UIUtil.timeToString((_local_2 + allWaitTime));
        }

        [Bindable(event="propertyChange")]
        private function get totalSpace():int
        {
            return (this._716599262totalSpace);
        }

        private function countSpace():void
        {
            var _local_3:String;
            var _local_1:Object = Context.getInstance().getCurCastle().fortification.toObject();
            var _local_2:int;
            for (_local_3 in _local_1)
            {
                switch (_local_3)
                {
                    case "abatis":
                        _local_2 = (_local_2 + (_local_1[_local_3] * 2));
                        break;
                    case "arrowTower":
                        _local_2 = (_local_2 + (_local_1[_local_3] * 3));
                        break;
                    case "rockfall":
                        _local_2 = (_local_2 + (_local_1[_local_3] * 5));
                        break;
                    case "rollingLogs":
                        _local_2 = (_local_2 + (_local_1[_local_3] * 4));
                        break;
                    case "trap":
                        _local_2 = (_local_2 + (_local_1[_local_3] * 1));
                        break;
                };
            };
            this.usedSpace = (_local_2 + this.currentProduceNum);
            this.leftSpace = (this.totalSpace - this.usedSpace);
        }

        public function set changeCastleSpace(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 1:
                    this.totalSpace = 1000;
                    break;
                case 2:
                    this.totalSpace = 3000;
                    break;
                case 3:
                    this.totalSpace = 6000;
                    break;
                case 4:
                    this.totalSpace = 10000;
                    break;
                case 5:
                    this.totalSpace = 15000;
                    break;
                case 6:
                    this.totalSpace = 21000;
                    break;
                case 7:
                    this.totalSpace = 28000;
                    break;
                case 8:
                    this.totalSpace = 36000;
                    break;
                case 9:
                    this.totalSpace = 45000;
                    break;
                case 10:
                    this.totalSpace = 55000;
                    break;
            };
            this.countSpace();
        }

        private function doSpeedUp(event:CommonProduceEvent):void
        {
            var onSpeedResponse:Function;
            onSpeedResponse = function (_arg_1:CommandResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    refreshQueue();
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            var cid:int = Context.getInstance().getCurCastle().id;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_ACC_TROOP_PRODUCE, onSpeedResponse, false, 0, true);
            if (event.eventName == Wall.EVENT_SPEEDUP)
            {
                ActionFactory.getInstance().getFortificationsCommands().accTroopProduce(cid, event.produceBean.queueId, event.speedUpItem.id);
            }
            else
            {
                ActionFactory.getInstance().getFortificationsCommands().accTroopProduce(cid, event.produceBean.queueId, CommonConstants.FREE_SPEED_ITEM_ID);
            };
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

        private function set totalSpace(_arg_1:int):void
        {
            var _local_2:Object = this._716599262totalSpace;
            if (_local_2 !== _arg_1)
            {
                this._716599262totalSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalSpace", _local_2, _arg_1));
            };
        }

        private function set queueAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1164508265queueAry;
            if (_local_2 !== _arg_1)
            {
                this._1164508265queueAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueAry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get usedSpace():int
        {
            return (this._72490167usedSpace);
        }

        private function _Wall_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Lang.msg("总训练时间") + ":") + needAllTime);
            _local_1 = Lang.msg("正在训练");
            _local_1 = ((((Lang.msg("等待队列") + ": ") + this.remainAmount) + "/") + (this.buildingBean.level - this.produceAmount));
            _local_1 = TFConstants.F_TRAP;
            _local_1 = TFConstants.F_ABATIS;
            _local_1 = TFConstants.F_ARROWTOWER;
            _local_1 = TFConstants.F_ROLLINGLOGS;
            _local_1 = TFConstants.F_ROCKFALL;
            _local_1 = ((Lang.msg("城防空间") + ": ") + this.totalSpace);
            _local_1 = ((Lang.msg("已用空间") + ": ") + this.usedSpace);
            _local_1 = ((Lang.msg("剩余空间") + ": ") + this.leftSpace);
        }

        [Bindable(event="propertyChange")]
        public function get leftSpace():int
        {
            return (this._1730759999leftSpace);
        }

        public function removeListener():void
        {
            this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        [Bindable(event="propertyChange")]
        private function get produceAmount():int
        {
            return (this._93839704produceAmount);
        }

        [Bindable(event="propertyChange")]
        public function get produceTypeContainer():Tile
        {
            return (this._1748938087produceTypeContainer);
        }

        [Bindable(event="propertyChange")]
        public function get queueContainer():VBox
        {
            return (this._1974405520queueContainer);
        }

        public function set leftSpace(_arg_1:int):void
        {
            var _local_2:Object = this._1730759999leftSpace;
            if (_local_2 !== _arg_1)
            {
                this._1730759999leftSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftSpace", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get buildingBean():BuildingBean
        {
            return (this._982966140buildingBean);
        }

        override public function initialize():void
        {
            var target:Wall;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Wall_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_wall_WallWatcherSetupUtil");
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

        private function set usedSpace(_arg_1:int):void
        {
            var _local_2:Object = this._72490167usedSpace;
            if (_local_2 !== _arg_1)
            {
                this._72490167usedSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "usedSpace", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get queueAry():ArrayCollection
        {
            return (this._1164508265queueAry);
        }

        private function _Wall_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("总训练时间") + ":") + needAllTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label1.text = _arg_1;
            }, "_Wall_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("正在训练");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label2.text = _arg_1;
            }, "_Wall_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((Lang.msg("等待队列") + ": ") + this.remainAmount) + "/") + (this.buildingBean.level - this.produceAmount));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label3.text = _arg_1;
            }, "_Wall_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_TRAP);
            }, function (_arg_1:int):void
            {
                _Wall_CastleDefTypeUI1.castleDefTypeId = _arg_1;
            }, "_Wall_CastleDefTypeUI1.castleDefTypeId");
            result[3] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ABATIS);
            }, function (_arg_1:int):void
            {
                _Wall_CastleDefTypeUI2.castleDefTypeId = _arg_1;
            }, "_Wall_CastleDefTypeUI2.castleDefTypeId");
            result[4] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ARROWTOWER);
            }, function (_arg_1:int):void
            {
                _Wall_CastleDefTypeUI3.castleDefTypeId = _arg_1;
            }, "_Wall_CastleDefTypeUI3.castleDefTypeId");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ROLLINGLOGS);
            }, function (_arg_1:int):void
            {
                _Wall_CastleDefTypeUI4.castleDefTypeId = _arg_1;
            }, "_Wall_CastleDefTypeUI4.castleDefTypeId");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.F_ROCKFALL);
            }, function (_arg_1:int):void
            {
                _Wall_CastleDefTypeUI5.castleDefTypeId = _arg_1;
            }, "_Wall_CastleDefTypeUI5.castleDefTypeId");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("城防空间") + ": ") + this.totalSpace);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label4.text = _arg_1;
            }, "_Wall_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("已用空间") + ": ") + this.usedSpace);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label5.text = _arg_1;
            }, "_Wall_Label5.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("剩余空间") + ": ") + this.leftSpace);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Wall_Label6.text = _arg_1;
            }, "_Wall_Label6.text");
            result[10] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get needAllTime():String
        {
            return (this._1693588840needAllTime);
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

        private function set remainAmount(_arg_1:int):void
        {
            var _local_2:Object = this._670137828remainAmount;
            if (_local_2 !== _arg_1)
            {
                this._670137828remainAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "remainAmount", _local_2, _arg_1));
            };
        }

        public function set produceTypeContainer(_arg_1:Tile):void
        {
            var _local_2:Object = this._1748938087produceTypeContainer;
            if (_local_2 !== _arg_1)
            {
                this._1748938087produceTypeContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceTypeContainer", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            trace((this.className + ".refresh()"));
            this.buildingBean = this.getBuildingBean();
            oldLevel = buildingBean.level;
            this.refreshTypeList();
            this.refreshQueue();
            if (cw != null)
            {
                cw.unwatch();
            };
            cw = BindingUtils.bindProperty(this, "changeCastleSpace", this.buildingBean, "level");
            if (!this.hasEventListener(Event.ENTER_FRAME))
            {
                this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
            };
        }

        private function doProduce(_arg_1:CommonProduceEvent):void
        {
            var _local_2:int;
            if (_arg_1.produceNum > 0)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getFortificationsCommands().produceWallProtect(_local_2, _arg_1.typeId, _arg_1.produceNum);
            };
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
                    ActionFactory.getInstance().getFortificationsCommands().cancelFortificationProduce(_local_2, event.produceBean.queueId);
                };
            };
            AlertWin.show(Lang.msg("确定取消"), onCancleOk);
        }

        [Bindable(event="propertyChange")]
        public function get curProduceTroopUi():CastleDefProduceUI
        {
            return (this._1269329178curProduceTroopUi);
        }

        [Bindable(event="propertyChange")]
        public function get labelContainer():Canvas
        {
            return (this._949911571labelContainer);
        }

        public function ___Wall_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function refreshTypeList():void
        {
            this.produceTypeContainer.enabled = false;
            ActionFactory.getInstance().getFortificationsCommands().getFortificationsProduceList(Context.getInstance().getCurCastle().id);
        }

        private function refreshQueue():void
        {
            ActionFactory.getInstance().getFortificationsCommands().getProduceQueue(Context.getInstance().getCurCastle().id);
        }

        public function set curProduceTroopUi(_arg_1:CastleDefProduceUI):void
        {
            var _local_2:Object = this._1269329178curProduceTroopUi;
            if (_local_2 !== _arg_1)
            {
                this._1269329178curProduceTroopUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curProduceTroopUi", _local_2, _arg_1));
            };
        }


    }
}//package view.module.wall

