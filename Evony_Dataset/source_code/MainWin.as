// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.MainWin

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.effects.Iris;
    import com.evony.common.beans.PlayerInfoBean;
    import view.castleList.AllCastleFrame;
    import mx.containers.Grid;
    import view.module.playerInfo.AllianceTypeUi;
    import mx.containers.HBox;
    import flash.display.Loader;
    import mx.controls.Button;
    import mx.controls.SWFLoader;
    import mx.core.UIComponent;
    import view.module.guide.GuideArrow;
    import view.ui.FacebookToolBar;
    import mx.controls.Label;
    import mx.containers.GridRow;
    import view.castle.MainFramePlayerBuff;
    import com.evony.util.EvonyImage;
    import mx.controls.Image;
    import view.newUI.MapPos;
    import mx.containers.GridItem;
    import view.module.guide.guideLady;
    import view.castle._BottomToolBar;
    import view.castle.MainFrame;
    import flash.net.SharedObject;
    import view.castle.world.FieldInfoWin;
    import view.module.quest.QuestBtnTooltip;
    import view.questWizard.Questwizard;
    import mx.controls.TextArea;
    import mx.controls.TextInput;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import flash.utils.Timer;
    import flash.geom.Rectangle;
    import com.evony.GameConfig;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.utils.getTimer;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.external.ExternalInterface;
    import mx.events.FlexEvent;
    import flash.utils.clearTimeout;
    import com.evony.Context;
    import view.module.guide.GuideStep;
    import com.evony.common.server.events.SecurityCodeRemovedEvent;
    import view.module.rank.cj;
    import view.ui.AmountInputUI;
    import view.module.rank.RankWin;
    import flash.events.KeyboardEvent;
    import flash.display.MovieClip;
    import view.ui.OtherPlayerHero;
    import mx.managers.PopUpManager;
    import com.adobe.crypto.MD5;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.events.Event;
    import com.evony.data.FbData;
    import view.ui.EffortFinishWin;
    import com.evony.common.server.events.QuestCompleteTipResponse;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.common.GetPackageNumberResponse;
    import flash.events.TimerEvent;
    import com.evony.util.UIUtil;
    import com.evony.common.MouseManager;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.events.MainWinInitEnd;
    import flash.events.TextEvent;
    import com.evony.MsgDispacther;
    import com.evony.events.HasQuestEvent;
    import view.module.playerInfo.SecurityCodeNotice;
    import view.module.shop.ShopWin;
    import com.evony.util.EnterKeyDispatcher;
    import flash.utils.setTimeout;
    import mx.styles.StyleManager;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import view.module.office.Office;
    import view.module.playerInfo.MyTreasure;
    import mx.events.ScrollEvent;
    import com.evony.client.action.ActionFactory;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.factory.PlayerInfoTypeManager;
    import flash.filters.GlowFilter;
    import view.module.shop.TurntableRank;
    import mx.events.ToolTipEvent;
    import view.module.alliance.AllianceWin;
    import view.ui.CallPrivaterWin;
    import view.module.workshop.Workshop;
    import com.evony.PreContext;
    import view.module.guide.SaveGameStep1Win;
    import mx.core.Application;
    import view.module.guide.SaveGameStep2Win;
    import flash.display.BitmapData;
    import com.evony.util.ResourceLoader;
    import view.module.gift.GiftFrame;
    import com.degrafa.skins.CSSSkin;
    import view.module.playerInfo.HeroSelect;
    import mx.core.IToolTip;
    import mx.managers.ToolTipManager;
    import view.ui.GameOptionsWin;
    import view.module.info.InfoWin;
    import flash.net.URLLoader;
    import flash.events.IOErrorEvent;
    import view.module.mail.MailWin;
    import view.castle.TownView;
    import view.module.friendList.FriendList;
    import com.evony.events.WindowChangeEvent;
    import view.module.forge.Forge;
    import view.module.tavern.TavernNewsWin;
    import view.ui.QuitGameWin;
    import view.ui.AddFavoriteWin;
    import view.module.rank.VoteWin;
    import flash.utils.getDefinitionByName;
    import view.ui.help;
    import view.ui.AddFundWin;
    import com.evony.common.server.events.SystemInfoMsg;
    import view.module.quest.QuestWin;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.events.*;
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
    import mx.effects.easing.*;

    use namespace mx_internal;

    public class MainWin extends Canvas implements IBindingClient 
    {

        public static const EVENT_CASTLE_CHANGE:String = "MainWin.curCastleChange";
        public static var instance:MainWin;
        private static var nFramecount:int = 0;
        private static var currentFPS:int = 0;
        private static var lastCalcFPSTime:Number = 0;
        private static var ss:Array = new Array("", "0", "00", "000", "0000", "00000", "000000");
        private static const FUNCTION_REFRESH:String = ((("document.insertScript = function ()" + "{ ") + "window.location.reload();") + "}");
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        mx_internal static var _MainWin_StylesInit_done:Boolean = false;

        private var oldWidth:Number = 1;
        private var _1269291995noticeText:String = "";
        private var _2062804539irisOut:Iris;
        private var _815231871playerInfoBean:PlayerInfoBean;
        private var _1455362316allCastleFrame:AllCastleFrame;
        private var _55996120MainMenu:Grid;
        private var _1306698027allianceUi:AllianceTypeUi;
        private var _1773821454buttonPanel:HBox;
        private var _437918602topicrepeat:Canvas;
        public var showNotice:Boolean;
        private var move_loader:Loader;
        private var polldigitime:uint;
        private var speed:Number = 0.5;
        private var _530115961overview:Button;
        private var _493534338playerInfoFrame:PlayerHeadFrame;
        private var _934521548report:SWFLoader;
        private var _373257866guideUC:UIComponent;
        private var _1742630605soundBtn:Button;
        private var _110149619tbfrm:ToolBarFrame;
        private var _33383659immediateBtn:Button;
        private var _817782562immediateNoticeBox:HBox;
        private var indextest:int = 0;
        private var _1639121572stoneArrow:GuideArrow;
        private var _646308862autofit:Button;
        private var _464330009townTabGuide:GuideArrow;
        private var _573249167giftboxUi:UIComponent;
        private var _2005378358bookmark:SWFLoader;
        private var _97185207fbBar:FacebookToolBar;
        private var _969159162allWinFrmVv:Object = 0;
        private var _1180384104irisIn:Iris;
        public var _MainWin_Label10:Label;
        public var _MainWin_Label12:Label;
        public var _MainWin_Button11:Button;
        public var _MainWin_Button12:Button;
        public var _MainWin_Button13:Button;
        public var _MainWin_Button14:Button;
        public var _MainWin_Button15:Button;
        private var _1596947701chatFrame:ChatFrame;
        private var _3506583row1:GridRow;
        private var digifindevoniansBtntime:uint;
        private var digitime30:uint;
        public var _MainWin_Button20:Button;
        public var _MainWin_Button21:Button;
        private var intervalId:uint;
        public var _MainWin_Button23:Button;
        public var _MainWin_Button24:Button;
        private var _761825443myItemGuide:GuideArrow;
        public var _MainWin_Button29:Button;
        private var _261712661allWindowsFrame:AllWindows;
        public var _MainWin_Button30:Button;
        public var _MainWin_Button31:Button;
        public var _MainWin_Button32:Button;
        private var _3035219buff:MainFramePlayerBuff;
        private var digichatallianceBtntime:uint;
        private var _434424498Tborder2:EvonyImage;
        private var _loader:Loader;
        private var _1565357413movingText:String;
        private var _51654649speedupArrow:GuideArrow;
        private var _1247888022allCityList:Canvas;
        private var _1897219624starPic:Image;
        private var _1642466168Lborder:EvonyImage;
        private var _1306653589addMoneyPic:Image;
        private var _3172656gift:SWFLoader;
        public var _MainWin_Canvas10:Canvas;
        private var _822370131mapPosBox:MapPos;
        private var _1211154592isBookMark:Boolean = false;
        private var _1822582529newUsualReportNumber:int;
        private var _1094600639skipBtnRight:Number = 320;
        private var _156526404populationArrow:GuideArrow;
        private var firstTime:Boolean = true;
        private var _1313445695bookmarkshowFlag:int = 0;
        private var countLine:Number = 0;
        private var _1267579196gridQuest:GridItem;
        private var _2076679706guideLady:view.module.guide.guideLady;
        private var _1406478259friendslist:Button;
        private var _685065473buildingProgress:_BottomToolBar;
        private var _274178252mainFrame:MainFrame;
        private var _1860599247chat_HtmlMsg:String = "";
        private var addBookMarkSo:SharedObject;
        private var _1861656612DigiChatTip:SWFLoader;
        private var _1279483106voteCanvas:Canvas;
        private var _9038014lumberArrow:GuideArrow;
        private var _907332761DigiFindEvoniansBtnCanvas:Canvas;
        private var _784993510DigiChatAllianceBtn:SWFLoader;
        private var _2099064Chat:Canvas;
        private var _2067274083showNew:FieldInfoWin;
        private var _1859770051myQuestBtnTooltip:QuestBtnTooltip;
        private var _588869644equipBtn:Button;
        private var _1397946434rightTopBg:EvonyImage;
        private var oldHeight:Number = 1;
        private var _1360475517wizadrd:Questwizard;
        private var _1038075094text_chat:TextArea;
        private var _2109822408text_input:TextInput;
        private var _1045836767ironArrow:GuideArrow;
        private var _221875458guidLadyBottom:Number = 140;
        private var _1616766879repeattopbg:Canvas;
        public var _MainWin_Label1:Label;
        private var digitimealpha:uint;
        public var _MainWin_Label3:Label;
        public var _MainWin_Label4:Label;
        public var _MainWin_Label5:Label;
        public var _MainWin_Label6:Label;
        public var _MainWin_Label7:Label;
        public var _MainWin_Label8:Label;
        public var _MainWin_Label9:Label;
        private var _868812181turnnotice:SWFLoader;
        private var _1518306708myitems:Button;
        public var _MainWin_Canvas9:Canvas;
        private var _969159596allWinFrmHv:Object = 0;
        private var _238289419issueQuestPos:int;
        private var _94506039glRight:Number = 500;
        private var _3529451shoe:SWFLoader;
        private var _879245080skipBtnBottom:Number = 260;
        private var questButton:Button = null;
        private var _1126740916cityInBtn:Button;
        private var _1195075843UserButton:Canvas;
        private var _200298193DigiFindEvoniansBtn:SWFLoader;
        private var _1893954902saveBtnBottom:Number = 212;
        public var _MainWin_EvonyImage17:EvonyImage;
        public var _MainWin_EvonyImage18:EvonyImage;
        public var _MainWin_SWFLoader4:SWFLoader;
        private var _2031699389saveBtnRight:Number = 320;
        private var _1138195893foodArrow:GuideArrow;
        public var _MainWin_EvonyImage20:EvonyImage;
        private var oldSx:Number = 1;
        public var _MainWin_EvonyImage22:EvonyImage;
        public var _MainWin_EvonyImage26:EvonyImage;
        public var _MainWin_EvonyImage27:EvonyImage;
        public var _MainWin_EvonyImage28:EvonyImage;
        private var oldSy:Number = 1;
        private var _202022634UserName:Canvas;
        private var _1456236650moveTextCanvas:Canvas;
        private var _1865426839visitLabel:Label;
        private var _1565524014moveTextUi:UIComponent;
        private var _495025357saveGameBtn:Button;
        private var _951852243prestigeTxt:Label;
        private var _416443577castleInfoFrame:CastleInfoFrame;
        private var _1290566025DigiChatAllianceBtneCanvas:Canvas;
        private var intervalId1:uint;
        private var digitime:uint;
        private var _1667860719questGuideArrow:GuideArrow;
        private var _1127671041SkipTutorialBtn:Button;
        private var _2052872123newEmailNumber:int;
        private var _153867910strVisitLabel:String = "Visiting Empire";
        private var _2608RB:EvonyImage;
        private var _678424838ChatWorld:Button;
        private var _3540562star:SWFLoader;
        private var _1354434640MapToggle:Grid;
        private var _793724443turnableGuide:GuideArrow;
        private var _1081404576mapBtn:Button;
        private var _699853067newQuestNumber:int;
        private var _1650892046cityTabGuide:GuideArrow;
        private var _639292178voteBtn:Button;
        private var curSkin:String = "Normal";
        private var _2145762204skip_btn:Button;
        private var _389548679cityOutBtn:Button;
        private var _1165907430questBtn:Button;
        private var isTheBottom:Boolean = true;
        public var _MainWin_Button9:Button;
        private var distance:Number = 20;
        private var _1560612375immediateNotice:Canvas;
        public var _MainWin_Button8:Button;
        private var _1035415678immediateText:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":MainFrame,
                        "id":"mainFrame",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.horizontalCenter = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":_BottomToolBar,
                        "id":"buildingProgress",
                        "stylesFactory":function ():void
                        {
                            this.top = "44";
                            this.left = "2";
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"DigiChatAllianceBtn",
                        "events":{
                            "mouseOver":"__DigiChatAllianceBtn_mouseOver",
                            "mouseOut":"__DigiChatAllianceBtn_mouseOut",
                            "click":"__DigiChatAllianceBtn_click"
                        },
                        "stylesFactory":function ():void
                        {
                            this.right = "313";
                            this.top = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "source":"fla/dynamic/DigiChatAlliance.swf",
                                "toolTip":"Cultivate a safe and private social network with your alliance members."
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"DigiChatAllianceBtneCanvas",
                        "events":{
                            "mouseOver":"__DigiChatAllianceBtneCanvas_mouseOver",
                            "mouseOut":"__DigiChatAllianceBtneCanvas_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.backgroundColor = 0;
                            this.right = "313";
                            this.top = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "alpha":0.01,
                                "width":180,
                                "height":31
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"DigiFindEvoniansBtn",
                        "events":{
                            "mouseOver":"__DigiFindEvoniansBtn_mouseOver",
                            "mouseOut":"__DigiFindEvoniansBtn_mouseOut",
                            "click":"__DigiFindEvoniansBtn_click"
                        },
                        "stylesFactory":function ():void
                        {
                            this.right = "313";
                            this.top = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "source":"fla/dynamic/DigiFindEvonians.swf",
                                "toolTip":"Digisoical lets you make new friends, meet different people across the world and keep in touch with them at all times and places."
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"DigiFindEvoniansBtnCanvas",
                        "events":{
                            "mouseOver":"__DigiFindEvoniansBtnCanvas_mouseOver",
                            "mouseOut":"__DigiFindEvoniansBtnCanvas_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.backgroundColor = 0;
                            this.right = "313";
                            this.top = "165";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "alpha":0.01,
                                "width":180,
                                "height":31
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"DigiChatTip",
                        "events":{"click":"__DigiChatTip_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "313";
                            this.top = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "source":"fla/dynamic/DigiChatTip.swf",
                                "toolTip":"Get informed promptly with Push Notification."
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"_MainWin_SWFLoader4",
                        "events":{"click":"___MainWin_SWFLoader4_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "313";
                            this.top = "200";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/facebook_small.swf",
                                "toolTip":"Play with your Facebook friends now! Remember they will reinforce your great kingdom!"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":FacebookToolBar,
                        "id":"fbBar",
                        "stylesFactory":function ():void
                        {
                            this.right = "313";
                            this.top = "120";
                            this.bottom = "270";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":80});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "id":"Lborder",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/dynamic/ui234.swf@Lborder.png",
                                "percentHeight":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Lbg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"repeattopbg",
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "-11";
                            this.right = "331";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":39,
                                "styleName":"repeattopbg",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@Ltopbg.png"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.left = "333";
                            this.right = "377";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":_embed_mxml_images_chatbg_jpg_1465891556,
                                "scaleContent":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "id":"rightTopBg",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Rtopbg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "id":"Tborder2",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "34";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Tborder2.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "598";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Rtopic.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "102";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Ltopic.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Grid,
                        "id":"MapToggle",
                        "stylesFactory":function ():void
                        {
                            this.right = "370";
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"MapToggle",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":GridRow,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"cityInBtn",
                                                            "events":{
                                                                "mouseOver":"__cityInBtn_mouseOver",
                                                                "click":"__cityInBtn_click"
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"MapToggle1",
                                                                    "selected":true,
                                                                    "toggle":true
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"cityOutBtn",
                                                            "events":{"click":"__cityOutBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"MapToggle2",
                                                                    "toggle":true
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"mapBtn",
                                                            "events":{"click":"__mapBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"MapToggle3",
                                                                    "toggle":true
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
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Tborder1.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@TL.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@TL2.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.right = "308";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@TR2.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "304";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@TR.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "185";
                            this.left = "420";
                            this.right = "466";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "styleName":"tt"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@LB.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "13";
                            this.top = "435";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/dynamic/ui234.swf@beginner.png",
                                "height":56
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "id":"RB",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@RB.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"topicrepeat",
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.left = "249";
                            this.right = "745.05";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":36,
                                "styleName":"topicrepeat"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@Rboder.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"voteBtn",
                        "events":{
                            "mouseOver":"__voteBtn_mouseOver",
                            "mouseOut":"__voteBtn_mouseOut",
                            "click":"__voteBtn_click"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"voteStyle"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"voteCanvas",
                        "events":{
                            "mouseOver":"__voteCanvas_mouseOver",
                            "mouseOut":"__voteCanvas_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.backgroundColor = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "alpha":0.01,
                                "width":145,
                                "height":48
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":PlayerHeadFrame,
                        "id":"playerInfoFrame",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "9";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":241,
                                "width":302
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"UserName",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "80";
                            this.left = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":200,
                                "height":78,
                                "styleName":"UserName",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MainWin_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "-7";
                                        this.horizontalCenter = "-11";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"UserName",
                                            "filters":[_MainWin_GlowFilter1_c()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Grid,
                        "stylesFactory":function ():void
                        {
                            this.left = "167";
                            this.bottom = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"userinfo",
                                "width":150,
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":GridRow,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "id":"_MainWin_EvonyImage17",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"fla/dynamic/ui234.swf@Honor.png"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"prestigeTxt",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "id":"_MainWin_EvonyImage18",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"fla/dynamic/ui234.swf@Alliance.png"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainWin_Label3",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":AllianceTypeUi,
                                                            "id":"allianceUi",
                                                            "events":{"toolTipShown":"__allianceUi_toolTipShown"}
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":GridRow,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_MainWin_Canvas9",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@Rank.png"});
                                                                        }
                                                                    })]});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainWin_Label4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "id":"_MainWin_EvonyImage20",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"fla/dynamic/ui234.swf@Prestige.png"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainWin_Label5",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":GridRow,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"_MainWin_Canvas10",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":EvonyImage,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"source":"fla/dynamic/ui234.swf@Ranking_by_Prestige.png"});
                                                                        }
                                                                    })]});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainWin_Label6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":EvonyImage,
                                                            "id":"_MainWin_EvonyImage22",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"source":"fla/dynamic/ui234.swf@Title.png"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainWin_Label7",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"leftmaintext"});
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
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@City_name_03.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.right = "10";
                            this.top = "231";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@bg.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":CastleInfoFrame,
                        "id":"castleInfoFrame",
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"y":20});
                        }
                    }), new UIComponentDescriptor({
                        "type":ChatFrame,
                        "id":"chatFrame",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "18";
                            this.left = "352";
                            this.right = "425";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"height":180});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"Chat",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "50";
                            this.left = "375";
                            this.right = "400";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":130,
                                "styleName":"Chat",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"text_chat",
                                    "events":{
                                        "scroll":"__text_chat_scroll",
                                        "updateComplete":"__text_chat_updateComplete",
                                        "change":"__text_chat_change",
                                        "dataChange":"__text_chat_dataChange"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "1";
                                        this.top = "1";
                                        this.bottom = "1";
                                        this.right = "1";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ChatText",
                                            "editable":false,
                                            "selectable":true
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"allCityList",
                        "stylesFactory":function ():void
                        {
                            this.top = "44";
                            this.bottom = "200";
                            this.right = "239";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":66,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.top = "40";
                                        this.bottom = "40";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":65,
                                            "styleName":"CityListBg"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllCastleFrame,
                                    "id":"allCastleFrame",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":66});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"ChatWorld",
                        "events":{"click":"__ChatWorld_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "10";
                            this.left = "375";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ChatWorld",
                                "toggle":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___MainWin_Button6_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "6";
                            this.right = "444";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"ChatSend"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___MainWin_Button7_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "400";
                            this.bottom = "6";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"ChatHeight"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "6";
                            this.left = "460";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@ChatInp.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "6";
                            this.left = "466";
                            this.right = "483";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":37,
                                "styleName":"ChatInp",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"text_input",
                                    "events":{
                                        "change":"__text_input_change",
                                        "keyDown":"__text_input_keyDown"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.right = "0";
                                        this.verticalCenter = "-2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ChatInpbg",
                                            "height":29,
                                            "maxChars":150
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Grid,
                        "id":"MainMenu",
                        "stylesFactory":function ():void
                        {
                            this.right = "2";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"MainMenu",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":GridRow,
                                    "id":"row1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button8",
                                                            "events":{"click":"___MainWin_Button8_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon1"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button9",
                                                            "events":{"click":"___MainWin_Button9_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon2"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "id":"gridQuest",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"questBtn",
                                                            "events":{"click":"__questBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon3"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button11",
                                                            "events":{"click":"___MainWin_Button11_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon4"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":GridRow,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button12",
                                                            "events":{"click":"___MainWin_Button12_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon5"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button13",
                                                            "events":{"click":"___MainWin_Button13_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon6"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button14",
                                                            "events":{"click":"___MainWin_Button14_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon7"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":GridItem,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MainWin_Button15",
                                                            "events":{"click":"___MainWin_Button15_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"MainIcon8"});
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
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "108";
                            this.right = "81";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_MainWin_EvonyImage26",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@redInfoAmount.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MainWin_Label8",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "9";
                                        this.right = "8";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":29,
                                            "styleName":"PropertyValue1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "108";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_MainWin_EvonyImage27",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@greenInfoAmount.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MainWin_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "9";
                                        this.right = "8";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":29,
                                            "styleName":"PropertyValue1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "35";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_MainWin_EvonyImage28",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@mailAmount.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MainWin_Label10",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "9";
                                        this.right = "8";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":29,
                                            "styleName":"PropertyValue1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"UserButton",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "3";
                            this.left = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":124,
                                "height":97,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"overview",
                                    "events":{"click":"__overview_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"overview"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"myitems",
                                    "events":{"click":"__myitems_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"myitems"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"friendslist",
                                    "events":{"click":"__friendslist_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"friendslist"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ToolBarFrame,
                        "id":"tbfrm",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":350,
                                "height":160
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"buttonPanel",
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":45,
                                "y":12,
                                "percentHeight":100,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":UIComponent,
                                    "id":"giftboxUi",
                                    "events":{
                                        "click":"__giftboxUi_click",
                                        "toolTipShown":"__giftboxUi_toolTipShown"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "includeInLayout":true,
                                            "width":22,
                                            "height":23
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"autofit",
                                    "events":{"click":"__autofit_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"restore",
                                            "toolTip":"Auto Fit"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainWin_Button20",
                                    "events":{"click":"___MainWin_Button20_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"quit"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"moveTextCanvas",
                        "stylesFactory":function ():void
                        {
                            this.left = "141";
                            this.right = "640";
                            this.top = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":20,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":UIComponent,
                                    "id":"moveTextUi",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "includeInLayout":true,
                                            "width":490,
                                            "height":36
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":MainFramePlayerBuff,
                        "id":"buff",
                        "stylesFactory":function ():void
                        {
                            this.right = "330";
                            this.top = "50";
                        }
                    }), new UIComponentDescriptor({
                        "type":MapPos,
                        "id":"mapPosBox",
                        "stylesFactory":function ():void
                        {
                            this.right = "325";
                            this.top = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "includeInLayout":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":QuestBtnTooltip,
                        "id":"myQuestBtnTooltip",
                        "stylesFactory":function ():void
                        {
                            this.right = "58";
                            this.bottom = "123";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"visible":false});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_MainWin_Button21",
                        "events":{"click":"___MainWin_Button21_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "152";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":153,
                                "styleName":"tavernBtn",
                                "toolTip":"Famous Historic Heroes"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"equipBtn",
                        "events":{"click":"__equipBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "185";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":153,
                                "styleName":"equipBtn"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_MainWin_Button23",
                        "events":{"click":"___MainWin_Button23_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "218";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":153,
                                "styleName":"stoneBtn",
                                "toolTip":""
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":UIComponent,
                        "id":"guideUC",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":-24,
                                "y":3,
                                "percentWidth":100,
                                "percentHeight":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_MainWin_Button24",
                        "events":{"click":"___MainWin_Button24_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "119";
                            this.bottom = "152";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"GetMoreCoins"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"immediateBtn",
                        "events":{
                            "click":"__immediateBtn_click",
                            "mouseOver":"__immediateBtn_mouseOver",
                            "mouseOut":"__immediateBtn_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.right = "8";
                            this.bottom = "154";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"Turntable"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"skip_btn",
                        "events":{"click":"__skip_btn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "320";
                            this.bottom = "212";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"skip",
                                "styleName":"b75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"SkipTutorialBtn",
                        "events":{"click":"__SkipTutorialBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"skipGuideBtn",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"saveGameBtn",
                        "events":{"click":"__saveGameBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"saveGameBtn"});
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"turnnotice",
                        "stylesFactory":function ():void
                        {
                            this.right = "26";
                            this.bottom = "204";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/turn_1.swf",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"report",
                        "events":{"click":"__report_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "2";
                            this.bottom = "73";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/report.swf",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "400";
                            this.bottom = "212";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainWin_Button29",
                                    "events":{"click":"___MainWin_Button29_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "toolTip":"You can check your Neighbor’s Achievements detail here.",
                                            "label":"Achievements",
                                            "styleName":"b75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainWin_Button30",
                                    "events":{"click":"___MainWin_Button30_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "toolTip":"Help increase your Neighbor’s resources production and get reward.",
                                            "label":"Help increase production",
                                            "styleName":"b75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainWin_Button31",
                                    "events":{"click":"___MainWin_Button31_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "toolTip":"Check your Neighbor’s top heroes.",
                                            "styleName":"b75"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MainWin_Button32",
                                    "events":{"click":"___MainWin_Button32_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "toolTip":"Give a comment on his empire and cities.",
                                            "label":"Leave a message",
                                            "styleName":"b75"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"bookmark",
                        "events":{"click":"__bookmark_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "255";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/bookmark.swf",
                                "toolTip":"Bookmark evony to your Facebook."
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"gift",
                        "events":{"click":"__gift_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "255";
                            this.left = "100";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/gift.swf",
                                "toolTip":"Bestow friends gifts.",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"shoe",
                        "events":{"click":"__shoe_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "255";
                            this.left = "100";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/shoe.swf",
                                "toolTip":"Company arrives.",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"immediateNoticeBox",
                        "stylesFactory":function ():void
                        {
                            this.top = "60";
                            this.left = "10";
                            this.right = "316";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "includeInLayout":false,
                                "mouseChildren":false,
                                "mouseEnabled":false,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"immediateNotice",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "visible":false,
                                            "x":209,
                                            "width":500,
                                            "height":130,
                                            "includeInLayout":false,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"immediateText",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "20";
                                                    this.top = "20";
                                                    this.right = "20";
                                                    this.color = 0xFFFFFF;
                                                    this.fontSize = 14;
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"height":91});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"questGuideArrow",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "145";
                            this.right = "123";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"questGuideArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"townTabGuide",
                        "stylesFactory":function ():void
                        {
                            this.top = "37";
                            this.right = "560";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"tabGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"cityTabGuide",
                        "stylesFactory":function ():void
                        {
                            this.top = "37";
                            this.right = "486";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"tabGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"speedupArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "58";
                            this.left = "423";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"itemGuideArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"turnableGuide",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "202";
                            this.right = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowBGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"myItemGuide",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "51";
                            this.left = "155";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"arrowLGuide"});
                        }
                    }), new UIComponentDescriptor({
                        "type":view.module.guide.guideLady,
                        "id":"guideLady",
                        "stylesFactory":function ():void
                        {
                            this.left = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"height":140});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"soundBtn",
                        "events":{"click":"__soundBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"SoundBtn",
                                "selected":true
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"visitLabel",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.top = "70";
                            this.fontSize = 22;
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "mouseEnabled":false,
                                "mouseChildren":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"populationArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "170";
                            this.right = "155";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"guideViewArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"foodArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "255";
                            this.right = "140";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"guideViewArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"lumberArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "288";
                            this.right = "140";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"guideViewArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"stoneArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "330";
                            this.right = "140";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"guideViewArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"ironArrow",
                        "stylesFactory":function ():void
                        {
                            this.top = "365";
                            this.right = "140";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"guideViewArrow"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_MainWin_Label12",
                        "stylesFactory":function ():void
                        {
                            this.right = "110";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"selectable":true});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.right = "4";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "selectable":true,
                                "htmlText":"<font color='#ffffff' size = '12'><a href='http://www.evony.com/index.do?PageModule=Static&type=PrivacyPolicy' target='_blank'><u>Privacy Policy</u></a></font>"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"starPic",
                        "events":{"click":"__starPic_click"},
                        "stylesFactory":function ():void
                        {
                            this.left = "450";
                            this.top = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/feed/star5.png",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":SWFLoader,
                        "id":"star",
                        "events":{"click":"__star_click"},
                        "stylesFactory":function ():void
                        {
                            this.left = "450";
                            this.top = "300";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/star.swf",
                                "visible":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Questwizard,
                        "id":"wizadrd",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "200";
                        }
                    }), new UIComponentDescriptor({
                        "type":FieldInfoWin,
                        "id":"showNew",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "-150";
                            this.verticalCenter = "-30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "includeInLayout":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":AllWindows,
                        "id":"allWindowsFrame",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "visible":false,
                                "width":819,
                                "height":555
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"addMoneyPic",
                        "events":{"click":"__addMoneyPic_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"",
                                "visible":false
                            });
                        }
                    })]});
            }
        });
        private var loadTimer:Timer = new Timer(300000, 0);
        private var noticeTimer:Timer = new Timer(7000, 0);
        private var showInfoTimer:Timer = new Timer(6000, 0);
        private var closeWinTimer:Timer = new Timer(6000, 1);
        private var randomEvent2:Timer = new Timer(300000);
        private var digiMsgCountTimer:Timer = new Timer(60000, 0);
        private var textRect:Rectangle = new Rectangle(0, 0, 465, 18);
        private var _805808750helpUrl:String = (("<font color='#ffffff' size = '12'><a href='" + GameConfig.instance.help) + "' target='_blank'><u>Contact Us</u></a></font>");
        private var _embed_css_images_Bborder_png_273760257:Class = MainWin__embed_css_images_Bborder_png_273760257;
        private var _embed_css_images_M_chat_png_177062443:Class = MainWin__embed_css_images_M_chat_png_177062443;
        private var _embed_css_images_repeattopbg_png_1199364659:Class = MainWin__embed_css_images_repeattopbg_png_1199364659;
        private var _embed_css_images_topicrepeat_png_2105565817:Class = MainWin__embed_css_images_topicrepeat_png_2105565817;
        private var _embed_mxml_images_chatbg_jpg_1465891556:Class = MainWin__embed_mxml_images_chatbg_jpg_1465891556;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MainWin()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.verticalCenter = "0";
                this.horizontalCenter = "0";
            };
            (mx_internal::_MainWin_StylesInit());
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            _MainWin_Iris2_i();
            _MainWin_Iris1_i();
            this.addEventListener("initialize", ___MainWin_Canvas1_initialize);
            this.addEventListener("creationComplete", ___MainWin_Canvas1_creationComplete);
        }

        public static function getCurrentFPS():Number
        {
            var _local_1:Number;
            if (lastCalcFPSTime == 0)
            {
                lastCalcFPSTime = getTimer();
                currentFPS = 15;
            }
            else
            {
                _local_1 = ((getTimer() - lastCalcFPSTime) / 1000);
                if (_local_1 > 20)
                {
                    currentFPS = (nFramecount / _local_1);
                    nFramecount = 0;
                    lastCalcFPSTime = getTimer();
                };
            };
            return (currentFPS);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MainWin._watcherSetupUtil = _arg_1;
        }


        public function recalcPopupCenter():void
        {
            if (this.width < 1200)
            {
                allWinFrmHv = 0;
            }
            else
            {
                allWinFrmHv = (-150 * this.scaleX);
            };
            if (this.height < 800)
            {
                allWinFrmVv = 0;
            }
            else
            {
                allWinFrmVv = (-30 * this.scaleY);
            };
        }

        public function __cityInBtn_click(_arg_1:MouseEvent):void
        {
            onCityInClick();
        }

        [Bindable(event="propertyChange")]
        public function get speedupArrow():GuideArrow
        {
            return (this._51654649speedupArrow);
        }

        public function set tbfrm(_arg_1:ToolBarFrame):void
        {
            var _local_2:Object;
            _local_2 = this._110149619tbfrm;
            if (_local_2 !== _arg_1)
            {
                this._110149619tbfrm = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tbfrm", _local_2, _arg_1));
            };
        }

        private function clickStar():void
        {
            this.star.visible = false;
            this.starPic.visible = false;
            RandomEventWin.show(4);
        }

        private function refreshPage():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(FUNCTION_REFRESH);
            };
        }

        public function set autofit(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._646308862autofit;
            if (_local_2 !== _arg_1)
            {
                this._646308862autofit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autofit", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get equipBtn():Button
        {
            return (this._588869644equipBtn);
        }

        public function set speedupArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._51654649speedupArrow;
            if (_local_2 !== _arg_1)
            {
                this._51654649speedupArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "speedupArrow", _local_2, _arg_1));
            };
        }

        public function __text_chat_dataChange(_arg_1:FlexEvent):void
        {
            onTextDataChange(_arg_1);
        }

        public function ___MainWin_Canvas1_initialize(_arg_1:FlexEvent):void
        {
            recalcPopupCenter();
        }

        public function ___MainWin_Button8_click(_arg_1:MouseEvent):void
        {
            onShopBtnClick();
        }

        [Bindable(event="propertyChange")]
        public function get DigiChatTip():SWFLoader
        {
            return (this._1861656612DigiChatTip);
        }

        public function set issueQuestPos(_arg_1:int):void
        {
            var _local_2:Object;
            _local_2 = this._238289419issueQuestPos;
            if (_local_2 !== _arg_1)
            {
                this._238289419issueQuestPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "issueQuestPos", _local_2, _arg_1));
            };
        }

        public function set equipBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._588869644equipBtn;
            if (_local_2 !== _arg_1)
            {
                this._588869644equipBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "equipBtn", _local_2, _arg_1));
            };
        }

        public function ___MainWin_SWFLoader4_click(_arg_1:MouseEvent):void
        {
            onFbLink();
        }

        private function onMouseOver():void
        {
            clearTimeout(intervalId);
            trace("onMouseOver");
        }

        public function set buttonPanel(_arg_1:HBox):void
        {
            var _local_2:Object;
            _local_2 = this._1773821454buttonPanel;
            if (_local_2 !== _arg_1)
            {
                this._1773821454buttonPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonPanel", _local_2, _arg_1));
            };
        }

        public function onCityInClick():void
        {
            cityInBtn.selected = true;
            cityOutBtn.selected = false;
            mapBtn.selected = false;
            MainFrame.instance.switchToInner();
            this.mapPosBox.visible = false;
            this.autofit.visible = true;
            if (Context.getInstance().needUserGuide)
            {
                if (GuideStep.getInstance().currentStep == 90001)
                {
                    GuideStep.getInstance().step90001();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get ironArrow():GuideArrow
        {
            return (this._1045836767ironArrow);
        }

        public function __ChatWorld_click(_arg_1:MouseEvent):void
        {
            ChatFrame.instance.onChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get autofit():Button
        {
            return (this._646308862autofit);
        }

        [Bindable(event="propertyChange")]
        private function get noticeText():String
        {
            return (this._1269291995noticeText);
        }

        public function __DigiFindEvoniansBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMousedigiOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get tbfrm():ToolBarFrame
        {
            return (this._110149619tbfrm);
        }

        public function set questBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1165907430questBtn;
            if (_local_2 !== _arg_1)
            {
                this._1165907430questBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questBtn", _local_2, _arg_1));
            };
        }

        private function onRemoveSecurityCode(_arg_1:SecurityCodeRemovedEvent):void
        {
            Context.getInstance().getPlayerBean().isSetSecurityCode = false;
        }

        private function showCj():void
        {
            cj.show();
        }

        public function set immediateNotice(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1560612375immediateNotice;
            if (_local_2 !== _arg_1)
            {
                this._1560612375immediateNotice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "immediateNotice", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get glRight():Number
        {
            return (this._94506039glRight);
        }

        public function onFinishInfoMsg(_arg_1:String):void
        {
            immediateNoticeBox.includeInLayout = true;
            immediateNoticeBox.visible = true;
            immediateNotice.visible = true;
            noticeTimer.start();
            noticeText = _arg_1;
        }

        public function set ironArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._1045836767ironArrow;
            if (_local_2 !== _arg_1)
            {
                this._1045836767ironArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironArrow", _local_2, _arg_1));
            };
        }

        private function onShowAmountInputUI():void
        {
            AmountInputUI.show();
        }

        [Bindable(event="propertyChange")]
        public function get cityInBtn():Button
        {
            return (this._1126740916cityInBtn);
        }

        public function set allWinFrmVv(_arg_1:Object):void
        {
            var _local_2:Object;
            _local_2 = this._969159162allWinFrmVv;
            if (_local_2 !== _arg_1)
            {
                this._969159162allWinFrmVv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allWinFrmVv", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buff():MainFramePlayerBuff
        {
            return (this._3035219buff);
        }

        private function onRankBtnClick():void
        {
            AllWindows.switchToFuncWindow(RankWin.EVENT_SHOW);
        }

        private function set noticeText(_arg_1:String):void
        {
            var _local_2:Object;
            _local_2 = this._1269291995noticeText;
            if (_local_2 !== _arg_1)
            {
                this._1269291995noticeText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noticeText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allWinFrmHv():Object
        {
            return (this._969159596allWinFrmHv);
        }

        public function set RB(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._2608RB;
            if (_local_2 !== _arg_1)
            {
                this._2608RB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "RB", _local_2, _arg_1));
            };
        }

        public function __DigiFindEvoniansBtnCanvas_mouseOver(_arg_1:MouseEvent):void
        {
            onMousedigiOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get visitLabel():Label
        {
            return (this._1865426839visitLabel);
        }

        private function onCityOutClik():void
        {
            cityInBtn.selected = false;
            cityOutBtn.selected = true;
            mapBtn.selected = false;
            MainFrame.instance.switchToOutside();
            this.mapPosBox.visible = false;
            this.autofit.visible = true;
            if (Context.getInstance().needUserGuide)
            {
                if (GuideStep.getInstance().currentStep == 50001)
                {
                    GuideStep.getInstance().step50001();
                };
            };
        }

        public function set irisOut(_arg_1:Iris):void
        {
            var _local_2:Object;
            _local_2 = this._2062804539irisOut;
            if (_local_2 !== _arg_1)
            {
                this._2062804539irisOut = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "irisOut", _local_2, _arg_1));
            };
        }

        public function __SkipTutorialBtn_click(_arg_1:MouseEvent):void
        {
            skipTutorial();
        }

        public function __text_input_keyDown(_arg_1:KeyboardEvent):void
        {
            ChatFrame.instance.onSendMsg(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get moveTextUi():UIComponent
        {
            return (this._1565524014moveTextUi);
        }

        public function set glRight(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._94506039glRight;
            if (_local_2 !== _arg_1)
            {
                this._94506039glRight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glRight", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get immediateText():Text
        {
            return (this._1035415678immediateText);
        }

        public function set text_input(_arg_1:TextInput):void
        {
            var _local_2:Object;
            _local_2 = this._2109822408text_input;
            if (_local_2 !== _arg_1)
            {
                this._2109822408text_input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text_input", _local_2, _arg_1));
            };
        }

        public function __starPic_click(_arg_1:MouseEvent):void
        {
            clickStar();
        }

        [Bindable(event="propertyChange")]
        public function get addMoneyPic():Image
        {
            return (this._1306653589addMoneyPic);
        }

        public function set newEmailNumber(_arg_1:int):void
        {
            var _local_2:Object;
            _local_2 = this._2052872123newEmailNumber;
            if (_local_2 !== _arg_1)
            {
                this._2052872123newEmailNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newEmailNumber", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newEmailNumber():int
        {
            return (this._2052872123newEmailNumber);
        }

        private function setBgBtn(_arg_1:MovieClip, _arg_2:UIComponent):void
        {
            _arg_1.gotoAndStop("over");
            _arg_2.addChild(_arg_1);
        }

        public function showHero():void
        {
            var _local_1:OtherPlayerHero = new OtherPlayerHero();
            if (!_local_1.isPopUp)
            {
                PopUpManager.addPopUp(_local_1, MainFrame.instance, false);
            }
            else
            {
                PopUpManager.bringToFront(_local_1);
            };
            _local_1.setHeroList(Context.getInstance().getCurCastle().herosArray);
        }

        public function set cityInBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1126740916cityInBtn;
            if (_local_2 !== _arg_1)
            {
                this._1126740916cityInBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityInBtn", _local_2, _arg_1));
            };
        }

        public function ___MainWin_Button21_click(_arg_1:MouseEvent):void
        {
            onTavernNews(_arg_1);
        }

        private function onDigiChatTip():void
        {
            var _local_1:* = "http://latest.digisocial.com/appjoin?";
            _local_1 = (_local_1 + (("email=" + playerInfoBean.accountName) + "&"));
            _local_1 = (_local_1 + "appid=2&");
            _local_1 = (_local_1 + (("username=" + playerInfoBean.userName) + "&"));
            _local_1 = (_local_1 + (("pwdhash=" + MD5.hash(EvonyClient.password)) + "&"));
            _local_1 = (_local_1 + "type=guild&");
            _local_1 = (_local_1 + (("guildname=" + playerInfoBean.alliance) + "&"));
            _local_1 = (_local_1 + ("guildlevel=" + playerInfoBean.allianceLevel));
            var _local_2:String = MD5.hash((_local_1 + "9f758e2deccbe6244f734371b9642eda"));
            _local_1 = (_local_1 + ("&key=" + _local_2));
            trace(_local_1);
            navigateToURL(new URLRequest(_local_1), "_blank");
        }

        [Bindable(event="propertyChange")]
        public function get irisIn():Iris
        {
            return (this._1180384104irisIn);
        }

        [Bindable(event="propertyChange")]
        private function get isBookMark():Boolean
        {
            return (this._1211154592isBookMark);
        }

        private function upHandle(_arg_1:MouseEvent):void
        {
            randomEvent2.stop();
            randomEvent2.start();
        }

        public function set star(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._3540562star;
            if (_local_2 !== _arg_1)
            {
                this._3540562star = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "star", _local_2, _arg_1));
            };
        }

        public function __immediateBtn_mouseOver(_arg_1:MouseEvent):void
        {
            this.turnnotice.visible = true;
        }

        private function polldigitimecompleteerrorHandler(_arg_1:Event):void
        {
            trace("polldigitimecompleteerrorHandler");
        }

        public function set buff(_arg_1:MainFramePlayerBuff):void
        {
            var _local_2:Object;
            _local_2 = this._3035219buff;
            if (_local_2 !== _arg_1)
            {
                this._3035219buff = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buff", _local_2, _arg_1));
            };
        }

        public function set foodArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._1138195893foodArrow;
            if (_local_2 !== _arg_1)
            {
                this._1138195893foodArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodArrow", _local_2, _arg_1));
            };
        }

        private function onQuestFinish(_arg_1:QuestCompleteTipResponse):void
        {
            var _local_2:Object = FbData.getInstance().getValue(_arg_1.questId);
            if (_local_2 != null)
            {
                EffortFinishWin.show(_arg_1.quest);
                if (cj.instance != null)
                {
                    cj.instance.refresh();
                };
            };
        }

        public function set allWinFrmHv(_arg_1:Object):void
        {
            var _local_2:Object;
            _local_2 = this._969159596allWinFrmHv;
            if (_local_2 !== _arg_1)
            {
                this._969159596allWinFrmHv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allWinFrmHv", _local_2, _arg_1));
            };
        }

        private function onEnterFrame(_arg_1:Event):void
        {
            nFramecount++;
            if ((((!(questButton == null)) && (!(Context.getInstance().needUserGuide))) && ((nFramecount % 10) == 0)))
            {
                if (newQuestNumber > 0)
                {
                    if (questButton.styleName == "MainIcon31")
                    {
                        questButton.styleName = "MainIcon3";
                    }
                    else
                    {
                        questButton.styleName = "MainIcon31";
                    };
                }
                else
                {
                    questButton.styleName = "MainIcon3";
                };
            };
        }

        public function ___MainWin_Button32_click(_arg_1:MouseEvent):void
        {
            WriteComment();
        }

        private function setBoxNum(_arg_1:GetPackageNumberResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Object(_loader.content).setNumber(_arg_1.number);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get lumberArrow():GuideArrow
        {
            return (this._9038014lumberArrow);
        }

        public function HelpIncrease():void
        {
            IncreaseProduct.show();
        }

        public function doCenter():void
        {
            if (MainFrame.instance != null)
            {
                MainFrame.instance.doCenter();
            };
        }

        private function loadError():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get populationArrow():GuideArrow
        {
            return (this._156526404populationArrow);
        }

        public function ___MainWin_Button15_click(_arg_1:MouseEvent):void
        {
            onMailBtnClick();
        }

        public function ___MainWin_Button7_click(_arg_1:MouseEvent):void
        {
            Chat_height();
        }

        private function onTextDataChange(_arg_1:FlexEvent):void
        {
            _arg_1.stopPropagation();
        }

        public function set addMoneyPic(_arg_1:Image):void
        {
            var _local_2:Object;
            _local_2 = this._1306653589addMoneyPic;
            if (_local_2 !== _arg_1)
            {
                this._1306653589addMoneyPic = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "addMoneyPic", _local_2, _arg_1));
            };
        }

        private function onDigiMsgCountTimer(_arg_1:TimerEvent):void
        {
            immediateNoticeBox.visible = false;
            immediateNotice.visible = false;
            immediateNoticeBox.includeInLayout = false;
            noticeTimer.stop();
        }

        private function loadTimeHandle(_arg_1:TimerEvent):void
        {
            if (GameConfig.instance.strMovingText != "")
            {
                if (Context.getInstance().facebookUser)
                {
                    UIUtil.loadFile(GameConfig.instance.strFbMovingText, textLoaded);
                }
                else
                {
                    UIUtil.loadFile(GameConfig.instance.strMovingText, textLoaded);
                };
            }
            else
            {
                if (Context.getInstance().facebookUser)
                {
                    UIUtil.loadFile("MovingTexFB.txt", textLoaded);
                }
                else
                {
                    UIUtil.loadFile("movingText.txt", textLoaded);
                };
            };
        }

        private function onMousedigiOut(_arg_1:Event):void
        {
            if (digitime30 == 0)
            {
                trace("-------------------");
                trace(("onMousedigiOut:" + _arg_1.target.id));
                trace(("onMousedigiOut:" + _arg_1.currentTarget.id));
                if (_arg_1.currentTarget.id == "DigiChatAllianceBtn")
                {
                };
                if (_arg_1.currentTarget.id == "DigiFindEvoniansBtn")
                {
                };
                if (_arg_1.currentTarget.id == "DigiChatAllianceBtneCanvas")
                {
                    clearTimeout(digitime);
                };
                if (_arg_1.currentTarget.id == "DigiFindEvoniansBtnCanvas")
                {
                    clearTimeout(digitime);
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get saveGameBtn():Button
        {
            return (this._495025357saveGameBtn);
        }

        [Bindable(event="propertyChange")]
        public function get skipBtnBottom():Number
        {
            return (this._879245080skipBtnBottom);
        }

        [Bindable(event="propertyChange")]
        public function get voteCanvas():Canvas
        {
            return (this._1279483106voteCanvas);
        }

        [Bindable(event="propertyChange")]
        public function get DigiChatAllianceBtn():SWFLoader
        {
            return (this._784993510DigiChatAllianceBtn);
        }

        public function ___MainWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set DigiChatAllianceBtneCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1290566025DigiChatAllianceBtneCanvas;
            if (_local_2 !== _arg_1)
            {
                this._1290566025DigiChatAllianceBtneCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DigiChatAllianceBtneCanvas", _local_2, _arg_1));
            };
        }

        public function set visitLabel(_arg_1:Label):void
        {
            var _local_2:Object;
            _local_2 = this._1865426839visitLabel;
            if (_local_2 !== _arg_1)
            {
                this._1865426839visitLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "visitLabel", _local_2, _arg_1));
            };
        }

        public function __addMoneyPic_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        private function addBookmark():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("facebook.fb_addBookmark");
            };
            addBookMarkSo.data.accountName = playerInfoBean.accountName;
            addBookMarkSo.data.isBookMark = true;
            this.isBookMark = true;
        }

        [Bindable(event="propertyChange")]
        public function get questGuideArrow():GuideArrow
        {
            return (this._1667860719questGuideArrow);
        }

        private function set helpUrl(_arg_1:String):void
        {
            var _local_2:Object;
            _local_2 = this._805808750helpUrl;
            if (_local_2 !== _arg_1)
            {
                this._805808750helpUrl = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "helpUrl", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allWindowsFrame():AllWindows
        {
            return (this._261712661allWindowsFrame);
        }

        [Bindable(event="propertyChange")]
        public function get newUsualReportNumber():int
        {
            return (this._1822582529newUsualReportNumber);
        }

        private function init():void
        {
            var _local_4:SharedObject;
            MouseManager.setNormal();
            trace((this.className + ".init()"));
            instance = this;
            EvonyClient(this.parent.parent).doResizeLimited();
            if (Context.getInstance().needUserGuide)
            {
                initGuid();
            };
            playerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            this.addEventListener(KeyboardEvent.KEY_DOWN, onEnterKeyDown);
            mainFrame.showTownView();
            loadTimeHandle(null);
            this.loadTimer.addEventListener(TimerEvent.TIMER, loadTimeHandle);
            this.loadTimer.start();
            closeWinTimer.addEventListener(TimerEvent.TIMER, onCloseWin);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_QUEST_COMPLETE_TIP_RESPONSE, onQuestFinish);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SECURITY_CODE_REMOVED_EVENT, onRemoveSecurityCode);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SYSTEM_INFO_MSG, onServerSystemInfoMsg);
            this.noticeTimer.addEventListener(TimerEvent.TIMER, onNoticeTimer);
            this.digiMsgCountTimer.addEventListener(TimerEvent.TIMER, onDigiMsgCountTimer);
            this.showInfoTimer.addEventListener(TimerEvent.TIMER, onShowInfoTimer);
            this.showInfoTimer.start();
            this.dispatchEvent(new MainWinInitEnd());
            getGiftBox();
            this.addEventListener(TextEvent.LINK, linkHandler);
            newEmailNumber = Context.getInstance().getPlayerBean().newMailCount;
            this.newUsualReportNumber = Context.getInstance().getPlayerBean().newReportCount;
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_PLAYINFO_UPDATE, onPlayerInofUpdate);
            var _local_1:SharedObject = SharedObject.getLocal("skipAnimation", "/");
            if (Context.getInstance().needUserGuide)
            {
                this.skip_btn.visible = false;
                allWindowsFrame.visible = false;
                this.SkipTutorialBtn.visible = true;
            }
            else
            {
                if (_local_1.data.value == true)
                {
                    this.skip_btn.visible = false;
                    if (!Context.getInstance().bVisitor)
                    {
                        allWindowsFrame.visible = true;
                    };
                };
            };
            addBookMarkSo = SharedObject.getLocal("addBookMark");
            if (addBookMarkSo.data.accountName == playerInfoBean.accountName)
            {
                isBookMark = addBookMarkSo.data.isBookMark;
            };
            MainWin.instance.addEventListener(MouseEvent.MOUSE_UP, upHandle);
            this.randomEvent2.addEventListener(TimerEvent.TIMER, randomEvent2Handle);
            randomEvent2.start();
            AllWindows.instance.qusetWinVs.addEventListener(HasQuestEvent.HAS_QUEST, tbfrm.onHasTask);
            recalcPopupCenter();
            var _local_2:GridRow = (MainMenu.getChildByName("row1") as GridRow);
            var _local_3:GridItem = (_local_2.getChildByName("gridQuest") as GridItem);
            questButton = (_local_3.getChildByName("questBtn") as Button);
            strVisitLabel = (("Visiting " + Context.getInstance().bVisitHostName) + "'s Empire");
            MainFrame.instance.doCenter();
            if (!Context.getInstance().needUserGuide)
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("socialBar.showSocialBar");
                };
            };
            if (((!(Context.getInstance().getPlayerBean().tutorialStepId == 1000)) && (Context.getInstance().needUserGuide)))
            {
                this.guideLady.guideLadyStep = Context.getInstance().getPlayerBean().tutorialStepId;
            };
            makeScreenShot();
            if (((UIUtil.checkOffice()) || (UIUtil.judgeTime() >= 7)))
            {
                _local_4 = SharedObject.getLocal("SecurityCodeNotice20111117", "/");
                if (_local_4.data.value == null)
                {
                    SecurityCodeNotice.show();
                    _local_4.data.value = "SecurityCodeNotice";
                    _local_4.flush();
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get newQuestNumber():int
        {
            return (this._699853067newQuestNumber);
        }

        public function __DigiChatAllianceBtn_click(_arg_1:MouseEvent):void
        {
            onDigiAllianceLink();
        }

        [Bindable(event="propertyChange")]
        public function get chatFrame():ChatFrame
        {
            return (this._1596947701chatFrame);
        }

        [Bindable(event="propertyChange")]
        public function get immediateBtn():Button
        {
            return (this._33383659immediateBtn);
        }

        [Bindable(event="propertyChange")]
        public function get buildingProgress():_BottomToolBar
        {
            return (this._685065473buildingProgress);
        }

        private function onShowInfoTimer(_arg_1:TimerEvent):void
        {
            this.myQuestBtnTooltip.visible = false;
            this.showInfoTimer.stop();
        }

        [Bindable(event="propertyChange")]
        public function get UserName():Canvas
        {
            return (this._202022634UserName);
        }

        public function set giftboxUi(_arg_1:UIComponent):void
        {
            var _local_2:Object;
            _local_2 = this._573249167giftboxUi;
            if (_local_2 !== _arg_1)
            {
                this._573249167giftboxUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giftboxUi", _local_2, _arg_1));
            };
        }

        public function __bookmark_click(_arg_1:MouseEvent):void
        {
            addBookmark();
        }

        [Bindable(event="propertyChange")]
        public function get townTabGuide():GuideArrow
        {
            return (this._464330009townTabGuide);
        }

        private function onShopBtnClick():void
        {
            AllWindows.switchToFuncWindow(ShopWin.EVENT_SHOW);
        }

        public function __immediateBtn_click(_arg_1:MouseEvent):void
        {
            onShowNoticeList();
        }

        private function onEnterKeyDown(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == 13)
            {
                if (EnterKeyDispatcher.instance.isEnterKey)
                {
                    this.chatFrame.setFocusForWrite();
                }
                else
                {
                    trace("there is no focus");
                };
            };
        }

        public function set immediateText(_arg_1:Text):void
        {
            var _local_2:Object;
            _local_2 = this._1035415678immediateText;
            if (_local_2 !== _arg_1)
            {
                this._1035415678immediateText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "immediateText", _local_2, _arg_1));
            };
        }

        public function hideTimerOut():void
        {
            voteCanvas.visible = false;
            this.voteBtn.visible = true;
            intervalId = setTimeout(hideVoteBtn, 10000);
        }

        public function set guideUC(_arg_1:UIComponent):void
        {
            var _local_2:Object;
            _local_2 = this._373257866guideUC;
            if (_local_2 !== _arg_1)
            {
                this._373257866guideUC = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "guideUC", _local_2, _arg_1));
            };
        }

        private function changealphaalliace():void
        {
            this.DigiChatAllianceBtn.alpha = (this.DigiChatAllianceBtn.alpha - 0.1);
            if (this.DigiChatAllianceBtn.alpha <= 0)
            {
                this.DigiChatAllianceBtn.alpha = 0;
                this.DigiChatAllianceBtn.visible = false;
                this.DigiChatAllianceBtneCanvas.visible = true;
                digichatallianceBtntime = 0;
            }
            else
            {
                digichatallianceBtntime = setTimeout(changealphaalliace, 300);
            };
        }

        [Bindable(event="propertyChange")]
        public function get DigiFindEvoniansBtn():SWFLoader
        {
            return (this._200298193DigiFindEvoniansBtn);
        }

        [Bindable(event="propertyChange")]
        public function get gift():SWFLoader
        {
            return (this._3172656gift);
        }

        [Bindable(event="propertyChange")]
        public function get bookmark():SWFLoader
        {
            return (this._2005378358bookmark);
        }

        public function set irisIn(_arg_1:Iris):void
        {
            var _local_2:Object;
            _local_2 = this._1180384104irisIn;
            if (_local_2 !== _arg_1)
            {
                this._1180384104irisIn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "irisIn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceUi():AllianceTypeUi
        {
            return (this._1306698027allianceUi);
        }

        public function __star_click(_arg_1:MouseEvent):void
        {
            clickStar();
        }

        [Bindable(event="propertyChange")]
        public function get myQuestBtnTooltip():QuestBtnTooltip
        {
            return (this._1859770051myQuestBtnTooltip);
        }

        private function set isBookMark(_arg_1:Boolean):void
        {
            var _local_2:Object;
            _local_2 = this._1211154592isBookMark;
            if (_local_2 !== _arg_1)
            {
                this._1211154592isBookMark = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBookMark", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get gridQuest():GridItem
        {
            return (this._1267579196gridQuest);
        }

        private function set movingText(_arg_1:String):void
        {
            var _local_2:Object;
            _local_2 = this._1565357413movingText;
            if (_local_2 !== _arg_1)
            {
                this._1565357413movingText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "movingText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get report():SWFLoader
        {
            return (this._934521548report);
        }

        private function changeSkin():void
        {
            try
            {
                if (curSkin == "Classic")
                {
                    StyleManager.unloadStyleDeclarations("fla/skins/evonySkinClassic.swf");
                    StyleManager.loadStyleDeclarations("fla/skins/evonySkin.swf");
                    curSkin = "Normal";
                }
                else
                {
                    StyleManager.unloadStyleDeclarations("fla/skins/evonySkin.swf");
                    StyleManager.loadStyleDeclarations("fla/skins/evonySkinClassic.swf");
                    curSkin = "Classic";
                };
            }
            catch(e)
            {
            };
        }

        public function __DigiChatAllianceBtneCanvas_mouseOut(_arg_1:MouseEvent):void
        {
            onMousedigiOut(_arg_1);
        }

        public function ___MainWin_Button20_click(_arg_1:MouseEvent):void
        {
            onQuitBtnClick();
        }

        private function showVoteBtn():void
        {
            voteCanvas.visible = false;
            this.voteBtn.visible = true;
            autoHideVote();
        }

        public function __DigiFindEvoniansBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMousedigiOut(_arg_1);
        }

        public function set saveBtnBottom(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._1893954902saveBtnBottom;
            if (_local_2 !== _arg_1)
            {
                this._1893954902saveBtnBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saveBtnBottom", _local_2, _arg_1));
            };
        }

        public function __immediateBtn_mouseOut(_arg_1:MouseEvent):void
        {
            this.turnnotice.visible = false;
        }

        public function set stoneArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._1639121572stoneArrow;
            if (_local_2 !== _arg_1)
            {
                this._1639121572stoneArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneArrow", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get showNew():FieldInfoWin
        {
            return (this._2067274083showNew);
        }

        public function set Tborder2(_arg_1:EvonyImage):void
        {
            var _local_2:Object;
            _local_2 = this._434424498Tborder2;
            if (_local_2 !== _arg_1)
            {
                this._434424498Tborder2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Tborder2", _local_2, _arg_1));
            };
        }

        public function __soundBtn_click(_arg_1:MouseEvent):void
        {
            soundModeChange();
        }

        private function showOfficeWindow():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_TOWN_HALL)
                {
                    AllWindows.switchToBuildingWindow(Office.EVENT_SHOW, _local_1);
                    return;
                };
            };
        }

        private function loadOk(_arg_1:Object):void
        {
            trace(_arg_1.toString());
            if (_arg_1.toString().indexOf("1") != -1)
            {
                PromotionWin.instance.show();
            };
        }

        [Bindable(event="propertyChange")]
        public function get wizadrd():Questwizard
        {
            return (this._1360475517wizadrd);
        }

        public function set populationArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._156526404populationArrow;
            if (_local_2 !== _arg_1)
            {
                this._156526404populationArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "populationArrow", _local_2, _arg_1));
            };
        }

        private function showMyTreasureWindow():void
        {
            AllWindows.switchToFuncWindow(MyTreasure.EVENT_SHOW);
            if (Context.getInstance().needUserGuide)
            {
                GuideStep.getInstance().step140();
            };
        }

        private function randomEvent2Handle(_arg_1:TimerEvent):void
        {
            trace("idle 5 mins.");
            RandomEventWin.show(2);
        }

        public function ___MainWin_Button14_click(_arg_1:MouseEvent):void
        {
            onRankBtnClick();
        }

        [Bindable(event="propertyChange")]
        public function get strVisitLabel():String
        {
            return (this._153867910strVisitLabel);
        }

        public function set lumberArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._9038014lumberArrow;
            if (_local_2 !== _arg_1)
            {
                this._9038014lumberArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lumberArrow", _local_2, _arg_1));
            };
        }

        private function onScroll(_arg_1:ScrollEvent):void
        {
            if (TextArea(_arg_1.currentTarget).verticalScrollPosition < TextArea(_arg_1.currentTarget).maxVerticalScrollPosition)
            {
                isTheBottom = false;
            }
            else
            {
                isTheBottom = true;
            };
        }

        public function __text_chat_scroll(_arg_1:ScrollEvent):void
        {
            onScroll(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get cityOutBtn():Button
        {
            return (this._389548679cityOutBtn);
        }

        public function ___MainWin_Button6_click(_arg_1:MouseEvent):void
        {
            ChatFrame.instance.sendMsg();
        }

        private function boxInit(_arg_1:Event):void
        {
            giftboxUi.addChild(_loader);
            Object(_loader.content).setNumber(0);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_GET_PACKAGE_NUMBER, setBoxNum);
            ActionFactory.getInstance().getCommonCommands().getPackageNumber();
        }

        private function onTownOver(_arg_1:MouseEvent):void
        {
            if (cityOutBtn.selected == true)
            {
                _arg_1.target.toolTip = "Enter Town";
            }
            else
            {
                _arg_1.target.toolTip = null;
            };
        }

        private function onFbLink():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.FbLinkAccountUrl), "_blank");
        }

        public function ___MainWin_Button31_click(_arg_1:MouseEvent):void
        {
            showHero();
        }

        [Bindable(event="propertyChange")]
        public function get allCityList():Canvas
        {
            return (this._1247888022allCityList);
        }

        public function __gift_click(_arg_1:MouseEvent):void
        {
            RandomEventWin.show(5);
            gift.visible = false;
        }

        private function _MainWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                buildingProgress.visible = _arg_1;
            }, "buildingProgress.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(Context.getInstance().facebookUser));
            }, function (_arg_1:Boolean):void
            {
                _MainWin_SWFLoader4.visible = _arg_1;
            }, "_MainWin_SWFLoader4.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().facebookUser) && (Context.getInstance().bVisitor == false));
            }, function (_arg_1:Boolean):void
            {
                fbBar.visible = _arg_1;
            }, "fbBar.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (skip_btn.visible == false);
            }, function (_arg_1:Boolean):void
            {
                cityInBtn.enabled = _arg_1;
            }, "cityInBtn.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (skip_btn.visible == false);
            }, function (_arg_1:Boolean):void
            {
                cityOutBtn.enabled = _arg_1;
            }, "cityOutBtn.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((skip_btn.visible == false) && (Context.getInstance().bVisitor == false));
            }, function (_arg_1:Boolean):void
            {
                mapBtn.enabled = _arg_1;
            }, "mapBtn.enabled");
            result[5] = binding;
            binding = new Binding(this, function ():*
            {
                return (irisIn);
            }, function (_arg_1:*):void
            {
                voteBtn.setStyle("showEffect", _arg_1);
            }, "voteBtn.showEffect");
            result[6] = binding;
            binding = new Binding(this, function ():*
            {
                return (irisOut);
            }, function (_arg_1:*):void
            {
                voteBtn.setStyle("hideEffect", _arg_1);
            }, "voteBtn.hideEffect");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = skipBtnRight;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                voteBtn.setStyle("right", _arg_1);
            }, "voteBtn.right");
            result[8] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.height - 265);
            }, function (_arg_1:Number):void
            {
                voteBtn.y = _arg_1;
            }, "voteBtn.y");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((!(Context.getInstance().needUserGuide)) && (!(EvonyClient.isTryUser))) && (this.skip_btn.visible == false));
            }, function (_arg_1:Boolean):void
            {
                voteBtn.visible = _arg_1;
            }, "voteBtn.visible");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (skipBtnRight + 10);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                voteCanvas.setStyle("right", _arg_1);
            }, "voteCanvas.right");
            result[11] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.height - 265);
            }, function (_arg_1:Number):void
            {
                voteCanvas.y = _arg_1;
            }, "voteCanvas.y");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label1.text = _arg_1;
            }, "_MainWin_Label1.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_EvonyImage17.toolTip = _arg_1;
            }, "_MainWin_EvonyImage17.toolTip");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = sumPrestigeValue(this.playerInfoBean.prestige);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                prestigeTxt.text = _arg_1;
            }, "prestigeTxt.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                prestigeTxt.toolTip = _arg_1;
            }, "prestigeTxt.toolTip");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("所属联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_EvonyImage18.toolTip = _arg_1;
            }, "_MainWin_EvonyImage18.toolTip");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label3.text = _arg_1;
            }, "_MainWin_Label3.text");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.allianceLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceUi.toolTip = _arg_1;
            }, "allianceUi.toolTip");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("荣誉");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Canvas9.toolTip = _arg_1;
            }, "_MainWin_Canvas9.toolTip");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = sumPrestigeValue(this.playerInfoBean.honor);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label4.text = _arg_1;
            }, "_MainWin_Label4.text");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label4.toolTip = _arg_1;
            }, "_MainWin_Label4.toolTip");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("官职");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_EvonyImage20.toolTip = _arg_1;
            }, "_MainWin_EvonyImage20.toolTip");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label5.text = _arg_1;
            }, "_MainWin_Label5.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Canvas10.toolTip = _arg_1;
            }, "_MainWin_Canvas10.toolTip");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = sumPrestigeValue(this.playerInfoBean.ranking);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label6.text = _arg_1;
            }, "_MainWin_Label6.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfoBean.ranking;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label6.toolTip = _arg_1;
            }, "_MainWin_Label6.toolTip");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("爵位");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_EvonyImage22.toolTip = _arg_1;
            }, "_MainWin_EvonyImage22.toolTip");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = PlayerInfoTypeManager.getTitle(this.playerInfoBean.titleId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label7.text = _arg_1;
            }, "_MainWin_Label7.text");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = chat_HtmlMsg;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                text_chat.htmlText = _arg_1;
            }, "text_chat.htmlText");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("切换按钮提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ChatWorld.toolTip = _arg_1;
            }, "ChatWorld.toolTip");
            result[31] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (ChatWorld.selected);
            }, function (_arg_1:Boolean):void
            {
                ChatWorld.selected = _arg_1;
            }, "ChatWorld.selected");
            result[32] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                text_input.enabled = _arg_1;
            }, "text_input.enabled");
            result[33] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button8.enabled = _arg_1;
            }, "_MainWin_Button8.enabled");
            result[34] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button9.enabled = _arg_1;
            }, "_MainWin_Button9.enabled");
            result[35] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                questBtn.enabled = _arg_1;
            }, "questBtn.enabled");
            result[36] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button11.enabled = _arg_1;
            }, "_MainWin_Button11.enabled");
            result[37] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button12.enabled = _arg_1;
            }, "_MainWin_Button12.enabled");
            result[38] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button13.enabled = _arg_1;
            }, "_MainWin_Button13.enabled");
            result[39] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button14.enabled = _arg_1;
            }, "_MainWin_Button14.enabled");
            result[40] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button15.enabled = _arg_1;
            }, "_MainWin_Button15.enabled");
            result[41] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newQuestNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_EvonyImage26.visible = _arg_1;
            }, "_MainWin_EvonyImage26.visible");
            result[42] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.newQuestNumber;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label8.text = _arg_1;
            }, "_MainWin_Label8.text");
            result[43] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newQuestNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Label8.visible = _arg_1;
            }, "_MainWin_Label8.visible");
            result[44] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newUsualReportNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_EvonyImage27.visible = _arg_1;
            }, "_MainWin_EvonyImage27.visible");
            result[45] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.newUsualReportNumber;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label9.text = _arg_1;
            }, "_MainWin_Label9.text");
            result[46] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newUsualReportNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Label9.visible = _arg_1;
            }, "_MainWin_Label9.visible");
            result[47] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newEmailNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_EvonyImage28.visible = _arg_1;
            }, "_MainWin_EvonyImage28.visible");
            result[48] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = newEmailNumber;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label10.text = _arg_1;
            }, "_MainWin_Label10.text");
            result[49] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.newEmailNumber > 0);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Label10.visible = _arg_1;
            }, "_MainWin_Label10.visible");
            result[50] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                overview.enabled = _arg_1;
            }, "overview.enabled");
            result[51] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                myitems.enabled = _arg_1;
            }, "myitems.enabled");
            result[52] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                friendslist.enabled = _arg_1;
            }, "friendslist.enabled");
            result[53] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼包");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                giftboxUi.toolTip = _arg_1;
            }, "giftboxUi.toolTip");
            result[54] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (autofit.selected);
            }, function (_arg_1:Boolean):void
            {
                autofit.selected = _arg_1;
            }, "autofit.selected");
            result[55] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("指导用户退出游戏");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Button20.toolTip = _arg_1;
            }, "_MainWin_Button20.toolTip");
            result[56] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button21.enabled = _arg_1;
            }, "_MainWin_Button21.enabled");
            result[57] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                equipBtn.enabled = _arg_1;
            }, "equipBtn.enabled");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("科技装备描述");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                equipBtn.toolTip = _arg_1;
            }, "equipBtn.toolTip");
            result[59] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (equipBtn.enabled);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button23.enabled = _arg_1;
            }, "_MainWin_Button23.enabled");
            result[60] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((((((GameConfig.instance.serverID.toLowerCase() == "ca1") || (GameConfig.instance.serverID.toLowerCase() == "ca2")) || (!(GameConfig.instance.serverID.toLowerCase().indexOf("ca") == -1))) || (!(GameConfig.instance.serverID.toLowerCase().indexOf("cc") == -1))) || (GameConfig.instance.serverID.toLowerCase() == "alpha2")) || (GameConfig.instance.serverID.toLowerCase() == "ceshi")) || (GameConfig.instance.serverID.toLowerCase() == "beta"));
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button23.visible = _arg_1;
            }, "_MainWin_Button23.visible");
            result[61] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button24.enabled = _arg_1;
            }, "_MainWin_Button24.enabled");
            result[62] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((Context.getInstance().bVisitor == false) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                immediateBtn.enabled = _arg_1;
            }, "immediateBtn.enabled");
            result[63] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("轮盘快捷提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                immediateBtn.toolTip = _arg_1;
            }, "immediateBtn.toolTip");
            result[64] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = skipBtnRight;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                SkipTutorialBtn.setStyle("right", _arg_1);
            }, "SkipTutorialBtn.right");
            result[65] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = skipBtnBottom;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                SkipTutorialBtn.setStyle("bottom", _arg_1);
            }, "SkipTutorialBtn.bottom");
            result[66] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = saveBtnRight;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                saveGameBtn.setStyle("right", _arg_1);
            }, "saveGameBtn.right");
            result[67] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = saveBtnBottom;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                saveGameBtn.setStyle("bottom", _arg_1);
            }, "saveGameBtn.bottom");
            result[68] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (EvonyClient.isTryUser);
            }, function (_arg_1:Boolean):void
            {
                saveGameBtn.visible = _arg_1;
            }, "saveGameBtn.visible");
            result[69] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("保存提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                saveGameBtn.toolTip = _arg_1;
            }, "saveGameBtn.toolTip");
            result[70] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().bVisitor);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button29.visible = _arg_1;
            }, "_MainWin_Button29.visible");
            result[71] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().bVisitor);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button30.visible = _arg_1;
            }, "_MainWin_Button30.visible");
            result[72] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().bVisitor);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button31.visible = _arg_1;
            }, "_MainWin_Button31.visible");
            result[73] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("显示英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Button31.label = _arg_1;
            }, "_MainWin_Button31.label");
            result[74] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().bVisitor);
            }, function (_arg_1:Boolean):void
            {
                _MainWin_Button32.visible = _arg_1;
            }, "_MainWin_Button32.visible");
            result[75] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((Context.getInstance().facebookUser) && (!(Context.getInstance().bVisitor))) ? (!(this.isBookMark)) : false);
            }, function (_arg_1:Boolean):void
            {
                bookmark.visible = _arg_1;
            }, "bookmark.visible");
            result[76] = binding;
            binding = new Binding(this, function ():Array
            {
                return ([new GlowFilter(0, 1, 6, 6, 8, 1, false, false)]);
            }, function (_arg_1:Array):void
            {
                immediateText.filters = _arg_1;
            }, "immediateText.filters");
            result[77] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = noticeText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                immediateText.htmlText = _arg_1;
            }, "immediateText.htmlText");
            result[78] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 301);
            }, function (_arg_1:Boolean):void
            {
                questGuideArrow.includeInLayout = _arg_1;
            }, "questGuideArrow.includeInLayout");
            result[79] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 301);
            }, function (_arg_1:Boolean):void
            {
                questGuideArrow.visible = _arg_1;
            }, "questGuideArrow.visible");
            result[80] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().townTask) && (cityInBtn.selected == false)) && (Context.getInstance().needUserGuide));
            }, function (_arg_1:Boolean):void
            {
                townTabGuide.includeInLayout = _arg_1;
            }, "townTabGuide.includeInLayout");
            result[81] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().townTask) && (cityInBtn.selected == false)) && (Context.getInstance().needUserGuide));
            }, function (_arg_1:Boolean):void
            {
                townTabGuide.visible = _arg_1;
            }, "townTabGuide.visible");
            result[82] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().cityTask) && (cityOutBtn.selected == false)) && (Context.getInstance().needUserGuide));
            }, function (_arg_1:Boolean):void
            {
                cityTabGuide.includeInLayout = _arg_1;
            }, "cityTabGuide.includeInLayout");
            result[83] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().cityTask) && (cityOutBtn.selected == false)) && (Context.getInstance().needUserGuide));
            }, function (_arg_1:Boolean):void
            {
                cityTabGuide.visible = _arg_1;
            }, "cityTabGuide.visible");
            result[84] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 2) || ((GuideStep.getInstance().currentStep == 6) && (Context.getInstance().need_speedSound))) && (GuideStep.getInstance().hideViewHere));
            }, function (_arg_1:Boolean):void
            {
                speedupArrow.includeInLayout = _arg_1;
            }, "speedupArrow.includeInLayout");
            result[85] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 2) || ((GuideStep.getInstance().currentStep == 6) && (Context.getInstance().need_speedSound))) && (GuideStep.getInstance().hideViewHere));
            }, function (_arg_1:Boolean):void
            {
                speedupArrow.visible = _arg_1;
            }, "speedupArrow.visible");
            result[86] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 1300);
            }, function (_arg_1:Boolean):void
            {
                turnableGuide.includeInLayout = _arg_1;
            }, "turnableGuide.includeInLayout");
            result[87] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 1300);
            }, function (_arg_1:Boolean):void
            {
                turnableGuide.visible = _arg_1;
            }, "turnableGuide.visible");
            result[88] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 140);
            }, function (_arg_1:Boolean):void
            {
                myItemGuide.includeInLayout = _arg_1;
            }, "myItemGuide.includeInLayout");
            result[89] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 140);
            }, function (_arg_1:Boolean):void
            {
                myItemGuide.visible = _arg_1;
            }, "myItemGuide.visible");
            result[90] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = guidLadyBottom;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                public::guideLady.setStyle("bottom", _arg_1);
            }, "guideLady.bottom");
            result[91] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = glRight;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                public::guideLady.setStyle("right", _arg_1);
            }, "guideLady.right");
            result[92] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().needUserGuide);
            }, function (_arg_1:Boolean):void
            {
                public::guideLady.visible = _arg_1;
            }, "guideLady.visible");
            result[93] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().needUserGuide);
            }, function (_arg_1:Boolean):void
            {
                soundBtn.visible = _arg_1;
            }, "soundBtn.visible");
            result[94] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (glRight + 10);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                soundBtn.setStyle("right", _arg_1);
            }, "soundBtn.right");
            result[95] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (guidLadyBottom + 10);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                soundBtn.setStyle("bottom", _arg_1);
            }, "soundBtn.bottom");
            result[96] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = strVisitLabel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                visitLabel.text = _arg_1;
            }, "visitLabel.text");
            result[97] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().bVisitor);
            }, function (_arg_1:Boolean):void
            {
                visitLabel.visible = _arg_1;
            }, "visitLabel.visible");
            result[98] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 2) || (GuideStep.getInstance().currentStep == 6001)) && (!(GuideStep.getInstance().hideViewHere)));
            }, function (_arg_1:Boolean):void
            {
                populationArrow.includeInLayout = _arg_1;
            }, "populationArrow.includeInLayout");
            result[99] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((GuideStep.getInstance().currentStep == 2) || (GuideStep.getInstance().currentStep == 6001)) && (!(GuideStep.getInstance().hideViewHere)));
            }, function (_arg_1:Boolean):void
            {
                populationArrow.visible = _arg_1;
            }, "populationArrow.visible");
            result[100] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 5);
            }, function (_arg_1:Boolean):void
            {
                foodArrow.includeInLayout = _arg_1;
            }, "foodArrow.includeInLayout");
            result[101] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 5);
            }, function (_arg_1:Boolean):void
            {
                foodArrow.visible = _arg_1;
            }, "foodArrow.visible");
            result[102] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 6);
            }, function (_arg_1:Boolean):void
            {
                lumberArrow.includeInLayout = _arg_1;
            }, "lumberArrow.includeInLayout");
            result[103] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 6);
            }, function (_arg_1:Boolean):void
            {
                lumberArrow.visible = _arg_1;
            }, "lumberArrow.visible");
            result[104] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 7);
            }, function (_arg_1:Boolean):void
            {
                stoneArrow.includeInLayout = _arg_1;
            }, "stoneArrow.includeInLayout");
            result[105] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 7);
            }, function (_arg_1:Boolean):void
            {
                stoneArrow.visible = _arg_1;
            }, "stoneArrow.visible");
            result[106] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 8);
            }, function (_arg_1:Boolean):void
            {
                ironArrow.includeInLayout = _arg_1;
            }, "ironArrow.includeInLayout");
            result[107] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 8);
            }, function (_arg_1:Boolean):void
            {
                ironArrow.visible = _arg_1;
            }, "ironArrow.visible");
            result[108] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = helpUrl;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainWin_Label12.htmlText = _arg_1;
            }, "_MainWin_Label12.htmlText");
            result[109] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().need_QuestGuid);
            }, function (_arg_1:Boolean):void
            {
                wizadrd.visible = _arg_1;
            }, "wizadrd.visible");
            result[110] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allWinFrmHv;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allWindowsFrame.setStyle("horizontalCenter", _arg_1);
            }, "allWindowsFrame.horizontalCenter");
            result[111] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allWinFrmVv;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allWindowsFrame.setStyle("verticalCenter", _arg_1);
            }, "allWindowsFrame.verticalCenter");
            result[112] = binding;
            return (result);
        }

        private function onMousedigiOver(_arg_1:Event):void
        {
            if (digitime30 == 0)
            {
                if (((_arg_1.target.id == "DigiChatAllianceBtneCanvas") && (digichatallianceBtntime == 0)))
                {
                    digitime = setTimeout(showDigiChatAllianceBtn, 3000);
                    trace("showDigiChatAllianceBtn");
                }
                else
                {
                    if (((_arg_1.target.id == "DigiFindEvoniansBtnCanvas") && (digifindevoniansBtntime == 0)))
                    {
                        digitime = setTimeout(showDigiFindEvoniansBtn, 3000);
                        trace("showDigiFindEvoniansBtn");
                    };
                };
            };
        }

        public function WriteComment():void
        {
            WriteMessage.show();
        }

        private function soundModeChange():void
        {
            soundBtn.selected = (!(soundBtn.selected));
            public::guideLady.needSound = soundBtn.selected;
        }

        [Bindable(event="propertyChange")]
        public function get turnnotice():SWFLoader
        {
            return (this._868812181turnnotice);
        }

        [Bindable(event="propertyChange")]
        public function get row1():GridRow
        {
            return (this._3506583row1);
        }

        public function set MainMenu(_arg_1:Grid):void
        {
            var _local_2:Object = this._55996120MainMenu;
            if (_local_2 !== _arg_1)
            {
                this._55996120MainMenu = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "MainMenu", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get fbBar():FacebookToolBar
        {
            return (this._97185207fbBar);
        }

        private function onBoxRank():void
        {
            AllWindows.switchToFuncWindow(TurntableRank.EVENT_SHOW);
        }

        public function __allianceUi_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function set saveGameBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._495025357saveGameBtn;
            if (_local_2 !== _arg_1)
            {
                this._495025357saveGameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saveGameBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get saveBtnRight():Number
        {
            return (this._2031699389saveBtnRight);
        }

        [Bindable(event="propertyChange")]
        public function get myitems():Button
        {
            return (this._1518306708myitems);
        }

        private function onCloseWin(_arg_1:TimerEvent):void
        {
            closeWinTimer.stop();
            AlertWin.close();
        }

        public function set voteCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1279483106voteCanvas;
            if (_local_2 !== _arg_1)
            {
                this._1279483106voteCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteCanvas", _local_2, _arg_1));
            };
        }

        private function onDigiFindEvonians():void
        {
            var _local_1:* = "http://latest.digisocial.com/appjoin?";
            _local_1 = (_local_1 + (("email=" + playerInfoBean.accountName) + "&"));
            _local_1 = (_local_1 + "appid=2&");
            _local_1 = (_local_1 + (("username=" + playerInfoBean.userName) + "&"));
            _local_1 = (_local_1 + (("pwdhash=" + MD5.hash(EvonyClient.password)) + "&"));
            _local_1 = (_local_1 + "type=city&");
            _local_1 = (_local_1 + "level=1");
            var _local_2:String = MD5.hash((_local_1 + "9f758e2deccbe6244f734371b9642eda"));
            _local_1 = (_local_1 + ("&key=" + _local_2));
            trace(_local_1);
            navigateToURL(new URLRequest(_local_1), "_blank");
        }

        [Bindable(event="propertyChange")]
        public function get overview():Button
        {
            return (this._530115961overview);
        }

        public function set skipBtnBottom(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._879245080skipBtnBottom;
            if (_local_2 !== _arg_1)
            {
                this._879245080skipBtnBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "skipBtnBottom", _local_2, _arg_1));
            };
        }

        private function onAllianceBtnClick():void
        {
            AllWindows.switchToFuncWindow(AllianceWin.EVENT_SHOW);
        }

        public function set allWindowsFrame(_arg_1:AllWindows):void
        {
            var _local_2:Object;
            _local_2 = this._261712661allWindowsFrame;
            if (_local_2 !== _arg_1)
            {
                this._261712661allWindowsFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allWindowsFrame", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get starPic():Image
        {
            return (this._1897219624starPic);
        }

        public function set chatFrame(_arg_1:ChatFrame):void
        {
            var _local_2:Object;
            _local_2 = this._1596947701chatFrame;
            if (_local_2 !== _arg_1)
            {
                this._1596947701chatFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chatFrame", _local_2, _arg_1));
            };
        }

        public function set allCastleFrame(_arg_1:AllCastleFrame):void
        {
            var _local_2:Object;
            _local_2 = this._1455362316allCastleFrame;
            if (_local_2 !== _arg_1)
            {
                this._1455362316allCastleFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allCastleFrame", _local_2, _arg_1));
            };
        }

        private function linkHandler(_arg_1:TextEvent):void
        {
            if (_arg_1.text != "")
            {
                CallPrivaterWin.instance.show(_arg_1.text);
            };
        }

        private function openWorkshop():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_WORKSHOP)
                {
                    AllWindows.switchToBuildingWindow(Workshop.EVENT_SHOW, _local_1);
                    return;
                };
            };
            AlertWin.show(Lang.msg("先建作坊"));
        }

        [Bindable(event="propertyChange")]
        public function get buttonPanel():HBox
        {
            return (this._1773821454buttonPanel);
        }

        public function set ChatWorld(_arg_1:Button):void
        {
            var _local_2:Object = this._678424838ChatWorld;
            if (_local_2 !== _arg_1)
            {
                this._678424838ChatWorld = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ChatWorld", _local_2, _arg_1));
            };
        }

        private function onMouseOverHandler():void
        {
            intervalId1 = setTimeout(autoShowVote, 2000);
        }

        public function set DigiChatAllianceBtn(_arg_1:SWFLoader):void
        {
            var _local_2:Object = this._784993510DigiChatAllianceBtn;
            if (_local_2 !== _arg_1)
            {
                this._784993510DigiChatAllianceBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DigiChatAllianceBtn", _local_2, _arg_1));
            };
        }

        public function set UserButton(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1195075843UserButton;
            if (_local_2 !== _arg_1)
            {
                this._1195075843UserButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "UserButton", _local_2, _arg_1));
            };
        }

        private function onForumUrlClick():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.forum), "_blank");
        }

        public function set cityTabGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._1650892046cityTabGuide;
            if (_local_2 !== _arg_1)
            {
                this._1650892046cityTabGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityTabGuide", _local_2, _arg_1));
            };
        }

        private function skipTutorial():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("tour_by_flash", Context.getInstance().iPicId, "skip", GuideStep.getInstance().currentStep, "", GameConfig.instance.serverID);
            };
            GuideStep.getInstance().setCurrentStep(999);
            this.SkipTutorialBtn.visible = false;
            MainWin.instance.guideLady.includeInLayout = false;
            MainWin.instance.guideLady.visible = false;
            if (((EvonyClient.isTryUser) && (!(PreContext.getInstance().bHasLordName))))
            {
                SaveGameStep1Win.getInstance().show();
            }
            else
            {
                Context.getInstance().needUserGuide = false;
                buff.bar.refreshBuff();
                if (((!(EvonyClient(Application.application).isOutLogin)) && (!(PreContext.getInstance().bHasLordName))))
                {
                    SaveGameStep2Win.getInstance().show();
                };
            };
        }

        public function set SkipTutorialBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1127671041SkipTutorialBtn;
            if (_local_2 !== _arg_1)
            {
                this._1127671041SkipTutorialBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SkipTutorialBtn", _local_2, _arg_1));
            };
        }

        public function set questGuideArrow(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._1667860719questGuideArrow;
            if (_local_2 !== _arg_1)
            {
                this._1667860719questGuideArrow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questGuideArrow", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get immediateNotice():Canvas
        {
            return (this._1560612375immediateNotice);
        }

        public function set buildingProgress(_arg_1:_BottomToolBar):void
        {
            var _local_2:Object;
            _local_2 = this._685065473buildingProgress;
            if (_local_2 !== _arg_1)
            {
                this._685065473buildingProgress = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingProgress", _local_2, _arg_1));
            };
        }

        public function set immediateBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._33383659immediateBtn;
            if (_local_2 !== _arg_1)
            {
                this._33383659immediateBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "immediateBtn", _local_2, _arg_1));
            };
        }

        public function set newUsualReportNumber(_arg_1:int):void
        {
            var _local_2:Object;
            _local_2 = this._1822582529newUsualReportNumber;
            if (_local_2 !== _arg_1)
            {
                this._1822582529newUsualReportNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newUsualReportNumber", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allWinFrmVv():Object
        {
            return (this._969159162allWinFrmVv);
        }

        [Bindable(event="propertyChange")]
        public function get turnableGuide():GuideArrow
        {
            return (this._793724443turnableGuide);
        }

        public function set guidLadyBottom(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._221875458guidLadyBottom;
            if (_local_2 !== _arg_1)
            {
                this._221875458guidLadyBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "guidLadyBottom", _local_2, _arg_1));
            };
        }

        public function set soundBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1742630605soundBtn;
            if (_local_2 !== _arg_1)
            {
                this._1742630605soundBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "soundBtn", _local_2, _arg_1));
            };
        }

        public function set shoe(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._3529451shoe;
            if (_local_2 !== _arg_1)
            {
                this._3529451shoe = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shoe", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get issueQuestPos():int
        {
            return (this._238289419issueQuestPos);
        }

        [Bindable(event="propertyChange")]
        public function get guideLady():view.module.guide.guideLady
        {
            return (this._2076679706guideLady);
        }

        [Bindable(event="propertyChange")]
        public function get chat_HtmlMsg():String
        {
            return (this._1860599247chat_HtmlMsg);
        }

        [Bindable(event="propertyChange")]
        public function get questBtn():Button
        {
            return (this._1165907430questBtn);
        }

        private function makeScreenShot():void
        {
            var _local_4:uint;
            var _local_5:String;
            var _local_6:int;
            var _local_1:BitmapData = new BitmapData(EvonyClient(Application.application).width, EvonyClient(Application.application).height, false);
            _local_1.draw(EvonyClient(Application.application));
            var _local_2:* = "";
            var _local_3:int;
            while (_local_3 < _local_1.width)
            {
                _local_4 = (_local_1.getPixel(_local_3, 0) & 0xFFFFFF);
                _local_5 = _local_4.toString(16);
                _local_6 = (6 - _local_5.length);
                if (_local_6 != 0)
                {
                    _local_5 = (ss[_local_6] + _local_5);
                };
                _local_2 = (_local_2 + _local_5);
                _local_3++;
            };
            trace(_local_2);
            ExternalInterface.call("showScreenShotString", _local_1.width, _local_1.height, _local_2);
        }

        public function __friendslist_click(_arg_1:MouseEvent):void
        {
            showFriendList();
        }

        public function __DigiFindEvoniansBtnCanvas_mouseOut(_arg_1:MouseEvent):void
        {
            onMousedigiOut(_arg_1);
        }

        private function autoHideVote():void
        {
            clearTimeout(intervalId);
            intervalId = setTimeout(hideVoteBtn, 3000);
        }

        private function getMoveText():void
        {
            if (move_loader)
            {
                move_loader.unload();
                if (moveTextUi.contains(move_loader))
                {
                    moveTextUi.removeChild(move_loader);
                };
            };
            move_loader = new Loader();
            move_loader.contentLoaderInfo.addEventListener(Event.INIT, textInit);
            move_loader.load(new URLRequest(ResourceLoader.getNormalUrl("fla/dynamic/movetext.swf")));
        }

        public function set voteBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._639292178voteBtn;
            if (_local_2 !== _arg_1)
            {
                this._639292178voteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "voteBtn", _local_2, _arg_1));
            };
        }

        public function set newQuestNumber(_arg_1:int):void
        {
            var _local_2:Object;
            _local_2 = this._699853067newQuestNumber;
            if (_local_2 !== _arg_1)
            {
                this._699853067newQuestNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newQuestNumber", _local_2, _arg_1));
            };
        }

        public function set UserName(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._202022634UserName;
            if (_local_2 !== _arg_1)
            {
                this._202022634UserName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "UserName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get RB():EvonyImage
        {
            return (this._2608RB);
        }

        private function onShowNoticeList():void
        {
            AmountInputUI.show();
            if (Context.getInstance().needUserGuide)
            {
                if (GuideStep.getInstance().currentStep == 1300)
                {
                    GuideStep.getInstance().step1300();
                };
            };
        }

        public function ___MainWin_Button30_click(_arg_1:MouseEvent):void
        {
            HelpIncrease();
        }

        public function ___MainWin_Button13_click(_arg_1:MouseEvent):void
        {
            onHelpUrlClick();
        }

        public function __voteBtn_click(_arg_1:MouseEvent):void
        {
            showVote();
        }

        private function onShowUIFrame(_arg_1:Event):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get text_input():TextInput
        {
            return (this._2109822408text_input);
        }

        public function set townTabGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._464330009townTabGuide;
            if (_local_2 !== _arg_1)
            {
                this._464330009townTabGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "townTabGuide", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get irisOut():Iris
        {
            return (this._2062804539irisOut);
        }

        public function set immediateNoticeBox(_arg_1:HBox):void
        {
            var _local_2:Object;
            _local_2 = this._817782562immediateNoticeBox;
            if (_local_2 !== _arg_1)
            {
                this._817782562immediateNoticeBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "immediateNoticeBox", _local_2, _arg_1));
            };
        }

        private function getGiftBox():void
        {
            _loader = new Loader();
            _loader.contentLoaderInfo.addEventListener(Event.INIT, boxInit);
            _loader.load(new URLRequest(ResourceLoader.getNormalUrl("fla/dynamic/giftBox.swf")));
        }

        private function onGiftButtonClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            AllWindows.switchToFuncWindow(GiftFrame.EVENT_SHOW);
        }

        [Bindable(event="propertyChange")]
        public function get foodArrow():GuideArrow
        {
            return (this._1138195893foodArrow);
        }

        public function __voteBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver();
        }

        mx_internal function _MainWin_StylesInit():void
        {
            var style:CSSStyleDeclaration;
            var effects:Array;
            if (mx_internal::_MainWin_StylesInit_done)
            {
                return;
            };
            mx_internal::_MainWin_StylesInit_done = true;
            style = StyleManager.getStyleDeclaration(".repeattopbg");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".repeattopbg", style, false);
            };
            if (style.factory == null)
            {
                style.factory = function ():void
                {
                    this.backgroundBlend = "multiply";
                    this.backgroundRepeat = "repeat";
                    this.borderSkin = CSSSkin;
                    this.backgroundPosition = "center";
                    this.backgroundImage = _embed_css_images_repeattopbg_png_1199364659;
                };
            };
            style = StyleManager.getStyleDeclaration(".tt");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".tt", style, false);
            };
            if (style.factory == null)
            {
                style.factory = function ():void
                {
                    this.backgroundBlend = "multiply";
                    this.backgroundRepeat = "repeat";
                    this.borderSkin = CSSSkin;
                    this.backgroundPosition = "center";
                    this.backgroundImage = _embed_css_images_Bborder_png_273760257;
                };
            };
            style = StyleManager.getStyleDeclaration(".topicrepeat");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".topicrepeat", style, false);
            };
            if (style.factory == null)
            {
                style.factory = function ():void
                {
                    this.backgroundBlend = "multiply";
                    this.backgroundRepeat = "repeat";
                    this.borderSkin = CSSSkin;
                    this.backgroundPosition = "center";
                    this.backgroundImage = _embed_css_images_topicrepeat_png_2105565817;
                };
            };
            style = StyleManager.getStyleDeclaration(".chat");
            if (!style)
            {
                style = new CSSStyleDeclaration();
                StyleManager.setStyleDeclaration(".chat", style, false);
            };
            if (style.factory == null)
            {
                style.factory = function ():void
                {
                    this.backgroundBlend = "multiply";
                    this.backgroundRepeat = "repeat";
                    this.borderSkin = CSSSkin;
                    this.backgroundPosition = "center";
                    this.backgroundImage = _embed_css_images_M_chat_png_177062443;
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get star():SWFLoader
        {
            return (this._3540562star);
        }

        public function __text_chat_change(_arg_1:Event):void
        {
            onDataChange(_arg_1);
        }

        private function onSelectHero():void
        {
            HeroSelect.show();
        }

        private function autoShowVote():void
        {
            voteCanvas.visible = false;
            this.voteBtn.visible = true;
            clearTimeout(intervalId1);
            autoHideVote();
        }

        public function ___MainWin_Button24_click(_arg_1:MouseEvent):void
        {
            rechargeHandle();
        }

        public function set prestigeTxt(_arg_1:Label):void
        {
            var _local_2:Object;
            _local_2 = this._951852243prestigeTxt;
            if (_local_2 !== _arg_1)
            {
                this._951852243prestigeTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestigeTxt", _local_2, _arg_1));
            };
        }

        public function set text_chat(_arg_1:TextArea):void
        {
            var _local_2:Object;
            _local_2 = this._1038075094text_chat;
            if (_local_2 !== _arg_1)
            {
                this._1038075094text_chat = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text_chat", _local_2, _arg_1));
            };
        }

        public function set allianceUi(_arg_1:AllianceTypeUi):void
        {
            var _local_2:Object;
            _local_2 = this._1306698027allianceUi;
            if (_local_2 !== _arg_1)
            {
                this._1306698027allianceUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceUi", _local_2, _arg_1));
            };
        }

        private function onLevelTextBtnClick():void
        {
            var _local_1:MsgDispacther = MsgDispacther.getInstance();
            _local_1.showBuildingLevel = (!(_local_1.showBuildingLevel));
        }

        public function set gift(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._3172656gift;
            if (_local_2 !== _arg_1)
            {
                this._3172656gift = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gift", _local_2, _arg_1));
            };
        }

        public function set mainFrame(_arg_1:MainFrame):void
        {
            var _local_2:Object;
            _local_2 = this._274178252mainFrame;
            if (_local_2 !== _arg_1)
            {
                this._274178252mainFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mainFrame", _local_2, _arg_1));
            };
        }

        private function sumPrestigeValue(_arg_1:int):String
        {
            var _local_2:String = String(_arg_1);
            var _local_3:* = "";
            var _local_4:int = _local_2.length;
            if (_local_4 >= 10)
            {
                _local_3 = (_local_2.substr(0, (_local_4 - 9)) + "B");
            }
            else
            {
                if (_local_4 >= 7)
                {
                    _local_3 = (_local_2.substr(0, (_local_4 - 6)) + "M");
                }
                else
                {
                    if (_local_4 > 4)
                    {
                        _local_3 = (_local_2.substr(0, (_local_4 - 3)) + "K");
                    }
                    else
                    {
                        _local_3 = _local_2;
                    };
                };
            };
            return (_local_3);
        }

        public function set bookmark(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._2005378358bookmark;
            if (_local_2 !== _arg_1)
            {
                this._2005378358bookmark = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bookmark", _local_2, _arg_1));
            };
        }

        private function onToolTipShown(_arg_1:ToolTipEvent):void
        {
            var _local_2:IToolTip;
            if (ToolTipManager.currentToolTip)
            {
                _local_2 = ToolTipManager.currentToolTip;
                if ((_local_2.x + _local_2.width) < 0)
                {
                    _local_2.x = 0;
                };
                if ((_local_2.y + _local_2.height) < 0)
                {
                    _local_2.y = 0;
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get helpUrl():String
        {
            return (this._805808750helpUrl);
        }

        public function set report(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._934521548report;
            if (_local_2 !== _arg_1)
            {
                this._934521548report = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "report", _local_2, _arg_1));
            };
        }

        public function set DigiFindEvoniansBtn(_arg_1:SWFLoader):void
        {
            var _local_2:Object = this._200298193DigiFindEvoniansBtn;
            if (_local_2 !== _arg_1)
            {
                this._200298193DigiFindEvoniansBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DigiFindEvoniansBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get DigiChatAllianceBtneCanvas():Canvas
        {
            return (this._1290566025DigiChatAllianceBtneCanvas);
        }

        public function __giftboxUi_toolTipShown(_arg_1:ToolTipEvent):void
        {
            onToolTipShown(_arg_1);
        }

        public function set gridQuest(_arg_1:GridItem):void
        {
            var _local_2:Object;
            _local_2 = this._1267579196gridQuest;
            if (_local_2 !== _arg_1)
            {
                this._1267579196gridQuest = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gridQuest", _local_2, _arg_1));
            };
        }

        public function set bookmarkshowFlag(_arg_1:int):void
        {
            var _local_2:Object;
            _local_2 = this._1313445695bookmarkshowFlag;
            if (_local_2 !== _arg_1)
            {
                this._1313445695bookmarkshowFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bookmarkshowFlag", _local_2, _arg_1));
            };
        }

        public function set castleInfoFrame(_arg_1:CastleInfoFrame):void
        {
            var _local_2:Object;
            _local_2 = this._416443577castleInfoFrame;
            if (_local_2 !== _arg_1)
            {
                this._416443577castleInfoFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleInfoFrame", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get giftboxUi():UIComponent
        {
            return (this._573249167giftboxUi);
        }

        [Bindable(event="propertyChange")]
        public function get guideUC():UIComponent
        {
            return (this._373257866guideUC);
        }

        public function set myQuestBtnTooltip(_arg_1:QuestBtnTooltip):void
        {
            var _local_2:Object;
            _local_2 = this._1859770051myQuestBtnTooltip;
            if (_local_2 !== _arg_1)
            {
                this._1859770051myQuestBtnTooltip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myQuestBtnTooltip", _local_2, _arg_1));
            };
        }

        private function onDigiAllianceLink():void
        {
            var _local_1:* = "http://latest.digisocial.com/appjoin?";
            _local_1 = (_local_1 + (("email=" + playerInfoBean.accountName) + "&"));
            _local_1 = (_local_1 + "appid=2&");
            _local_1 = (_local_1 + (("username=" + playerInfoBean.userName) + "&"));
            _local_1 = (_local_1 + (("pwdhash=" + MD5.hash(EvonyClient.password)) + "&"));
            _local_1 = (_local_1 + "type=guild&");
            _local_1 = (_local_1 + (("guildname=" + playerInfoBean.alliance) + "&"));
            _local_1 = (_local_1 + ("guildlevel=" + playerInfoBean.allianceLevel));
            var _local_2:String = MD5.hash((_local_1 + "9f758e2deccbe6244f734371b9642eda"));
            _local_1 = (_local_1 + ("&key=" + _local_2));
            trace(_local_1);
            navigateToURL(new URLRequest(_local_1), "_blank");
        }

        public function __DigiFindEvoniansBtn_click(_arg_1:MouseEvent):void
        {
            onDigiFindEvonians();
        }

        [Bindable(event="propertyChange")]
        private function get movingText():String
        {
            return (this._1565357413movingText);
        }

        public function __report_click(_arg_1:MouseEvent):void
        {
            onInfoBtnClick();
        }

        public function ___MainWin_Button29_click(_arg_1:MouseEvent):void
        {
            showCj();
        }

        public function set mapPosBox(_arg_1:MapPos):void
        {
            var _local_2:Object;
            _local_2 = this._822370131mapPosBox;
            if (_local_2 !== _arg_1)
            {
                this._822370131mapPosBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapPosBox", _local_2, _arg_1));
            };
        }

        private function toInstall():void
        {
            navigateToURL(new URLRequest("http://bbs.evony.com/showthread.php?t=174882#1"), "_blank");
            this.addMoneyPic.visible = false;
        }

        private function onValueCommit(_arg_1:FlexEvent):void
        {
            if (this.isTheBottom)
            {
                TextArea(_arg_1.target).verticalScrollPosition = TextArea(_arg_1.target).maxVerticalScrollPosition;
            };
        }

        [Bindable(event="propertyChange")]
        public function get saveBtnBottom():Number
        {
            return (this._1893954902saveBtnBottom);
        }

        [Bindable(event="propertyChange")]
        public function get stoneArrow():GuideArrow
        {
            return (this._1639121572stoneArrow);
        }

        [Bindable(event="propertyChange")]
        public function get Tborder2():EvonyImage
        {
            return (this._434424498Tborder2);
        }

        public function __text_chat_updateComplete(_arg_1:FlexEvent):void
        {
            onValueCommit(_arg_1);
        }

        public function set myItemGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._761825443myItemGuide;
            if (_local_2 !== _arg_1)
            {
                this._761825443myItemGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myItemGuide", _local_2, _arg_1));
            };
        }

        public function set mapBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1081404576mapBtn;
            if (_local_2 !== _arg_1)
            {
                this._1081404576mapBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapBtn", _local_2, _arg_1));
            };
        }

        public function set showNew(_arg_1:FieldInfoWin):void
        {
            var _local_2:Object;
            _local_2 = this._2067274083showNew;
            if (_local_2 !== _arg_1)
            {
                this._2067274083showNew = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showNew", _local_2, _arg_1));
            };
        }

        private function onMouseOutHandler():void
        {
            clearTimeout(intervalId1);
        }

        [Bindable(event="propertyChange")]
        public function get soundBtn():Button
        {
            return (this._1742630605soundBtn);
        }

        public function set DigiFindEvoniansBtnCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._907332761DigiFindEvoniansBtnCanvas;
            if (_local_2 !== _arg_1)
            {
                this._907332761DigiFindEvoniansBtnCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DigiFindEvoniansBtnCanvas", _local_2, _arg_1));
            };
        }

        private function onShowChangeTitleWin():void
        {
            GameOptionsWin.show();
        }

        private function onInfoBtnClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            AllWindows.switchToFuncWindow(InfoWin.EVENT_SHOW);
        }

        private function changealphaFindEvonians():void
        {
            this.DigiFindEvoniansBtn.alpha = (this.DigiFindEvoniansBtn.alpha - 0.1);
            if (this.DigiFindEvoniansBtn.alpha <= 0)
            {
                this.DigiFindEvoniansBtn.alpha = 0;
                this.DigiFindEvoniansBtn.visible = false;
                this.DigiFindEvoniansBtnCanvas.visible = true;
                digifindevoniansBtntime = 0;
            }
            else
            {
                digifindevoniansBtntime = setTimeout(changealphaFindEvonians, 300);
            };
        }

        [Bindable(event="propertyChange")]
        public function get MainMenu():Grid
        {
            return (this._55996120MainMenu);
        }

        public function set allCityList(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1247888022allCityList;
            if (_local_2 !== _arg_1)
            {
                this._1247888022allCityList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allCityList", _local_2, _arg_1));
            };
        }

        public function __voteBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function polldigitme():void
        {
            var request:URLRequest = new URLRequest(("http://latest.digisocial.com/?r=chat_noread&email=" + playerInfoBean.accountName));
            var urlloader:URLLoader = new URLLoader();
            try
            {
                urlloader.load(request);
            }
            catch(error:SecurityError)
            {
                trace("A SecurityError has occurred.");
            };
            urlloader.addEventListener(Event.COMPLETE, polldigitimecompletehandler);
            urlloader.addEventListener(IOErrorEvent.IO_ERROR, polldigitimecompleteerrorHandler);
            setTimeout(polldigitme, 30000);
        }

        private function onMailBtnClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            AllWindows.switchToFuncWindow(MailWin.EVENT_SHOW);
        }

        public function set Chat(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2099064Chat;
            if (_local_2 !== _arg_1)
            {
                this._2099064Chat = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Chat", _local_2, _arg_1));
            };
        }

        public function setMyQuestBtnTooltipVisible(_arg_1:Boolean):void
        {
        }

        private function showRandEvent():void
        {
            var _local_1:Array = [1, 2, 3, 4, 5, 6];
            if (indextest >= _local_1.length)
            {
                indextest = 0;
            };
            RandomEventWin.show(_local_1[indextest++]);
        }

        [Bindable(event="propertyChange")]
        public function get allCastleFrame():AllCastleFrame
        {
            return (this._1455362316allCastleFrame);
        }

        [Bindable(event="propertyChange")]
        public function get UserButton():Canvas
        {
            return (this._1195075843UserButton);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            turnnotice.move((immediateBtn.x + 25), ((immediateBtn.y < 75) ? 75 : (immediateBtn.y - 60)));
            this.turnnotice.visible = true;
        }

        public function set Lborder(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._1642466168Lborder;
            if (_local_2 !== _arg_1)
            {
                this._1642466168Lborder = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Lborder", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ChatWorld():Button
        {
            return (this._678424838ChatWorld);
        }

        private function showDigiChatAllianceBtn():void
        {
            this.DigiChatAllianceBtn.visible = true;
            this.DigiChatAllianceBtn.alpha = 1;
            this.DigiChatAllianceBtneCanvas.visible = false;
            digichatallianceBtntime = setTimeout(changealphaalliace, 30000);
        }

        public function __skip_btn_click(_arg_1:MouseEvent):void
        {
            TownView.singleton().clickHandle();
        }

        public function set wizadrd(_arg_1:Questwizard):void
        {
            var _local_2:Object;
            _local_2 = this._1360475517wizadrd;
            if (_local_2 !== _arg_1)
            {
                this._1360475517wizadrd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wizadrd", _local_2, _arg_1));
            };
        }

        public function __questBtn_click(_arg_1:MouseEvent):void
        {
            onQuestBtnClick();
        }

        public function set strVisitLabel(_arg_1:String):void
        {
            var _local_2:Object;
            _local_2 = this._153867910strVisitLabel;
            if (_local_2 !== _arg_1)
            {
                this._153867910strVisitLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strVisitLabel", _local_2, _arg_1));
            };
        }

        public function __cityInBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onTownOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get SkipTutorialBtn():Button
        {
            return (this._1127671041SkipTutorialBtn);
        }

        private function saveGame():void
        {
            SaveGameStep1Win.getInstance().show();
        }

        private function showDigiFindEvoniansBtn():void
        {
            this.DigiFindEvoniansBtn.visible = true;
            this.DigiFindEvoniansBtn.alpha = 1;
            this.DigiFindEvoniansBtnCanvas.visible = false;
            digifindevoniansBtntime = setTimeout(changealphaFindEvonians, 30000);
        }

        public function ___MainWin_Button23_click(_arg_1:MouseEvent):void
        {
            onSelectHero();
        }

        [Bindable(event="propertyChange")]
        public function get shoe():SWFLoader
        {
            return (this._3529451shoe);
        }

        public function ___MainWin_Button12_click(_arg_1:MouseEvent):void
        {
            onShowChangeTitleWin();
        }

        public function set cityOutBtn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._389548679cityOutBtn;
            if (_local_2 !== _arg_1)
            {
                this._389548679cityOutBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityOutBtn", _local_2, _arg_1));
            };
        }

        public function __DigiChatAllianceBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMousedigiOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get voteBtn():Button
        {
            return (this._639292178voteBtn);
        }

        public function __cityOutBtn_click(_arg_1:MouseEvent):void
        {
            onCityOutClik();
        }

        public function __shoe_click(_arg_1:MouseEvent):void
        {
            RandomEventWin.show(37);
            shoe.visible = false;
        }

        public function set myitems(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1518306708myitems;
            if (_local_2 !== _arg_1)
            {
                this._1518306708myitems = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myitems", _local_2, _arg_1));
            };
        }

        public function __overview_click(_arg_1:MouseEvent):void
        {
            showOfficeWindow();
        }

        [Bindable(event="propertyChange")]
        public function get text_chat():TextArea
        {
            return (this._1038075094text_chat);
        }

        public function __autofit_click(_arg_1:MouseEvent):void
        {
            MainFrame.instance.onAutoFit();
        }

        [Bindable(event="propertyChange")]
        public function get prestigeTxt():Label
        {
            return (this._951852243prestigeTxt);
        }

        public function set row1(_arg_1:GridRow):void
        {
            var _local_2:Object;
            _local_2 = this._3506583row1;
            if (_local_2 !== _arg_1)
            {
                this._3506583row1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "row1", _local_2, _arg_1));
            };
        }

        public function __DigiChatAllianceBtneCanvas_mouseOver(_arg_1:MouseEvent):void
        {
            onMousedigiOver(_arg_1);
        }

        public function set moveTextCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1456236650moveTextCanvas;
            if (_local_2 !== _arg_1)
            {
                this._1456236650moveTextCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "moveTextCanvas", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mainFrame():MainFrame
        {
            return (this._274178252mainFrame);
        }

        private function _MainWin_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 3417374;
            _local_1.blurX = 5;
            _local_1.blurY = 5;
            _local_1.alpha = 0.7;
            _local_1.strength = 5;
            _local_1.quality = 1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get guidLadyBottom():Number
        {
            return (this._221875458guidLadyBottom);
        }

        [Bindable(event="propertyChange")]
        public function get cityTabGuide():GuideArrow
        {
            return (this._1650892046cityTabGuide);
        }

        private function showFriendList():void
        {
            AllWindows.switchToFuncWindow(FriendList.EVENT_SHOW);
        }

        public function set skip_btn(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._2145762204skip_btn;
            if (_local_2 !== _arg_1)
            {
                this._2145762204skip_btn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "skip_btn", _local_2, _arg_1));
            };
        }

        private function onHelpUrlClick():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            cj.show();
        }

        public function set topicrepeat(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._437918602topicrepeat;
            if (_local_2 !== _arg_1)
            {
                this._437918602topicrepeat = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "topicrepeat", _local_2, _arg_1));
            };
        }

        public function set playerInfoFrame(_arg_1:PlayerHeadFrame):void
        {
            var _local_2:Object;
            _local_2 = this._493534338playerInfoFrame;
            if (_local_2 !== _arg_1)
            {
                this._493534338playerInfoFrame = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfoFrame", _local_2, _arg_1));
            };
        }

        private function openForge():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_BLACKSMITH)
                {
                    AllWindows.switchToBuildingWindow(Forge.EVENT_SHOW, _local_1);
                    return;
                };
            };
            AlertWin.show(Lang.msg("先建铁匠铺"));
        }

        public function set repeattopbg(_arg_1:Canvas):void
        {
            var _local_2:Object;
            _local_2 = this._1616766879repeattopbg;
            if (_local_2 !== _arg_1)
            {
                this._1616766879repeattopbg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "repeattopbg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get castleInfoFrame():CastleInfoFrame
        {
            return (this._416443577castleInfoFrame);
        }

        private function _MainWin_Iris2_i():Iris
        {
            var _local_1:Iris = new Iris();
            irisIn = _local_1;
            _local_1.duration = 1000;
            _local_1.showTarget = false;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get immediateNoticeBox():HBox
        {
            return (this._817782562immediateNoticeBox);
        }

        private function onTavernNews(_arg_1:MouseEvent):void
        {
            var _local_2:BuildingBean;
            for each (_local_2 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (UIUtil.isInnerBuilding(_local_2.positionId))
                {
                    if (_local_2.typeId == BuildingConstants.TYPE_TAVERN)
                    {
                        if (_local_2.level >= 5)
                        {
                            AllWindows.switchToFuncWindow(TavernNewsWin.EVENT_SHOW);
                            return;
                        };
                    };
                };
            };
            AlertWin.show("You have to build an Inn and upgrade it to level 5 or higher in this city first.");
        }

        private function set playerInfoBean(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object;
            _local_2 = this._815231871playerInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._815231871playerInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfoBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mapPosBox():MapPos
        {
            return (this._822370131mapPosBox);
        }

        public function __voteCanvas_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOutHandler();
        }

        public function set turnnotice(_arg_1:SWFLoader):void
        {
            var _local_2:Object;
            _local_2 = this._868812181turnnotice;
            if (_local_2 !== _arg_1)
            {
                this._868812181turnnotice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "turnnotice", _local_2, _arg_1));
            };
        }

        public function ___MainWin_Button9_click(_arg_1:MouseEvent):void
        {
            onAllianceBtnClick();
        }

        [Bindable(event="propertyChange")]
        public function get myItemGuide():GuideArrow
        {
            return (this._761825443myItemGuide);
        }

        private function polldigitimecompletehandler(_arg_1:Event):void
        {
            var _local_2:MovieClip = (this.DigiChatTip.content as MovieClip);
            _local_2.ChatIfor.Num.text = (_arg_1.target.data as String);
            _local_2.ChatIfor.Num.visible = true;
            _local_2.ChatIfor.NumberBG.visible = true;
        }

        public function __myitems_click(_arg_1:MouseEvent):void
        {
            showMyTreasureWindow();
        }

        public function set MapToggle(_arg_1:Grid):void
        {
            var _local_2:Object = this._1354434640MapToggle;
            if (_local_2 !== _arg_1)
            {
                this._1354434640MapToggle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "MapToggle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get bookmarkshowFlag():int
        {
            return (this._1313445695bookmarkshowFlag);
        }

        private function onPlayerInofUpdate(_arg_1:Event):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get DigiFindEvoniansBtnCanvas():Canvas
        {
            return (this._907332761DigiFindEvoniansBtnCanvas);
        }

        private function onMouseOut():void
        {
            autoHideVote();
        }

        public function set fbBar(_arg_1:FacebookToolBar):void
        {
            var _local_2:Object;
            _local_2 = this._97185207fbBar;
            if (_local_2 !== _arg_1)
            {
                this._97185207fbBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fbBar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mapBtn():Button
        {
            return (this._1081404576mapBtn);
        }

        private function hideVoteBtn():void
        {
            voteCanvas.visible = true;
            this.voteBtn.visible = false;
            clearTimeout(intervalId);
            intervalId = setTimeout(showVoteBtn, 900000);
        }

        public function __equipBtn_click(_arg_1:MouseEvent):void
        {
            openWorkshop();
        }

        public function set overview(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._530115961overview;
            if (_local_2 !== _arg_1)
            {
                this._530115961overview = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "overview", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get Chat():Canvas
        {
            return (this._2099064Chat);
        }

        public function set rightTopBg(_arg_1:EvonyImage):void
        {
            var _local_2:Object;
            _local_2 = this._1397946434rightTopBg;
            if (_local_2 !== _arg_1)
            {
                this._1397946434rightTopBg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "rightTopBg", _local_2, _arg_1));
            };
        }

        private function onDataChange(_arg_1:Event):void
        {
            _arg_1.stopPropagation();
        }

        private function onQuitBtnClick():void
        {
            var _local_2:Boolean;
            var _local_3:SharedObject;
            var _local_1:Boolean = EvonyClient.isTryUser;
            if (_local_1)
            {
                QuitGameWin.show();
            }
            else
            {
                _local_2 = false;
                _local_3 = SharedObject.getLocal("addFavorite");
                if (_local_3.data.accountName == playerInfoBean.accountName)
                {
                    _local_2 = _local_3.data.isFavorite;
                };
                if (_local_2)
                {
                    navigateToURL(new URLRequest(GameConfig.instance.homePage), "_parent");
                }
                else
                {
                    AddFavoriteWin.show();
                };
            };
        }

        public function __DigiChatAllianceBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMousedigiOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get playerInfoBean():PlayerInfoBean
        {
            return (this._815231871playerInfoBean);
        }

        private function showVote():void
        {
            AllWindows.switchToFuncWindow(VoteWin.EVENT_SHOW);
        }

        public function set friendslist(_arg_1:Button):void
        {
            var _local_2:Object;
            _local_2 = this._1406478259friendslist;
            if (_local_2 !== _arg_1)
            {
                this._1406478259friendslist = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendslist", _local_2, _arg_1));
            };
        }

        public function set saveBtnRight(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._2031699389saveBtnRight;
            if (_local_2 !== _arg_1)
            {
                this._2031699389saveBtnRight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "saveBtnRight", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get topicrepeat():Canvas
        {
            return (this._437918602topicrepeat);
        }

        public function __DigiChatTip_click(_arg_1:MouseEvent):void
        {
            onDigiChatTip();
        }

        private function _MainWin_Iris1_i():Iris
        {
            var _local_1:Iris = new Iris();
            irisOut = _local_1;
            _local_1.duration = 1000;
            _local_1.showTarget = true;
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:MainWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MainWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_MainWinWatcherSetupUtil");
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

        private function textLoaded(_arg_1:String):void
        {
            trace((this.className + "textLoaded()"));
            if (Context.getInstance().bVisitor)
            {
                _arg_1 = "Visiting Empire";
            };
            this.movingText = _arg_1;
            if (((!(this.movingText == null)) && (this.movingText.length > 0)))
            {
                getMoveText();
            };
        }

        [Bindable(event="propertyChange")]
        public function get Lborder():EvonyImage
        {
            return (this._1642466168Lborder);
        }

        [Bindable(event="propertyChange")]
        public function get moveTextCanvas():Canvas
        {
            return (this._1456236650moveTextCanvas);
        }

        [Bindable(event="propertyChange")]
        public function get repeattopbg():Canvas
        {
            return (this._1616766879repeattopbg);
        }

        [Bindable(event="propertyChange")]
        public function get playerInfoFrame():PlayerHeadFrame
        {
            return (this._493534338playerInfoFrame);
        }

        [Bindable(event="propertyChange")]
        public function get skip_btn():Button
        {
            return (this._2145762204skip_btn);
        }

        public function set chat_HtmlMsg(_arg_1:String):void
        {
            var _local_2:Object;
            _local_2 = this._1860599247chat_HtmlMsg;
            if (_local_2 !== _arg_1)
            {
                this._1860599247chat_HtmlMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "chat_HtmlMsg", _local_2, _arg_1));
            };
        }

        private function onHelpClick():void
        {
            help.show();
        }

        public function set moveTextUi(_arg_1:UIComponent):void
        {
            var _local_2:Object;
            _local_2 = this._1565524014moveTextUi;
            if (_local_2 !== _arg_1)
            {
                this._1565524014moveTextUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "moveTextUi", _local_2, _arg_1));
            };
        }

        private function changealpha():void
        {
            this.DigiChatAllianceBtn.alpha = (this.DigiChatAllianceBtn.alpha - 0.1);
            this.DigiFindEvoniansBtn.alpha = (this.DigiFindEvoniansBtn.alpha - 0.1);
            if (((this.DigiFindEvoniansBtn.alpha <= 0) || (this.DigiFindEvoniansBtn.alpha <= 0)))
            {
                this.DigiChatAllianceBtn.alpha = 0;
                this.DigiFindEvoniansBtn.alpha = 0;
                this.DigiChatAllianceBtn.visible = false;
                this.DigiFindEvoniansBtn.visible = false;
                this.DigiChatAllianceBtneCanvas.visible = true;
                this.DigiFindEvoniansBtnCanvas.visible = true;
            }
            else
            {
                digitimealpha = setTimeout(changealpha, 300);
            };
        }

        private function rechargeHandle():void
        {
            AddFundWin.gotoPurchasePage();
            this.addMoneyPic.visible = false;
        }

        [Bindable(event="propertyChange")]
        public function get MapToggle():Grid
        {
            return (this._1354434640MapToggle);
        }

        private function starthidedigibtn():void
        {
            clearTimeout(digitime30);
            digitime30 = 0;
            digitimealpha = setTimeout(changealpha, 500);
        }

        public function __text_input_change(_arg_1:Event):void
        {
            ChatFrame.instance.onChatInput(_arg_1);
        }

        public function set DigiChatTip(_arg_1:SWFLoader):void
        {
            var _local_2:Object = this._1861656612DigiChatTip;
            if (_local_2 !== _arg_1)
            {
                this._1861656612DigiChatTip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DigiChatTip", _local_2, _arg_1));
            };
        }

        public function set starPic(_arg_1:Image):void
        {
            var _local_2:Object;
            _local_2 = this._1897219624starPic;
            if (_local_2 !== _arg_1)
            {
                this._1897219624starPic = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "starPic", _local_2, _arg_1));
            };
        }

        private function initGuid():void
        {
            var _local_1:int = Context.getInstance().getPlayerBean().playerInfo.userId;
            Context.getInstance().iPicId = 2;
            ResourceLoader.loadResource("fla/dynamic/guide.swf", public::guideLady.type2, public::guideLady.resourceReady, ResourceLoader.LOAD_DEMAND);
        }

        [Bindable(event="propertyChange")]
        public function get friendslist():Button
        {
            return (this._1406478259friendslist);
        }

        public function set skipBtnRight(_arg_1:Number):void
        {
            var _local_2:Object;
            _local_2 = this._1094600639skipBtnRight;
            if (_local_2 !== _arg_1)
            {
                this._1094600639skipBtnRight = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "skipBtnRight", _local_2, _arg_1));
            };
        }

        public function ___MainWin_Button11_click(_arg_1:MouseEvent):void
        {
            onInfoBtnClick();
        }

        [Bindable(event="propertyChange")]
        public function get skipBtnRight():Number
        {
            return (this._1094600639skipBtnRight);
        }

        public function __mapBtn_click(_arg_1:MouseEvent):void
        {
            onMapClik();
        }

        public function set turnableGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object;
            _local_2 = this._793724443turnableGuide;
            if (_local_2 !== _arg_1)
            {
                this._793724443turnableGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "turnableGuide", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get rightTopBg():EvonyImage
        {
            return (this._1397946434rightTopBg);
        }

        private function Chat_height():void
        {
            if (Chat.height == 130)
            {
                Chat.height = 360;
            }
            else
            {
                if (Chat.height == 360)
                {
                    if (Application.application.height <= 0x0300)
                    {
                        Chat.height = 400;
                    }
                    else
                    {
                        Chat.height = 580;
                    };
                }
                else
                {
                    Chat.height = 130;
                };
            };
        }

        public function set guideLady(_arg_1:view.module.guide.guideLady):void
        {
            var _local_2:Object;
            _local_2 = this._2076679706guideLady;
            if (_local_2 !== _arg_1)
            {
                this._2076679706guideLady = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "guideLady", _local_2, _arg_1));
            };
        }

        public function __voteCanvas_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOverHandler();
        }

        private function onServerSystemInfoMsg(_arg_1:SystemInfoMsg):void
        {
            var _local_2:String;
            if (_arg_1.tV)
            {
                _local_2 = _arg_1.msg;
                if (((_local_2.indexOf(" Ritual of Pact") > 0) || (_local_2.indexOf(" Speaker") > 0)))
                {
                    return;
                };
                immediateNoticeBox.includeInLayout = true;
                immediateNoticeBox.visible = true;
                immediateNotice.visible = true;
                noticeTimer.start();
                noticeText = _arg_1.msg;
            };
        }

        public function __saveGameBtn_click(_arg_1:MouseEvent):void
        {
            saveGame();
        }

        private function textInit(_arg_1:Event):void
        {
            moveTextUi.addChild(move_loader);
            Object(move_loader.content).noticeText(this.movingText);
        }

        public function onMapClik():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            cityInBtn.selected = false;
            cityOutBtn.selected = false;
            mapBtn.selected = true;
            MainFrame.instance.switchToWorldMap();
            this.mapPosBox.visible = true;
            this.autofit.visible = false;
        }

        private function onNoticeTimer(_arg_1:TimerEvent):void
        {
            immediateNoticeBox.visible = false;
            immediateNotice.visible = false;
            immediateNoticeBox.includeInLayout = false;
            noticeTimer.stop();
        }

        private function onQuestBtnClick():void
        {
            if (questGuideArrow.visible)
            {
                questGuideArrow.visible = false;
                questGuideArrow.includeInLayout = false;
            };
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            AllWindows.switchToFuncWindow(QuestWin.EVENT_SHOW);
            MainWin.instance.setMyQuestBtnTooltipVisible(false);
            if (Context.getInstance().needUserGuide)
            {
                if (GuideStep.getInstance().currentStep == 301)
                {
                    GuideStep.getInstance().step301();
                };
            };
            guidLadyBottom = 0;
        }

        private function _MainWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = (!(Context.getInstance().facebookUser));
            _local_1 = ((Context.getInstance().facebookUser) && (Context.getInstance().bVisitor == false));
            _local_1 = (skip_btn.visible == false);
            _local_1 = (skip_btn.visible == false);
            _local_1 = ((skip_btn.visible == false) && (Context.getInstance().bVisitor == false));
            _local_1 = irisIn;
            _local_1 = irisOut;
            _local_1 = skipBtnRight;
            _local_1 = (this.height - 265);
            _local_1 = (((!(Context.getInstance().needUserGuide)) && (!(EvonyClient.isTryUser))) && (this.skip_btn.visible == false));
            _local_1 = (skipBtnRight + 10);
            _local_1 = (this.height - 265);
            _local_1 = this.playerInfoBean.userName;
            _local_1 = Lang.msg("声望");
            _local_1 = sumPrestigeValue(this.playerInfoBean.prestige);
            _local_1 = this.playerInfoBean.prestige;
            _local_1 = Lang.msg("所属联盟");
            _local_1 = this.playerInfoBean.alliance;
            _local_1 = this.playerInfoBean.allianceLevel;
            _local_1 = Lang.msg("荣誉");
            _local_1 = sumPrestigeValue(this.playerInfoBean.honor);
            _local_1 = this.playerInfoBean.honor;
            _local_1 = Lang.msg("官职");
            _local_1 = this.playerInfoBean.office;
            _local_1 = Lang.msg("声望排名");
            _local_1 = sumPrestigeValue(this.playerInfoBean.ranking);
            _local_1 = this.playerInfoBean.ranking;
            _local_1 = Lang.msg("爵位");
            _local_1 = PlayerInfoTypeManager.getTitle(this.playerInfoBean.titleId);
            _local_1 = chat_HtmlMsg;
            _local_1 = Lang.msg("切换按钮提示");
            _local_1 = ChatWorld.selected;
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = (this.newQuestNumber > 0);
            _local_1 = this.newQuestNumber;
            _local_1 = (this.newQuestNumber > 0);
            _local_1 = (this.newUsualReportNumber > 0);
            _local_1 = this.newUsualReportNumber;
            _local_1 = (this.newUsualReportNumber > 0);
            _local_1 = (this.newEmailNumber > 0);
            _local_1 = newEmailNumber;
            _local_1 = (this.newEmailNumber > 0);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = Lang.msg("礼包");
            _local_1 = autofit.selected;
            _local_1 = Lang.msg("指导用户退出游戏");
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = Lang.msg("科技装备描述");
            _local_1 = equipBtn.enabled;
            _local_1 = (((((((GameConfig.instance.serverID.toLowerCase() == "ca1") || (GameConfig.instance.serverID.toLowerCase() == "ca2")) || (!(GameConfig.instance.serverID.toLowerCase().indexOf("ca") == -1))) || (!(GameConfig.instance.serverID.toLowerCase().indexOf("cc") == -1))) || (GameConfig.instance.serverID.toLowerCase() == "alpha2")) || (GameConfig.instance.serverID.toLowerCase() == "ceshi")) || (GameConfig.instance.serverID.toLowerCase() == "beta"));
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = ((Context.getInstance().bVisitor == false) ? true : false);
            _local_1 = Lang.msg("轮盘快捷提示");
            _local_1 = skipBtnRight;
            _local_1 = skipBtnBottom;
            _local_1 = saveBtnRight;
            _local_1 = saveBtnBottom;
            _local_1 = EvonyClient.isTryUser;
            _local_1 = Lang.msg("保存提示");
            _local_1 = Context.getInstance().bVisitor;
            _local_1 = Context.getInstance().bVisitor;
            _local_1 = Context.getInstance().bVisitor;
            _local_1 = Lang.msg("显示英雄");
            _local_1 = Context.getInstance().bVisitor;
            _local_1 = (((Context.getInstance().facebookUser) && (!(Context.getInstance().bVisitor))) ? (!(this.isBookMark)) : false);
            _local_1 = [new GlowFilter(0, 1, 6, 6, 8, 1, false, false)];
            _local_1 = noticeText;
            _local_1 = (GuideStep.getInstance().currentStep == 301);
            _local_1 = (GuideStep.getInstance().currentStep == 301);
            _local_1 = (((GuideStep.getInstance().townTask) && (cityInBtn.selected == false)) && (Context.getInstance().needUserGuide));
            _local_1 = (((GuideStep.getInstance().townTask) && (cityInBtn.selected == false)) && (Context.getInstance().needUserGuide));
            _local_1 = (((GuideStep.getInstance().cityTask) && (cityOutBtn.selected == false)) && (Context.getInstance().needUserGuide));
            _local_1 = (((GuideStep.getInstance().cityTask) && (cityOutBtn.selected == false)) && (Context.getInstance().needUserGuide));
            _local_1 = (((GuideStep.getInstance().currentStep == 2) || ((GuideStep.getInstance().currentStep == 6) && (Context.getInstance().need_speedSound))) && (GuideStep.getInstance().hideViewHere));
            _local_1 = (((GuideStep.getInstance().currentStep == 2) || ((GuideStep.getInstance().currentStep == 6) && (Context.getInstance().need_speedSound))) && (GuideStep.getInstance().hideViewHere));
            _local_1 = (GuideStep.getInstance().currentStep == 1300);
            _local_1 = (GuideStep.getInstance().currentStep == 1300);
            _local_1 = (GuideStep.getInstance().currentStep == 140);
            _local_1 = (GuideStep.getInstance().currentStep == 140);
            _local_1 = guidLadyBottom;
            _local_1 = glRight;
            _local_1 = Context.getInstance().needUserGuide;
            _local_1 = Context.getInstance().needUserGuide;
            _local_1 = (glRight + 10);
            _local_1 = (guidLadyBottom + 10);
            _local_1 = strVisitLabel;
            _local_1 = Context.getInstance().bVisitor;
            _local_1 = (((GuideStep.getInstance().currentStep == 2) || (GuideStep.getInstance().currentStep == 6001)) && (!(GuideStep.getInstance().hideViewHere)));
            _local_1 = (((GuideStep.getInstance().currentStep == 2) || (GuideStep.getInstance().currentStep == 6001)) && (!(GuideStep.getInstance().hideViewHere)));
            _local_1 = (GuideStep.getInstance().currentStep == 5);
            _local_1 = (GuideStep.getInstance().currentStep == 5);
            _local_1 = (GuideStep.getInstance().currentStep == 6);
            _local_1 = (GuideStep.getInstance().currentStep == 6);
            _local_1 = (GuideStep.getInstance().currentStep == 7);
            _local_1 = (GuideStep.getInstance().currentStep == 7);
            _local_1 = (GuideStep.getInstance().currentStep == 8);
            _local_1 = (GuideStep.getInstance().currentStep == 8);
            _local_1 = helpUrl;
            _local_1 = Context.getInstance().need_QuestGuid;
            _local_1 = allWinFrmHv;
            _local_1 = allWinFrmVv;
        }

        override protected function updateDisplayList(_arg_1:Number, _arg_2:Number):void
        {
            super.updateDisplayList(_arg_1, _arg_2);
            if (((((!(oldSx == this.scaleX)) || (!(oldSy == this.scaleY))) || (!(oldWidth == this.width))) || (!(oldHeight == this.height))))
            {
                oldSx = this.scaleX;
                oldSy = this.scaleY;
                oldWidth = this.width;
                oldHeight = this.height;
                if (this.mainFrame != null)
                {
                    this.callLater(mainFrame.doAutofit);
                }
                else
                {
                    trace("updateDisplayList and mainFrame is null");
                };
            };
        }

        public function __giftboxUi_click(_arg_1:MouseEvent):void
        {
            onGiftButtonClick();
        }


    }
}//package view

