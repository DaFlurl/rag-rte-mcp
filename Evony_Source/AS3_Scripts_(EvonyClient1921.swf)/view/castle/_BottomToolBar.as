// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle._BottomToolBar

package view.castle
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.ViewStack;
    import com.evony.common.beans.BuildingBean;
    import mx.containers.VBox;
    import view.ui.TechnologyBar;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import com.evony.util.UICache;
    import mx.core.UIComponent;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.MsgDispacther;
    import com.evony.events.BuildingChangeEvent;
    import com.evony.common.server.events.BuildingQueueUpdate;
    import com.evony.common.server.events.BuildComplate;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import com.evony.client.response.ResponseDispatcher;
    import view.ui.WarDeclarationsBar;
    import com.evony.common.beans.PlayerDeclaredWarBean;
    import flash.events.Event;
    import com.evony.common.server.events.SelfArmysUpdate;
    import com.evony.common.beans.AvailableResearchListBean;
    import com.evony.common.server.events.AcademyResearchUpdate;
    import mx.binding.Binding;
    import mx.core.IToolTip;
    import mx.managers.ToolTipManager;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.tech.AvailableResearchListResponse;
    import com.evony.events.ChangeSizeEvent;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.common.server.events.DeclaredWarUpdate;
    import view.ui.BuildingBar;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.common.constants.BuildingConstants;
    import view.ui.ArmyMovementBar;
    import view.ui.ColonyBar;
    import com.evony.common.beans.ColonyBean;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import view.ui.MercenaryBar;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.constants.ArmyConstants;
    import com.evony.GameConfig;
    import com.evony.common.beans.MercenaryBean;
    import com.evony.client.action.ActionFactory;
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

    public class _BottomToolBar extends Canvas implements IBindingClient 
    {

        public static const EVENT_BUILDING_UPDATE:String = "BottomToolBar.buildingUpdate";
        public static const EVENT_SELFARMYS_RESETED:String = "BottomToolBar.selfArmysReseted";
        public static const EVENT_REFRESHSELFARMYS:String = "BottomToolBar.refreshArmys";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1584105757viewStack:ViewStack;
        private var _696937552hasTech:Boolean = false;
        private var _982906011buildingDesc:String;
        private var mouseOverEffect:Boolean = false;
        private var _1616414137techDesc:String;
        private var _1862638161viewStack2:ViewStack;
        private var _185887518PeaceBean:BuildingBean;
        public var __BottomToolBar_Canvas2:Canvas;
        private var _898042984isPressed:Boolean = false;
        private var _1443811182hasBuilding:Boolean = false;
        private var _10526356hasEquipTech:Boolean = false;
        private var _153931906hasSecondBuilding:Boolean = false;
        private var isClick:Boolean = false;
        private var _126531572hasPeace:Boolean = false;
        private var isFinishTech:Boolean = false;
        private var bReportBlockBar:Boolean = false;
        private var _3893532curBuildingBean:BuildingBean;
        public var nowHasBuilding:int = 0;
        private var _935289393armyMovementView:VBox;
        private var _852350822vBoxBg:VBox;
        private var _1437617763techBar:TechnologyBar;
        private var _2098967865buidingView:VBox;
        private var _1506323224secondBuildingBean:BuildingBean;
        private var _2128119045isShowOutline:Boolean = false;
        private var _25190394peaceEndTime:Number;
        private var _1457130723declareWarView:VBox;
        private var _1417182017buildingBar:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "id":"vBoxBg",
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":425,
                                "styleName":"schedule",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"viewStack",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "maxHeight":230,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"buidingView",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"__BottomToolBar_Canvas2",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "id":"buildingBar",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 0;
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TechnologyBar,
                                                            "id":"techBar",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":23
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "maxHeight":230,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "id":"armyMovementView",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":30,
                                                                    "verticalScrollPolicy":"off",
                                                                    "horizontalScrollPolicy":"off"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "maxHeight":230,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "id":"declareWarView",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalGap = 0;
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"viewStack2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":37,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button1_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "12";
                                                                this.top = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"Construction"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button2_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "0";
                                                                this.left = "112";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"troops"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button3_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "0";
                                                                this.left = "184";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"WarDeclarations"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":37,
                                                        "styleName":"schedulef",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button4_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "12";
                                                                this.bottom = "5";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"Construction"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button5_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "5";
                                                                this.left = "112";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"troops"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"____BottomToolBar_Button6_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.bottom = "5";
                                                                this.left = "184";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"WarDeclarations"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var _307245397armyMovementArr:ArrayCollection = new ArrayCollection();
        private var _1978297095colonyArr:ArrayCollection = new ArrayCollection();
        private var _2033060469mercenaryArr:ArrayCollection = new ArrayCollection();
        private var _191418573declaredWarArr:ArrayCollection = new ArrayCollection();
        private var buildUiCache:UICache = new UICache(15);
        private var uiCache:UICache = new UICache(12);
        private var warUiCache:UICache = new UICache(100);
        private var coloniUiCache:UICache = new UICache(12);
        private var mercenaryUiCache:UICache = new UICache(20);
        private var maskArmyView:UIComponent = new UIComponent();
        private var techList:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function _BottomToolBar()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.borderColor = 12040892;
            };
            this.creationPolicy = "all";
            this.addEventListener("creationComplete", ____BottomToolBar_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            _BottomToolBar._watcherSetupUtil = _arg_1;
        }

        public static function buildingQueueUpdate(_arg_1:BuildingQueueUpdate):void
        {
            MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(EVENT_BUILDING_UPDATE, null, _arg_1.castleId));
        }

        public static function buildingUpdate(_arg_1:BuildComplate):void
        {
            MsgDispacther.getInstance().dispatchEvent(new BuildingChangeEvent(EVENT_BUILDING_UPDATE, _arg_1.buildingBean, _arg_1.castleId));
        }


        public function ____BottomToolBar_Button4_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(0);
        }

        private function set hasSecondBuilding(_arg_1:Boolean):void
        {
            var _local_2:Object = this._153931906hasSecondBuilding;
            if (_local_2 !== _arg_1)
            {
                this._153931906hasSecondBuilding = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasSecondBuilding", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_RESEARCH_LIST, onGetResearchList);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_UPDATE, onBuildingUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, onSelfArmysUpdate);
            MsgDispacther.getInstance().addEventListener(_BottomToolBar.EVENT_REFRESHSELFARMYS, onRefreshArmysView);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_UPDATE, onDeclaredWarUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ACADEMY_RESEARCH_UPDATE, onRefreshResearchEvent);
            setSize();
            this.refresh();
            setDeclareWarArr();
        }

        [Bindable(event="propertyChange")]
        private function get isShowOutline():Boolean
        {
            return (this._2128119045isShowOutline);
        }

        [Bindable(event="propertyChange")]
        private function get colonyArr():ArrayCollection
        {
            return (this._1978297095colonyArr);
        }

        [Bindable(event="propertyChange")]
        private function get secondBuildingBean():BuildingBean
        {
            return (this._1506323224secondBuildingBean);
        }

        [Bindable(event="propertyChange")]
        private function get PeaceBean():BuildingBean
        {
            return (this._185887518PeaceBean);
        }

        private function setDeclareWarArr():void
        {
            var _local_2:WarDeclarationsBar;
            this.declaredWarArr = new ArrayCollection();
            declaredWarArr = Context.getInstance().getPlayerBean().declaredWarBeansArray;
            this.warUiCache.reset();
            this.declareWarView.removeAllChildren();
            if (declaredWarArr.length <= 0)
            {
                declareWarView.height = 0;
            }
            else
            {
                (declaredWarArr.length > 0);
            };
            declareWarView.height = (23 * declaredWarArr.length);
            var _local_1:int;
            while (_local_1 < declaredWarArr.length)
            {
                _local_2 = (this.warUiCache.getUI(WarDeclarationsBar) as WarDeclarationsBar);
                _local_2.declaredWarBean = (declaredWarArr[_local_1] as PlayerDeclaredWarBean);
                declareWarView.addChild(_local_2);
                _local_1++;
            };
            setSize();
        }

        private function onSelfArmysUpdate(_arg_1:SelfArmysUpdate=null):void
        {
            selfArmysFresh();
            if (_arg_1 != null)
            {
                Context.getInstance().getPlayerBean().selfArmysArray = _arg_1.armysArray;
            };
            MsgDispacther.getInstance().dispatchEvent(new Event(EVENT_SELFARMYS_RESETED));
            if ((((armyMovementArr.length > 0) || (getColonyNum() > 0)) || (mercenaryArr.length > 0)))
            {
                isPressed = false;
                viewStack.selectedIndex = 1;
            }
            else
            {
                if (((hasBuilding) || (hasTech)))
                {
                    isPressed = false;
                    viewStack.selectedIndex = 0;
                }
                else
                {
                    if (declaredWarArr.length > 0)
                    {
                        isPressed = false;
                        viewStack.selectedIndex = 2;
                    }
                    else
                    {
                        isPressed = true;
                    };
                };
            };
            setSize();
        }

        private function set mercenaryArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2033060469mercenaryArr;
            if (_local_2 !== _arg_1)
            {
                this._2033060469mercenaryArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mercenaryArr", _local_2, _arg_1));
            };
        }

        private function set colonyArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1978297095colonyArr;
            if (_local_2 !== _arg_1)
            {
                this._1978297095colonyArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyArr", _local_2, _arg_1));
            };
        }

        public function set vBoxBg(_arg_1:VBox):void
        {
            var _local_2:Object = this._852350822vBoxBg;
            if (_local_2 !== _arg_1)
            {
                this._852350822vBoxBg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "vBoxBg", _local_2, _arg_1));
            };
        }

        private function set secondBuildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._1506323224secondBuildingBean;
            if (_local_2 !== _arg_1)
            {
                this._1506323224secondBuildingBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "secondBuildingBean", _local_2, _arg_1));
            };
        }

        public function ____BottomToolBar_Button1_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(0);
        }

        public function set techBar(_arg_1:TechnologyBar):void
        {
            var _local_2:Object = this._1437617763techBar;
            if (_local_2 !== _arg_1)
            {
                this._1437617763techBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techBar", _local_2, _arg_1));
            };
        }

        private function onRefreshResearchEvent(_arg_1:AcademyResearchUpdate):void
        {
            var _local_2:AvailableResearchListBean = _arg_1.researchBean;
            if (_local_2.castleId == Context.getInstance().getCurCastle().id)
            {
                techBar.myTechBean = _local_2;
            };
        }

        public function ____BottomToolBar_Button5_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(1);
        }

        private function set isPressed(_arg_1:Boolean):void
        {
            var _local_2:Object = this._898042984isPressed;
            if (_local_2 !== _arg_1)
            {
                this._898042984isPressed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isPressed", _local_2, _arg_1));
            };
        }

        private function __BottomToolBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (isPressed == false);
            }, function (_arg_1:Boolean):void
            {
                viewStack.visible = _arg_1;
            }, "viewStack.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isPressed == false);
            }, function (_arg_1:Boolean):void
            {
                viewStack.includeInLayout = _arg_1;
            }, "viewStack.includeInLayout");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((hasBuilding) || (hasTech));
            }, function (_arg_1:Boolean):void
            {
                buidingView.visible = _arg_1;
            }, "buidingView.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                __BottomToolBar_Canvas2.visible = _arg_1;
            }, "__BottomToolBar_Canvas2.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                __BottomToolBar_Canvas2.includeInLayout = _arg_1;
            }, "__BottomToolBar_Canvas2.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasBuilding);
            }, function (_arg_1:Boolean):void
            {
                buildingBar.includeInLayout = _arg_1;
            }, "buildingBar.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                techBar.visible = _arg_1;
            }, "techBar.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTech);
            }, function (_arg_1:Boolean):void
            {
                techBar.includeInLayout = _arg_1;
            }, "techBar.includeInLayout");
            result[7] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get declaredWarArr():ArrayCollection
        {
            return (this._191418573declaredWarArr);
        }

        private function set PeaceBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._185887518PeaceBean;
            if (_local_2 !== _arg_1)
            {
                this._185887518PeaceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "PeaceBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get techDesc():String
        {
            return (this._1616414137techDesc);
        }

        [Bindable(event="propertyChange")]
        public function get buidingView():VBox
        {
            return (this._2098967865buidingView);
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            trace((this.className + ".onCurCastleChange()"));
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        private function get hasTech():Boolean
        {
            return (this._696937552hasTech);
        }

        [Bindable(event="propertyChange")]
        public function get armyMovementView():VBox
        {
            return (this._935289393armyMovementView);
        }

        [Bindable(event="propertyChange")]
        private function get armyMovementArr():ArrayCollection
        {
            return (this._307245397armyMovementArr);
        }

        public function set viewStack2(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1862638161viewStack2;
            if (_local_2 !== _arg_1)
            {
                this._1862638161viewStack2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewStack2", _local_2, _arg_1));
            };
        }

        public function set armyMovementView(_arg_1:VBox):void
        {
            var _local_2:Object = this._935289393armyMovementView;
            if (_local_2 !== _arg_1)
            {
                this._935289393armyMovementView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyMovementView", _local_2, _arg_1));
            };
        }

        private function onBuildingUpdate(_arg_1:BuildingChangeEvent):void
        {
            if (_arg_1.castleId == Context.getInstance().getCurCastle().id)
            {
                this.refreshBuilding();
            };
            if (((hasTech) || (hasBuilding)))
            {
                isPressed = false;
                viewStack.selectedIndex = 0;
            }
            else
            {
                if ((((armyMovementArr.length > 0) || (getColonyNum() > 0)) || (mercenaryArr.length > 0)))
                {
                    isPressed = false;
                    viewStack.selectedIndex = 1;
                }
                else
                {
                    if (declaredWarArr.length > 0)
                    {
                        isPressed = false;
                        viewStack.selectedIndex = 2;
                    }
                    else
                    {
                        isPressed = true;
                    };
                };
            };
            setSize();
        }

        private function set declaredWarArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._191418573declaredWarArr;
            if (_local_2 !== _arg_1)
            {
                this._191418573declaredWarArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declaredWarArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get buildingDesc():String
        {
            return (this._982906011buildingDesc);
        }

        private function onToolTipShown(_arg_1:Event):void
        {
            var _local_2:IToolTip;
            if (ToolTipManager.currentToolTip)
            {
                _local_2 = ToolTipManager.currentToolTip;
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasBuilding():Boolean
        {
            return (this._1443811182hasBuilding);
        }

        private function onGetResearchList(_arg_1:AvailableResearchListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                techList = _arg_1.acailableResearchBeansArray;
                onRefreshResearchList(_arg_1.acailableResearchBeansArray);
            }
            else
            {
                trace(((this.className + "onGetResearchList error: ") + _arg_1.errorMsg));
            };
            if (((hasTech) || (hasBuilding)))
            {
                isPressed = false;
                viewStack.selectedIndex = 0;
            }
            else
            {
                if ((((armyMovementArr.length > 0) || (getColonyNum() > 0)) || (mercenaryArr.length > 0)))
                {
                    isPressed = false;
                    viewStack.selectedIndex = 1;
                }
                else
                {
                    if (declaredWarArr.length > 0)
                    {
                        isPressed = false;
                        viewStack.selectedIndex = 2;
                    }
                    else
                    {
                        isPressed = true;
                    };
                };
            };
            setSize();
        }

        public function set buidingView(_arg_1:VBox):void
        {
            var _local_2:Object = this._2098967865buidingView;
            if (_local_2 !== _arg_1)
            {
                this._2098967865buidingView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buidingView", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasEquipTech():Boolean
        {
            return (this._10526356hasEquipTech);
        }

        private function getColonyNum():int
        {
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < colonyArr.length)
            {
                if (colonyArr[_local_2].status != 2)
                {
                    _local_1++;
                };
                _local_2++;
            };
            return (_local_1);
        }

        public function ____BottomToolBar_Button2_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(1);
        }

        [Bindable(event="propertyChange")]
        private function get hasSecondBuilding():Boolean
        {
            return (this._153931906hasSecondBuilding);
        }

        private function setSize():void
        {
            var _local_1:int;
            TownView.handleNewArmy(armyMovementView.numChildren);
            isShowOutline = this.showOutline();
            if (viewStack.selectedIndex == 0)
            {
                if (((hasBuilding) || (hasTech)))
                {
                    viewStack2.selectedIndex = 1;
                    _local_1 = nowHasBuilding;
                    if (hasTech)
                    {
                        _local_1 = (_local_1 + 1);
                    };
                    buidingView.height = (23 * _local_1);
                }
                else
                {
                    viewStack2.selectedIndex = 0;
                    buidingView.height = 0;
                };
                this.viewStack.height = this.buidingView.height;
            }
            else
            {
                if (viewStack.selectedIndex == 1)
                {
                    if (armyMovementView.numChildren != 0)
                    {
                        viewStack2.selectedIndex = 1;
                    }
                    else
                    {
                        buidingView.height = 0;
                    };
                    this.viewStack.height = this.armyMovementView.height;
                }
                else
                {
                    if (viewStack.selectedIndex == 2)
                    {
                        if (declareWarView.numChildren != 0)
                        {
                            viewStack2.selectedIndex = 1;
                        };
                        this.viewStack.height = ((this.declareWarView.height >= 230) ? 230 : this.declareWarView.height);
                    };
                };
            };
            if (isPressed)
            {
                this.dispatchEvent(new ChangeSizeEvent(ChangeSizeEvent.SIZE_CHANGE_EVENT, 4));
                viewStack2.selectedIndex = 0;
            }
            else
            {
                this.dispatchEvent(new ChangeSizeEvent(ChangeSizeEvent.SIZE_CHANGE_EVENT, (viewStack.height + 4)));
                viewStack2.selectedIndex = 1;
            };
            if (viewStack.selectedIndex == 1)
            {
                buidingView.visible = false;
                declareWarView.visible = false;
                armyMovementView.visible = true;
            }
            else
            {
                if (viewStack.selectedIndex == 0)
                {
                    armyMovementView.visible = false;
                    declareWarView.visible = false;
                    buidingView.visible = true;
                }
                else
                {
                    if (viewStack.selectedIndex == 2)
                    {
                        armyMovementView.visible = false;
                        buidingView.visible = false;
                        declareWarView.visible = true;
                    };
                };
            };
        }

        private function showOutline():Boolean
        {
            var _local_1:Boolean;
            if (viewStack.selectedIndex == 0)
            {
                _local_1 = (((hasBuilding) || (hasTech)) ? true : false);
            }
            else
            {
                if (viewStack.selectedIndex == 1)
                {
                    _local_1 = ((this.armyMovementArr.length > 0) ? true : false);
                };
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get mercenaryArr():ArrayCollection
        {
            return (this._2033060469mercenaryArr);
        }

        public function ____BottomToolBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:_BottomToolBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = __BottomToolBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle__BottomToolBarWatcherSetupUtil");
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

        public function ____BottomToolBar_Button6_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(2);
        }

        private function onDeclaredWarUpdate(_arg_1:DeclaredWarUpdate):void
        {
            Context.getInstance().getPlayerBean().declaredWarBeansArray = _arg_1.declaredWarBeansArray;
            setDeclareWarArr();
            if (declaredWarArr.length > 0)
            {
                isPressed = false;
                viewStack.selectedIndex = 2;
            }
            else
            {
                if (((hasBuilding) || (hasTech)))
                {
                    isPressed = false;
                    viewStack.selectedIndex = 0;
                }
                else
                {
                    if ((((armyMovementArr.length > 0) || (getColonyNum() > 0)) || (mercenaryArr.length > 0)))
                    {
                        isPressed = false;
                        viewStack.selectedIndex = 1;
                    }
                    else
                    {
                        isPressed = true;
                    };
                };
            };
            setSize();
        }

        private function onRefreshArmysView(_arg_1:Event):void
        {
            onSelfArmysUpdate();
        }

        public function set buildingBar(_arg_1:VBox):void
        {
            var _local_2:Object = this._1417182017buildingBar;
            if (_local_2 !== _arg_1)
            {
                this._1417182017buildingBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingBar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get vBoxBg():VBox
        {
            return (this._852350822vBoxBg);
        }

        [Bindable(event="propertyChange")]
        public function get techBar():TechnologyBar
        {
            return (this._1437617763techBar);
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

        private function set armyMovementArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._307245397armyMovementArr;
            if (_local_2 !== _arg_1)
            {
                this._307245397armyMovementArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyMovementArr", _local_2, _arg_1));
            };
        }

        private function refreshBuilding():void
        {
            var _local_5:BuildingBean;
            var _local_7:BuildingBar;
            var _local_8:BuildingQueueBean;
            var _local_9:BuildingBar;
            trace((this.className + ".refreshBuilding()"));
            var _local_1:Boolean;
            var _local_2:int;
            var _local_3:int = Context.getInstance().getCurCastle().buildingQueuesArray.length;
            var _local_4:ArrayCollection = new ArrayCollection();
            for each (_local_5 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((!(_local_5.status == BuildingConstants.STATUS_NORMAL)) && (!(_local_5.status == BuildingConstants.STATUS_WAITING))))
                {
                    if (_local_1 == false)
                    {
                        _local_1 = true;
                    };
                    _local_2++;
                    _local_4.addItem(_local_5);
                };
            };
            this.buildUiCache.reset();
            if (_local_3 > 0)
            {
                this.buildUiCache.deleteAllChildren();
            };
            this.buildingBar.removeAllChildren();
            if (_local_2 <= 0)
            {
                buildingBar.height = 0;
            }
            else
            {
                (_local_2 > 0);
            };
            buildingBar.height = (23 * _local_2);
            var _local_6:int;
            while (_local_6 < _local_2)
            {
                _local_7 = (this.buildUiCache.getUI(BuildingBar) as BuildingBar);
                _local_7.myBuilding = (_local_4[_local_6] as BuildingBean);
                this.buildingBar.addChild(_local_7);
                _local_6++;
            };
            if (_local_3 > 0)
            {
                buildingBar.height = (buildingBar.height + (23 * _local_3));
                for each (_local_8 in Context.getInstance().getCurCastle().buildingQueuesArray)
                {
                    _local_9 = (this.buildUiCache.getUI(BuildingBar) as BuildingBar);
                    _local_9.myBuildingQueue = _local_8;
                    this.buildingBar.addChild(_local_9);
                };
                _local_1 = true;
            };
            this.hasBuilding = _local_1;
            nowHasBuilding = (_local_2 + _local_3);
            setSize();
        }

        [Bindable(event="propertyChange")]
        private function get isPressed():Boolean
        {
            return (this._898042984isPressed);
        }

        [Bindable(event="propertyChange")]
        public function get viewStack2():ViewStack
        {
            return (this._1862638161viewStack2);
        }

        private function onBottomTBClick(_arg_1:int):void
        {
            isClick = true;
            switch (_arg_1)
            {
                case 0:
                    if (viewStack.selectedIndex == 0)
                    {
                        isPressed = (!(isPressed));
                    }
                    else
                    {
                        isPressed = false;
                    };
                    if (!((hasBuilding) || (hasTech)))
                    {
                        isPressed = true;
                    };
                    this.viewStack.selectedIndex = 0;
                    this.refreshBuilding();
                    this.onRefreshResearchList(techList);
                    break;
                case 1:
                    if (viewStack.selectedIndex == 1)
                    {
                        isPressed = (!(isPressed));
                    }
                    else
                    {
                        isPressed = false;
                    };
                    if ((((armyMovementArr.length <= 0) && (getColonyNum() <= 0)) && (mercenaryArr.length <= 0)))
                    {
                        isPressed = true;
                    };
                    this.viewStack.selectedIndex = 1;
                    selfArmysFresh();
                    break;
                case 2:
                    if (viewStack.selectedIndex == 2)
                    {
                        isPressed = (!(isPressed));
                    }
                    else
                    {
                        isPressed = false;
                    };
                    if (declaredWarArr.length <= 0)
                    {
                        isPressed = true;
                    };
                    this.viewStack.selectedIndex = 2;
                    setDeclareWarArr();
                    break;
            };
            setSize();
        }

        [Bindable(event="propertyChange")]
        public function get buildingBar():VBox
        {
            return (this._1417182017buildingBar);
        }

        public function set declareWarView(_arg_1:VBox):void
        {
            var _local_2:Object = this._1457130723declareWarView;
            if (_local_2 !== _arg_1)
            {
                this._1457130723declareWarView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "declareWarView", _local_2, _arg_1));
            };
        }

        private function __BottomToolBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (isPressed == false);
            _local_1 = (isPressed == false);
            _local_1 = ((hasBuilding) || (hasTech));
            _local_1 = hasBuilding;
            _local_1 = hasBuilding;
            _local_1 = hasBuilding;
            _local_1 = hasTech;
            _local_1 = hasTech;
        }

        private function selfArmysFresh():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:ArmyMovementBar;
            var _local_7:ColonyBar;
            var _local_8:ColonyBean;
            var _local_9:URLLoader;
            var _local_10:URLRequest;
            var _local_11:MercenaryBar;
            this.armyMovementArr = new ArrayCollection();
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().selfArmysArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (ArmyBean(_local_1[_local_2]).direction != ArmyConstants.ARMY_STAY)
                {
                    if (ArmyBean(_local_1[_local_2]).startFieldId == Context.getInstance().getCurCastle().fieldId)
                    {
                        armyMovementArr.addItem(_local_1[_local_2]);
                    };
                };
                _local_2++;
            };
            this.colonyArr = Context.getInstance().getCurCastle().colonyBeansArray;
            this.mercenaryArr = Context.getInstance().getCurCastle().mercenaryBeansArray;
            this.uiCache.reset();
            this.coloniUiCache.reset();
            this.mercenaryUiCache.reset();
            this.armyMovementView.removeAllChildren();
            if ((((armyMovementArr.length <= 0) && (getColonyNum() <= 0)) && (mercenaryArr.length <= 0)))
            {
                armyMovementView.height = 0;
            }
            else
            {
                armyMovementView.height = (23 * ((armyMovementArr.length + getColonyNum()) + mercenaryArr.length));
                _local_3 = 0;
                while (_local_3 < armyMovementArr.length)
                {
                    _local_6 = (this.uiCache.getUI(ArmyMovementBar) as ArmyMovementBar);
                    _local_6.armyBean = (armyMovementArr[_local_3] as ArmyBean);
                    armyMovementView.addChild(_local_6);
                    _local_3++;
                };
                _local_4 = 0;
                while (_local_4 < colonyArr.length)
                {
                    if (colonyArr[_local_4].status != 2)
                    {
                        _local_7 = (this.coloniUiCache.getUI(ColonyBar) as ColonyBar);
                        _local_8 = (colonyArr[_local_4] as ColonyBean);
                        _local_7.colonyBean = (colonyArr[_local_4] as ColonyBean);
                        armyMovementView.addChild(_local_7);
                        if (!bReportBlockBar)
                        {
                            if ((_local_8.endTime + 60000) < new Date().valueOf())
                            {
                                bReportBlockBar = true;
                                _local_9 = new URLLoader();
                                _local_10 = new URLRequest((((((((((((((((((((((("http://battlena1.evony.com/blockbar.php" + "?castleId=") + _local_8.castleId) + "&serverId=") + GameConfig.instance.serverID) + "&account=") + Context.getInstance().userName) + "&cityName=") + _local_8.cityName) + "&endTime=") + _local_8.endTime) + "&lordName=") + _local_8.lordName) + "&position=") + _local_8.position) + "&relation=") + _local_8.relation) + "&startTime=") + _local_8.startTime) + "&status=") + _local_8.status) + "&time=") + _local_8.time));
                                _local_9.load(_local_10);
                            };
                        };
                    };
                    _local_4++;
                };
                _local_5 = 0;
                while (_local_5 < mercenaryArr.length)
                {
                    _local_11 = (this.mercenaryUiCache.getUI(MercenaryBar) as MercenaryBar);
                    _local_11.mercenaryBean = (mercenaryArr[_local_5] as MercenaryBean);
                    armyMovementView.addChild(_local_11);
                    _local_5++;
                };
            };
            setSize();
        }

        public function set viewStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1584105757viewStack;
            if (_local_2 !== _arg_1)
            {
                this._1584105757viewStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewStack", _local_2, _arg_1));
            };
        }

        private function set curBuildingBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._3893532curBuildingBean;
            if (_local_2 !== _arg_1)
            {
                this._3893532curBuildingBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curBuildingBean", _local_2, _arg_1));
            };
        }

        private function set buildingDesc(_arg_1:String):void
        {
            var _local_2:Object = this._982906011buildingDesc;
            if (_local_2 !== _arg_1)
            {
                this._982906011buildingDesc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingDesc", _local_2, _arg_1));
            };
        }

        public function ____BottomToolBar_Button3_click(_arg_1:MouseEvent):void
        {
            onBottomTBClick(2);
        }

        private function set hasTech(_arg_1:Boolean):void
        {
            var _local_2:Object = this._696937552hasTech;
            if (_local_2 !== _arg_1)
            {
                this._696937552hasTech = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTech", _local_2, _arg_1));
            };
        }

        private function refresh():void
        {
            this.refreshBuilding();
            selfArmysFresh();
            ActionFactory.getInstance().getTechCommand().getResearchList(Context.getInstance().getCurCastle().id, onGetResearchList);
        }

        [Bindable(event="propertyChange")]
        public function get declareWarView():VBox
        {
            return (this._1457130723declareWarView);
        }

        [Bindable(event="propertyChange")]
        private function get curBuildingBean():BuildingBean
        {
            return (this._3893532curBuildingBean);
        }

        private function set hasEquipTech(_arg_1:Boolean):void
        {
            var _local_2:Object = this._10526356hasEquipTech;
            if (_local_2 !== _arg_1)
            {
                this._10526356hasEquipTech = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasEquipTech", _local_2, _arg_1));
            };
        }

        private function set hasPeace(_arg_1:Boolean):void
        {
            var _local_2:Object = this._126531572hasPeace;
            if (_local_2 !== _arg_1)
            {
                this._126531572hasPeace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasPeace", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewStack():ViewStack
        {
            return (this._1584105757viewStack);
        }

        private function set hasBuilding(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1443811182hasBuilding;
            if (_local_2 !== _arg_1)
            {
                this._1443811182hasBuilding = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasBuilding", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasPeace():Boolean
        {
            return (this._126531572hasPeace);
        }

        private function onRefreshResearchList(_arg_1:ArrayCollection):void
        {
            var _local_4:AvailableResearchListBean;
            var _local_2:Boolean;
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1[_local_3];
                if (_local_4.upgradeing)
                {
                    if (_local_4.castleId == Context.getInstance().getCurCastle().id)
                    {
                        techBar.myTechBean = _local_4;
                        _local_2 = true;
                        break;
                    };
                };
                _local_3++;
            };
            this.hasTech = _local_2;
            setSize();
        }

        [Bindable(event="propertyChange")]
        private function get peaceEndTime():Number
        {
            return (this._25190394peaceEndTime);
        }

        private function set peaceEndTime(_arg_1:Number):void
        {
            var _local_2:Object = this._25190394peaceEndTime;
            if (_local_2 !== _arg_1)
            {
                this._25190394peaceEndTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peaceEndTime", _local_2, _arg_1));
            };
        }

        private function set isShowOutline(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2128119045isShowOutline;
            if (_local_2 !== _arg_1)
            {
                this._2128119045isShowOutline = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShowOutline", _local_2, _arg_1));
            };
        }


    }
}//package view.castle

