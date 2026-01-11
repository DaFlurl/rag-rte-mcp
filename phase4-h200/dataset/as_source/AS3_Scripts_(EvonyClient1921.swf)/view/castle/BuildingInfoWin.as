// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.BuildingInfoWin

package view.castle
{
    import view.ui.BaseWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import view.module.wall.Wall;
    import view.ui.BaseBuildingWindow;
    import view.module.barrack.Barrack;
    import view.module.market.Market;
    import view.module.trainningField.TrainningField;
    import view.ui.BuildingInfoTimeLabel;
    import mx.containers.ViewStack;
    import mx.controls.Button;
    import view.ui.ConditionTooltip;
    import view.module.herosMansion.HerosMansion;
    import mx.containers.Canvas;
    import view.module.office.Office;
    import com.evony.common.beans.ConditionBean;
    import mx.binding.utils.ChangeWatcher;
    import view.module.warehouse.WareHouse;
    import view.ui.BuildingInfoRemainTimeLabel;
    import com.evony.common.beans.BuildingBean;
    import view.module.guide.GuideArrow;
    import mx.controls.Image;
    import view.module.technology.Technology;
    import view.module.tavern.Tavern;
    import view.module.workshop.Workshop;
    import mx.controls.Text;
    import view.module.embassy.Embassy;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import flash.utils.Timer;
    import view.ui.BuildingLogoMovieClip;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import view.ui.AlertWin;
    import view.module.guide.GuideStep;
    import com.evony.eum.BuildingEumDefine;
    import com.evony.eum.BuildingEum;
    import view.ui.DescribeTooltip;
    import mx.events.FlexEvent;
    import com.evony.common.module.castle.CheckOutBuildingResponse;
    import com.evony.util.UIUtil;
    import com.evony.events.BuildingChangeEvent;
    import flash.events.Event;
    import view.ui.SpeedUpCheckOut;
    import com.evony.common.constants.CommonConstants;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.constants.ErrorCode;
    import com.evony.GameConfig;
    import com.evony.data.FbData;
    import view.RandomEventWin;
    import flash.external.ExternalInterface;
    import com.evony.eum.ItemEum;
    import com.evony.data.ClickBuildDate;
    import mx.binding.utils.BindingUtils;
    import view.MainWin;
    import com.evony.util.InputTextFilter;
    import flash.events.TimerEvent;
    import view.ui.BuildingDescribeTooltip;
    import mx.collections.ArrayCollection;
    import com.evony.MsgDispacther;
    import view.castle.building.DestrctChoiceWin;
    import com.evony.common.beans.BuildingQueueBean;
    import view.AllWindows;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import com.evony.factory.UIFactory;
    import mx.managers.PopUpManager;
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

    public class BuildingInfoWin extends BaseWindow implements IBindingClient 
    {

        public static var instance:BuildingInfoWin;
        public static const EVENT_SHOW:String = "BuildingInfoWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _BuildingInfoWin_Label1:Label;
        public var _BuildingInfoWin_Label3:Label;
        public var _BuildingInfoWin_Label4:Label;
        private var _795192793wallVs:Wall;
        private var barrackWin:BaseBuildingWindow;
        private var _1964563911barrackVs:Barrack;
        private var isLowFiveMimutes:Boolean;
        private var _397924048buildingLevel:String;
        private var _246972441marketVs:Market;
        private var _835593477trainningFieldVs:TrainningField;
        public var _BuildingInfoWin_BuildingInfoTimeLabel1:BuildingInfoTimeLabel;
        private var _946505330viewstack1:ViewStack;
        private var startUpgradewithhelp:Boolean = false;
        private var _1607799334toLeftBtn:Button;
        private var tt:ConditionTooltip;
        private var _107554lvl:Label;
        private var _253516403herosMansionVs:HerosMansion;
        private var _2067041731btnUpgradeEnable:Boolean = false;
        private var _1647079470swapContainer:Canvas;
        private var _1420684256btnUpgrade:Button;
        private var _765293927officeVs:Office;
        private var _1498725528commandVs:Canvas;
        private var _601108392currentPage:int;
        private var _991395497decconditionBean:ConditionBean;
        private var _762902470buildingStatus:String;
        private var _1437953227btnQueueUpgrade2:Button;
        private var isBuildingDesctShowAll:Boolean = false;
        private var _982906011buildingDesc:String;
        private var _982612129buildingName:String;
        private var _841595259btnDesctruct:Button;
        private var buildingStatusWatcher:ChangeWatcher;
        private var _626460780btnCancelSpeedUp:Button;
        private var currentBuildingWin:BaseBuildingWindow;
        private var _168534240warehouseVs:WareHouse;
        public var _BuildingInfoWin_BuildingInfoRemainTimeLabel1:BuildingInfoRemainTimeLabel;
        private var _3019696bean:BuildingBean;
        private var conditionBean:ConditionBean;
        public var _BuildingInfoWin_Button4:Button;
        private var _1097043782btnSpeedUp:Button;
        private var _1456175557toRightBtn:Button;
        public var _BuildingInfoWin_GuideArrow1:GuideArrow;
        private var _815019520btnDestructVisible:Boolean = true;
        private var _276194949img_buildingLogo:Image;
        private var buildingWinId:String;
        private var _577409037totalPage:int;
        private var _946505329viewstack2:ViewStack;
        private var _1075477737technologyVs:Technology;
        private var _328900107tavernVs:Tavern;
        private var _8091300workshopVs:Workshop;
        public var _BuildingInfoWin_Text1:Text;
        private var _1432142730structingVs:Canvas;
        private var _1730121778btnUpgradeVisible:Boolean = true;
        private var _1508683729embassyVs:Embassy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":218,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"doubleLineBlue",
                                "width":605,
                                "height":119,
                                "x":31,
                                "y":58
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalAlign = "bottom";
                            this.top = "5";
                            this.kerning = true;
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":25,
                                "width":436,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingInfoWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "truncateToFit":false,
                                            "styleName":"winTitleFont"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"lvl",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "truncateToFit":false,
                                            "styleName":"winTitleFont"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___BuildingInfoWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "42";
                            this.top = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"img_buildingLogo",
                        "events":{
                            "complete":"__img_buildingLogo_complete",
                            "mouseOver":"__img_buildingLogo_mouseOver",
                            "mouseOut":"__img_buildingLogo_mouseOut",
                            "mouseMove":"__img_buildingLogo_mouseMove"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":34,
                                "y":63,
                                "width":109,
                                "height":109
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "155";
                            this.right = "185";
                            this.top = "63";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":109,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "styleName":"buildingDescNewBox",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BuildingInfoWin_Text1",
                                    "events":{
                                        "mouseOver":"___BuildingInfoWin_Text1_mouseOver",
                                        "mouseMove":"___BuildingInfoWin_Text1_mouseMove",
                                        "mouseOut":"___BuildingInfoWin_Text1_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText3",
                                            "selectable":false,
                                            "percentHeight":100,
                                            "percentWidth":100
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
                                "x":153,
                                "width":478,
                                "height":28,
                                "y":152,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":BuildingInfoTimeLabel,
                                                "id":"_BuildingInfoWin_BuildingInfoTimeLabel1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":268,
                                                        "styleName":"PropertyValue3"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BuildingInfoWin_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader2"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":BuildingInfoRemainTimeLabel,
                                                "id":"_BuildingInfoWin_BuildingInfoRemainTimeLabel1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":93,
                                                        "styleName":"PropertyValue2"
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.left = "28";
                            this.top = "57";
                            this.right = "23";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":121,
                                "showInAutomationHierarchy":true,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"commandVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"View 1",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "showInAutomationHierarchy":true,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnDesctruct",
                                                "events":{
                                                    "click":"__btnDesctruct_click",
                                                    "mouseOut":"__btnDesctruct_mouseOut",
                                                    "mouseOver":"__btnDesctruct_mouseOver",
                                                    "mouseMove":"__btnDesctruct_mouseMove"
                                                },
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "6";
                                                    this.left = "78";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"delete",
                                                        "width":37,
                                                        "height":37
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnUpgrade",
                                                "events":{
                                                    "click":"__btnUpgrade_click",
                                                    "mouseOut":"__btnUpgrade_mouseOut",
                                                    "mouseOver":"__btnUpgrade_mouseOver",
                                                    "mouseMove":"__btnUpgrade_mouseMove"
                                                },
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "1";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"y125",
                                                        "width":155
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_BuildingInfoWin_Button4",
                                                "events":{"click":"___BuildingInfoWin_Button4_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "1";
                                                    this.fontSize = 11;
                                                    this.top = "6";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Upgrade With Help",
                                                        "styleName":"y125",
                                                        "width":155,
                                                        "height":40,
                                                        "toolTip":"For each facebook friend that clicks on your feed,the build (or upgrade) time will be reduced by either 1 minute or 1% whichever is greater. Up to 10 friends can speed up your build (or upgrade) ."
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"structingVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "showInAutomationHierarchy":true,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnSpeedUp",
                                                "events":{"click":"__btnSpeedUp_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "1";
                                                    this.top = "6";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"y125",
                                                        "width":155,
                                                        "height":40
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnQueueUpgrade2",
                                                "events":{"click":"__btnQueueUpgrade2_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "1";
                                                    this.top = "51";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"y125",
                                                        "width":155,
                                                        "height":30
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"btnCancelSpeedUp",
                                                "events":{"click":"__btnCancelSpeedUp_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "1";
                                                    this.top = "86";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"y125",
                                                        "width":155,
                                                        "height":30
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack2",
                        "stylesFactory":function ():void
                        {
                            this.top = "187";
                            this.bottom = "15";
                            this.left = "32";
                            this.right = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({"type":Canvas}), new UIComponentDescriptor({
                                    "type":Office,
                                    "id":"officeVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Wall,
                                    "id":"wallVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Barrack,
                                    "id":"barrackVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Embassy,
                                    "id":"embassyVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Tavern,
                                    "id":"tavernVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Technology,
                                    "id":"technologyVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TrainningField,
                                    "id":"trainningFieldVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HerosMansion,
                                    "id":"herosMansionVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":WareHouse,
                                    "id":"warehouseVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Workshop,
                                    "id":"workshopVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Market,
                                    "id":"marketVs",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"swapContainer",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":350,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toLeftBtn",
                                    "events":{"click":"__toLeftBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BuildingInfoWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.horizontalCenter = "-1";
                                        this.verticalCenter = "-2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ftp14f",
                                            "width":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"toRightBtn",
                                    "events":{"click":"__toRightBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"next",
                                            "x":100
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_BuildingInfoWin_GuideArrow1",
                        "stylesFactory":function ():void
                        {
                            this.top = "85";
                            this.right = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"upgradeGuide"});
                        }
                    })]
                });
            }
        });
        private var winMap:Array = [];
        private var barrackAry:Array = new Array();
        private var conditionTimer:Timer = new Timer(1000, 0);
        private var buildingLogoMovieClip:BuildingLogoMovieClip = new BuildingLogoMovieClip();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BuildingInfoWin()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 218;
            this.addEventListener("creationComplete", ___BuildingInfoWin_BaseWindow1_creationComplete);
            this.addEventListener("add", ___BuildingInfoWin_BaseWindow1_add);
            this.addEventListener("removedFromStage", ___BuildingInfoWin_BaseWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BuildingInfoWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get btnDestructVisible():Boolean
        {
            return (this._815019520btnDestructVisible);
        }

        public function set trainningFieldVs(_arg_1:TrainningField):void
        {
            var _local_2:Object = this._835593477trainningFieldVs;
            if (_local_2 !== _arg_1)
            {
                this._835593477trainningFieldVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "trainningFieldVs", _local_2, _arg_1));
            };
        }

        private function set btnDestructVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._815019520btnDestructVisible;
            if (_local_2 !== _arg_1)
            {
                this._815019520btnDestructVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnDestructVisible", _local_2, _arg_1));
            };
        }

        private function refreshBuildingInfo():void
        {
            this.buildingLevel = (Lang.msg("等级（简）") + this.bean.level);
            this.lvl.text = this.buildingLevel;
            if (bean.status == BuildingConstants.STATUS_NORMAL)
            {
                this.viewstack1.selectedChild = this.commandVs;
                this.buildingStatus = "";
                this.sendCheckRequest();
            }
            else
            {
                this.viewstack1.selectedChild = this.structingVs;
                this.structingVs.enabled = true;
                if (bean.status == BuildingConstants.STATUS_DESTRUCTING)
                {
                    this.buildingStatus = Lang.msg("拆除中");
                }
                else
                {
                    this.buildingStatus = Lang.msg("升级中");
                };
            };
        }

        private function sendCheckRequest():void
        {
            var _local_2:int;
            this.btnUpgradeEnable = false;
            this.conditionBean = null;
            this.conditionTimer.stop();
            var _local_1:int = BuildingConstants.MAX_LEVEL;
            if (((bean.typeId >= 4) && (bean.typeId <= 7)))
            {
                _local_2 = Context.getInstance().getCurCastle().powerlevel;
                if (_local_2 == 0)
                {
                    _local_1 = 18;
                }
                else
                {
                    if (_local_2 == 1)
                    {
                        _local_1 = 16;
                    }
                    else
                    {
                        if (_local_2 == 2)
                        {
                            _local_1 = 14;
                        }
                        else
                        {
                            if (_local_2 == 3)
                            {
                                _local_1 = 12;
                            };
                        };
                    };
                };
            };
            ActionFactory.getInstance().getCastleCommands().checkOutUpgrade(Context.getInstance().getCurCastle().id, bean.positionId, onCheckOutUpgrade);
            if (bean.level < _local_1)
            {
                this.btnUpgradeVisible = true;
            }
            else
            {
                if (bean.level == _local_1)
                {
                    this.btnUpgradeVisible = false;
                }
                else
                {
                    this.btnUpgradeVisible = false;
                };
            };
        }

        private function onBuildWithHelp():void
        {
            startUpgradewithhelp = true;
            onUpgradeClick();
        }

        public function ___BuildingInfoWin_Text1_mouseOut(_arg_1:MouseEvent):void
        {
            onBuildingDescTxtRollOut();
        }

        [Bindable(event="propertyChange")]
        public function get marketVs():Market
        {
            return (this._246972441marketVs);
        }

        private function onCancle():void
        {
            if (Context.getInstance().isBuildingQueued(this.bean.positionId))
            {
                AlertWin.show(Lang.msg("确定取消排队"), onCancleOk);
            }
            else
            {
                AlertWin.show(Lang.msg("确定取消"), onCancleOk);
            };
        }

        private function upgrade(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getCastleCommands().upgradeBuilding(Context.getInstance().getCurCastle().id, this.bean.positionId, onBuildCommand);
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnUpgrade():Button
        {
            return (this._1420684256btnUpgrade);
        }

        private function checkGuideText():void
        {
            switch (GuideStep.getInstance().currentStep)
            {
                case 110:
                    if (this.bean.typeId == BuildingConstants.TYPE_TAVERN)
                    {
                        GuideStep.getInstance().step110();
                    };
                    return;
                case 120:
                    if (this.bean.typeId == BuildingConstants.TYPE_HEROS_MANSION)
                    {
                        GuideStep.getInstance().step120();
                    };
                    return;
                case 150:
                    if (this.bean.typeId == BuildingConstants.TYPE_TOWN_HALL)
                    {
                        GuideStep.getInstance().step150();
                    };
                    return;
            };
        }

        override public function destroy():void
        {
            trace((this.className + ".destroy()"));
            this.conditionTimer.stop();
            if (buildingStatusWatcher != null)
            {
                buildingStatusWatcher.unwatch();
            };
            if (this.currentBuildingWin != null)
            {
                this.currentBuildingWin.destroy();
            };
        }

        [Bindable(event="propertyChange")]
        public function get lvl():Label
        {
            return (this._107554lvl);
        }

        private function onPicMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:BuildingEum = BuildingEumDefine.getBuildingEumByType(bean.typeId);
            DescribeTooltip.show(_local_2.name, _local_2.wikiDesc, _arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get embassyVs():Embassy
        {
            return (this._1508683729embassyVs);
        }

        public function __img_buildingLogo_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        public function ___BuildingInfoWin_BaseWindow1_add(_arg_1:FlexEvent):void
        {
            onAdded(_arg_1);
        }

        private function onCheckOutUpgrade(_arg_1:CheckOutBuildingResponse):void
        {
            this.conditionBean = _arg_1.conditionBean;
            this.decconditionBean = _arg_1.desConditionBean;
            if (_arg_1.conditionBean != null)
            {
                this.onConditionTime(null);
                this.conditionTimer.start();
            };
        }

        public function __btnDesctruct_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get swapContainer():Canvas
        {
            return (this._1647079470swapContainer);
        }

        [Bindable(event="propertyChange")]
        public function get wallVs():Wall
        {
            return (this._795192793wallVs);
        }

        public function set btnUpgrade(_arg_1:Button):void
        {
            var _local_2:Object = this._1420684256btnUpgrade;
            if (_local_2 !== _arg_1)
            {
                this._1420684256btnUpgrade = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnUpgrade", _local_2, _arg_1));
            };
        }

        public function set marketVs(_arg_1:Market):void
        {
            var _local_2:Object = this._246972441marketVs;
            if (_local_2 !== _arg_1)
            {
                this._246972441marketVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "marketVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
        }

        private function onUpgradeClick():void
        {
            var _local_2:BuildingBean;
            var _local_3:int;
            var _local_4:int;
            var _local_1:int;
            for each (_local_2 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_2.status != BuildingConstants.STATUS_NORMAL)
                {
                    _local_1++;
                };
            };
            _local_3 = Context.getInstance().getCurCastle().id;
            _local_4 = this.bean.positionId;
            Context.getInstance().positionId = _local_4;
            if (((_local_4 == BuildingConstants.POSITION_TOWN_HALL) && (this.bean.level == 4)))
            {
                if (UIUtil.checkOffice())
                {
                    ActionFactory.getInstance().getCastleCommands().upgradeBuilding(Context.getInstance().getCurCastle().id, this.bean.positionId, onBuildCommand);
                }
                else
                {
                    AlertWin.show(Lang.msg("大于五级的提示"), upgrade);
                };
            }
            else
            {
                if (this.bean.level == 9)
                {
                    AlertWin.show(Lang.msg("消耗建筑图纸的提示"), upgrade);
                }
                else
                {
                    ActionFactory.getInstance().getCastleCommands().upgradeBuilding(_local_3, _local_4, onBuildCommand);
                };
            };
            if (Context.getInstance().isBuildHelp)
            {
                Context.getInstance().isSpeedType = 0;
                Context.getInstance().buidwithhelpName = this.buildingName;
                Context.getInstance().buidwithhelpLevel = String((this.bean.level + 1));
            };
        }

        public function set lvl(_arg_1:Label):void
        {
            var _local_2:Object = this._107554lvl;
            if (_local_2 !== _arg_1)
            {
                this._107554lvl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lvl", _local_2, _arg_1));
            };
        }

        private function onClickBuildingQueue():void
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

        public function set wallVs(_arg_1:Wall):void
        {
            var _local_2:Object = this._795192793wallVs;
            if (_local_2 !== _arg_1)
            {
                this._795192793wallVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wallVs", _local_2, _arg_1));
            };
        }

        private function onBuildingUpdate(_arg_1:BuildingChangeEvent):void
        {
            if (((!(this.bean == null)) && (bean.positionId == _arg_1.getBean().positionId)))
            {
                this.bean = _arg_1.getBean();
                refreshBuildingInfo();
            };
        }

        public function ___BuildingInfoWin_Text1_mouseMove(_arg_1:MouseEvent):void
        {
            onBuildingDescTxtMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get btnUpgradeVisible():Boolean
        {
            return (this._1730121778btnUpgradeVisible);
        }

        private function onAdded(_arg_1:Event):void
        {
            trace("added");
        }

        private function onSpeedUp():void
        {
            var _local_1:int;
            if (bean.positionId == 32)
            {
                bean.positionId = -1;
            };
            if (this.bean.status != BuildingConstants.STATUS_DESTRUCTING)
            {
                if (!SpeedUpCheckOut.checkOutBuilding(this.bean))
                {
                    isLowFiveMimutes = true;
                    _local_1 = Context.getInstance().getCurCastle().id;
                    ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_local_1, bean.positionId, CommonConstants.FREE_SPEED_ITEM_ID, onBuildCommand);
                }
                else
                {
                    SpeedupItemSelector.getInstance().bean = this.bean;
                    SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_BUILD_SPEED;
                    SpeedupItemSelector.show(ItemManager.speedItemArray, onSpeedUpItemSelected);
                };
            }
            else
            {
                SpeedupItemSelector.getInstance().bean = this.bean;
                SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_BUILD_SPEED;
                SpeedupItemSelector.show(ItemManager.speedItemArray, onSpeedUpItemSelected);
            };
            if (Context.getInstance().isBuildHelp)
            {
                Context.getInstance().isSpeedType = 0;
                Context.getInstance().buidwithhelpName = this.buildingName;
                Context.getInstance().buidwithhelpLevel = String((this.bean.level + 1));
            };
            this.structingVs.enabled = false;
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.onChagePage(1);
        }

        private function onCancelBuildingQueueResponse(_arg_1:CommandResponse):*
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set buildingLevel(_arg_1:String):void
        {
            var _local_2:Object = this._397924048buildingLevel;
            if (_local_2 !== _arg_1)
            {
                this._397924048buildingLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingLevel", _local_2, _arg_1));
            };
        }

        public function set swapContainer(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1647079470swapContainer;
            if (_local_2 !== _arg_1)
            {
                this._1647079470swapContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "swapContainer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnCancelSpeedUp():Button
        {
            return (this._626460780btnCancelSpeedUp);
        }

        public function set embassyVs(_arg_1:Embassy):void
        {
            var _local_2:Object = this._1508683729embassyVs;
            if (_local_2 !== _arg_1)
            {
                this._1508683729embassyVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "embassyVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get herosMansionVs():HerosMansion
        {
            return (this._253516403herosMansionVs);
        }

        private function onBuildCommand(_arg_1:CommandResponse):void
        {
            var _local_2:Object;
            trace((this.className + ".onBuildCommand."));
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
                }
                else
                {
                    if (((isLowFiveMimutes) && (Context.getInstance().needUserGuide == false)))
                    {
                        isLowFiveMimutes = false;
                        AlertWin.show(Lang.msg("生产时间低于5分钟免费加速"));
                    };
                };
            };
            if (this.bean.status != BuildingConstants.STATUS_NORMAL)
            {
                this.structingVs.enabled = true;
                if (((Context.getInstance().facebookUser) && (startUpgradewithhelp)))
                {
                    _local_2 = FbData.getInstance().getValue(20045);
                    if (_local_2 != null)
                    {
                        RandomEventWin.show(11);
                    };
                };
            };
        }

        public function set toRightBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1456175557toRightBtn;
            if (_local_2 !== _arg_1)
            {
                this._1456175557toRightBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toRightBtn", _local_2, _arg_1));
            };
        }

        private function set btnUpgradeVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1730121778btnUpgradeVisible;
            if (_local_2 !== _arg_1)
            {
                this._1730121778btnUpgradeVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnUpgradeVisible", _local_2, _arg_1));
            };
        }

        public function __btnUpgrade_click(_arg_1:MouseEvent):void
        {
            onUpgradeClick();
        }

        public function set btnSpeedUp(_arg_1:Button):void
        {
            var _local_2:Object = this._1097043782btnSpeedUp;
            if (_local_2 !== _arg_1)
            {
                this._1097043782btnSpeedUp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnSpeedUp", _local_2, _arg_1));
            };
        }

        public function ___BuildingInfoWin_BaseWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        public function __btnUpgrade_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get officeVs():Office
        {
            return (this._765293927officeVs);
        }

        [Bindable(event="propertyChange")]
        public function get workshopVs():Workshop
        {
            return (this._8091300workshopVs);
        }

        [Bindable(event="propertyChange")]
        private function get decconditionBean():ConditionBean
        {
            return (this._991395497decconditionBean);
        }

        private function onPicMouseOut():void
        {
            DescribeTooltip.hide();
        }

        private function checkQueueBuilding(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this.onBuildingQueue();
            };
        }

        private function _BuildingInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.buildingName;
            _local_1 = this.buildingLevel;
            _local_1 = this.buildingDesc;
            _local_1 = this.bean.endTime;
            _local_1 = (Lang.msg("时间剩余") + ":  ");
            _local_1 = (this.bean.endTime > 0);
            _local_1 = this.bean.endTime;
            _local_1 = this.btnDestructVisible;
            _local_1 = Lang.msg("升级");
            _local_1 = ((Context.getInstance().isBuildHelp) ? 30 : 40);
            _local_1 = this.btnUpgradeEnable;
            _local_1 = this.btnUpgradeVisible;
            _local_1 = ((Context.getInstance().isBuildHelp) ? 46 : 6);
            _local_1 = this.btnUpgradeEnable;
            _local_1 = ((this.btnUpgradeVisible) && (Context.getInstance().isBuildHelp));
            _local_1 = Lang.msg("加速");
            _local_1 = (!(bean.status == BuildingConstants.STATUS_WAITING));
            _local_1 = Lang.msg("建造排队");
            _local_1 = GameConfig.instance.enableBuildingQueue;
            _local_1 = Lang.msg("撤销");
            _local_1 = ((this.currentPage + "/") + this.totalPage);
            _local_1 = (GuideStep.getInstance().currentStep == 401);
            _local_1 = (GuideStep.getInstance().currentStep == 401);
        }

        private function set buildingName(_arg_1:String):void
        {
            var _local_2:Object = this._982612129buildingName;
            if (_local_2 !== _arg_1)
            {
                this._982612129buildingName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingName", _local_2, _arg_1));
            };
        }

        private function onBuildingDestroy(_arg_1:BuildingChangeEvent):void
        {
            if (((!(this.bean == null)) && (bean.positionId == _arg_1.getBean().positionId)))
            {
                this.onClose();
            };
        }

        private function getBuildingMaxLevel():int
        {
            var _local_2:int;
            var _local_1:int = BuildingConstants.MAX_LEVEL;
            if (((bean.typeId >= 4) && (bean.typeId <= 7)))
            {
                _local_2 = Context.getInstance().getCurCastle().powerlevel;
                if (_local_2 == 0)
                {
                    _local_1 = 18;
                }
                else
                {
                    if (_local_2 == 1)
                    {
                        _local_1 = 16;
                    }
                    else
                    {
                        if (_local_2 == 2)
                        {
                            _local_1 = 14;
                        }
                        else
                        {
                            if (_local_2 == 3)
                            {
                                _local_1 = 12;
                            };
                        };
                    };
                };
            };
            return (_local_1);
        }

        public function ___BuildingInfoWin_BaseWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function __img_buildingLogo_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        public function set commandVs(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1498725528commandVs;
            if (_local_2 !== _arg_1)
            {
                this._1498725528commandVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commandVs", _local_2, _arg_1));
            };
        }

        private function onSpeedUpItemSelected(_arg_1:ItemEum=null):void
        {
            var _local_2:int;
            if (bean.positionId == 32)
            {
                bean.positionId = -1;
            };
            if (_arg_1 != null)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getCastleCommands().speedUpBuildCommand(_local_2, bean.positionId, _arg_1.id, onBuildCommand);
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

        [Bindable(event="propertyChange")]
        public function get btnQueueUpgrade2():Button
        {
            return (this._1437953227btnQueueUpgrade2);
        }

        public function __btnDesctruct_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        public function set btnCancelSpeedUp(_arg_1:Button):void
        {
            var _local_2:Object = this._626460780btnCancelSpeedUp;
            if (_local_2 !== _arg_1)
            {
                this._626460780btnCancelSpeedUp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnCancelSpeedUp", _local_2, _arg_1));
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

        override public function refresh():void
        {
            this.startUpgradewithhelp = false;
            var _local_1:ClickBuildDate = (this.eventData as ClickBuildDate);
            if (buildingStatusWatcher != null)
            {
                buildingStatusWatcher.unwatch();
            };
            this.bean = _local_1.buildingBean;
            if (Context.getInstance().needUserGuide)
            {
                checkGuideText();
            };
            buildingStatusWatcher = BindingUtils.bindProperty(this, "onBuildingStatusChange", bean, "status");
            this.buildingWinId = _local_1.buildingWinId;
            if (this.bean.typeId == BuildingConstants.TYPE_BARRACK)
            {
                if (this.bean.level == 0)
                {
                    this.swapContainer.visible = false;
                }
                else
                {
                    this.swapContainer.visible = true;
                    countAllBarrack();
                };
            }
            else
            {
                this.swapContainer.visible = false;
            };
            this.img_buildingLogo.source = buildingLogoMovieClip.GetImg(this.bean);
            if ((((this.bean.level == 1) && (this.bean.status == BuildingConstants.STATUS_WAITING)) && (Context.getInstance().getBuildingObjByPosision(this.bean.positionId) == null)))
            {
                currentBuildingWin = null;
            }
            else
            {
                currentBuildingWin = this.winMap[this.buildingWinId];
            };
            if (this.buildingWinId == Barrack.EVENT_SHOW)
            {
                this.barrackWin = currentBuildingWin;
            };
            if (((((this.buildingWinId == Office.EVENT_SHOW) && (Context.getInstance().needUserGuide)) && (!(MainWin.instance == null))) && (MainWin.instance.height < 800)))
            {
                MainWin.instance.guidLadyBottom = 0;
                if (Context.getInstance().iPicId == 3)
                {
                    MainWin.instance.saveBtnBottom = 0xFF;
                    MainWin.instance.skipBtnBottom = 250;
                };
            };
            if (((!(currentBuildingWin == null)) && (bean.level > 0)))
            {
                if (((!(this.viewstack2.selectedChild == this.currentBuildingWin)) && (this.viewstack2.selectedChild is BaseBuildingWindow)))
                {
                    (this.viewstack2.selectedChild as BaseBuildingWindow).destroy();
                };
                this.viewstack2.selectedChild = currentBuildingWin;
                this.viewstack2.visible = true;
                currentBuildingWin.onShowEvent(this.bean);
                this.height = 555;
            }
            else
            {
                this.viewstack2.visible = false;
                this.height = 218;
            };
            this.buildingName = BuildingEumDefine.getName(bean.typeId);
            if (((BuildingEumDefine.getDesc(bean.typeId).split(" ").length > 60) && (!(InputTextFilter.isChinese(BuildingEumDefine.getDesc(bean.typeId))))))
            {
                this.buildingDesc = BuildingEumDefine.getDesc(bean.typeId);
                isBuildingDesctShowAll = true;
            }
            else
            {
                this.buildingDesc = BuildingEumDefine.getDesc(bean.typeId);
                isBuildingDesctShowAll = false;
            };
            if (((bean.typeId == BuildingConstants.TYPE_TOWN_HALL) || (bean.typeId == BuildingConstants.TYPE_WALL)))
            {
                this.btnDestructVisible = false;
            }
            else
            {
                this.btnDestructVisible = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function get warehouseVs():WareHouse
        {
            return (this._168534240warehouseVs);
        }

        public function set herosMansionVs(_arg_1:HerosMansion):void
        {
            var _local_2:Object = this._253516403herosMansionVs;
            if (_local_2 !== _arg_1)
            {
                this._253516403herosMansionVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "herosMansionVs", _local_2, _arg_1));
            };
        }

        private function onConditionTime(_arg_1:TimerEvent):void
        {
            var _local_2:Boolean = UIUtil.isConditionMatch(this.conditionBean);
            var _local_3:Boolean = UIUtil.isResourceConditionMatch(this.conditionBean);
            if (_local_3)
            {
                this.conditionTimer.stop();
            };
            if (((_local_2) && (_local_3)))
            {
                this.btnUpgradeEnable = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function get technologyVs():Technology
        {
            return (this._1075477737technologyVs);
        }

        public function __btnQueueUpgrade2_click(_arg_1:MouseEvent):void
        {
            onClickBuildingQueue();
        }

        private function onBuildingDescTxtMove(_arg_1:MouseEvent):void
        {
            BuildingDescribeTooltip.move2Mouse(_arg_1);
        }

        public function set btnDesctruct(_arg_1:Button):void
        {
            var _local_2:Object = this._841595259btnDesctruct;
            if (_local_2 !== _arg_1)
            {
                this._841595259btnDesctruct = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnDesctruct", _local_2, _arg_1));
            };
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (((!(tt == null)) && (bean.level < BuildingConstants.MAX_LEVEL)))
            {
                tt.moveToMouse(_arg_1);
            };
        }

        private function countAllBarrack():void
        {
            this.barrackAry.splice(0);
            this.totalPage = 0;
            this.barrackAry.push(this.bean);
            var _local_1:ArrayCollection = Context.getInstance().getCurCastle().buildingsArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (((_local_1.getItemAt(_local_2).typeId == BuildingConstants.TYPE_BARRACK) && (!(_local_1.getItemAt(_local_2).positionId == this.bean.positionId))))
                {
                    this.barrackAry.push(_local_1.getItemAt(_local_2));
                };
                _local_2++;
            };
            this.currentPage = 1;
            this.totalPage = this.barrackAry.length;
        }

        [Bindable(event="propertyChange")]
        public function get trainningFieldVs():TrainningField
        {
            return (this._835593477trainningFieldVs);
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

        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.onChagePage(-1);
        }

        private function onBuildingDescTxtRollOut():void
        {
            BuildingDescribeTooltip.hide();
        }

        private function init():void
        {
            instance = this;
            trace((this.className + ".init()"));
            winMap[Office.EVENT_SHOW] = this.officeVs;
            winMap[Wall.EVENT_SHOW] = this.wallVs;
            winMap[Barrack.EVENT_SHOW] = this.barrackVs;
            winMap[Embassy.EVENT_SHOW] = this.embassyVs;
            winMap[Tavern.EVENT_SHOW] = this.tavernVs;
            winMap[Technology.EVENT_SHOW] = this.technologyVs;
            winMap[TrainningField.EVENT_SHOW] = this.trainningFieldVs;
            winMap[HerosMansion.EVENT_SHOW] = this.herosMansionVs;
            winMap[WareHouse.EVENT_SHOW] = this.warehouseVs;
            winMap[Workshop.EVENT_SHOW] = this.workshopVs;
            winMap[Market.EVENT_SHOW] = this.marketVs;
            MsgDispacther.getInstance().addEventListener(TownView.EVENT_BUILDING_DESTROY, onBuildingDestroy);
            MsgDispacther.getInstance().addEventListener(CityView.EVENT_BUILDING_DESTROY, onBuildingDestroy);
            MsgDispacther.getInstance().addEventListener(CityView.EVENT_BUILDING_UPDATE, onBuildingUpdate);
            MsgDispacther.getInstance().addEventListener(TownView.EVENT_BUILDING_UPDATE, onBuildingUpdate);
            this.conditionTimer.addEventListener(TimerEvent.TIMER, onConditionTime);
            this.technologyVs.createComponentsFromDescriptors();
            this.workshopVs.createComponentsFromDescriptors();
        }

        private function onChagePage(_arg_1:int):void
        {
            var _local_2:int = (this.currentPage + _arg_1);
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.currentPage = _local_2;
                this.bean = this.barrackAry[(_local_2 - 1)];
                this.barrackWin.onShowEvent(this.barrackAry[(_local_2 - 1)]);
                if (buildingStatusWatcher != null)
                {
                    buildingStatusWatcher.unwatch();
                };
                buildingStatusWatcher = BindingUtils.bindProperty(this, "onBuildingStatusChange", bean, "status");
            };
        }

        private function onDesctructClick():void
        {
            DestrctChoiceWin.show(this.bean);
            Context.getInstance().iDemolishedPosId = this.bean.positionId;
        }

        public function set structingVs(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1432142730structingVs;
            if (_local_2 !== _arg_1)
            {
                this._1432142730structingVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "structingVs", _local_2, _arg_1));
            };
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        private function onBuildingQueue():void
        {
            var _local_1:int = Context.getInstance().getBuildingQueueMaxLevel(this.bean.positionId);
            if (_local_1 < 0)
            {
                if (this.bean.status == BuildingConstants.STATUS_NORMAL)
                {
                    _local_1 = (this.bean.level + 1);
                }
                else
                {
                    if (this.bean.status == BuildingConstants.STATUS_UPGRADING)
                    {
                        _local_1 = (this.bean.level + 2);
                    };
                };
            }
            else
            {
                _local_1 = (_local_1 + 1);
            };
            if (_local_1 > this.getBuildingMaxLevel())
            {
                AlertWin.show(Lang.msg("无法继续排队"));
                return;
            };
            ActionFactory.getInstance().getCastleCommands().newBuildingQueue(Context.getInstance().getCurCastle().id, this.bean.typeId, _local_1, this.bean.positionId, onNewBuildingQueueResponse);
        }

        public function set viewstack2(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505329viewstack2;
            if (_local_2 !== _arg_1)
            {
                this._946505329viewstack2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack2", _local_2, _arg_1));
            };
        }

        public function set onBuildingStatusChange(_arg_1:int):void
        {
            trace(((((this.className + ".onBuildingStatusChange() event.status=") + _arg_1) + " windowId=") + this.buildingWinId));
            this.refreshBuildingInfo();
        }

        private function onPicMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        public function __btnSpeedUp_click(_arg_1:MouseEvent):void
        {
            onSpeedUp();
        }

        [Bindable(event="propertyChange")]
        private function get buildingLevel():String
        {
            return (this._397924048buildingLevel);
        }

        public function set officeVs(_arg_1:Office):void
        {
            var _local_2:Object = this._765293927officeVs;
            if (_local_2 !== _arg_1)
            {
                this._765293927officeVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officeVs", _local_2, _arg_1));
            };
        }

        public function __img_buildingLogo_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        public function __btnDesctruct_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get btnSpeedUp():Button
        {
            return (this._1097043782btnSpeedUp);
        }

        private function onCancleOk(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:BuildingQueueBean;
            trace((((this.className + ".onCancleOk(") + _arg_1) + ")"));
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                for each (_local_3 in Context.getInstance().getCurCastle().buildingQueuesArray)
                {
                    if (_local_3.positionId == this.bean.positionId)
                    {
                        ActionFactory.getInstance().getCastleCommands().cancelBuildingQueue(_local_2, _local_3.id, onBuildCommand);
                    };
                };
                if (this.bean.status != BuildingConstants.STATUS_WAITING)
                {
                    ActionFactory.getInstance().getCastleCommands().cancleBuildCommand(_local_2, bean.positionId, onBuildCommand);
                };
            };
        }

        public function set workshopVs(_arg_1:Workshop):void
        {
            var _local_2:Object = this._8091300workshopVs;
            if (_local_2 !== _arg_1)
            {
                this._8091300workshopVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "workshopVs", _local_2, _arg_1));
            };
        }

        private function set currentPage(_arg_1:int):void
        {
            var _local_2:Object = this._601108392currentPage;
            if (_local_2 !== _arg_1)
            {
                this._601108392currentPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentPage", _local_2, _arg_1));
            };
        }

        private function onClose():void
        {
            if (this.buildingWinId == Wall.EVENT_SHOW)
            {
                wallVs.removeListener();
            };
            if (this.buildingWinId == Barrack.EVENT_SHOW)
            {
            };
            AllWindows.closeAll();
        }

        public function ___BuildingInfoWin_Text1_mouseOver(_arg_1:MouseEvent):void
        {
            onBuildingDescTxtRollOver(_arg_1);
        }

        private function onDesctructOk(_arg_1:Boolean):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                _local_3 = this.bean.positionId;
                ActionFactory.getInstance().getCastleCommands().destructBuilding(_local_2, _local_3, onBuildCommand);
            };
        }

        private function onNewBuildingQueueResponse(_arg_1:CommandResponse):void
        {
            var _local_2:BuildingBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            }
            else
            {
                if (this.bean.status == BuildingConstants.STATUS_NORMAL)
                {
                    _local_2 = new BuildingBean();
                    this.bean.copyTo(_local_2);
                    _local_2.status = BuildingConstants.STATUS_WAITING;
                    this.bean = _local_2;
                    refreshBuildingInfo();
                };
                this.structingVs.enabled = true;
            };
        }

        private function set bean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        private function set decconditionBean(_arg_1:ConditionBean):void
        {
            var _local_2:Object = this._991395497decconditionBean;
            if (_local_2 !== _arg_1)
            {
                this._991395497decconditionBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "decconditionBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get buildingDesc():String
        {
            return (this._982906011buildingDesc);
        }

        [Bindable(event="propertyChange")]
        private function get buildingName():String
        {
            return (this._982612129buildingName);
        }

        public function ___BuildingInfoWin_Button4_click(_arg_1:MouseEvent):void
        {
            onBuildWithHelp();
        }

        private function onMouseOut():void
        {
            if (tt != null)
            {
                tt.destroy();
            };
        }

        [Bindable(event="propertyChange")]
        public function get commandVs():Canvas
        {
            return (this._1498725528commandVs);
        }

        public function setStructingVsTrue():void
        {
            if (!structingVs.enabled)
            {
                structingVs.enabled = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnDesctruct():Button
        {
            return (this._841595259btnDesctruct);
        }

        [Bindable(event="propertyChange")]
        public function get img_buildingLogo():Image
        {
            return (this._276194949img_buildingLogo);
        }

        public function set barrackVs(_arg_1:Barrack):void
        {
            var _local_2:Object = this._1964563911barrackVs;
            if (_local_2 !== _arg_1)
            {
                this._1964563911barrackVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "barrackVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewstack2():ViewStack
        {
            return (this._946505329viewstack2);
        }

        [Bindable(event="propertyChange")]
        public function get structingVs():Canvas
        {
            return (this._1432142730structingVs);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        override public function initialize():void
        {
            var target:BuildingInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BuildingInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_BuildingInfoWinWatcherSetupUtil");
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

        public function __btnUpgrade_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        private function set buildingStatus(_arg_1:String):void
        {
            var _local_2:Object = this._762902470buildingStatus;
            if (_local_2 !== _arg_1)
            {
                this._762902470buildingStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingStatus", _local_2, _arg_1));
            };
        }

        public function __img_buildingLogo_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function set btnUpgradeEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2067041731btnUpgradeEnable;
            if (_local_2 !== _arg_1)
            {
                this._2067041731btnUpgradeEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnUpgradeEnable", _local_2, _arg_1));
            };
        }

        public function ___BuildingInfoWin_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        private function get currentPage():int
        {
            return (this._601108392currentPage);
        }

        public function __btnDesctruct_click(_arg_1:MouseEvent):void
        {
            onDesctructClick();
        }

        public function set btnQueueUpgrade2(_arg_1:Button):void
        {
            var _local_2:Object = this._1437953227btnQueueUpgrade2;
            if (_local_2 !== _arg_1)
            {
                this._1437953227btnQueueUpgrade2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnQueueUpgrade2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get bean():BuildingBean
        {
            return (this._3019696bean);
        }

        public function set toLeftBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1607799334toLeftBtn;
            if (_local_2 !== _arg_1)
            {
                this._1607799334toLeftBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toLeftBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get barrackVs():Barrack
        {
            return (this._1964563911barrackVs);
        }

        [Bindable(event="propertyChange")]
        private function get btnUpgradeEnable():Boolean
        {
            return (this._2067041731btnUpgradeEnable);
        }

        [Bindable(event="propertyChange")]
        private function get buildingStatus():String
        {
            return (this._762902470buildingStatus);
        }

        public function set technologyVs(_arg_1:Technology):void
        {
            var _local_2:Object = this._1075477737technologyVs;
            if (_local_2 !== _arg_1)
            {
                this._1075477737technologyVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "technologyVs", _local_2, _arg_1));
            };
        }

        public function __btnCancelSpeedUp_click(_arg_1:MouseEvent):void
        {
            onCancle();
        }

        public function __btnUpgrade_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function set tavernVs(_arg_1:Tavern):void
        {
            var _local_2:Object = this._328900107tavernVs;
            if (_local_2 !== _arg_1)
            {
                this._328900107tavernVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tavernVs", _local_2, _arg_1));
            };
        }

        private function _BuildingInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingInfoWin_Label1.text = _arg_1;
            }, "_BuildingInfoWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lvl.text = _arg_1;
            }, "lvl.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingInfoWin_Text1.htmlText = _arg_1;
            }, "_BuildingInfoWin_Text1.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.bean.endTime);
            }, function (_arg_1:Number):void
            {
                _BuildingInfoWin_BuildingInfoTimeLabel1.time = _arg_1;
            }, "_BuildingInfoWin_BuildingInfoTimeLabel1.time");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("时间剩余") + ":  ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingInfoWin_Label3.text = _arg_1;
            }, "_BuildingInfoWin_Label3.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bean.endTime > 0);
            }, function (_arg_1:Boolean):void
            {
                _BuildingInfoWin_Label3.visible = _arg_1;
            }, "_BuildingInfoWin_Label3.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.bean.endTime);
            }, function (_arg_1:Number):void
            {
                _BuildingInfoWin_BuildingInfoRemainTimeLabel1.remainTime = _arg_1;
            }, "_BuildingInfoWin_BuildingInfoRemainTimeLabel1.remainTime");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnDestructVisible);
            }, function (_arg_1:Boolean):void
            {
                btnDesctruct.visible = _arg_1;
            }, "btnDesctruct.visible");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("升级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnUpgrade.label = _arg_1;
            }, "btnUpgrade.label");
            result[8] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((Context.getInstance().isBuildHelp) ? 30 : 40);
            }, function (_arg_1:Number):void
            {
                btnUpgrade.height = _arg_1;
            }, "btnUpgrade.height");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnUpgradeEnable);
            }, function (_arg_1:Boolean):void
            {
                btnUpgrade.enabled = _arg_1;
            }, "btnUpgrade.enabled");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnUpgradeVisible);
            }, function (_arg_1:Boolean):void
            {
                btnUpgrade.visible = _arg_1;
            }, "btnUpgrade.visible");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Context.getInstance().isBuildHelp) ? 46 : 6);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnUpgrade.setStyle("top", _arg_1);
            }, "btnUpgrade.top");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnUpgradeEnable);
            }, function (_arg_1:Boolean):void
            {
                _BuildingInfoWin_Button4.enabled = _arg_1;
            }, "_BuildingInfoWin_Button4.enabled");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.btnUpgradeVisible) && (Context.getInstance().isBuildHelp));
            }, function (_arg_1:Boolean):void
            {
                _BuildingInfoWin_Button4.visible = _arg_1;
            }, "_BuildingInfoWin_Button4.visible");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("加速");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnSpeedUp.label = _arg_1;
            }, "btnSpeedUp.label");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(bean.status == BuildingConstants.STATUS_WAITING));
            }, function (_arg_1:Boolean):void
            {
                btnSpeedUp.enabled = _arg_1;
            }, "btnSpeedUp.enabled");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造排队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnQueueUpgrade2.label = _arg_1;
            }, "btnQueueUpgrade2.label");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GameConfig.instance.enableBuildingQueue);
            }, function (_arg_1:Boolean):void
            {
                btnQueueUpgrade2.visible = _arg_1;
            }, "btnQueueUpgrade2.visible");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("撤销");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                btnCancelSpeedUp.label = _arg_1;
            }, "btnCancelSpeedUp.label");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.currentPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BuildingInfoWin_Label4.text = _arg_1;
            }, "_BuildingInfoWin_Label4.text");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 401);
            }, function (_arg_1:Boolean):void
            {
                _BuildingInfoWin_GuideArrow1.includeInLayout = _arg_1;
            }, "_BuildingInfoWin_GuideArrow1.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 401);
            }, function (_arg_1:Boolean):void
            {
                _BuildingInfoWin_GuideArrow1.visible = _arg_1;
            }, "_BuildingInfoWin_GuideArrow1.visible");
            result[22] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get tavernVs():Tavern
        {
            return (this._328900107tavernVs);
        }

        public function set warehouseVs(_arg_1:WareHouse):void
        {
            var _local_2:Object = this._168534240warehouseVs;
            if (_local_2 !== _arg_1)
            {
                this._168534240warehouseVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warehouseVs", _local_2, _arg_1));
            };
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            tt = UIFactory.getInstance().getConditionTooltip();
            tt.moveToMouse(_arg_1);
            if (!tt.isPopUp)
            {
                PopUpManager.addPopUp(tt, this);
            }
            else
            {
                PopUpManager.bringToFront(tt);
            };
            if (_arg_1.target == this.btnDesctruct)
            {
                tt.setBeanRecover(this.decconditionBean);
                tt.setBuildingType(Lang.msg("拆除"), this.bean.typeId, (bean.level - 1));
                tt.setBuildingDoType("desctructBuilding", this.conditionBean.destructTime);
            }
            else
            {
                if (_arg_1.target == this.btnUpgrade)
                {
                    _local_2 = BuildingConstants.MAX_LEVEL;
                    if (((bean.typeId >= 4) && (bean.typeId <= 7)))
                    {
                        _local_3 = Context.getInstance().getCurCastle().powerlevel;
                        if (_local_3 == 0)
                        {
                            _local_2 = 18;
                        }
                        else
                        {
                            if (_local_3 == 1)
                            {
                                _local_2 = 16;
                            }
                            else
                            {
                                if (_local_3 == 2)
                                {
                                    _local_2 = 14;
                                }
                                else
                                {
                                    if (_local_3 == 3)
                                    {
                                        _local_2 = 12;
                                    };
                                };
                            };
                        };
                    };
                    if (((this.conditionBean == null) || (bean.level >= _local_2)))
                    {
                        return;
                    };
                    tt.setBuildingType(Lang.msg("升级"), this.bean.typeId, bean.level);
                    tt.setBean(this.conditionBean);
                };
            };
        }

        private function onBuildingDescTxtRollOver(_arg_1:MouseEvent):void
        {
            if (isBuildingDesctShowAll)
            {
                BuildingDescribeTooltip.show(BuildingEumDefine.getName(bean.typeId), BuildingEumDefine.getDesc(bean.typeId), _arg_1);
            };
        }


    }
}//package view.castle

