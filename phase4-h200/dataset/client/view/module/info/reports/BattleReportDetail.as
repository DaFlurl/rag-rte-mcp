// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.BattleReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import mx.containers.FormHeading;
    import mx.containers.FormItem;
    import view.ui.MyHRule;
    import mx.controls.Text;
    import view.module.info.reports.ReportUi.BattleTroopUi;
    import mx.controls.Label;
    import view.module.info.reports.ReportUi.LootResourceUi;
    import view.module.info.reports.ReportUi.AutoHealReportDetail;
    import view.module.info.reports.ReportUi.LoseHeroUi;
    import mx.containers.VBox;
    import view.module.info.reports.ReportUi.BattleBackTroop;
    import view.module.info.reports.ReportUi.GetTreasure;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import mx.controls.Spacer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class BattleReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _740692621showReturn:Boolean = false;
        private var _595557056autoHealObj:ObjectProxy;
        private var _109815obj:ObjectProxy;
        private var _2077368934timeText:String;
        private var _877219718upriseSuppressText:String;
        public var _BattleReportDetail_FormHeading1:FormHeading;
        public var _BattleReportDetail_FormHeading2:FormHeading;
        public var _BattleReportDetail_FormHeading3:FormHeading;
        public var _BattleReportDetail_FormHeading4:FormHeading;
        private var _2091694845atkTroopObj:ObjectProxy;
        public var _BattleReportDetail_FormItem2:FormItem;
        public var _BattleReportDetail_FormItem3:FormItem;
        public var _BattleReportDetail_MyHRule1:MyHRule;
        public var _BattleReportDetail_MyHRule2:MyHRule;
        public var _BattleReportDetail_MyHRule4:MyHRule;
        public var _BattleReportDetail_MyHRule5:MyHRule;
        public var _BattleReportDetail_Text1:Text;
        public var _BattleReportDetail_MyHRule7:MyHRule;
        public var _BattleReportDetail_MyHRule8:MyHRule;
        public var _BattleReportDetail_MyHRule9:MyHRule;
        public var _BattleReportDetail_BattleTroopUi1:BattleTroopUi;
        public var _BattleReportDetail_BattleTroopUi2:BattleTroopUi;
        public var _BattleReportDetail_Text2:Text;
        public var _BattleReportDetail_Text3:Text;
        public var _BattleReportDetail_Text4:Text;
        private var _266467215bakTroopObj:ObjectProxy;
        private var _869138316coloniSuppressText:String;
        public var _BattleReportDetail_Label10:Label;
        public var _BattleReportDetail_Label11:Label;
        public var _BattleReportDetail_Label13:Label;
        public var _BattleReportDetail_Label14:Label;
        public var _BattleReportDetail_Label15:Label;
        public var _BattleReportDetail_MyHRule12:MyHRule;
        public var _BattleReportDetail_Label17:Label;
        public var _BattleReportDetail_Label18:Label;
        public var _BattleReportDetail_MyHRule15:MyHRule;
        public var _BattleReportDetail_MyHRule16:MyHRule;
        public var _BattleReportDetail_MyHRule10:MyHRule;
        public var _BattleReportDetail_MyHRule11:MyHRule;
        public var _BattleReportDetail_MyHRule19:MyHRule;
        private var _815590653targetPos:String;
        public var _BattleReportDetail_MyHRule14:MyHRule;
        public var _BattleReportDetail_Label19:Label;
        public var _BattleReportDetail_Label12:Label;
        public var _BattleReportDetail_Label16:Label;
        public var _BattleReportDetail_MyHRule17:MyHRule;
        public var _BattleReportDetail_MyHRule18:MyHRule;
        public var _BattleReportDetail_Label20:Label;
        public var _BattleReportDetail_Label21:Label;
        public var _BattleReportDetail_Label22:Label;
        public var _BattleReportDetail_Label23:Label;
        public var _BattleReportDetail_Label24:Label;
        public var _BattleReportDetail_Label25:Label;
        public var _BattleReportDetail_Label26:Label;
        public var _BattleReportDetail_Label27:Label;
        public var _BattleReportDetail_Label28:Label;
        public var _BattleReportDetail_MyHRule25:MyHRule;
        public var _BattleReportDetail_MyHRule26:MyHRule;
        public var _BattleReportDetail_MyHRule20:MyHRule;
        public var _BattleReportDetail_MyHRule21:MyHRule;
        public var _BattleReportDetail_MyHRule29:MyHRule;
        public var _BattleReportDetail_MyHRule23:MyHRule;
        public var _BattleReportDetail_MyHRule28:MyHRule;
        public var _BattleReportDetail_MyHRule22:MyHRule;
        private var _562448104lotResObj:ObjectProxy;
        public var _BattleReportDetail_MyHRule30:MyHRule;
        public var _BattleReportDetail_Label1:Label;
        public var _BattleReportDetail_Label2:Label;
        public var _BattleReportDetail_Label3:Label;
        public var _BattleReportDetail_Label4:Label;
        public var _BattleReportDetail_Label5:Label;
        public var _BattleReportDetail_Label6:Label;
        public var _BattleReportDetail_Label7:Label;
        public var _BattleReportDetail_Label8:Label;
        public var _BattleReportDetail_Label9:Label;
        public var _BattleReportDetail_LootResourceUi1:LootResourceUi;
        public var _BattleReportDetail_AutoHealReportDetail1:AutoHealReportDetail;
        public var _BattleReportDetail_LoseHeroUi1:LoseHeroUi;
        public var _BattleReportDetail_VBox1:VBox;
        public var _BattleReportDetail_MyHRule13:MyHRule;
        public var _BattleReportDetail_BattleBackTroop1:BattleBackTroop;
        private var _1316782738startPos:String;
        public var _BattleReportDetail_VBox2:VBox;
        private var _95881066defTroopObj:ObjectProxy;
        private var _1729329906colonizationText:String;
        private var _428062264loseHeroObj:ObjectProxy;
        public var _BattleReportDetail_GetTreasure1:GetTreasure;

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
                                    "id":"_BattleReportDetail_Label1"
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleReportDetail_Label2"
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleReportDetail_Label3"
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"_BattleReportDetail_VBox1",
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
                                                                        "id":"_BattleReportDetail_FormHeading1"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label4"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label5"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label6"
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "id":"_BattleReportDetail_MyHRule4",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":BattleTroopUi,
                                                            "id":"_BattleReportDetail_BattleTroopUi1",
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
                                                "id":"_BattleReportDetail_VBox2",
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
                                                                        "id":"_BattleReportDetail_FormHeading2"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label7"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label8"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label9"
                                                                    })]});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "id":"_BattleReportDetail_MyHRule5",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"tooltipsHrule"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":BattleTroopUi,
                                                            "id":"_BattleReportDetail_BattleTroopUi2",
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
                                                "id":"_BattleReportDetail_Label10"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleReportDetail_MyHRule7",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GetTreasure,
                                                "id":"_BattleReportDetail_GetTreasure1"
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
                                                                        "id":"_BattleReportDetail_MyHRule8",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label11",
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
                                                                        "id":"_BattleReportDetail_MyHRule9",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label12",
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
                                                                        "id":"_BattleReportDetail_MyHRule10",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label13",
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
                                                                        "id":"_BattleReportDetail_MyHRule11",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label14",
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
                                                                        "id":"_BattleReportDetail_MyHRule12",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label15",
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
                                                                        "id":"_BattleReportDetail_MyHRule13",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label16",
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
                                                                        "id":"_BattleReportDetail_MyHRule14",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label17"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_BattleReportDetail_MyHRule15",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label18"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_BattleReportDetail_MyHRule16",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label19"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_BattleReportDetail_MyHRule17",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label20"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_BattleReportDetail_MyHRule18",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label21"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":MyHRule,
                                                                        "id":"_BattleReportDetail_MyHRule19",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"tooltipsHrule"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_BattleReportDetail_Label22"
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleReportDetail_MyHRule20",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":LoseHeroUi,
                                                "id":"_BattleReportDetail_LoseHeroUi1"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleReportDetail_MyHRule21",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleReportDetail_Label23"
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleReportDetail_MyHRule22",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_BattleReportDetail_Label24"
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule23",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_BattleReportDetail_FormItem2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_BattleReportDetail_FormHeading3",
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
                                                "id":"_BattleReportDetail_LootResourceUi1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({"type":Spacer})]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule25",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "id":"_BattleReportDetail_FormItem3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":FormHeading,
                                                "id":"_BattleReportDetail_FormHeading4",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyHRule,
                                                "id":"_BattleReportDetail_MyHRule26",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"tooltipsHrule"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":BattleBackTroop,
                                                "id":"_BattleReportDetail_BattleBackTroop1",
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
                                                "type":Label,
                                                "id":"_BattleReportDetail_Label25",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule28",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BattleReportDetail_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleReportDetail_Label26",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BattleReportDetail_Text2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule29",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BattleReportDetail_Text3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleReportDetail_Label27",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_BattleReportDetail_MyHRule30",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"tooltipsHrule"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_BattleReportDetail_Text4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_BattleReportDetail_Label28",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AutoHealReportDetail,
                                    "id":"_BattleReportDetail_AutoHealReportDetail1"
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

        public function BattleReportDetail()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BattleReportDetail._watcherSetupUtil = _arg_1;
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

        private function set targetPos(_arg_1:String):void
        {
            var _local_2:Object = this._815590653targetPos;
            if (_local_2 !== _arg_1)
            {
                this._815590653targetPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _local_2, _arg_1));
            };
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            this.startPos = _arg_2;
            this.targetPos = _arg_3;
            this.obj = _arg_1;
            this.colonizationText = null;
            this.timeText = null;
            if (((this.obj.isColonial) && (this.obj.isAttackSuccess)))
            {
                timeText = Lang.msg("臣服期时间", this.obj.colonialStartTime, this.obj.colonialEndTime);
                if (this.obj.isAttack)
                {
                    this.colonizationText = Lang.msg("宗主臣服描述");
                }
                else
                {
                    this.colonizationText = Lang.msg("附属臣服描述");
                };
            };
            if (this.obj.isSuppress)
            {
                if (this.obj.isAttack)
                {
                    if (this.obj.hasOwnProperty("isAttackSuccess"))
                    {
                        if (this.obj.isAttackSuccess)
                        {
                            coloniSuppressText = Lang.msg("臣服期镇压描述宗主城成功");
                        }
                        else
                        {
                            coloniSuppressText = Lang.msg("臣服期镇压描述宗主城失败");
                        };
                    }
                    else
                    {
                        coloniSuppressText = Lang.msg("臣服期镇压描述宗主城成功");
                    };
                }
                else
                {
                    if (this.obj.hasOwnProperty("isAttackSuccess"))
                    {
                        if (this.obj.isAttackSuccess)
                        {
                            coloniSuppressText = Lang.msg("臣服期镇压描述附属城失败");
                        }
                        else
                        {
                            coloniSuppressText = Lang.msg("臣服期镇压描述附属城成功");
                        };
                    }
                    else
                    {
                        coloniSuppressText = Lang.msg("臣服期镇压描述附属城失败");
                    };
                };
            };
            if (this.obj.isUprising)
            {
                if (this.obj.isAttack)
                {
                    if (this.obj.hasOwnProperty("isAttackSuccess"))
                    {
                        if (this.obj.isAttackSuccess)
                        {
                            upriseSuppressText = Lang.msg("起义镇压描述宗主城成功");
                        }
                        else
                        {
                            upriseSuppressText = Lang.msg("起义镇压描述宗主城失败");
                        };
                    }
                    else
                    {
                        upriseSuppressText = Lang.msg("起义镇压描述宗主城成功");
                    };
                }
                else
                {
                    if (this.obj.hasOwnProperty("isAttackSuccess"))
                    {
                        if (this.obj.isAttackSuccess)
                        {
                            upriseSuppressText = Lang.msg("起义镇压描述附属城失败");
                        }
                        else
                        {
                            upriseSuppressText = Lang.msg("起义镇压描述附属城成功");
                        };
                    }
                    else
                    {
                        upriseSuppressText = Lang.msg("起义镇压描述附属城失败");
                    };
                };
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
            if (((!(_arg_1.LoseHeroList == null)) && (_arg_1.LoseHeroList is Object)))
            {
                this.loseHeroObj = (_arg_1.LoseHeroList as ObjectProxy);
            }
            else
            {
                this.loseHeroObj = _arg_1.LoseHeroList;
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
            if (((!(_arg_1.autoHeal == null)) && (_arg_1.autoHeal is Object)))
            {
                this.autoHealObj = (_arg_1.autoHeal as ObjectProxy);
            }
            else
            {
                this.autoHealObj = _arg_1.autoHeal;
            };
            this.showReturn = isShowReturn();
        }

        [Bindable(event="propertyChange")]
        private function get bakTroopObj():ObjectProxy
        {
            return (this._266467215bakTroopObj);
        }

        private function set autoHealObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._595557056autoHealObj;
            if (_local_2 !== _arg_1)
            {
                this._595557056autoHealObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoHealObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get showReturn():Boolean
        {
            return (this._740692621showReturn);
        }

        [Bindable(event="propertyChange")]
        private function get startPos():String
        {
            return (this._1316782738startPos);
        }

        private function _BattleReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.obj.isAttack == true) ? ((((((((Lang.msg("出发地") + " ") + this.startPos) + ", ") + Lang.msg("向城池")) + " ") + this.targetPos) + ", ") + Lang.msg("执行攻击任务的军队已到达目标")) : ((((Lang.msg("一支军队对") + " ") + this.targetPos) + " ") + Lang.msg("进行了攻击")));
            _local_1 = ((this.obj.isAttack == null) ? false : ((true) && (this.obj.isAntiColony == null)));
            _local_1 = ((this.obj.isAttack == null) ? false : ((true) && (this.obj.isAntiColony == null)));
            _local_1 = ((this.obj.isAntiColony == null) ? false : true);
            _local_1 = ((this.obj.isAntiColony == null) ? false : true);
            _local_1 = Lang.msg("雇佣军战争说明", this.startPos, this.targetPos);
            _local_1 = ((this.obj.isAntiColony == null) ? false : true);
            _local_1 = ((this.obj.isAntiColony == null) ? false : true);
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = ((this.obj.unNomal == null) ? false : true);
            _local_1 = this.obj.unNomal;
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
            _local_1 = ((((this.obj.round > 1) ? Lang.msg("战斗持续{0}回合复数", this.obj.round) : Lang.msg("战斗持续{0}回合单数", this.obj.round)) + ", ") + ((this.obj.isAttackSuccess == true) ? ((this.obj.isColonial == true) ? (Lang.msg("攻击方战斗胜利") + Lang.msg("军队驻守目标城")) : Lang.msg("攻击方战斗胜利")) : Lang.msg("防守方战斗胜利")));
            _local_1 = ((this.obj.round == null) ? false : true);
            _local_1 = ((this.obj.round == null) ? false : true);
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = ((this.obj.attackWinnerItems == null) ? false : true);
            _local_1 = this.obj.attackWinnerItems;
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
            _local_1 = ((this.loseHeroObj == null) ? false : true);
            _local_1 = ((this.loseHeroObj == null) ? false : true);
            _local_1 = this.loseHeroObj;
            _local_1 = ((this.loseHeroObj == null) ? false : true);
            _local_1 = ((this.loseHeroObj == null) ? false : true);
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
            _local_1 = ((this.obj.isAttack == this.obj.isAttackSuccess) ? Lang.msg("掠夺的资源") : Lang.msg("被掠夺的资源"));
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
            _local_1 = Lang.msg("军队在返回{0}", this.startPos);
            _local_1 = this.showReturn;
            _local_1 = this.showReturn;
            _local_1 = this.obj.isColonial;
            _local_1 = this.obj.isColonial;
            _local_1 = ((this.obj.isAttack) ? Lang.msg("首战胜利进入臣服") : Lang.msg("城池被占进入臣服"));
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = timeText;
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = colonizationText;
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            _local_1 = this.obj.isSuppress;
            _local_1 = this.obj.isSuppress;
            _local_1 = this.coloniSuppressText;
            _local_1 = this.obj.isSuppress;
            _local_1 = this.obj.isSuppress;
            _local_1 = Lang.msg("殖民关系中止战争结束");
            _local_1 = ((this.obj.isSuppress) && (!(this.obj.isAttackSuccess)));
            _local_1 = ((this.obj.isSuppress) && (!(this.obj.isAttackSuccess)));
            _local_1 = this.obj.isUprising;
            _local_1 = this.obj.isUprising;
            _local_1 = this.upriseSuppressText;
            _local_1 = this.obj.isUprising;
            _local_1 = this.obj.isUprising;
            _local_1 = Lang.msg("殖民关系中止战争结束");
            _local_1 = ((this.obj.isUprising) && (!(this.obj.isAttackSuccess)));
            _local_1 = ((this.obj.isUprising) && (!(this.obj.isAttackSuccess)));
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
            _local_1 = this.autoHealObj;
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

        [Bindable(event="propertyChange")]
        private function get lotResObj():ObjectProxy
        {
            return (this._562448104lotResObj);
        }

        [Bindable(event="propertyChange")]
        private function get atkTroopObj():ObjectProxy
        {
            return (this._2091694845atkTroopObj);
        }

        private function set upriseSuppressText(_arg_1:String):void
        {
            var _local_2:Object = this._877219718upriseSuppressText;
            if (_local_2 !== _arg_1)
            {
                this._877219718upriseSuppressText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "upriseSuppressText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonizationText():String
        {
            return (this._1729329906colonizationText);
        }

        private function set showReturn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._740692621showReturn;
            if (_local_2 !== _arg_1)
            {
                this._740692621showReturn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showReturn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        private function set coloniSuppressText(_arg_1:String):void
        {
            var _local_2:Object = this._869138316coloniSuppressText;
            if (_local_2 !== _arg_1)
            {
                this._869138316coloniSuppressText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "coloniSuppressText", _local_2, _arg_1));
            };
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

        private function set timeText(_arg_1:String):void
        {
            var _local_2:Object = this._2077368934timeText;
            if (_local_2 !== _arg_1)
            {
                this._2077368934timeText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "timeText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get obj():ObjectProxy
        {
            return (this._109815obj);
        }

        private function isShowReturn():Boolean
        {
            var _local_1:Boolean;
            if (((((this.obj.isAttack == true) && (this.obj.isAttackSuccess == true)) && (!(this.bakTroopObj == null))) && (this.obj.isSeize == false)))
            {
                _local_1 = true;
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get autoHealObj():ObjectProxy
        {
            return (this._595557056autoHealObj);
        }

        [Bindable(event="propertyChange")]
        private function get defTroopObj():ObjectProxy
        {
            return (this._95881066defTroopObj);
        }

        override public function initialize():void
        {
            var target:BattleReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BattleReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_BattleReportDetailWatcherSetupUtil");
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
        private function get coloniSuppressText():String
        {
            return (this._869138316coloniSuppressText);
        }

        [Bindable(event="propertyChange")]
        private function get timeText():String
        {
            return (this._2077368934timeText);
        }

        [Bindable(event="propertyChange")]
        private function get upriseSuppressText():String
        {
            return (this._877219718upriseSuppressText);
        }

        private function set loseHeroObj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._428062264loseHeroObj;
            if (_local_2 !== _arg_1)
            {
                this._428062264loseHeroObj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loseHeroObj", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get loseHeroObj():ObjectProxy
        {
            return (this._428062264loseHeroObj);
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

        private function _BattleReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttack == true) ? ((((((((Lang.msg("出发地") + " ") + this.startPos) + ", ") + Lang.msg("向城池")) + " ") + this.targetPos) + ", ") + Lang.msg("执行攻击任务的军队已到达目标")) : ((((Lang.msg("一支军队对") + " ") + this.targetPos) + " ") + Lang.msg("进行了攻击")));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label1.text = _arg_1;
            }, "_BattleReportDetail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : ((true) && (this.obj.isAntiColony == null)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label1.visible = _arg_1;
            }, "_BattleReportDetail_Label1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : ((true) && (this.obj.isAntiColony == null)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAntiColony == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule1.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule1.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAntiColony == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("雇佣军战争说明", this.startPos, this.targetPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label2.text = _arg_1;
            }, "_BattleReportDetail_Label2.text");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAntiColony == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label2.visible = _arg_1;
            }, "_BattleReportDetail_Label2.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAntiColony == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label2.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule2.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule2.visible");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule2.includeInLayout");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.unNomal;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label3.text = _arg_1;
            }, "_BattleReportDetail_Label3.text");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label3.visible = _arg_1;
            }, "_BattleReportDetail_Label3.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.unNomal == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label3.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label3.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_VBox1.visible = _arg_1;
            }, "_BattleReportDetail_VBox1.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_VBox1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_VBox1.includeInLayout");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("攻击方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_FormHeading1.label = _arg_1;
            }, "_BattleReportDetail_FormHeading1.label");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + ((this.obj.isAttack == true) ? Lang.msg("我方") : Lang.msg("敌方"))) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label4.text = _arg_1;
            }, "_BattleReportDetail_Label4.text");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label4.visible = _arg_1;
            }, "_BattleReportDetail_Label4.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label4.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label4.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.atkTroopObj.king;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label5.text = _arg_1;
            }, "_BattleReportDetail_Label5.text");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label5.visible = _arg_1;
            }, "_BattleReportDetail_Label5.visible");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label5.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label5.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttackSuccess == true) ? Lang.msg("胜利") : Lang.msg("失败"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label6.text = _arg_1;
            }, "_BattleReportDetail_Label6.text");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label6.visible = _arg_1;
            }, "_BattleReportDetail_Label6.visible");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label6.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label6.includeInLayout");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule4.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule4.visible");
            result[25] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule4.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule4.includeInLayout");
            result[26] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.atkTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_BattleTroopUi1.attackObj = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi1.attackObj");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_BattleTroopUi1.visible = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi1.visible");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.atkTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_BattleTroopUi1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi1.includeInLayout");
            result[29] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_VBox2.visible = _arg_1;
            }, "_BattleReportDetail_VBox2.visible");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_VBox2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_VBox2.includeInLayout");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("防守方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_FormHeading2.label = _arg_1;
            }, "_BattleReportDetail_FormHeading2.label");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + ((this.obj.isAttack == true) ? Lang.msg("敌方") : Lang.msg("我方"))) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label7.text = _arg_1;
            }, "_BattleReportDetail_Label7.text");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label7.visible = _arg_1;
            }, "_BattleReportDetail_Label7.visible");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttack == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label7.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label7.includeInLayout");
            result[35] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.defTroopObj.king;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label8.text = _arg_1;
            }, "_BattleReportDetail_Label8.text");
            result[36] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label8.visible = _arg_1;
            }, "_BattleReportDetail_Label8.visible");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj.king != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label8.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label8.includeInLayout");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttackSuccess == true) ? Lang.msg("失败") : Lang.msg("胜利"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label9.text = _arg_1;
            }, "_BattleReportDetail_Label9.text");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label9.visible = _arg_1;
            }, "_BattleReportDetail_Label9.visible");
            result[40] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isAttackSuccess == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label9.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label9.includeInLayout");
            result[41] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule5.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule5.visible");
            result[42] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule5.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule5.includeInLayout");
            result[43] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.defTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_BattleTroopUi2.attackObj = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi2.attackObj");
            result[44] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_BattleTroopUi2.visible = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi2.visible");
            result[45] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.defTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_BattleTroopUi2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_BattleTroopUi2.includeInLayout");
            result[46] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((((this.obj.round > 1) ? Lang.msg("战斗持续{0}回合复数", this.obj.round) : Lang.msg("战斗持续{0}回合单数", this.obj.round)) + ", ") + ((this.obj.isAttackSuccess == true) ? ((this.obj.isColonial == true) ? (Lang.msg("攻击方战斗胜利") + Lang.msg("军队驻守目标城")) : Lang.msg("攻击方战斗胜利")) : Lang.msg("防守方战斗胜利")));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label10.text = _arg_1;
            }, "_BattleReportDetail_Label10.text");
            result[47] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.round == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label10.visible = _arg_1;
            }, "_BattleReportDetail_Label10.visible");
            result[48] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.round == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label10.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label10.includeInLayout");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule7.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule7.visible");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule7.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule7.includeInLayout");
            result[51] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.attackWinnerItems;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_GetTreasure1.myItem = _arg_1;
            }, "_BattleReportDetail_GetTreasure1.myItem");
            result[52] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_GetTreasure1.visible = _arg_1;
            }, "_BattleReportDetail_GetTreasure1.visible");
            result[53] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.attackWinnerItems == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_GetTreasure1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_GetTreasure1.includeInLayout");
            result[54] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule8.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule8.visible");
            result[55] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule8.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule8.includeInLayout");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("君主声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label11.text = _arg_1;
            }, "_BattleReportDetail_Label11.text");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label11.visible = _arg_1;
            }, "_BattleReportDetail_Label11.visible");
            result[58] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label11.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label11.includeInLayout");
            result[59] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule9.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule9.visible");
            result[60] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule9.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule9.includeInLayout");
            result[61] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("伤兵比例") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label12.text = _arg_1;
            }, "_BattleReportDetail_Label12.text");
            result[62] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label12.visible = _arg_1;
            }, "_BattleReportDetail_Label12.visible");
            result[63] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label12.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label12.includeInLayout");
            result[64] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule10.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule10.visible");
            result[65] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule10.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule10.includeInLayout");
            result[66] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label13.text = _arg_1;
            }, "_BattleReportDetail_Label13.text");
            result[67] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label13.visible = _arg_1;
            }, "_BattleReportDetail_Label13.visible");
            result[68] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label13.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label13.includeInLayout");
            result[69] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule11.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule11.visible");
            result[70] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule11.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule11.includeInLayout");
            result[71] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("将领经验值") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label14.text = _arg_1;
            }, "_BattleReportDetail_Label14.text");
            result[72] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label14.visible = _arg_1;
            }, "_BattleReportDetail_Label14.visible");
            result[73] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label14.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label14.includeInLayout");
            result[74] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule12.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule12.visible");
            result[75] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule12.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule12.includeInLayout");
            result[76] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("民心变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label15.text = _arg_1;
            }, "_BattleReportDetail_Label15.text");
            result[77] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label15.visible = _arg_1;
            }, "_BattleReportDetail_Label15.visible");
            result[78] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label15.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label15.includeInLayout");
            result[79] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule13.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule13.visible");
            result[80] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule13.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule13.includeInLayout");
            result[81] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("民怨变化") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label16.text = _arg_1;
            }, "_BattleReportDetail_Label16.text");
            result[82] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label16.visible = _arg_1;
            }, "_BattleReportDetail_Label16.visible");
            result[83] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label16.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label16.includeInLayout");
            result[84] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule14.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule14.visible");
            result[85] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule14.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule14.includeInLayout");
            result[86] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label17.text = _arg_1;
            }, "_BattleReportDetail_Label17.text");
            result[87] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label17.visible = _arg_1;
            }, "_BattleReportDetail_Label17.visible");
            result[88] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.prestige == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label17.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label17.includeInLayout");
            result[89] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule15.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule15.visible");
            result[90] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule15.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule15.includeInLayout");
            result[91] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.obj.injuredPer + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label18.text = _arg_1;
            }, "_BattleReportDetail_Label18.text");
            result[92] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label18.visible = _arg_1;
            }, "_BattleReportDetail_Label18.visible");
            result[93] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.injuredPer == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label18.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label18.includeInLayout");
            result[94] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule16.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule16.visible");
            result[95] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule16.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule16.includeInLayout");
            result[96] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label19.text = _arg_1;
            }, "_BattleReportDetail_Label19.text");
            result[97] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label19.visible = _arg_1;
            }, "_BattleReportDetail_Label19.visible");
            result[98] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.honor == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label19.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label19.includeInLayout");
            result[99] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule17.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule17.visible");
            result[100] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule17.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule17.includeInLayout");
            result[101] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.heroExp;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label20.text = _arg_1;
            }, "_BattleReportDetail_Label20.text");
            result[102] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label20.visible = _arg_1;
            }, "_BattleReportDetail_Label20.visible");
            result[103] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.heroExp == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label20.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label20.includeInLayout");
            result[104] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule18.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule18.visible");
            result[105] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule18.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule18.includeInLayout");
            result[106] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.support;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label21.text = _arg_1;
            }, "_BattleReportDetail_Label21.text");
            result[107] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label21.visible = _arg_1;
            }, "_BattleReportDetail_Label21.visible");
            result[108] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.support == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label21.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label21.includeInLayout");
            result[109] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule19.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule19.visible");
            result[110] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule19.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule19.includeInLayout");
            result[111] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.complaint;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label22.text = _arg_1;
            }, "_BattleReportDetail_Label22.text");
            result[112] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label22.visible = _arg_1;
            }, "_BattleReportDetail_Label22.visible");
            result[113] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.complaint == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label22.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label22.includeInLayout");
            result[114] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule20.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule20.visible");
            result[115] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule20.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule20.includeInLayout");
            result[116] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.loseHeroObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_LoseHeroUi1.loseHeroObj = _arg_1;
            }, "_BattleReportDetail_LoseHeroUi1.loseHeroObj");
            result[117] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_LoseHeroUi1.visible = _arg_1;
            }, "_BattleReportDetail_LoseHeroUi1.visible");
            result[118] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.loseHeroObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_LoseHeroUi1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_LoseHeroUi1.includeInLayout");
            result[119] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule21.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule21.visible");
            result[120] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule21.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule21.includeInLayout");
            result[121] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.obj.seizeProblem;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label23.text = _arg_1;
            }, "_BattleReportDetail_Label23.text");
            result[122] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label23.visible = _arg_1;
            }, "_BattleReportDetail_Label23.visible");
            result[123] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.seizeProblem == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label23.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label23.includeInLayout");
            result[124] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule22.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule22.visible");
            result[125] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule22.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule22.includeInLayout");
            result[126] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isSeize == true) ? Lang.msg("占领成功") : Lang.msg("占领失败"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label24.text = _arg_1;
            }, "_BattleReportDetail_Label24.text");
            result[127] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label24.visible = _arg_1;
            }, "_BattleReportDetail_Label24.visible");
            result[128] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSeize == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label24.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label24.includeInLayout");
            result[129] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule23.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule23.visible");
            result[130] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule23.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule23.includeInLayout");
            result[131] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormItem2.visible = _arg_1;
            }, "_BattleReportDetail_FormItem2.visible");
            result[132] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.lotResObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormItem2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_FormItem2.includeInLayout");
            result[133] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttack == this.obj.isAttackSuccess) ? Lang.msg("掠夺的资源") : Lang.msg("被掠夺的资源"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_FormHeading3.label = _arg_1;
            }, "_BattleReportDetail_FormHeading3.label");
            result[134] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.lotResObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_LootResourceUi1.resourceObj = _arg_1;
            }, "_BattleReportDetail_LootResourceUi1.resourceObj");
            result[135] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule25.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule25.visible");
            result[136] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule25.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule25.includeInLayout");
            result[137] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormItem3.visible = _arg_1;
            }, "_BattleReportDetail_FormItem3.visible");
            result[138] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.bakTroopObj == null) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormItem3.includeInLayout = _arg_1;
            }, "_BattleReportDetail_FormItem3.includeInLayout");
            result[139] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("部队返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_FormHeading4.label = _arg_1;
            }, "_BattleReportDetail_FormHeading4.label");
            result[140] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormHeading4.visible = _arg_1;
            }, "_BattleReportDetail_FormHeading4.visible");
            result[141] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_FormHeading4.includeInLayout = _arg_1;
            }, "_BattleReportDetail_FormHeading4.includeInLayout");
            result[142] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule26.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule26.visible");
            result[143] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.bakTroopObj.isBack);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule26.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule26.includeInLayout");
            result[144] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.bakTroopObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_BattleBackTroop1.backTroops = _arg_1;
            }, "_BattleReportDetail_BattleBackTroop1.backTroops");
            result[145] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队在返回{0}", this.startPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label25.text = _arg_1;
            }, "_BattleReportDetail_Label25.text");
            result[146] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showReturn);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label25.visible = _arg_1;
            }, "_BattleReportDetail_Label25.visible");
            result[147] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showReturn);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label25.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label25.includeInLayout");
            result[148] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isColonial);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule28.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule28.visible");
            result[149] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isColonial);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule28.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule28.includeInLayout");
            result[150] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.obj.isAttack) ? Lang.msg("首战胜利进入臣服") : Lang.msg("城池被占进入臣服"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Text1.text = _arg_1;
            }, "_BattleReportDetail_Text1.text");
            result[151] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text1.visible = _arg_1;
            }, "_BattleReportDetail_Text1.visible");
            result[152] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Text1.includeInLayout");
            result[153] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = timeText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label26.text = _arg_1;
            }, "_BattleReportDetail_Label26.text");
            result[154] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label26.visible = _arg_1;
            }, "_BattleReportDetail_Label26.visible");
            result[155] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label26.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label26.includeInLayout");
            result[156] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = colonizationText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Text2.text = _arg_1;
            }, "_BattleReportDetail_Text2.text");
            result[157] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text2.visible = _arg_1;
            }, "_BattleReportDetail_Text2.visible");
            result[158] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isColonial) && (this.obj.isAttackSuccess));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text2.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Text2.includeInLayout");
            result[159] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isSuppress);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule29.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule29.visible");
            result[160] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isSuppress);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule29.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule29.includeInLayout");
            result[161] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.coloniSuppressText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Text3.text = _arg_1;
            }, "_BattleReportDetail_Text3.text");
            result[162] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isSuppress);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text3.visible = _arg_1;
            }, "_BattleReportDetail_Text3.visible");
            result[163] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isSuppress);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text3.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Text3.includeInLayout");
            result[164] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("殖民关系中止战争结束");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label27.text = _arg_1;
            }, "_BattleReportDetail_Label27.text");
            result[165] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSuppress) && (!(this.obj.isAttackSuccess)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label27.visible = _arg_1;
            }, "_BattleReportDetail_Label27.visible");
            result[166] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isSuppress) && (!(this.obj.isAttackSuccess)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label27.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label27.includeInLayout");
            result[167] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isUprising);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule30.visible = _arg_1;
            }, "_BattleReportDetail_MyHRule30.visible");
            result[168] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isUprising);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_MyHRule30.includeInLayout = _arg_1;
            }, "_BattleReportDetail_MyHRule30.includeInLayout");
            result[169] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.upriseSuppressText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Text4.text = _arg_1;
            }, "_BattleReportDetail_Text4.text");
            result[170] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isUprising);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text4.visible = _arg_1;
            }, "_BattleReportDetail_Text4.visible");
            result[171] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.obj.isUprising);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Text4.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Text4.includeInLayout");
            result[172] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("殖民关系中止战争结束");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _BattleReportDetail_Label28.text = _arg_1;
            }, "_BattleReportDetail_Label28.text");
            result[173] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isUprising) && (!(this.obj.isAttackSuccess)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label28.visible = _arg_1;
            }, "_BattleReportDetail_Label28.visible");
            result[174] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.obj.isUprising) && (!(this.obj.isAttackSuccess)));
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_Label28.includeInLayout = _arg_1;
            }, "_BattleReportDetail_Label28.includeInLayout");
            result[175] = binding;
            binding = new Binding(this, function ():ObjectProxy
            {
                return (this.autoHealObj);
            }, function (_arg_1:ObjectProxy):void
            {
                _BattleReportDetail_AutoHealReportDetail1.xmlObj = _arg_1;
            }, "_BattleReportDetail_AutoHealReportDetail1.xmlObj");
            result[176] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_AutoHealReportDetail1.visible = _arg_1;
            }, "_BattleReportDetail_AutoHealReportDetail1.visible");
            result[177] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.autoHealObj);
            }, function (_arg_1:Boolean):void
            {
                _BattleReportDetail_AutoHealReportDetail1.includeInLayout = _arg_1;
            }, "_BattleReportDetail_AutoHealReportDetail1.includeInLayout");
            result[178] = binding;
            return (result);
        }

        private function set colonizationText(_arg_1:String):void
        {
            var _local_2:Object = this._1729329906colonizationText;
            if (_local_2 !== _arg_1)
            {
                this._1729329906colonizationText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonizationText", _local_2, _arg_1));
            };
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


    }
}//package view.module.info.reports

