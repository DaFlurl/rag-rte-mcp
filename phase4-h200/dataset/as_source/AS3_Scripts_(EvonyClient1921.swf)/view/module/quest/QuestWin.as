// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.QuestWin

package view.module.quest
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.ComboBox;
    import com.evony.common.beans.QuestBean;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import mx.containers.ViewStack;
    import mx.controls.TextInput;
    import mx.controls.List;
    import mx.controls.Image;
    import mx.controls.ToggleButtonBar;
    import mx.containers.Canvas;
    import mx.controls.Button;
    import view.module.guide.GuideArrow;
    import com.evony.util.EvonyImage;
    import mx.containers.HBox;
    import mx.controls.Label;
    import com.evony.common.beans.CommissionQuestBean;
    import mx.controls.Text;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.QuestTypeBean;
    import mx.core.UIComponentDescriptor;
    import view.ui.MyHRule;
    import flash.utils.Timer;
    import flash.net.SharedObject;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import mx.events.FlexEvent;
    import com.evony.events.HasQuestEvent;
    import com.evony.common.module.quest.QuestTypeResponse;
    import flash.events.MouseEvent;
    import com.evony.Coordinate;
    import view.MainWin;
    import com.evony.common.module.commission.CommissionQuestRespone;
    import mx.events.PropertyChangeEvent;
    import mx.collections.SortField;
    import mx.collections.Sort;
    import com.evony.common.module.CommandResponse;
    import mx.binding.BindingManager;
    import com.evony.common.constants.CommonConstants;
    import mx.events.ListEvent;
    import view.questWizard.Questwizard;
    import mx.events.ItemClickEvent;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.TimerEvent;
    import mx.core.ClassFactory;
    import mx.core.BitmapAsset;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import view.AllWindows;
    import flash.utils.setTimeout;
    import com.evony.common.beans.QuestTargetBean;
    import view.module.guide.GuideStep;
    import com.evony.common.module.quest.QuestListResponse;
    import view.ui.AlertWin;
    import com.evony.data.FbData;
    import view.ui.FacebookNoticeWin;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.PlayerBean;
    import com.evony.common.server.events.NewFinishedQuest;
    import mx.utils.StringUtil;
    import view.castle.TownView;
    import flash.events.Event;
    import view.module.playerInfo.AwardShowWin;
    import com.evony.common.module.shop.UseItemResultResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.commission.CommissionQuestArmyRespone;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import com.evony.common.beans.*;
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

    public class QuestWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "QuestWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1781897444questtype:ComboBox;
        private var _545394306curQuest:QuestBean;
        public var _QuestWin_DataGridColumn1:DataGridColumn;
        public var _QuestWin_DataGridColumn2:DataGridColumn;
        public var _QuestWin_DataGridColumn3:DataGridColumn;
        public var _QuestWin_DataGridColumn4:DataGridColumn;
        public var _QuestWin_DataGridColumn5:DataGridColumn;
        public var _QuestWin_DataGridColumn7:DataGridColumn;
        public var _QuestWin_DataGridColumn8:DataGridColumn;
        public var _QuestWin_DataGridColumn9:DataGridColumn;
        private var _2048592632showDigiBtn:Boolean = false;
        public var _QuestWin_DataGrid1:DataGrid;
        public var _QuestWin_DataGrid2:DataGrid;
        private var _880905839target:ComboBox;
        private var _153085257myViewstack:ViewStack;
        private var _104079552money:TextInput;
        public var _QuestWin_List1:List;
        private var BigPoint:Class;
        private var _1746226814iFinishCount1:int = 0;
        private var _1660440092digiImg:Image;
        public var _QuestWin_DataGridColumn10:DataGridColumn;
        public var _QuestWin_DataGridColumn11:DataGridColumn;
        public var _QuestWin_DataGridColumn13:DataGridColumn;
        public var _QuestWin_DataGridColumn14:DataGridColumn;
        private var _2024405605showFavotiteBtn:Boolean = false;
        private var curSelectParentQuestIndex:int = 0;
        private var jobDone:int;
        private var _1117186164SmallpointTop:int = 350;
        private var SmallPoint:Class;
        private var _2097343884btnStack:ViewStack;
        private var _1341206824questTypeTBB:ToggleButtonBar;
        private var _625641193showDelTaskBtn:Boolean = false;
        private var _84842905questTypeInfoVs:Canvas;
        private var _1328205377questContainer:Canvas;
        private var _655126789questDg:DataGrid;
        public var _QuestWin_Button10:Button;
        public var _QuestWin_Button11:Button;
        private var _1069616830questDetail1:GuideArrow;
        private var _7663145NewshowDecBtn:Boolean = false;
        private var _3446917posY:int;
        private var curSelectQuestTypeIndex:int = 0;
        private var curSelectSubQuestIndex:int = 0;
        private var _2027803128showArmyList:Boolean = false;
        public var _QuestWin_EvonyImage1:EvonyImage;
        public var _QuestWin_EvonyImage2:EvonyImage;
        public var _QuestWin_EvonyImage3:EvonyImage;
        public var _QuestWin_HBox3:HBox;
        public var _QuestWin_Label1:Label;
        public var _QuestWin_Label2:Label;
        public var _QuestWin_Label3:Label;
        public var _QuestWin_Label4:Label;
        public var _QuestWin_Label5:Label;
        public var _QuestWin_Label6:Label;
        public var _QuestWin_Label7:Label;
        public var _QuestWin_Label8:Label;
        private var _1658593671curQuestTypeName:String = "";
        private var _603467556commBean:CommissionQuestBean;
        public var _QuestWin_Text1:Text;
        public var _QuestWin_Text2:Text;
        public var _QuestWin_Text3:Text;
        public var _QuestWin_Text5:Text;
        public var _QuestWin_Text6:Text;
        private var _3446916posX:int;
        public var _QuestWin_Text4:Text;
        public var _QuestWin_Button2:Button;
        public var _QuestWin_Button3:Button;
        public var _QuestWin_Button5:Button;
        public var _QuestWin_Button6:Button;
        public var _QuestWin_Button7:Button;
        public var _QuestWin_Button8:Button;
        public var _QuestWin_Button9:Button;
        public var _QuestWin_Button4:Button;
        public var _QuestWin_Button1:Button;
        private var _892629391AllTaskListInfoVs:VBox;
        private var _1746226815iFinishCount2:int = 0;
        private var _1069616832questDetail3:GuideArrow;
        private var _1537267268taskCom:ComboBox;
        private var _1783104352questList:ArrayCollection;
        private var _1471129131showHeroList:Boolean = false;
        private var _126677407myCommArray:ArrayCollection;
        private var _127936104hasQuest:Boolean = false;
        private var _339329111showDecBtn:Boolean = false;
        public var _QuestWin_Label11:Label;
        public var _QuestWin_Label12:Label;
        public var _QuestWin_Label13:Label;
        public var _QuestWin_Label15:Label;
        public var _QuestWin_Label17:Label;
        public var _QuestWin_Label18:Label;
        public var _QuestWin_Label19:Label;
        private var _1483107973BigpointTop:int = 380;
        public var _QuestWin_Label20:Label;
        private var _909756138strPicUrl:String = "";
        private var AllQuestArray:ArrayCollection;
        private var _918137798showDigiBtn2:Boolean = false;
        public var _QuestWin_Array3:Array;
        private var _482839393closeHint:GuideArrow;
        private var _1579605898typeNewBtn:HBox;
        private var _1528145235commArray:ArrayCollection;
        private var _764623491xcoord:TextInput;
        private var _735994340ycoord:TextInput;
        private var _425636739questTypeArray:ArrayCollection;
        private var _242116564publicInfoVs:VBox;
        private var isFirstLogin:Boolean = true;
        private var _826490203subQuestDg:DataGrid;
        private var curPosition:String;
        private var _1276648794btnStackIndex:int = 0;
        private var _1476876850TaskListInfoVs:VBox;
        private var _47009677questInfoVs:VBox;
        private var _602210084curQuestType:QuestTypeBean;
        private var _1746226816iFinishCount3:int = 0;
        private var _1545078129typeOldBtn:HBox;
        private var _1069616831questDetail2:GuideArrow;
        private var _410168125taskSort:ComboBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"questContainer",
                        "stylesFactory":function ():void
                        {
                            this.top = "90";
                            this.bottom = "16";
                            this.right = "14";
                            this.left = "260";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"myViewstack",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "x":0,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"questTypeInfoVs",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":98,
                                                                    "y":30
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "y":35,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"questInfoVs",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "left";
                                                                this.left = "5";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_QuestWin_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "styleName":"contentheader1"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "id":"_QuestWin_EvonyImage1",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "source":"images/icon/Age2Quest.png",
                                                                                "width":43,
                                                                                "height":20
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"ParamgraphText1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_QuestWin_Button1",
                                                                        "events":{"click":"___QuestWin_Button1_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "5";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"b95"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "id":"_QuestWin_HBox3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":List,
                                                                        "id":"_QuestWin_List1",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selectable":false,
                                                                                "styleName":"listNotShowBG",
                                                                                "itemRenderer":_QuestWin_ClassFactory1_c()
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_QuestWin_Button2",
                                                                        "events":{"click":"___QuestWin_Button2_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Donate",
                                                                                "styleName":"b95"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text4",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Scan in the QR code, and you will be able to complete the quest.",
                                                                    "maxWidth":502,
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"digiImg",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalCenter = "0";
                                                                this.horizontalAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":500});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"PropertyValue1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ViewStack,
                                                            "id":"btnStack",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "id":"typeOldBtn",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 2;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button3",
                                                                                    "events":{"click":"___QuestWin_Button3_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"b95"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button4",
                                                                                    "events":{"click":"___QuestWin_Button4_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "label":"Complete and Share",
                                                                                            "styleName":"b95"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button5",
                                                                                    "events":{"click":"___QuestWin_Button5_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"b95"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button6",
                                                                                    "events":{"click":"___QuestWin_Button6_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "label":"Donate",
                                                                                            "styleName":"b95"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "id":"typeNewBtn",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalGap = 2;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button7",
                                                                                    "events":{"click":"___QuestWin_Button7_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "styleName":"b96",
                                                                                            "width":128,
                                                                                            "height":39
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button8",
                                                                                    "events":{"click":"___QuestWin_Button8_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "styleName":"b97",
                                                                                            "width":89,
                                                                                            "height":25
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button9",
                                                                                    "events":{"click":"___QuestWin_Button9_click"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.bottom = "5";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"b95"});
                                                                                    }
                                                                                })]
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
                                                                    "percentWidth":95,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_QuestWin_Button10",
                                                                        "events":{"click":"___QuestWin_Button10_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.bottom = "5";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"b95"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"publicInfoVs",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestWin_Text6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"ParamgraphText1",
                                                                    "selectable":false
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingTop = 10;
                                                                this.verticalGap = 5;
                                                                this.horizontalAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_QuestWin_Label8",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":30,
                                                                                            "styleName":"contentheader1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "text":"X",
                                                                                            "styleName":"contentheader1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":TextInput,
                                                                                    "id":"xcoord",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":40,
                                                                                            "height":20,
                                                                                            "maxChars":3,
                                                                                            "styleName":"textInput"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "text":"Y",
                                                                                            "styleName":"contentheader1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":TextInput,
                                                                                    "id":"ycoord",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":40,
                                                                                            "height":20,
                                                                                            "maxChars":3,
                                                                                            "styleName":"textInput"
                                                                                        });
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_QuestWin_Label11",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":30,
                                                                                            "styleName":"contentheader1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":ComboBox,
                                                                                    "id":"questtype",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"width":200});
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "includeInLayout":false,
                                                                                "visible":false,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_QuestWin_Label12",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"contentheader1"});
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":ComboBox,
                                                                                    "id":"target",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.fontWeight = "normal";
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"width":200});
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_QuestWin_Label13",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "width":160,
                                                                                            "styleName":"contentheader1"
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":TextInput,
                                                                                    "id":"money",
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "text":"0",
                                                                                            "width":80,
                                                                                            "height":20,
                                                                                            "styleName":"textInput",
                                                                                            "restrict":"0-9",
                                                                                            "maxChars":4
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.textAlign = "left";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "text":"Cents",
                                                                                            "styleName":"contentheader1"
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
                                                                                "percentWidth":95,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Button,
                                                                                    "id":"_QuestWin_Button11",
                                                                                    "events":{"click":"___QuestWin_Button11_click"},
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"b95"});
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
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"TaskListInfoVs",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestWin_Label15",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_QuestWin_DataGrid1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "none";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":400,
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "styleName":"style2",
                                                                    "columns":[_QuestWin_DataGridColumn1_i(), _QuestWin_DataGridColumn2_i(), _QuestWin_DataGridColumn3_i(), _QuestWin_DataGridColumn4_i(), _QuestWin_DataGridColumn5_i(), _QuestWin_DataGridColumn6_c()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "id":"AllTaskListInfoVs",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":95,
                                                                    "text":"Commission Quest List",
                                                                    "styleName":"contentheader1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":MyHRule,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.strokeWidth = 1;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":95});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_QuestWin_Label17",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.top = "5";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyName1"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"taskCom",
                                                                        "events":{"change":"__taskCom_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "110";
                                                                            this.fontWeight = "normal";
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ComboBox",
                                                                                "height":28
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_QuestWin_Label18",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.left = "270";
                                                                            this.top = "5";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"PropertyName1"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"taskSort",
                                                                        "events":{"change":"__taskSort_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.left = "310";
                                                                            this.fontWeight = "normal";
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"ComboBox",
                                                                                "height":28,
                                                                                "width":140
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_QuestWin_DataGrid2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "none";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":376,
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "styleName":"style2",
                                                                    "columns":[_QuestWin_DataGridColumn7_i(), _QuestWin_DataGridColumn8_i(), _QuestWin_DataGridColumn9_i(), _QuestWin_DataGridColumn10_i(), _QuestWin_DataGridColumn11_i(), _QuestWin_DataGridColumn12_c()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"questTypeTBB",
                        "events":{"itemClick":"__questTypeTBB_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "62";
                            this.left = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":29,
                                "width":485,
                                "dataProvider":_QuestWin_Array3_i()
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "54";
                            this.left = "139";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_QuestWin_EvonyImage2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@redInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_QuestWin_Label19",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "17";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "54";
                            this.left = "307";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_QuestWin_EvonyImage3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "source":"fla/dynamic/ui234.swf@redInfoAmount.png",
                                            "alpha":0.5
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_QuestWin_Label20",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "17";
                                        this.top = "8";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "90";
                            this.verticalGap = 5;
                            this.bottom = "36";
                            this.left = "34";
                            this.right = "563";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"tabwk",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "1";
                                                    this.top = "1";
                                                    this.bottom = "1";
                                                    this.right = "1";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"tabnk",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"questDg",
                                                            "events":{"itemClick":"__questDg_itemClick"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "none";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "styleName":"style2",
                                                                    "showHeaders":false,
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "columns":[_QuestWin_DataGridColumn13_i()]
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":154,
                                            "styleName":"tabwk",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "1";
                                                    this.right = "1";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "styleName":"tabnk",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"subQuestDg",
                                                            "events":{"itemClick":"__subQuestDg_itemClick"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "none";
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "styleName":"style2",
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "columns":[_QuestWin_DataGridColumn14_i()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"questDetail1",
                        "stylesFactory":function ():void
                        {
                            this.top = "350";
                            this.left = "380";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "type":"questDetail1",
                                "includeInLayout":false,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"questDetail3",
                        "stylesFactory":function ():void
                        {
                            this.top = "350";
                            this.left = "380";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "type":"questDetail3",
                                "includeInLayout":false,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"questDetail2",
                        "stylesFactory":function ():void
                        {
                            this.top = "206";
                            this.left = "683";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "type":"questDetail2",
                                "includeInLayout":false,
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"closeHint",
                        "stylesFactory":function ():void
                        {
                            this.top = "20";
                            this.right = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "type":"arrowTGuide",
                                "visible":false
                            });
                        }
                    })]});
            }
        });
        private var RoutinQuestArray:ArrayCollection = new ArrayCollection();
        private var DailyQuestArray:ArrayCollection = new ArrayCollection();
        private var HeroQuestArray:ArrayCollection = new ArrayCollection();
        private var refreshTimer:Timer = new Timer((1000 * 180), 0);
        private var addFavoriteCookie:SharedObject = SharedObject.getLocal("addFavorite");
        private var FinishedIcon:Class = QuestWin_FinishedIcon;
        private var UnfinishedIcon:Class = QuestWin_UnfinishedIcon;
        private var eachTargetArray1:ArrayCollection = new ArrayCollection([{
            "name":Lang.msg("日常任务领取描述"),
            "finished":null
        }]);
        private var eachTargetArray2:ArrayCollection = new ArrayCollection([{
            "name":Lang.msg("所在联盟有成员拥有名城"),
            "finished":null
        }]);
        private var _1207875353testArray:ArrayCollection = new ArrayCollection([{"name":"所在联盟有成员日常任务领取描述"}]);
        private var _488358570curDailyTarget:ArrayCollection = eachTargetArray1;
        private var newCommission:ArrayCollection = new ArrayCollection([{
            "name":Lang.msg("更多任务"),
            "isFinish":false
        }, {
            "name":Lang.msg("发布委托"),
            "isFinish":false
        }, {
            "name":Lang.msg("我的委托"),
            "isFinish":false
        }]);
        private var _2017594025taskTypeData:Array = new Array({
            "label":Lang.msg("协助反殖民"),
            "data":1
        });
        private var _917691967filterArray:Array = new Array({
            "label":"Normal",
            "data":0
        }, {
            "label":Lang.msg("协助反殖民"),
            "data":1
        }, {
            "label":"Other",
            "data":2
        });
        private var _39690405sortArray:Array = new Array({
            "label":"Location",
            "data":0
        }, {
            "label":"Reward",
            "data":1
        }, {
            "label":"Remaining Time",
            "data":2
        });
        private var _1421733719cityList:Array = new Array({
            "label":"--",
            "data":0
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function QuestWin()
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
            this.addEventListener("creationComplete", ___QuestWin_BaseFunctionWindowEx1_creationComplete);
            this.addEventListener("removedFromStage", ___QuestWin_BaseFunctionWindowEx1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            QuestWin._watcherSetupUtil = _arg_1;
        }


        override public function destroy():void
        {
        }

        public function taskTimeOut():void
        {
            if (myViewstack.selectedChild == AllTaskListInfoVs)
            {
                ActionFactory.getInstance().getCommissionQuestCommands().getAllCommissionQuest();
            }
            else
            {
                if (myViewstack.selectedChild == TaskListInfoVs)
                {
                    ActionFactory.getInstance().getCommissionQuestCommands().getMyCommissionQuest();
                };
            };
        }

        private function refreshQuestList():void
        {
            if (this.curQuestType != null)
            {
                ActionFactory.getInstance().getQuestCommands().getQuestList(Context.getInstance().getCurCastle().id, curQuestType.typeId);
            }
            else
            {
                this.myViewstack.selectedChild = this.questInfoVs;
            };
        }

        public function acceptCommission(_arg_1:Object):void
        {
            var _local_2:Array = setXYArray(_arg_1.position);
            AddArmyWin.show(_arg_1.id, _local_2[0], _local_2[1]);
        }

        public function ___QuestWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onQuestType(_arg_1:QuestTypeResponse):void
        {
            var _local_4:String;
            var _local_5:int;
            var _local_6:Boolean;
            var _local_7:QuestTypeBean;
            if (_arg_1.typesArray.length == 0)
            {
                if (!isFirstLogin)
                {
                    questContainer.visible = false;
                };
                return;
            };
            questContainer.visible = true;
            var _local_2:ArrayCollection = _arg_1.typesArray;
            if (_local_2.length == 0)
            {
                if (this.questTypeTBB.selectedIndex == 1)
                {
                    this.questTypeArray = _arg_1.typesArray;
                    this.questList = null;
                    this.hasQuest = false;
                };
                return;
            };
            var _local_3:int = QuestTypeBean(_local_2[0]).mainId;
            if (_local_3 == 1)
            {
                this.RoutinQuestArray = _arg_1.typesArray;
                _local_4 = QuestTypeBean(_local_2[0]).name;
                if (_local_4.indexOf("Play Evony on Mobile") != -1)
                {
                    Context.getInstance().iDigiTypeId = QuestTypeBean(_local_2[0]).typeId;
                };
            }
            else
            {
                if (_local_3 == 4)
                {
                    this.HeroQuestArray = _arg_1.typesArray;
                };
            };
            this.AllQuestArray = new ArrayCollection(this.RoutinQuestArray.toArray());
            iFinishCount1 = countDoneValue(AllQuestArray);
            if (this.HeroQuestArray.length > 0)
            {
                _local_5 = 0;
                while (_local_5 < HeroQuestArray.length)
                {
                    this.AllQuestArray.addItem(HeroQuestArray[_local_5]);
                    _local_5++;
                };
            };
            iFinishCount3 = countDoneValue(AllQuestArray);
            iFinishCount3 = (iFinishCount3 - iFinishCount1);
            if (this.AllQuestArray.length > 0)
            {
                countDoneValue(AllQuestArray);
                if (this.jobDone > 0)
                {
                    this.dispatchEvent(new HasQuestEvent(HasQuestEvent.HAS_QUEST, true, this.jobDone));
                }
                else
                {
                    this.dispatchEvent(new HasQuestEvent(HasQuestEvent.HAS_QUEST, false, 0));
                };
            };
            if ((((questTypeTBB.selectedIndex == 0) && (_local_3 == 1)) || ((questTypeTBB.selectedIndex == 1) && (_local_3 == 4))))
            {
                this.questTypeArray = _arg_1.typesArray;
                if (this.questTypeArray.length > 0)
                {
                    if (this.curQuestType == null)
                    {
                        this.curQuestType = (this.questTypeArray[0] as QuestTypeBean);
                        this.subQuestDg.selectedIndex = 0;
                        this.myViewstack.selectedChild = this.questInfoVs;
                    }
                    else
                    {
                        _local_6 = false;
                        for each (_local_7 in this.questTypeArray)
                        {
                            if (_local_7.typeId == this.curQuestType.typeId)
                            {
                                _local_6 = true;
                                break;
                            };
                        };
                        if (!_local_6)
                        {
                            this.curQuestType = (this.questTypeArray[0] as QuestTypeBean);
                            this.questDg.selectedIndex = 0;
                            this.myViewstack.selectedChild = this.questInfoVs;
                        }
                        else
                        {
                            this.questDg.selectedIndex = curSelectQuestTypeIndex;
                            this.questDg.scrollToIndex(curSelectQuestTypeIndex);
                            this.questDg.verticalScrollPosition = Math.ceil((curSelectQuestTypeIndex * (this.questDg.maxVerticalScrollPosition / questTypeArray.length)));
                        };
                    };
                    this.refreshQuestList();
                    this.hasQuest = true;
                    this.curQuestTypeName = this.curQuestType.name;
                }
                else
                {
                    this.hasQuest = false;
                    this.curQuestTypeName = "";
                    this.questList = null;
                    this.questTypeArray = null;
                    this.curQuest = null;
                };
            };
            if (this.questTypeTBB.selectedIndex == 2)
            {
                this.curQuestTypeName = "The Hunt-Down";
            };
            if (((Context.getInstance().needUserGuide) && (_local_3 == 1)))
            {
                guideQuest();
            };
            this.showDecBtn = false;
            this.showDelTaskBtn = false;
        }

        public function ___QuestWin_Button6_click(_arg_1:MouseEvent):void
        {
            DeclineTask();
        }

        private function getMyCommResponse(_arg_1:CommissionQuestRespone):void
        {
            var _local_4:QuestBean;
            var _local_5:Coordinate;
            questContainer.visible = true;
            this.questTypeArray = _arg_1.commissionQuestBeanArray;
            var _local_2:int = this.newCommission.length;
            this.questList = new ArrayCollection();
            var _local_3:int;
            while (_local_3 < _local_2)
            {
                _local_4 = new QuestBean();
                _local_4.name = this.newCommission[_local_3].name;
                _local_4.isFinish = false;
                this.questList.addItem(_local_4);
                _local_3++;
            };
            if (this.questTypeArray.length == 0)
            {
                this.subQuestDg.selectedIndex = 0;
                ActionFactory.getInstance().getCommissionQuestCommands().getAllCommissionQuest();
                this.myViewstack.selectedChild = this.AllTaskListInfoVs;
            }
            else
            {
                questDg.selectedIndex = 0;
                setAntiColonyDetail(this.questTypeArray[0]);
            };
            showDelTaskBtn = true;
            showArmyList = true;
            if (MainWin.instance.issueQuestPos != 0)
            {
                _local_5 = new Coordinate(MainWin.instance.issueQuestPos);
                posX = _local_5.x;
                posY = _local_5.y;
                MainWin.instance.issueQuestPos = 0;
                this.myViewstack.selectedChild = this.publicInfoVs;
                this.questDg.selectedIndex = -1;
            };
        }

        public function set digiImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1660440092digiImg;
            if (_local_2 !== _arg_1)
            {
                this._1660440092digiImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "digiImg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get showDigiBtn2():Boolean
        {
            return (this._918137798showDigiBtn2);
        }

        public function set ycoord(_arg_1:TextInput):void
        {
            var _local_2:Object = this._735994340ycoord;
            if (_local_2 !== _arg_1)
            {
                this._735994340ycoord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ycoord", _local_2, _arg_1));
            };
        }

        private function sortTask():void
        {
            var _local_1:SortField = new SortField();
            switch (taskSort.selectedItem.data)
            {
                case 0:
                    _local_1.name = "position";
                    break;
                case 1:
                    _local_1.name = "reward";
                    _local_1.descending = true;
                    break;
                case 2:
                    _local_1.name = "timeout";
                    _local_1.descending = true;
                    break;
            };
            _local_1.numeric = true;
            var _local_2:Sort = new Sort();
            _local_2.fields = [_local_1];
            commArray.sort = _local_2;
            commArray.refresh();
        }

        [Bindable(event="propertyChange")]
        private function get showDecBtn():Boolean
        {
            return (this._339329111showDecBtn);
        }

        private function set showDigiBtn2(_arg_1:Boolean):void
        {
            var _local_2:Object = this._918137798showDigiBtn2;
            if (_local_2 !== _arg_1)
            {
                this._918137798showDigiBtn2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showDigiBtn2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get typeNewBtn():HBox
        {
            return (this._1579605898typeNewBtn);
        }

        [Bindable(event="propertyChange")]
        private function get questTypeArray():ArrayCollection
        {
            return (this._425636739questTypeArray);
        }

        [Bindable(event="propertyChange")]
        private function get posX():int
        {
            return (this._3446916posX);
        }

        [Bindable(event="propertyChange")]
        private function get posY():int
        {
            return (this._3446917posY);
        }

        public function ___QuestWin_Button10_click(_arg_1:MouseEvent):void
        {
            ArmyListShow();
        }

        private function addfavoriteResponse(_arg_1:CommandResponse):void
        {
            refresh();
        }

        [Bindable(event="propertyChange")]
        public function get closeHint():GuideArrow
        {
            return (this._482839393closeHint);
        }

        [Bindable(event="propertyChange")]
        private function get questList():ArrayCollection
        {
            return (this._1783104352questList);
        }

        [Bindable(event="propertyChange")]
        private function get cityList():Array
        {
            return (this._1421733719cityList);
        }

        private function onAllow():void
        {
            ActionFactory.getInstance().getQuestCommands().AllowRegister(onResponse);
        }

        private function set showDecBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._339329111showDecBtn;
            if (_local_2 !== _arg_1)
            {
                this._339329111showDecBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showDecBtn", _local_2, _arg_1));
            };
        }

        private function onTimeOutClose():void
        {
            closeHint.visible = true;
        }

        [Bindable(event="propertyChange")]
        public function get money():TextInput
        {
            return (this._104079552money);
        }

        private function set myCommArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._126677407myCommArray;
            if (_local_2 !== _arg_1)
            {
                this._126677407myCommArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myCommArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get taskSort():ComboBox
        {
            return (this._410168125taskSort);
        }

        public function set questTypeInfoVs(_arg_1:Canvas):void
        {
            var _local_2:Object = this._84842905questTypeInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._84842905questTypeInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeInfoVs", _local_2, _arg_1));
            };
        }

        private function set hasQuest(_arg_1:Boolean):void
        {
            var _local_2:Object = this._127936104hasQuest;
            if (_local_2 !== _arg_1)
            {
                this._127936104hasQuest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasQuest", _local_2, _arg_1));
            };
        }

        private function set showFavotiteBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2024405605showFavotiteBtn;
            if (_local_2 !== _arg_1)
            {
                this._2024405605showFavotiteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showFavotiteBtn", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn9_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn9 = _local_1;
            _local_1.dataField = "target";
            _local_1.width = 105;
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn9", _QuestWin_DataGridColumn9);
            return (_local_1);
        }

        private function issue():void
        {
            ActionFactory.getInstance().getCommissionQuestCommands().issueCommissionQuest(Context.getInstance().getCurCastle().id, CommonConstants.COMMISSION_QUEST_TYPE_COLONY, int(xcoord.text), int(ycoord.text), int(money.text));
        }

        [Bindable(event="propertyChange")]
        private function get curQuestType():QuestTypeBean
        {
            return (this._602210084curQuestType);
        }

        private function getAllCommissionQuestHandler(_arg_1:CommissionQuestRespone):void
        {
            this.commArray = _arg_1.commissionQuestBeanArray;
        }

        private function _QuestWin_DataGridColumn14_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn14 = _local_1;
            _local_1.itemRenderer = _QuestWin_ClassFactory8_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn14", _QuestWin_DataGridColumn14);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get commBean():CommissionQuestBean
        {
            return (this._603467556commBean);
        }

        public function ___QuestWin_Button5_click(_arg_1:MouseEvent):void
        {
            deleteTask();
        }

        public function set typeNewBtn(_arg_1:HBox):void
        {
            var _local_2:Object = this._1579605898typeNewBtn;
            if (_local_2 !== _arg_1)
            {
                this._1579605898typeNewBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeNewBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get testArray():ArrayCollection
        {
            return (this._1207875353testArray);
        }

        private function set questTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._425636739questTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._425636739questTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeArray", _local_2, _arg_1));
            };
        }

        public function __subQuestDg_itemClick(_arg_1:ListEvent):void
        {
            onQuestChange(_arg_1);
        }

        private function set iFinishCount1(_arg_1:int):void
        {
            var _local_2:Object = this._1746226814iFinishCount1;
            if (_local_2 !== _arg_1)
            {
                this._1746226814iFinishCount1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iFinishCount1", _local_2, _arg_1));
            };
        }

        private function set iFinishCount2(_arg_1:int):void
        {
            var _local_2:Object = this._1746226815iFinishCount2;
            if (_local_2 !== _arg_1)
            {
                this._1746226815iFinishCount2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iFinishCount2", _local_2, _arg_1));
            };
        }

        private function set curQuest(_arg_1:QuestBean):void
        {
            var _local_2:Object = this._545394306curQuest;
            if (_local_2 !== _arg_1)
            {
                this._545394306curQuest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuest", _local_2, _arg_1));
            };
        }

        private function onQuestClick(_arg_1:ItemClickEvent):void
        {
            isFirstLogin = false;
            showDelTaskBtn = false;
            showDecBtn = false;
            showArmyList = false;
            this.curQuestTypeName = "";
            this.questList = null;
            this.questTypeArray = null;
            this.posX = 0;
            this.posY = 0;
            this.myViewstack.selectedChild = this.questInfoVs;
            switch (_arg_1.index)
            {
                case 0:
                    Questwizard.instance.bopen = true;
                    this.showHeroList = false;
                    ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 1);
                    break;
                case 1:
                    this.showHeroList = true;
                    Questwizard.instance.bopen = false;
                    ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 4);
                    break;
                case 2:
                    this.showHeroList = false;
                    Questwizard.instance.bopen = false;
                    ActionFactory.getInstance().getCommissionQuestCommands().getMyAcceptedCommissionQuest(getMyCommResponse);
                    break;
            };
            this.curSelectQuestTypeIndex = 0;
        }

        private function set iFinishCount3(_arg_1:int):void
        {
            var _local_2:Object = this._1746226816iFinishCount3;
            if (_local_2 !== _arg_1)
            {
                this._1746226816iFinishCount3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iFinishCount3", _local_2, _arg_1));
            };
        }

        private function set posX(_arg_1:int):void
        {
            var _local_2:Object = this._3446916posX;
            if (_local_2 !== _arg_1)
            {
                this._3446916posX = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "posX", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get questDg():DataGrid
        {
            return (this._655126789questDg);
        }

        private function set posY(_arg_1:int):void
        {
            var _local_2:Object = this._3446917posY;
            if (_local_2 !== _arg_1)
            {
                this._3446917posY = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "posY", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.NewshowDecBtn = true;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_TYPE, onQuestType);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_GET_QUEST_LIST, onQuestList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_AWARD, onAwardResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.QUEST_ABANDON, onAwardResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_NEW_FINISHED_QUEST, onNewFinishedQuest);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMISSION_GET_ALL_COMMISSION_QUEST, getAllCommissionQuestHandler);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMISSION_GET_MY_COMMISSION_QUEST, MyCommission);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMISSION_ISSUE_COMMISSION_QUEST, OnIssue);
            refreshTimer.addEventListener(TimerEvent.TIMER, onTimesRequest);
            refreshTimer.start();
            this.refresh();
        }

        private function set BigpointTop(_arg_1:int):void
        {
            var _local_2:Object = this._1483107973BigpointTop;
            if (_local_2 !== _arg_1)
            {
                this._1483107973BigpointTop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "BigpointTop", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn8 = _local_1;
            _local_1.dataField = "type";
            _local_1.itemRenderer = _QuestWin_ClassFactory4_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn8", _QuestWin_DataGridColumn8);
            return (_local_1);
        }

        public function set typeOldBtn(_arg_1:HBox):void
        {
            var _local_2:Object = this._1545078129typeOldBtn;
            if (_local_2 !== _arg_1)
            {
                this._1545078129typeOldBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeOldBtn", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn13_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn13 = _local_1;
            _local_1.dataField = "name";
            _local_1.itemRenderer = _QuestWin_ClassFactory7_c();
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn13", _QuestWin_DataGridColumn13);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get strPicUrl():String
        {
            return (this._909756138strPicUrl);
        }

        private function _QuestWin_ClassFactory8_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent8;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function setXYArray(_arg_1:String):Array
        {
            var _local_2:Array;
            return (_arg_1.split(","));
        }

        public function onCreationComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
            };
        }

        private function addfavorite():void
        {
            ActionFactory.getInstance().getCommonCommands().addToFavorites(addfavoriteResponse);
            if (ExternalInterface.available)
            {
                ExternalInterface.call("addFavorite", "Evony game", GameConfig.instance.homePage);
            };
        }

        public function set closeHint(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._482839393closeHint;
            if (_local_2 !== _arg_1)
            {
                this._482839393closeHint = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeHint", _local_2, _arg_1));
            };
        }

        private function set questList(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1783104352questList;
            if (_local_2 !== _arg_1)
            {
                this._1783104352questList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questList", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn12_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "";
            _local_1.dataField = "id";
            _local_1.width = 65;
            _local_1.itemRenderer = _QuestWin_ClassFactory6_c();
            _local_1.setStyle("textAlign", "left");
            return (_local_1);
        }

        private function set taskTypeData(_arg_1:Array):void
        {
            var _local_2:Object = this._2017594025taskTypeData;
            if (_local_2 !== _arg_1)
            {
                this._2017594025taskTypeData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taskTypeData", _local_2, _arg_1));
            };
        }

        private function set btnStackIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1276648794btnStackIndex;
            if (_local_2 !== _arg_1)
            {
                this._1276648794btnStackIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnStackIndex", _local_2, _arg_1));
            };
        }

        private function set curDailyTarget(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._488358570curDailyTarget;
            if (_local_2 !== _arg_1)
            {
                this._488358570curDailyTarget = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curDailyTarget", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn7 = _local_1;
            _local_1.dataField = "position";
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn7", _QuestWin_DataGridColumn7);
            return (_local_1);
        }

        private function set commArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1528145235commArray;
            if (_local_2 !== _arg_1)
            {
                this._1528145235commArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commArray", _local_2, _arg_1));
            };
        }

        private function set cityList(_arg_1:Array):void
        {
            var _local_2:Object = this._1421733719cityList;
            if (_local_2 !== _arg_1)
            {
                this._1421733719cityList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityList", _local_2, _arg_1));
            };
        }

        private function _QuestWin_ClassFactory7_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent7;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function doTimeOutClose():void
        {
            if (AllWindows.instance.currentWin == this)
            {
                setTimeout(onTimeOutClose, 5000);
            };
        }

        public function set subQuestDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._826490203subQuestDg;
            if (_local_2 !== _arg_1)
            {
                this._826490203subQuestDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "subQuestDg", _local_2, _arg_1));
            };
        }

        public function __questTypeTBB_itemClick(_arg_1:ItemClickEvent):void
        {
            onQuestClick(_arg_1);
        }

        private function filterRows(_arg_1:Object):Boolean
        {
            var _local_2:int = this.taskCom.selectedItem.data;
            if (_local_2 == 0)
            {
                return (true);
            };
            if (_arg_1.type == _local_2)
            {
                return (true);
            };
            return (false);
        }

        public function getQuestTypeArray():ArrayCollection
        {
            return (this.questTypeArray);
        }

        public function set myViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._153085257myViewstack;
            if (_local_2 !== _arg_1)
            {
                this._153085257myViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myViewstack", _local_2, _arg_1));
            };
        }

        public function set questDetail1(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1069616830questDetail1;
            if (_local_2 !== _arg_1)
            {
                this._1069616830questDetail1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDetail1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get xcoord():TextInput
        {
            return (this._764623491xcoord);
        }

        public function set questDetail2(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1069616831questDetail2;
            if (_local_2 !== _arg_1)
            {
                this._1069616831questDetail2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDetail2", _local_2, _arg_1));
            };
        }

        public function set money(_arg_1:TextInput):void
        {
            var _local_2:Object = this._104079552money;
            if (_local_2 !== _arg_1)
            {
                this._104079552money = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "money", _local_2, _arg_1));
            };
        }

        private function onQuestList(_arg_1:QuestListResponse):void
        {
            var _local_3:uint;
            var _local_4:QuestTargetBean;
            var _local_5:String;
            var _local_6:int;
            this.questList = _arg_1.questsArray;
            if (this.questList.length > 0)
            {
                this.hasQuest = true;
                this.curQuest = (this.questList[0] as QuestBean);
                if (this.showHeroList)
                {
                    if (this.curQuestType.typeId != 1000000)
                    {
                        if ((((this.curQuest.questId == 488) || (this.curQuest.questId == 498)) || (this.curQuest.questId == 504)))
                        {
                            this.showDelTaskBtn = false;
                            this.showDecBtn = false;
                        }
                        else
                        {
                            if (this.curQuest.isFinish)
                            {
                                this.showDecBtn = false;
                            }
                            else
                            {
                                this.showDecBtn = true;
                            };
                        };
                    }
                    else
                    {
                        this.showDecBtn = false;
                        this.showDelTaskBtn = true;
                    };
                };
                if (this.curQuest.name == "Daily Amulet")
                {
                    this.curDailyTarget = this.eachTargetArray1;
                };
                this.subQuestDg.selectedIndex = 0;
                if (this.curQuest.name == Lang.msg("新手收藏夹任务"))
                {
                    _local_3 = 0;
                    while (_local_3 < this.curQuest.targetsArray.length)
                    {
                        _local_4 = (this.curQuest.targetsArray[_local_3] as QuestTargetBean);
                        _local_4.name = _local_4.name.toString().replace("%s", GameConfig.instance.homePage);
                        _local_3++;
                    };
                };
                showFavotiteBtn = ((!(this.curQuest.isFinish)) && (this.curQuest.name == Lang.msg("新手收藏夹任务")));
                showDigiBtn = false;
                showDigiBtn2 = false;
                if (this.curQuest.name.indexOf("Welcome to a new way to play Evony.") == 0)
                {
                    _local_5 = this.curQuest.targetsArray[0].name.toString();
                    _local_6 = _local_5.indexOf("http://");
                    strPicUrl = _local_5.substr(_local_6);
                    strPicUrl = ((strPicUrl + "&sip=") + GameConfig.instance.serverIp);
                    if (!Context.getInstance().facebookUser)
                    {
                        strPicUrl = ((strPicUrl + "&pic=") + Context.getInstance().getPlayerBean().playerInfo.faceUrl);
                    };
                    if (digiImg)
                    {
                        digiImg.source = strPicUrl;
                    };
                    showDigiBtn = true;
                };
            }
            else
            {
                this.hasQuest = false;
            };
            var _local_2:GuideArrow = this.questDetail1;
            if (btnStackIndex == 1)
            {
                _local_2 = this.questDetail3;
            };
            if (_local_2.visible)
            {
                _local_2.visible = false;
                _local_2.includeInLayout = false;
            };
            if (questDetail2.visible)
            {
                this.questDetail2.visible = false;
                this.questDetail2.includeInLayout = false;
            };
            if (Context.getInstance().needUserGuide)
            {
                if (((curQuest.questId == 1) && (GuideStep.getInstance().currentStep == 3)))
                {
                    _local_2.visible = true;
                    _local_2.includeInLayout = true;
                }
                else
                {
                    if (((curQuest.questId == 2) && (GuideStep.getInstance().currentStep == 401)))
                    {
                        this.questDetail2.visible = true;
                        this.questDetail2.includeInLayout = true;
                    };
                };
            };
        }

        private function DeclineTask():void
        {
            ActionFactory.getInstance().getQuestCommands().donate(this.curQuest.questId, Context.getInstance().getCurCastle().id, declineCommQuestResponse);
        }

        public function set taskSort(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._410168125taskSort;
            if (_local_2 !== _arg_1)
            {
                this._410168125taskSort = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taskSort", _local_2, _arg_1));
            };
        }

        public function set questDetail3(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._1069616832questDetail3;
            if (_local_2 !== _arg_1)
            {
                this._1069616832questDetail3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDetail3", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnStack():ViewStack
        {
            return (this._2097343884btnStack);
        }

        private function onChangeQuestType(_arg_1:ListEvent):void
        {
            if ((_arg_1.itemRenderer.data is QuestTypeBean))
            {
                this.curQuestType = (_arg_1.itemRenderer.data as QuestTypeBean);
                this.curQuestTypeName = this.curQuestType.name;
                this.curSelectQuestTypeIndex = DataGrid(_arg_1.target).selectedIndex;
                this.refreshQuestList();
                if (this.curQuestTypeName == "Daily Gift")
                {
                    this.curDailyTarget = this.eachTargetArray1;
                }
                else
                {
                    this.curDailyTarget = this.eachTargetArray2;
                };
                if (this.questTypeTBB.selectedIndex == 2)
                {
                    this.curQuestTypeName = "The Hunt-Down";
                };
            }
            else
            {
                if (_arg_1.itemRenderer.data.type == CommonConstants.COMMISSION_QUEST_TYPE_COLONY)
                {
                    setAntiColonyDetail(_arg_1.itemRenderer.data);
                    this.subQuestDg.selectedIndex = -1;
                    this.curQuestTypeName = "   ";
                };
            };
        }

        private function _QuestWin_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Accepted";
            _local_1.dataField = "playerCount";
            _local_1.width = 70;
            _local_1.setStyle("textAlign", "left");
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get AllTaskListInfoVs():VBox
        {
            return (this._892629391AllTaskListInfoVs);
        }

        [Bindable(event="propertyChange")]
        public function get target():ComboBox
        {
            return (this._880905839target);
        }

        public function getUnfinishIcon():Object
        {
            return (this.UnfinishedIcon);
        }

        private function _QuestWin_DataGridColumn11_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn11 = _local_1;
            _local_1.dataField = "reward";
            _local_1.width = 75;
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn11", _QuestWin_DataGridColumn11);
            return (_local_1);
        }

        private function ArmyListShow():void
        {
            ActionFactory.getInstance().getCommissionQuestCommands().getCommissionQuestArmyRanking(this.curQuest.questId, questArmyRankResponse);
        }

        [Bindable(event="propertyChange")]
        private function get curQuestTypeName():String
        {
            return (this._1658593671curQuestTypeName);
        }

        private function _QuestWin_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___QuestWin_Button4_click(_arg_1:MouseEvent):void
        {
            awardAndShare();
        }

        public function set questTypeTBB(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._1341206824questTypeTBB;
            if (_local_2 !== _arg_1)
            {
                this._1341206824questTypeTBB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeTBB", _local_2, _arg_1));
            };
        }

        private function set curQuestType(_arg_1:QuestTypeBean):void
        {
            var _local_2:Object = this._602210084curQuestType;
            if (_local_2 !== _arg_1)
            {
                this._602210084curQuestType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuestType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get taskCom():ComboBox
        {
            return (this._1537267268taskCom);
        }

        private function awardResponse(_arg_1:CommandResponse=null):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (((Context.getInstance().need_QuestGuid) && (curQuest.questId == 29)))
                {
                    AlertWin.show("Congratulations. Your Majesty! Now you have become an independent and strong lord.  Lead your empire and troops and fight to prevail!");
                    MainWin.instance.wizadrd.visible = false;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get questContainer():Canvas
        {
            return (this._1328205377questContainer);
        }

        [Bindable(event="propertyChange")]
        private function get filterArray():Array
        {
            return (this._917691967filterArray);
        }

        private function awardAndShare():void
        {
            var _local_1:Object;
            if (Context.getInstance().facebookUser)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("log_user_action", Context.getInstance().getPlayerBean().playerInfo.accountName, 3);
                };
                _local_1 = FbData.getInstance().getValue(curQuest.questId);
                if (_local_1 != null)
                {
                    FacebookNoticeWin.show(_local_1);
                };
            }
            else
            {
                navigateToURL(new URLRequest(GameConfig.instance.FbLinkAccountUrl), "_blank");
            };
            if (Context.getInstance().needUserGuide)
            {
                if (curQuest.questId == 1)
                {
                    GuideStep.getInstance().step3();
                    return;
                };
            };
            ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, curQuest.questId, awardResponse);
        }

        [Bindable(event="propertyChange")]
        public function get TaskListInfoVs():VBox
        {
            return (this._1476876850TaskListInfoVs);
        }

        private function deleteTask():void
        {
            if (questTypeTBB.selectedIndex == 3)
            {
                ActionFactory.getInstance().getCommissionQuestCommands().declineCommissionQuest(this.curQuest.questId, declineCommQuestResponse);
            }
            else
            {
                ActionFactory.getInstance().getQuestCommands().abandon(this.curQuest.questId, Context.getInstance().getCurCastle().id);
            };
        }

        private function set showDelTaskBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._625641193showDelTaskBtn;
            if (_local_2 !== _arg_1)
            {
                this._625641193showDelTaskBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showDelTaskBtn", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn5 = _local_1;
            _local_1.dataField = "reward";
            _local_1.width = 65;
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn5", _QuestWin_DataGridColumn5);
            return (_local_1);
        }

        private function _QuestWin_DataGridColumn10_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn10 = _local_1;
            _local_1.dataField = "timeout";
            _local_1.width = 115;
            _local_1.itemRenderer = _QuestWin_ClassFactory5_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn10", _QuestWin_DataGridColumn10);
            return (_local_1);
        }

        private function set testArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1207875353testArray;
            if (_local_2 !== _arg_1)
            {
                this._1207875353testArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "testArray", _local_2, _arg_1));
            };
        }

        private function _QuestWin_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get showHeroList():Boolean
        {
            return (this._1471129131showHeroList);
        }

        private function set commBean(_arg_1:CommissionQuestBean):void
        {
            var _local_2:Object = this._603467556commBean;
            if (_local_2 !== _arg_1)
            {
                this._603467556commBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "commBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get NewshowDecBtn():Boolean
        {
            return (this._7663145NewshowDecBtn);
        }

        public function ___QuestWin_Button9_click(_arg_1:MouseEvent):void
        {
            deleteTask();
        }

        private function GetIdFromCityName(_arg_1:String):int
        {
            var _local_3:CastleBean;
            var _local_2:PlayerBean = Context.getInstance().getPlayerBean();
            if (_local_2 != null)
            {
                for each (_local_3 in _local_2.castlesArray)
                {
                    if (_local_3.name == _arg_1)
                    {
                        return (_local_3.id);
                    };
                };
            };
            return (0);
        }

        private function set showDigiBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2048592632showDigiBtn;
            if (_local_2 !== _arg_1)
            {
                this._2048592632showDigiBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showDigiBtn", _local_2, _arg_1));
            };
        }

        private function onNewFinishedQuest(_arg_1:NewFinishedQuest):void
        {
            ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 1);
            ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 4);
        }

        public function set questDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._655126789questDg;
            if (_local_2 !== _arg_1)
            {
                this._655126789questDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get showArmyList():Boolean
        {
            return (this._2027803128showArmyList);
        }

        private function _QuestWin_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn4 = _local_1;
            _local_1.dataField = "timeout";
            _local_1.width = 110;
            _local_1.itemRenderer = _QuestWin_ClassFactory3_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn4", _QuestWin_DataGridColumn4);
            return (_local_1);
        }

        private function OnIssue(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show("Issue Successfully");
                this.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get digiImg():Image
        {
            return (this._1660440092digiImg);
        }

        private function onAwardResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (this.curQuest.questId == 646)
                {
                    AlertWin.show("Turned in successfully!");
                }
                else
                {
                    this.refresh();
                };
                if (Context.getInstance().iFbStep == 3)
                {
                    Context.getInstance().iFbStep++;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _QuestWin_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get ycoord():TextInput
        {
            return (this._735994340ycoord);
        }

        public function ArrowPoints(_arg_1:int):void
        {
            this.questDg.selectedIndex = _arg_1;
        }

        private function set strPicUrl(_arg_1:String):void
        {
            var _local_2:Object = this._909756138strPicUrl;
            if (_local_2 !== _arg_1)
            {
                this._909756138strPicUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strPicUrl", _local_2, _arg_1));
            };
        }

        public function set questtype(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1781897444questtype;
            if (_local_2 !== _arg_1)
            {
                this._1781897444questtype = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questtype", _local_2, _arg_1));
            };
        }

        private function _QuestWin_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn3 = _local_1;
            _local_1.dataField = "target";
            _local_1.width = 90;
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn3", _QuestWin_DataGridColumn3);
            return (_local_1);
        }

        private function _QuestWin_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get myCommArray():ArrayCollection
        {
            return (this._126677407myCommArray);
        }

        public function ___QuestWin_Button3_click(_arg_1:MouseEvent):void
        {
            award();
        }

        public function showIssueQuest():void
        {
            isFirstLogin = false;
            showDelTaskBtn = false;
            showArmyList = false;
            this.curQuestTypeName = "";
            this.questList = null;
            this.questTypeArray = null;
        }

        [Bindable(event="propertyChange")]
        public function get questTypeInfoVs():Canvas
        {
            return (this._84842905questTypeInfoVs);
        }

        [Bindable(event="propertyChange")]
        private function get hasQuest():Boolean
        {
            return (this._127936104hasQuest);
        }

        private function award():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("log_user_action", Context.getInstance().getPlayerBean().playerInfo.accountName, 2);
            };
            if (Context.getInstance().needUserGuide)
            {
                if (curQuest.questId == 1)
                {
                    GuideStep.getInstance().step3();
                    return;
                };
            };
            if (Context.getInstance().need_QuestGuid)
            {
                Questwizard.instance.bopen = true;
            };
            ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, curQuest.questId, awardResponse);
        }

        private function setFilter():void
        {
            this.commArray.filterFunction = filterRows;
            this.commArray.refresh();
        }

        [Bindable(event="propertyChange")]
        private function get showFavotiteBtn():Boolean
        {
            return (this._2024405605showFavotiteBtn);
        }

        [Bindable(event="propertyChange")]
        private function get iFinishCount1():int
        {
            return (this._1746226814iFinishCount1);
        }

        [Bindable(event="propertyChange")]
        private function get iFinishCount2():int
        {
            return (this._1746226815iFinishCount2);
        }

        [Bindable(event="propertyChange")]
        private function get iFinishCount3():int
        {
            return (this._1746226816iFinishCount3);
        }

        [Bindable(event="propertyChange")]
        private function get curQuest():QuestBean
        {
            return (this._545394306curQuest);
        }

        [Bindable(event="propertyChange")]
        private function get BigpointTop():int
        {
            return (this._1483107973BigpointTop);
        }

        private function _QuestWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "type";
            _local_1.width = 80;
            _local_1.itemRenderer = _QuestWin_ClassFactory2_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn2", _QuestWin_DataGridColumn2);
            return (_local_1);
        }

        private function _QuestWin_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get subQuestDg():DataGrid
        {
            return (this._826490203subQuestDg);
        }

        [Bindable(event="propertyChange")]
        public function get typeOldBtn():HBox
        {
            return (this._1545078129typeOldBtn);
        }

        public function ___QuestWin_Button8_click(_arg_1:MouseEvent):void
        {
            award();
        }

        [Bindable(event="propertyChange")]
        private function get curDailyTarget():ArrayCollection
        {
            return (this._488358570curDailyTarget);
        }

        [Bindable(event="propertyChange")]
        private function get commArray():ArrayCollection
        {
            return (this._1528145235commArray);
        }

        private function set sortArray(_arg_1:Array):void
        {
            var _local_2:Object = this._39690405sortArray;
            if (_local_2 !== _arg_1)
            {
                this._39690405sortArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sortArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get myViewstack():ViewStack
        {
            return (this._153085257myViewstack);
        }

        [Bindable(event="propertyChange")]
        public function get questDetail2():GuideArrow
        {
            return (this._1069616831questDetail2);
        }

        [Bindable(event="propertyChange")]
        private function get taskTypeData():Array
        {
            return (this._2017594025taskTypeData);
        }

        [Bindable(event="propertyChange")]
        public function get questDetail1():GuideArrow
        {
            return (this._1069616830questDetail1);
        }

        private function countDoneValue(_arg_1:ArrayCollection):int
        {
            var _local_2:int;
            this.jobDone = 0;
            if (_arg_1.length > 0)
            {
                _local_2 = 0;
                while (_local_2 < _arg_1.length)
                {
                    if (QuestTypeBean(_arg_1[_local_2]).isFinish)
                    {
                        this.jobDone++;
                    };
                    _local_2++;
                };
            };
            return (this.jobDone);
        }

        public function __taskSort_change(_arg_1:ListEvent):void
        {
            sortTask();
        }

        [Bindable(event="propertyChange")]
        private function get btnStackIndex():int
        {
            return (this._1276648794btnStackIndex);
        }

        override public function refresh():void
        {
            if (closeHint != null)
            {
                closeHint.visible = false;
            };
            ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 1);
            ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 4);
            if (((questTypeTBB.selectedIndex == 2) && (!(this.questDg.selectedIndex == -1))))
            {
                ActionFactory.getInstance().getCommissionQuestCommands().getMyAcceptedCommissionQuest(getMyCommResponse);
            };
            if ((((MainWin) && (MainWin.instance)) && (!(MainWin.instance.issueQuestPos == 0))))
            {
                questTypeTBB.selectedIndex = 2;
                ActionFactory.getInstance().getCommissionQuestCommands().getMyAcceptedCommissionQuest(getMyCommResponse);
            };
        }

        private function _QuestWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _QuestWin_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestWin_DataGridColumn1 = _local_1;
            _local_1.dataField = "position";
            _local_1.width = 85;
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_QuestWin_DataGridColumn1", _QuestWin_DataGridColumn1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get questTypeTBB():ToggleButtonBar
        {
            return (this._1341206824questTypeTBB);
        }

        [Bindable(event="propertyChange")]
        public function get questDetail3():GuideArrow
        {
            return (this._1069616832questDetail3);
        }

        public function SmallArrowPoints(_arg_1:int, _arg_2:QuestBean):void
        {
            this.subQuestDg.scrollToIndex(_arg_1);
            this.subQuestDg.selectedIndex = _arg_1;
            this.curQuest = _arg_2;
        }

        [Bindable(event="propertyChange")]
        private function get showDelTaskBtn():Boolean
        {
            return (this._625641193showDelTaskBtn);
        }

        private function setAntiColonyDetail(_arg_1:Object):void
        {
            var _local_2:CommissionQuestBean = (_arg_1 as CommissionQuestBean);
            var _local_3:QuestBean = new QuestBean();
            _local_3.award = Lang.msg("反殖民委托奖励", _local_2.reward);
            _local_3.description = Lang.msg("反殖民委托描述", _local_2.position, _local_2.endtime);
            _local_3.manual = Lang.msg("反殖民委托指南");
            _local_3.isCard = false;
            _local_3.isFinish = false;
            var _local_4:QuestTargetBean = new QuestTargetBean();
            _local_4.name = Lang.msg("反殖民委托目标", _local_2.position);
            _local_4.finished = false;
            _local_3.targetsArray.addItem(_local_4);
            _local_3.name = _local_2.name;
            _local_3.questId = _local_2.id;
            this.curQuest = _local_3;
            this.curPosition = _local_2.position;
            this.myViewstack.selectedChild = this.questInfoVs;
        }

        private function _QuestWin_Array3_i():Array
        {
            var _local_1:Array = [null, null, null];
            _QuestWin_Array3 = _local_1;
            BindingManager.executeBindings(this, "_QuestWin_Array3", _QuestWin_Array3);
            return (_local_1);
        }

        public function set xcoord(_arg_1:TextInput):void
        {
            var _local_2:Object = this._764623491xcoord;
            if (_local_2 !== _arg_1)
            {
                this._764623491xcoord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xcoord", _local_2, _arg_1));
            };
        }

        private function _QuestWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("任务");
            _local_1 = this.hasQuest;
            _local_1 = this.curQuestType.name;
            _local_1 = this.curQuestType.description;
            _local_1 = this.curQuest.name;
            _local_1 = Lang.msg("任务描述");
            _local_1 = ((this.curQuest.version == 2) ? true : false);
            _local_1 = this.curQuest.description;
            _local_1 = Lang.msg("任务指南");
            _local_1 = this.curQuest.manual;
            _local_1 = Lang.msg("任务目标");
            _local_1 = Lang.msg("加入收藏夹");
            _local_1 = this.showFavotiteBtn;
            _local_1 = this.showFavotiteBtn;
            _local_1 = (!(this.showDigiBtn));
            _local_1 = (!(this.showDigiBtn));
            _local_1 = ((curQuest.targetsArray.length > 0) ? curQuest.targetsArray : curDailyTarget);
            _local_1 = ((curQuest.targetsArray.length > 0) ? curQuest.targetsArray.length : curDailyTarget.length);
            _local_1 = ((this.showDecBtn) && (this.NewshowDecBtn));
            _local_1 = ((this.showDecBtn) && (this.NewshowDecBtn));
            _local_1 = this.showDigiBtn;
            _local_1 = this.showDigiBtn;
            _local_1 = this.showDigiBtn;
            _local_1 = this.showDigiBtn;
            _local_1 = Lang.msg("任务奖励");
            _local_1 = StringUtil.trim(this.curQuest.award);
            _local_1 = this.btnStackIndex;
            _local_1 = Lang.msg("领取奖励");
            _local_1 = this.curQuest.isFinish;
            _local_1 = ((this.curQuest.isFinish) && (!(FbData.getInstance().getValue(curQuest.questId) == null)));
            _local_1 = Lang.msg("放弃任务");
            _local_1 = this.showDelTaskBtn;
            _local_1 = this.showDelTaskBtn;
            _local_1 = this.showDecBtn;
            _local_1 = this.showDecBtn;
            _local_1 = ((this.curQuest.isFinish) && (!(FbData.getInstance().getValue(curQuest.questId) == null)));
            _local_1 = this.curQuest.isFinish;
            _local_1 = Lang.msg("放弃任务");
            _local_1 = this.showDelTaskBtn;
            _local_1 = Lang.msg("军队排行");
            _local_1 = this.showArmyList;
            _local_1 = Lang.msg("发布委托");
            _local_1 = Lang.msg("发布委托任务说明");
            _local_1 = (Lang.msg("坐标") + "：");
            _local_1 = this.posX;
            _local_1 = this.posY;
            _local_1 = (Lang.msg("任务类型") + "   ：");
            _local_1 = this.taskTypeData;
            _local_1 = (Lang.msg("目标城池") + "：");
            _local_1 = cityList;
            _local_1 = (Lang.msg("任务奖励") + "：");
            _local_1 = Lang.msg("发布");
            _local_1 = Lang.msg("我的委托");
            _local_1 = myCommArray;
            _local_1 = Lang.msg("坐标");
            _local_1 = Lang.msg("任务类型");
            _local_1 = Lang.msg("任务目标");
            _local_1 = Lang.msg("剩余时间");
            _local_1 = Lang.msg("奖励");
            _local_1 = Lang.msg("任务过滤");
            _local_1 = filterArray;
            _local_1 = Lang.msg("排列方式");
            _local_1 = sortArray;
            _local_1 = commArray;
            _local_1 = Lang.msg("坐标");
            _local_1 = Lang.msg("任务类型");
            _local_1 = Lang.msg("任务目标");
            _local_1 = Lang.msg("剩余时间");
            _local_1 = Lang.msg("奖励");
            _local_1 = Lang.msg("成长任务");
            _local_1 = Lang.msg("名将任务");
            _local_1 = Lang.msg("委托任务");
            _local_1 = ((iFinishCount1 == 0) ? false : true);
            _local_1 = this.iFinishCount1;
            _local_1 = ((iFinishCount1 == 0) ? false : true);
            _local_1 = ((iFinishCount3 == 0) ? false : true);
            _local_1 = this.iFinishCount3;
            _local_1 = ((iFinishCount3 == 0) ? false : true);
            _local_1 = this.questTypeArray;
            _local_1 = Lang.msg("成长任务");
            _local_1 = this.questList;
            _local_1 = this.curQuestTypeName;
        }

        private function decLinetaskResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get showDigiBtn():Boolean
        {
            return (this._2048592632showDigiBtn);
        }

        private function set curQuestTypeName(_arg_1:String):void
        {
            var _local_2:Object = this._1658593671curQuestTypeName;
            if (_local_2 !== _arg_1)
            {
                this._1658593671curQuestTypeName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curQuestTypeName", _local_2, _arg_1));
            };
        }

        public function GetQuestGuide():Boolean
        {
            return (Context.getInstance().need_QuestGuid);
        }

        public function set btnStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._2097343884btnStack;
            if (_local_2 !== _arg_1)
            {
                this._2097343884btnStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnStack", _local_2, _arg_1));
            };
        }

        public function set questInfoVs(_arg_1:VBox):void
        {
            var _local_2:Object = this._47009677questInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._47009677questInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questInfoVs", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get questtype():ComboBox
        {
            return (this._1781897444questtype);
        }

        private function set SmallpointTop(_arg_1:int):void
        {
            var _local_2:Object = this._1117186164SmallpointTop;
            if (_local_2 !== _arg_1)
            {
                this._1117186164SmallpointTop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SmallpointTop", _local_2, _arg_1));
            };
        }

        public function ___QuestWin_Button2_click(_arg_1:MouseEvent):void
        {
            DeclineTask();
        }

        public function set target(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._880905839target;
            if (_local_2 !== _arg_1)
            {
                this._880905839target = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "target", _local_2, _arg_1));
            };
        }

        public function set AllTaskListInfoVs(_arg_1:VBox):void
        {
            var _local_2:Object = this._892629391AllTaskListInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._892629391AllTaskListInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AllTaskListInfoVs", _local_2, _arg_1));
            };
        }

        private function onResponse(_arg_1:CommandResponse):void
        {
            refreshQuestList();
            this.curQuest.isFinish = true;
        }

        private function declineCommQuestResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.refresh();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function guideQuest():void
        {
            var _local_1:int;
            if (GuideStep.getInstance().currentStep == 3)
            {
                _local_1 = 0;
                while (_local_1 < questTypeArray.length)
                {
                    if (questTypeArray[_local_1].typeId == 66)
                    {
                        this.questTypeTBB.selectedIndex = 0;
                        this.curQuestType = (this.questTypeArray[_local_1] as QuestTypeBean);
                        this.questDg.selectedIndex = 0;
                        this.myViewstack.selectedChild = this.questInfoVs;
                        this.refreshQuestList();
                    };
                    _local_1++;
                };
            };
        }

        private function onQuestClickClone(_arg_1:int):void
        {
            isFirstLogin = false;
            showDelTaskBtn = false;
            showArmyList = false;
            this.curQuestTypeName = "";
            this.questList = null;
            this.questTypeArray = null;
            this.myViewstack.selectedChild = this.questInfoVs;
            switch (_arg_1)
            {
                case 0:
                    ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 1);
                    break;
                case 4:
                    ActionFactory.getInstance().getQuestCommands().getQuestType(Context.getInstance().getCurCastle().id, 4);
                    showDelTaskBtn = true;
                    break;
                case 2:
                    ActionFactory.getInstance().getCommissionQuestCommands().getMyAcceptedCommissionQuest(getMyCommResponse);
                    break;
            };
            this.curSelectQuestTypeIndex = 0;
        }

        [Bindable(event="propertyChange")]
        private function get sortArray():Array
        {
            return (this._39690405sortArray);
        }

        override protected function onClose(_arg_1:Event):void
        {
            super.onClose(_arg_1);
            if (((!(TownView.instance == null)) && (!(TownView.instance.guideArrow == null))))
            {
                TownView.instance.guideArrow.visible = true;
            };
            closeHint.visible = false;
        }

        public function ___QuestWin_Button7_click(_arg_1:MouseEvent):void
        {
            awardAndShare();
        }

        private function useGoodsResponse(_arg_1:UseItemResultResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (_arg_1.itemBeansArray.length > 1)
                {
                    AwardShowWin.show(_arg_1);
                };
            };
        }

        public function __taskCom_change(_arg_1:ListEvent):void
        {
            setFilter();
        }

        public function set taskCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1537267268taskCom;
            if (_local_2 !== _arg_1)
            {
                this._1537267268taskCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taskCom", _local_2, _arg_1));
            };
        }

        public function set questContainer(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1328205377questContainer;
            if (_local_2 !== _arg_1)
            {
                this._1328205377questContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questContainer", _local_2, _arg_1));
            };
        }

        private function set filterArray(_arg_1:Array):void
        {
            var _local_2:Object = this._917691967filterArray;
            if (_local_2 !== _arg_1)
            {
                this._917691967filterArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "filterArray", _local_2, _arg_1));
            };
        }

        private function onDownload():void
        {
            navigateToURL(new URLRequest("http://evonygame.com/?p=828"), "_blank");
        }

        [Bindable(event="propertyChange")]
        public function get questInfoVs():VBox
        {
            return (this._47009677questInfoVs);
        }

        [Bindable(event="propertyChange")]
        private function get SmallpointTop():int
        {
            return (this._1117186164SmallpointTop);
        }

        override public function initialize():void
        {
            var target:QuestWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _QuestWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_QuestWinWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (internal::target[_arg_1]);
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

        public function __questDg_itemClick(_arg_1:ListEvent):void
        {
            onChangeQuestType(_arg_1);
        }

        public function set TaskListInfoVs(_arg_1:VBox):void
        {
            var _local_2:Object = this._1476876850TaskListInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._1476876850TaskListInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TaskListInfoVs", _local_2, _arg_1));
            };
        }

        public function getFinishIcon():Object
        {
            return (this.FinishedIcon);
        }

        public function set publicInfoVs(_arg_1:VBox):void
        {
            var _local_2:Object = this._242116564publicInfoVs;
            if (_local_2 !== _arg_1)
            {
                this._242116564publicInfoVs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "publicInfoVs", _local_2, _arg_1));
            };
        }

        private function set showHeroList(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1471129131showHeroList;
            if (_local_2 !== _arg_1)
            {
                this._1471129131showHeroList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showHeroList", _local_2, _arg_1));
            };
        }

        private function set NewshowDecBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._7663145NewshowDecBtn;
            if (_local_2 !== _arg_1)
            {
                this._7663145NewshowDecBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "NewshowDecBtn", _local_2, _arg_1));
            };
        }

        public function ___QuestWin_Button11_click(_arg_1:MouseEvent):void
        {
            issue();
        }

        private function questArmyRankResponse(_arg_1:CommissionQuestArmyRespone):void
        {
            var _local_2:Array;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = this.setXYArray(curPosition);
                QuestAmryInfo.show(_arg_1.armyRankBeanArray, this.curQuest.questId, _local_2[0], _local_2[1]);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onQuestChange(_arg_1:ListEvent):void
        {
            var _local_2:uint;
            var _local_3:QuestTargetBean;
            this.showDigiBtn = false;
            this.showDigiBtn2 = false;
            if (_arg_1.itemRenderer.data.name == Lang.msg("更多任务"))
            {
                ActionFactory.getInstance().getCommissionQuestCommands().getAllCommissionQuest();
                this.myViewstack.selectedChild = this.AllTaskListInfoVs;
                this.questDg.selectedIndex = -1;
                if (taskCom)
                {
                    this.taskCom.selectedIndex = 0;
                };
                if (taskSort)
                {
                    this.taskSort.selectedIndex = 0;
                };
                return;
            };
            if (_arg_1.itemRenderer.data.name == Lang.msg("发布委托"))
            {
                this.myViewstack.selectedChild = this.publicInfoVs;
                this.questDg.selectedIndex = -1;
                return;
            };
            if (_arg_1.itemRenderer.data.name == Lang.msg("我的委托"))
            {
                ActionFactory.getInstance().getCommissionQuestCommands().getMyCommissionQuest();
                this.myViewstack.selectedChild = this.TaskListInfoVs;
                this.questDg.selectedIndex = -1;
                return;
            };
            if (_arg_1.itemRenderer.data.name == "The Prophet Crystal Ball")
            {
                this.showDigiBtn = true;
            }
            else
            {
                if (_arg_1.itemRenderer.data.name == "Recognition of the Prophet Crystal Ball")
                {
                    this.showDigiBtn2 = true;
                };
            };
            this.myViewstack.selectedChild = this.questInfoVs;
            this.curQuest = (_arg_1.itemRenderer.data as QuestBean);
            if (this.showHeroList)
            {
                if (this.curQuestType.typeId != 1000000)
                {
                    if ((((this.curQuest.questId == 488) || (this.curQuest.questId == 498)) || (this.curQuest.questId == 504)))
                    {
                        this.showDelTaskBtn = false;
                        this.showDecBtn = false;
                    }
                    else
                    {
                        if (this.curQuest.isFinish)
                        {
                            this.showDecBtn = false;
                        }
                        else
                        {
                            this.showDecBtn = true;
                        };
                    };
                }
                else
                {
                    this.showDecBtn = false;
                    this.showDelTaskBtn = true;
                };
            };
            this.curSelectSubQuestIndex = DataGrid(_arg_1.currentTarget).selectedIndex;
            if (this.curQuest.name == Lang.msg("新手收藏夹任务"))
            {
                _local_2 = 0;
                while (_local_2 < this.curQuest.targetsArray.length)
                {
                    _local_3 = (this.curQuest.targetsArray[_local_2] as QuestTargetBean);
                    _local_3.name = _local_3.name.toString().replace("%s", GameConfig.instance.homePage);
                    _local_2++;
                };
            };
            showFavotiteBtn = ((!(this.curQuest.isFinish)) && (this.curQuest.name == Lang.msg("新手收藏夹任务")));
        }

        public function ___QuestWin_BaseFunctionWindowEx1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function MyCommission(_arg_1:CommissionQuestRespone):void
        {
            this.myCommArray = _arg_1.commissionQuestBeanArray;
        }

        [Bindable(event="propertyChange")]
        public function get publicInfoVs():VBox
        {
            return (this._242116564publicInfoVs);
        }

        private function onTimesRequest(_arg_1:TimerEvent):void
        {
            if (((Context.getInstance().isLink) && (!(Context.getInstance().getPlayerBean() == null))))
            {
                this.refresh();
            };
        }

        private function _QuestWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.hasQuest);
            }, function (_arg_1:Boolean):void
            {
                myViewstack.visible = _arg_1;
            }, "myViewstack.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuestType.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label1.text = _arg_1;
            }, "_QuestWin_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuestType.description;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Text1.text = _arg_1;
            }, "_QuestWin_Text1.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuest.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label2.text = _arg_1;
            }, "_QuestWin_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label3.text = _arg_1;
            }, "_QuestWin_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.curQuest.version == 2) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_EvonyImage1.visible = _arg_1;
            }, "_QuestWin_EvonyImage1.visible");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuest.description;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Text2.text = _arg_1;
            }, "_QuestWin_Text2.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务指南");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label4.text = _arg_1;
            }, "_QuestWin_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuest.manual;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Text3.text = _arg_1;
            }, "_QuestWin_Text3.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务目标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label5.text = _arg_1;
            }, "_QuestWin_Label5.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("加入收藏夹");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button1.label = _arg_1;
            }, "_QuestWin_Button1.label");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showFavotiteBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button1.visible = _arg_1;
            }, "_QuestWin_Button1.visible");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showFavotiteBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button1.includeInLayout = _arg_1;
            }, "_QuestWin_Button1.includeInLayout");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.showDigiBtn));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_HBox3.visible = _arg_1;
            }, "_QuestWin_HBox3.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.showDigiBtn));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_HBox3.includeInLayout = _arg_1;
            }, "_QuestWin_HBox3.includeInLayout");
            result[15] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((curQuest.targetsArray.length > 0) ? curQuest.targetsArray : curDailyTarget);
            }, function (_arg_1:Object):void
            {
                _QuestWin_List1.dataProvider = _arg_1;
            }, "_QuestWin_List1.dataProvider");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return ((curQuest.targetsArray.length > 0) ? curQuest.targetsArray.length : curDailyTarget.length);
            }, function (_arg_1:int):void
            {
                _QuestWin_List1.rowCount = _arg_1;
            }, "_QuestWin_List1.rowCount");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.showDecBtn) && (this.NewshowDecBtn));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button2.visible = _arg_1;
            }, "_QuestWin_Button2.visible");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.showDecBtn) && (this.NewshowDecBtn));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button2.includeInLayout = _arg_1;
            }, "_QuestWin_Button2.includeInLayout");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDigiBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Text4.visible = _arg_1;
            }, "_QuestWin_Text4.visible");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDigiBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Text4.includeInLayout = _arg_1;
            }, "_QuestWin_Text4.includeInLayout");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDigiBtn);
            }, function (_arg_1:Boolean):void
            {
                digiImg.visible = _arg_1;
            }, "digiImg.visible");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDigiBtn);
            }, function (_arg_1:Boolean):void
            {
                digiImg.includeInLayout = _arg_1;
            }, "digiImg.includeInLayout");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label6.text = _arg_1;
            }, "_QuestWin_Label6.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = StringUtil.trim(this.curQuest.award);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Text5.text = _arg_1;
            }, "_QuestWin_Text5.text");
            result[25] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.btnStackIndex);
            }, function (_arg_1:int):void
            {
                btnStack.selectedIndex = _arg_1;
            }, "btnStack.selectedIndex");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button3.label = _arg_1;
            }, "_QuestWin_Button3.label");
            result[27] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.curQuest.isFinish);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button3.enabled = _arg_1;
            }, "_QuestWin_Button3.enabled");
            result[28] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.curQuest.isFinish) && (!(FbData.getInstance().getValue(curQuest.questId) == null)));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button4.enabled = _arg_1;
            }, "_QuestWin_Button4.enabled");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("放弃任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button5.label = _arg_1;
            }, "_QuestWin_Button5.label");
            result[30] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDelTaskBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button5.visible = _arg_1;
            }, "_QuestWin_Button5.visible");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDelTaskBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button5.includeInLayout = _arg_1;
            }, "_QuestWin_Button5.includeInLayout");
            result[32] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDecBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button6.visible = _arg_1;
            }, "_QuestWin_Button6.visible");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDecBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button6.includeInLayout = _arg_1;
            }, "_QuestWin_Button6.includeInLayout");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.curQuest.isFinish) && (!(FbData.getInstance().getValue(curQuest.questId) == null)));
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button7.enabled = _arg_1;
            }, "_QuestWin_Button7.enabled");
            result[35] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.curQuest.isFinish);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button8.enabled = _arg_1;
            }, "_QuestWin_Button8.enabled");
            result[36] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("放弃任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button9.label = _arg_1;
            }, "_QuestWin_Button9.label");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showDelTaskBtn);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button9.visible = _arg_1;
            }, "_QuestWin_Button9.visible");
            result[38] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队排行");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button10.label = _arg_1;
            }, "_QuestWin_Button10.label");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showArmyList);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Button10.visible = _arg_1;
            }, "_QuestWin_Button10.visible");
            result[40] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布委托");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label7.text = _arg_1;
            }, "_QuestWin_Label7.text");
            result[41] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布委托任务说明");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Text6.text = _arg_1;
            }, "_QuestWin_Text6.text");
            result[42] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("坐标") + "：");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label8.text = _arg_1;
            }, "_QuestWin_Label8.text");
            result[43] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.posX;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                xcoord.text = _arg_1;
            }, "xcoord.text");
            result[44] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.posY;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ycoord.text = _arg_1;
            }, "ycoord.text");
            result[45] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("任务类型") + "   ：");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label11.text = _arg_1;
            }, "_QuestWin_Label11.text");
            result[46] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.taskTypeData);
            }, function (_arg_1:Object):void
            {
                questtype.dataProvider = _arg_1;
            }, "questtype.dataProvider");
            result[47] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("目标城池") + "：");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label12.text = _arg_1;
            }, "_QuestWin_Label12.text");
            result[48] = binding;
            binding = new Binding(this, function ():Object
            {
                return (cityList);
            }, function (_arg_1:Object):void
            {
                public::target.dataProvider = _arg_1;
            }, "target.dataProvider");
            result[49] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("任务奖励") + "：");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label13.text = _arg_1;
            }, "_QuestWin_Label13.text");
            result[50] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Button11.label = _arg_1;
            }, "_QuestWin_Button11.label");
            result[51] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("我的委托");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label15.text = _arg_1;
            }, "_QuestWin_Label15.text");
            result[52] = binding;
            binding = new Binding(this, function ():Object
            {
                return (myCommArray);
            }, function (_arg_1:Object):void
            {
                _QuestWin_DataGrid1.dataProvider = _arg_1;
            }, "_QuestWin_DataGrid1.dataProvider");
            result[53] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn1.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn1.headerText");
            result[54] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务类型");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn2.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn2.headerText");
            result[55] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务目标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn3.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn3.headerText");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn4.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn4.headerText");
            result[57] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn5.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn5.headerText");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务过滤");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label17.text = _arg_1;
            }, "_QuestWin_Label17.text");
            result[59] = binding;
            binding = new Binding(this, function ():Object
            {
                return (filterArray);
            }, function (_arg_1:Object):void
            {
                taskCom.dataProvider = _arg_1;
            }, "taskCom.dataProvider");
            result[60] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排列方式");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label18.text = _arg_1;
            }, "_QuestWin_Label18.text");
            result[61] = binding;
            binding = new Binding(this, function ():Object
            {
                return (sortArray);
            }, function (_arg_1:Object):void
            {
                taskSort.dataProvider = _arg_1;
            }, "taskSort.dataProvider");
            result[62] = binding;
            binding = new Binding(this, function ():Object
            {
                return (commArray);
            }, function (_arg_1:Object):void
            {
                _QuestWin_DataGrid2.dataProvider = _arg_1;
            }, "_QuestWin_DataGrid2.dataProvider");
            result[63] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("坐标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn7.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn7.headerText");
            result[64] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务类型");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn8.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn8.headerText");
            result[65] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务目标");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn9.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn9.headerText");
            result[66] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn10.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn10.headerText");
            result[67] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn11.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn11.headerText");
            result[68] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("成长任务"));
            }, function (_arg_1:*):void
            {
                _QuestWin_Array3[0] = _arg_1;
            }, "_QuestWin_Array3[0]");
            result[69] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("名将任务"));
            }, function (_arg_1:*):void
            {
                _QuestWin_Array3[1] = _arg_1;
            }, "_QuestWin_Array3[1]");
            result[70] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("委托任务"));
            }, function (_arg_1:*):void
            {
                _QuestWin_Array3[2] = _arg_1;
            }, "_QuestWin_Array3[2]");
            result[71] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iFinishCount1 == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_EvonyImage2.visible = _arg_1;
            }, "_QuestWin_EvonyImage2.visible");
            result[72] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.iFinishCount1;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label19.text = _arg_1;
            }, "_QuestWin_Label19.text");
            result[73] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iFinishCount1 == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Label19.visible = _arg_1;
            }, "_QuestWin_Label19.visible");
            result[74] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iFinishCount3 == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_EvonyImage3.visible = _arg_1;
            }, "_QuestWin_EvonyImage3.visible");
            result[75] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.iFinishCount3;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_Label20.text = _arg_1;
            }, "_QuestWin_Label20.text");
            result[76] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iFinishCount3 == 0) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _QuestWin_Label20.visible = _arg_1;
            }, "_QuestWin_Label20.visible");
            result[77] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.questTypeArray);
            }, function (_arg_1:Object):void
            {
                questDg.dataProvider = _arg_1;
            }, "questDg.dataProvider");
            result[78] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成长任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn13.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn13.headerText");
            result[79] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.questList);
            }, function (_arg_1:Object):void
            {
                subQuestDg.dataProvider = _arg_1;
            }, "subQuestDg.dataProvider");
            result[80] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curQuestTypeName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestWin_DataGridColumn14.headerText = _arg_1;
            }, "_QuestWin_DataGridColumn14.headerText");
            result[81] = binding;
            return (result);
        }

        public function ___QuestWin_Button1_click(_arg_1:MouseEvent):void
        {
            addfavorite();
        }

        private function set showArmyList(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2027803128showArmyList;
            if (_local_2 !== _arg_1)
            {
                this._2027803128showArmyList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showArmyList", _local_2, _arg_1));
            };
        }


    }
}//package view.module.quest

