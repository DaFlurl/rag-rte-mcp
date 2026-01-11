// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ColonyBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.util.EvonyImage;
    import mx.controls.Spacer;
    import com.evony.common.beans.ColonyBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import view.module.office.AbondonColonyItemWin;
    import com.evony.factory.ItemManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.filters.GlowFilter;
    import flash.events.TimerEvent;
    import com.evony.common.constants.ColonyConstants;
    import mx.events.FlexEvent;
    import com.evony.Context;
    import mx.core.BitmapAsset;
    import flash.events.MouseEvent;
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

    public class ColonyBar extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _486420412targetName:Label;
        private var _549915252firstBtn:Button;
        private var _982612129buildingName:Label;
        private var _678927291percent:Number = 0.001;
        private var _2126000581buildingPBinstance:EvonyImage;
        private var _853101417typeStr:String = "";
        private var _493364297typeColor:Number = 0;
        public var _ColonyBar_Spacer1:Spacer;
        private var nowTime:Number;
        private var _2008969879_colonyBean:ColonyBean;
        private var _953891597spaceTime:Number;
        private var _155830162situationTxt:Label;

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
                                        this.left = "15";
                                        this.top = "0";
                                        this.fontWeight = "bold";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"targetName",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.left = "110";
                                        this.top = "0";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"situationTxt",
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
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
                                                "type":Spacer,
                                                "id":"_ColonyBar_Spacer1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":55});
                                                }
                                            })]});
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
                    })]});
            }
        });
        private var _676654381typeIcon:Object = {};
        private var _858803508typePb:Object = {};
        private var timeCount:Timer = new Timer(1000);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonyBar()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ColonyBar_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonyBar._watcherSetupUtil = _arg_1;
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

        private function set percent(_arg_1:Number):void
        {
            var _local_2:Object = this._678927291percent;
            if (_local_2 !== _arg_1)
            {
                this._678927291percent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percent", _local_2, _arg_1));
            };
        }

        private function onBuildingSpeedUp():void
        {
            AbondonColonyItemWin.show(ItemManager.abondonColonyItemArray, _colonyBean);
        }

        override public function initialize():void
        {
            var target:ColonyBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ColonyBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ColonyBarWatcherSetupUtil");
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
        public function get firstBtn():Button
        {
            return (this._549915252firstBtn);
        }

        public function set colonyBean(_arg_1:Object):void
        {
            if (!timeCount.running)
            {
                timeCount.start();
            };
            if (_arg_1)
            {
                _colonyBean = ColonyBean(_arg_1);
                this.getTypeProperty();
            };
        }

        private function _ColonyBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = typePb;
            _local_1 = (414 * percent);
            _local_1 = typeStr;
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = (((_colonyBean.cityName + "(") + _colonyBean.position) + ")");
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = secondToString((spaceTime / 1000));
            _local_1 = [new GlowFilter(0, 1, 4, 4, 25, 1, false, false)];
            _local_1 = (typeStr == "Handover");
            _local_1 = (typeStr == "Handover");
            _local_1 = (typeStr == "Handover");
            _local_1 = (typeStr == "Handover");
        }

        private function init():void
        {
            nowTime = new Date().valueOf();
            timeCount.addEventListener(TimerEvent.TIMER, onTimeCount);
            timeCount.start();
            percent = 0.001;
        }

        private function getTypeProperty():void
        {
            if (_colonyBean.status == ColonyConstants.COLONY_STATUS_ATTACKING)
            {
                typeStr = "Suppression";
                if (_colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)
                {
                    typePb = "fla/dynamic/ui234.swf@Suppression.png";
                }
                else
                {
                    typePb = "fla/dynamic/ui234.swf@againstSuppression.png";
                };
            }
            else
            {
                if (_colonyBean.status == ColonyConstants.COLONY_STATUS_UPRISING)
                {
                    typeStr = "Uprising";
                    if (_colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)
                    {
                        typePb = "fla/dynamic/ui234.swf@againstUprising.png";
                    }
                    else
                    {
                        typePb = "fla/dynamic/ui234.swf@uprising.png";
                    };
                }
                else
                {
                    if (_colonyBean.status == ColonyConstants.COLONY_STATUS_ABANDON)
                    {
                        typeStr = "Handover";
                        typePb = "fla/dynamic/ui234.swf@armyReturnBar.png";
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeStr():String
        {
            return (this._853101417typeStr);
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

        public function ___ColonyBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
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

        private function _ColonyBar_bindingsSetup():Array
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
                var _local_1:* = (((_colonyBean.cityName + "(") + _colonyBean.position) + ")");
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
            binding = new Binding(this, function ():Boolean
            {
                return (typeStr == "Handover");
            }, function (_arg_1:Boolean):void
            {
                _ColonyBar_Spacer1.includeInLayout = _arg_1;
            }, "_ColonyBar_Spacer1.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (typeStr == "Handover");
            }, function (_arg_1:Boolean):void
            {
                _ColonyBar_Spacer1.visible = _arg_1;
            }, "_ColonyBar_Spacer1.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (typeStr == "Handover");
            }, function (_arg_1:Boolean):void
            {
                firstBtn.includeInLayout = _arg_1;
            }, "firstBtn.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (typeStr == "Handover");
            }, function (_arg_1:Boolean):void
            {
                firstBtn.visible = _arg_1;
            }, "firstBtn.visible");
            result[11] = binding;
            return (result);
        }

        private function onTimeCount(_arg_1:TimerEvent):void
        {
            nowTime = new Date().valueOf();
            spaceTime = ((_colonyBean.endTime + Context.getInstance().getTimeDiff()) - nowTime);
            if (_colonyBean)
            {
                percent = (((nowTime - Context.getInstance().getTimeDiff()) - _colonyBean.startTime) / (_colonyBean.endTime - _colonyBean.startTime));
            };
            if (percent >= 1)
            {
                timeCount.stop();
                percent = 1;
            };
        }

        [Bindable(event="propertyChange")]
        public function get situationTxt():Label
        {
            return (this._155830162situationTxt);
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

        [Bindable(event="propertyChange")]
        private function get percent():Number
        {
            return (this._678927291percent);
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

        private function set _colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._2008969879_colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._2008969879_colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_colonyBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingPBinstance():EvonyImage
        {
            return (this._2126000581buildingPBinstance);
        }

        [Bindable(event="propertyChange")]
        private function get typeColor():Number
        {
            return (this._493364297typeColor);
        }

        [Bindable(event="propertyChange")]
        private function get typePb():Object
        {
            return (this._858803508typePb);
        }

        [Bindable(event="propertyChange")]
        public function get buildingName():Label
        {
            return (this._982612129buildingName);
        }

        [Bindable(event="propertyChange")]
        private function get typeIcon():Object
        {
            return (this._676654381typeIcon);
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

        [Bindable(event="propertyChange")]
        private function get _colonyBean():ColonyBean
        {
            return (this._2008969879_colonyBean);
        }

        [Bindable(event="propertyChange")]
        private function get spaceTime():Number
        {
            return (this._953891597spaceTime);
        }

        public function __firstBtn_click(_arg_1:MouseEvent):void
        {
            onBuildingSpeedUp();
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


    }
}//package view.ui

