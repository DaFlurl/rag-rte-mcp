// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.BaseNewBuildingWin

package view.castle
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.guide.GuideArrow;
    import mx.collections.ArrayCollection;
    import mx.containers.Tile;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import view.AllWindows;
    import view.ui.BuildingType;
    import com.evony.events.NewBuildingCommandEvent;
    import com.evony.common.module.castle.AvailableBuilingListResponse;
    import com.evony.common.constants.ErrorCode;
    import com.evony.GameConfig;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ChatFrame;
    import com.evony.data.FbData;
    import view.RandomEventWin;
    import view.module.guide.GuideStep;
    import mx.events.PropertyChangeEvent;
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

    public class BaseNewBuildingWin extends BaseFunctionWindow implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1893616730step101:GuideArrow;
        private var _1893610003step801:GuideArrow;
        private var selectTypeId:int;
        private var _95356390dataP:ArrayCollection;
        private var _2124672093builtContainer:Tile;
        private var positionId:int;
        private var _1893611925step601:GuideArrow;
        private var isCanBuildHelp:Boolean = false;
        private var _109761253step1:GuideArrow;
        private var _1893610964step701:GuideArrow;
        private var _1893609042step901:GuideArrow;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Tile,
                        "id":"builtContainer",
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "33";
                            this.right = "33";
                            this.top = "42";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"auto"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step1",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "92";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step601",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "210";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step701",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "325";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step801",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "443";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step901",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "325";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"step101",
                        "stylesFactory":function ():void
                        {
                            this.top = "180";
                            this.left = "325";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowTGuide"});
                        }
                    })]});
            }
        });
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BaseNewBuildingWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___BaseNewBuildingWin_BaseFunctionWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BaseNewBuildingWin._watcherSetupUtil = _arg_1;
        }


        public function ___BaseNewBuildingWin_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:BaseNewBuildingWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BaseNewBuildingWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_BaseNewBuildingWinWatcherSetupUtil");
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

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(this.getListeEventName(), onGetAvailableBuildingList);
        }

        private function onNewBuildingButtonClick(_arg_1:int):void
        {
            var _local_2:int;
            var _local_5:BuildingBean;
            if (_arg_1 == BuildingConstants.TYPE_WALL)
            {
                _local_2 = BuildingConstants.POSITION_WALL;
            }
            else
            {
                _local_2 = this.positionId;
            };
            var _local_3:int = Context.getInstance().getCurCastle().id;
            trace(((((((this.className + ".createNewBuilding type=") + _arg_1) + " castleId=") + _local_3) + " positionId=") + _local_2));
            selectTypeId = _arg_1;
            var _local_4:int;
            for each (_local_5 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_5.status != BuildingConstants.STATUS_NORMAL)
                {
                    _local_4++;
                };
            };
            if (_local_4 == 0)
            {
                ActionFactory.getInstance().getCastleCommands().newBuilding(_local_3, _local_2, _arg_1, onBuildResponse);
            }
            else
            {
                if (!Context.getInstance().needUserGuide)
                {
                    ActionFactory.getInstance().getCastleCommands().newBuilding(_local_3, _local_2, _arg_1, onBuildResponse);
                };
            };
            AllWindows.closeAll();
        }

        [Bindable(event="propertyChange")]
        public function get step101():GuideArrow
        {
            return (this._1893616730step101);
        }

        protected function checkGuideText():void
        {
        }

        private function onGetAvailableBuildingList(_arg_1:AvailableBuilingListResponse):void
        {
            var _local_3:BuildingType;
            this.uiCache.reset();
            var _local_2:int;
            while (_local_2 < _arg_1.builingListArray.length)
            {
                _local_3 = (this.uiCache.getUI(BuildingType) as BuildingType);
                builtContainer.addChild(_local_3);
                _local_3.bean = _arg_1.getBuilingList(_local_2);
                _local_3.removeEventListener(NewBuildingCommandEvent.EVENT_NAME, sendHandler);
                _local_3.addEventListener(NewBuildingCommandEvent.EVENT_NAME, sendHandler);
                _local_2++;
            };
            this.builtContainer.enabled = true;
        }

        [Bindable(event="propertyChange")]
        public function get step901():GuideArrow
        {
            return (this._1893609042step901);
        }

        private function onBuildResponse(_arg_1:CommandResponse):void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            var _local_4:Object;
            if (((GameConfig.instance.enableBuildingQueue) && ((_arg_1.ok == ErrorCode.TOWNHALL_LEVEL_UNSUPPORT) || (_arg_1.ok == ErrorCode.NO_DEPEND_BUILDING))))
            {
                if (Context.getInstance().isItemEnough("player.queue.building"))
                {
                    AlertWin.show(Lang.msg("需要排队"), checkQueueBuilding);
                }
                else
                {
                    AlertWin.show(Lang.msg("需要排队及道具"), checkQueueBuilding);
                };
            }
            else
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(_arg_1.errorMsg);
                    if (_arg_1.ok == ErrorCode.INVALID_BUILDING_STATUS)
                    {
                        _local_2 = Context.getInstance().getCurCastle().buildingsArray;
                        _local_3 = 0;
                        while (_local_3 < _local_2.length)
                        {
                            if (((_local_2[_local_3].positionId == this.positionId) || (_local_2[_local_3].positionId == BuildingConstants.POSITION_WALL)))
                            {
                                ChatFrame.instance.buildToDebugString(_local_2[_local_3].toDebugString());
                            };
                            _local_3++;
                        };
                    };
                }
                else
                {
                    if (((Context.getInstance().isBuildHelp) && (this.isCanBuildHelp)))
                    {
                        _local_4 = FbData.getInstance().getValue(20045);
                        if (_local_4 != null)
                        {
                            RandomEventWin.show(11);
                        };
                    };
                };
            };
        }

        private function sendHandler(_arg_1:NewBuildingCommandEvent):void
        {
            isCanBuildHelp = _arg_1.isCanBuildHelp;
            onNewBuildingButtonClick(_arg_1.buildingType);
        }

        public function sendCommand():void
        {
            trace((this.className + " sendCommand()"));
        }

        [Bindable(event="propertyChange")]
        public function get builtContainer():Tile
        {
            return (this._2124672093builtContainer);
        }

        private function checkQueueBuilding(_arg_1:Boolean):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                if (this.selectTypeId == BuildingConstants.TYPE_WALL)
                {
                    _local_2 = BuildingConstants.POSITION_WALL;
                }
                else
                {
                    _local_2 = this.positionId;
                };
                ActionFactory.getInstance().getCastleCommands().newBuildingQueue(Context.getInstance().getCurCastle().id, this.selectTypeId, 1, _local_2, onNewBuildingQueueResponse);
            };
        }

        private function _BaseNewBuildingWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((GuideStep.getInstance().currentStep == 1) && (this.className == "NewInnerBuilding")) || ((GuideStep.getInstance().currentStep == 501) && (this.className == "NewOutsideBuilding")));
            _local_1 = (((GuideStep.getInstance().currentStep == 1) && (this.className == "NewInnerBuilding")) || ((GuideStep.getInstance().currentStep == 501) && (this.className == "NewOutsideBuilding")));
            _local_1 = ((GuideStep.getInstance().currentStep == 601) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 601) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 701) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 701) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 801) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 801) && (this.className == "NewOutsideBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 901) && (this.className == "NewInnerBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 901) && (this.className == "NewInnerBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 101) && (this.className == "NewInnerBuilding"));
            _local_1 = ((GuideStep.getInstance().currentStep == 101) && (this.className == "NewInnerBuilding"));
        }

        public function setSpace(_arg_1:int):void
        {
            this.positionId = _arg_1;
            Context.getInstance().positionId = this.positionId;
        }

        public function set builtContainer(_arg_1:Tile):void
        {
            var _local_2:Object = this._2124672093builtContainer;
            if (_local_2 !== _arg_1)
            {
                this._2124672093builtContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "builtContainer", _local_2, _arg_1));
            };
        }

        private function _BaseNewBuildingWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 1) && (this.className == "NewInnerBuilding")) || ((GuideStep.getInstance().currentStep == 501) && (this.className == "NewOutsideBuilding")));
            }, function (_arg_1:Boolean):void
            {
                step1.includeInLayout = _arg_1;
            }, "step1.includeInLayout");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 1) && (this.className == "NewInnerBuilding")) || ((GuideStep.getInstance().currentStep == 501) && (this.className == "NewOutsideBuilding")));
            }, function (_arg_1:Boolean):void
            {
                step1.visible = _arg_1;
            }, "step1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 601) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step601.includeInLayout = _arg_1;
            }, "step601.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 601) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step601.visible = _arg_1;
            }, "step601.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 701) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step701.includeInLayout = _arg_1;
            }, "step701.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 701) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step701.visible = _arg_1;
            }, "step701.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 801) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step801.includeInLayout = _arg_1;
            }, "step801.includeInLayout");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 801) && (this.className == "NewOutsideBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step801.visible = _arg_1;
            }, "step801.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 901) && (this.className == "NewInnerBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step901.includeInLayout = _arg_1;
            }, "step901.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 901) && (this.className == "NewInnerBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step901.visible = _arg_1;
            }, "step901.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 101) && (this.className == "NewInnerBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step101.includeInLayout = _arg_1;
            }, "step101.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 101) && (this.className == "NewInnerBuilding"));
            }, function (_arg_1:Boolean):void
            {
                step101.visible = _arg_1;
            }, "step101.visible");
            result[11] = binding;
            return (result);
        }

        public function set step101(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1893616730step101;
            if (_local_2 !== _arg_1)
            {
                this._1893616730step101 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step101", _local_2, _arg_1));
            };
        }

        public function set step601(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1893611925step601;
            if (_local_2 !== _arg_1)
            {
                this._1893611925step601 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step601", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            super.refresh();
            trace((this.className + " refresh()"));
            this.builtContainer.enabled = false;
            builtContainer.removeAllChildren();
            this.sendCommand();
            if (Context.getInstance().needUserGuide)
            {
                checkGuideText();
            };
        }

        public function set step901(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1893609042step901;
            if (_local_2 !== _arg_1)
            {
                this._1893609042step901 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step901", _local_2, _arg_1));
            };
        }

        private function onNewBuildingQueueResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set step801(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1893610003step801;
            if (_local_2 !== _arg_1)
            {
                this._1893610003step801 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step801", _local_2, _arg_1));
            };
        }

        public function set step1(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._109761253step1;
            if (_local_2 !== _arg_1)
            {
                this._109761253step1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step1", _local_2, _arg_1));
            };
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get step1():GuideArrow
        {
            return (this._109761253step1);
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }

        public function set step701(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1893610964step701;
            if (_local_2 !== _arg_1)
            {
                this._1893610964step701 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "step701", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get step601():GuideArrow
        {
            return (this._1893611925step601);
        }

        [Bindable(event="propertyChange")]
        public function get step701():GuideArrow
        {
            return (this._1893610964step701);
        }

        public function getListeEventName():String
        {
            return (ResponseDispatcher.CASTLE_GET_AVAILABLE_BUILDING_LIST_INSIDE);
        }

        [Bindable(event="propertyChange")]
        public function get step801():GuideArrow
        {
            return (this._1893610003step801);
        }


    }
}//package view.castle

