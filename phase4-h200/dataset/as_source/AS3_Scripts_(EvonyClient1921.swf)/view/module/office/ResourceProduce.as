// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.ResourceProduce

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.CastleBean;
    import view.module.office.production.ResourceProduction;
    import mx.controls.Button;
    import com.evony.client.response.ResponseDispatcher;
    import view.module.guide.GuideArrow;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import com.evony.common.beans.ResourceProduceDataBean;
    import view.module.guide.GuideStep;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.common.module.interior.ResourceProduceDataResponse;
    import flash.external.ExternalInterface;
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

    public class ResourceProduce extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ResourceProduce_Label2:Label;
        public var _ResourceProduce_Label3:Label;
        public var _ResourceProduce_Label4:Label;
        public var _ResourceProduce_Label5:Label;
        public var _ResourceProduce_Label6:Label;
        public var _ResourceProduce_Label7:Label;
        public var _ResourceProduce_Label9:Label;
        public var _ResourceProduce_Label8:Label;
        private var _191627976availableLabour:Label;
        private var woodPercentage:int;
        private var _106847765commenceDemandsNum:int;
        private var _782085250worker:int;
        public var _ResourceProduce_Label10:Label;
        public var _ResourceProduce_Label11:Label;
        public var _ResourceProduce_Label12:Label;
        public var _ResourceProduce_Label13:Label;
        public var _ResourceProduce_Label14:Label;
        public var _ResourceProduce_Label15:Label;
        public var _ResourceProduce_Label16:Label;
        public var _ResourceProduce_Label18:Label;
        private var _691506344curCastle:CastleBean;
        private var _166389665ironProduction:ResourceProduction;
        private var _1368195070productionEfficiency:Number;
        public var _ResourceProduce_Label20:Label;
        public var _ResourceProduce_Label22:Label;
        private var _942048329foodProduction:ResourceProduction;
        private var _1900602558modifyBtn:Button;
        private var _1938825865ironPeople:int;
        private var _1187274174productionEfficiencyHandleYet:Number;
        private var ironPercentage:int;
        private var instance:ResponseDispatcher;
        public var _ResourceProduce_GuideArrow1:GuideArrow;
        public var _ResourceProduce_GuideArrow2:GuideArrow;
        private var _1735557277maxLabourNum:int;
        private var foodPercentage:int;
        private var _1315008826allProduction:ResourceProduction;
        private var _447246236woodPeople:int;
        private var _1261923249commenceDemands:Label;
        private var _946610362woodProduction:ResourceProduction;
        private var _795443933maxLabour:Label;
        private var _623242498productionEffeciency:Label;
        private var stonePercentage:int;
        private var _213797630stoneProduction:ResourceProduction;
        private var _506991475foodPeople:int;
        private var _309495980stonePeople:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"modifyBtn",
                        "events":{"click":"__modifyBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.bottom = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b95"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "40";
                            this.top = "0";
                            this.right = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"newBackGroundWithBode",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.bottom = "0";
                                        this.top = "0";
                                        this.right = "16";
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "1";
                                                                this.right = "1";
                                                                this.top = "1";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":27,
                                                                    "styleName":"textBackGroundFillColor",
                                                                    "verticalScrollPolicy":"off",
                                                                    "horizontalScrollPolicy":"off",
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "styleName":"focusColor",
                                                                                "text":"  "
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent1",
                                                                    "height":22
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent1",
                                                                    "height":22
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent1",
                                                                    "height":22
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label14",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "styleName":"tableContent1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ResourceProduce_Label15",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"tableContent1",
                                                                    "height":22
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tooltipsRrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceProduction,
                                                "id":"foodProduction",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tooltipsRrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceProduction,
                                                "id":"woodProduction",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tooltipsRrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceProduction,
                                                "id":"stoneProduction",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tooltipsRrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceProduction,
                                                "id":"ironProduction",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tooltipsRrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceProduction,
                                                "id":"allProduction",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "verticalScrollPolicy":"off",
                                                        "horizontalScrollPolicy":"off"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "width":620,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "left";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ResourceProduce_Label16",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"availableLabour",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tableContent3"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ResourceProduce_Label18",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"maxLabour",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tableContent3"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ResourceProduce_Label20",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"commenceDemands",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tableContent3"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ResourceProduce_Label22",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"productionEffeciency",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"tableContent3"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_ResourceProduce_GuideArrow1",
                        "stylesFactory":function ():void
                        {
                            this.top = "124";
                            this.right = "77";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"tabGuide100"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"_ResourceProduce_GuideArrow2",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "21";
                            this.right = "110";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowRGuide"});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ResourceProduce()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ResourceProduce._watcherSetupUtil = _arg_1;
        }


        public function set stoneProduction(_arg_1:ResourceProduction):void
        {
            var _local_2:Object = this._213797630stoneProduction;
            if (_local_2 !== _arg_1)
            {
                this._213797630stoneProduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneProduction", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get productionEfficiency():Number
        {
            return (this._1368195070productionEfficiency);
        }

        public function init():void
        {
            maxLabourNum = 0;
            this.curCastle = Context.getInstance().getCurCastle();
            this.worker = (this.curCastle.resource.curPopulation - this.curCastle.resource.buildPeople);
            ActionFactory.getInstance().getInteriorCommands().getResourceProduceData(this.curCastle.id, getResourceResponse);
            allProduction.lookLabelOnOff = "OFF";
        }

        private function set productionEfficiency(_arg_1:Number):void
        {
            var _local_2:Object = this._1368195070productionEfficiency;
            if (_local_2 !== _arg_1)
            {
                this._1368195070productionEfficiency = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionEfficiency", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get commenceDemandsNum():int
        {
            return (this._106847765commenceDemandsNum);
        }

        [Bindable(event="propertyChange")]
        public function get maxLabour():Label
        {
            return (this._795443933maxLabour);
        }

        private function set worker(_arg_1:int):void
        {
            var _local_2:Object = this._782085250worker;
            if (_local_2 !== _arg_1)
            {
                this._782085250worker = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "worker", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get productionEffeciency():Label
        {
            return (this._623242498productionEffeciency);
        }

        private function set commenceDemandsNum(_arg_1:int):void
        {
            var _local_2:Object = this._106847765commenceDemandsNum;
            if (_local_2 !== _arg_1)
            {
                this._106847765commenceDemandsNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceDemandsNum", _local_2, _arg_1));
            };
        }

        private function set woodPeople(_arg_1:int):void
        {
            var _local_2:Object = this._447246236woodPeople;
            if (_local_2 !== _arg_1)
            {
                this._447246236woodPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodPeople", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allProduction():ResourceProduction
        {
            return (this._1315008826allProduction);
        }

        private function set foodPeople(_arg_1:int):void
        {
            var _local_2:Object = this._506991475foodPeople;
            if (_local_2 !== _arg_1)
            {
                this._506991475foodPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodPeople", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stoneProduction():ResourceProduction
        {
            return (this._213797630stoneProduction);
        }

        public function set maxLabour(_arg_1:Label):void
        {
            var _local_2:Object = this._795443933maxLabour;
            if (_local_2 !== _arg_1)
            {
                this._795443933maxLabour = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxLabour", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get woodProduction():ResourceProduction
        {
            return (this._946610362woodProduction);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function set ironProduction(_arg_1:ResourceProduction):void
        {
            var _local_2:Object = this._166389665ironProduction;
            if (_local_2 !== _arg_1)
            {
                this._166389665ironProduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironProduction", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get stonePeople():int
        {
            return (this._309495980stonePeople);
        }

        [Bindable(event="propertyChange")]
        private function get maxLabourNum():int
        {
            return (this._1735557277maxLabourNum);
        }

        [Bindable(event="propertyChange")]
        public function get modifyBtn():Button
        {
            return (this._1900602558modifyBtn);
        }

        public function set commenceDemands(_arg_1:Label):void
        {
            var _local_2:Object = this._1261923249commenceDemands;
            if (_local_2 !== _arg_1)
            {
                this._1261923249commenceDemands = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commenceDemands", _local_2, _arg_1));
            };
        }

        public function __modifyBtn_click(_arg_1:MouseEvent):void
        {
            modifyHandle(_arg_1);
        }

        public function set foodProduction(_arg_1:ResourceProduction):void
        {
            var _local_2:Object = this._942048329foodProduction;
            if (_local_2 !== _arg_1)
            {
                this._942048329foodProduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodProduction", _local_2, _arg_1));
            };
        }

        private function onChange(_arg_1:int, _arg_2:ResourceProduceDataBean, _arg_3:int):void
        {
            if (_arg_2 != null)
            {
                switch (_arg_2.typeid)
                {
                    case 1:
                        this.foodPeople = _arg_1;
                        this.foodPercentage = _arg_3;
                        break;
                    case 2:
                        this.woodPeople = _arg_1;
                        this.woodPercentage = _arg_3;
                        break;
                    case 3:
                        this.stonePeople = _arg_1;
                        this.stonePercentage = _arg_3;
                        break;
                    case 4:
                        this.ironPeople = _arg_1;
                        this.ironPercentage = _arg_3;
                        break;
                };
            }
            else
            {
                foodProduction.myPercentage.value = (woodProduction.myPercentage.value = (stoneProduction.myPercentage.value = (ironProduction.myPercentage.value = _arg_3)));
                this.foodPercentage = (this.woodPercentage = (this.stonePercentage = (this.ironPercentage = _arg_3)));
                this.foodPeople = int(((int(foodProduction.myMaxLabour.text) * _arg_3) / 100));
                this.woodPeople = int(((int(woodProduction.myMaxLabour.text) * _arg_3) / 100));
                this.stonePeople = int(((int(stoneProduction.myMaxLabour.text) * _arg_3) / 100));
                this.ironPeople = int(((int(ironProduction.myMaxLabour.text) * _arg_3) / 100));
                foodProduction.countTotal();
                woodProduction.countTotal();
                stoneProduction.countTotal();
                ironProduction.countTotal();
            };
            countProductionEfficiency();
        }

        public function set allProduction(_arg_1:ResourceProduction):void
        {
            var _local_2:Object = this._1315008826allProduction;
            if (_local_2 !== _arg_1)
            {
                this._1315008826allProduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allProduction", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get ironPeople():int
        {
            return (this._1938825865ironPeople);
        }

        private function set productionEfficiencyHandleYet(_arg_1:Number):void
        {
            var _local_2:Object = this._1187274174productionEfficiencyHandleYet;
            if (_local_2 !== _arg_1)
            {
                this._1187274174productionEfficiencyHandleYet = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionEfficiencyHandleYet", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get worker():int
        {
            return (this._782085250worker);
        }

        public function set modifyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1900602558modifyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1900602558modifyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "modifyBtn", _local_2, _arg_1));
            };
        }

        private function modifyHandle(_arg_1:MouseEvent):void
        {
            instance = ResponseDispatcher.getInstance();
            instance.addEventListener(ResponseDispatcher.INTERIOR_MODIFY_COMMENCE_RATE, modifyCommenceRateResponse);
            ActionFactory.getInstance().getInteriorCommands().modifyCommenceRate(this.curCastle.id, this.foodPercentage, this.woodPercentage, this.stonePercentage, this.ironPercentage);
            if (((((((Context.getInstance().needUserGuide) && (allProduction.myPercentage.value == 100)) && (ironProduction.myPercentage.value == 100)) && (stoneProduction.myPercentage.value == 100)) && (woodProduction.myPercentage.value == 100)) && (foodProduction.myPercentage.value == 100)))
            {
                GuideStep.getInstance().step15();
            };
            if (((Context.getInstance().facebookUser) && (Context.getInstance().needUserGuide)))
            {
                showSocialBar();
                trace("show social bar");
            };
        }

        public function set woodProduction(_arg_1:ResourceProduction):void
        {
            var _local_2:Object = this._946610362woodProduction;
            if (_local_2 !== _arg_1)
            {
                this._946610362woodProduction = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodProduction", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get foodPeople():int
        {
            return (this._506991475foodPeople);
        }

        override public function initialize():void
        {
            var target:ResourceProduce;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ResourceProduce_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_ResourceProduceWatcherSetupUtil");
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
        private function get woodPeople():int
        {
            return (this._447246236woodPeople);
        }

        private function modifyCommenceRateResponse(_arg_1:CommandResponse):void
        {
            instance.removeEventListener(ResponseDispatcher.INTERIOR_MODIFY_COMMENCE_RATE, modifyCommenceRateResponse);
            switch (_arg_1.ok)
            {
                case CommandResponse.OK_DEFAULT:
                    AlertWin.show(Lang.msg("成功修改开工率"));
                    return;
                case CommandResponse.OK_INVALID_REQUEST:
                    AlertWin.show(_arg_1.errorMsg);
                    return;
            };
        }

        private function set stonePeople(_arg_1:int):void
        {
            var _local_2:Object = this._309495980stonePeople;
            if (_local_2 !== _arg_1)
            {
                this._309495980stonePeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stonePeople", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get foodProduction():ResourceProduction
        {
            return (this._942048329foodProduction);
        }

        private function countProductionEfficiency():void
        {
            this.commenceDemandsNum = (((this.foodPeople + this.woodPeople) + this.stonePeople) + this.ironPeople);
            if (this.commenceDemandsNum == 0)
            {
                this.productionEfficiency = 100;
                this.productionEfficiencyHandleYet = 100;
            }
            else
            {
                this.productionEfficiency = ((this.worker >= this.commenceDemandsNum) ? 100 : ((this.worker / this.commenceDemandsNum) * 100));
                this.productionEfficiencyHandleYet = ((this.worker >= this.commenceDemandsNum) ? 100 : (int(((this.worker / this.commenceDemandsNum) * 10000)) / 100));
            };
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get commenceDemands():Label
        {
            return (this._1261923249commenceDemands);
        }

        [Bindable(event="propertyChange")]
        public function get ironProduction():ResourceProduction
        {
            return (this._166389665ironProduction);
        }

        private function _ResourceProduce_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("修改");
            _local_1 = Lang.msg("生产能力");
            _local_1 = Lang.msg("最大劳力");
            _local_1 = Lang.msg("开工需求");
            _local_1 = Lang.msg("开工率");
            _local_1 = Lang.msg("基础产量");
            _local_1 = Lang.msg("殖民地加成");
            _local_1 = Lang.msg("宗主加成");
            _local_1 = Lang.msg("自然加成");
            _local_1 = Lang.msg("科技加成");
            _local_1 = Lang.msg("军队加成");
            _local_1 = Lang.msg("将领加成");
            _local_1 = Lang.msg("野地加成");
            _local_1 = Lang.msg("宝物加成");
            _local_1 = Lang.msg("总产量");
            _local_1 = onChange;
            _local_1 = this.productionEfficiency;
            _local_1 = onChange;
            _local_1 = this.productionEfficiency;
            _local_1 = onChange;
            _local_1 = this.productionEfficiency;
            _local_1 = onChange;
            _local_1 = this.productionEfficiency;
            _local_1 = onChange;
            _local_1 = this.productionEfficiency;
            _local_1 = (Lang.msg("可用劳力") + ":");
            _local_1 = this.worker;
            _local_1 = (Lang.msg("最大劳力") + ":");
            _local_1 = this.maxLabourNum;
            _local_1 = (Lang.msg("开工需求") + ":");
            _local_1 = this.commenceDemandsNum;
            _local_1 = (Lang.msg("生产效率") + ":");
            _local_1 = (this.productionEfficiencyHandleYet + "%");
            _local_1 = ((GuideStep.getInstance().currentStep == 15) && (!(allProduction.myPercentage.value == 100)));
            _local_1 = ((GuideStep.getInstance().currentStep == 15) && (!(allProduction.myPercentage.value == 100)));
            _local_1 = ((GuideStep.getInstance().currentStep == 15) && (allProduction.myPercentage.value == 100));
            _local_1 = ((((((GuideStep.getInstance().currentStep == 15) && (allProduction.myPercentage.value == 100)) && (ironProduction.myPercentage.value == 100)) && (stoneProduction.myPercentage.value == 100)) && (woodProduction.myPercentage.value == 100)) && (foodProduction.myPercentage.value == 100));
        }

        private function set maxLabourNum(_arg_1:int):void
        {
            var _local_2:Object = this._1735557277maxLabourNum;
            if (_local_2 !== _arg_1)
            {
                this._1735557277maxLabourNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxLabourNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get availableLabour():Label
        {
            return (this._191627976availableLabour);
        }

        [Bindable(event="propertyChange")]
        private function get productionEfficiencyHandleYet():Number
        {
            return (this._1187274174productionEfficiencyHandleYet);
        }

        private function _ResourceProduce_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("修改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                modifyBtn.label = _arg_1;
            }, "modifyBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("生产能力");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label2.text = _arg_1;
            }, "_ResourceProduce_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最大劳力");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label3.text = _arg_1;
            }, "_ResourceProduce_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开工需求");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label4.text = _arg_1;
            }, "_ResourceProduce_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开工率");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label5.text = _arg_1;
            }, "_ResourceProduce_Label5.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("基础产量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label6.text = _arg_1;
            }, "_ResourceProduce_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("殖民地加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label7.text = _arg_1;
            }, "_ResourceProduce_Label7.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("宗主加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label8.text = _arg_1;
            }, "_ResourceProduce_Label8.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("自然加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label9.text = _arg_1;
            }, "_ResourceProduce_Label9.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("科技加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label10.text = _arg_1;
            }, "_ResourceProduce_Label10.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label11.text = _arg_1;
            }, "_ResourceProduce_Label11.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label12.text = _arg_1;
            }, "_ResourceProduce_Label12.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("野地加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label13.text = _arg_1;
            }, "_ResourceProduce_Label13.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("宝物加成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label14.text = _arg_1;
            }, "_ResourceProduce_Label14.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("总产量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label15.text = _arg_1;
            }, "_ResourceProduce_Label15.text");
            result[14] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                foodProduction.onDataChange = _arg_1;
            }, "foodProduction.onDataChange");
            result[15] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.productionEfficiency);
            }, function (_arg_1:Number):void
            {
                foodProduction.myProductivity = _arg_1;
            }, "foodProduction.myProductivity");
            result[16] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                woodProduction.onDataChange = _arg_1;
            }, "woodProduction.onDataChange");
            result[17] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.productionEfficiency);
            }, function (_arg_1:Number):void
            {
                woodProduction.myProductivity = _arg_1;
            }, "woodProduction.myProductivity");
            result[18] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                stoneProduction.onDataChange = _arg_1;
            }, "stoneProduction.onDataChange");
            result[19] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.productionEfficiency);
            }, function (_arg_1:Number):void
            {
                stoneProduction.myProductivity = _arg_1;
            }, "stoneProduction.myProductivity");
            result[20] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                ironProduction.onDataChange = _arg_1;
            }, "ironProduction.onDataChange");
            result[21] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.productionEfficiency);
            }, function (_arg_1:Number):void
            {
                ironProduction.myProductivity = _arg_1;
            }, "ironProduction.myProductivity");
            result[22] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                allProduction.onDataChange = _arg_1;
            }, "allProduction.onDataChange");
            result[23] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.productionEfficiency);
            }, function (_arg_1:Number):void
            {
                allProduction.myProductivity = _arg_1;
            }, "allProduction.myProductivity");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("可用劳力") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label16.text = _arg_1;
            }, "_ResourceProduce_Label16.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.worker;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                availableLabour.text = _arg_1;
            }, "availableLabour.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("最大劳力") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label18.text = _arg_1;
            }, "_ResourceProduce_Label18.text");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.maxLabourNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                maxLabour.text = _arg_1;
            }, "maxLabour.text");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("开工需求") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label20.text = _arg_1;
            }, "_ResourceProduce_Label20.text");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.commenceDemandsNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                commenceDemands.text = _arg_1;
            }, "commenceDemands.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("生产效率") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ResourceProduce_Label22.text = _arg_1;
            }, "_ResourceProduce_Label22.text");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.productionEfficiencyHandleYet + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                productionEffeciency.text = _arg_1;
            }, "productionEffeciency.text");
            result[32] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 15) && (!(allProduction.myPercentage.value == 100)));
            }, function (_arg_1:Boolean):void
            {
                _ResourceProduce_GuideArrow1.includeInLayout = _arg_1;
            }, "_ResourceProduce_GuideArrow1.includeInLayout");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 15) && (!(allProduction.myPercentage.value == 100)));
            }, function (_arg_1:Boolean):void
            {
                _ResourceProduce_GuideArrow1.visible = _arg_1;
            }, "_ResourceProduce_GuideArrow1.visible");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((GuideStep.getInstance().currentStep == 15) && (allProduction.myPercentage.value == 100));
            }, function (_arg_1:Boolean):void
            {
                _ResourceProduce_GuideArrow2.includeInLayout = _arg_1;
            }, "_ResourceProduce_GuideArrow2.includeInLayout");
            result[35] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((((GuideStep.getInstance().currentStep == 15) && (allProduction.myPercentage.value == 100)) && (ironProduction.myPercentage.value == 100)) && (stoneProduction.myPercentage.value == 100)) && (woodProduction.myPercentage.value == 100)) && (foodProduction.myPercentage.value == 100));
            }, function (_arg_1:Boolean):void
            {
                _ResourceProduce_GuideArrow2.visible = _arg_1;
            }, "_ResourceProduce_GuideArrow2.visible");
            result[36] = binding;
            return (result);
        }

        public function set availableLabour(_arg_1:Label):void
        {
            var _local_2:Object = this._191627976availableLabour;
            if (_local_2 !== _arg_1)
            {
                this._191627976availableLabour = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "availableLabour", _local_2, _arg_1));
            };
        }

        private function getResourceResponse(_arg_1:ResourceProduceDataResponse):void
        {
            var _local_3:ResourceProduceDataBean;
            var _local_2:int;
            while (_local_2 < _arg_1.resourceProduceDataBeanArray.length)
            {
                _local_3 = _arg_1.getResourceProduceDataBean(_local_2);
                switch (_local_3.typeid)
                {
                    case 1:
                        this.foodProduction.myResourceProduceDataBean = _local_3;
                        this.foodPeople = int(((_local_3.maxLabour * _local_3.commenceRate) / 100));
                        this.foodPercentage = _local_3.commenceRate;
                        this.maxLabourNum = (this.maxLabourNum + _local_3.maxLabour);
                        if (this.curCastle.colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN)
                        {
                            this.foodProduction._receiveResource = this.curCastle.resource.colonyFood;
                            this.foodProduction._paidResource = 0;
                        }
                        else
                        {
                            this.foodProduction._receiveResource = 0;
                            this.foodProduction._paidResource = this.curCastle.resource.colonyFood;
                        };
                        break;
                    case 2:
                        this.woodProduction.myResourceProduceDataBean = _local_3;
                        this.woodPeople = int(((_local_3.maxLabour * _local_3.commenceRate) / 100));
                        this.woodPercentage = _local_3.commenceRate;
                        this.maxLabourNum = (this.maxLabourNum + _local_3.maxLabour);
                        if (this.curCastle.colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN)
                        {
                            this.woodProduction._receiveResource = this.curCastle.resource.colonyWood;
                            this.woodProduction._paidResource = 0;
                        }
                        else
                        {
                            this.woodProduction._receiveResource = 0;
                            this.woodProduction._paidResource = this.curCastle.resource.colonyWood;
                        };
                        break;
                    case 3:
                        this.stoneProduction.myResourceProduceDataBean = _local_3;
                        this.stonePeople = int(((_local_3.maxLabour * _local_3.commenceRate) / 100));
                        this.stonePercentage = _local_3.commenceRate;
                        this.maxLabourNum = (this.maxLabourNum + _local_3.maxLabour);
                        if (this.curCastle.colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN)
                        {
                            this.stoneProduction._receiveResource = this.curCastle.resource.colonyStone;
                            this.stoneProduction._paidResource = 0;
                        }
                        else
                        {
                            this.stoneProduction._receiveResource = 0;
                            this.stoneProduction._paidResource = this.curCastle.resource.colonyStone;
                        };
                        break;
                    case 4:
                        this.ironProduction.myResourceProduceDataBean = _local_3;
                        this.ironPeople = int(((_local_3.maxLabour * _local_3.commenceRate) / 100));
                        this.ironPercentage = _local_3.commenceRate;
                        this.maxLabourNum = (this.maxLabourNum + _local_3.maxLabour);
                        if (this.curCastle.colonization == ColonyConstants.CASTLE_COLONIZATION_SUZERAIN)
                        {
                            this.ironProduction._receiveResource = this.curCastle.resource.colonyIron;
                            this.ironProduction._paidResource = 0;
                        }
                        else
                        {
                            this.ironProduction._receiveResource = 0;
                            this.ironProduction._paidResource = this.curCastle.resource.colonyIron;
                        };
                        break;
                };
                _local_2++;
            };
            countProductionEfficiency();
        }

        private function showSocialBar():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("socialBar.showSocialBar");
            };
        }

        private function set ironPeople(_arg_1:int):void
        {
            var _local_2:Object = this._1938825865ironPeople;
            if (_local_2 !== _arg_1)
            {
                this._1938825865ironPeople = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironPeople", _local_2, _arg_1));
            };
        }

        public function set productionEffeciency(_arg_1:Label):void
        {
            var _local_2:Object = this._623242498productionEffeciency;
            if (_local_2 !== _arg_1)
            {
                this._623242498productionEffeciency = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "productionEffeciency", _local_2, _arg_1));
            };
        }


    }
}//package view.module.office

