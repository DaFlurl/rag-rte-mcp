// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.util.EvonyImage;
    import com.evony.common.beans.BuildingQueueBean;
    import mx.controls.Image;
    import com.evony.common.beans.BuildingBean;
    import flash.utils.Timer;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.factory.ItemManager;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.events.TimerEvent;
    import mx.binding.Binding;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.util.UIUtil;
    import flash.external.ExternalInterface;
    import com.evony.eum.ItemEum;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
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

    public class BuildingBar extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _982612129buildingName:Label;
        private var _549915252firstBtn:Button;
        private var _2126000581buildingPBinstance:EvonyImage;
        public var _BuildingBar_Label4:Label;
        private var isLowFiveMimutes:Boolean;
        private var _1009154035buildingQueueBean:BuildingQueueBean;
        private var _615271122doneTimePer:Number;
        private var _1060223401myName:String;
        private var _1161124207doneTime:Number;
        private var _1739464226queueText:String;
        public var callBack:Function;
        private var _1775566259isBuildingQueue:Boolean = false;
        public var _BuildingBar_Image1:Image;
        private var _1185107632imgBar:Object;
        private var _1829946124buildingEndTime:Number;
        private var _1164489825queueTxt:Label;
        private var _982966140buildingBean:BuildingBean;
        private var time:Number = 0;
        private var _155830162situationTxt:Label;
        private var _1921309049showLevel:int;
        private var _164812141isUpdate:Boolean = true;
        private var myTimer:Timer;
        private var _1916786312imgPath:Object;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":23,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":425,
                                "height":23,
                                "styleName":"schedulel",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"buildingPBinstance",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":23});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"situationTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "75";
                                        this.top = "0";
                                        this.textAlign = "right";
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "width":144,
                                            "filters":[_BuildingBar_GlowFilter1_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"queueTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "180";
                                        this.top = "0";
                                        this.textAlign = "right";
                                        this.color = 0xFFFFFF;
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "width":144,
                                            "filters":[_BuildingBar_GlowFilter2_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "32";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"buildingName",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"filters":[_BuildingBar_GlowFilter3_c()]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BuildingBar_Label4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"filters":[_BuildingBar_GlowFilter4_c()]});
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_BuildingBar_Image1",
                                    "events":{
                                        "complete":"___BuildingBar_Image1_complete",
                                        "updateComplete":"___BuildingBar_Image1_updateComplete"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.left = "10";
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"firstBtn",
                        "events":{"click":"__firstBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "10";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"Speedup"});
                        }
                    })]
                });
            }
        });
        private var buidingUpdate:Class = BuildingBar_buidingUpdate;
        private var buildingDisClass:Class = BuildingBar_buildingDisClass;
        private var buidingQueueUpdate:Class = BuildingBar_buidingQueueUpdate;
        private var buildingQueueDisClass:Class = BuildingBar_buildingQueueDisClass;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuildingBar()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 23;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___BuildingBar_Canvas1_creationComplete);
        }

        public static function secondToString(_arg_1:Number):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:* = "";
            if (_arg_1 >= 0)
            {
                _local_3 = int((_arg_1 / (60 * 60)));
                if (_local_3 > 0)
                {
                    _local_2 = (_local_2 + ((_local_3 + Lang.msg("时")) + " "));
                };
                _local_4 = int(((_arg_1 / 60) % 60));
                if (((_local_2.length > 0) || (_local_4 > 0)))
                {
                    _local_2 = (_local_2 + ((_local_4 + Lang.msg("分")) + " "));
                };
                if (_local_3 == 0)
                {
                    _local_5 = (_arg_1 % 60);
                    if (_local_5 < 10)
                    {
                        _local_2 = (_local_2 + "0");
                    };
                    _local_2 = (_local_2 + (_local_5 + Lang.msg("秒")));
                };
            };
            return (_local_2);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuildingBar._watcherSetupUtil = _arg_1;
        }


        public function set myBuilding(_arg_1:BuildingBean):void
        {
            this.isBuildingQueue = false;
            this.buildingBean = _arg_1;
            this.buildingEndTime = _arg_1.endTime;
            this.getTypeProperty();
            remainTime(this.buildingBean.endTime);
            if (this.isUpdate)
            {
                this.showLevel = (_arg_1.level + 1);
            }
            else
            {
                this.showLevel = (_arg_1.level - 1);
            };
            this.queueText = null;
            this.myName = this.buildingBean.name;
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

        [Bindable(event="propertyChange")]
        private function get buildingQueueBean():BuildingQueueBean
        {
            return (this._1009154035buildingQueueBean);
        }

        private function set showLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1921309049showLevel;
            if (_local_2 !== _arg_1)
            {
                this._1921309049showLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showLevel", _local_2, _arg_1));
            };
        }

        private function onBuildingSpeedUp(_arg_1:MouseEvent):void
        {
            var _local_3:BuildingBean;
            var _local_4:BuildingBean;
            var _local_5:int;
            if (this.isBuildingQueue)
            {
                _local_4 = new BuildingBean();
                _local_4.name = this.buildingQueueBean.name;
                _local_4.typeId = this.buildingQueueBean.typeId;
                this.buildingQueueBean.level--;
                _local_4.positionId = this.buildingQueueBean.positionId;
                _local_4.status = BuildingConstants.STATUS_UPGRADING;
                if (_local_4.level < 0)
                {
                    _local_4.level = 0;
                };
                if (SpeedUpCheckOut.checkOutBuilding(_local_4))
                {
                    SpeedupItemSelector.getInstance().buildQueueBean = this.buildingQueueBean;
                    SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_BUILD_QUEUE_SPEED;
                    SpeedupItemSelector.show(ItemManager.speedItemArray, onBuildingSpeedUpItemSelected);
                }
                else
                {
                    _local_5 = Context.getInstance().getCurCastle().id;
                    ActionFactory.getInstance().getCastleCommands().speedupBuildingQueue(_local_5, this.buildingQueueBean.id, CommonConstants.FREE_SPEED_ITEM_ID, onCommandResponse);
                    isLowFiveMimutes = true;
                };
                return;
            };
            var _local_2:int;
            for each (_local_3 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_3.status != BuildingConstants.STATUS_NORMAL)
                {
                    _local_2++;
                };
            };
            if (buildingBean.status == BuildingConstants.STATUS_DESTRUCTING)
            {
                SpeedupItemSelector.getInstance().bean = buildingBean;
                SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_BUILD_SPEED;
                SpeedupItemSelector.show(ItemManager.speedItemArray, onBuildingSpeedUpItemSelected);
            }
            else
            {
                if (SpeedUpCheckOut.checkOutBuilding(buildingBean))
                {
                    SpeedupItemSelector.getInstance().bean = buildingBean;
                    SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_BUILD_SPEED;
                    SpeedupItemSelector.show(ItemManager.speedItemArray, onBuildingSpeedUpItemSelected);
                    if (Context.getInstance().isBuildHelp)
                    {
                        Context.getInstance().isSpeedType = 0;
                        Context.getInstance().buidwithhelpName = this.buildingBean.name;
                        Context.getInstance().buidwithhelpLevel = String(int((this.buildingBean.level + 1)));
                    };
                }
                else
                {
                    _local_5 = Context.getInstance().getCurCastle().id;
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_local_5, buildingBean.positionId, CommonConstants.FREE_SPEED_ITEM_ID, onCommandResponse);
                    isLowFiveMimutes = true;
                };
            };
        }

        private function init():void
        {
        }

        private function _BuildingBar_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
        }

        private function set imgPath(_arg_1:Object):void
        {
            var _local_2:Object = this._1916786312imgPath;
            if (_local_2 !== _arg_1)
            {
                this._1916786312imgPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgPath", _local_2, _arg_1));
            };
        }

        public function set firstBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._549915252firstBtn;
            if (_local_2 !== _arg_1)
            {
                this._549915252firstBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "firstBtn", _local_2, _arg_1));
            };
        }

        private function set buildingQueueBean(_arg_1:BuildingQueueBean):void
        {
            var _local_2:Object = this._1009154035buildingQueueBean;
            if (_local_2 !== _arg_1)
            {
                this._1009154035buildingQueueBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingQueueBean", _local_2, _arg_1));
            };
        }

        public function set situationTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._155830162situationTxt;
            if (_local_2 !== _arg_1)
            {
                this._155830162situationTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "situationTxt", _local_2, _arg_1));
            };
        }

        private function set isUpdate(_arg_1:Boolean):void
        {
            var _local_2:Object = this._164812141isUpdate;
            if (_local_2 !== _arg_1)
            {
                this._164812141isUpdate = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isUpdate", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get doneTimePer():Number
        {
            return (this._615271122doneTimePer);
        }

        [Bindable(event="propertyChange")]
        public function get buildingPBinstance():EvonyImage
        {
            return (this._2126000581buildingPBinstance);
        }

        private function timerHandler(_arg_1:TimerEvent=null):Boolean
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:Number;
            var _local_5:int;
            if (buildingBean != null)
            {
                _local_2 = new Date().valueOf();
                _local_3 = Context.getInstance().getTimeDiff();
                _local_4 = ((time + _local_3) - _local_2);
                _local_5 = (this.buildingBean.endTime - this.buildingBean.startTime);
                if (_local_4 > _local_5)
                {
                    _local_4 = _local_5;
                };
                doneTime = (_local_4 / 1000);
                if (_local_4 > 0)
                {
                    doneTimePer = ((1 - (_local_4 / _local_5)) * 100);
                    if (doneTimePer < 0)
                    {
                        doneTimePer = 0;
                        doneTime = 0;
                    };
                    return (true);
                };
                doneTimePer = 100;
                trace((((this.className + "remain=") + _local_4) + " timer stop."));
                if (((!(this.callBack == null)) && (this.myTimer.running)))
                {
                    this.callBack.apply(this);
                };
                this.myTimer.stop();
                return (false);
            };
            doneTimePer = 0;
            trace((((this.className + "remain=") + _local_4) + " timer stop."));
            this.situationTxt.text = "";
            if (((!(this.callBack == null)) && (this.myTimer.running)))
            {
                this.callBack.apply(this);
            };
            this.myTimer.stop();
            return (false);
        }

        public function set queueTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1164489825queueTxt;
            if (_local_2 !== _arg_1)
            {
                this._1164489825queueTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get imgBar():Object
        {
            return (this._1185107632imgBar);
        }

        private function _BuildingBar_GlowFilter4_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get myName():String
        {
            return (this._1060223401myName);
        }

        private function remainTime(_arg_1:Number):void
        {
            this.time = _arg_1;
            if (((!(isNaN(_arg_1))) && (time > 0)))
            {
                if (myTimer == null)
                {
                    myTimer = new Timer(1000, 0);
                    myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                };
                if (this.timerHandler())
                {
                    this.myTimer.start();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingName():Label
        {
            return (this._982612129buildingName);
        }

        private function set doneTimePer(_arg_1:Number):void
        {
            var _local_2:Object = this._615271122doneTimePer;
            if (_local_2 !== _arg_1)
            {
                this._615271122doneTimePer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doneTimePer", _local_2, _arg_1));
            };
        }

        private function set isBuildingQueue(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1775566259isBuildingQueue;
            if (_local_2 !== _arg_1)
            {
                this._1775566259isBuildingQueue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBuildingQueue", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get doneTime():Number
        {
            return (this._1161124207doneTime);
        }

        private function _BuildingBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (imgBar);
            }, function (_arg_1:Object):void
            {
                buildingPBinstance.source = _arg_1;
            }, "buildingPBinstance.source");
            result[0] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((414 * doneTimePer) / 100);
            }, function (_arg_1:Number):void
            {
                buildingPBinstance.imgWidth = _arg_1;
            }, "buildingPBinstance.imgWidth");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = secondToString(doneTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                situationTxt.text = _arg_1;
            }, "situationTxt.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = queueText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                queueTxt.text = _arg_1;
            }, "queueTxt.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (myName + " ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buildingName.text = _arg_1;
            }, "buildingName.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("等级（简）") + String(showLevel));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingBar_Label4.text = _arg_1;
            }, "_BuildingBar_Label4.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.imgPath);
            }, function (_arg_1:Object):void
            {
                _BuildingBar_Image1.source = _arg_1;
            }, "_BuildingBar_Image1.source");
            result[6] = binding;
            return (result);
        }

        public function set buildingPBinstance(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._2126000581buildingPBinstance;
            if (_local_2 !== _arg_1)
            {
                this._2126000581buildingPBinstance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingPBinstance", _local_2, _arg_1));
            };
        }

        private function onBuildingSpeedUpItemSelected(_arg_1:ItemEum=null):void
        {
            var _local_2:int;
            if (_arg_1 != null)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_SPEED_UP_BUILD_COMMAND, onCommandResponse, false, 0, true);
                if (this.isBuildingQueue)
                {
                    ActionFactory.getInstance().getCastleCommands().speedupBuildingQueue(_local_2, this.buildingQueueBean.id, _arg_1.id);
                }
                else
                {
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_local_2, buildingBean.positionId, _arg_1.id);
                };
                if (!UIUtil.checkItemEx(_arg_1.id, 1))
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameBuy", "1", _arg_1.price, _arg_1.id, _arg_1.name, _arg_1.itemType, _arg_1.price, 1);
                    };
                };
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("callByIngameUse", _arg_1.id, _arg_1.name, _arg_1.itemType, _arg_1.price);
                };
            };
        }

        public function ___BuildingBar_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get showLevel():int
        {
            return (this._1921309049showLevel);
        }

        [Bindable(event="propertyChange")]
        private function get imgPath():Object
        {
            return (this._1916786312imgPath);
        }

        [Bindable(event="propertyChange")]
        private function get buildingBean():BuildingBean
        {
            return (this._982966140buildingBean);
        }

        [Bindable(event="propertyChange")]
        public function get firstBtn():Button
        {
            return (this._549915252firstBtn);
        }

        override public function initialize():void
        {
            var target:BuildingBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuildingBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_BuildingBarWatcherSetupUtil");
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
        public function get situationTxt():Label
        {
            return (this._155830162situationTxt);
        }

        private function _BuildingBar_GlowFilter3_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
        }

        public function ___BuildingBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _BuildingBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = imgBar;
            _local_1 = ((414 * doneTimePer) / 100);
            _local_1 = secondToString(doneTime);
            _local_1 = queueText;
            _local_1 = (myName + " ");
            _local_1 = (Lang.msg("等级（简）") + String(showLevel));
            _local_1 = this.imgPath;
        }

        private function set imgBar(_arg_1:Object):void
        {
            var _local_2:Object = this._1185107632imgBar;
            if (_local_2 !== _arg_1)
            {
                this._1185107632imgBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgBar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isUpdate():Boolean
        {
            return (this._164812141isUpdate);
        }

        private function getTypeProperty():void
        {
            if (this.isBuildingQueue)
            {
                isUpdate = (this.buildingQueueBean.queueType == BuildingConstants.BUILDING_QUEUE_UPGRADING);
                imgBar = null;
                imgPath = ((isUpdate) ? this.buidingQueueUpdate : this.buildingQueueDisClass);
            }
            else
            {
                imgBar = ((buildingBean.status == BuildingConstants.STATUS_DESTRUCTING) ? "fla/dynamic/ui234.swf@buildDes.png" : "fla/dynamic/ui234.swf@buildPlan.png");
                isUpdate = (!(buildingBean.status == BuildingConstants.STATUS_DESTRUCTING));
                imgPath = ((isUpdate) ? buidingUpdate : buildingDisClass);
            };
        }

        [Bindable(event="propertyChange")]
        public function get queueTxt():Label
        {
            return (this._1164489825queueTxt);
        }

        private function set myName(_arg_1:String):void
        {
            var _local_2:Object = this._1060223401myName;
            if (_local_2 !== _arg_1)
            {
                this._1060223401myName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isBuildingQueue():Boolean
        {
            return (this._1775566259isBuildingQueue);
        }

        public function set buildingName(_arg_1:Label):void
        {
            var _local_2:Object = this._982612129buildingName;
            if (_local_2 !== _arg_1)
            {
                this._982612129buildingName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingName", _local_2, _arg_1));
            };
        }

        private function set queueText(_arg_1:String):void
        {
            var _local_2:Object = this._1739464226queueText;
            if (_local_2 !== _arg_1)
            {
                this._1739464226queueText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "queueText", _local_2, _arg_1));
            };
        }

        private function _BuildingBar_GlowFilter2_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
        }

        private function onCommandResponse(_arg_1:CommandResponse):void
        {
            trace((this.className + ".onBuildCommand."));
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                if (((isLowFiveMimutes) && (Context.getInstance().needUserGuide == false)))
                {
                    AlertWin.show(Lang.msg("生产时间低于5分钟免费加速"));
                    isLowFiveMimutes = false;
                };
            };
        }

        private function set doneTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1161124207doneTime;
            if (_local_2 !== _arg_1)
            {
                this._1161124207doneTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doneTime", _local_2, _arg_1));
            };
        }

        public function set myBuildingQueue(_arg_1:BuildingQueueBean):void
        {
            this.isBuildingQueue = true;
            this.buildingQueueBean = _arg_1;
            this.getTypeProperty();
            this.showLevel = _arg_1.level;
            if (this.showLevel < 0)
            {
                this.showLevel = 0;
            };
            this.doneTime = _arg_1.costTime;
            this.queueText = Lang.msg("已排队");
            this.myName = this.buildingQueueBean.name;
            this.doneTimePer = 0;
        }

        [Bindable(event="propertyChange")]
        private function get queueText():String
        {
            return (this._1739464226queueText);
        }

        private function set buildingEndTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1829946124buildingEndTime;
            if (_local_2 !== _arg_1)
            {
                this._1829946124buildingEndTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingEndTime", _local_2, _arg_1));
            };
        }

        public function ___BuildingBar_Image1_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get buildingEndTime():Number
        {
            return (this._1829946124buildingEndTime);
        }

        public function __firstBtn_click(_arg_1:MouseEvent):void
        {
            onBuildingSpeedUp(_arg_1);
        }


    }
}//package view.ui

