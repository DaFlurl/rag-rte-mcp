// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.technology.Technology

package view.module.technology
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.containers.Tile;
    import mx.controls.Label;
    import mx.containers.VBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.controls.Image;
    import com.evony.util.UICache;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.common.constants.TechConstants;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.tech.ResearchResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.events.BuildingChangeEvent;
    import mx.events.FlexEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.MsgDispacther;
    import view.castle.TownView;
    import view.castle.CityView;
    import com.evony.Context;
    import com.evony.data.FbData;
    import view.RandomEventWin;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.PlayerBean;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import com.evony.eum.TechEumDefine;
    import view.MainWin;
    import view.ChatFrame;
    import com.evony.common.server.events.ResearchCompleteUpdate;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
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

    public class Technology extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Technology.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1192646334currentProductContain:Canvas;
        public var _Technology_TechItemUI10:TechItemUI;
        public var _Technology_TechItemUI11:TechItemUI;
        public var _Technology_TechItemUI12:TechItemUI;
        public var _Technology_TechItemUI13:TechItemUI;
        public var _Technology_TechItemUI15:TechItemUI;
        public var _Technology_TechItemUI16:TechItemUI;
        public var _Technology_TechItemUI17:TechItemUI;
        public var _Technology_TechItemUI18:TechItemUI;
        public var _Technology_TechItemUI19:TechItemUI;
        private var _1984916423schoolAmountText:Text;
        public var _Technology_TechItemUI14:TechItemUI;
        public var _Technology_TechItemUI1:TechItemUI;
        public var _Technology_TechItemUI2:TechItemUI;
        public var _Technology_TechItemUI4:TechItemUI;
        public var _Technology_TechItemUI6:TechItemUI;
        public var _Technology_TechItemUI5:TechItemUI;
        public var _Technology_TechItemUI9:TechItemUI;
        public var _Technology_TechItemUI3:TechItemUI;
        private var _1299767438schoolAmout:int = 0;
        public var _Technology_TechItemUI7:TechItemUI;
        public var _Technology_TechItemUI8:TechItemUI;
        private var _817714405productContain:Tile;
        public var _Technology_Label1:Label;
        public var _Technology_Label3:Label;
        private var _58467523curCastleResearchingUI:TechReseachingUI;
        private var _86084077currentStaticLabel:Label;
        private var _330690077otherCastleResearch:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"currentProductContain",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "width":315,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"auto",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Technology_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "28";
                                        this.left = "10";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"currentStaticLabel",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "95";
                                        this.left = "10";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":10,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Technology_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"schoolAmountText",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":19,
                                                        "height":19
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "90";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"controls/Public/line1.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TechReseachingUI,
                                    "id":"curCastleResearchingUI",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":46,
                                            "x":6,
                                            "visible":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"otherCastleResearch",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "115";
                                        this.bottom = "0";
                                        this.verticalGap = 8;
                                        this.left = "6";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "verticalScrollPolicy":"auto",
                                            "horizontalScrollPolicy":"off"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Tile,
                        "id":"productContain",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.horizontalGap = 5;
                            this.top = "0";
                            this.bottom = "35";
                            this.paddingLeft = 5;
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
                                "verticalScrollPolicy":"auto",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI1"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI2"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI3"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI4"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI5"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI6"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI7"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI8"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI9"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI10"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI11"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI12"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI13"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI14"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI15"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI16"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI17"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI18"
                                }), new UIComponentDescriptor({
                                    "type":TechItemUI,
                                    "id":"_Technology_TechItemUI19"
                                })]
                            });
                        }
                    })]});
            }
        });
        private var techUiMap:Object = new Object();
        private var uiCache:UICache = new UICache(20);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Technology()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Technology_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Technology._watcherSetupUtil = _arg_1;
        }


        public function set schoolAmountText(_arg_1:Text):void
        {
            var _local_2:Object = this._1984916423schoolAmountText;
            if (_local_2 !== _arg_1)
            {
                this._1984916423schoolAmountText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "schoolAmountText", _local_2, _arg_1));
            };
        }

        public function set curCastleResearchingUI(_arg_1:TechReseachingUI):void
        {
            var _local_2:Object = this._58467523curCastleResearchingUI;
            if (_local_2 !== _arg_1)
            {
                this._58467523curCastleResearchingUI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastleResearchingUI", _local_2, _arg_1));
            };
        }

        public function set productContain(_arg_1:Tile):void
        {
            var _local_2:Object = this._817714405productContain;
            if (_local_2 !== _arg_1)
            {
                this._817714405productContain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productContain", _local_2, _arg_1));
            };
        }

        private function _Technology_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("当前书院研究项目");
            _local_1 = Lang.msg("其他书院研究项目");
            _local_1 = (Lang.msg("共有书院") + ": ");
            _local_1 = schoolAmout;
            _local_1 = TechConstants.CROP_TECH;
            _local_1 = TechConstants.HEW_TECH;
            _local_1 = TechConstants.EXCAVATION_TECH;
            _local_1 = TechConstants.SMELT_TECH;
            _local_1 = TechConstants.MAKE_TECH;
            _local_1 = TechConstants.SCOUT_SKILL;
            _local_1 = TechConstants.TRAIN_SKILL;
            _local_1 = TechConstants.COMBAT_SKILL;
            _local_1 = TechConstants.DEFEND_SKILL;
            _local_1 = TechConstants.LOAD_TECH;
            _local_1 = TechConstants.MARCH_SKILL;
            _local_1 = TechConstants.DRIVE_SKILL;
            _local_1 = TechConstants.THROW_SKILL;
            _local_1 = TechConstants.STORE_TECH;
            _local_1 = TechConstants.SUPPLY_SKILL;
            _local_1 = TechConstants.BUILD_TECH;
            _local_1 = TechConstants.FORTIFICATION_TECH;
            _local_1 = TechConstants.REPAIR_TECH;
            _local_1 = TechConstants.HARRY_SKILL;
        }

        [Bindable(event="propertyChange")]
        private function get schoolAmout():int
        {
            return (this._1299767438schoolAmout);
        }

        private function onSpeedUpResearch(_arg_1:ResearchResponse):void
        {
            trace((this.className + "onSpeedUpResearch()"));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        override public function initialize():void
        {
            var target:Technology;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Technology_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_technology_TechnologyWatcherSetupUtil");
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

        private function onSomeBuildingComplete(_arg_1:BuildingChangeEvent):void
        {
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get curCastleResearchingUI():TechReseachingUI
        {
            return (this._58467523curCastleResearchingUI);
        }

        [Bindable(event="propertyChange")]
        public function get currentProductContain():Canvas
        {
            return (this._1192646334currentProductContain);
        }

        public function ___Technology_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function init():void
        {
            var _local_1:TechItemUI;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_CANCEL_RESEARCH, onTechCancelResearch);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_RESEARCH, onTechResearch);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_SPEED_UP_RESEARCH, onSpeedUpResearch);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESEARCH_COMPLETE_UPDATE, onResearchComplete);
            MsgDispacther.getInstance().addEventListener(TownView.EVENT_BUILDING_COMPLETE, onSomeBuildingComplete);
            MsgDispacther.getInstance().addEventListener(CityView.EVENT_BUILDING_COMPLETE, onSomeBuildingComplete);
            for each (_local_1 in this.productContain.getChildren())
            {
                trace(((this.className + "init() addTechUi") + _local_1.techTypeId));
                this.techUiMap[_local_1.techTypeId] = _local_1;
            };
        }

        private function _Technology_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前书院研究项目");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Technology_Label1.text = _arg_1;
            }, "_Technology_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("其他书院研究项目");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                currentStaticLabel.text = _arg_1;
            }, "currentStaticLabel.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("共有书院") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Technology_Label3.text = _arg_1;
            }, "_Technology_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = schoolAmout;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                schoolAmountText.text = _arg_1;
            }, "schoolAmountText.text");
            result[3] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.CROP_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI1.techTypeId = _arg_1;
            }, "_Technology_TechItemUI1.techTypeId");
            result[4] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.HEW_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI2.techTypeId = _arg_1;
            }, "_Technology_TechItemUI2.techTypeId");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.EXCAVATION_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI3.techTypeId = _arg_1;
            }, "_Technology_TechItemUI3.techTypeId");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.SMELT_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI4.techTypeId = _arg_1;
            }, "_Technology_TechItemUI4.techTypeId");
            result[7] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.MAKE_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI5.techTypeId = _arg_1;
            }, "_Technology_TechItemUI5.techTypeId");
            result[8] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.SCOUT_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI6.techTypeId = _arg_1;
            }, "_Technology_TechItemUI6.techTypeId");
            result[9] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.TRAIN_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI7.techTypeId = _arg_1;
            }, "_Technology_TechItemUI7.techTypeId");
            result[10] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.COMBAT_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI8.techTypeId = _arg_1;
            }, "_Technology_TechItemUI8.techTypeId");
            result[11] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.DEFEND_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI9.techTypeId = _arg_1;
            }, "_Technology_TechItemUI9.techTypeId");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.LOAD_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI10.techTypeId = _arg_1;
            }, "_Technology_TechItemUI10.techTypeId");
            result[13] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.MARCH_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI11.techTypeId = _arg_1;
            }, "_Technology_TechItemUI11.techTypeId");
            result[14] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.DRIVE_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI12.techTypeId = _arg_1;
            }, "_Technology_TechItemUI12.techTypeId");
            result[15] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.THROW_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI13.techTypeId = _arg_1;
            }, "_Technology_TechItemUI13.techTypeId");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.STORE_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI14.techTypeId = _arg_1;
            }, "_Technology_TechItemUI14.techTypeId");
            result[17] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.SUPPLY_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI15.techTypeId = _arg_1;
            }, "_Technology_TechItemUI15.techTypeId");
            result[18] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.BUILD_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI16.techTypeId = _arg_1;
            }, "_Technology_TechItemUI16.techTypeId");
            result[19] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.FORTIFICATION_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI17.techTypeId = _arg_1;
            }, "_Technology_TechItemUI17.techTypeId");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.REPAIR_TECH);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI18.techTypeId = _arg_1;
            }, "_Technology_TechItemUI18.techTypeId");
            result[21] = binding;
            binding = new Binding(this, function ():int
            {
                return (TechConstants.HARRY_SKILL);
            }, function (_arg_1:int):void
            {
                _Technology_TechItemUI19.techTypeId = _arg_1;
            }, "_Technology_TechItemUI19.techTypeId");
            result[22] = binding;
            return (result);
        }

        private function onTechCancelResearch(_arg_1:CommandResponse):void
        {
            trace((this.className + "onTechCancelResearch()"));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onTechResearch(_arg_1:ResearchResponse):void
        {
            var _local_2:Object;
            trace((this.className + "onTechResearch()"));
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
                if (((Context.getInstance().isBuildHelp) && (Context.getInstance().isResearchHelp)))
                {
                    _local_2 = FbData.getInstance().getValue(20045);
                    if (_local_2 != null)
                    {
                        RandomEventWin.show(11);
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
            Context.getInstance().isResearchHelp = false;
        }

        private function getCastleById(_arg_1:int):CastleBean
        {
            var _local_3:CastleBean;
            var _local_2:PlayerBean = Context.getInstance().getPlayerBean();
            for each (_local_3 in _local_2.castlesArray)
            {
                if (_local_3.id == _arg_1)
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        override public function refresh():void
        {
            var _local_1:TechItemUI;
            trace((this.className + " refresh()"));
            if (this.initialized)
            {
                this.curCastleResearchingUI.visible = false;
                this.otherCastleResearch.removeAllChildren();
                for each (_local_1 in this.productContain.getChildren())
                {
                    _local_1.isCanResearch = false;
                };
            };
            this.countSchools();
            ActionFactory.getInstance().getTechCommand().getResearchList(Context.getInstance().getCurCastle().id, onGetResearchList);
        }

        [Bindable(event="propertyChange")]
        public function get otherCastleResearch():VBox
        {
            return (this._330690077otherCastleResearch);
        }

        [Bindable(event="propertyChange")]
        public function get productContain():Tile
        {
            return (this._817714405productContain);
        }

        public function set otherCastleResearch(_arg_1:VBox):void
        {
            var _local_2:Object = this._330690077otherCastleResearch;
            if (_local_2 !== _arg_1)
            {
                this._330690077otherCastleResearch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherCastleResearch", _local_2, _arg_1));
            };
        }

        public function set currentStaticLabel(_arg_1:Label):void
        {
            var _local_2:Object = this._86084077currentStaticLabel;
            if (_local_2 !== _arg_1)
            {
                this._86084077currentStaticLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentStaticLabel", _local_2, _arg_1));
            };
        }

        private function onGetResearchList(_arg_1:AvailableResearchListResponse):void
        {
            var _local_2:int;
            var _local_3:AvailableResearchListBean;
            var _local_4:TechItemUI;
            var _local_5:TechReseachingUI;
            trace((this.className + "onGetResearchList() "));
            this.uiCache.reset();
            if (_arg_1.ok)
            {
                _local_2 = 0;
                while (_local_2 < _arg_1.acailableResearchBeansArray.length)
                {
                    _local_3 = (_arg_1.acailableResearchBeansArray.getItemAt(_local_2) as AvailableResearchListBean);
                    _local_4 = (this.techUiMap[_local_3.typeId] as TechItemUI);
                    _local_4.techBean = _local_3;
                    if (_local_3.upgradeing)
                    {
                        if (_local_3.castleId == Context.getInstance().getCurCastle().id)
                        {
                            this.curCastleResearchingUI.visible = true;
                            this.curCastleResearchingUI.bean = _local_3;
                            this.curCastleResearchingUI.buildBean = this.getBuildingBean();
                            this.curCastleResearchingUI.teachTypeId = _local_4.techTypeId;
                        }
                        else
                        {
                            _local_5 = (this.uiCache.getUI(TechReseachingUI) as TechReseachingUI);
                            this.otherCastleResearch.addChild(_local_5);
                            _local_5.bean = _local_3;
                        };
                    };
                    _local_2++;
                };
            }
            else
            {
                trace(((this.className + "onGetResearchList error: ") + _arg_1.errorMsg));
            };
        }

        [Bindable(event="propertyChange")]
        public function get schoolAmountText():Text
        {
            return (this._1984916423schoolAmountText);
        }

        private function onResearchComplete(_arg_1:ResearchCompleteUpdate):void
        {
            refresh();
            var _local_2:int = _arg_1.typeId;
            var _local_3:String = String(_arg_1.level);
            var _local_4:CastleBean = getCastleById(_arg_1.castleId);
            var _local_5:* = ((((((((((("<FONT COLOR='#FF0000'>" + _local_4.name) + "</FONT>") + "'s ") + "<FONT COLOR='#F7B70B'>") + TechEumDefine.getTechEumByType(_local_2).name) + "</FONT>") + "<FONT COLOR='#FF0000'>") + " LV ") + _local_3) + "</FONT>") + " research successfully！");
            var _local_6:* = ((((((((((("<FONT COLOR='#FF0000'>" + _local_4.name) + "</FONT>") + "'s ") + "<FONT COLOR='#0066FF'>") + TechEumDefine.getTechEumByType(_local_2).name) + "</FONT>") + "<FONT COLOR='#FF0000'>") + " LV ") + _local_3) + "</FONT>") + " research successfully！");
            MainWin.instance.onFinishInfoMsg(_local_5);
            ChatFrame.instance.onFinishInfoMSg(_local_6);
        }

        [Bindable(event="propertyChange")]
        public function get currentStaticLabel():Label
        {
            return (this._86084077currentStaticLabel);
        }

        private function countSchools():void
        {
            var _local_2:String;
            var _local_3:ArrayCollection;
            var _local_4:String;
            schoolAmout = 0;
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().castlesArray;
            for (_local_2 in _local_1)
            {
                _local_3 = CastleBean(_local_1[_local_2]).buildingsArray;
                for (_local_4 in _local_3)
                {
                    if (BuildingBean(_local_3[_local_4]).typeId == BuildingConstants.TYPE_ACADEMY)
                    {
                        this.schoolAmout++;
                    };
                };
            };
        }

        public function set currentProductContain(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1192646334currentProductContain;
            if (_local_2 !== _arg_1)
            {
                this._1192646334currentProductContain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentProductContain", _local_2, _arg_1));
            };
        }

        private function set schoolAmout(_arg_1:int):void
        {
            var _local_2:Object = this._1299767438schoolAmout;
            if (_local_2 !== _arg_1)
            {
                this._1299767438schoolAmout = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "schoolAmout", _local_2, _arg_1));
            };
        }


    }
}//package view.module.technology

