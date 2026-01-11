// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ScoutBattleReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.VBox;
    import view.module.info.reports.ReportUi.BattleBackTroop;
    import mx.containers.FormHeading;
    import mx.utils.ObjectProxy;
    import mx.containers.FormItem;
    import view.ui.MyHRule;
    import view.module.info.reports.ReportUi.BattleTroopUi;
    import mx.controls.Label;
    import view.module.info.reports.ReportUi.LootResourceUi;
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.controls.VRule;
    import mx.controls.Spacer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import view.module.info.reports.ReportUi.GetItem;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    public class ScoutBattleReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ScoutBattleReportDetail_VBox1:VBox;
        public var _ScoutBattleReportDetail_BattleBackTroop1:BattleBackTroop;
        private var _815590653targetPos:String;
        public var _ScoutBattleReportDetail_VBox2:VBox;
        public var _ScoutBattleReportDetail_FormHeading1:FormHeading;
        public var _ScoutBattleReportDetail_FormHeading2:FormHeading;
        public var _ScoutBattleReportDetail_FormHeading3:FormHeading;
        public var _ScoutBattleReportDetail_FormHeading4:FormHeading;
        private var _109815obj:ObjectProxy;
        private var _562448104lotResObj:ObjectProxy;
        public var _ScoutBattleReportDetail_FormItem2:FormItem;
        public var _ScoutBattleReportDetail_FormItem3:FormItem;
        public var _ScoutBattleReportDetail_MyHRule1:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule2:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule3:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule5:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule6:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule7:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule8:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule9:MyHRule;
        public var _ScoutBattleReportDetail_BattleTroopUi1:BattleTroopUi;
        public var _ScoutBattleReportDetail_BattleTroopUi2:BattleTroopUi;
        public var _ScoutBattleReportDetail_Label11:Label;
        public var _ScoutBattleReportDetail_Label13:Label;
        public var _ScoutBattleReportDetail_Label14:Label;
        public var _ScoutBattleReportDetail_Label15:Label;
        public var _ScoutBattleReportDetail_Label16:Label;
        public var _ScoutBattleReportDetail_MyHRule13:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule15:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule17:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule18:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule19:MyHRule;
        public var _ScoutBattleReportDetail_Label17:Label;
        public var _ScoutBattleReportDetail_MyHRule14:MyHRule;
        public var _ScoutBattleReportDetail_Label12:Label;
        public var _ScoutBattleReportDetail_MyHRule12:MyHRule;
        public var _ScoutBattleReportDetail_Label18:Label;
        public var _ScoutBattleReportDetail_MyHRule16:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule11:MyHRule;
        public var _ScoutBattleReportDetail_Label20:Label;
        public var _ScoutBattleReportDetail_Label21:Label;
        public var _ScoutBattleReportDetail_Label22:Label;
        public var _ScoutBattleReportDetail_Label23:Label;
        public var _ScoutBattleReportDetail_Label24:Label;
        public var _ScoutBattleReportDetail_MyHRule23:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule20:MyHRule;
        public var _ScoutBattleReportDetail_MyHRule22:MyHRule;
        public var _ScoutBattleReportDetail_Label10:Label;
        public var _ScoutBattleReportDetail_MyHRule10:MyHRule;
        private var _1316782738startPos:String;
        public var _ScoutBattleReportDetail_Label19:Label;
        private var _2091694845atkTroopObj:ObjectProxy;
        private var _95881066defTroopObj:ObjectProxy;
        private var _266467215bakTroopObj:ObjectProxy;
        public var _ScoutBattleReportDetail_Label1:Label;
        public var _ScoutBattleReportDetail_Label2:Label;
        public var _ScoutBattleReportDetail_Label3:Label;
        public var _ScoutBattleReportDetail_Label4:Label;
        public var _ScoutBattleReportDetail_Label5:Label;
        public var _ScoutBattleReportDetail_Label6:Label;
        public var _ScoutBattleReportDetail_Label7:Label;
        public var _ScoutBattleReportDetail_Label8:Label;
        public var _ScoutBattleReportDetail_Label9:Label;
        public var _ScoutBattleReportDetail_LootResourceUi1:LootResourceUi;
        public var _ScoutBattleReportDetail_HBox5:HBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "16";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"reportFrom",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ScoutBattleReportDetail_Label1"
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutBattleReportDetail_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"_ScoutBattleReportDetail_VBox1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":FormHeading,
                                                                        "id":"_ScoutBattleReportDetail_FormHeading1"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label2"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label3"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label4"
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "id":"_ScoutBattleReportDetail_MyHRule2",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":BattleTroopUi,
                                                            "id":"_ScoutBattleReportDetail_BattleTroopUi1",
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
                                                "type":VBox,
                                                "id":"_ScoutBattleReportDetail_VBox2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":FormHeading,
                                                                        "id":"_ScoutBattleReportDetail_FormHeading2"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label5"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label6"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label7"
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "id":"_ScoutBattleReportDetail_MyHRule3",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":BattleTroopUi,
                                                            "id":"_ScoutBattleReportDetail_BattleTroopUi2",
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
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutBattleReportDetail_Label8"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutBattleReportDetail_MyHRule5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutBattleReportDetail_Label9"
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule6",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label10",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule7",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label11",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule8",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label12",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule9",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label13",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule10",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label14",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule11",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label15",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule12",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label16"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule13",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label17"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule14",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label18"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule15",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label19"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule16",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label20"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_ScoutBattleReportDetail_MyHRule17",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ScoutBattleReportDetail_Label21"
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutBattleReportDetail_MyHRule18",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutBattleReportDetail_Label22"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutBattleReportDetail_MyHRule19",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ScoutBattleReportDetail_Label23"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutBattleReportDetail_MyHRule20",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_ScoutBattleReportDetail_FormItem2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutBattleReportDetail_FormHeading3",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
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
                                                "type":LootResourceUi,
                                                "id":"_ScoutBattleReportDetail_LootResourceUi1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({"type":Spacer})]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ScoutBattleReportDetail_MyHRule22",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_ScoutBattleReportDetail_FormItem3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_ScoutBattleReportDetail_FormHeading4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_ScoutBattleReportDetail_MyHRule23",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":BattleBackTroop,
                                                "id":"_ScoutBattleReportDetail_BattleBackTroop1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
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
                                                "type":HBox,
                                                "id":"_ScoutBattleReportDetail_HBox5",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_ScoutBattleReportDetail_Label24",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        })]});
                                                }
                                            })]
                                        });
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

        public function ScoutBattleReportDetail()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ScoutBattleReportDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        [Bindable(event="propertyChange")]
        private function get atkTroopObj():ObjectProxy
        {
            return (this._2091694845atkTroopObj);
        }

        private function set targetPos(_arg_1:String):void
        {
            var _local_2:Object = this._815590653targetPos;
            if (_local_2 !== _arg_1)
            {
                this._815590653targetPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get obj():ObjectProxy
        {
            return (this._109815obj);
        }

        private function set obj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._109815obj;
            if (_local_2 !== _arg_1)
            {
                this._109815obj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "obj", _local_2, _arg_1));
            };
        }

        private function set atkTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._2091694845atkTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._2091694845atkTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "atkTroopObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get lotResObj():ObjectProxy
        {
            return (this._562448104lotResObj);
        }

        private function set startPos(_arg_1:String):void
        {
            var _local_2:Object = this._1316782738startPos;
            if (_local_2 !== _arg_1)
            {
                this._1316782738startPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPos", _local_2, _arg_1));
            };
        }

        private function _ScoutBattleReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.obj.unNomal;
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = ((this.obj == null) ? false : true);
            _local_1 = ((this.obj == null) ? false : true);
            _local_1 = Lang.msg("攻击方");
            _local_1 = (("(" + ((this.obj.isAttack == true) ? Lang.msg("我方") : Lang.msg("敌方"))) + ")");
            _local_1 = ((this.obj.isAttack == null) ? false : true);
            _local_1 = ((this.obj.isAttack == null) ? false : true);
            _local_1 = this.atkTroopObj.king;
            _local_1 = ((this.atkTroopObj.king != null) ? true : false);
            _local_1 = ((this.atkTroopObj.king != null) ? true : false);
            _local_1 = ((this.obj.isAttackSuccess == true) ? Lang.msg("胜利") : Lang.msg("失败"));
            _local_1 = ((this.obj.isAttackSuccess == null) ? false : true);
            _local_1 = ((this.obj.isAttackSuccess == null) ? false : true);
            _local_1 = ((this.atkTroopObj == null) ? false : true);
            _local_1 = ((this.atkTroopObj == null) ? false : true);
            _local_1 = this.atkTroopObj;
            _local_1 = ((this.atkTroopObj == null) ? false : true);
            _local_1 = ((this.atkTroopObj == null) ? false : true);
            _local_1 = ((this.obj == null) ? false : true);
            _local_1 = ((this.obj == null) ? false : true);
            _local_1 = Lang.msg("防守方");
            _local_1 = (("(" + ((this.obj.isAttack == true) ? Lang.msg("敌方") : Lang.msg("我方"))) + ")");
            _local_1 = ((this.obj.isAttack == null) ? false : true);
            _local_1 = ((this.obj.isAttack == null) ? false : true);
            _local_1 = this.defTroopObj.king;
            _local_1 = ((this.defTroopObj.king != null) ? true : false);
            _local_1 = ((this.defTroopObj.king != null) ? true : false);
            _local_1 = ((this.obj.isAttackSuccess == true) ? Lang.msg("失败") : Lang.msg("胜利"));
            _local_1 = ((this.obj.isAttackSuccess == null) ? false : true);
            _local_1 = ((this.obj.isAttackSuccess == null) ? false : true);
            _local_1 = ((this.defTroopObj == null) ? false : true);
            _local_1 = ((this.defTroopObj == null) ? false : true);
            _local_1 = this.defTroopObj;
            _local_1 = ((this.defTroopObj == null) ? false : true);
            _local_1 = ((this.defTroopObj == null) ? false : true);
            _local_1 = ((((this.obj.round > 1) ? Lang.msg("战斗持续{0}回合复数", this.obj.round) : Lang.msg("战斗持续{0}回合单数", this.obj.round)) + ", ") + ((this.obj.isAttackSuccess == true) ? Lang.msg("攻击方战斗胜利") : Lang.msg("防守方战斗胜利")));
            _local_1 = ((this.obj.round == null) ? false : true);
            _local_1 = ((this.obj.round == null) ? false : true);
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = ((Lang.msg("获得宝物") + ":") + GetItem.getItems(this.obj.attackWinnerItems));
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = (Lang.msg("君主声望") + ": ");
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = (Lang.msg("伤兵比例") + ": ");
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = (Lang.msg("将领经验值") + ": ");
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = (Lang.msg("民心变化") + ": ");
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = (Lang.msg("民怨变化") + ": ");
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = this.obj.prestige;
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.prestige == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = (this.obj.injuredPer + "%");
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.injuredPer == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = this.obj.honor;
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.honor == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = this.obj.heroExp;
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.heroExp == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = this.obj.support;
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.support == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = this.obj.complaint;
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.complaint == null) ? false : true);
            _local_1 = ((this.obj.seizeProblem == null) ? false : true);
            _local_1 = ((this.obj.seizeProblem == null) ? false : true);
            _local_1 = this.obj.seizeProblem;
            _local_1 = ((this.obj.seizeProblem == null) ? false : true);
            _local_1 = ((this.obj.seizeProblem == null) ? false : true);
            _local_1 = ((this.obj.isSeize == null) ? false : true);
            _local_1 = ((this.obj.isSeize == null) ? false : true);
            _local_1 = ((this.obj.isSeize == true) ? Lang.msg("占领成功") : Lang.msg("占领失败"));
            _local_1 = ((this.obj.isSeize == null) ? false : true);
            _local_1 = ((this.obj.isSeize == null) ? false : true);
            _local_1 = ((this.lotResObj == null) ? false : true);
            _local_1 = ((this.lotResObj == null) ? false : true);
            _local_1 = ((this.lotResObj == null) ? false : true);
            _local_1 = ((this.lotResObj == null) ? false : true);
            _local_1 = ((this.obj.isAttack == true) ? Lang.msg("掠夺的资源") : Lang.msg("被掠夺的资源"));
            _local_1 = this.lotResObj;
            _local_1 = ((this.bakTroopObj == null) ? false : true);
            _local_1 = ((this.bakTroopObj == null) ? false : true);
            _local_1 = ((this.bakTroopObj == null) ? false : true);
            _local_1 = ((this.bakTroopObj == null) ? false : true);
            _local_1 = Lang.msg("部队返回");
            _local_1 = this.bakTroopObj.isBack;
            _local_1 = this.bakTroopObj.isBack;
            _local_1 = this.bakTroopObj.isBack;
            _local_1 = this.bakTroopObj.isBack;
            _local_1 = this.bakTroopObj;
            _local_1 = this.obj.isAttack;
            _local_1 = Lang.msg("军队在返回{0}", this.startPos);
            _local_1 = this.obj.isSeize;
        }

        private function _ScoutBattleReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.unNomal;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label1.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label1.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label1.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule1.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule1.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_VBox1.visible = _arg_1;
            }, "_ScoutBattleReportDetail_VBox1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_VBox1.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_VBox1.includeInLayout");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("攻击方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_FormHeading1.label = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading1.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + ((this.obj.isAttack == true) ? Lang.msg("我方") : Lang.msg("敌方"))) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label2.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label2.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label2.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label2.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label2.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label2.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.atkTroopObj.king;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label3.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label3.text");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label3.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label3.visible");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label3.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label3.includeInLayout");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttackSuccess == true) ? Lang.msg("胜利") : Lang.msg("失败"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label4.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label4.text");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label4.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label4.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label4.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label4.includeInLayout");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule2.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule2.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule2.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule2.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.atkTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutBattleReportDetail_BattleTroopUi1.attackObj = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi1.attackObj");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_BattleTroopUi1.visible = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi1.visible");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_BattleTroopUi1.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi1.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_VBox2.visible = _arg_1;
            }, "_ScoutBattleReportDetail_VBox2.visible");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_VBox2.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_VBox2.includeInLayout");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("防守方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_FormHeading2.label = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading2.label");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + ((this.obj.isAttack == true) ? Lang.msg("敌方") : Lang.msg("我方"))) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label5.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label5.text");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label5.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label5.visible");
            result[26] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label5.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label5.includeInLayout");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.defTroopObj.king;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label6.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label6.text");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label6.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label6.visible");
            result[29] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label6.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label6.includeInLayout");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttackSuccess == true) ? Lang.msg("失败") : Lang.msg("胜利"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label7.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label7.text");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label7.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label7.visible");
            result[32] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label7.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label7.includeInLayout");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule3.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule3.visible");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule3.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule3.includeInLayout");
            result[35] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.defTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutBattleReportDetail_BattleTroopUi2.attackObj = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi2.attackObj");
            result[36] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_BattleTroopUi2.visible = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi2.visible");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_BattleTroopUi2.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_BattleTroopUi2.includeInLayout");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((this.obj.round > 1) ? Lang.msg("战斗持续{0}回合复数", this.obj.round) : Lang.msg("战斗持续{0}回合单数", this.obj.round)) + ", ") + ((this.obj.isAttackSuccess == true) ? Lang.msg("攻击方战斗胜利") : Lang.msg("防守方战斗胜利")));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label8.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label8.text");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.round == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label8.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label8.visible");
            result[40] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.round == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label8.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label8.includeInLayout");
            result[41] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule5.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule5.visible");
            result[42] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule5.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule5.includeInLayout");
            result[43] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("获得宝物") + ":") + GetItem.getItems(this.obj.attackWinnerItems));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label9.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label9.text");
            result[44] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label9.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label9.visible");
            result[45] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label9.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label9.includeInLayout");
            result[46] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule6.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule6.visible");
            result[47] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule6.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule6.includeInLayout");
            result[48] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label10.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label10.text");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label10.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label10.visible");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label10.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label10.includeInLayout");
            result[51] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule7.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule7.visible");
            result[52] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule7.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule7.includeInLayout");
            result[53] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("伤兵比例") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label11.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label11.text");
            result[54] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label11.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label11.visible");
            result[55] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label11.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label11.includeInLayout");
            result[56] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule8.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule8.visible");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule8.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule8.includeInLayout");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label12.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label12.text");
            result[59] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label12.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label12.visible");
            result[60] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label12.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label12.includeInLayout");
            result[61] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule9.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule9.visible");
            result[62] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule9.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule9.includeInLayout");
            result[63] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("将领经验值") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label13.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label13.text");
            result[64] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label13.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label13.visible");
            result[65] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label13.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label13.includeInLayout");
            result[66] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule10.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule10.visible");
            result[67] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule10.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule10.includeInLayout");
            result[68] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("民心变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label14.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label14.text");
            result[69] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label14.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label14.visible");
            result[70] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label14.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label14.includeInLayout");
            result[71] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule11.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule11.visible");
            result[72] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule11.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule11.includeInLayout");
            result[73] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("民怨变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label15.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label15.text");
            result[74] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label15.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label15.visible");
            result[75] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label15.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label15.includeInLayout");
            result[76] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule12.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule12.visible");
            result[77] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule12.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule12.includeInLayout");
            result[78] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label16.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label16.text");
            result[79] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label16.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label16.visible");
            result[80] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label16.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label16.includeInLayout");
            result[81] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule13.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule13.visible");
            result[82] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule13.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule13.includeInLayout");
            result[83] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.obj.injuredPer + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label17.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label17.text");
            result[84] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label17.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label17.visible");
            result[85] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label17.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label17.includeInLayout");
            result[86] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule14.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule14.visible");
            result[87] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule14.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule14.includeInLayout");
            result[88] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label18.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label18.text");
            result[89] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label18.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label18.visible");
            result[90] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label18.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label18.includeInLayout");
            result[91] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule15.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule15.visible");
            result[92] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule15.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule15.includeInLayout");
            result[93] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.heroExp;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label19.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label19.text");
            result[94] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label19.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label19.visible");
            result[95] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label19.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label19.includeInLayout");
            result[96] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule16.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule16.visible");
            result[97] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule16.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule16.includeInLayout");
            result[98] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label20.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label20.text");
            result[99] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label20.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label20.visible");
            result[100] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label20.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label20.includeInLayout");
            result[101] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule17.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule17.visible");
            result[102] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule17.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule17.includeInLayout");
            result[103] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.complaint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label21.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label21.text");
            result[104] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label21.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label21.visible");
            result[105] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label21.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label21.includeInLayout");
            result[106] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule18.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule18.visible");
            result[107] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule18.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule18.includeInLayout");
            result[108] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.seizeProblem;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label22.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label22.text");
            result[109] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label22.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label22.visible");
            result[110] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label22.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label22.includeInLayout");
            result[111] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule19.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule19.visible");
            result[112] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule19.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule19.includeInLayout");
            result[113] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isSeize == true) ? Lang.msg("占领成功") : Lang.msg("占领失败"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label23.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label23.text");
            result[114] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label23.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label23.visible");
            result[115] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label23.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_Label23.includeInLayout");
            result[116] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule20.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule20.visible");
            result[117] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule20.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule20.includeInLayout");
            result[118] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormItem2.visible = _arg_1;
            }, "_ScoutBattleReportDetail_FormItem2.visible");
            result[119] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormItem2.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_FormItem2.includeInLayout");
            result[120] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttack == true) ? Lang.msg("掠夺的资源") : Lang.msg("被掠夺的资源"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_FormHeading3.label = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading3.label");
            result[121] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.lotResObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutBattleReportDetail_LootResourceUi1.resourceObj = _arg_1;
            }, "_ScoutBattleReportDetail_LootResourceUi1.resourceObj");
            result[122] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule22.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule22.visible");
            result[123] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule22.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule22.includeInLayout");
            result[124] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormItem3.visible = _arg_1;
            }, "_ScoutBattleReportDetail_FormItem3.visible");
            result[125] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormItem3.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_FormItem3.includeInLayout");
            result[126] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("部队返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_FormHeading4.label = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading4.label");
            result[127] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormHeading4.visible = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading4.visible");
            result[128] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_FormHeading4.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_FormHeading4.includeInLayout");
            result[129] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule23.visible = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule23.visible");
            result[130] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_MyHRule23.includeInLayout = _arg_1;
            }, "_ScoutBattleReportDetail_MyHRule23.includeInLayout");
            result[131] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.bakTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _ScoutBattleReportDetail_BattleBackTroop1.backTroops = _arg_1;
            }, "_ScoutBattleReportDetail_BattleBackTroop1.backTroops");
            result[132] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isAttack);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_HBox5.visible = _arg_1;
            }, "_ScoutBattleReportDetail_HBox5.visible");
            result[133] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队在返回{0}", this.startPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ScoutBattleReportDetail_Label24.text = _arg_1;
            }, "_ScoutBattleReportDetail_Label24.text");
            result[134] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isSeize);
            }, function (_arg_1:Boolean):void
            {
                _ScoutBattleReportDetail_Label24.visible = _arg_1;
            }, "_ScoutBattleReportDetail_Label24.visible");
            result[135] = binding;
            return (result);
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            this.startPos = _arg_2;
            this.targetPos = _arg_3;
            this.obj = _arg_1;
            if (_arg_1 == null)
            {
                return;
            };
            if (((!(_arg_1.attackTroop == null)) && (_arg_1.attackTroop is Object)))
            {
                this.atkTroopObj = (_arg_1.attackTroop as ObjectProxy);
            }
            else
            {
                this.atkTroopObj = _arg_1.attackTroop;
            };
            if (((!(_arg_1.defendTroop == null)) && (_arg_1.defendTroop is Object)))
            {
                this.defTroopObj = (_arg_1.defendTroop as ObjectProxy);
            }
            else
            {
                this.defTroopObj = _arg_1.defendTroop;
            };
            if (((!(_arg_1.lootResource == null)) && (_arg_1.lootResource is Object)))
            {
                this.lotResObj = (_arg_1.lootResource as ObjectProxy);
            }
            else
            {
                this.lotResObj = _arg_1.lootResource;
            };
            if (((!(_arg_1.backTroop == null)) && (_arg_1.backTroop is Object)))
            {
                this.bakTroopObj = (_arg_1.backTroop as ObjectProxy);
            }
            else
            {
                this.bakTroopObj = _arg_1.backTroop;
            };
        }

        [Bindable(event="propertyChange")]
        private function get defTroopObj():ObjectProxy
        {
            return (this._95881066defTroopObj);
        }

        [Bindable(event="propertyChange")]
        private function get startPos():String
        {
            return (this._1316782738startPos);
        }

        override public function initialize():void
        {
            var target:ScoutBattleReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ScoutBattleReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ScoutBattleReportDetailWatcherSetupUtil");
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
        private function get bakTroopObj():ObjectProxy
        {
            return (this._266467215bakTroopObj);
        }

        private function set lotResObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._562448104lotResObj;
            if (_local_2 !== _arg_1)
            {
                this._562448104lotResObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lotResObj", _local_2, _arg_1));
            };
        }

        private function set defTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._95881066defTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._95881066defTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defTroopObj", _local_2, _arg_1));
            };
        }

        private function set bakTroopObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._266467215bakTroopObj;
            if (_local_2 !== _arg_1)
            {
                this._266467215bakTroopObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bakTroopObj", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports

