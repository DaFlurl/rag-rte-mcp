// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.BuildingType

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.VBox;
    import com.evony.common.beans.AvailableBuildingListBean;
    import flash.events.EventDispatcher;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.factory.UIFactory;
    import com.evony.Lang;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.TimerEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.eum.BuildingEumDefine;
    import com.evony.eum.BuildingEum;
    import com.evony.common.constants.BuildingConstants;
    import mx.events.FlexEvent;
    import com.evony.util.UIUtil;
    import view.module.guide.GuideStep;
    import com.evony.events.NewBuildingCommandEvent;
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

    public class BuildingType extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var tt:ConditionTooltip;
        private var _982410226buildingType:int;
        public var _BuildingType_VBox1:VBox;
        public var _BuildingType_VBox2:VBox;
        private var _bean:AvailableBuildingListBean;
        private var _982906011buildingDesc:String;
        public var eventd:EventDispatcher;
        private var _982612129buildingName:String;
        private var _97884btn:Button;
        private var isCanBuildHelp:Boolean = false;
        private var _186800895btnEnable:Boolean = false;
        private var _3034454btn2:Button;
        private var _276194949img_buildingLogo:Image;
        public var _BuildingType_Label1:Label;
        public var _BuildingType_Button2:Button;
        public var _BuildingType_HBox1:HBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":117,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"img_buildingLogo",
                        "events":{
                            "complete":"__img_buildingLogo_complete",
                            "mouseOver":"__img_buildingLogo_mouseOver",
                            "mouseOut":"__img_buildingLogo_mouseOut",
                            "mouseMove":"__img_buildingLogo_mouseMove",
                            "click":"__img_buildingLogo_click"
                        },
                        "stylesFactory":function ():void
                        {
                            this.top = "2";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":109,
                                "height":109
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "id":"_BuildingType_VBox1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btn",
                                    "events":{
                                        "click":"__btn_click",
                                        "mouseOut":"__btn_mouseOut",
                                        "mouseOver":"__btn_mouseOver",
                                        "mouseMove":"__btn_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "styleName":"b75"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "id":"_BuildingType_VBox2",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_BuildingType_Button2",
                                    "events":{"click":"___BuildingType_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b75",
                                            "width":110,
                                            "height":25,
                                            "label":"Build With Help",
                                            "toolTip":"For each facebook friend that clicks on your feed,the build (or upgrade) time will be reduced by either 1 minute or 1% whichever is greater. Up to 10 friends can speed up your build (or upgrade) ."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"btn2",
                                    "events":{
                                        "click":"__btn2_click",
                                        "mouseOut":"__btn2_mouseOut",
                                        "mouseOver":"__btn2_mouseOver",
                                        "mouseMove":"__btn2_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.fontSize = 12;
                                        this.fontWeight = "normal";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b75",
                                            "height":25,
                                            "width":110
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"_BuildingType_HBox1",
                        "events":{
                            "mouseOver":"___BuildingType_HBox1_mouseOver",
                            "mouseOut":"___BuildingType_HBox1_mouseOut",
                            "mouseMove":"___BuildingType_HBox1_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalAlign = "middle";
                            this.borderStyle = "none";
                            this.backgroundColor = 0;
                            this.horizontalGap = 1;
                            this.verticalGap = 1;
                            this.cornerRadius = 2;
                            this.backgroundAlpha = 0.9;
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "alpha":0.7,
                                "height":22,
                                "width":110,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingType_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.bottom = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "styleName":"buildingName"
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var conditionTimer:Timer = new Timer(1000, 0);
        private var _222927675isBuildHelp:Boolean = Context.getInstance().isBuildHelp;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuildingType()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalCenter = "0";
            };
            this.width = 117;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___BuildingType_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuildingType._watcherSetupUtil = _arg_1;
        }


        private function onMouseOver(_arg_1:MouseEvent):void
        {
            tt = UIFactory.getInstance().getConditionTooltip();
            tt.setBuildingType(Lang.msg("建造"), this._bean.typeId, -1);
            tt.setBean(this._bean.conditionBean);
            PopUpManager.addPopUp(tt, this);
            tt.moveToMouse(_arg_1);
        }

        public function __btn_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function set btnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._186800895btnEnable;
            if (_local_2 !== _arg_1)
            {
                this._186800895btnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEnable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingType():int
        {
            return (this._982410226buildingType);
        }

        override public function initialize():void
        {
            var target:BuildingType;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuildingType_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_BuildingTypeWatcherSetupUtil");
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

        private function _BuildingType_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Context.getInstance().isBuildHelp) ? 165 : 137);
            _local_1 = (!(Context.getInstance().isBuildHelp));
            _local_1 = ("btn" + this.buildingType);
            _local_1 = Lang.msg("建造");
            _local_1 = this.btnEnable;
            _local_1 = Context.getInstance().isBuildHelp;
            _local_1 = Context.getInstance().isBuildHelp;
            _local_1 = this.btnEnable;
            _local_1 = ("btn" + this.buildingType);
            _local_1 = Lang.msg("建造");
            _local_1 = this.btnEnable;
            _local_1 = ((Context.getInstance().isBuildHelp) ? 55 : 25);
            _local_1 = this.buildingName;
        }

        public function __btn_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        private function onBuildWithHelp():void
        {
            this.isCanBuildHelp = true;
            onClick();
        }

        private function init():void
        {
            this.conditionTimer.addEventListener(TimerEvent.TIMER, onConditionTime);
            this.swapBuildingLogo();
        }

        public function __img_buildingLogo_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___BuildingType_Button2_click(_arg_1:MouseEvent):void
        {
            onBuildWithHelp();
        }

        private function onPicMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onPicMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:BuildingEum = BuildingEumDefine.getBuildingEumByType(this._bean.typeId);
            DescribeTooltip.show(_local_2.name, _local_2.wikiDesc, _arg_1);
        }

        private function swapBuildingLogo():void
        {
            if (this.initialized)
            {
                if (this._bean != null)
                {
                    switch (_bean.typeId)
                    {
                        case BuildingConstants.TYPE_FARM_LAND:
                            gotoMc(73);
                            return;
                        case BuildingConstants.TYPE_ACADEMY:
                            gotoMc(21);
                            return;
                        case BuildingConstants.TYPE_BARRACK:
                            gotoMc(45);
                            return;
                        case BuildingConstants.TYPE_BLACKSMITH:
                            gotoMc(13);
                            return;
                        case BuildingConstants.TYPE_EMBASSY:
                            gotoMc(57);
                            return;
                        case BuildingConstants.TYPE_HEROS_MANSION:
                            gotoMc(33);
                            return;
                        case BuildingConstants.TYPE_HOUSE:
                            gotoMc(17);
                            return;
                        case BuildingConstants.TYPE_IRON_MINE:
                            gotoMc(77);
                            return;
                        case BuildingConstants.TYPE_LUMBER_MILL:
                            gotoMc(65);
                            return;
                        case BuildingConstants.TYPE_MARKET:
                            gotoMc(25);
                            return;
                        case BuildingConstants.TYPE_SENTRY_BUILDING:
                            gotoMc(41);
                            return;
                        case BuildingConstants.TYPE_STABLE:
                            gotoMc(49);
                            return;
                        case BuildingConstants.TYPE_STONE_MINE:
                            gotoMc(69);
                            return;
                        case BuildingConstants.TYPE_TAVERN:
                            gotoMc(29);
                            return;
                        case BuildingConstants.TYPE_TOWN_HALL:
                            gotoMc(61);
                            return;
                        case BuildingConstants.TYPE_TRAINNING_FEILD:
                            gotoMc(37);
                            return;
                        case BuildingConstants.TYPE_TRANSPORT_STATION:
                            gotoMc(1);
                            return;
                        case BuildingConstants.TYPE_WALL:
                            gotoMc(81);
                            return;
                        case BuildingConstants.TYPE_WAREHOUSE:
                            gotoMc(9);
                            return;
                        case BuildingConstants.TYPE_WORKSHOP:
                            gotoMc(5);
                            return;
                    };
                };
            };
        }

        private function onPicMouseOut():void
        {
            DescribeTooltip.hide();
        }

        public function __img_buildingLogo_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        public function ___BuildingType_HBox1_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        private function set isBuildHelp(_arg_1:Boolean):void
        {
            var _local_2:Object = this._222927675isBuildHelp;
            if (_local_2 !== _arg_1)
            {
                this._222927675isBuildHelp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBuildHelp", _local_2, _arg_1));
            };
        }

        public function __img_buildingLogo_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        public function __img_buildingLogo_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function set buildingType(_arg_1:int):void
        {
            var _local_2:Object = this._982410226buildingType;
            if (_local_2 !== _arg_1)
            {
                this._982410226buildingType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingType", _local_2, _arg_1));
            };
        }

        public function ___BuildingType_HBox1_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        public function __btn_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function ___BuildingType_HBox1_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        public function set buildingName(_arg_1:String):void
        {
            var _local_2:Object = this._982612129buildingName;
            if (_local_2 !== _arg_1)
            {
                this._982612129buildingName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingName", _local_2, _arg_1));
            };
        }

        public function __btn2_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function set btn(_arg_1:Button):void
        {
            var _local_2:Object = this._97884btn;
            if (_local_2 !== _arg_1)
            {
                this._97884btn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btn", _local_2, _arg_1));
            };
        }

        public function __btn_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        public function __img_buildingLogo_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        public function ___BuildingType_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get btn2():Button
        {
            return (this._3034454btn2);
        }

        public function __btn2_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        private function gotoMc(_arg_1:int):void
        {
            var _local_2:int = (_arg_1 + 3);
            img_buildingLogo.source = (("images/buildinglogo/" + _local_2) + ".jpg");
        }

        private function _BuildingType_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Number
            {
                return ((Context.getInstance().isBuildHelp) ? 165 : 137);
            }, function (_arg_1:Number):void
            {
                this.height = _arg_1;
            }, "this.height");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(Context.getInstance().isBuildHelp));
            }, function (_arg_1:Boolean):void
            {
                _BuildingType_VBox1.visible = _arg_1;
            }, "_BuildingType_VBox1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("btn" + this.buildingType);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btn.name = _arg_1;
            }, "btn.name");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btn.label = _arg_1;
            }, "btn.label");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnable);
            }, function (_arg_1:Boolean):void
            {
                btn.enabled = _arg_1;
            }, "btn.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().isBuildHelp);
            }, function (_arg_1:Boolean):void
            {
                _BuildingType_VBox2.visible = _arg_1;
            }, "_BuildingType_VBox2.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().isBuildHelp);
            }, function (_arg_1:Boolean):void
            {
                _BuildingType_Button2.visible = _arg_1;
            }, "_BuildingType_Button2.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnable);
            }, function (_arg_1:Boolean):void
            {
                _BuildingType_Button2.enabled = _arg_1;
            }, "_BuildingType_Button2.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("btn" + this.buildingType);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btn2.name = _arg_1;
            }, "btn2.name");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btn2.label = _arg_1;
            }, "btn2.label");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnable);
            }, function (_arg_1:Boolean):void
            {
                btn2.enabled = _arg_1;
            }, "btn2.enabled");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().isBuildHelp) ? 55 : 25);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingType_HBox1.setStyle("bottom", _arg_1);
            }, "_BuildingType_HBox1.bottom");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingType_Label1.text = _arg_1;
            }, "_BuildingType_Label1.text");
            result[12] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get buildingName():String
        {
            return (this._982612129buildingName);
        }

        public function set bean(_arg_1:AvailableBuildingListBean):void
        {
            this._bean = _arg_1;
            this.swapBuildingLogo();
            this.buildingName = BuildingEumDefine.getName(this._bean.typeId);
            this.buildingDesc = BuildingEumDefine.getDesc(this._bean.typeId);
            this.btnEnable = false;
            this.onConditionTime(null);
            this.conditionTimer.start();
        }

        public function __btn2_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        public function set buildingDesc(_arg_1:String):void
        {
            var _local_2:Object = this._982906011buildingDesc;
            if (_local_2 !== _arg_1)
            {
                this._982906011buildingDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingDesc", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get btn():Button
        {
            return (this._97884btn);
        }

        public function __btn2_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get isBuildHelp():Boolean
        {
            return (this._222927675isBuildHelp);
        }

        private function onMouseOut():void
        {
            if (tt != null)
            {
                tt.destroy();
            };
        }

        private function onConditionTime(_arg_1:TimerEvent):void
        {
            var _local_2:Boolean = UIUtil.isConditionMatch(this._bean.conditionBean);
            var _local_3:Boolean = UIUtil.isResourceConditionMatch(this._bean.conditionBean);
            if (_local_3)
            {
                this.conditionTimer.stop();
            };
            if (((_local_2) && (_local_3)))
            {
                if ((((!(_bean == null)) && (Context.getInstance().needUserGuide)) && (!(GuideStep.getInstance().currentStep == 999))))
                {
                    switch (GuideStep.getInstance().currentStep)
                    {
                        case 1:
                            if (_bean.typeId == BuildingConstants.TYPE_HOUSE)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 501:
                            if (_bean.typeId == BuildingConstants.TYPE_FARM_LAND)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 601:
                            if (_bean.typeId == BuildingConstants.TYPE_LUMBER_MILL)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 701:
                            if (_bean.typeId == BuildingConstants.TYPE_STONE_MINE)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 801:
                            if (_bean.typeId == BuildingConstants.TYPE_IRON_MINE)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 901:
                            if (_bean.typeId == BuildingConstants.TYPE_TAVERN)
                            {
                                this.btnEnable = true;
                            };
                            break;
                        case 101:
                            if (_bean.typeId == BuildingConstants.TYPE_HEROS_MANSION)
                            {
                                this.btnEnable = true;
                            };
                            break;
                    };
                }
                else
                {
                    this.btnEnable = true;
                };
            };
            if (((!(UIUtil.isUIComponentVisible(this))) && (conditionTimer.currentCount > 60)))
            {
                this.conditionTimer.stop();
            };
        }

        private function onClick():void
        {
            this.dispatchEvent(new NewBuildingCommandEvent(this._bean.typeId, isCanBuildHelp));
            this.isCanBuildHelp = false;
            if (tt != null)
            {
                tt.destroy();
            };
            if (Context.getInstance().isBuildHelp)
            {
                Context.getInstance().isSpeedType = 0;
                Context.getInstance().buidwithhelpName = this.buildingName;
                Context.getInstance().buidwithhelpLevel = "1";
            };
        }

        public function set btn2(_arg_1:Button):void
        {
            var _local_2:Object = this._3034454btn2;
            if (_local_2 !== _arg_1)
            {
                this._3034454btn2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btn2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buildingDesc():String
        {
            return (this._982906011buildingDesc);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (tt != null)
            {
                tt.moveToMouse(_arg_1);
            };
        }

        public function destroy():void
        {
            this.conditionTimer.stop();
        }

        [Bindable(event="propertyChange")]
        public function get img_buildingLogo():Image
        {
            return (this._276194949img_buildingLogo);
        }

        public function set img_buildingLogo(_arg_1:Image):void
        {
            var _local_2:Object = this._276194949img_buildingLogo;
            if (_local_2 !== _arg_1)
            {
                this._276194949img_buildingLogo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "img_buildingLogo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnEnable():Boolean
        {
            return (this._186800895btnEnable);
        }


    }
}//package view.ui

