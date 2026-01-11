// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ArmyMovementBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.util.EvonyImage;
    import mx.controls.Image;
    import com.evony.common.beans.ArmyBean;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.TimerEvent;
    import com.evony.common.constants.ArmyConstants;
    import com.evony.common.constants.ObjConstants;
    import com.evony.Context;
    import mx.core.BitmapAsset;
    import mx.events.FlexEvent;
    import flash.filters.GlowFilter;
    import com.evony.util.ImageSmooth;
    import com.evony.Coordinate;
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

    public class ArmyMovementBar extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1538277144targetY:int = 0;
        private var _486420412targetName:Label;
        private var _982612129buildingName:Label;
        private var _2126000581buildingPBinstance:EvonyImage;
        private var _678927291percent:Number = 0.001;
        private var _853101417typeStr:String = "";
        private var _493364297typeColor:Number = 0;
        private var nowTime:Number;
        private var _953891597spaceTime:Number;
        public var _ArmyMovementBar_Image1:Image;
        private var _1324977076_armyBean:ArmyBean;
        private var _155830162situationTxt:Label;
        private var _1538277145targetX:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.backgroundAlpha = 0.4;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":425,
                                "height":23,
                                "styleName":"schedulel",
                                "horizontalScrollPolicy":"off",
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
                                    "id":"buildingName",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.left = "32";
                                        this.top = "0";
                                        this.fontWeight = "bold";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"targetName",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.left = "100";
                                        this.top = "0";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"situationTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.right = "20";
                                        this.top = "0";
                                        this.textAlign = "right";
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_ArmyMovementBar_Image1",
                                    "events":{"updateComplete":"___ArmyMovementBar_Image1_updateComplete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _676654381typeIcon:Object = {};
        private var _858803508typePb:Object = {};
        private var ArmyAttackIcon:Class = ArmyMovementBar_ArmyAttackIcon;
        private var ArmySendIcon:Class = ArmyMovementBar_ArmySendIcon;
        private var ArmyTransportIcon:Class = ArmyMovementBar_ArmyTransportIcon;
        private var ArmyScoutIcon:Class = ArmyMovementBar_ArmyScoutIcon;
        private var ArmyReturnIcon:Class = ArmyMovementBar_ArmyReturnIcon;
        private var ArmyconstruceIcon:Class = ArmyMovementBar_ArmyconstruceIcon;
        private var timeCount:Timer = new Timer(1000);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ArmyMovementBar()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ArmyMovementBar_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ArmyMovementBar._watcherSetupUtil = _arg_1;
        }


        private function secondToString(_arg_1:Number):String
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

        public function set buildingPBinstance(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._2126000581buildingPBinstance;
            if (_local_2 !== _arg_1)
            {
                this._2126000581buildingPBinstance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingPBinstance", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ArmyMovementBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ArmyMovementBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ArmyMovementBarWatcherSetupUtil");
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

        private function set percent(_arg_1:Number):void
        {
            var _local_2:Object = this._678927291percent;
            if (_local_2 !== _arg_1)
            {
                this._678927291percent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get situationTxt():Label
        {
            return (this._155830162situationTxt);
        }

        [Bindable(event="propertyChange")]
        private function get typeStr():String
        {
            return (this._853101417typeStr);
        }

        private function init():void
        {
            nowTime = new Date().valueOf();
            timeCount.addEventListener(TimerEvent.TIMER, onTimeCount);
            timeCount.start();
            percent = 0.001;
        }

        private function getTypeProperty(_arg_1:int):void
        {
            if (_armyBean.direction == ArmyConstants.ARMY_FORWARD)
            {
                this.typeColor = 16731654;
                this.typePb = "fla/dynamic/ui234.swf@armyToBar.png";
                switch (_arg_1)
                {
                    case ObjConstants.ARMY_MISSION_CONSTRUCT:
                        this.typeStr = "Build City";
                        this.typeIcon = ArmyconstruceIcon;
                        break;
                    case ObjConstants.ARMY_MISSION_OCCUPY:
                        this.typeStr = "Attack";
                        this.typeIcon = ArmyAttackIcon;
                        break;
                    case ObjConstants.ARMY_MISSION_SCOUT:
                        this.typeStr = "Scout";
                        this.typeIcon = ArmyScoutIcon;
                        break;
                    case ObjConstants.ARMY_MISSION_SEND:
                        this.typeStr = "Send";
                        this.typePb = "fla/dynamic/ui234.swf@armySend.png";
                        this.typeIcon = ArmySendIcon;
                        break;
                    case ObjConstants.ARMY_MISSION_TRANS:
                        this.typeIcon = ArmyTransportIcon;
                        this.typePb = "fla/dynamic/ui234.swf@armySend.png";
                        this.typeStr = "Trans";
                        break;
                    case ObjConstants.ARMY_MISSION_COLONIZE:
                        this.typeIcon = ArmyAttackIcon;
                        this.typeStr = "Colonize";
                        break;
                };
            }
            else
            {
                if (_armyBean.direction == ArmyConstants.ARMY_BACKWARD)
                {
                    this.typeStr = "Return";
                    this.typeIcon = ArmyReturnIcon;
                    this.typePb = "fla/dynamic/ui234.swf@armyReturnBar.png";
                    this.typeColor = 1479423;
                };
            };
        }

        private function set _armyBean(_arg_1:ArmyBean):void
        {
            var _local_2:Object = this._1324977076_armyBean;
            if (_local_2 !== _arg_1)
            {
                this._1324977076_armyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_armyBean", _local_2, _arg_1));
            };
        }

        private function onTimeCount(_arg_1:TimerEvent):void
        {
            nowTime = new Date().valueOf();
            spaceTime = ((_armyBean.reachTime + Context.getInstance().getTimeDiff()) - nowTime);
            if (_armyBean)
            {
                percent = (((nowTime - Context.getInstance().getTimeDiff()) - _armyBean.startTime) / (_armyBean.reachTime - _armyBean.startTime));
            };
            if (percent >= 1)
            {
                timeCount.stop();
                percent = 1;
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

        private function set typeIcon(_arg_1:Object):void
        {
            var _local_2:Object = this._676654381typeIcon;
            if (_local_2 !== _arg_1)
            {
                this._676654381typeIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeIcon", _local_2, _arg_1));
            };
        }

        private function set typeStr(_arg_1:String):void
        {
            var _local_2:Object = this._853101417typeStr;
            if (_local_2 !== _arg_1)
            {
                this._853101417typeStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeStr", _local_2, _arg_1));
            };
        }

        private function set typePb(_arg_1:Object):void
        {
            var _local_2:Object = this._858803508typePb;
            if (_local_2 !== _arg_1)
            {
                this._858803508typePb = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typePb", _local_2, _arg_1));
            };
        }

        private function onCreationComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
                BitmapAsset(_arg_1.currentTarget.content).width = 280;
            };
        }

        [Bindable(event="propertyChange")]
        public function get targetName():Label
        {
            return (this._486420412targetName);
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

        private function set typeColor(_arg_1:Number):void
        {
            var _local_2:Object = this._493364297typeColor;
            if (_local_2 !== _arg_1)
            {
                this._493364297typeColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeColor", _local_2, _arg_1));
            };
        }

        private function set targetX(_arg_1:int):void
        {
            var _local_2:Object = this._1538277145targetX;
            if (_local_2 !== _arg_1)
            {
                this._1538277145targetX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetX", _local_2, _arg_1));
            };
        }

        private function _ArmyMovementBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (typePb);
            }, function (_arg_1:Object):void
            {
                buildingPBinstance.source = _arg_1;
            }, "buildingPBinstance.source");
            result[0] = binding;
            binding = new Binding(this, function ():Number
            {
                return (414 * percent);
            }, function (_arg_1:Number):void
            {
                buildingPBinstance.imgWidth = _arg_1;
            }, "buildingPBinstance.imgWidth");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = typeStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buildingName.text = _arg_1;
            }, "buildingName.text");
            result[2] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 4, 4, 25, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                buildingName.filters = _arg_1;
            }, "buildingName.filters");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((((_armyBean.targetPosName + "(") + targetX) + ",") + targetY) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                targetName.text = _arg_1;
            }, "targetName.text");
            result[4] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 4, 4, 25, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                targetName.filters = _arg_1;
            }, "targetName.filters");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = secondToString((spaceTime / 1000));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                situationTxt.text = _arg_1;
            }, "situationTxt.text");
            result[6] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 4, 4, 25, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                situationTxt.filters = _arg_1;
            }, "situationTxt.filters");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.typeIcon);
            }, function (_arg_1:Object):void
            {
                _ArmyMovementBar_Image1.source = _arg_1;
            }, "_ArmyMovementBar_Image1.source");
            result[8] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get percent():Number
        {
            return (this._678927291percent);
        }

        public function ___ArmyMovementBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___ArmyMovementBar_Image1_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function _ArmyMovementBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = typePb;
            _local_1 = (414 * percent);
            _local_1 = typeStr;
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = (((((_armyBean.targetPosName + "(") + targetX) + ",") + targetY) + ")");
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = secondToString((spaceTime / 1000));
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = this.typeIcon;
        }

        [Bindable(event="propertyChange")]
        private function get typeColor():Number
        {
            return (this._493364297typeColor);
        }

        [Bindable(event="propertyChange")]
        public function get buildingPBinstance():EvonyImage
        {
            return (this._2126000581buildingPBinstance);
        }

        public function set armyBean(_arg_1:Object):void
        {
            var _local_2:Coordinate;
            if (!timeCount.running)
            {
                timeCount.start();
            };
            if (_arg_1)
            {
                _armyBean = ArmyBean(_arg_1);
                this.getTypeProperty(_armyBean.missionType);
                _local_2 = new Coordinate(_armyBean.targetFieldId);
                this.targetX = _local_2.x;
                this.targetY = _local_2.y;
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeIcon():Object
        {
            return (this._676654381typeIcon);
        }

        [Bindable(event="propertyChange")]
        private function get _armyBean():ArmyBean
        {
            return (this._1324977076_armyBean);
        }

        [Bindable(event="propertyChange")]
        private function get targetX():int
        {
            return (this._1538277145targetX);
        }

        [Bindable(event="propertyChange")]
        private function get targetY():int
        {
            return (this._1538277144targetY);
        }

        [Bindable(event="propertyChange")]
        public function get buildingName():Label
        {
            return (this._982612129buildingName);
        }

        private function set targetY(_arg_1:int):void
        {
            var _local_2:Object = this._1538277144targetY;
            if (_local_2 !== _arg_1)
            {
                this._1538277144targetY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetY", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get spaceTime():Number
        {
            return (this._953891597spaceTime);
        }

        private function set spaceTime(_arg_1:Number):void
        {
            var _local_2:Object = this._953891597spaceTime;
            if (_local_2 !== _arg_1)
            {
                this._953891597spaceTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "spaceTime", _local_2, _arg_1));
            };
        }

        public function set targetName(_arg_1:Label):void
        {
            var _local_2:Object = this._486420412targetName;
            if (_local_2 !== _arg_1)
            {
                this._486420412targetName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typePb():Object
        {
            return (this._858803508typePb);
        }


    }
}//package view.ui

