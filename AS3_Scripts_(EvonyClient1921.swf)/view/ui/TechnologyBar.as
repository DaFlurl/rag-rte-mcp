// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TechnologyBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import flash.utils.Timer;
    import mx.controls.Label;
    import com.evony.util.EvonyImage;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import mx.core.BitmapAsset;
    import flash.filters.GlowFilter;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.UIUtil;
    import flash.external.ExternalInterface;
    import com.evony.eum.ItemEum;
    import com.evony.common.constants.CommonConstants;
    import com.evony.eum.TechEumDefine;
    import com.evony.factory.ItemManager;
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

    public class TechnologyBar extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var myTimer:Timer;
        private var _1616414137techDesc:String;
        private var _982612129buildingName:Label;
        private var _2126000581buildingPBinstance:EvonyImage;
        private var _615271122doneTimePer:Number;
        private var time:Number = 0;
        private var _1161124207doneTime:int;
        private var _1616474266techBean:AvailableResearchListBean;
        private var _155830162situationTxt:Label;
        public var callBack:Function;
        private var _1710738130techEndTime:Number;

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
                                        return ({
                                            "height":23,
                                            "source":"fla/dynamic/ui234.swf@skillPlan.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"situationTxt",
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "75";
                                        this.top = "0";
                                        this.color = 0xFFFFFF;
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "filters":[_TechnologyBar_GlowFilter1_c()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"buildingName",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "32";
                                        this.top = "0";
                                        this.color = 0xFFFFFF;
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"filters":[_TechnologyBar_GlowFilter2_c()]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___TechnologyBar_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"Speedup"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@tec_update.png"});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TechnologyBar()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.borderStyle = "none";
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___TechnologyBar_Canvas1_creationComplete);
        }

        public static function secondToString(_arg_1:int):String
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
            TechnologyBar._watcherSetupUtil = _arg_1;
        }


        private function init():void
        {
        }

        public function ___TechnologyBar_Button1_click(_arg_1:MouseEvent):void
        {
            onTechSpeedUp();
        }

        [Bindable(event="propertyChange")]
        public function get situationTxt():Label
        {
            return (this._155830162situationTxt);
        }

        private function set techDesc(_arg_1:String):void
        {
            var _local_2:Object = this._1616414137techDesc;
            if (_local_2 !== _arg_1)
            {
                this._1616414137techDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techDesc", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TechnologyBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TechnologyBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_TechnologyBarWatcherSetupUtil");
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

        public function set situationTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._155830162situationTxt;
            if (_local_2 !== _arg_1)
            {
                this._155830162situationTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "situationTxt", _local_2, _arg_1));
            };
        }

        private function set techEndTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1710738130techEndTime;
            if (_local_2 !== _arg_1)
            {
                this._1710738130techEndTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techEndTime", _local_2, _arg_1));
            };
        }

        private function _TechnologyBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((414 * doneTimePer) / 100);
            _local_1 = secondToString(doneTime);
            _local_1 = this.techDesc;
        }

        public function ___TechnologyBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onCreationComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
                BitmapAsset(_arg_1.currentTarget.content).width = 280;
            };
        }

        private function _TechnologyBar_GlowFilter2_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get buildingPBinstance():EvonyImage
        {
            return (this._2126000581buildingPBinstance);
        }

        [Bindable(event="propertyChange")]
        private function get doneTimePer():Number
        {
            return (this._615271122doneTimePer);
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

        private function timerHandler(_arg_1:TimerEvent=null):Boolean
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:Number;
            if (techBean != null)
            {
                _local_2 = new Date().valueOf();
                _local_3 = Context.getInstance().getTimeDiff();
                _local_4 = (((time + _local_3) - _local_2) / 1000);
                doneTime = _local_4;
                if (_local_4 > 0)
                {
                    doneTimePer = ((1 - ((_local_4 * 1000) / (techEndTime - this.techBean.startTime))) * 100);
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

        [Bindable(event="propertyChange")]
        private function get techDesc():String
        {
            return (this._1616414137techDesc);
        }

        [Bindable(event="propertyChange")]
        private function get techEndTime():Number
        {
            return (this._1710738130techEndTime);
        }

        private function set techBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1616474266techBean;
            if (_local_2 !== _arg_1)
            {
                this._1616474266techBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techBean", _local_2, _arg_1));
            };
        }

        private function _TechnologyBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Number
            {
                return ((414 * doneTimePer) / 100);
            }, function (_arg_1:Number):void
            {
                buildingPBinstance.imgWidth = _arg_1;
            }, "buildingPBinstance.imgWidth");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = secondToString(doneTime);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                situationTxt.text = _arg_1;
            }, "situationTxt.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.techDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                buildingName.text = _arg_1;
            }, "buildingName.text");
            result[2] = binding;
            return (result);
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

        private function onTechSpeedUpItemSelected(_arg_1:ItemEum):void
        {
            trace((((this.className + ".onSpeedUpItemSelected(") + _arg_1.name) + ")"));
            var _local_2:int = Context.getInstance().getCurCastle().id;
            ActionFactory.getInstance().getTechCommand().speedUpResearch(_local_2, _arg_1.id);
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
        }

        private function set doneTime(_arg_1:int):void
        {
            var _local_2:Object = this._1161124207doneTime;
            if (_local_2 !== _arg_1)
            {
                this._1161124207doneTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doneTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingName():Label
        {
            return (this._982612129buildingName);
        }

        private function freeTecSpeed(_arg_1:Boolean):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getTechCommand().speedUpResearch(_local_2, CommonConstants.FREE_SPEED_ITEM_ID);
            };
        }

        public function set myTechBean(_arg_1:AvailableResearchListBean):void
        {
            this.techBean = _arg_1;
            this.techDesc = ((((TechEumDefine.getTechEumByType(this.techBean.typeId).name + " (") + Lang.msg("等级（简）")) + String((int(_arg_1.level) + 1))) + ")");
            this.techEndTime = _arg_1.endTime;
            remainTime(this.techBean.endTime);
        }

        [Bindable(event="propertyChange")]
        private function get techBean():AvailableResearchListBean
        {
            return (this._1616474266techBean);
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

        private function onTechSpeedUp():void
        {
            var _local_1:String;
            if (SpeedUpCheckOut.checkOutTech(this.techBean))
            {
                SpeedupItemSelector.getInstance().teachbean = this.techBean;
                SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_TECH_SPEED;
                SpeedupItemSelector.show(ItemManager.speedItemArray, onTechSpeedUpItemSelected);
                if (Context.getInstance().isBuildHelp)
                {
                    Context.getInstance().isSpeedType = 1;
                    _local_1 = TechEumDefine.getTechEumByType(this.techBean.typeId).name;
                    Context.getInstance().buidwithhelpName = _local_1;
                    Context.getInstance().buidwithhelpLevel = String((int(this.techBean.level) + 1));
                };
            }
            else
            {
                AlertWin.show(Lang.msg("生产时间低于5分钟免费加速"), freeTecSpeed);
            };
        }

        [Bindable(event="propertyChange")]
        private function get doneTime():int
        {
            return (this._1161124207doneTime);
        }

        private function _TechnologyBar_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 2;
            return (_local_1);
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


    }
}//package view.ui

