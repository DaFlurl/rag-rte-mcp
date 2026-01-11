// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.MainScreen

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.core.SoundAsset;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import flash.utils.Timer;
    import mx.controls.Label;
    import mx.controls.TabBar;
    import com.evony.common.beans.PlayerBean;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Image;
    import mx.containers.VDividedBox;
    import mx.containers.HDividedBox;
    import mx.utils.ObjectProxy;
    import mx.collections.ArrayList;
    import autoevony.player.LoginHelper;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.common.beans.TroopBean;
    import autoevony.common.Utils;
    import mx.collections.ArrayCollection;
    import autoevony.scripts.CityState;
    import autoevony.management.CityManager;
    import autoevony.player.Map;
    import com.evony.common.beans.CastleBean;
    import autoevony.management.CityConfigs;
    import flash.events.KeyboardEvent;
    import autoevony.common.Items;
    import com.evony.common.module.common.GetItemDefResponse;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.common.server.events.NewMail;
    import autoevony.net.Connection;
    import com.evony.client.action.ActionFactory;
    import flash.events.TimerEvent;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.constants.ObjConstants;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.events.TextEvent;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.server.events.ResourceUpdate;
    import autoevony.event.ScriptLogEvent;
    import autoevony.event.WarLogEvent;
    import autoevony.event.StopScriptEvent;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.server.events.DeclaredWarUpdate;
    import com.evony.common.server.events.NewReport;
    import mx.events.ItemClickEvent;
    import flash.net.URLLoader;
    import com.evony.common.beans.HeroBean;
    import flash.external.ExternalInterface;
    import mx.rpc.http.HTTPService;
    import mx.rpc.events.ResultEvent;
    import mx.rpc.events.FaultEvent;
    import com.evony.common.constants.CommonConstants;
    import com.evony.common.server.events.HeroUpdate;
    import com.evony.common.server.events.FriendArmysUpdate;
    import com.skype.SkypeResponse;
    import com.skype.Skype;
    import com.evony.common.module.common.GetPackageNumberResponse;
    import com.evony.common.server.events.PlayerBuffUpdate;
    import mx.binding.Binding;
    import com.evony.common.server.events.TroopUpdate;
    import com.evony.common.server.events.PlayerInfoUpdate;
    import mx.controls.tabBarClasses.Tab;
    import com.evony.common.server.events.CastleFieldUpdate;
    import com.evony.common.server.events.SelfArmysUpdate;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.common.server.events.LoginResponse;
    import com.evony.common.server.events.CastleUpdate;
    import autoevony.gui.controls.themes.ThemeManager;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.server.events.EnemyArmysUpdate;
    import com.evony.common.server.events.ConnectionLost;
    import com.evony.common.server.events.ColonyUpdate;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.server.events.ItemUpdate;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class MainScreen extends Canvas implements IBindingClient 
    {

        private static const RefreshIcon:Class = MainScreen_RefreshIcon;
        private static const PauseIcon:Class = MainScreen_PauseIcon;
        private static const ResumeIcon:Class = MainScreen_ResumeIcon;
        private static var Scouted_Sound:Class = MainScreen_Scouted_Sound;
        public static var scoutedSound:SoundAsset = null;
        private static var Attempted_Sound:Class = MainScreen_Attempted_Sound;
        public static var attemptedSound:SoundAsset = null;
        public static var configAttackWarning:int = 0;
        private static var lastEmailTime:Number;
        private static var lastEmailMsg:String = null;
        private static var cities:Array = new Array();
        public static var lastActive:Number;
        private static var instance:MainScreen = null;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2003593416pauseButton:Button;
        private var _243786428_accountInfo:AccountInfo;
        private var _2093140739_logStack:ViewStack;
        private var unpauseTimer:Timer = null;
        private var _2033767917refreshButton:Button;
        private var displayServerClockTimer:Timer = null;
        private var _861376190_MainScreen_VersionLabelBottom:Label;
        private var _1247270413_citiesTab:TabBar;
        private var pausedLabelTimer:Timer = null;
        private var _773017919_serverClockTimeField:Label;
        private var checkGiftCounter:int = 2;
        private var _1051751339_mapCanvas:MapCanvas;
        private var _1255627100logoutButton:Button;
        private var attackSeveralSound:SoundAsset = null;
        private var attackEndedSound:SoundAsset = null;
        private var _2145417798currentPlayer:PlayerBean;
        private var skypeWarningTimer:Timer = null;
        public var _MainScreen_Label3:Label;
        private var _1882046310_clearLogBtn:Button;
        private var checkForUpdatedVersionTimer:Timer = null;
        private var _1587488048_cityPanelBeansArray:ViewStack;
        private var _3327407logs:TextArea;
        private var _1611115216_logTab:TabBar;
        private var _1685431770_cityPanel:CityPanel;
        private var _604333141_snippets:Snippets;
        private var attackSound:SoundAsset = null;
        private var lastWarningStatus:Boolean = false;
        private var _1140201565topInfo:TopInfo;
        private var _1012169220topInfoNameServ:Label;
        private var _116774925_chatPanel:ChatPanel;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "events":{
                            "keyDown":"___MainScreen_VBox1_keyDown",
                            "mouseMove":"___MainScreen_VBox1_mouseMove",
                            "mouseUp":"___MainScreen_VBox1_mouseUp"
                        },
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.paddingLeft = 3;
                            this.paddingRight = 3;
                            this.paddingTop = 3;
                            this.paddingBottom = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.verticalGap = 0;
                                        this.paddingLeft = 0;
                                        this.paddingRight = 0;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":42,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":VBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "25";
                                                                this.top = "1";
                                                                this.horizontalAlign = "center";
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":220,
                                                                    "height":40,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "styleName":"REmainScreenTopNamePopupTitleContainer"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"topInfoNameServ",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "35";
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":200,
                                                                    "styleName":"REmainScreenTopNameText",
                                                                    "toolTip":""
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TopInfo,
                                                            "id":"topInfo",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "255";
                                                                this.right = "273";
                                                                this.top = "0";
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.right = "0";
                                                                this.top = "0";
                                                                this.verticalAlign = "middle";
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 10;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"pauseButton",
                                                                        "events":{"click":"__pauseButton_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.paddingTop = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"REwinBtn",
                                                                                "enabled":true,
                                                                                "label":"Pause"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":10});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"refreshButton",
                                                                        "events":{"click":"__refreshButton_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.paddingTop = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"REwinBtn",
                                                                                "enabled":true,
                                                                                "label":"Refresh"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":15});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"logoutButton",
                                                                        "events":{"click":"__logoutButton_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "styleName":"REwinBtn",
                                                                                "enabled":true,
                                                                                "label":"Logout"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":10});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "middle";
                                                                            this.horizontalAlign = "center";
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":30,
                                                                                "height":32,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Image,
                                                                                    "events":{"click":"___MainScreen_Image1_click"},
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "source":_embed_mxml_autoevony_gui_images_helpIcon_png_987429035,
                                                                                            "toolTip":"Click to view the help doc."
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
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.verticalAlign = "bottom";
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "bottom";
                                                                            this.paddingLeft = 0;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "height":22,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":TabBar,
                                                                                    "id":"_citiesTab",
                                                                                    "events":{"itemClick":"___citiesTab_itemClick"},
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.tabStyleName = "REtabBarCitiesTab";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({"styleName":"REtabBar"});
                                                                                    }
                                                                                })]
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalAlign = "bottom";
                                                                            this.paddingLeft = 0;
                                                                            this.paddingRight = 0;
                                                                            this.paddingTop = 0;
                                                                            this.paddingBottom = 0;
                                                                            this.horizontalGap = 0;
                                                                            this.verticalGap = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":26,
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":Label,
                                                                                    "id":"_serverClockTimeField",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "text":"",
                                                                                            "styleName":"REmainScreenServerClockTimeField",
                                                                                            "toolTip":"Server Clock"
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
                                                            "id":"_cityPanelBeansArray",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                                this.borderStyle = "none";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":1,
                                                                    "height":0
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalGap = 0;
                                                                this.paddingLeft = 3;
                                                                this.paddingRight = 3;
                                                                this.paddingTop = 3;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "styleName":"REmainScreenMainPanel",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VDividedBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.verticalGap = 3;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "percentHeight":100,
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":CityPanel,
                                                                                    "id":"_cityPanel",
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "percentHeight":50
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HDividedBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalGap = 3;
                                                                                        this.borderStyle = "none";
                                                                                        this.verticalAlign = "bottom";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "percentHeight":50,
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.verticalGap = 0;
                                                                                                    this.paddingLeft = 0;
                                                                                                    this.paddingRight = 0;
                                                                                                    this.paddingTop = 0;
                                                                                                    this.paddingBottom = 3;
                                                                                                },
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentWidth":100,
                                                                                                        "percentHeight":100,
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":HBox,
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.verticalAlign = "bottom";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "percentWidth":100,
                                                                                                                    "height":22,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":TabBar,
                                                                                                                        "id":"_logTab",
                                                                                                                        "events":{"itemClick":"___logTab_itemClick"},
                                                                                                                        "stylesFactory":function ():void
                                                                                                                        {
                                                                                                                            this.tabStyleName = "REtabBarTab";
                                                                                                                        },
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"styleName":"REtabBar"});
                                                                                                                        }
                                                                                                                    })]
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":ViewStack,
                                                                                                            "id":"_logStack",
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "creationPolicy":"all",
                                                                                                                    "percentWidth":100,
                                                                                                                    "percentHeight":100,
                                                                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                                                                        "type":Canvas,
                                                                                                                        "events":{
                                                                                                                            "rollOver":"___MainScreen_Canvas3_rollOver",
                                                                                                                            "rollOut":"___MainScreen_Canvas3_rollOut"
                                                                                                                        },
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({
                                                                                                                                "percentWidth":100,
                                                                                                                                "percentHeight":100,
                                                                                                                                "label":"Log",
                                                                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                                                                    "type":TextArea,
                                                                                                                                    "id":"logs",
                                                                                                                                    "events":{"link":"__logs_link"},
                                                                                                                                    "stylesFactory":function ():void
                                                                                                                                    {
                                                                                                                                        this.left = "0";
                                                                                                                                        this.right = "0";
                                                                                                                                        this.top = "0";
                                                                                                                                        this.bottom = "0";
                                                                                                                                    },
                                                                                                                                    "propertiesFactory":function ():Object
                                                                                                                                    {
                                                                                                                                        return ({
                                                                                                                                            "styleName":"RElogBox",
                                                                                                                                            "editable":false
                                                                                                                                        });
                                                                                                                                    }
                                                                                                                                }), new UIComponentDescriptor({
                                                                                                                                    "type":Button,
                                                                                                                                    "id":"_clearLogBtn",
                                                                                                                                    "events":{"click":"___clearLogBtn_click"},
                                                                                                                                    "stylesFactory":function ():void
                                                                                                                                    {
                                                                                                                                        this.top = "10";
                                                                                                                                        this.right = "27";
                                                                                                                                    },
                                                                                                                                    "propertiesFactory":function ():Object
                                                                                                                                    {
                                                                                                                                        return ({
                                                                                                                                            "styleName":"clearLogBtn",
                                                                                                                                            "visible":false
                                                                                                                                        });
                                                                                                                                    }
                                                                                                                                })]
                                                                                                                            });
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":MapCanvas,
                                                                                                                        "id":"_mapCanvas",
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"label":"Maps"});
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":AccountInfo,
                                                                                                                        "id":"_accountInfo",
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"label":"Account"});
                                                                                                                        }
                                                                                                                    }), new UIComponentDescriptor({
                                                                                                                        "type":Snippets,
                                                                                                                        "id":"_snippets",
                                                                                                                        "propertiesFactory":function ():Object
                                                                                                                        {
                                                                                                                            return ({"label":"Snippets"});
                                                                                                                        }
                                                                                                                    })]
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":ChatPanel,
                                                                                                "id":"_chatPanel"
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
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 0;
                                        this.verticalGap = 0;
                                        this.paddingLeft = 3;
                                        this.paddingRight = 3;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":17,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":300,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainScreen_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontFamily = "DejaVu Sans";
                                                                this.fontSize = 10;
                                                                this.color = 0xFFFFFF;
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MainScreen_VersionLabelBottom",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontFamily = "DejaVu Sans";
                                                                this.fontSize = 10;
                                                                this.fontStyle = "italic";
                                                                this.color = 0xFFFFFF;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"text":""});
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
                    })]});
            }
        });
        private var Attack_Sound:Class = MainScreen_Attack_Sound;
        private var Attack_Several_Sound:Class = MainScreen_Attack_Several_Sound;
        private var Attack_Ended_Sound:Class = MainScreen_Attack_Ended_Sound;
        private var _94416770cache:ObjectProxy = new ObjectProxy({
            "logs":"",
            "cityLogs":new ArrayList(["", "", "", "", "", "", "", "", "", ""]),
            "warLogs":"",
            "emptyStr":""
        });
        private var config:LoginHelper = LoginHelper.getInstance();
        private var lastDate:Date = new Date();
        private var skypeLastSendTimes:Object = new Object();
        private var _embed_mxml_autoevony_gui_images_helpIcon_png_987429035:Class = MainScreen__embed_mxml_autoevony_gui_images_helpIcon_png_987429035;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MainScreen()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.paddingLeft = 0;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "REmainScreen";
            this.addEventListener("creationComplete", this.___MainScreen_Canvas1_creationComplete);
        }

        public static function setPlayer(_arg_1:PlayerBean):void
        {
            instance.currentPlayer = _arg_1;
        }

        private static function _we947(_arg_1:ArrayCollection, _arg_2:Number):TroopBean
        {
            var _local_7:String;
            var _local_3:TroopBean;
            var _local_4:TroopBean = new TroopBean();
            var _local_5:Object = _local_4.toObject();
            var _local_6:int;
            while (_local_6 < _arg_1.length)
            {
                if (!(_arg_1[_local_6].reachTime > _arg_2))
                {
                    _local_3 = Utils.getTroopBeanFromTroopStrBean(_arg_1[_local_6].troop);
                    if (_local_3 != null)
                    {
                        for (_local_7 in _local_5)
                        {
                            _local_4[_local_7] = (_local_4[_local_7] + _local_3[_local_7]);
                        };
                    };
                };
                _local_6++;
            };
            return (_local_4);
        }

        public static function getCityFromFieldId(_arg_1:int):CityState
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.castle.fieldId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getCityFromValleyFieldId(_arg_1:int):CityState
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.cityManager.isValley(_arg_1))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getCityManagerFromFieldId(_arg_1:int):CityManager
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.castle.fieldId == _arg_1)
                {
                    return (_local_2.cityManager);
                };
            };
            return (null);
        }

        public static function getCityFromName(_arg_1:String, _arg_2:Boolean=false):CityState
        {
            var _local_3:CityState;
            if (!_arg_2)
            {
                for each (_local_3 in cities)
                {
                    if (_local_3.castle.name == _arg_1)
                    {
                        return (_local_3);
                    };
                };
            }
            else
            {
                for each (_local_3 in cities)
                {
                    if (_local_3.castle.name.replace(new RegExp(String.fromCharCode(65279), "g"), "") == _arg_1)
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public static function getPlayer():PlayerBean
        {
            if (((instance == null) || (instance.currentPlayer == null)))
            {
                return (null);
            };
            return (instance.currentPlayer);
        }

        public static function setMaintPolicy(_arg_1:int=-1, _arg_2:int=-1):void
        {
            ChatPanel.maintMin = _arg_1;
            ChatPanel.maintMax = _arg_2;
        }

        public static function getMainTownCityState():CityState
        {
            var _local_1:CityState;
            for each (_local_1 in cities)
            {
                if (_local_1.cityManager.isMainTown())
                {
                    return (_local_1);
                };
            };
            return ((cities.length > 0) ? (cities[0] as CityState) : null);
        }

        public static function getCityManagerFromValleyFieldId(_arg_1:int):CityManager
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.cityManager.isValley(_arg_1))
                {
                    return (_local_2.cityManager);
                };
            };
            return (null);
        }

        public static function getCities():Array
        {
            return (cities);
        }

        public static function getInstance():MainScreen
        {
            return (instance);
        }

        public static function getCityManagerFromCastleId(_arg_1:int):CityManager
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.castleId == _arg_1)
                {
                    return (_local_2.cityManager);
                };
            };
            return (null);
        }

        public static function getClosestCityToFieldId(_arg_1:int, _arg_2:int=-1):CityState
        {
            var _local_4:CityState;
            var _local_3:CityState;
            for each (_local_4 in cities)
            {
                if (_local_4.castleId != _arg_2)
                {
                    if (_local_3 == null)
                    {
                        _local_3 = _local_4;
                    }
                    else
                    {
                        if (Map.fieldDistance(_local_4.castle.fieldId, _arg_1) < Map.fieldDistance(_local_3.castle.fieldId, _arg_1))
                        {
                            _local_3 = _local_4;
                        };
                    };
                };
            };
            return (_local_3);
        }

        public static function getCastle(_arg_1:int):CastleBean
        {
            var _local_2:CastleBean;
            for each (_local_2 in instance.currentPlayer.castlesArray)
            {
                if (_local_2.id == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function getCityFromColonyFieldId(_arg_1:int):CityState
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.cityManager.isColony(_arg_1))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MainScreen._watcherSetupUtil = _arg_1;
        }

        public static function setCastle(_arg_1:CastleBean):void
        {
            var _local_2:int;
            while (_local_2 < instance.currentPlayer.castlesArray.length)
            {
                if (instance.currentPlayer.castlesArray[_local_2].id == _arg_1.id)
                {
                    instance.currentPlayer.castlesArray[_local_2] = _arg_1;
                    return;
                };
                _local_2++;
            };
        }

        public static function get buildNpcEnabled():Boolean
        {
            var _local_1:CityState;
            for each (_local_1 in cities)
            {
                if (_local_1.cityManager.getCfg(CityConfigs.CFG_BUILDNPC) > 0)
                {
                    return (true);
                };
            };
            return (false);
        }

        public static function getCityFromCastleId(_arg_1:int):CityState
        {
            var _local_2:CityState;
            for each (_local_2 in cities)
            {
                if (_local_2.castleId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }


        public function ___MainScreen_VBox1_keyDown(_arg_1:KeyboardEvent):void
        {
            this.newKeyDownEvent(_arg_1);
        }

        private function onItemDefXml(_arg_1:GetItemDefResponse):void
        {
            var _local_2:String = Items.addPacketItem(_arg_1.itemXml);
            if (Version.isTraceOn())
            {
                trace(_arg_1.itemXml);
            };
            if (_local_2 != "")
            {
                getMainTownCityState().cityManager.logMsg(_local_2, "#666666");
            };
        }

        private function setScrollPos(target:TextArea):void
        {
            Utils.callLater(50, function ():void
            {
                target.verticalScrollPosition = target.maxVerticalScrollPosition;
            });
        }

        public function set _logStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._2093140739_logStack;
            if (_local_2 !== _arg_1)
            {
                this._2093140739_logStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_logStack", _local_2, _arg_1));
            };
        }

        public function set topInfoNameServ(_arg_1:Label):void
        {
            var _local_2:Object = this._1012169220topInfoNameServ;
            if (_local_2 !== _arg_1)
            {
                this._1012169220topInfoNameServ = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "topInfoNameServ", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get topInfoNameServ():Label
        {
            return (this._1012169220topInfoNameServ);
        }

        private function onLoadedText(_arg_1:Event):void
        {
            this.logMsg(_arg_1.target.data);
        }

        private function evtNewMail(_arg_1:NewMail):void
        {
            if (((((this.currentPlayer.newMailCount = _arg_1.count) > 0) || ((this.currentPlayer.newMaileCount_inbox = _arg_1.count_inbox) > 0)) || ((this.currentPlayer.newMaileCount_system = _arg_1.count_system) > 0)))
            {
                getMainTownCityState().cityManager.doMailNotification();
            };
        }

        private function doCityTabLabels(_arg_1:int=-1):void
        {
            var _local_5:CityState;
            var _local_6:CastleBean;
            var _local_7:CityPanelBean;
            var _local_2:String;
            var _local_3:int;
            var _local_4:* = (_arg_1 > -1);
            for each (_local_7 in this._cityPanelBeansArray.getChildren())
            {
                if (!((_local_4) && (!(_arg_1 == _local_7.castleId))))
                {
                    _local_5 = getCityFromCastleId(_local_7.castleId);
                    _local_6 = getCastle(_local_7.castleId);
                    _local_2 = _local_6.name.replace(new RegExp(String.fromCharCode(65279), "g"), "");
                    _local_2 = ((((_local_5.cityManager.isTrainingHeroInCity()) ? "*" : "") + ((_local_2.length < 4) ? _local_2 : _local_2.substring(0, 3))) + Map.fieldIdToCoordString(_local_6.fieldId));
                    if (_local_7.label != _local_2)
                    {
                        _local_7.label = _local_2;
                    };
                    if (_local_6.colonyBeansArray.length > 0)
                    {
                        if (this.cityIsSuzerain(_local_6))
                        {
                            _local_3 = CityPanelBean.ICON_TYPE_SUZ;
                        }
                        else
                        {
                            _local_3 = CityPanelBean.ICON_TYPE_COL;
                        };
                    }
                    else
                    {
                        _local_3 = CityPanelBean.ICON_TYPE_NONE;
                    };
                    _local_7.setTabIcon(_local_3);
                    if (_local_4) break;
                };
            };
        }

        private function topClockAndGiftUpdate(_arg_1:TimerEvent=null):void
        {
            this._serverClockTimeField.text = Utils.getServerTimeStr(true);
            this.topInfoNameServ.toolTip = ((((((("server:  " + this.config.server) + " (") + this.config.serverIP) + ")\nborn:  ") + new Date(this.currentPlayer.playerInfo.createrTime).toString()) + "\nage:  ") + Utils.formatTime(((Utils.getServerTime() - this.currentPlayer.playerInfo.createrTime) / 1000)));
            if (!Connection.getInstance().paused)
            {
                if (25 == this.checkGiftCounter--)
                {
                    ActionFactory.getInstance().getCommonCommands().getPackageNumber(this.setBoxNum);
                };
                if (this.checkGiftCounter < 1)
                {
                    this.checkGiftCounter = 25;
                };
            };
        }

        private function updateEnemyArmies(_arg_1:ArrayCollection):void
        {
            var _local_2:CityState;
            var _local_3:int;
            if (((this.currentPlayer == null) || (this.currentPlayer.enemyArmysArray == null)))
            {
                Utils.callLater(50, this.updateEnemyArmies, [_arg_1]);
                return;
            };
            if (getMainTownCityState() == null)
            {
                if (Version.isTraceOn())
                {
                    trace("   *****  Abnormal get MainTown response");
                };
                Utils.callLater(50, this.updateEnemyArmies, [_arg_1]);
                return;
            };
            this.currentPlayer.enemyArmysArray = _arg_1;
            this.currentPlayer.isReceiveIncomingAttack = (this.currentPlayer.enemyArmysArray.length > 0);
            for each (_local_2 in cities)
            {
                _local_2.cityManager._updateEnemyArmies(_arg_1);
            };
            _local_3 = 0;
            while (_local_3 < _arg_1.length)
            {
                if ((_arg_1[_local_3] as ArmyBean).missionType == ObjConstants.ARMY_MISSION_SEND)
                {
                    _arg_1.removeItemAt(_local_3--);
                };
                _local_3++;
            };
            _arg_1.source.sort(Utils.sortByReachTime);
            if (Version.isTraceOn())
            {
                trace(((("eArmyObj = " + ((_arg_1 != null) ? _arg_1.length : "null")) + "    isAtkWarnOn = ") + ((getMainTownCityState() != null) ? getMainTownCityState().cityManager._isAttackWarningOn() : "null")));
            };
            this.processEnemyAudioWarning(_arg_1, getMainTownCityState().cityManager._isAttackWarningOn());
            this.processEnemySkypeWarning();
        }

        private function loadCustomAudio():void
        {
            var atkSnd_onLoadComplete:Function;
            var atkSnd_onIOError:Function;
            var atkSvrlSnd_onLoadComplete:Function;
            var atkSvrlSnd_onIOError:Function;
            var atkEnd_onLoadComplete:Function;
            var atkEnd_onIOError:Function;
            var sct_onLoadComplete:Function;
            var sct_onIOError:Function;
            var attmptSct_onLoadComplete:Function;
            var attmptSct_onIOError:Function;
            atkSnd_onLoadComplete = function (_arg_1:Event):void
            {
                attackSound.removeEventListener(Event.COMPLETE, atkSnd_onLoadComplete);
                attackSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSnd_onIOError);
            };
            atkSnd_onIOError = function (_arg_1:IOErrorEvent):void
            {
                attackSound.removeEventListener(Event.COMPLETE, atkSnd_onLoadComplete);
                attackSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSnd_onIOError);
                attackSound = (new Attack_Sound() as SoundAsset);
                logMsg("Could not load custom attack sound, using default warning instead.");
                if (Version.isTraceOn())
                {
                    trace(("Could not load custom attack sound, using default warning instead:  " + _arg_1.text));
                };
            };
            try
            {
                this.attackSound = new SoundAsset();
                this.attackSound.addEventListener(Event.COMPLETE, atkSnd_onLoadComplete);
                this.attackSound.addEventListener(IOErrorEvent.IO_ERROR, atkSnd_onIOError);
                this.attackSound.load(new URLRequest("sounds/attack.mp3"));
            }
            catch(error1:Error)
            {
                attackSound.removeEventListener(Event.COMPLETE, atkSnd_onLoadComplete);
                attackSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSnd_onIOError);
                this.attackSound = (new Attack_Sound() as SoundAsset);
                this.logMsg(("Could not load custom attack sound, using default warning instead:  " + error1.message));
            };
            atkSvrlSnd_onLoadComplete = function (_arg_1:Event):void
            {
                attackSeveralSound.removeEventListener(Event.COMPLETE, atkSvrlSnd_onLoadComplete);
                attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSvrlSnd_onIOError);
            };
            atkSvrlSnd_onIOError = function (_arg_1:IOErrorEvent):void
            {
                attackSeveralSound.removeEventListener(Event.COMPLETE, atkSvrlSnd_onLoadComplete);
                attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSvrlSnd_onIOError);
                attackSeveralSound = (new Attack_Several_Sound() as SoundAsset);
                logMsg("Could not load custom attack_several sound, using default warning instead.");
                if (Version.isTraceOn())
                {
                    trace(("Could not load custom attack_several sound, using default warning instead:  " + _arg_1.text));
                };
            };
            try
            {
                this.attackSeveralSound = new SoundAsset();
                this.attackSeveralSound.addEventListener(Event.COMPLETE, atkSvrlSnd_onLoadComplete);
                this.attackSeveralSound.addEventListener(IOErrorEvent.IO_ERROR, atkSvrlSnd_onIOError);
                this.attackSeveralSound.load(new URLRequest("sounds/attack_several.mp3"));
            }
            catch(error2:Error)
            {
                attackSeveralSound.removeEventListener(Event.COMPLETE, atkSvrlSnd_onLoadComplete);
                attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR, atkSvrlSnd_onIOError);
                this.attackSeveralSound = (new Attack_Several_Sound() as SoundAsset);
                this.logMsg(("Could not load custom attack_several sound, using default warning instead:  " + error2.message));
            };
            atkEnd_onLoadComplete = function (_arg_1:Event):void
            {
                attackEndedSound.removeEventListener(Event.COMPLETE, atkEnd_onLoadComplete);
                attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR, atkEnd_onIOError);
            };
            atkEnd_onIOError = function (_arg_1:IOErrorEvent):void
            {
                attackEndedSound.removeEventListener(Event.COMPLETE, atkEnd_onLoadComplete);
                attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR, atkEnd_onIOError);
                attackEndedSound = (new Attack_Ended_Sound() as SoundAsset);
                logMsg("Could not load custom attack_ended sound, using default warning instead.");
                if (Version.isTraceOn())
                {
                    trace(("Could not load custom attack_ended sound, using default warning instead:  " + _arg_1.text));
                };
            };
            try
            {
                this.attackEndedSound = new SoundAsset();
                this.attackEndedSound.addEventListener(Event.COMPLETE, atkEnd_onLoadComplete);
                this.attackEndedSound.addEventListener(IOErrorEvent.IO_ERROR, atkEnd_onIOError);
                this.attackEndedSound.load(new URLRequest("sounds/attack_ended.mp3"));
            }
            catch(error3:Error)
            {
                attackEndedSound.removeEventListener(Event.COMPLETE, atkEnd_onLoadComplete);
                attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR, atkEnd_onIOError);
                this.attackEndedSound = (new Attack_Ended_Sound() as SoundAsset);
                this.logMsg(("Could not load custom attack_ended sound, using default warning instead:  " + error3.message));
            };
            sct_onLoadComplete = function (_arg_1:Event):void
            {
                scoutedSound.removeEventListener(Event.COMPLETE, sct_onLoadComplete);
                scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR, sct_onIOError);
            };
            sct_onIOError = function (_arg_1:IOErrorEvent):void
            {
                scoutedSound.removeEventListener(Event.COMPLETE, sct_onLoadComplete);
                scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR, sct_onIOError);
                scoutedSound = (new Scouted_Sound() as SoundAsset);
                logMsg("Could not load custom scouted sound, using default warning instead.");
                if (Version.isTraceOn())
                {
                    trace(("Could not load custom scouted sound, using default warning instead:  " + _arg_1.text));
                };
            };
            try
            {
                scoutedSound = new SoundAsset();
                scoutedSound.addEventListener(Event.COMPLETE, sct_onLoadComplete);
                scoutedSound.addEventListener(IOErrorEvent.IO_ERROR, sct_onIOError);
                scoutedSound.load(new URLRequest("sounds/scouted.mp3"));
            }
            catch(error4:Error)
            {
                scoutedSound.removeEventListener(Event.COMPLETE, sct_onLoadComplete);
                scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR, sct_onIOError);
                scoutedSound = (new Scouted_Sound() as SoundAsset);
                this.logMsg(("Could not load custom scouted sound, using default warning instead:  " + error4.message));
            };
            attmptSct_onLoadComplete = function (_arg_1:Event):void
            {
                attemptedSound.removeEventListener(Event.COMPLETE, attmptSct_onLoadComplete);
                attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR, attmptSct_onIOError);
            };
            attmptSct_onIOError = function (_arg_1:IOErrorEvent):void
            {
                attemptedSound.removeEventListener(Event.COMPLETE, attmptSct_onLoadComplete);
                attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR, attmptSct_onIOError);
                attemptedSound = (new Attempted_Sound() as SoundAsset);
                logMsg("Could not load custom attempted sound, using default warning instead.");
                if (Version.isTraceOn())
                {
                    trace(("Could not load custom attempted sound, using default warning instead:  " + _arg_1.text));
                };
            };
            try
            {
                attemptedSound = new SoundAsset();
                attemptedSound.addEventListener(Event.COMPLETE, attmptSct_onLoadComplete);
                attemptedSound.addEventListener(IOErrorEvent.IO_ERROR, attmptSct_onIOError);
                attemptedSound.load(new URLRequest("sounds/attempted.mp3"));
            }
            catch(error5:Error)
            {
                attemptedSound.removeEventListener(Event.COMPLETE, attmptSct_onLoadComplete);
                attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR, attmptSct_onIOError);
                attemptedSound = (new Attempted_Sound() as SoundAsset);
                this.logMsg(("Could not load custom attempted sound, using default warning instead:  " + error5.message));
            };
        }

        public function set _chatPanel(_arg_1:ChatPanel):void
        {
            var _local_2:Object = this._116774925_chatPanel;
            if (_local_2 !== _arg_1)
            {
                this._116774925_chatPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_chatPanel", _local_2, _arg_1));
            };
        }

        private function destroyCityObject(_arg_1:CityState):void
        {
            var _local_2:int = _arg_1.castleId;
            var _local_3:* = (this.getSelectedCity().castleId == _local_2);
            var _local_4:int;
            while (_local_4 < this._cityPanelBeansArray.getChildren().length)
            {
                if ((this._cityPanelBeansArray.getChildAt(_local_4) as CityPanelBean).castleId == _local_2)
                {
                    this._cityPanelBeansArray.removeChildAt(_local_4--);
                };
                _local_4++;
            };
            if ((_local_4 = cities.indexOf(_arg_1)) != -1)
            {
                this.unInitCityScript(_arg_1);
                this.cache.cityLogs.setItemAt("", _local_4);
                cities.splice(_local_4, 1);
            };
            _local_4 = 0;
            while (_local_4 < this.currentPlayer.castlesArray.length)
            {
                if (this.currentPlayer.castlesArray[_local_4].id == _local_2)
                {
                    this.currentPlayer.castlesArray.removeItemAt(_local_4--);
                };
                _local_4++;
            };
            if (_local_3)
            {
                this._cityPanel.cityPanelBean = (this._cityPanelBeansArray.getChildAt(0) as CityPanelBean);
                this._cityPanel.castleBean = (this.currentPlayer.castlesArray.getItemAt(0) as CastleBean);
                this._cityPanelBeansArray.selectedIndex = 0;
            };
        }

        [Bindable(event="propertyChange")]
        public function get _chatPanel():ChatPanel
        {
            return (this._116774925_chatPanel);
        }

        public function set _citiesTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1247270413_citiesTab;
            if (_local_2 !== _arg_1)
            {
                this._1247270413_citiesTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_citiesTab", _local_2, _arg_1));
            };
        }

        private function handleLogLinkEvent(_arg_1:TextEvent):void
        {
            navigateToURL(new URLRequest(("http://" + _arg_1.text)), "_blank");
        }

        private function eArmyToString(_arg_1:ArmyBean):String
        {
            return (((((((((_arg_1.alliance != null) ? (" alliance:" + _arg_1.alliance) : "") + ((_arg_1.king != null) ? (" lord:" + _arg_1.king) : "")) + ((_arg_1.startPosName != null) ? (" from:" + _arg_1.startPosName) : "")) + ((_arg_1.startFieldId != -1) ? (((("(" + Map.getX(_arg_1.startFieldId)) + ",") + Map.getY(_arg_1.startFieldId)) + ")") : "")) + ((_arg_1.targetPosName != null) ? (" to:" + _arg_1.targetPosName) : "")) + ((_arg_1.targetFieldId != -1) ? (((("(" + Map.getX(_arg_1.targetFieldId)) + ",") + Map.getY(_arg_1.targetFieldId)) + ")") : "")) + ((_arg_1.troop != null) ? (" troop: " + Utils.troopStrBeanToMsgString(_arg_1.troop)) : "")) + ((_arg_1.reachTime != -1) ? (((" in " + Utils.formatEndTime(_arg_1.reachTime)) + " @ ") + Utils.getLogTimeStr(_arg_1.reachTime)) : ""));
        }

        [Bindable(event="propertyChange")]
        public function get _citiesTab():TabBar
        {
            return (this._1247270413_citiesTab);
        }

        public function ___MainScreen_Canvas3_rollOut(_arg_1:MouseEvent):void
        {
            this._clearLogBtn.visible = false;
        }

        private function onResourceUpdate(_arg_1:ResourceUpdate):void
        {
            var _local_2:CastleBean;
            var _local_3:CityState;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                return;
            };
            if (((this.currentPlayer == null) || (this.currentPlayer.castlesArray == null)))
            {
                Utils.callLater(50, this.onResourceUpdate, [_arg_1]);
            }
            else
            {
                _local_2 = getCastle(_arg_1.castleId);
                if (_local_2 != null)
                {
                    if (_local_2.resource == null)
                    {
                        _local_2.resource = _arg_1.resource;
                    }
                    else
                    {
                        _arg_1.resource.copyTo(_local_2.resource);
                    };
                    _local_3 = getCityFromCastleId(_arg_1.castleId);
                    if (_local_3 != null)
                    {
                        _local_3.cityManager._onResourceUpdate();
                    };
                };
            };
        }

        private function unInitCityScript(_arg_1:CityState):void
        {
            _arg_1._getScript().removeEventListener(ScriptLogEvent.TYPE, this.cityLogMsg);
            _arg_1.cityManager.removeEventListener(ScriptLogEvent.TYPE, this.cityLogMsg);
            _arg_1.cityManager.removeEventListener(WarLogEvent.TYPE, this.warLogMsg);
            _arg_1._getScript().removeEventListener(StopScriptEvent.STOP_SCRIPT, this.onStopScriptEvent);
            _arg_1._getScript()._cleanUp();
        }

        private function doPauseResume():void
        {
            var _local_1:Connection = Connection.getInstance();
            _local_1.paused = (_local_1.paused == false);
            this.modifyCtrlBtns();
            this.logMsg(((_local_1.paused) ? "Pausing jobs" : "Resuming jobs"));
            _local_1.reconnectTimer.delay = Utils.rand((20 * 1000), (30 * 1000));
            _local_1.reconnectHandler();
            if ((((!(_local_1.paused)) && (!(this.unpauseTimer == null))) && (this.unpauseTimer.running)))
            {
                this.unpauseTimer.stop();
            };
        }

        private function clear(_arg_1:Boolean, _arg_2:String, _arg_3:Boolean=false):void
        {
            if (!_arg_1)
            {
                return;
            };
            if (_arg_3)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Are you sure you want to clear this log window?", this.clear, "Clear Log", "Cancel", [_arg_2]));
                return;
            };
            if (_arg_2 == "cityLogs")
            {
                (this.cache.cityLogs as ArrayList).setItemAt("", this._citiesTab.selectedIndex);
                this.cache.emptyStr = " ";
                this.cache.emptyStr = "";
            }
            else
            {
                this.cache[_arg_2] = "";
            };
        }

        private function evtDeclaredWarsUpdate(_arg_1:DeclaredWarUpdate):void
        {
            this.currentPlayer.declaredWarBeansArray = _arg_1.declaredWarBeansArray;
        }

        public function _dx1146(_arg_1:int):Boolean
        {
            var _local_2:ArmyBean;
            for each (_local_2 in this.currentPlayer.enemyArmysArray)
            {
                if ((_local_2.reachTime - Utils.getServerTime()) < (_arg_1 * 1000))
                {
                    return (true);
                };
            };
            return (false);
        }

        private function evtNewReport(_arg_1:NewReport):void
        {
            if (((this.currentPlayer == null) || (getMainTownCityState() == null)))
            {
                Utils.callLater(50, this.evtNewReport, [_arg_1]);
                return;
            };
            var _local_2:CityManager = getMainTownCityState().cityManager;
            this.currentPlayer.newReportCount = _arg_1.count;
            this.currentPlayer.newReportCount_army = _arg_1.army_count;
            this.currentPlayer.newReportCount_scout = _arg_1.scout_cout;
            this.currentPlayer.newReportCount_trade = _arg_1.trade_count;
            this.currentPlayer.newReportCount_other = _arg_1.other_count;
            _local_2._handleNewReport(_arg_1);
        }

        public function ___citiesTab_itemClick(_arg_1:ItemClickEvent):void
        {
            this.onCityTabClick(_arg_1);
        }

        public function disableLogoutButton():void
        {
            this.logoutButton.enabled = false;
        }

        private function loadTextTest():void
        {
            var _local_1:URLLoader = new URLLoader();
            _local_1.addEventListener(Event.COMPLETE, this.onLoadedText);
            _local_1.load(new URLRequest("Scripts/myTextTest.txt"));
        }

        private function onSecCodeResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.showNewMsg("logs", ("WARNING: Error received while handling security code:  " + _arg_1.errorMsg), "#CC0000");
            }
            else
            {
                ActionFactory.getInstance().getSecurityCommands().setUnlockOption(31, this.onUnlockSecOption);
            };
        }

        [Bindable(event="propertyChange")]
        public function get _mapCanvas():MapCanvas
        {
            return (this._1051751339_mapCanvas);
        }

        public function ___MainScreen_Canvas3_rollOver(_arg_1:MouseEvent):void
        {
            this._clearLogBtn.visible = true;
        }

        [Bindable(event="propertyChange")]
        public function get _snippets():Snippets
        {
            return (this._604333141_snippets);
        }

        private function initCities():void
        {
            var ii:int;
            var i:int;
            var pw:String = this.config.getHashedEvonyPw();
            var found:Boolean;
            var firstCastleId:int = (this.currentPlayer.castlesArray.getItemAt(0) as CastleBean).id;
            var castle:CastleBean;
            var h:HeroBean;
            var newCity:CityState;
            var cPanelBean:CityPanelBean;
            try
            {
                i = 0;
                while (i < this.currentPlayer.castlesArray.length)
                {
                    castle = this.currentPlayer.castlesArray[i];
                    for each (h in castle.herosArray)
                    {
                        Utils.formatHeroName(h);
                    };
                    Utils.sortFieldsByDistance(castle);
                    found = false;
                    ii = 0;
                    while (ii < cities.length)
                    {
                        if ((cities[ii] as CityState).castleId == castle.id)
                        {
                            found = true;
                            if (ii != i)
                            {
                                cities.splice(i, 0, cities.splice(ii, 1)[0]);
                                this._cityPanelBeansArray.addChildAt(this._cityPanelBeansArray.removeChildAt(ii), i);
                            };
                            (cities[i] as CityState)._setCastleBean();
                            break;
                        };
                        ii = (ii + 1);
                    };
                    if (!found)
                    {
                        if (castle.id != firstCastleId)
                        {
                            newCity = new CityState(int(castle.id));
                        }
                        else
                        {
                            newCity = new CityState(int(castle.id), false);
                        };
                        cities.push(newCity);
                        cPanelBean = new CityPanelBean(int(castle.id), (((castle.name.length < 4) ? castle.name : castle.name.substring(0, 3)) + Map.fieldIdToCoordString(castle.fieldId)));
                        this._cityPanelBeansArray.addChild(cPanelBean);
                        this.initCityScript(newCity);
                        cPanelBean.onLoadGoals();
                        cPanelBean.onLoadScript(null, 5000);
                    };
                    i = (i + 1);
                };
                this.removeStaleCityObjects();
                if (!this._cityPanel.isInitialized)
                {
                    this._cityPanel.init();
                };
                Utils.callLater(50, this.doCityTabLabels);
                Utils.callLater(100, this.doCityTabColors);
            }
            catch(error:Error)
            {
                logMsg(("Error in parseCities: " + error.message));
            };
        }

        private function onCancelRemoveResponse(_arg_1:CommandResponse):void
        {
            var _local_2:* = "";
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                _local_2 = ("An error occured while attempting to cancel the security code removal process:  " + _arg_1.errorMsg);
            }
            else
            {
                _local_2 = "The security code removal process has been cancelled sucessfully.";
            };
            getMainTownCityState().cityManager.logMsg(_local_2, "#AA0000");
        }

        private function removeStaleCityObjects():void
        {
            var _local_1:Boolean;
            var _local_2:CastleBean;
            var _local_3:int;
            while (_local_3 < cities.length)
            {
                _local_1 = false;
                for each (_local_2 in this.currentPlayer.castlesArray)
                {
                    if (_local_2.id == cities[_local_3].castleId)
                    {
                        _local_1 = true;
                        break;
                    };
                };
                if (!_local_1)
                {
                    this.destroyCityObject((cities[_local_3--] as CityState));
                };
                _local_3++;
            };
        }

        public function enableLogoutButton():void
        {
            this.logoutButton.enabled = true;
        }

        private function getPlayerBuffIndexFromTypeId(_arg_1:String):int
        {
            var _local_2:int;
            while (_local_2 < this.currentPlayer.buffsArray.length)
            {
                if (this.currentPlayer.buffsArray[_local_2].typeId == _arg_1)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        public function ___MainScreen_VBox1_mouseUp(_arg_1:MouseEvent):void
        {
            this._cityPanel.onHideRename(_arg_1.target);
        }

        private function setWindowTitle(newTitle:String=""):void
        {
            try
            {
                ExternalInterface.call("changeTitle", newTitle);
            }
            catch(e:Error)
            {
                this.showNewMsg("logs", ("Cannot set window title: " + e.message));
            };
        }

        public function set _MainScreen_VersionLabelBottom(_arg_1:Label):void
        {
            var _local_2:Object = this._861376190_MainScreen_VersionLabelBottom;
            if (_local_2 !== _arg_1)
            {
                this._861376190_MainScreen_VersionLabelBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_MainScreen_VersionLabelBottom", _local_2, _arg_1));
            };
        }

        private function handleSecCode():void
        {
            if (this.config.secCode == "")
            {
                this.showNewMsg("logs", "WARNING: Security code is set with no way to disable it for full account management. Restart and enter code at login screen, or manually run script.", "#CC0000");
            }
            else
            {
                ActionFactory.getInstance().getSecurityCommands().authSecurityCode(this.config.secCode, this.onSecCodeResponse);
            };
        }

        public function scheduleUnpauseTimer(_arg_1:Number):void
        {
            var _local_2:Date;
            if (!Connection.getInstance().paused)
            {
                _local_2 = new Date((new Date().getTime() + _arg_1));
                this.logMsg((((((("*** Pausing job queues for " + Utils.formatTime((_arg_1 / 1000))) + " before automatically resuming at ") + Utils.format2(_local_2.hours)) + ":") + Utils.format2(_local_2.minutes)) + ". ***"), "#79796A");
                this.doPauseResume();
            };
            if (this.unpauseTimer != null)
            {
                this.unpauseTimer.delay = _arg_1;
                this.unpauseTimer.reset();
            }
            else
            {
                this.unpauseTimer = new Timer(_arg_1, 1);
                this.unpauseTimer.addEventListener(TimerEvent.TIMER, this.onUnpauseTimer);
            };
            this.unpauseTimer.start();
        }

        private function checkForUpdatedVersion(evt:TimerEvent=null):void
        {
            var checkForUpdatedVersionResponse:Function;
            var checkForUpdatedVersionErrorResponse:Function;
            var httpReq:HTTPService;
            checkForUpdatedVersionResponse = function (_arg_1:ResultEvent):void
            {
                httpReq.removeEventListener(ResultEvent.RESULT, checkForUpdatedVersionResponse);
                httpReq.removeEventListener(FaultEvent.FAULT, checkForUpdatedVersionErrorResponse);
                var _local_2:XML = new XML(_arg_1.message.body.toString());
                var _local_3:String = _local_2.versionInfo.@ver;
                var _local_4:String = _local_2.versionInfo.@step;
                var _local_5:String = _local_2.versionInfo.@release;
                if ((((!(_local_3 == Version.getVersion())) || (!(_local_4 == Version.getStep()))) || (!(_local_5 == Version.getRelease()))))
                {
                    _MainScreen_VersionLabelBottom.text = (((_local_2.versionInfo.@isBeta == "true") ? "A Beta" : "An") + " update is available!    ");
                }
                else
                {
                    _MainScreen_VersionLabelBottom.text = "";
                };
                httpReq = null;
                _local_2 = null;
            };
            checkForUpdatedVersionErrorResponse = function (_arg_1:FaultEvent):void
            {
                httpReq.removeEventListener(ResultEvent.RESULT, checkForUpdatedVersionResponse);
                httpReq.removeEventListener(FaultEvent.FAULT, checkForUpdatedVersionErrorResponse);
                httpReq = null;
            };
            var postVars:Object = new Object();
            postVars.getVerUpdateInfo = "checkRE";
            httpReq = new HTTPService();
            httpReq.method = "POST";
            httpReq.url = "http://evonystuff.com/dls/RE/validateRE_Ver.asp";
            httpReq.resultFormat = HTTPService.RESULT_FORMAT_XML;
            httpReq.contentType = HTTPService.CONTENT_TYPE_FORM;
            httpReq.method = "POST";
            httpReq.addEventListener(ResultEvent.RESULT, checkForUpdatedVersionResponse);
            httpReq.addEventListener(FaultEvent.FAULT, checkForUpdatedVersionErrorResponse);
            httpReq.send(postVars);
        }

        private function onHeroUpdate(_arg_1:HeroUpdate):void
        {
            var _local_2:CityState = getCityFromCastleId(_arg_1.castleId);
            if (((_local_2 == null) || (_local_2.cityManager == null)))
            {
                Utils.callLater(50, this.onHeroUpdate, [_arg_1]);
                return;
            };
            _local_2.cityManager._onHeroUpdate(_arg_1);
            if (((_local_2.cityManager._isTraininghero(_arg_1.hero.name)) && ((_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD) || (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE))))
            {
                this.doCityTabLabels(_arg_1.castleId);
            };
            if (((_arg_1.hero.isHero == CommonConstants.HERO_KING_QUEEN) && ((_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD) || (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE))))
            {
                this.doCityTabColors(_arg_1.castleId);
            };
        }

        private function evtFriendArmiesUpdate(_arg_1:FriendArmysUpdate):void
        {
            if (((this.currentPlayer == null) || (this.currentPlayer.friendArmysArray == null)))
            {
                Utils.callLater(50, this.evtFriendArmiesUpdate, [_arg_1]);
            }
            else
            {
                this.updateFriendlyArmies(_arg_1.armysArray);
            };
        }

        public function __logs_link(_arg_1:TextEvent):void
        {
            this.handleLogLinkEvent(_arg_1);
        }

        public function warLogMsg(_arg_1:WarLogEvent):void
        {
            this.showNewMsg("warLogs", _arg_1.logText);
            if (this._logTab.selectedIndex != 2)
            {
                this._logTab.getChildren()[2].setStyle("fontStyle", "italic");
            };
        }

        private function updateFriendlyArmies(_arg_1:ArrayCollection):void
        {
            var _local_4:CityState;
            var _local_5:int;
            var _local_6:ArmyBean;
            if (_arg_1 == null)
            {
                return;
            };
            this.currentPlayer.friendArmysArray = _arg_1;
            var _local_2:Array = new Array();
            var _local_3:Array = new Array();
            for each (_local_4 in cities)
            {
                _local_2.push(_local_4.castle.fieldId);
                _local_3.push([]);
            };
            for each (_local_6 in _arg_1)
            {
                if ((_local_5 = _local_2.indexOf(_local_6.targetFieldId)) != -1)
                {
                    (_local_3[_local_5] as Array).push(_local_6);
                };
            };
            for each (_local_4 in cities)
            {
                _local_4.cityManager._updateFriendArmies((_local_3[_local_2.indexOf(_local_4.castle.fieldId)] as Array));
            };
        }

        public function set _mapCanvas(_arg_1:MapCanvas):void
        {
            var _local_2:Object = this._1051751339_mapCanvas;
            if (_local_2 !== _arg_1)
            {
                this._1051751339_mapCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_mapCanvas", _local_2, _arg_1));
            };
        }

        private function sendSkypeWarnings(receivers:Array, msg:String):void
        {
            var receiver:Object;
            var skResp:SkypeResponse;
            for each (receiver in receivers)
            {
                try
                {
                    if ((skResp = Skype.queueMsg(receiver.id, msg, receiver.isGroup)).ok != 1)
                    {
                        trace(skResp.errorMsg);
                    };
                }
                catch(e:Error)
                {
                    trace(e);
                };
            };
        }

        public function set _snippets(_arg_1:Snippets):void
        {
            var _local_2:Object = this._604333141_snippets;
            if (_local_2 !== _arg_1)
            {
                this._604333141_snippets = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_snippets", _local_2, _arg_1));
            };
        }

        private function _MainScreen_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.currentPlayer.playerInfo.userName;
            _local_1 = ((this.currentPlayer.playerInfo.alliance == null) ? "(no alliance)" : this.currentPlayer.playerInfo.alliance);
            _local_1 = Utils.formatInt(this.currentPlayer.playerInfo.prestige);
            _local_1 = this.currentPlayer.playerInfo.office;
            _local_1 = Utils.formatInt(this.currentPlayer.playerInfo.medal);
            _local_1 = Utils.formatInt(this.currentPlayer.playerInfo.ranking);
            _local_1 = (this.currentPlayer.playerInfo.levelId - 4);
            _local_1 = ((this.currentPlayer.playerInfo.alliance == null) ? "" : this.currentPlayer.playerInfo.allianceLevel);
            _local_1 = Utils.formatInt(this.currentPlayer.playerInfo.honor);
            _local_1 = Map.TITLES.getItemAt(this.currentPlayer.playerInfo.titleId);
            _local_1 = PauseIcon;
            _local_1 = RefreshIcon;
            _local_1 = this._cityPanelBeansArray.selectedChild;
            _local_1 = this.currentPlayer.castlesArray.getItemAt(this._cityPanelBeansArray.selectedIndex);
            _local_1 = [{"label":"Log"}, {"label":"City Log"}, {"label":"War Log"}, {"label":"Maps"}, {"label":"Account"}, {"label":"Snippets"}];
            _local_1 = ((this._logTab.selectedIndex < 3) ? 0 : (this._logTab.selectedIndex - 2));
            _local_1 = ((this._logTab.selectedIndex == 0) ? this.cache.logs : ((this._logTab.selectedIndex == 1) ? this.cache.cityLogs.getItemAt(this._citiesTab.selectedIndex) : ((this._logTab.selectedIndex == 2) ? this.cache.warLogs : this.cache.emptyStr)));
            _local_1 = (("Clear all entries from the " + ((this._logTab.selectedIndex == 0) ? "Main" : ((this._logTab.selectedIndex == 1) ? "City" : "War"))) + " Log");
            _local_1 = ("   RE for Age II: " + Version.getVersionStr());
        }

        [Bindable(event="propertyChange")]
        public function get _accountInfo():AccountInfo
        {
            return (this._243786428_accountInfo);
        }

        public function setBoxNum(_arg_1:GetPackageNumberResponse):void
        {
            var _local_2:int;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                if (Version.isTraceOn())
                {
                    trace(_arg_1.errorMsg);
                };
            }
            else
            {
                this.checkGiftCounter = 24;
                _local_2 = _arg_1.number;
                if (_local_2 < 1)
                {
                    _local_2 = 0;
                };
                if (this.topInfo.gift != Utils.formatInt(_local_2))
                {
                    this.topInfo.gift = Utils.formatInt(_local_2);
                };
            };
        }

        public function set logoutButton(_arg_1:Button):void
        {
            var _local_2:Object = this._1255627100logoutButton;
            if (_local_2 !== _arg_1)
            {
                this._1255627100logoutButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoutButton", _local_2, _arg_1));
            };
        }

        private function evtPlayerBuffUpdate(_arg_1:PlayerBuffUpdate):void
        {
            if (_arg_1.buffBean == null)
            {
                return;
            };
            var _local_2:int = this.getPlayerBuffIndexFromTypeId(_arg_1.buffBean.typeId);
            var _local_3:* = "";
            if (_arg_1.updateType == 0)
            {
                _local_3 = ((((("PLAYERBUFFUPDATE > <b>Buff added</b>: <u>" + _arg_1.buffBean.typeId) + "</u>: ") + _arg_1.buffBean.descName) + "  <b>remain time</b>: ") + Utils.formatTime(((_arg_1.buffBean.endTime - Utils.getServerTime()) / 1000)));
                if (_local_2 != -1)
                {
                    this.currentPlayer.buffsArray[_local_2] = _arg_1.buffBean;
                }
                else
                {
                    this.currentPlayer.buffsArray.addItem(_arg_1.buffBean);
                };
            }
            else
            {
                if (_arg_1.updateType == 1)
                {
                    _local_3 = ((("PLAYERBUFFUPDATE > <b>Buff removed</b>: <u>" + _arg_1.buffBean.typeId) + "</u>: ") + _arg_1.buffBean.descName);
                    if (_local_2 != -1)
                    {
                        this.currentPlayer.buffsArray.removeItemAt(_local_2);
                    };
                }
                else
                {
                    if (_arg_1.updateType == 2)
                    {
                        _local_3 = ((((("PLAYERBUFFUPDATE > <b>Buff change</b>: <u>" + _arg_1.buffBean.typeId) + "</u>: ") + _arg_1.buffBean.descName) + "  <b>remain time</b>: ") + Utils.formatTime(((_arg_1.buffBean.endTime - Utils.getServerTime()) / 1000)));
                        if (_local_2 == -1)
                        {
                            this.currentPlayer.buffsArray.addItem(_arg_1.buffBean);
                        }
                        else
                        {
                            this.currentPlayer.buffsArray[_local_2] = _arg_1.buffBean;
                        };
                    }
                    else
                    {
                        _local_3 = ((("PLAYERBUFFUPDATE > ignore buff update " + _arg_1.updateType) + " on ") + _arg_1.buffBean.typeId);
                    };
                };
            };
            if (_local_3 != "")
            {
                getMainTownCityState().cityManager.logMsg(_local_3, "#225555");
            };
            if (((((_arg_1.updateType == 0) || (_arg_1.updateType == 2)) && (_arg_1.buffBean.typeId == "RemovingSecurityCodeBuff")) && (getMainTownCityState().cityManager.getCfg(CityConfigs.CFG_ALLOWDISABLESECCODE) <= 0)))
            {
                getMainTownCityState().cityManager.logMsg("Detected an attempt to remove security code. Cancelling code removal now.", "#AA0000");
                ActionFactory.getInstance().getSecurityCommands().cancelRemovingSecurityCodeProcess(this.onCancelRemoveResponse);
            };
        }

        [Bindable(event="propertyChange")]
        public function get _serverClockTimeField():Label
        {
            return (this._773017919_serverClockTimeField);
        }

        private function initReqs(_arg_1:int):void
        {
            ActionFactory.getInstance().getQuestCommands().getQuestType(_arg_1, 1);
            ActionFactory.getInstance().getQuestCommands().getQuestType(_arg_1, 4);
            ActionFactory.getInstance().getCommonCommands().getItemDefXml(this.onItemDefXml);
            ActionFactory.getInstance().getTechCommand().getResearchList(_arg_1);
            ActionFactory.getInstance().getQuestCommands().getQuestList(_arg_1, 64);
            ActionFactory.getInstance().getCommonCommands().getPackageNumber(this.setBoxNum);
            ActionFactory.getInstance().getTechCommand().getResearchList(_arg_1);
            ActionFactory.getInstance().getEquipmenttechCommands().getResearchList(_arg_1);
        }

        private function sendEmailAlert(_arg_1:String, _arg_2:String):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get _cityPanelBeansArray():ViewStack
        {
            return (this._1587488048_cityPanelBeansArray);
        }

        public function set _clearLogBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1882046310_clearLogBtn;
            if (_local_2 !== _arg_1)
            {
                this._1882046310_clearLogBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_clearLogBtn", _local_2, _arg_1));
            };
        }

        private function _MainScreen_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.currentPlayer.playerInfo.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfoNameServ.text = _arg_1;
            }, "topInfoNameServ.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.currentPlayer.playerInfo.alliance == null) ? "(no alliance)" : this.currentPlayer.playerInfo.alliance);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.alliance = _arg_1;
            }, "topInfo.alliance");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.currentPlayer.playerInfo.prestige);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.prestige = _arg_1;
            }, "topInfo.prestige");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.currentPlayer.playerInfo.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.office = _arg_1;
            }, "topInfo.office");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.currentPlayer.playerInfo.medal);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.gameCoins = _arg_1;
            }, "topInfo.gameCoins");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.currentPlayer.playerInfo.ranking);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.ranking = _arg_1;
            }, "topInfo.ranking");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.currentPlayer.playerInfo.levelId - 4);
            }, function (_arg_1:int):void
            {
                topInfo.roleImg = _arg_1;
            }, "topInfo.roleImg");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.currentPlayer.playerInfo.alliance == null) ? "" : this.currentPlayer.playerInfo.allianceLevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.role = _arg_1;
            }, "topInfo.role");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.currentPlayer.playerInfo.honor);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.honor = _arg_1;
            }, "topInfo.honor");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Map.TITLES.getItemAt(this.currentPlayer.playerInfo.titleId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                topInfo.title = _arg_1;
            }, "topInfo.title");
            result[9] = binding;
            binding = new Binding(this, function ():Class
            {
                return (PauseIcon);
            }, function (_arg_1:Class):void
            {
                pauseButton.setStyle("icon", _arg_1);
            }, "pauseButton.icon");
            result[10] = binding;
            binding = new Binding(this, function ():Class
            {
                return (RefreshIcon);
            }, function (_arg_1:Class):void
            {
                refreshButton.setStyle("icon", _arg_1);
            }, "refreshButton.icon");
            result[11] = binding;
            binding = new Binding(this, function ():CityPanelBean
            {
                return (this._cityPanelBeansArray.selectedChild);
            }, function (_arg_1:CityPanelBean):void
            {
                _cityPanel.cityPanelBean = _arg_1;
            }, "_cityPanel.cityPanelBean");
            result[12] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.currentPlayer.castlesArray.getItemAt(this._cityPanelBeansArray.selectedIndex));
            }, function (_arg_1:CastleBean):void
            {
                _cityPanel.castleBean = _arg_1;
            }, "_cityPanel.castleBean");
            result[13] = binding;
            binding = new Binding(this, function ():Object
            {
                return ([{"label":"Log"}, {"label":"City Log"}, {"label":"War Log"}, {"label":"Maps"}, {"label":"Account"}, {"label":"Snippets"}]);
            }, function (_arg_1:Object):void
            {
                _logTab.dataProvider = _arg_1;
            }, "_logTab.dataProvider");
            result[14] = binding;
            binding = new Binding(this, function ():int
            {
                return ((this._logTab.selectedIndex < 3) ? 0 : (this._logTab.selectedIndex - 2));
            }, function (_arg_1:int):void
            {
                _logStack.selectedIndex = _arg_1;
            }, "_logStack.selectedIndex");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._logTab.selectedIndex == 0) ? this.cache.logs : ((this._logTab.selectedIndex == 1) ? this.cache.cityLogs.getItemAt(this._citiesTab.selectedIndex) : ((this._logTab.selectedIndex == 2) ? this.cache.warLogs : this.cache.emptyStr)));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                logs.htmlText = _arg_1;
            }, "logs.htmlText");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("Clear all entries from the " + ((this._logTab.selectedIndex == 0) ? "Main" : ((this._logTab.selectedIndex == 1) ? "City" : "War"))) + " Log");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _clearLogBtn.toolTip = _arg_1;
            }, "_clearLogBtn.toolTip");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("   RE for Age II: " + Version.getVersionStr());
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MainScreen_Label3.text = _arg_1;
            }, "_MainScreen_Label3.text");
            result[18] = binding;
            return (result);
        }

        public function __refreshButton_click(_arg_1:MouseEvent):void
        {
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get _logTab():TabBar
        {
            return (this._1611115216_logTab);
        }

        private function armyToMsgString(_arg_1:String, _arg_2:ArmyBean):String
        {
            var _local_3:String = ((("<b>" + _arg_1) + " to</b> ") + this.currentPlayer.playerInfo.userName);
            if (_arg_2.targetFieldId != -1)
            {
                _local_3 = (_local_3 + ((((((" <b>at</b> " + getCityFromFieldId(_arg_2.targetFieldId).castle.name) + "(") + Map.getX(_arg_2.targetFieldId)) + ",") + Map.getY(_arg_2.targetFieldId)) + ")"));
            };
            if (_arg_2.king != null)
            {
                _local_3 = (_local_3 + (" <b>by</b> " + _arg_2.king));
            };
            if (_arg_2.alliance != null)
            {
                _local_3 = (_local_3 + (" <b>of</b> " + _arg_2.alliance));
            };
            if (_arg_2.startPosName != null)
            {
                _local_3 = (_local_3 + (" <b>from</b> " + _arg_2.startPosName));
            };
            if (_arg_2.startFieldId != -1)
            {
                _local_3 = (_local_3 + (((("(" + Map.getX(_arg_2.startFieldId)) + ",") + Map.getY(_arg_2.startFieldId)) + ")"));
            };
            if (_arg_2.hero != null)
            {
                _local_3 = (_local_3 + (" <b>using hero</b> " + _arg_2.hero));
            };
            if (_arg_2.heroLevel > 0)
            {
                _local_3 = (_local_3 + (("(" + _arg_2.heroLevel) + ")"));
            };
            if (_arg_2.troop != null)
            {
                _local_3 = (_local_3 + (" <b>with troops</b> " + Utils.troopStrBeanToMsgString(_arg_2.troop, true)));
            };
            if (_arg_2.reachTime > 0)
            {
                _local_3 = (_local_3 + (((" <b>arriving in</b> " + Utils.formatEndTime(_arg_2.reachTime)) + " <b>@</b> ") + Utils.getServerEndTimeStr(_arg_2.reachTime)));
            };
            return (_local_3);
        }

        private function evtTroopUpdate(_arg_1:TroopUpdate):void
        {
            var _local_2:CityState = getCityFromCastleId(_arg_1.caslteId);
            if (_local_2 != null)
            {
                _local_2.castle.troop = _arg_1.troop;
                _local_2.cityManager.troopProductionUpdateNeeded = true;
            };
        }

        private function attemptSkypeLogin():void
        {
            if (((this.config.skypeUn.length > 0) && (this.config.skypePw.length > 0)))
            {
                Utils.callLater(1000, Skype.login, [this.config.skypeUn, this.config.skypePw, this.onSkypeLoginResponse]);
            };
        }

        private function evtPlayerInfoUpdate(_arg_1:PlayerInfoUpdate):void
        {
            this.updateMiscInfo(_arg_1.playerInfo);
            this.currentPlayer.playerInfo = _arg_1.playerInfo;
            _arg_1 = null;
        }

        private function processEnemySkypeWarning(_arg_1:TimerEvent=null):void
        {
            var _local_13:CityState;
            this.skypeWarningTimer.reset();
            if ((((getMainTownCityState() == null) || (this.currentPlayer == null)) || (this.currentPlayer.enemyArmysArray.length == 0)))
            {
                return;
            };
            var _local_2:CityManager = getMainTownCityState().cityManager;
            var _local_3:int = Math.max(_local_2.getCfg(CityConfigs.CFG_SKYPEWARNING), 30);
            var _local_4:Array = _local_2._getSkypeWarningReceivers();
            var _local_5:String;
            var _local_6:Array = _local_2._getSkypeWarningPolicy();
            var _local_7:Object = new Object();
            var _local_8:Array = new Array();
            var _local_9:int;
            var _local_10:Number = new Date().getTime();
            var _local_11:ArmyBean;
            var _local_12:String;
            for each (_local_13 in getCities())
            {
                for each (_local_11 in _local_13.cityManager.enemyArmies)
                {
                    _local_12 = "NEW ATTACK";
                    if (this.skypeLastSendTimes[String(_local_11.armyId)] != undefined)
                    {
                        if ((_local_10 - this.skypeLastSendTimes[String(_local_11.armyId)]) < (_local_3 * 1000))
                        {
                            _local_7[String(_local_11.armyId)] = this.skypeLastSendTimes[String(_local_11.armyId)];
                            continue;
                        };
                        _local_12 = "ATTACK UPDATE";
                    };
                    if (!_local_13.cityManager.isJunkTroop(_local_11.troop))
                    {
                        if (_local_6[0])
                        {
                            _local_8.push(this.armyToMsgString(_local_12, _local_11));
                            _local_7[String(_local_11.armyId)] = _local_10;
                        };
                    }
                    else
                    {
                        if (_local_6[1])
                        {
                            _local_8.push(this.armyToMsgString(_local_12, _local_11));
                            _local_7[String(_local_11.armyId)] = _local_10;
                        };
                    };
                    if (_local_8.length >= 10)
                    {
                        this.sendSkypeWarnings(_local_4, _local_8.join("\n"));
                        _local_8 = new Array();
                    };
                };
                for each (_local_11 in _local_13.cityManager.enemyValleyArmies)
                {
                    _local_12 = "NEW VALLEY ATTACK";
                    if (this.skypeLastSendTimes[String(_local_11.armyId)] != undefined)
                    {
                        if ((_local_10 - this.skypeLastSendTimes[String(_local_11.armyId)]) < (_local_3 * 1000))
                        {
                            _local_7[String(_local_11.armyId)] = this.skypeLastSendTimes[String(_local_11.armyId)];
                            continue;
                        };
                        _local_12 = "VALLEY ATTACK UPDATE";
                    };
                    if (_local_6[2])
                    {
                        _local_8.push(this.armyToMsgString(_local_12, _local_11));
                        _local_7[String(_local_11.armyId)] = _local_10;
                    };
                    if (_local_8.length >= 10)
                    {
                        this.sendSkypeWarnings(_local_4, _local_8.join("\n"));
                        _local_8 = new Array();
                    };
                };
                for each (_local_11 in _local_13.cityManager.enemyColonyArmies)
                {
                    _local_12 = "NEW COLONY ATTACK";
                    if (this.skypeLastSendTimes[String(_local_11.armyId)] != undefined)
                    {
                        if ((_local_10 - this.skypeLastSendTimes[String(_local_11.armyId)]) < (_local_3 * 1000))
                        {
                            _local_7[String(_local_11.armyId)] = this.skypeLastSendTimes[String(_local_11.armyId)];
                            continue;
                        };
                        _local_12 = "COLONY ATTACK UPDATE";
                    };
                    if (_local_6[3])
                    {
                        _local_8.push(this.armyToMsgString(_local_12, _local_11));
                        _local_7[String(_local_11.armyId)] = _local_10;
                    };
                    if (_local_8.length >= 10)
                    {
                        this.sendSkypeWarnings(_local_4, _local_8.join("\n"));
                        _local_8 = new Array();
                    };
                };
            };
            if (_local_8.length > 0)
            {
                this.sendSkypeWarnings(_local_4, _local_8.join("\n"));
            };
            this.skypeLastSendTimes = _local_7;
            this.skypeWarningTimer.start();
        }

        public function __logoutButton_click(_arg_1:MouseEvent):void
        {
            this.logoutNow();
        }

        public function cityLogMsg(_arg_1:ScriptLogEvent):void
        {
            this.showNewMsg("logs", _arg_1.logText);
            this.showNewCityMsg(_arg_1.logText, ((_arg_1.logCity != null) ? cities.indexOf(_arg_1.logCity) : 0));
        }

        public function refresh():void
        {
            var conn:Connection;
            var isPaused:Boolean;
            conn = Connection.getInstance();
            isPaused = conn.paused;
            if (!isPaused)
            {
                conn.paused = true;
            };
            conn.disconnect();
            var handler:Function = function ():void
            {
                conn.connect();
                conn.paused = isPaused;
            };
            Utils.callLater(1500, handler);
        }

        private function logoutNow():void
        {
            var _local_1:Connection = Connection.getInstance();
            if ((((!(_local_1.reconnectTimer.running)) && (!(_local_1.authenticated))) && (_local_1.paused)))
            {
                return;
            };
            this.disableLogoutButton();
            _local_1.reconnectTimer.stop();
            _local_1.disconnect();
            getMainTownCityState().cityManager.logMsg("   <b>*** LOGOUT > Disconnected ***</b>", "#AA0000");
            _local_1.paused = true;
        }

        internal function getCityPanelBean(_arg_1:int):CityPanelBean
        {
            var _local_2:CityPanelBean;
            for each (_local_2 in this._cityPanelBeansArray.getChildren())
            {
                if (_local_2.castleId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        [Bindable(event="propertyChange")]
        public function get pauseButton():Button
        {
            return (this._2003593416pauseButton);
        }

        private function onLogTabClick(_arg_1:TabBar, _arg_2:Object):void
        {
            var _local_3:Tab;
            for each (_local_3 in _arg_1.getChildren())
            {
                if (_local_3 == _arg_2)
                {
                    _local_3.setStyle("fontStyle", "normal");
                    _local_3.setStyle("fontWeight", "bold");
                }
                else
                {
                    _local_3.setStyle("fontWeight", "normal");
                };
            };
            if (((_arg_1 == this._logTab) && (_arg_1.selectedIndex < 3)))
            {
                this.setScrollPos(this.logs);
            }
            else
            {
                if (((_arg_1 == this._logTab) && (_arg_1.selectedIndex == 3)))
                {
                    this._mapCanvas._centerMapOn(this.currentPlayer.castlesArray[this._citiesTab.selectedIndex].fieldId, true);
                };
            };
        }

        public function getDistanceFromClosestCastle(_arg_1:int):Number
        {
            var _local_4:CastleBean;
            var _local_2:Number = NaN;
            var _local_3:Number = 10000;
            for each (_local_4 in this.currentPlayer.castlesArray)
            {
                _local_2 = Map.fieldDistance(_arg_1, _local_4.fieldId);
                if ((_local_2 < _local_3))
                {
                    _local_3 = _local_2;
                };
            };
            return (_local_3);
        }

        private function onCityTabClick(_arg_1:ItemClickEvent):void
        {
            if (this._logTab.selectedIndex == 1)
            {
                this.setScrollPos(this.logs);
            };
            this._mapCanvas._centerMapOn(this.currentPlayer.castlesArray[_arg_1.index].fieldId);
        }

        private function handleCastleFieldUpdate(_arg_1:CastleFieldUpdate):void
        {
            var _local_2:CastleBean;
            var _local_3:int;
            var _local_4:CityManager;
            var _local_5:int;
            if (((this.currentPlayer == null) || (this.currentPlayer.castlesArray == null)))
            {
                Utils.callLater(50, this.handleCastleFieldUpdate, [_arg_1]);
            }
            else
            {
                _local_2 = getCastle(_arg_1.castleId);
                if (_local_2 != null)
                {
                    _local_3 = 0;
                    _local_4 = getCityFromCastleId(_arg_1.castleId).cityManager;
                    _local_5 = _local_4.getCfg(CityConfigs.CFG_DEBUG);
                    if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
                    {
                        if (_local_5 > 0)
                        {
                            _local_4.logMsg(((("DEBUG(" + _local_5) + ") > Troop change on field ") + Map.fieldIdToString(_arg_1.bean.id)), CityManager.COLR_DBG_LOG_MSG);
                        };
                        _local_3 = 0;
                        while (_local_3 < _local_2.fieldsArray.length)
                        {
                            if (_local_2.fieldsArray[_local_3].id == _arg_1.bean.id)
                            {
                                _local_2.fieldsArray[_local_3] = _arg_1.bean;
                            };
                            return;
                        };
                    }
                    else
                    {
                        if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                        {
                            _local_4.logMsg(("Take field " + Map.fieldIdToString(_arg_1.bean.id)), CityManager.COLR_STD_LOG_MSG);
                            Map.updateDetailInfo(_arg_1.bean.id);
                            if (!_local_4.isValley(_arg_1.bean.id))
                            {
                                _local_2.fieldsArray.addItem(_arg_1.bean);
                                Utils.sortFieldsByDistance(_local_2);
                            };
                            _local_4._onFieldUpdate_handleAtkEnemyFieldAndHunting(_arg_1.bean.id);
                        }
                        else
                        {
                            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                            {
                                if (_local_5 > 0)
                                {
                                    _local_4.logMsg(((("DEBUG(" + _local_5) + ") > Give up field ") + Map.fieldIdToString(_arg_1.bean.id)), CityManager.COLR_DBG_LOG_MSG);
                                };
                                _local_3 = 0;
                                while (_local_3 < _local_2.fieldsArray.length)
                                {
                                    if (_local_2.fieldsArray[_local_3].id == _arg_1.bean.id)
                                    {
                                        _local_2.fieldsArray.removeItemAt(_local_3);
                                        Map.updateDetailInfo(_arg_1.bean.id);
                                        return;
                                    };
                                    _local_3++;
                                };
                            }
                            else
                            {
                                _local_4.logMsg((((((("ignore castle field update " + _arg_1.updateType) + " on field (") + Map.getX(_arg_1.bean.id)) + ",") + Map.getY(_arg_1.bean.id)) + ")"), CityManager.COLR_STD_LOG_MSG);
                            };
                        };
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _logStack():ViewStack
        {
            return (this._2093140739_logStack);
        }

        private function updateSelfArmies(_arg_1:ArrayCollection):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            this.currentPlayer.selfArmysArray = _arg_1;
            CityManager._updateOwnArmiesSeen(this.currentPlayer.selfArmysArray);
            this.updateLocalArmies();
        }

        private function evtSelfArmiesUpdate(_arg_1:SelfArmysUpdate):void
        {
            if (((this.currentPlayer == null) || (this.currentPlayer.selfArmysArray == null)))
            {
                Utils.callLater(50, this.evtSelfArmiesUpdate, [_arg_1]);
            }
            else
            {
                this.updateSelfArmies(_arg_1.armysArray);
            };
        }

        public function doCityTabLabel(_arg_1:int):void
        {
            this.doCityTabLabels(_arg_1);
        }

        public function getSelectedCityIndex():int
        {
            return (this._citiesTab.selectedIndex);
        }

        public function init():void
        {
            instance = this;
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, this.evtLogin);
            _local_1.addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.evtSelfArmiesUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, this.evtFriendArmiesUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, this.evtEnemyArmiesUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, this.evtTroopUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, this.onHeroUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, this.onResourceUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, this.handleCastleFieldUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CONNECTION_LOST, this.evtConnectionLost);
            _local_1.addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, this.evtCastleUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_COLONY_UPDATE, this.evtColonyUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, this.evtPlayerInfoUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_NEW_REPORT, this.evtNewReport);
            _local_1.addEventListener(ResponseDispatcher.SERVER_NEW_MAIL, this.evtNewMail);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.evtItemUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_PLAYER_BUFF_UPDATE, this.evtPlayerBuffUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_UPDATE, this.evtDeclaredWarsUpdate);
            this.loadCustomAudio();
            if (this.pausedLabelTimer == null)
            {
                this.pausedLabelTimer = new Timer(3000);
                this.pausedLabelTimer.addEventListener(TimerEvent.TIMER, this.modifyCtrlBtns);
            };
            if (((!(this.pausedLabelTimer == null)) && (!(this.pausedLabelTimer.running))))
            {
                this.pausedLabelTimer.start();
            };
            if (this.displayServerClockTimer == null)
            {
                this.displayServerClockTimer = new Timer(4995);
                this.displayServerClockTimer.addEventListener(TimerEvent.TIMER, this.topClockAndGiftUpdate);
            };
            if (this.checkForUpdatedVersionTimer == null)
            {
                this.checkForUpdatedVersionTimer = new Timer(3600000);
                this.checkForUpdatedVersionTimer.addEventListener(TimerEvent.TIMER, this.checkForUpdatedVersion);
            };
            if (((!(this.checkForUpdatedVersionTimer == null)) && (!(this.checkForUpdatedVersionTimer.running))))
            {
                this.checkForUpdatedVersionTimer.start();
            };
            if (this.skypeWarningTimer == null)
            {
                this.skypeWarningTimer = new Timer(30000);
                this.skypeWarningTimer.addEventListener(TimerEvent.TIMER, this.processEnemySkypeWarning);
            };
            Utils.callLater(50, Connection.getInstance().init);
            this.addEventListener(CityPanel.SAVEALLEVENT, this._cityPanel.onSaveAll);
            this.addEventListener(CityPanel.SETALLGOALS, this.onSetAllGoals);
            this.addEventListener(Snippets.SAVEALLEVENT, this._snippets.saveAll);
        }

        public function getSelectedCity():CityState
        {
            return (cities[this._citiesTab.selectedIndex] as CityState);
        }

        private function showNewMsg(_arg_1:String, _arg_2:String, _arg_3:String="#000000", _arg_4:Boolean=false, _arg_5:String=""):void
        {
            var _local_7:int;
            this.cache[_arg_1] = (this.cache[_arg_1] + (((((((("<font color='" + ((_arg_3 != "#000000") ? _arg_3 : "#006666")) + "'>") + ((_arg_4) ? (((_arg_5 + "&lt;") + Utils.getChatTimeStr(Utils.getServerTime())) + "&gt;</font>") : (Utils.getLogTimeStr(Utils.getServerTime(), (_arg_1 == "warLogs")) + "</font> "))) + "<font color='") + _arg_3) + "'>") + _arg_2.replace(/\r\n?|\n|<br>/gi, "\n")) + "</font>\n"));
            var _local_6:int = this.cache[_arg_1].length;
            if ((((_arg_1 == "logs") && (_local_6 > 128000)) || ((_arg_1 == "warLogs") && (_local_6 > 96000))))
            {
                this.cache[_arg_1] = this.cache[_arg_1].substr(this.cache[_arg_1].indexOf("\n", 8000));
            };
            if ((((_arg_1 == "logs") && (!(this._logTab.selectedIndex == 0))) && ((lastActive + ((5 * 60) * 1000)) < new Date().getTime())))
            {
                this._logTab.selectedIndex = 0;
                Utils.callLater(50, this.onLogTabClick, [this._logTab, this._logTab.getChildAt(0)]);
            }
            else
            {
                if (((((_local_7 = this._logTab.selectedIndex) == 0) && (_arg_1 == "logs")) || ((_local_7 == 2) && (_arg_1 == "warLogs"))))
                {
                    this.setScrollPos(this.logs);
                };
            };
        }

        private function set cache(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._94416770cache;
            if (_local_2 !== _arg_1)
            {
                this._94416770cache = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cache", _local_2, _arg_1));
            };
        }

        public function uninit():void
        {
            instance = null;
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE, this.evtLogin);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.evtSelfArmiesUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, this.evtFriendArmiesUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, this.evtEnemyArmiesUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE, this.evtTroopUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, this.onHeroUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, this.onResourceUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE, this.handleCastleFieldUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_CONNECTION_LOST, this.evtConnectionLost);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE, this.evtCastleUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_COLONY_UPDATE, this.evtColonyUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE, this.evtPlayerInfoUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_NEW_REPORT, this.evtNewReport);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_NEW_MAIL, this.evtNewMail);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.evtItemUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_PLAYER_BUFF_UPDATE, this.evtPlayerBuffUpdate);
            _local_1.removeEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_UPDATE, this.evtDeclaredWarsUpdate);
            if (this.unpauseTimer != null)
            {
                this.unpauseTimer.stop();
                this.unpauseTimer.removeEventListener(TimerEvent.TIMER, this.onUnpauseTimer);
                this.unpauseTimer = null;
            };
            this.pausedLabelTimer.stop();
            this.pausedLabelTimer.removeEventListener(TimerEvent.TIMER, this.modifyCtrlBtns);
            this.pausedLabelTimer = null;
            if (this.skypeWarningTimer != null)
            {
                this.skypeWarningTimer.stop();
                this.skypeWarningTimer.removeEventListener(TimerEvent.TIMER, this.processEnemySkypeWarning);
            };
            this.displayServerClockTimer.stop();
            this.displayServerClockTimer.removeEventListener(TimerEvent.TIMER, this.topClockAndGiftUpdate);
            this.displayServerClockTimer = null;
            this.checkForUpdatedVersionTimer.stop();
            this.checkForUpdatedVersionTimer.removeEventListener(TimerEvent.TIMER, this.checkForUpdatedVersion);
            this.checkForUpdatedVersionTimer = null;
            this.removeEventListener(CityPanel.SAVEALLEVENT, this._cityPanel.onSaveAll);
            this.removeEventListener(CityPanel.SETALLGOALS, this.onSetAllGoals);
            this.removeEventListener(Snippets.SAVEALLEVENT, this._snippets.saveAll);
        }

        private function setLastActiveTime():void
        {
            var _local_1:Date = new Date();
            lastActive = _local_1.getTime();
        }

        private function showNewCityMsg(_arg_1:String, _arg_2:int, _arg_3:String="#000000"):void
        {
            (this.cache.cityLogs as ArrayList).setItemAt((((((((((this.cache.cityLogs.getItemAt(_arg_2) + "<font color='") + ((_arg_3 != "#444444") ? _arg_3 : "#339999")) + "'>") + Utils.getLogTimeStr(Utils.getServerTime())) + "</font> <font color='") + _arg_3) + "'>") + _arg_1.replace(/\r\n?|\n|<br>/gi, "\n")) + "</font>\n"), _arg_2);
            if ((this.cache.cityLogs as ArrayList).getItemAt(_arg_2).length > 30000)
            {
                (this.cache.cityLogs as ArrayList).setItemAt((this.cache.cityLogs as ArrayList).getItemAt(_arg_2).substr((this.cache.cityLogs as ArrayList).getItemAt(_arg_2).indexOf("\n", 4000)), _arg_2);
            };
            this.cache.emptyStr = " ";
            this.cache.emptyStr = "";
            if (((this._logTab.selectedIndex == 1) && (this._citiesTab.selectedIndex == _arg_2)))
            {
                this.setScrollPos(this.logs);
            };
        }

        private function cityIsSuzerain(_arg_1:CastleBean):Boolean
        {
            var _local_2:ColonyBean;
            for each (_local_2 in _arg_1.colonyBeansArray)
            {
                if (((!(_local_2.status == ColonyConstants.COLONY_STATUS_FREE)) && (_local_2.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)))
                {
                    return (false);
                };
            };
            return (true);
        }

        private function isAnyEnemyArmyNotJunk(_arg_1:ArrayCollection):Boolean
        {
            var _local_2:ArmyBean;
            for each (_local_2 in _arg_1)
            {
                if (!getCityFromFieldId(_local_2.targetFieldId).cityManager.isJunkTroop(_local_2.troop))
                {
                    return (true);
                };
            };
            return (false);
        }

        private function newKeyDownEvent(_arg_1:KeyboardEvent):void
        {
            this.setLastActiveTime();
        }

        [Bindable(event="propertyChange")]
        public function get _MainScreen_VersionLabelBottom():Label
        {
            return (this._861376190_MainScreen_VersionLabelBottom);
        }

        private function initCityScript(_arg_1:CityState):void
        {
            _arg_1._getScript().addEventListener(ScriptLogEvent.TYPE, this.cityLogMsg);
            _arg_1.cityManager.addEventListener(ScriptLogEvent.TYPE, this.cityLogMsg);
            _arg_1.cityManager.addEventListener(WarLogEvent.TYPE, this.warLogMsg);
            _arg_1._getScript().addEventListener(StopScriptEvent.STOP_SCRIPT, this.onStopScriptEvent);
        }

        public function ___clearLogBtn_click(_arg_1:MouseEvent):void
        {
            this.clear(true, ["logs", "cityLogs", "warLogs"][this._logTab.selectedIndex], true);
        }

        private function onStopScriptEvent(_arg_1:StopScriptEvent):void
        {
            var _local_2:CityPanelBean;
            for each (_local_2 in this._cityPanelBeansArray.getChildren())
            {
                if (_local_2.castleId == _arg_1.castleId)
                {
                    _local_2.scriptIsRunning = false;
                    break;
                };
            };
        }

        private function processEnemyEmailWarning(_arg_1:ArrayCollection, _arg_2:int):void
        {
        }

        public function ___MainScreen_Image1_click(_arg_1:MouseEvent):void
        {
            navigateToURL(new URLRequest("http://roboev.webstarts.com"), "_blank");
        }

        [Bindable(event="propertyChange")]
        public function get logoutButton():Button
        {
            return (this._1255627100logoutButton);
        }

        public function evtLogin(_arg_1:LoginResponse):void
        {
            if (_arg_1.ok != 1)
            {
                if (Version.isTraceOn())
                {
                    trace(_arg_1.errorMsg);
                };
                return;
            };
            this.currentPlayer = _arg_1.player;
            Utils.setServerTime(this.currentPlayer.currentTime);
            Utils.setServerTimeZoneAdjust(this.currentPlayer.currentTime, this.currentPlayer.currentDateTime);
            var _local_2:Date = new Date();
            _local_2.setTime(Utils.getServerTime());
            Utils.setEstimatedServerTime(_local_2.getTime());
            Utils.callLater(100, this.initReqs, [this.currentPlayer.castlesArray[0].id]);
            this.showNewMsg("logs", (("<b>Logged in successfully, server time difference: " + (Utils.getServerLagTime() / 1000)) + "s</b>"));
            if (Math.abs(Utils.getServerLagTime()) > 5000)
            {
                this.showNewMsg("logs", (("<b>Your current computer time: " + Utils.getLogTimeStr(new Date().getTime())) + "</b>"));
                this.showNewMsg("logs", "<b>PLEASE AVOID ADJUSTING YOUR COMPUTER CLOCK WHILE THE BOT IS RUNNING! If you do adjust, be sure to click Refresh.</b>");
            };
            Map.initMap(this.currentPlayer.mapSizeX, this.currentPlayer.mapSizeY);
            this.topClockAndGiftUpdate();
            this.initCities();
            this.updateSelfArmies(_arg_1.player.selfArmysArray);
            this.updateFriendlyArmies(_arg_1.player.friendArmysArray);
            if (this._citiesTab.dataProvider == null)
            {
                this._citiesTab.dataProvider = this._cityPanelBeansArray;
                this._cityPanel.cityPanelBean = (this._cityPanelBeansArray.getChildAt(0) as CityPanelBean);
                this._cityPanel.castleBean = (this.currentPlayer.castlesArray.getItemAt(0) as CastleBean);
            };
            if (this.currentPlayer.isSetSecurityCode)
            {
                Utils.callLater(200, this.handleSecCode);
            };
            this.attemptSkypeLogin();
            this.updateMiscInfo(this.currentPlayer.playerInfo);
            this.topInfo.server = (((this.config.strserverAlias + " (") + this.config.server) + ")");
            this.setWindowTitle((((this.currentPlayer.playerInfo.userName + "(") + this.config.server) + ") RE for Age II"));
            if (((!(this.displayServerClockTimer == null)) && (!(this.displayServerClockTimer.running))))
            {
                this.displayServerClockTimer.start();
            };
            Utils.callLater(3000, this.checkForUpdatedVersion);
            this.updateEnemyArmies(_arg_1.player.enemyArmysArray);
        }

        private function onUnlockSecOption(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                this.showNewMsg("logs", ("WARNING: Error received while temporarily unlocking security code options:  " + _arg_1.errorMsg), "#CC0000");
            }
            else
            {
                this.showNewMsg("logs", "SUCCESS: Security code accepted and temporarily unlocked. Normal operation can now continue.", "#00006A");
            };
        }

        public function set logs(_arg_1:TextArea):void
        {
            var _local_2:Object = this._3327407logs;
            if (_local_2 !== _arg_1)
            {
                this._3327407logs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logs", _local_2, _arg_1));
            };
        }

        public function set topInfo(_arg_1:TopInfo):void
        {
            var _local_2:Object = this._1140201565topInfo;
            if (_local_2 !== _arg_1)
            {
                this._1140201565topInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "topInfo", _local_2, _arg_1));
            };
        }

        private function evtCastleUpdate(_arg_1:CastleUpdate):void
        {
            var _local_5:Boolean;
            var _local_6:int;
            var _local_7:CityPanelBean;
            var _local_2:CityState;
            var _local_3:HeroBean;
            var _local_4:int;
            if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
            {
                _local_4 = 0;
                while (_local_4 < this.currentPlayer.castlesArray.length)
                {
                    if (this.currentPlayer.castlesArray[_local_4].id == _arg_1.castleBean.id)
                    {
                        _arg_1.castleBean.copyTo((this.currentPlayer.castlesArray[_local_4] as CastleBean));
                        for each (_local_3 in this.currentPlayer.castlesArray[_local_4].herosArray)
                        {
                            Utils.formatHeroName(_local_3);
                        };
                        Utils.sortFieldsByDistance(this.currentPlayer.castlesArray[_local_4]);
                        getCityFromCastleId(_arg_1.castleBean.id)._setCastleBean();
                        break;
                    };
                    _local_4++;
                };
                Utils.callLater(50, this.doCityTabLabels, [int(_arg_1.castleBean.id)]);
                Utils.callLater(50, this.doCityTabColors, [int(_arg_1.castleBean.id)]);
            }
            else
            {
                if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_ADD)
                {
                    if ((((((((((((buildNpcEnabled) && (!(_arg_1.castleBean.fieldId == CityManager.getBuildCityLocation()))) && (_arg_1.castleBean.buildingsArray.length <= 1)) && ((_arg_1.castleBean.buildingsArray.length == 0) || ((_arg_1.castleBean.buildingsArray[0].name == "Town Hall") && (_arg_1.castleBean.buildingsArray[0].level <= 1)))) && (_arg_1.castleBean.name == "Flat")) && (_arg_1.castleBean.herosArray.length == 0)) && (_arg_1.castleBean.resource.gold <= 5000)) && (_arg_1.castleBean.resource.food.amount <= 5000)) && (_arg_1.castleBean.resource.wood.amount <= 5000)) && (_arg_1.castleBean.resource.stone.amount <= 5000)) && (_arg_1.castleBean.resource.iron.amount <= 5000)))
                    {
                        return;
                    };
                    _local_5 = false;
                    _local_4 = 0;
                    while (_local_4 < this.currentPlayer.castlesArray.length)
                    {
                        if (this.currentPlayer.castlesArray[_local_4].id == _arg_1.castleBean.id)
                        {
                            _local_5 = true;
                            break;
                        };
                        _local_4++;
                    };
                    if (!_local_5)
                    {
                        this.currentPlayer.castlesArray.addItem(_arg_1.castleBean);
                        _local_2 = new CityState(int(_arg_1.castleBean.id));
                        cities.push(_local_2);
                        _local_6 = 0;
                        if (_local_2.castle.colonyBeansArray.length > 0)
                        {
                            if (this.cityIsSuzerain(_local_2.castle))
                            {
                                _local_6 = CityPanelBean.ICON_TYPE_SUZ;
                            }
                            else
                            {
                                _local_6 = CityPanelBean.ICON_TYPE_COL;
                            };
                        }
                        else
                        {
                            _local_6 = CityPanelBean.ICON_TYPE_NONE;
                        };
                        _local_7 = new CityPanelBean(int(_arg_1.castleBean.id), (((_arg_1.castleBean.name.length < 4) ? _arg_1.castleBean.name : _arg_1.castleBean.name.substring(0, 3)) + Map.fieldIdToCoordString(_arg_1.castleBean.fieldId)), _local_6);
                        this._cityPanelBeansArray.addChild(_local_7);
                        this.initCityScript(_local_2);
                        _local_7.onLoadGoals();
                        _local_7.onLoadScript(null, 5000);
                        Utils.callLater(50, this.doCityTabLabels, [int(_arg_1.castleBean.id)]);
                        Utils.callLater(50, this.doCityTabColors, [int(_arg_1.castleBean.id)]);
                    };
                }
                else
                {
                    if (_arg_1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
                    {
                        for each (_local_2 in cities)
                        {
                            if (_local_2.castleId == _arg_1.castleBean.id)
                            {
                                this.logMsg(((("  ***LOST CASTLE  " + _local_2.castle.name) + "  @  ") + Map.fieldIdToCoordString(_local_2.castle.fieldId)), "#BB0000");
                                _local_2.cityManager.onCityIsLost();
                                this.destroyCityObject(_local_2);
                            };
                        };
                    };
                };
            };
        }

        private function doCityTabColors(castleId:int=-1):void
        {
            var foundRoyal:Boolean;
            var deffillColors:Array;
            var defBgColor:int;
            var colonyEventColors:Array;
            var colonyEventBgColor:int;
            var royalPresentColors:Array;
            var royalPresentBgColor:int;
            var underAttackColors:Array;
            var underAttackBgColor:int;
            var colonyUnderAttackColors:Array;
            var colonyUnderAttackBgColor:int;
            var arrCol:Array;
            var bgCol:int;
            var tTip:String;
            var varStatusStr:String;
            var city:CityState;
            var cb:ColonyBean;
            var isAttack:Boolean;
            var cnt:int;
            var a:ArmyBean;
            var tab:Tab;
            var doOneTab:Boolean;
            var len:int;
            var i:int;
            var h:HeroBean;
            try
            {
                foundRoyal = false;
                deffillColors = ThemeManager.getStyle(".REtabBarCitiesTab", "fillColors");
                defBgColor = ThemeManager.getStyle(".REtabBarCitiesTab", "backgroundColor");
                colonyEventColors = new Array(16759162, 16745749, 16761732, 16748319);
                colonyEventBgColor = 16745749;
                royalPresentColors = new Array(6075757, 3966026, 6733687, 4623956);
                royalPresentBgColor = 3966026;
                underAttackColors = new Array(16736866, 0xCC0000, 16739436, 14027274);
                underAttackBgColor = 0xCC0000;
                colonyUnderAttackColors = new Array(16075081, 11012618, 16733011, 11670548);
                colonyUnderAttackBgColor = 11012618;
                arrCol = new Array();
                tTip = "";
                varStatusStr = null;
                city = null;
                cb = null;
                isAttack = false;
                cnt = 0;
                a = null;
                doOneTab = (castleId > -1);
                len = this._citiesTab.getChildren().length;
                i = 0;
                while (i < len)
                {
                    city = (cities[i] as CityState);
                    if (!((doOneTab) && (!(castleId == city.castleId))))
                    {
                        tTip = "";
                        arrCol = deffillColors;
                        bgCol = defBgColor;
                        tab = (this._citiesTab.getChildAt(i) as Tab);
                        if (!foundRoyal)
                        {
                            for each (h in city.cityManager.heroes)
                            {
                                if (h.isHero == 2)
                                {
                                    tTip = (tTip + (((h.name + " ") + h.stamina) + "\n"));
                                    arrCol = royalPresentColors;
                                    bgCol = royalPresentBgColor;
                                    foundRoyal = true;
                                    break;
                                };
                            };
                        };
                        for each (cb in city.cityManager.colonies)
                        {
                            varStatusStr = "";
                            if (cb.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                            {
                                varStatusStr = ((cb.status == ColonyConstants.COLONY_STATUS_ATTACKING) ? "is Colonizing" : ((cb.status == ColonyConstants.COLONY_STATUS_UPRISING) ? ", You are uprising" : ""));
                                tTip = (tTip + (((((((("Suzerain Info\n\nLord Name: " + cb.lordName) + "\nLocation: ") + cb.position) + "\nAlliance: ") + cb.allianceName) + "\n") + varStatusStr) + "\n"));
                                if (((cb.status == ColonyConstants.COLONY_STATUS_ATTACKING) || (cb.status == ColonyConstants.COLONY_STATUS_UPRISING)))
                                {
                                    if (cb.endTime != 0)
                                    {
                                        tTip = (tTip + (((((("Your City @(" + cb.position) + ")\n  - In: ") + Utils.formatEndTime(cb.endTime)) + " @ ") + Utils.getLogTimeStr(cb.endTime)) + "\n"));
                                    };
                                    arrCol = colonyEventColors;
                                    bgCol = colonyEventBgColor;
                                };
                            }
                            else
                            {
                                varStatusStr = ((cb.status == ColonyConstants.COLONY_STATUS_ATTACKING) ? "You are Colonizing" : ((cb.status == ColonyConstants.COLONY_STATUS_UPRISING) ? "They are uprising" : ""));
                                if (((cb.status == ColonyConstants.COLONY_STATUS_ATTACKING) || (cb.status == ColonyConstants.COLONY_STATUS_UPRISING)))
                                {
                                    if (cb.endTime != 0)
                                    {
                                        tTip = (tTip + (((((((((((varStatusStr + " ") + cb.lordName) + " (") + cb.allianceName) + ") @(") + cb.position) + ")\n  - In: ") + Utils.formatEndTime(cb.endTime)) + " @ ") + Utils.getLogTimeStr(cb.endTime)) + "\n"));
                                    };
                                    arrCol = colonyEventColors;
                                    bgCol = colonyEventBgColor;
                                };
                            };
                        };
                        cnt = 0;
                        isAttack = false;
                        if (((!(city.cityManager.enemyArmies == null)) && (city.cityManager.enemyArmies.length > 0)))
                        {
                            for each (a in city.cityManager.enemyArmies)
                            {
                                if (cnt++ >= 10) break;
                                if ((((a.reachTime > 0) && ((a.reachTime - Utils.getServerTime()) > ((10 * 60) * 1000))) && (city.cityManager.isJunkTroop(a.troop))))
                                {
                                    tTip = (tTip + (((((((("JunkWave Attack " + a.king) + " [") + ((a.alliance != null) ? a.alliance : "none")) + "] ") + Map.fieldIdToCoordString(a.startFieldId)) + "\n  Arrival Time: ") + ((a.reachTime > 0) ? (((((" in " + Utils.formatEndTime(a.reachTime)) + " @ ") + Utils.getLogTimeStr(a.reachTime)) + "\n troop: ") + Utils.troopStrBeanToMsgString(a.troop)) : (("UNKNOWN \n" + Utils.troopStrBeanToMsgString(a.troop)) + "\n---"))) + "\n"));
                                }
                                else
                                {
                                    tTip = (tTip + (((((((("Attack " + a.king) + " [") + ((a.alliance != null) ? a.alliance : "none")) + "] ") + Map.fieldIdToCoordString(a.startFieldId)) + "\n  Arrival Time: ") + ((a.reachTime > 0) ? (((((" in " + Utils.formatEndTime(a.reachTime)) + " @ ") + Utils.getLogTimeStr(a.reachTime)) + "\n troop: ") + Utils.troopStrBeanToMsgString(a.troop)) : (("UNKNOWN \n" + Utils.troopStrBeanToMsgString(a.troop)) + "\n---"))) + "\n"));
                                };
                                if (!isAttack)
                                {
                                    arrCol = underAttackColors;
                                    bgCol = underAttackBgColor;
                                    isAttack = true;
                                };
                            };
                        };
                        if (((!(city.cityManager.enemyColonyArmies == null)) && (city.cityManager.enemyColonyArmies.length > 0)))
                        {
                            for each (a in city.cityManager.enemyColonyArmies)
                            {
                                if (cnt++ >= 10) break;
                                tTip = (tTip + (((((((((((("Colony Attack " + a.king) + " [") + ((a.alliance != null) ? a.alliance : "none")) + "] ") + Map.fieldIdToCoordString(a.startFieldId)) + " => ") + Map.fieldIdToCoordString(a.targetFieldId)) + "\n") + ((a.reachTime > 0) ? (((("  Arrival Time: " + " in ") + Utils.formatEndTime(a.reachTime)) + " @ ") + Utils.getLogTimeStr(a.reachTime)) : "  Arrival Time: UNKNOWN ")) + "\n troop: ") + Utils.troopStrBeanToMsgString(a.troop)) + "\n"));
                                if (!isAttack)
                                {
                                    arrCol = colonyUnderAttackColors;
                                    bgCol = colonyUnderAttackBgColor;
                                    isAttack = true;
                                };
                            };
                        };
                        if (((!(city.cityManager.enemyValleyArmies == null)) && (city.cityManager.enemyValleyArmies.length > 0)))
                        {
                            for each (a in city.cityManager.enemyValleyArmies)
                            {
                                if (cnt++ >= 10) break;
                                tTip = (tTip + (((((((((((("Valley Attack " + a.king) + " [") + ((a.alliance != null) ? a.alliance : "none")) + "] ") + Map.fieldIdToCoordString(a.startFieldId)) + " => ") + Map.fieldIdToCoordString(a.targetFieldId)) + "\n") + ((a.reachTime > 0) ? (((("  Arrival Time: " + " in ") + Utils.formatEndTime(a.reachTime)) + " @ ") + Utils.getLogTimeStr(a.reachTime)) : "  Arrival Time: UNKNOWN ")) + "\n troop: ") + Utils.troopStrBeanToMsgString(a.troop)) + "\n"));
                                if (!isAttack)
                                {
                                    arrCol = colonyUnderAttackColors;
                                    bgCol = colonyUnderAttackBgColor;
                                    isAttack = true;
                                };
                            };
                        };
                        if (arrCol.length >= 1)
                        {
                            tab.setStyle("fillColors", arrCol);
                            tab.setStyle("backgroundColor", bgCol);
                        };
                        tab.toolTip = tTip;
                        if (doOneTab) break;
                    };
                    i = (i + 1);
                };
            }
            catch(err:Error)
            {
            };
        }

        public function __pauseButton_click(_arg_1:MouseEvent):void
        {
            this.doPauseResume();
        }

        public function getEnemyArmies():ArrayCollection
        {
            return (this.currentPlayer.enemyArmysArray);
        }

        [Bindable(event="propertyChange")]
        public function get _clearLogBtn():Button
        {
            return (this._1882046310_clearLogBtn);
        }

        public function resetSkypeWarningTimer(_arg_1:int):void
        {
            this.skypeWarningTimer.stop();
            this.skypeWarningTimer.delay = (_arg_1 * 1000);
            this.processEnemySkypeWarning();
        }

        public function set _accountInfo(_arg_1:AccountInfo):void
        {
            var _local_2:Object = this._243786428_accountInfo;
            if (_local_2 !== _arg_1)
            {
                this._243786428_accountInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_accountInfo", _local_2, _arg_1));
            };
        }

        public function ___MainScreen_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function set currentPlayer(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._2145417798currentPlayer;
            if (_local_2 !== _arg_1)
            {
                this._2145417798currentPlayer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentPlayer", _local_2, _arg_1));
            };
        }

        private function modifyCtrlBtns(_arg_1:TimerEvent=null):void
        {
            var _local_2:String = ((Connection.getInstance().paused) ? "Resume" : "Pause");
            if (this.pauseButton.label != _local_2)
            {
                this.pauseButton.label = _local_2;
                if (_local_2 == "Pause")
                {
                    this.pauseButton.setStyle("icon", PauseIcon);
                };
                if (_local_2 == "Resume")
                {
                    this.pauseButton.setStyle("icon", ResumeIcon);
                };
                if (_local_2 == "Pause")
                {
                    this.enableLogoutButton();
                };
            };
        }

        public function set _serverClockTimeField(_arg_1:Label):void
        {
            var _local_2:Object = this._773017919_serverClockTimeField;
            if (_local_2 !== _arg_1)
            {
                this._773017919_serverClockTimeField = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_serverClockTimeField", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MainScreen;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._MainScreen_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_MainScreenWatcherSetupUtil");
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
        private function get cache():ObjectProxy
        {
            return (this._94416770cache);
        }

        public function logMsg(_arg_1:String, _arg_2:String="#000000"):void
        {
            this.showNewMsg("logs", _arg_1, _arg_2);
        }

        public function set _cityPanelBeansArray(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1587488048_cityPanelBeansArray;
            if (_local_2 !== _arg_1)
            {
                this._1587488048_cityPanelBeansArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_cityPanelBeansArray", _local_2, _arg_1));
            };
        }

        private function updateMiscInfo(_arg_1:PlayerInfoBean):void
        {
            if (this.currentPlayer.playerInfo.userName != _arg_1.userName)
            {
                this.setWindowTitle((((_arg_1.userName + "(") + this.config.server) + ") RE for Age II"));
            };
            if (((this.currentPlayer.playerInfo.alliance == null) ? "" : this.currentPlayer.playerInfo.allianceLevel) != ((_arg_1.alliance == null) ? "" : _arg_1.allianceLevel))
            {
                if (_arg_1.alliance != null)
                {
                    if (this._accountInfo.allianceInfo.allianceDiplo != null)
                    {
                        this._accountInfo.allianceInfo.allianceDiplo.setMemberLevel(_arg_1.levelId);
                    };
                    if (this._accountInfo.allianceInfo.members != null)
                    {
                        this._accountInfo.allianceInfo.members.setMemberLevel(_arg_1.levelId);
                    };
                };
            };
        }

        public function ___logTab_itemClick(_arg_1:ItemClickEvent):void
        {
            this.onLogTabClick(this._logTab, _arg_1.relatedObject);
        }

        public function set pauseButton(_arg_1:Button):void
        {
            var _local_2:Object = this._2003593416pauseButton;
            if (_local_2 !== _arg_1)
            {
                this._2003593416pauseButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pauseButton", _local_2, _arg_1));
            };
        }

        private function evtEnemyArmiesUpdate(_arg_1:EnemyArmysUpdate):void
        {
            this.updateEnemyArmies(_arg_1.armysArray);
        }

        [Bindable(event="propertyChange")]
        public function get topInfo():TopInfo
        {
            return (this._1140201565topInfo);
        }

        public function set _logTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._1611115216_logTab;
            if (_local_2 !== _arg_1)
            {
                this._1611115216_logTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_logTab", _local_2, _arg_1));
            };
        }

        public function set _cityPanel(_arg_1:CityPanel):void
        {
            var _local_2:Object = this._1685431770_cityPanel;
            if (_local_2 !== _arg_1)
            {
                this._1685431770_cityPanel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_cityPanel", _local_2, _arg_1));
            };
        }

        private function updateLocalArmies():void
        {
            var _local_3:CityState;
            var _local_4:int;
            var _local_5:ArmyBean;
            var _local_1:Array = new Array();
            var _local_2:Array = new Array();
            for each (_local_3 in cities)
            {
                _local_1.push(_local_3.castle.fieldId);
                _local_2.push([]);
            };
            for each (_local_5 in this.currentPlayer.selfArmysArray)
            {
                if ((_local_4 = _local_1.indexOf(_local_5.startFieldId)) != -1)
                {
                    (_local_2[_local_4] as Array).push(_local_5);
                };
            };
            for each (_local_3 in cities)
            {
                _local_3.cityManager._updateLocalArmies((_local_2[_local_1.indexOf(_local_3.castle.fieldId)] as Array));
            };
        }

        [Bindable(event="propertyChange")]
        public function get logs():TextArea
        {
            return (this._3327407logs);
        }

        [Bindable(event="propertyChange")]
        private function get currentPlayer():PlayerBean
        {
            return (this._2145417798currentPlayer);
        }

        private function onSetAllGoals(_arg_1:Object=null):void
        {
            var _local_2:CastleBean;
            for each (_local_2 in this.currentPlayer.castlesArray)
            {
                this._cityPanel.onSetGoals(_local_2.id);
            };
        }

        public function get unpauseTimerIsRunning():Boolean
        {
            return ((!(this.unpauseTimer == null)) && (this.unpauseTimer.running));
        }

        private function onUnpauseTimer(_arg_1:TimerEvent):void
        {
            if (Connection.getInstance().paused)
            {
                this.doPauseResume();
            };
        }

        private function onSkypeLoginResponse(_arg_1:SkypeResponse):void
        {
            if (_arg_1.ok == 1)
            {
                this.showNewMsg("logs", _arg_1.msg);
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            };
        }

        private function processEnemyAudioWarning(_arg_1:ArrayCollection, _arg_2:Boolean):void
        {
            var _local_6:ArmyBean;
            var _local_3:Boolean;
            var _local_4:Array = new Array();
            var _local_5:CityState;
            for each (_local_6 in _arg_1)
            {
                if (!(((_local_4[_local_6.targetFieldId]) || ((_local_5 = getCityFromFieldId(_local_6.targetFieldId)) == null)) || (_local_5.cityManager.isJunkTroop(_local_6.troop))))
                {
                    _local_3 = true;
                    _local_4[_local_6.targetFieldId] = 1;
                };
            };
            if (_arg_2)
            {
                if (_local_3)
                {
                    if (_arg_1.length > 1)
                    {
                        this.attackSeveralSound.play();
                    }
                    else
                    {
                        this.attackSound.play();
                    };
                }
                else
                {
                    if (this.lastWarningStatus)
                    {
                        this.attackEndedSound.play();
                    };
                };
            };
            this.lastWarningStatus = _local_3;
            this.doCityTabColors();
        }

        [Bindable(event="propertyChange")]
        public function get _cityPanel():CityPanel
        {
            return (this._1685431770_cityPanel);
        }

        private function newMouseMoveEvent(_arg_1:MouseEvent):void
        {
            this.setLastActiveTime();
        }

        public function evtConnectionLost(_arg_1:ConnectionLost):void
        {
            var _local_2:Array = new Array("Kicked by server", "Server starting", "Server shutting down", "Another user has logged into your account", "Server down for maintanence", "Username not allowed", "Too many frequent login attempts", "Unknown reason for disconnect");
            this.showNewMsg("logs", (("<b>DISCONNECTED > " + _local_2[(((_arg_1.reasonCode < 0) || (_arg_1.reasonCode > 6)) ? 7 : _arg_1.reasonCode)]) + "</b>"));
            var _local_3:Number = ((getMainTownCityState() == null) ? 1 : getMainTownCityState().cityManager._getReloginWaitCfg());
            if (((_arg_1.reasonCode == ConnectionLost.KICK_BY_OTHER) && (!(Connection.getInstance().paused))))
            {
                this.scheduleUnpauseTimer(Utils.rand((((_local_3 - 2) * 60) * 1000), (((_local_3 + 2) * 60) * 1000)));
            }
            else
            {
                if (((_arg_1.reasonCode == ConnectionLost.LOGIN_FREQUENTLY) && (!(Connection.getInstance().paused))))
                {
                    this.scheduleUnpauseTimer(Utils.rand(((15 * 60) * 1000), ((17 * 60) * 1000)));
                }
                else
                {
                    if ((((!(_arg_1.reasonCode == ConnectionLost.KICK_BY_OTHER)) && (!(_arg_1.reasonCode == ConnectionLost.LOGIN_FREQUENTLY))) && (!(Connection.getInstance().paused))))
                    {
                        this.refresh();
                    };
                };
            };
        }

        private function evtColonyUpdate(_arg_1:ColonyUpdate):void
        {
            var _local_2:CastleBean;
            Utils.callLater(5000, this.processEnemyAudioWarning, [this.currentPlayer.enemyArmysArray, false]);
            for each (_local_2 in this.currentPlayer.castlesArray)
            {
                if (_local_2.id == _arg_1.castleId)
                {
                    _local_2.colonyBeansArray = _arg_1.colonyBeansArray;
                    break;
                };
            };
            this.doCityTabLabel(_arg_1.castleId);
            this.doCityTabColors(_arg_1.castleId);
        }

        public function set refreshButton(_arg_1:Button):void
        {
            var _local_2:Object = this._2033767917refreshButton;
            if (_local_2 !== _arg_1)
            {
                this._2033767917refreshButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "refreshButton", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get refreshButton():Button
        {
            return (this._2033767917refreshButton);
        }

        public function ___MainScreen_VBox1_mouseMove(_arg_1:MouseEvent):void
        {
            this.newMouseMoveEvent(_arg_1);
        }

        private function evtItemUpdate(_arg_1:ItemUpdate):void
        {
            var _local_4:ItemBean;
            var _local_5:int;
            var _local_2:int;
            var _local_3:Boolean;
            for each (_local_4 in _arg_1.itemsArray)
            {
                _local_2 = 0;
                _local_3 = false;
                _local_5 = 0;
                while (_local_5 < this.currentPlayer.itemsArray.length)
                {
                    if (this.currentPlayer.itemsArray[_local_5].id == _local_4.id)
                    {
                        _local_3 = true;
                        _local_2 = this.currentPlayer.itemsArray[_local_5].count;
                        if (_local_4.count > 0)
                        {
                            this.currentPlayer.itemsArray[_local_5] = _local_4;
                        }
                        else
                        {
                            this.currentPlayer.itemsArray.removeItemAt(_local_5);
                        };
                        break;
                    };
                    _local_5++;
                };
                if (!_local_3)
                {
                    this.currentPlayer.itemsArray.addItem(_local_4);
                };
                getMainTownCityState().cityManager.logMsg((((((("ITEM UPDATE >  " + (((_local_4.count - _local_2) > 0) ? "+" : "")) + (_local_4.count - _local_2)) + " ") + Items.getItemName(_local_4.id)) + ", new count ") + _local_4.count), "#00006A");
            };
        }


    }
}//package autoevony.gui

