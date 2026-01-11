package autoevony.gui
{
   import autoevony.common.Items;
   import autoevony.common.Utils;
   import autoevony.event.ScriptLogEvent;
   import autoevony.event.StopScriptEvent;
   import autoevony.event.WarLogEvent;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.themes.ThemeManager;
   import autoevony.management.CityConfigs;
   import autoevony.management.CityManager;
   import autoevony.net.Connection;
   import autoevony.player.LoginHelper;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.PlayerBean;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.constants.ColonyConstants;
   import com.evony.common.constants.CommonConstants;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.common.GetItemDefResponse;
   import com.evony.common.module.common.GetPackageNumberResponse;
   import com.evony.common.server.events.CastleFieldUpdate;
   import com.evony.common.server.events.CastleUpdate;
   import com.evony.common.server.events.ColonyUpdate;
   import com.evony.common.server.events.ConnectionLost;
   import com.evony.common.server.events.DeclaredWarUpdate;
   import com.evony.common.server.events.EnemyArmysUpdate;
   import com.evony.common.server.events.FriendArmysUpdate;
   import com.evony.common.server.events.HeroUpdate;
   import com.evony.common.server.events.ItemUpdate;
   import com.evony.common.server.events.LoginResponse;
   import com.evony.common.server.events.NewMail;
   import com.evony.common.server.events.NewReport;
   import com.evony.common.server.events.PlayerBuffUpdate;
   import com.evony.common.server.events.PlayerInfoUpdate;
   import com.evony.common.server.events.ResourceUpdate;
   import com.evony.common.server.events.SelfArmysUpdate;
   import com.evony.common.server.events.TroopUpdate;
   import com.skype.Skype;
   import com.skype.SkypeResponse;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.collections.ArrayCollection;
   import mx.collections.ArrayList;
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.HDividedBox;
   import mx.containers.VBox;
   import mx.containers.VDividedBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TabBar;
   import mx.controls.TextArea;
   import mx.controls.tabBarClasses.Tab;
   import mx.core.SoundAsset;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ItemClickEvent;
   import mx.events.PropertyChangeEvent;
   import mx.rpc.events.FaultEvent;
   import mx.rpc.events.ResultEvent;
   import mx.rpc.http.HTTPService;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class MainScreen extends Canvas implements IBindingClient
   {
      
      private static var lastEmailTime:Number;
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public static var lastActive:Number;
      
      private static const RefreshIcon:Class = MainScreen_RefreshIcon;
      
      private static const PauseIcon:Class = MainScreen_PauseIcon;
      
      private static const ResumeIcon:Class = MainScreen_ResumeIcon;
      
      private static var Scouted_Sound:Class = MainScreen_Scouted_Sound;
      
      public static var scoutedSound:SoundAsset = null;
      
      private static var Attempted_Sound:Class = MainScreen_Attempted_Sound;
      
      public static var attemptedSound:SoundAsset = null;
      
      public static var configAttackWarning:int = 0;
      
      private static var lastEmailMsg:String = null;
      
      private static var cities:Array = new Array();
      
      private static var instance:MainScreen = null;
      
      private var _2003593416pauseButton:Button;
      
      private var _243786428_accountInfo:AccountInfo;
      
      private var _2093140739_logStack:ViewStack;
      
      private var unpauseTimer:Timer = null;
      
      private var _2033767917refreshButton:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var Attack_Sound:Class;
      
      private var displayServerClockTimer:Timer = null;
      
      private var _861376190_MainScreen_VersionLabelBottom:Label;
      
      private var _1247270413_citiesTab:TabBar;
      
      private var pausedLabelTimer:Timer = null;
      
      private var _773017919_serverClockTimeField:Label;
      
      private var checkGiftCounter:int = 2;
      
      private var _94416770cache:ObjectProxy;
      
      private var _1051751339_mapCanvas:MapCanvas;
      
      private var _1255627100logoutButton:Button;
      
      private var attackSeveralSound:SoundAsset = null;
      
      private var attackEndedSound:SoundAsset = null;
      
      private var _2145417798currentPlayer:PlayerBean;
      
      private var skypeWarningTimer:Timer = null;
      
      private var Attack_Several_Sound:Class;
      
      public var _MainScreen_Label3:Label;
      
      private var config:LoginHelper;
      
      private var _1882046310_clearLogBtn:Button;
      
      private var checkForUpdatedVersionTimer:Timer = null;
      
      private var _1587488048_cityPanelBeansArray:ViewStack;
      
      private var lastDate:Date;
      
      private var _3327407logs:TextArea;
      
      private var skypeLastSendTimes:Object;
      
      private var _embed_mxml_autoevony_gui_images_helpIcon_png_987429035:Class;
      
      private var _1611115216_logTab:TabBar;
      
      mx_internal var _watchers:Array;
      
      private var _1685431770_cityPanel:CityPanel;
      
      private var _604333141_snippets:Snippets;
      
      private var attackSound:SoundAsset = null;
      
      private var Attack_Ended_Sound:Class;
      
      private var lastWarningStatus:Boolean = false;
      
      private var _1140201565topInfo:TopInfo;
      
      private var _1012169220topInfoNameServ:Label;
      
      private var _116774925_chatPanel:ChatPanel;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function MainScreen()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "events":{
                     "keyDown":"___MainScreen_VBox1_keyDown",
                     "mouseMove":"___MainScreen_VBox1_mouseMove",
                     "mouseUp":"___MainScreen_VBox1_mouseUp"
                  },
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 0;
                     this.verticalGap = 0;
                     this.paddingLeft = 3;
                     this.paddingRight = 3;
                     this.paddingTop = 3;
                     this.paddingBottom = 0;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 0;
                              this.verticalGap = 0;
                              this.paddingLeft = 0;
                              this.paddingRight = 0;
                              this.paddingTop = 0;
                              this.paddingBottom = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":42,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":VBox,
                                             "stylesFactory":function():void
                                             {
                                                this.left = "25";
                                                this.top = "1";
                                                this.horizontalAlign = "center";
                                                this.horizontalGap = 0;
                                                this.verticalGap = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":220,
                                                   "height":40,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "styleName":"REmainScreenTopNamePopupTitleContainer"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"topInfoNameServ",
                                             "stylesFactory":function():void
                                             {
                                                this.left = "35";
                                                this.textAlign = "center";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":200,
                                                   "styleName":"REmainScreenTopNameText",
                                                   "toolTip":""
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":TopInfo,
                                             "id":"topInfo",
                                             "stylesFactory":function():void
                                             {
                                                this.left = "255";
                                                this.right = "273";
                                                this.top = "0";
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
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
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"pauseButton",
                                                      "events":{"click":"__pauseButton_click"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.paddingTop = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"REwinBtn",
                                                            "enabled":true,
                                                            "label":"Pause"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":10};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"refreshButton",
                                                      "events":{"click":"__refreshButton_click"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.paddingTop = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"REwinBtn",
                                                            "enabled":true,
                                                            "label":"Refresh"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":15};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"logoutButton",
                                                      "events":{"click":"__logoutButton_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "styleName":"REwinBtn",
                                                            "enabled":true,
                                                            "label":"Logout"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":10};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalAlign = "middle";
                                                         this.horizontalAlign = "center";
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":30,
                                                            "height":32,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Image,
                                                               "events":{"click":"___MainScreen_Image1_click"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "source":_embed_mxml_autoevony_gui_images_helpIcon_png_987429035,
                                                                     "toolTip":"Click to view the help doc."
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalGap = 0;
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.verticalAlign = "bottom";
                                                this.horizontalGap = 0;
                                                this.verticalGap = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalAlign = "bottom";
                                                         this.paddingLeft = 0;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 0;
                                                         this.paddingBottom = 0;
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "height":22,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":TabBar,
                                                               "id":"_citiesTab",
                                                               "events":{"itemClick":"___citiesTab_itemClick"},
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.tabStyleName = "REtabBarCitiesTab";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {"styleName":"REtabBar"};
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalAlign = "bottom";
                                                         this.paddingLeft = 0;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 0;
                                                         this.paddingBottom = 0;
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "height":26,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_serverClockTimeField",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "text":"",
                                                                     "styleName":"REmainScreenServerClockTimeField",
                                                                     "toolTip":"Server Clock"
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ViewStack,
                                             "id":"_cityPanelBeansArray",
                                             "stylesFactory":function():void
                                             {
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                                this.borderStyle = "none";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":1,
                                                   "height":0
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 0;
                                                this.verticalGap = 0;
                                                this.paddingLeft = 3;
                                                this.paddingRight = 3;
                                                this.paddingTop = 3;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "percentHeight":100,
                                                   "styleName":"REmainScreenMainPanel",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":VDividedBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalGap = 3;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "percentHeight":100,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":CityPanel,
                                                               "id":"_cityPanel",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "percentHeight":50
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":HDividedBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalGap = 3;
                                                                  this.borderStyle = "none";
                                                                  this.verticalAlign = "bottom";
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "percentHeight":50,
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.verticalGap = 0;
                                                                           this.paddingLeft = 0;
                                                                           this.paddingRight = 0;
                                                                           this.paddingTop = 0;
                                                                           this.paddingBottom = 3;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "percentWidth":100,
                                                                              "percentHeight":100,
                                                                              "childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":HBox,
                                                                                 "stylesFactory":function():void
                                                                                 {
                                                                                    this.verticalAlign = "bottom";
                                                                                 },
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "percentWidth":100,
                                                                                       "height":22,
                                                                                       "childDescriptors":[new UIComponentDescriptor({
                                                                                          "type":TabBar,
                                                                                          "id":"_logTab",
                                                                                          "events":{"itemClick":"___logTab_itemClick"},
                                                                                          "stylesFactory":function():void
                                                                                          {
                                                                                             this.tabStyleName = "REtabBarTab";
                                                                                          },
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {"styleName":"REtabBar"};
                                                                                          }
                                                                                       })]
                                                                                    };
                                                                                 }
                                                                              }),new UIComponentDescriptor({
                                                                                 "type":ViewStack,
                                                                                 "id":"_logStack",
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "creationPolicy":"all",
                                                                                       "percentWidth":100,
                                                                                       "percentHeight":100,
                                                                                       "childDescriptors":[new UIComponentDescriptor({
                                                                                          "type":Canvas,
                                                                                          "events":{
                                                                                             "rollOver":"___MainScreen_Canvas3_rollOver",
                                                                                             "rollOut":"___MainScreen_Canvas3_rollOut"
                                                                                          },
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {
                                                                                                "percentWidth":100,
                                                                                                "percentHeight":100,
                                                                                                "label":"Log",
                                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                                   "type":TextArea,
                                                                                                   "id":"logs",
                                                                                                   "events":{"link":"__logs_link"},
                                                                                                   "stylesFactory":function():void
                                                                                                   {
                                                                                                      this.left = "0";
                                                                                                      this.right = "0";
                                                                                                      this.top = "0";
                                                                                                      this.bottom = "0";
                                                                                                   },
                                                                                                   "propertiesFactory":function():Object
                                                                                                   {
                                                                                                      return {
                                                                                                         "styleName":"RElogBox",
                                                                                                         "editable":false
                                                                                                      };
                                                                                                   }
                                                                                                }),new UIComponentDescriptor({
                                                                                                   "type":Button,
                                                                                                   "id":"_clearLogBtn",
                                                                                                   "events":{"click":"___clearLogBtn_click"},
                                                                                                   "stylesFactory":function():void
                                                                                                   {
                                                                                                      this.top = "10";
                                                                                                      this.right = "27";
                                                                                                   },
                                                                                                   "propertiesFactory":function():Object
                                                                                                   {
                                                                                                      return {
                                                                                                         "styleName":"clearLogBtn",
                                                                                                         "visible":false
                                                                                                      };
                                                                                                   }
                                                                                                })]
                                                                                             };
                                                                                          }
                                                                                       }),new UIComponentDescriptor({
                                                                                          "type":MapCanvas,
                                                                                          "id":"_mapCanvas",
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {"label":"Maps"};
                                                                                          }
                                                                                       }),new UIComponentDescriptor({
                                                                                          "type":AccountInfo,
                                                                                          "id":"_accountInfo",
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {"label":"Account"};
                                                                                          }
                                                                                       }),new UIComponentDescriptor({
                                                                                          "type":Snippets,
                                                                                          "id":"_snippets",
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {"label":"Snippets"};
                                                                                          }
                                                                                       })]
                                                                                    };
                                                                                 }
                                                                              })]
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":ChatPanel,
                                                                        "id":"_chatPanel"
                                                                     })]
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "middle";
                              this.horizontalGap = 0;
                              this.verticalGap = 0;
                              this.paddingLeft = 3;
                              this.paddingRight = 3;
                              this.paddingTop = 0;
                              this.paddingBottom = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "height":17,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":300,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_MainScreen_Label3",
                                             "stylesFactory":function():void
                                             {
                                                this.fontFamily = "DejaVu Sans";
                                                this.fontSize = 10;
                                                this.color = 16777215;
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalAlign = "right";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "id":"_MainScreen_VersionLabelBottom",
                                             "stylesFactory":function():void
                                             {
                                                this.fontFamily = "DejaVu Sans";
                                                this.fontSize = 10;
                                                this.fontStyle = "italic";
                                                this.color = 16777215;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {"text":""};
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               })]};
            }
         });
         this.Attack_Sound = MainScreen_Attack_Sound;
         this.Attack_Several_Sound = MainScreen_Attack_Several_Sound;
         this.Attack_Ended_Sound = MainScreen_Attack_Ended_Sound;
         this._94416770cache = new ObjectProxy({
            "logs":"",
            "cityLogs":new ArrayList(["","","","","","","","","",""]),
            "warLogs":"",
            "emptyStr":""
         });
         this.config = LoginHelper.getInstance();
         this.lastDate = new Date();
         this.skypeLastSendTimes = new Object();
         this._embed_mxml_autoevony_gui_images_helpIcon_png_987429035 = MainScreen__embed_mxml_autoevony_gui_images_helpIcon_png_987429035;
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.paddingLeft = 0;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.styleName = "REmainScreen";
         this.addEventListener("creationComplete",this.___MainScreen_Canvas1_creationComplete);
      }
      
      public static function setPlayer(param1:PlayerBean) : void
      {
         instance.currentPlayer = param1;
      }
      
      private static function _we947(param1:ArrayCollection, param2:Number) : TroopBean
      {
         var _loc7_:String = null;
         var _loc3_:TroopBean = null;
         var _loc4_:TroopBean = new TroopBean();
         var _loc5_:Object = _loc4_.toObject();
         var _loc6_:int = 0;
         while(_loc6_ < param1.length)
         {
            if(param1[_loc6_].reachTime <= param2)
            {
               _loc3_ = Utils.getTroopBeanFromTroopStrBean(param1[_loc6_].troop);
               if(_loc3_ != null)
               {
                  for(_loc7_ in _loc5_)
                  {
                     _loc4_[_loc7_] += _loc3_[_loc7_];
                  }
               }
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function getCityFromFieldId(param1:int) : CityState
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.castle.fieldId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getCityFromValleyFieldId(param1:int) : CityState
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.cityManager.isValley(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getCityManagerFromFieldId(param1:int) : CityManager
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.castle.fieldId == param1)
            {
               return _loc2_.cityManager;
            }
         }
         return null;
      }
      
      public static function getCityFromName(param1:String, param2:Boolean = false) : CityState
      {
         var _loc3_:CityState = null;
         if(!param2)
         {
            for each(_loc3_ in cities)
            {
               if(_loc3_.castle.name == param1)
               {
                  return _loc3_;
               }
            }
         }
         else
         {
            for each(_loc3_ in cities)
            {
               if(_loc3_.castle.name.replace(new RegExp(String.fromCharCode(65279),"g"),"") == param1)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public static function getPlayer() : PlayerBean
      {
         if(instance == null || instance.currentPlayer == null)
         {
            return null;
         }
         return instance.currentPlayer;
      }
      
      public static function setMaintPolicy(param1:int = -1, param2:int = -1) : void
      {
         ChatPanel.maintMin = param1;
         ChatPanel.maintMax = param2;
      }
      
      public static function getMainTownCityState() : CityState
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in cities)
         {
            if(_loc1_.cityManager.isMainTown())
            {
               return _loc1_;
            }
         }
         return cities.length > 0 ? cities[0] as CityState : null;
      }
      
      public static function getCityManagerFromValleyFieldId(param1:int) : CityManager
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.cityManager.isValley(param1))
            {
               return _loc2_.cityManager;
            }
         }
         return null;
      }
      
      public static function getCities() : Array
      {
         return cities;
      }
      
      public static function getInstance() : MainScreen
      {
         return instance;
      }
      
      public static function getCityManagerFromCastleId(param1:int) : CityManager
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.castleId == param1)
            {
               return _loc2_.cityManager;
            }
         }
         return null;
      }
      
      public static function getClosestCityToFieldId(param1:int, param2:int = -1) : CityState
      {
         var _loc4_:CityState = null;
         var _loc3_:CityState = null;
         for each(_loc4_ in cities)
         {
            if(_loc4_.castleId != param2)
            {
               if(_loc3_ == null)
               {
                  _loc3_ = _loc4_;
               }
               else if(Map.fieldDistance(_loc4_.castle.fieldId,param1) < Map.fieldDistance(_loc3_.castle.fieldId,param1))
               {
                  _loc3_ = _loc4_;
               }
            }
         }
         return _loc3_;
      }
      
      public static function getCastle(param1:int) : CastleBean
      {
         var _loc2_:CastleBean = null;
         for each(_loc2_ in instance.currentPlayer.castlesArray)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getCityFromColonyFieldId(param1:int) : CityState
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.cityManager.isColony(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MainScreen._watcherSetupUtil = param1;
      }
      
      public static function setCastle(param1:CastleBean) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < instance.currentPlayer.castlesArray.length)
         {
            if(instance.currentPlayer.castlesArray[_loc2_].id == param1.id)
            {
               instance.currentPlayer.castlesArray[_loc2_] = param1;
               break;
            }
            _loc2_++;
         }
      }
      
      public static function get buildNpcEnabled() : Boolean
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in cities)
         {
            if(_loc1_.cityManager.getCfg(CityConfigs.CFG_BUILDNPC) > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getCityFromCastleId(param1:int) : CityState
      {
         var _loc2_:CityState = null;
         for each(_loc2_ in cities)
         {
            if(_loc2_.castleId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function ___MainScreen_VBox1_keyDown(param1:KeyboardEvent) : void
      {
         this.newKeyDownEvent(param1);
      }
      
      private function onItemDefXml(param1:GetItemDefResponse) : void
      {
         var _loc2_:String = Items.addPacketItem(param1.itemXml);
         if(Version.isTraceOn())
         {
            trace(param1.itemXml);
         }
         if(_loc2_ != "")
         {
            getMainTownCityState().cityManager.logMsg(_loc2_,"#666666");
         }
      }
      
      private function setScrollPos(param1:TextArea) : void
      {
         var target:TextArea = param1;
         Utils.callLater(50,function():void
         {
            target.verticalScrollPosition = target.maxVerticalScrollPosition;
         });
      }
      
      public function set _logStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._2093140739_logStack;
         if(_loc2_ !== param1)
         {
            this._2093140739_logStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_logStack",_loc2_,param1));
         }
      }
      
      public function set topInfoNameServ(param1:Label) : void
      {
         var _loc2_:Object = this._1012169220topInfoNameServ;
         if(_loc2_ !== param1)
         {
            this._1012169220topInfoNameServ = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topInfoNameServ",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get topInfoNameServ() : Label
      {
         return this._1012169220topInfoNameServ;
      }
      
      private function onLoadedText(param1:Event) : void
      {
         this.logMsg(param1.target.data);
      }
      
      private function evtNewMail(param1:NewMail) : void
      {
         if((this.currentPlayer.newMailCount = param1.count) > 0 || (this.currentPlayer.newMaileCount_inbox = param1.count_inbox) > 0 || (this.currentPlayer.newMaileCount_system = param1.count_system) > 0)
         {
            getMainTownCityState().cityManager.doMailNotification();
         }
      }
      
      private function doCityTabLabels(param1:int = -1) : void
      {
         var _loc5_:CityState = null;
         var _loc6_:CastleBean = null;
         var _loc7_:CityPanelBean = null;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:* = param1 > -1;
         for each(_loc7_ in this._cityPanelBeansArray.getChildren())
         {
            if(!(_loc4_ && param1 != _loc7_.castleId))
            {
               _loc5_ = getCityFromCastleId(_loc7_.castleId);
               _loc6_ = getCastle(_loc7_.castleId);
               _loc2_ = _loc6_.name.replace(new RegExp(String.fromCharCode(65279),"g"),"");
               _loc2_ = (!_loc5_.cityManager.isTrainingHeroInCity() ? "" : "*") + (_loc2_.length < 4 ? _loc2_ : _loc2_.substring(0,3)) + Map.fieldIdToCoordString(_loc6_.fieldId);
               if(_loc7_.label != _loc2_)
               {
                  _loc7_.label = _loc2_;
               }
               if(_loc6_.colonyBeansArray.length > 0)
               {
                  if(this.cityIsSuzerain(_loc6_))
                  {
                     _loc3_ = CityPanelBean.ICON_TYPE_SUZ;
                  }
                  else
                  {
                     _loc3_ = CityPanelBean.ICON_TYPE_COL;
                  }
               }
               else
               {
                  _loc3_ = CityPanelBean.ICON_TYPE_NONE;
               }
               _loc7_.setTabIcon(_loc3_);
               if(_loc4_)
               {
                  break;
               }
            }
         }
      }
      
      private function topClockAndGiftUpdate(param1:TimerEvent = null) : void
      {
         this._serverClockTimeField.text = Utils.getServerTimeStr(true);
         this.topInfoNameServ.toolTip = "server:  " + this.config.server + " (" + this.config.serverIP + ")\nborn:  " + new Date(this.currentPlayer.playerInfo.createrTime).toString() + "\nage:  " + Utils.formatTime((Utils.getServerTime() - this.currentPlayer.playerInfo.createrTime) / 1000);
         if(!Connection.getInstance().paused)
         {
            if(25 == this.checkGiftCounter--)
            {
               ActionFactory.getInstance().getCommonCommands().getPackageNumber(this.setBoxNum);
            }
            if(this.checkGiftCounter < 1)
            {
               this.checkGiftCounter = 25;
            }
         }
      }
      
      private function updateEnemyArmies(param1:ArrayCollection) : void
      {
         var _loc2_:CityState = null;
         var _loc3_:int = 0;
         if(this.currentPlayer == null || this.currentPlayer.enemyArmysArray == null)
         {
            Utils.callLater(50,this.updateEnemyArmies,[param1]);
            return;
         }
         if(getMainTownCityState() == null)
         {
            if(Version.isTraceOn())
            {
               trace("   *****  Abnormal get MainTown response");
            }
            Utils.callLater(50,this.updateEnemyArmies,[param1]);
            return;
         }
         this.currentPlayer.enemyArmysArray = param1;
         this.currentPlayer.isReceiveIncomingAttack = this.currentPlayer.enemyArmysArray.length > 0;
         for each(_loc2_ in cities)
         {
            _loc2_.cityManager._updateEnemyArmies(param1);
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if((param1[_loc3_] as ArmyBean).missionType == ObjConstants.ARMY_MISSION_SEND)
            {
               param1.removeItemAt(_loc3_--);
            }
            _loc3_++;
         }
         param1.source.sort(Utils.sortByReachTime);
         if(Version.isTraceOn())
         {
            trace("eArmyObj = " + (param1 != null ? param1.length : "null") + "    isAtkWarnOn = " + (getMainTownCityState() != null ? getMainTownCityState().cityManager._isAttackWarningOn() : "null"));
         }
         this.processEnemyAudioWarning(param1,getMainTownCityState().cityManager._isAttackWarningOn());
         this.processEnemySkypeWarning();
      }
      
      private function loadCustomAudio() : void
      {
         var atkSnd_onLoadComplete:Function = null;
         var atkSnd_onIOError:Function = null;
         var atkSvrlSnd_onLoadComplete:Function = null;
         var atkSvrlSnd_onIOError:Function = null;
         var atkEnd_onLoadComplete:Function = null;
         var atkEnd_onIOError:Function = null;
         var sct_onLoadComplete:Function = null;
         var sct_onIOError:Function = null;
         var attmptSct_onLoadComplete:Function = null;
         var attmptSct_onIOError:Function = null;
         atkSnd_onLoadComplete = function(param1:Event):void
         {
            attackSound.removeEventListener(Event.COMPLETE,atkSnd_onLoadComplete);
            attackSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSnd_onIOError);
         };
         atkSnd_onIOError = function(param1:IOErrorEvent):void
         {
            attackSound.removeEventListener(Event.COMPLETE,atkSnd_onLoadComplete);
            attackSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSnd_onIOError);
            attackSound = new Attack_Sound() as SoundAsset;
            logMsg("Could not load custom attack sound, using default warning instead.");
            if(Version.isTraceOn())
            {
               trace("Could not load custom attack sound, using default warning instead:  " + param1.text);
            }
         };
         try
         {
            this.attackSound = new SoundAsset();
            this.attackSound.addEventListener(Event.COMPLETE,atkSnd_onLoadComplete);
            this.attackSound.addEventListener(IOErrorEvent.IO_ERROR,atkSnd_onIOError);
            this.attackSound.load(new URLRequest("sounds/attack.mp3"));
         }
         catch(error1:Error)
         {
            attackSound.removeEventListener(Event.COMPLETE,atkSnd_onLoadComplete);
            attackSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSnd_onIOError);
            this.attackSound = new Attack_Sound() as SoundAsset;
            this.logMsg("Could not load custom attack sound, using default warning instead:  " + error1.message);
         }
         atkSvrlSnd_onLoadComplete = function(param1:Event):void
         {
            attackSeveralSound.removeEventListener(Event.COMPLETE,atkSvrlSnd_onLoadComplete);
            attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSvrlSnd_onIOError);
         };
         atkSvrlSnd_onIOError = function(param1:IOErrorEvent):void
         {
            attackSeveralSound.removeEventListener(Event.COMPLETE,atkSvrlSnd_onLoadComplete);
            attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSvrlSnd_onIOError);
            attackSeveralSound = new Attack_Several_Sound() as SoundAsset;
            logMsg("Could not load custom attack_several sound, using default warning instead.");
            if(Version.isTraceOn())
            {
               trace("Could not load custom attack_several sound, using default warning instead:  " + param1.text);
            }
         };
         try
         {
            this.attackSeveralSound = new SoundAsset();
            this.attackSeveralSound.addEventListener(Event.COMPLETE,atkSvrlSnd_onLoadComplete);
            this.attackSeveralSound.addEventListener(IOErrorEvent.IO_ERROR,atkSvrlSnd_onIOError);
            this.attackSeveralSound.load(new URLRequest("sounds/attack_several.mp3"));
         }
         catch(error2:Error)
         {
            attackSeveralSound.removeEventListener(Event.COMPLETE,atkSvrlSnd_onLoadComplete);
            attackSeveralSound.removeEventListener(IOErrorEvent.IO_ERROR,atkSvrlSnd_onIOError);
            this.attackSeveralSound = new Attack_Several_Sound() as SoundAsset;
            this.logMsg("Could not load custom attack_several sound, using default warning instead:  " + error2.message);
         }
         atkEnd_onLoadComplete = function(param1:Event):void
         {
            attackEndedSound.removeEventListener(Event.COMPLETE,atkEnd_onLoadComplete);
            attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR,atkEnd_onIOError);
         };
         atkEnd_onIOError = function(param1:IOErrorEvent):void
         {
            attackEndedSound.removeEventListener(Event.COMPLETE,atkEnd_onLoadComplete);
            attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR,atkEnd_onIOError);
            attackEndedSound = new Attack_Ended_Sound() as SoundAsset;
            logMsg("Could not load custom attack_ended sound, using default warning instead.");
            if(Version.isTraceOn())
            {
               trace("Could not load custom attack_ended sound, using default warning instead:  " + param1.text);
            }
         };
         try
         {
            this.attackEndedSound = new SoundAsset();
            this.attackEndedSound.addEventListener(Event.COMPLETE,atkEnd_onLoadComplete);
            this.attackEndedSound.addEventListener(IOErrorEvent.IO_ERROR,atkEnd_onIOError);
            this.attackEndedSound.load(new URLRequest("sounds/attack_ended.mp3"));
         }
         catch(error3:Error)
         {
            attackEndedSound.removeEventListener(Event.COMPLETE,atkEnd_onLoadComplete);
            attackEndedSound.removeEventListener(IOErrorEvent.IO_ERROR,atkEnd_onIOError);
            this.attackEndedSound = new Attack_Ended_Sound() as SoundAsset;
            this.logMsg("Could not load custom attack_ended sound, using default warning instead:  " + error3.message);
         }
         sct_onLoadComplete = function(param1:Event):void
         {
            scoutedSound.removeEventListener(Event.COMPLETE,sct_onLoadComplete);
            scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR,sct_onIOError);
         };
         sct_onIOError = function(param1:IOErrorEvent):void
         {
            scoutedSound.removeEventListener(Event.COMPLETE,sct_onLoadComplete);
            scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR,sct_onIOError);
            scoutedSound = new Scouted_Sound() as SoundAsset;
            logMsg("Could not load custom scouted sound, using default warning instead.");
            if(Version.isTraceOn())
            {
               trace("Could not load custom scouted sound, using default warning instead:  " + param1.text);
            }
         };
         try
         {
            scoutedSound = new SoundAsset();
            scoutedSound.addEventListener(Event.COMPLETE,sct_onLoadComplete);
            scoutedSound.addEventListener(IOErrorEvent.IO_ERROR,sct_onIOError);
            scoutedSound.load(new URLRequest("sounds/scouted.mp3"));
         }
         catch(error4:Error)
         {
            scoutedSound.removeEventListener(Event.COMPLETE,sct_onLoadComplete);
            scoutedSound.removeEventListener(IOErrorEvent.IO_ERROR,sct_onIOError);
            scoutedSound = new Scouted_Sound() as SoundAsset;
            this.logMsg("Could not load custom scouted sound, using default warning instead:  " + error4.message);
         }
         attmptSct_onLoadComplete = function(param1:Event):void
         {
            attemptedSound.removeEventListener(Event.COMPLETE,attmptSct_onLoadComplete);
            attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR,attmptSct_onIOError);
         };
         attmptSct_onIOError = function(param1:IOErrorEvent):void
         {
            attemptedSound.removeEventListener(Event.COMPLETE,attmptSct_onLoadComplete);
            attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR,attmptSct_onIOError);
            attemptedSound = new Attempted_Sound() as SoundAsset;
            logMsg("Could not load custom attempted sound, using default warning instead.");
            if(Version.isTraceOn())
            {
               trace("Could not load custom attempted sound, using default warning instead:  " + param1.text);
            }
         };
         try
         {
            attemptedSound = new SoundAsset();
            attemptedSound.addEventListener(Event.COMPLETE,attmptSct_onLoadComplete);
            attemptedSound.addEventListener(IOErrorEvent.IO_ERROR,attmptSct_onIOError);
            attemptedSound.load(new URLRequest("sounds/attempted.mp3"));
         }
         catch(error5:Error)
         {
            attemptedSound.removeEventListener(Event.COMPLETE,attmptSct_onLoadComplete);
            attemptedSound.removeEventListener(IOErrorEvent.IO_ERROR,attmptSct_onIOError);
            attemptedSound = new Attempted_Sound() as SoundAsset;
            this.logMsg("Could not load custom attempted sound, using default warning instead:  " + error5.message);
         }
      }
      
      public function set _chatPanel(param1:ChatPanel) : void
      {
         var _loc2_:Object = this._116774925_chatPanel;
         if(_loc2_ !== param1)
         {
            this._116774925_chatPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_chatPanel",_loc2_,param1));
         }
      }
      
      private function destroyCityObject(param1:CityState) : void
      {
         var _loc2_:int = param1.castleId;
         var _loc3_:* = this.getSelectedCity().castleId == _loc2_;
         var _loc4_:int = 0;
         while(_loc4_ < this._cityPanelBeansArray.getChildren().length)
         {
            if((this._cityPanelBeansArray.getChildAt(_loc4_) as CityPanelBean).castleId == _loc2_)
            {
               this._cityPanelBeansArray.removeChildAt(_loc4_--);
            }
            _loc4_++;
         }
         _loc4_ = int(cities.indexOf(param1));
         if(_loc4_ != -1)
         {
            this.unInitCityScript(param1);
            this.cache.cityLogs.setItemAt("",_loc4_);
            cities.splice(_loc4_,1);
         }
         _loc4_ = 0;
         while(_loc4_ < this.currentPlayer.castlesArray.length)
         {
            if(this.currentPlayer.castlesArray[_loc4_].id == _loc2_)
            {
               this.currentPlayer.castlesArray.removeItemAt(_loc4_--);
            }
            _loc4_++;
         }
         if(_loc3_)
         {
            this._cityPanel.cityPanelBean = this._cityPanelBeansArray.getChildAt(0) as CityPanelBean;
            this._cityPanel.castleBean = this.currentPlayer.castlesArray.getItemAt(0) as CastleBean;
            this._cityPanelBeansArray.selectedIndex = 0;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _chatPanel() : ChatPanel
      {
         return this._116774925_chatPanel;
      }
      
      public function set _citiesTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._1247270413_citiesTab;
         if(_loc2_ !== param1)
         {
            this._1247270413_citiesTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_citiesTab",_loc2_,param1));
         }
      }
      
      private function handleLogLinkEvent(param1:TextEvent) : void
      {
         navigateToURL(new URLRequest("http://" + param1.text),"_blank");
      }
      
      private function eArmyToString(param1:ArmyBean) : String
      {
         return (param1.alliance != null ? " alliance:" + param1.alliance : "") + (param1.king != null ? " lord:" + param1.king : "") + (param1.startPosName != null ? " from:" + param1.startPosName : "") + (param1.startFieldId != -1 ? "(" + Map.getX(param1.startFieldId) + "," + Map.getY(param1.startFieldId) + ")" : "") + (param1.targetPosName != null ? " to:" + param1.targetPosName : "") + (param1.targetFieldId != -1 ? "(" + Map.getX(param1.targetFieldId) + "," + Map.getY(param1.targetFieldId) + ")" : "") + (param1.troop != null ? " troop: " + Utils.troopStrBeanToMsgString(param1.troop) : "") + (param1.reachTime != -1 ? " in " + Utils.formatEndTime(param1.reachTime) + " @ " + Utils.getLogTimeStr(param1.reachTime) : "");
      }
      
      [Bindable(event="propertyChange")]
      public function get _citiesTab() : TabBar
      {
         return this._1247270413_citiesTab;
      }
      
      public function ___MainScreen_Canvas3_rollOut(param1:MouseEvent) : void
      {
         this._clearLogBtn.visible = false;
      }
      
      private function onResourceUpdate(param1:ResourceUpdate) : void
      {
         var _loc2_:CastleBean = null;
         var _loc3_:CityState = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            return;
         }
         if(this.currentPlayer == null || this.currentPlayer.castlesArray == null)
         {
            Utils.callLater(50,this.onResourceUpdate,[param1]);
         }
         else
         {
            _loc2_ = getCastle(param1.castleId);
            if(_loc2_ != null)
            {
               if(_loc2_.resource == null)
               {
                  _loc2_.resource = param1.resource;
               }
               else
               {
                  param1.resource.copyTo(_loc2_.resource);
               }
               _loc3_ = getCityFromCastleId(param1.castleId);
               if(_loc3_ != null)
               {
                  _loc3_.cityManager._onResourceUpdate();
               }
            }
         }
      }
      
      private function unInitCityScript(param1:CityState) : void
      {
         param1._getScript().removeEventListener(ScriptLogEvent.TYPE,this.cityLogMsg);
         param1.cityManager.removeEventListener(ScriptLogEvent.TYPE,this.cityLogMsg);
         param1.cityManager.removeEventListener(WarLogEvent.TYPE,this.warLogMsg);
         param1._getScript().removeEventListener(StopScriptEvent.STOP_SCRIPT,this.onStopScriptEvent);
         param1._getScript()._cleanUp();
      }
      
      private function doPauseResume() : void
      {
         var _loc1_:Connection = Connection.getInstance();
         _loc1_.paused = _loc1_.paused == false;
         this.modifyCtrlBtns();
         this.logMsg(_loc1_.paused ? "Pausing jobs" : "Resuming jobs");
         _loc1_.reconnectTimer.delay = Utils.rand(20 * 1000,30 * 1000);
         _loc1_.reconnectHandler();
         if(!_loc1_.paused && this.unpauseTimer != null && this.unpauseTimer.running)
         {
            this.unpauseTimer.stop();
         }
      }
      
      private function clear(param1:Boolean, param2:String, param3:Boolean = false) : void
      {
         if(!param1)
         {
            return;
         }
         if(param3)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to clear this log window?",this.clear,"Clear Log","Cancel",[param2]));
            return;
         }
         if(param2 == "cityLogs")
         {
            (this.cache.cityLogs as ArrayList).setItemAt("",this._citiesTab.selectedIndex);
            this.cache.emptyStr = " ";
            this.cache.emptyStr = "";
         }
         else
         {
            this.cache[param2] = "";
         }
      }
      
      private function evtDeclaredWarsUpdate(param1:DeclaredWarUpdate) : void
      {
         this.currentPlayer.declaredWarBeansArray = param1.declaredWarBeansArray;
      }
      
      public function _dx1146(param1:int) : Boolean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in this.currentPlayer.enemyArmysArray)
         {
            if(_loc2_.reachTime - Utils.getServerTime() < param1 * 1000)
            {
               return true;
            }
         }
         return false;
      }
      
      private function evtNewReport(param1:NewReport) : void
      {
         if(this.currentPlayer == null || getMainTownCityState() == null)
         {
            Utils.callLater(50,this.evtNewReport,[param1]);
            return;
         }
         var _loc2_:CityManager = getMainTownCityState().cityManager;
         this.currentPlayer.newReportCount = param1.count;
         this.currentPlayer.newReportCount_army = param1.army_count;
         this.currentPlayer.newReportCount_scout = param1.scout_cout;
         this.currentPlayer.newReportCount_trade = param1.trade_count;
         this.currentPlayer.newReportCount_other = param1.other_count;
         _loc2_._handleNewReport(param1);
      }
      
      public function ___citiesTab_itemClick(param1:ItemClickEvent) : void
      {
         this.onCityTabClick(param1);
      }
      
      public function disableLogoutButton() : void
      {
         this.logoutButton.enabled = false;
      }
      
      private function loadTextTest() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.addEventListener(Event.COMPLETE,this.onLoadedText);
         _loc1_.load(new URLRequest("Scripts/myTextTest.txt"));
      }
      
      private function onSecCodeResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.showNewMsg("logs","WARNING: Error received while handling security code:  " + param1.errorMsg,"#CC0000");
         }
         else
         {
            ActionFactory.getInstance().getSecurityCommands().setUnlockOption(31,this.onUnlockSecOption);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _mapCanvas() : MapCanvas
      {
         return this._1051751339_mapCanvas;
      }
      
      public function ___MainScreen_Canvas3_rollOver(param1:MouseEvent) : void
      {
         this._clearLogBtn.visible = true;
      }
      
      [Bindable(event="propertyChange")]
      public function get _snippets() : Snippets
      {
         return this._604333141_snippets;
      }
      
      private function initCities() : void
      {
         var ii:int = 0;
         var i:int = 0;
         var pw:String = this.config.getHashedEvonyPw();
         var found:Boolean = false;
         var firstCastleId:int = (this.currentPlayer.castlesArray.getItemAt(0) as CastleBean).id;
         var castle:CastleBean = null;
         var h:HeroBean = null;
         var newCity:CityState = null;
         var cPanelBean:CityPanelBean = null;
         try
         {
            i = 0;
            while(i < this.currentPlayer.castlesArray.length)
            {
               castle = this.currentPlayer.castlesArray[i];
               for each(h in castle.herosArray)
               {
                  Utils.formatHeroName(h);
               }
               Utils.sortFieldsByDistance(castle);
               found = false;
               ii = 0;
               while(ii < cities.length)
               {
                  if((cities[ii] as CityState).castleId == castle.id)
                  {
                     found = true;
                     if(ii != i)
                     {
                        cities.splice(i,0,cities.splice(ii,1)[0]);
                        this._cityPanelBeansArray.addChildAt(this._cityPanelBeansArray.removeChildAt(ii),i);
                     }
                     (cities[i] as CityState)._setCastleBean();
                     break;
                  }
                  ii++;
               }
               if(!found)
               {
                  if(castle.id != firstCastleId)
                  {
                     newCity = new CityState(int(castle.id));
                  }
                  else
                  {
                     newCity = new CityState(int(castle.id),false);
                  }
                  cities.push(newCity);
                  cPanelBean = new CityPanelBean(int(castle.id),(castle.name.length < 4 ? castle.name : castle.name.substring(0,3)) + Map.fieldIdToCoordString(castle.fieldId));
                  this._cityPanelBeansArray.addChild(cPanelBean);
                  this.initCityScript(newCity);
                  cPanelBean.onLoadGoals();
                  cPanelBean.onLoadScript(null,5000);
               }
               i++;
            }
            this.removeStaleCityObjects();
            if(!this._cityPanel.isInitialized)
            {
               this._cityPanel.init();
            }
            Utils.callLater(50,this.doCityTabLabels);
            Utils.callLater(100,this.doCityTabColors);
         }
         catch(error:Error)
         {
            logMsg("Error in parseCities: " + error.message);
         }
      }
      
      private function onCancelRemoveResponse(param1:CommandResponse) : void
      {
         var _loc2_:String = "";
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            _loc2_ = "An error occured while attempting to cancel the security code removal process:  " + param1.errorMsg;
         }
         else
         {
            _loc2_ = "The security code removal process has been cancelled sucessfully.";
         }
         getMainTownCityState().cityManager.logMsg(_loc2_,"#AA0000");
      }
      
      private function removeStaleCityObjects() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:CastleBean = null;
         var _loc3_:int = 0;
         while(_loc3_ < cities.length)
         {
            _loc1_ = false;
            for each(_loc2_ in this.currentPlayer.castlesArray)
            {
               if(_loc2_.id == cities[_loc3_].castleId)
               {
                  _loc1_ = true;
                  break;
               }
            }
            if(!_loc1_)
            {
               this.destroyCityObject(cities[_loc3_--] as CityState);
            }
            _loc3_++;
         }
      }
      
      public function enableLogoutButton() : void
      {
         this.logoutButton.enabled = true;
      }
      
      private function getPlayerBuffIndexFromTypeId(param1:String) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.currentPlayer.buffsArray.length)
         {
            if(this.currentPlayer.buffsArray[_loc2_].typeId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function ___MainScreen_VBox1_mouseUp(param1:MouseEvent) : void
      {
         this._cityPanel.onHideRename(param1.target);
      }
      
      private function setWindowTitle(param1:String = "") : void
      {
         var newTitle:String = param1;
         try
         {
            ExternalInterface.call("changeTitle",newTitle);
         }
         catch(e:Error)
         {
            this.showNewMsg("logs","Cannot set window title: " + e.message);
         }
      }
      
      public function set _MainScreen_VersionLabelBottom(param1:Label) : void
      {
         var _loc2_:Object = this._861376190_MainScreen_VersionLabelBottom;
         if(_loc2_ !== param1)
         {
            this._861376190_MainScreen_VersionLabelBottom = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_MainScreen_VersionLabelBottom",_loc2_,param1));
         }
      }
      
      private function handleSecCode() : void
      {
         if(this.config.secCode == "")
         {
            this.showNewMsg("logs","WARNING: Security code is set with no way to disable it for full account management. Restart and enter code at login screen, or manually run script.","#CC0000");
         }
         else
         {
            ActionFactory.getInstance().getSecurityCommands().authSecurityCode(this.config.secCode,this.onSecCodeResponse);
         }
      }
      
      public function scheduleUnpauseTimer(param1:Number) : void
      {
         var _loc2_:Date = null;
         if(!Connection.getInstance().paused)
         {
            _loc2_ = new Date(new Date().getTime() + param1);
            this.logMsg("*** Pausing job queues for " + Utils.formatTime(param1 / 1000) + " before automatically resuming at " + Utils.format2(_loc2_.hours) + ":" + Utils.format2(_loc2_.minutes) + ". ***","#79796A");
            this.doPauseResume();
         }
         if(this.unpauseTimer != null)
         {
            this.unpauseTimer.delay = param1;
            this.unpauseTimer.reset();
         }
         else
         {
            this.unpauseTimer = new Timer(param1,1);
            this.unpauseTimer.addEventListener(TimerEvent.TIMER,this.onUnpauseTimer);
         }
         this.unpauseTimer.start();
      }
      
      private function checkForUpdatedVersion(param1:TimerEvent = null) : void
      {
         var checkForUpdatedVersionResponse:Function = null;
         var checkForUpdatedVersionErrorResponse:Function = null;
         var httpReq:HTTPService = null;
         var evt:TimerEvent = param1;
         checkForUpdatedVersionResponse = function(param1:ResultEvent):void
         {
            httpReq.removeEventListener(ResultEvent.RESULT,checkForUpdatedVersionResponse);
            httpReq.removeEventListener(FaultEvent.FAULT,checkForUpdatedVersionErrorResponse);
            var _loc2_:XML = new XML(param1.message.body.toString());
            var _loc3_:String = _loc2_.versionInfo.@ver;
            var _loc4_:String = _loc2_.versionInfo.@step;
            var _loc5_:String = _loc2_.versionInfo.@release;
            if(_loc3_ != Version.getVersion() || _loc4_ != Version.getStep() || _loc5_ != Version.getRelease())
            {
               _MainScreen_VersionLabelBottom.text = (_loc2_.versionInfo.@isBeta == "true" ? "A Beta" : "An") + " update is available!    ";
            }
            else
            {
               _MainScreen_VersionLabelBottom.text = "";
            }
            httpReq = null;
            _loc2_ = null;
         };
         checkForUpdatedVersionErrorResponse = function(param1:FaultEvent):void
         {
            httpReq.removeEventListener(ResultEvent.RESULT,checkForUpdatedVersionResponse);
            httpReq.removeEventListener(FaultEvent.FAULT,checkForUpdatedVersionErrorResponse);
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
         httpReq.addEventListener(ResultEvent.RESULT,checkForUpdatedVersionResponse);
         httpReq.addEventListener(FaultEvent.FAULT,checkForUpdatedVersionErrorResponse);
         httpReq.send(postVars);
      }
      
      private function onHeroUpdate(param1:HeroUpdate) : void
      {
         var _loc2_:CityState = getCityFromCastleId(param1.castleId);
         if(_loc2_ == null || _loc2_.cityManager == null)
         {
            Utils.callLater(50,this.onHeroUpdate,[param1]);
            return;
         }
         _loc2_.cityManager._onHeroUpdate(param1);
         if(_loc2_.cityManager._isTraininghero(param1.hero.name) && (param1.updateType == CommonConstants.UPDATE_TYPE_ADD || param1.updateType == CommonConstants.UPDATE_TYPE_DELETE))
         {
            this.doCityTabLabels(param1.castleId);
         }
         if(param1.hero.isHero == CommonConstants.HERO_KING_QUEEN && (param1.updateType == CommonConstants.UPDATE_TYPE_ADD || param1.updateType == CommonConstants.UPDATE_TYPE_DELETE))
         {
            this.doCityTabColors(param1.castleId);
         }
      }
      
      private function evtFriendArmiesUpdate(param1:FriendArmysUpdate) : void
      {
         if(this.currentPlayer == null || this.currentPlayer.friendArmysArray == null)
         {
            Utils.callLater(50,this.evtFriendArmiesUpdate,[param1]);
         }
         else
         {
            this.updateFriendlyArmies(param1.armysArray);
         }
      }
      
      public function __logs_link(param1:TextEvent) : void
      {
         this.handleLogLinkEvent(param1);
      }
      
      public function warLogMsg(param1:WarLogEvent) : void
      {
         this.showNewMsg("warLogs",param1.logText);
         if(this._logTab.selectedIndex != 2)
         {
            this._logTab.getChildren()[2].setStyle("fontStyle","italic");
         }
      }
      
      private function updateFriendlyArmies(param1:ArrayCollection) : void
      {
         var _loc4_:CityState = null;
         var _loc5_:int = 0;
         var _loc6_:ArmyBean = null;
         if(param1 == null)
         {
            return;
         }
         this.currentPlayer.friendArmysArray = param1;
         var _loc2_:Array = new Array();
         var _loc3_:Array = new Array();
         for each(_loc4_ in cities)
         {
            _loc2_.push(_loc4_.castle.fieldId);
            _loc3_.push([]);
         }
         for each(_loc6_ in param1)
         {
            _loc5_ = int(_loc2_.indexOf(_loc6_.targetFieldId));
            if(_loc5_ != -1)
            {
               (_loc3_[_loc5_] as Array).push(_loc6_);
            }
         }
         for each(_loc4_ in cities)
         {
            _loc4_.cityManager._updateFriendArmies(_loc3_[_loc2_.indexOf(_loc4_.castle.fieldId)] as Array);
         }
      }
      
      public function set _mapCanvas(param1:MapCanvas) : void
      {
         var _loc2_:Object = this._1051751339_mapCanvas;
         if(_loc2_ !== param1)
         {
            this._1051751339_mapCanvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_mapCanvas",_loc2_,param1));
         }
      }
      
      private function sendSkypeWarnings(param1:Array, param2:String) : void
      {
         var receiver:Object = null;
         var receivers:Array = param1;
         var msg:String = param2;
         var skResp:SkypeResponse = null;
         for each(receiver in receivers)
         {
            try
            {
               if((skResp = Skype.queueMsg(receiver.id,msg,receiver.isGroup)).ok != 1)
               {
                  trace(skResp.errorMsg);
               }
            }
            catch(e:Error)
            {
               trace(e);
            }
         }
      }
      
      public function set _snippets(param1:Snippets) : void
      {
         var _loc2_:Object = this._604333141_snippets;
         if(_loc2_ !== param1)
         {
            this._604333141_snippets = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_snippets",_loc2_,param1));
         }
      }
      
      private function _MainScreen_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.currentPlayer.playerInfo.userName;
         _loc1_ = this.currentPlayer.playerInfo.alliance == null ? "(no alliance)" : this.currentPlayer.playerInfo.alliance;
         _loc1_ = Utils.formatInt(this.currentPlayer.playerInfo.prestige);
         _loc1_ = this.currentPlayer.playerInfo.office;
         _loc1_ = Utils.formatInt(this.currentPlayer.playerInfo.medal);
         _loc1_ = Utils.formatInt(this.currentPlayer.playerInfo.ranking);
         _loc1_ = this.currentPlayer.playerInfo.levelId - 4;
         _loc1_ = this.currentPlayer.playerInfo.alliance == null ? "" : this.currentPlayer.playerInfo.allianceLevel;
         _loc1_ = Utils.formatInt(this.currentPlayer.playerInfo.honor);
         _loc1_ = Map.TITLES.getItemAt(this.currentPlayer.playerInfo.titleId);
         _loc1_ = PauseIcon;
         _loc1_ = RefreshIcon;
         _loc1_ = this._cityPanelBeansArray.selectedChild;
         _loc1_ = this.currentPlayer.castlesArray.getItemAt(this._cityPanelBeansArray.selectedIndex);
         _loc1_ = [{"label":"Log"},{"label":"City Log"},{"label":"War Log"},{"label":"Maps"},{"label":"Account"},{"label":"Snippets"}];
         _loc1_ = this._logTab.selectedIndex < 3 ? 0 : this._logTab.selectedIndex - 2;
         _loc1_ = this._logTab.selectedIndex == 0 ? this.cache.logs : (this._logTab.selectedIndex == 1 ? this.cache.cityLogs.getItemAt(this._citiesTab.selectedIndex) : (this._logTab.selectedIndex == 2 ? this.cache.warLogs : this.cache.emptyStr));
         _loc1_ = "Clear all entries from the " + (this._logTab.selectedIndex == 0 ? "Main" : (this._logTab.selectedIndex == 1 ? "City" : "War")) + " Log";
         _loc1_ = "   RE for Age II: " + Version.getVersionStr();
      }
      
      [Bindable(event="propertyChange")]
      public function get _accountInfo() : AccountInfo
      {
         return this._243786428_accountInfo;
      }
      
      public function setBoxNum(param1:GetPackageNumberResponse) : void
      {
         var _loc2_:int = 0;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            if(Version.isTraceOn())
            {
               trace(param1.errorMsg);
            }
         }
         else
         {
            this.checkGiftCounter = 24;
            _loc2_ = param1.number;
            if(_loc2_ < 1)
            {
               _loc2_ = 0;
            }
            if(this.topInfo.gift != Utils.formatInt(_loc2_))
            {
               this.topInfo.gift = Utils.formatInt(_loc2_);
            }
         }
      }
      
      public function set logoutButton(param1:Button) : void
      {
         var _loc2_:Object = this._1255627100logoutButton;
         if(_loc2_ !== param1)
         {
            this._1255627100logoutButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logoutButton",_loc2_,param1));
         }
      }
      
      private function evtPlayerBuffUpdate(param1:PlayerBuffUpdate) : void
      {
         if(param1.buffBean == null)
         {
            return;
         }
         var _loc2_:int = this.getPlayerBuffIndexFromTypeId(param1.buffBean.typeId);
         var _loc3_:String = "";
         if(param1.updateType == 0)
         {
            _loc3_ = "PLAYERBUFFUPDATE > <b>Buff added</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName + "  <b>remain time</b>: " + Utils.formatTime((param1.buffBean.endTime - Utils.getServerTime()) / 1000);
            if(_loc2_ != -1)
            {
               this.currentPlayer.buffsArray[_loc2_] = param1.buffBean;
            }
            else
            {
               this.currentPlayer.buffsArray.addItem(param1.buffBean);
            }
         }
         else if(param1.updateType == 1)
         {
            _loc3_ = "PLAYERBUFFUPDATE > <b>Buff removed</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName;
            if(_loc2_ != -1)
            {
               this.currentPlayer.buffsArray.removeItemAt(_loc2_);
            }
         }
         else if(param1.updateType == 2)
         {
            _loc3_ = "PLAYERBUFFUPDATE > <b>Buff change</b>: <u>" + param1.buffBean.typeId + "</u>: " + param1.buffBean.descName + "  <b>remain time</b>: " + Utils.formatTime((param1.buffBean.endTime - Utils.getServerTime()) / 1000);
            if(_loc2_ == -1)
            {
               this.currentPlayer.buffsArray.addItem(param1.buffBean);
            }
            else
            {
               this.currentPlayer.buffsArray[_loc2_] = param1.buffBean;
            }
         }
         else
         {
            _loc3_ = "PLAYERBUFFUPDATE > ignore buff update " + param1.updateType + " on " + param1.buffBean.typeId;
         }
         if(_loc3_ != "")
         {
            getMainTownCityState().cityManager.logMsg(_loc3_,"#225555");
         }
         if((param1.updateType == 0 || param1.updateType == 2) && param1.buffBean.typeId == "RemovingSecurityCodeBuff" && getMainTownCityState().cityManager.getCfg(CityConfigs.CFG_ALLOWDISABLESECCODE) <= 0)
         {
            getMainTownCityState().cityManager.logMsg("Detected an attempt to remove security code. Cancelling code removal now.","#AA0000");
            ActionFactory.getInstance().getSecurityCommands().cancelRemovingSecurityCodeProcess(this.onCancelRemoveResponse);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _serverClockTimeField() : Label
      {
         return this._773017919_serverClockTimeField;
      }
      
      private function initReqs(param1:int) : void
      {
         ActionFactory.getInstance().getQuestCommands().getQuestType(param1,1);
         ActionFactory.getInstance().getQuestCommands().getQuestType(param1,4);
         ActionFactory.getInstance().getCommonCommands().getItemDefXml(this.onItemDefXml);
         ActionFactory.getInstance().getTechCommand().getResearchList(param1);
         ActionFactory.getInstance().getQuestCommands().getQuestList(param1,64);
         ActionFactory.getInstance().getCommonCommands().getPackageNumber(this.setBoxNum);
         ActionFactory.getInstance().getTechCommand().getResearchList(param1);
         ActionFactory.getInstance().getEquipmenttechCommands().getResearchList(param1);
      }
      
      private function sendEmailAlert(param1:String, param2:String) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _cityPanelBeansArray() : ViewStack
      {
         return this._1587488048_cityPanelBeansArray;
      }
      
      public function set _clearLogBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1882046310_clearLogBtn;
         if(_loc2_ !== param1)
         {
            this._1882046310_clearLogBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_clearLogBtn",_loc2_,param1));
         }
      }
      
      private function _MainScreen_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.currentPlayer.playerInfo.userName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfoNameServ.text = param1;
         },"topInfoNameServ.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.currentPlayer.playerInfo.alliance == null ? "(no alliance)" : this.currentPlayer.playerInfo.alliance;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.alliance = param1;
         },"topInfo.alliance");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.currentPlayer.playerInfo.prestige);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.prestige = param1;
         },"topInfo.prestige");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.currentPlayer.playerInfo.office;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.office = param1;
         },"topInfo.office");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.currentPlayer.playerInfo.medal);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.gameCoins = param1;
         },"topInfo.gameCoins");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.currentPlayer.playerInfo.ranking);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.ranking = param1;
         },"topInfo.ranking");
         result[5] = binding;
         binding = new Binding(this,function():int
         {
            return this.currentPlayer.playerInfo.levelId - 4;
         },function(param1:int):void
         {
            topInfo.roleImg = param1;
         },"topInfo.roleImg");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.currentPlayer.playerInfo.alliance == null ? "" : this.currentPlayer.playerInfo.allianceLevel;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.role = param1;
         },"topInfo.role");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.currentPlayer.playerInfo.honor);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.honor = param1;
         },"topInfo.honor");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Map.TITLES.getItemAt(this.currentPlayer.playerInfo.titleId);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            topInfo.title = param1;
         },"topInfo.title");
         result[9] = binding;
         binding = new Binding(this,function():Class
         {
            return PauseIcon;
         },function(param1:Class):void
         {
            pauseButton.setStyle("icon",param1);
         },"pauseButton.icon");
         result[10] = binding;
         binding = new Binding(this,function():Class
         {
            return RefreshIcon;
         },function(param1:Class):void
         {
            refreshButton.setStyle("icon",param1);
         },"refreshButton.icon");
         result[11] = binding;
         binding = new Binding(this,function():CityPanelBean
         {
            return this._cityPanelBeansArray.selectedChild;
         },function(param1:CityPanelBean):void
         {
            _cityPanel.cityPanelBean = param1;
         },"_cityPanel.cityPanelBean");
         result[12] = binding;
         binding = new Binding(this,function():CastleBean
         {
            return this.currentPlayer.castlesArray.getItemAt(this._cityPanelBeansArray.selectedIndex);
         },function(param1:CastleBean):void
         {
            _cityPanel.castleBean = param1;
         },"_cityPanel.castleBean");
         result[13] = binding;
         binding = new Binding(this,function():Object
         {
            return [{"label":"Log"},{"label":"City Log"},{"label":"War Log"},{"label":"Maps"},{"label":"Account"},{"label":"Snippets"}];
         },function(param1:Object):void
         {
            _logTab.dataProvider = param1;
         },"_logTab.dataProvider");
         result[14] = binding;
         binding = new Binding(this,function():int
         {
            return this._logTab.selectedIndex < 3 ? 0 : this._logTab.selectedIndex - 2;
         },function(param1:int):void
         {
            _logStack.selectedIndex = param1;
         },"_logStack.selectedIndex");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._logTab.selectedIndex == 0 ? this.cache.logs : (this._logTab.selectedIndex == 1 ? this.cache.cityLogs.getItemAt(this._citiesTab.selectedIndex) : (this._logTab.selectedIndex == 2 ? this.cache.warLogs : this.cache.emptyStr));
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            logs.htmlText = param1;
         },"logs.htmlText");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "Clear all entries from the " + (this._logTab.selectedIndex == 0 ? "Main" : (this._logTab.selectedIndex == 1 ? "City" : "War")) + " Log";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _clearLogBtn.toolTip = param1;
         },"_clearLogBtn.toolTip");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "   RE for Age II: " + Version.getVersionStr();
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MainScreen_Label3.text = param1;
         },"_MainScreen_Label3.text");
         result[18] = binding;
         return result;
      }
      
      public function __refreshButton_click(param1:MouseEvent) : void
      {
         this.refresh();
      }
      
      [Bindable(event="propertyChange")]
      public function get _logTab() : TabBar
      {
         return this._1611115216_logTab;
      }
      
      private function armyToMsgString(param1:String, param2:ArmyBean) : String
      {
         var _loc3_:String = "<b>" + param1 + " to</b> " + this.currentPlayer.playerInfo.userName;
         if(param2.targetFieldId != -1)
         {
            _loc3_ += " <b>at</b> " + getCityFromFieldId(param2.targetFieldId).castle.name + "(" + Map.getX(param2.targetFieldId) + "," + Map.getY(param2.targetFieldId) + ")";
         }
         if(param2.king != null)
         {
            _loc3_ += " <b>by</b> " + param2.king;
         }
         if(param2.alliance != null)
         {
            _loc3_ += " <b>of</b> " + param2.alliance;
         }
         if(param2.startPosName != null)
         {
            _loc3_ += " <b>from</b> " + param2.startPosName;
         }
         if(param2.startFieldId != -1)
         {
            _loc3_ += "(" + Map.getX(param2.startFieldId) + "," + Map.getY(param2.startFieldId) + ")";
         }
         if(param2.hero != null)
         {
            _loc3_ += " <b>using hero</b> " + param2.hero;
         }
         if(param2.heroLevel > 0)
         {
            _loc3_ += "(" + param2.heroLevel + ")";
         }
         if(param2.troop != null)
         {
            _loc3_ += " <b>with troops</b> " + Utils.troopStrBeanToMsgString(param2.troop,true);
         }
         if(param2.reachTime > 0)
         {
            _loc3_ += " <b>arriving in</b> " + Utils.formatEndTime(param2.reachTime) + " <b>@</b> " + Utils.getServerEndTimeStr(param2.reachTime);
         }
         return _loc3_;
      }
      
      private function evtTroopUpdate(param1:TroopUpdate) : void
      {
         var _loc2_:CityState = getCityFromCastleId(param1.caslteId);
         if(_loc2_ != null)
         {
            _loc2_.castle.troop = param1.troop;
            _loc2_.cityManager.troopProductionUpdateNeeded = true;
         }
      }
      
      private function attemptSkypeLogin() : void
      {
         if(this.config.skypeUn.length > 0 && this.config.skypePw.length > 0)
         {
            Utils.callLater(1000,Skype.login,[this.config.skypeUn,this.config.skypePw,this.onSkypeLoginResponse]);
         }
      }
      
      private function evtPlayerInfoUpdate(param1:PlayerInfoUpdate) : void
      {
         this.updateMiscInfo(param1.playerInfo);
         this.currentPlayer.playerInfo = param1.playerInfo;
         param1 = null;
      }
      
      private function processEnemySkypeWarning(param1:TimerEvent = null) : void
      {
         var _loc13_:CityState = null;
         this.skypeWarningTimer.reset();
         if(getMainTownCityState() == null || this.currentPlayer == null || this.currentPlayer.enemyArmysArray.length == 0)
         {
            return;
         }
         var _loc2_:CityManager = getMainTownCityState().cityManager;
         var _loc3_:int = Math.max(_loc2_.getCfg(CityConfigs.CFG_SKYPEWARNING),30);
         var _loc4_:Array = _loc2_._getSkypeWarningReceivers();
         var _loc5_:String = null;
         var _loc6_:Array = _loc2_._getSkypeWarningPolicy();
         var _loc7_:Object = new Object();
         var _loc8_:Array = new Array();
         var _loc9_:int = 0;
         var _loc10_:Number = Number(new Date().getTime());
         var _loc11_:ArmyBean = null;
         var _loc12_:String = null;
         for each(_loc13_ in getCities())
         {
            for each(_loc11_ in _loc13_.cityManager.enemyArmies)
            {
               _loc12_ = "NEW ATTACK";
               if(this.skypeLastSendTimes[String(_loc11_.armyId)] != undefined)
               {
                  if(_loc10_ - this.skypeLastSendTimes[String(_loc11_.armyId)] < _loc3_ * 1000)
                  {
                     _loc7_[String(_loc11_.armyId)] = this.skypeLastSendTimes[String(_loc11_.armyId)];
                     continue;
                  }
                  _loc12_ = "ATTACK UPDATE";
               }
               if(!_loc13_.cityManager.isJunkTroop(_loc11_.troop))
               {
                  if(_loc6_[0])
                  {
                     _loc8_.push(this.armyToMsgString(_loc12_,_loc11_));
                     _loc7_[String(_loc11_.armyId)] = _loc10_;
                  }
               }
               else if(_loc6_[1])
               {
                  _loc8_.push(this.armyToMsgString(_loc12_,_loc11_));
                  _loc7_[String(_loc11_.armyId)] = _loc10_;
               }
               if(_loc8_.length >= 10)
               {
                  this.sendSkypeWarnings(_loc4_,_loc8_.join("\n"));
                  _loc8_ = new Array();
               }
            }
            for each(_loc11_ in _loc13_.cityManager.enemyValleyArmies)
            {
               _loc12_ = "NEW VALLEY ATTACK";
               if(this.skypeLastSendTimes[String(_loc11_.armyId)] != undefined)
               {
                  if(_loc10_ - this.skypeLastSendTimes[String(_loc11_.armyId)] < _loc3_ * 1000)
                  {
                     _loc7_[String(_loc11_.armyId)] = this.skypeLastSendTimes[String(_loc11_.armyId)];
                     continue;
                  }
                  _loc12_ = "VALLEY ATTACK UPDATE";
               }
               if(_loc6_[2])
               {
                  _loc8_.push(this.armyToMsgString(_loc12_,_loc11_));
                  _loc7_[String(_loc11_.armyId)] = _loc10_;
               }
               if(_loc8_.length >= 10)
               {
                  this.sendSkypeWarnings(_loc4_,_loc8_.join("\n"));
                  _loc8_ = new Array();
               }
            }
            for each(_loc11_ in _loc13_.cityManager.enemyColonyArmies)
            {
               _loc12_ = "NEW COLONY ATTACK";
               if(this.skypeLastSendTimes[String(_loc11_.armyId)] != undefined)
               {
                  if(_loc10_ - this.skypeLastSendTimes[String(_loc11_.armyId)] < _loc3_ * 1000)
                  {
                     _loc7_[String(_loc11_.armyId)] = this.skypeLastSendTimes[String(_loc11_.armyId)];
                     continue;
                  }
                  _loc12_ = "COLONY ATTACK UPDATE";
               }
               if(_loc6_[3])
               {
                  _loc8_.push(this.armyToMsgString(_loc12_,_loc11_));
                  _loc7_[String(_loc11_.armyId)] = _loc10_;
               }
               if(_loc8_.length >= 10)
               {
                  this.sendSkypeWarnings(_loc4_,_loc8_.join("\n"));
                  _loc8_ = new Array();
               }
            }
         }
         if(_loc8_.length > 0)
         {
            this.sendSkypeWarnings(_loc4_,_loc8_.join("\n"));
         }
         this.skypeLastSendTimes = _loc7_;
         this.skypeWarningTimer.start();
      }
      
      public function __logoutButton_click(param1:MouseEvent) : void
      {
         this.logoutNow();
      }
      
      public function cityLogMsg(param1:ScriptLogEvent) : void
      {
         this.showNewMsg("logs",param1.logText);
         this.showNewCityMsg(param1.logText,param1.logCity != null ? int(cities.indexOf(param1.logCity)) : 0);
      }
      
      public function refresh() : void
      {
         var handler:Function;
         var conn:Connection = null;
         var isPaused:Boolean = false;
         conn = Connection.getInstance();
         isPaused = conn.paused;
         if(!isPaused)
         {
            conn.paused = true;
         }
         conn.disconnect();
         handler = function():void
         {
            conn.connect();
            conn.paused = isPaused;
         };
         Utils.callLater(1500,handler);
      }
      
      private function logoutNow() : void
      {
         var _loc1_:Connection = Connection.getInstance();
         if(!_loc1_.reconnectTimer.running && !_loc1_.authenticated && _loc1_.paused)
         {
            return;
         }
         this.disableLogoutButton();
         _loc1_.reconnectTimer.stop();
         _loc1_.disconnect();
         getMainTownCityState().cityManager.logMsg("   <b>*** LOGOUT > Disconnected ***</b>","#AA0000");
         _loc1_.paused = true;
      }
      
      internal function getCityPanelBean(param1:int) : CityPanelBean
      {
         var _loc2_:CityPanelBean = null;
         for each(_loc2_ in this._cityPanelBeansArray.getChildren())
         {
            if(_loc2_.castleId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      [Bindable(event="propertyChange")]
      public function get pauseButton() : Button
      {
         return this._2003593416pauseButton;
      }
      
      private function onLogTabClick(param1:TabBar, param2:Object) : void
      {
         var _loc3_:Tab = null;
         for each(_loc3_ in param1.getChildren())
         {
            if(_loc3_ == param2)
            {
               _loc3_.setStyle("fontStyle","normal");
               _loc3_.setStyle("fontWeight","bold");
            }
            else
            {
               _loc3_.setStyle("fontWeight","normal");
            }
         }
         if(param1 == this._logTab && param1.selectedIndex < 3)
         {
            this.setScrollPos(this.logs);
         }
         else if(param1 == this._logTab && param1.selectedIndex == 3)
         {
            this._mapCanvas._centerMapOn(this.currentPlayer.castlesArray[this._citiesTab.selectedIndex].fieldId,true);
         }
      }
      
      public function getDistanceFromClosestCastle(param1:int) : Number
      {
         var _loc4_:CastleBean = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = 10000;
         for each(_loc4_ in this.currentPlayer.castlesArray)
         {
            _loc2_ = Map.fieldDistance(param1,_loc4_.fieldId);
            if(_loc2_ < _loc3_)
            {
               _loc3_ = _loc2_;
            }
         }
         return _loc3_;
      }
      
      private function onCityTabClick(param1:ItemClickEvent) : void
      {
         if(this._logTab.selectedIndex == 1)
         {
            this.setScrollPos(this.logs);
         }
         this._mapCanvas._centerMapOn(this.currentPlayer.castlesArray[param1.index].fieldId);
      }
      
      private function handleCastleFieldUpdate(param1:CastleFieldUpdate) : void
      {
         var _loc2_:CastleBean = null;
         var _loc3_:int = 0;
         var _loc4_:CityManager = null;
         var _loc5_:int = 0;
         if(this.currentPlayer == null || this.currentPlayer.castlesArray == null)
         {
            Utils.callLater(50,this.handleCastleFieldUpdate,[param1]);
         }
         else
         {
            _loc2_ = getCastle(param1.castleId);
            if(_loc2_ != null)
            {
               _loc3_ = 0;
               _loc4_ = getCityFromCastleId(param1.castleId).cityManager;
               _loc5_ = _loc4_.getCfg(CityConfigs.CFG_DEBUG);
               if(param1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
               {
                  if(_loc5_ > 0)
                  {
                     _loc4_.logMsg("DEBUG(" + _loc5_ + ") > Troop change on field " + Map.fieldIdToString(param1.bean.id),CityManager.COLR_DBG_LOG_MSG);
                  }
                  _loc3_ = 0;
                  if(_loc3_ < _loc2_.fieldsArray.length)
                  {
                     if(_loc2_.fieldsArray[_loc3_].id == param1.bean.id)
                     {
                        _loc2_.fieldsArray[_loc3_] = param1.bean;
                     }
                     return;
                  }
               }
               else if(param1.updateType == CommonConstants.UPDATE_TYPE_ADD)
               {
                  _loc4_.logMsg("Take field " + Map.fieldIdToString(param1.bean.id),CityManager.COLR_STD_LOG_MSG);
                  Map.updateDetailInfo(param1.bean.id);
                  if(!_loc4_.isValley(param1.bean.id))
                  {
                     _loc2_.fieldsArray.addItem(param1.bean);
                     Utils.sortFieldsByDistance(_loc2_);
                  }
                  _loc4_._onFieldUpdate_handleAtkEnemyFieldAndHunting(param1.bean.id);
               }
               else if(param1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
               {
                  if(_loc5_ > 0)
                  {
                     _loc4_.logMsg("DEBUG(" + _loc5_ + ") > Give up field " + Map.fieldIdToString(param1.bean.id),CityManager.COLR_DBG_LOG_MSG);
                  }
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_.fieldsArray.length)
                  {
                     if(_loc2_.fieldsArray[_loc3_].id == param1.bean.id)
                     {
                        _loc2_.fieldsArray.removeItemAt(_loc3_);
                        Map.updateDetailInfo(param1.bean.id);
                        return;
                     }
                     _loc3_++;
                  }
               }
               else
               {
                  _loc4_.logMsg("ignore castle field update " + param1.updateType + " on field (" + Map.getX(param1.bean.id) + "," + Map.getY(param1.bean.id) + ")",CityManager.COLR_STD_LOG_MSG);
               }
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _logStack() : ViewStack
      {
         return this._2093140739_logStack;
      }
      
      private function updateSelfArmies(param1:ArrayCollection) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.currentPlayer.selfArmysArray = param1;
         CityManager._updateOwnArmiesSeen(this.currentPlayer.selfArmysArray);
         this.updateLocalArmies();
      }
      
      private function evtSelfArmiesUpdate(param1:SelfArmysUpdate) : void
      {
         if(this.currentPlayer == null || this.currentPlayer.selfArmysArray == null)
         {
            Utils.callLater(50,this.evtSelfArmiesUpdate,[param1]);
         }
         else
         {
            this.updateSelfArmies(param1.armysArray);
         }
      }
      
      public function doCityTabLabel(param1:int) : void
      {
         this.doCityTabLabels(param1);
      }
      
      public function getSelectedCityIndex() : int
      {
         return this._citiesTab.selectedIndex;
      }
      
      public function init() : void
      {
         instance = this;
         var _loc1_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc1_.addEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.evtLogin);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.evtSelfArmiesUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE,this.evtFriendArmiesUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE,this.evtEnemyArmiesUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE,this.evtTroopUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.onHeroUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE,this.onResourceUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE,this.handleCastleFieldUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_CONNECTION_LOST,this.evtConnectionLost);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE,this.evtCastleUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_COLONY_UPDATE,this.evtColonyUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE,this.evtPlayerInfoUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_NEW_REPORT,this.evtNewReport);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_NEW_MAIL,this.evtNewMail);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.evtItemUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_PLAYER_BUFF_UPDATE,this.evtPlayerBuffUpdate);
         _loc1_.addEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_UPDATE,this.evtDeclaredWarsUpdate);
         this.loadCustomAudio();
         if(this.pausedLabelTimer == null)
         {
            this.pausedLabelTimer = new Timer(3000);
            this.pausedLabelTimer.addEventListener(TimerEvent.TIMER,this.modifyCtrlBtns);
         }
         if(this.pausedLabelTimer != null && !this.pausedLabelTimer.running)
         {
            this.pausedLabelTimer.start();
         }
         if(this.displayServerClockTimer == null)
         {
            this.displayServerClockTimer = new Timer(4995);
            this.displayServerClockTimer.addEventListener(TimerEvent.TIMER,this.topClockAndGiftUpdate);
         }
         if(this.checkForUpdatedVersionTimer == null)
         {
            this.checkForUpdatedVersionTimer = new Timer(3600000);
            this.checkForUpdatedVersionTimer.addEventListener(TimerEvent.TIMER,this.checkForUpdatedVersion);
         }
         if(this.checkForUpdatedVersionTimer != null && !this.checkForUpdatedVersionTimer.running)
         {
            this.checkForUpdatedVersionTimer.start();
         }
         if(this.skypeWarningTimer == null)
         {
            this.skypeWarningTimer = new Timer(30000);
            this.skypeWarningTimer.addEventListener(TimerEvent.TIMER,this.processEnemySkypeWarning);
         }
         Utils.callLater(50,Connection.getInstance().init);
         this.addEventListener(CityPanel.SAVEALLEVENT,this._cityPanel.onSaveAll);
         this.addEventListener(CityPanel.SETALLGOALS,this.onSetAllGoals);
         this.addEventListener(Snippets.SAVEALLEVENT,this._snippets.saveAll);
      }
      
      public function getSelectedCity() : CityState
      {
         return cities[this._citiesTab.selectedIndex] as CityState;
      }
      
      private function showNewMsg(param1:String, param2:String, param3:String = "#000000", param4:Boolean = false, param5:String = "") : void
      {
         var _loc7_:int = 0;
         this.cache[param1] += "<font color=\'" + (param3 != "#000000" ? param3 : "#006666") + "\'>" + (param4 ? param5 + "&lt;" + Utils.getChatTimeStr(Utils.getServerTime()) + "&gt;</font>" : Utils.getLogTimeStr(Utils.getServerTime(),param1 == "warLogs") + "</font> ") + "<font color=\'" + param3 + "\'>" + param2.replace(/\r\n?|\n|<br>/gi,"\n") + "</font>\n";
         var _loc6_:int = int(this.cache[param1].length);
         if(param1 == "logs" && _loc6_ > 128000 || param1 == "warLogs" && _loc6_ > 96000)
         {
            this.cache[param1] = this.cache[param1].substr(this.cache[param1].indexOf("\n",8000));
         }
         if(param1 == "logs" && this._logTab.selectedIndex != 0 && lastActive + 5 * 60 * 1000 < new Date().getTime())
         {
            this._logTab.selectedIndex = 0;
            Utils.callLater(50,this.onLogTabClick,[this._logTab,this._logTab.getChildAt(0)]);
         }
         else
         {
            _loc7_ = this._logTab.selectedIndex;
            if(_loc7_ == 0 && param1 == "logs" || _loc7_ == 2 && param1 == "warLogs")
            {
               this.setScrollPos(this.logs);
            }
         }
      }
      
      private function set cache(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._94416770cache;
         if(_loc2_ !== param1)
         {
            this._94416770cache = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cache",_loc2_,param1));
         }
      }
      
      public function uninit() : void
      {
         instance = null;
         var _loc1_:ResponseDispatcher = ResponseDispatcher.getInstance();
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_LOGIN_RESPONSE,this.evtLogin);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.evtSelfArmiesUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE,this.evtFriendArmiesUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE,this.evtEnemyArmiesUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_TROOP_UPDATE,this.evtTroopUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.onHeroUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE,this.onResourceUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CASTLE_FIELD_UPDATE,this.handleCastleFieldUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CONNECTION_LOST,this.evtConnectionLost);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_CASTLE_UPDATE,this.evtCastleUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_COLONY_UPDATE,this.evtColonyUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_PLAYER_INFO_UPDATE,this.evtPlayerInfoUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_NEW_REPORT,this.evtNewReport);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_NEW_MAIL,this.evtNewMail);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.evtItemUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_PLAYER_BUFF_UPDATE,this.evtPlayerBuffUpdate);
         _loc1_.removeEventListener(ResponseDispatcher.SERVER_DECLARED_WAR_UPDATE,this.evtDeclaredWarsUpdate);
         if(this.unpauseTimer != null)
         {
            this.unpauseTimer.stop();
            this.unpauseTimer.removeEventListener(TimerEvent.TIMER,this.onUnpauseTimer);
            this.unpauseTimer = null;
         }
         this.pausedLabelTimer.stop();
         this.pausedLabelTimer.removeEventListener(TimerEvent.TIMER,this.modifyCtrlBtns);
         this.pausedLabelTimer = null;
         if(this.skypeWarningTimer != null)
         {
            this.skypeWarningTimer.stop();
            this.skypeWarningTimer.removeEventListener(TimerEvent.TIMER,this.processEnemySkypeWarning);
         }
         this.displayServerClockTimer.stop();
         this.displayServerClockTimer.removeEventListener(TimerEvent.TIMER,this.topClockAndGiftUpdate);
         this.displayServerClockTimer = null;
         this.checkForUpdatedVersionTimer.stop();
         this.checkForUpdatedVersionTimer.removeEventListener(TimerEvent.TIMER,this.checkForUpdatedVersion);
         this.checkForUpdatedVersionTimer = null;
         this.removeEventListener(CityPanel.SAVEALLEVENT,this._cityPanel.onSaveAll);
         this.removeEventListener(CityPanel.SETALLGOALS,this.onSetAllGoals);
         this.removeEventListener(Snippets.SAVEALLEVENT,this._snippets.saveAll);
      }
      
      private function setLastActiveTime() : void
      {
         var _loc1_:Date = new Date();
         lastActive = _loc1_.getTime();
      }
      
      private function showNewCityMsg(param1:String, param2:int, param3:String = "#000000") : void
      {
         (this.cache.cityLogs as ArrayList).setItemAt(this.cache.cityLogs.getItemAt(param2) + "<font color=\'" + (param3 != "#444444" ? param3 : "#339999") + "\'>" + Utils.getLogTimeStr(Utils.getServerTime()) + "</font> <font color=\'" + param3 + "\'>" + param1.replace(/\r\n?|\n|<br>/gi,"\n") + "</font>\n",param2);
         if((this.cache.cityLogs as ArrayList).getItemAt(param2).length > 30000)
         {
            (this.cache.cityLogs as ArrayList).setItemAt((this.cache.cityLogs as ArrayList).getItemAt(param2).substr((this.cache.cityLogs as ArrayList).getItemAt(param2).indexOf("\n",4000)),param2);
         }
         this.cache.emptyStr = " ";
         this.cache.emptyStr = "";
         if(this._logTab.selectedIndex == 1 && this._citiesTab.selectedIndex == param2)
         {
            this.setScrollPos(this.logs);
         }
      }
      
      private function cityIsSuzerain(param1:CastleBean) : Boolean
      {
         var _loc2_:ColonyBean = null;
         for each(_loc2_ in param1.colonyBeansArray)
         {
            if(_loc2_.status != ColonyConstants.COLONY_STATUS_FREE && _loc2_.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
            {
               return false;
            }
         }
         return true;
      }
      
      private function isAnyEnemyArmyNotJunk(param1:ArrayCollection) : Boolean
      {
         var _loc2_:ArmyBean = null;
         for each(_loc2_ in param1)
         {
            if(!getCityFromFieldId(_loc2_.targetFieldId).cityManager.isJunkTroop(_loc2_.troop))
            {
               return true;
            }
         }
         return false;
      }
      
      private function newKeyDownEvent(param1:KeyboardEvent) : void
      {
         this.setLastActiveTime();
      }
      
      [Bindable(event="propertyChange")]
      public function get _MainScreen_VersionLabelBottom() : Label
      {
         return this._861376190_MainScreen_VersionLabelBottom;
      }
      
      private function initCityScript(param1:CityState) : void
      {
         param1._getScript().addEventListener(ScriptLogEvent.TYPE,this.cityLogMsg);
         param1.cityManager.addEventListener(ScriptLogEvent.TYPE,this.cityLogMsg);
         param1.cityManager.addEventListener(WarLogEvent.TYPE,this.warLogMsg);
         param1._getScript().addEventListener(StopScriptEvent.STOP_SCRIPT,this.onStopScriptEvent);
      }
      
      public function ___clearLogBtn_click(param1:MouseEvent) : void
      {
         this.clear(true,["logs","cityLogs","warLogs"][this._logTab.selectedIndex],true);
      }
      
      private function onStopScriptEvent(param1:StopScriptEvent) : void
      {
         var _loc2_:CityPanelBean = null;
         for each(_loc2_ in this._cityPanelBeansArray.getChildren())
         {
            if(_loc2_.castleId == param1.castleId)
            {
               _loc2_.scriptIsRunning = false;
               break;
            }
         }
      }
      
      private function processEnemyEmailWarning(param1:ArrayCollection, param2:int) : void
      {
      }
      
      public function ___MainScreen_Image1_click(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://roboev.webstarts.com"),"_blank");
      }
      
      [Bindable(event="propertyChange")]
      public function get logoutButton() : Button
      {
         return this._1255627100logoutButton;
      }
      
      public function evtLogin(param1:LoginResponse) : void
      {
         if(param1.ok != 1)
         {
            if(Version.isTraceOn())
            {
               trace(param1.errorMsg);
            }
            return;
         }
         this.currentPlayer = param1.player;
         Utils.setServerTime(this.currentPlayer.currentTime);
         Utils.setServerTimeZoneAdjust(this.currentPlayer.currentTime,this.currentPlayer.currentDateTime);
         var _loc2_:Date = new Date();
         _loc2_.setTime(Utils.getServerTime());
         Utils.setEstimatedServerTime(_loc2_.getTime());
         Utils.callLater(100,this.initReqs,[this.currentPlayer.castlesArray[0].id]);
         this.showNewMsg("logs","<b>Logged in successfully, server time difference: " + Utils.getServerLagTime() / 1000 + "s</b>");
         if(Math.abs(Utils.getServerLagTime()) > 5000)
         {
            this.showNewMsg("logs","<b>Your current computer time: " + Utils.getLogTimeStr(new Date().getTime()) + "</b>");
            this.showNewMsg("logs","<b>PLEASE AVOID ADJUSTING YOUR COMPUTER CLOCK WHILE THE BOT IS RUNNING! If you do adjust, be sure to click Refresh.</b>");
         }
         Map.initMap(this.currentPlayer.mapSizeX,this.currentPlayer.mapSizeY);
         this.topClockAndGiftUpdate();
         this.initCities();
         this.updateSelfArmies(param1.player.selfArmysArray);
         this.updateFriendlyArmies(param1.player.friendArmysArray);
         if(this._citiesTab.dataProvider == null)
         {
            this._citiesTab.dataProvider = this._cityPanelBeansArray;
            this._cityPanel.cityPanelBean = this._cityPanelBeansArray.getChildAt(0) as CityPanelBean;
            this._cityPanel.castleBean = this.currentPlayer.castlesArray.getItemAt(0) as CastleBean;
         }
         if(this.currentPlayer.isSetSecurityCode)
         {
            Utils.callLater(200,this.handleSecCode);
         }
         this.attemptSkypeLogin();
         this.updateMiscInfo(this.currentPlayer.playerInfo);
         this.topInfo.server = this.config.strserverAlias + " (" + this.config.server + ")";
         this.setWindowTitle(this.currentPlayer.playerInfo.userName + "(" + this.config.server + ") RE for Age II");
         if(this.displayServerClockTimer != null && !this.displayServerClockTimer.running)
         {
            this.displayServerClockTimer.start();
         }
         Utils.callLater(3000,this.checkForUpdatedVersion);
         this.updateEnemyArmies(param1.player.enemyArmysArray);
      }
      
      private function onUnlockSecOption(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.showNewMsg("logs","WARNING: Error received while temporarily unlocking security code options:  " + param1.errorMsg,"#CC0000");
         }
         else
         {
            this.showNewMsg("logs","SUCCESS: Security code accepted and temporarily unlocked. Normal operation can now continue.","#00006A");
         }
      }
      
      public function set logs(param1:TextArea) : void
      {
         var _loc2_:Object = this._3327407logs;
         if(_loc2_ !== param1)
         {
            this._3327407logs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"logs",_loc2_,param1));
         }
      }
      
      public function set topInfo(param1:TopInfo) : void
      {
         var _loc2_:Object = this._1140201565topInfo;
         if(_loc2_ !== param1)
         {
            this._1140201565topInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"topInfo",_loc2_,param1));
         }
      }
      
      private function evtCastleUpdate(param1:CastleUpdate) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:CityPanelBean = null;
         var _loc2_:CityState = null;
         var _loc3_:HeroBean = null;
         var _loc4_:int = 0;
         if(param1.updateType == CommonConstants.UPDATE_TYPE_UPDATE)
         {
            _loc4_ = 0;
            while(_loc4_ < this.currentPlayer.castlesArray.length)
            {
               if(this.currentPlayer.castlesArray[_loc4_].id == param1.castleBean.id)
               {
                  param1.castleBean.copyTo(this.currentPlayer.castlesArray[_loc4_] as CastleBean);
                  for each(_loc3_ in this.currentPlayer.castlesArray[_loc4_].herosArray)
                  {
                     Utils.formatHeroName(_loc3_);
                  }
                  Utils.sortFieldsByDistance(this.currentPlayer.castlesArray[_loc4_]);
                  getCityFromCastleId(param1.castleBean.id)._setCastleBean();
                  break;
               }
               _loc4_++;
            }
            Utils.callLater(50,this.doCityTabLabels,[int(param1.castleBean.id)]);
            Utils.callLater(50,this.doCityTabColors,[int(param1.castleBean.id)]);
         }
         else if(param1.updateType == CommonConstants.UPDATE_TYPE_ADD)
         {
            if(buildNpcEnabled && param1.castleBean.fieldId != CityManager.getBuildCityLocation() && param1.castleBean.buildingsArray.length <= 1 && (param1.castleBean.buildingsArray.length == 0 || param1.castleBean.buildingsArray[0].name == "Town Hall" && param1.castleBean.buildingsArray[0].level <= 1) && param1.castleBean.name == "Flat" && param1.castleBean.herosArray.length == 0 && param1.castleBean.resource.gold <= 5000 && param1.castleBean.resource.food.amount <= 5000 && param1.castleBean.resource.wood.amount <= 5000 && param1.castleBean.resource.stone.amount <= 5000 && param1.castleBean.resource.iron.amount <= 5000)
            {
               return;
            }
            _loc5_ = false;
            _loc4_ = 0;
            while(_loc4_ < this.currentPlayer.castlesArray.length)
            {
               if(this.currentPlayer.castlesArray[_loc4_].id == param1.castleBean.id)
               {
                  _loc5_ = true;
                  break;
               }
               _loc4_++;
            }
            if(!_loc5_)
            {
               this.currentPlayer.castlesArray.addItem(param1.castleBean);
               _loc2_ = new CityState(int(param1.castleBean.id));
               cities.push(_loc2_);
               _loc6_ = 0;
               if(_loc2_.castle.colonyBeansArray.length > 0)
               {
                  if(this.cityIsSuzerain(_loc2_.castle))
                  {
                     _loc6_ = CityPanelBean.ICON_TYPE_SUZ;
                  }
                  else
                  {
                     _loc6_ = CityPanelBean.ICON_TYPE_COL;
                  }
               }
               else
               {
                  _loc6_ = CityPanelBean.ICON_TYPE_NONE;
               }
               _loc7_ = new CityPanelBean(int(param1.castleBean.id),(param1.castleBean.name.length < 4 ? param1.castleBean.name : param1.castleBean.name.substring(0,3)) + Map.fieldIdToCoordString(param1.castleBean.fieldId),_loc6_);
               this._cityPanelBeansArray.addChild(_loc7_);
               this.initCityScript(_loc2_);
               _loc7_.onLoadGoals();
               _loc7_.onLoadScript(null,5000);
               Utils.callLater(50,this.doCityTabLabels,[int(param1.castleBean.id)]);
               Utils.callLater(50,this.doCityTabColors,[int(param1.castleBean.id)]);
            }
         }
         else if(param1.updateType == CommonConstants.UPDATE_TYPE_DELETE)
         {
            for each(_loc2_ in cities)
            {
               if(_loc2_.castleId == param1.castleBean.id)
               {
                  this.logMsg("  ***LOST CASTLE  " + _loc2_.castle.name + "  @  " + Map.fieldIdToCoordString(_loc2_.castle.fieldId),"#BB0000");
                  _loc2_.cityManager.onCityIsLost();
                  this.destroyCityObject(_loc2_);
               }
            }
         }
      }
      
      private function doCityTabColors(param1:int = -1) : void
      {
         var foundRoyal:Boolean = false;
         var deffillColors:Array = null;
         var defBgColor:int = 0;
         var colonyEventColors:Array = null;
         var colonyEventBgColor:int = 0;
         var royalPresentColors:Array = null;
         var royalPresentBgColor:int = 0;
         var underAttackColors:Array = null;
         var underAttackBgColor:int = 0;
         var colonyUnderAttackColors:Array = null;
         var colonyUnderAttackBgColor:int = 0;
         var arrCol:Array = null;
         var bgCol:int = 0;
         var tTip:String = null;
         var varStatusStr:String = null;
         var city:CityState = null;
         var cb:ColonyBean = null;
         var isAttack:Boolean = false;
         var cnt:int = 0;
         var a:ArmyBean = null;
         var tab:Tab = null;
         var doOneTab:Boolean = false;
         var len:int = 0;
         var i:int = 0;
         var h:HeroBean = null;
         var castleId:int = param1;
         try
         {
            foundRoyal = false;
            deffillColors = ThemeManager.getStyle(".REtabBarCitiesTab","fillColors");
            defBgColor = ThemeManager.getStyle(".REtabBarCitiesTab","backgroundColor");
            colonyEventColors = new Array(16759162,16745749,16761732,16748319);
            colonyEventBgColor = 16745749;
            royalPresentColors = new Array(6075757,3966026,6733687,4623956);
            royalPresentBgColor = 3966026;
            underAttackColors = new Array(16736866,13369344,16739436,14027274);
            underAttackBgColor = 13369344;
            colonyUnderAttackColors = new Array(16075081,11012618,16733011,11670548);
            colonyUnderAttackBgColor = 11012618;
            arrCol = new Array();
            tTip = "";
            varStatusStr = null;
            city = null;
            cb = null;
            isAttack = false;
            cnt = 0;
            a = null;
            doOneTab = castleId > -1;
            len = int(this._citiesTab.getChildren().length);
            i = 0;
            while(i < len)
            {
               city = cities[i] as CityState;
               if(!(doOneTab && castleId != city.castleId))
               {
                  tTip = "";
                  arrCol = deffillColors;
                  bgCol = defBgColor;
                  tab = this._citiesTab.getChildAt(i) as Tab;
                  if(!foundRoyal)
                  {
                     for each(h in city.cityManager.heroes)
                     {
                        if(h.isHero == 2)
                        {
                           tTip += h.name + " " + h.stamina + "\n";
                           arrCol = royalPresentColors;
                           bgCol = royalPresentBgColor;
                           foundRoyal = true;
                           break;
                        }
                     }
                  }
                  for each(cb in city.cityManager.colonies)
                  {
                     varStatusStr = "";
                     if(cb.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                     {
                        varStatusStr = cb.status == ColonyConstants.COLONY_STATUS_ATTACKING ? "is Colonizing" : (cb.status == ColonyConstants.COLONY_STATUS_UPRISING ? ", You are uprising" : "");
                        tTip += "Suzerain Info\n\nLord Name: " + cb.lordName + "\nLocation: " + cb.position + "\nAlliance: " + cb.allianceName + "\n" + varStatusStr + "\n";
                        if(cb.status == ColonyConstants.COLONY_STATUS_ATTACKING || cb.status == ColonyConstants.COLONY_STATUS_UPRISING)
                        {
                           if(cb.endTime != 0)
                           {
                              tTip += "Your City @(" + cb.position + ")\n  - In: " + Utils.formatEndTime(cb.endTime) + " @ " + Utils.getLogTimeStr(cb.endTime) + "\n";
                           }
                           arrCol = colonyEventColors;
                           bgCol = colonyEventBgColor;
                        }
                     }
                     else
                     {
                        varStatusStr = cb.status == ColonyConstants.COLONY_STATUS_ATTACKING ? "You are Colonizing" : (cb.status == ColonyConstants.COLONY_STATUS_UPRISING ? "They are uprising" : "");
                        if(cb.status == ColonyConstants.COLONY_STATUS_ATTACKING || cb.status == ColonyConstants.COLONY_STATUS_UPRISING)
                        {
                           if(cb.endTime != 0)
                           {
                              tTip += varStatusStr + " " + cb.lordName + " (" + cb.allianceName + ") @(" + cb.position + ")\n  - In: " + Utils.formatEndTime(cb.endTime) + " @ " + Utils.getLogTimeStr(cb.endTime) + "\n";
                           }
                           arrCol = colonyEventColors;
                           bgCol = colonyEventBgColor;
                        }
                     }
                  }
                  cnt = 0;
                  isAttack = false;
                  if(city.cityManager.enemyArmies != null && city.cityManager.enemyArmies.length > 0)
                  {
                     for each(a in city.cityManager.enemyArmies)
                     {
                        if(cnt++ >= 10)
                        {
                           break;
                        }
                        if(a.reachTime > 0 && a.reachTime - Utils.getServerTime() > 10 * 60 * 1000 && city.cityManager.isJunkTroop(a.troop))
                        {
                           tTip += "JunkWave Attack " + a.king + " [" + (a.alliance != null ? a.alliance : "none") + "] " + Map.fieldIdToCoordString(a.startFieldId) + "\n  Arrival Time: " + (a.reachTime > 0 ? " in " + Utils.formatEndTime(a.reachTime) + " @ " + Utils.getLogTimeStr(a.reachTime) + "\n troop: " + Utils.troopStrBeanToMsgString(a.troop) : "UNKNOWN \n" + Utils.troopStrBeanToMsgString(a.troop) + "\n---") + "\n";
                        }
                        else
                        {
                           tTip += "Attack " + a.king + " [" + (a.alliance != null ? a.alliance : "none") + "] " + Map.fieldIdToCoordString(a.startFieldId) + "\n  Arrival Time: " + (a.reachTime > 0 ? " in " + Utils.formatEndTime(a.reachTime) + " @ " + Utils.getLogTimeStr(a.reachTime) + "\n troop: " + Utils.troopStrBeanToMsgString(a.troop) : "UNKNOWN \n" + Utils.troopStrBeanToMsgString(a.troop) + "\n---") + "\n";
                        }
                        if(!isAttack)
                        {
                           arrCol = underAttackColors;
                           bgCol = underAttackBgColor;
                           isAttack = true;
                        }
                     }
                  }
                  if(city.cityManager.enemyColonyArmies != null && city.cityManager.enemyColonyArmies.length > 0)
                  {
                     for each(a in city.cityManager.enemyColonyArmies)
                     {
                        if(cnt++ >= 10)
                        {
                           break;
                        }
                        tTip += "Colony Attack " + a.king + " [" + (a.alliance != null ? a.alliance : "none") + "] " + Map.fieldIdToCoordString(a.startFieldId) + " => " + Map.fieldIdToCoordString(a.targetFieldId) + "\n" + (a.reachTime > 0 ? "  Arrival Time: " + " in " + Utils.formatEndTime(a.reachTime) + " @ " + Utils.getLogTimeStr(a.reachTime) : "  Arrival Time: UNKNOWN ") + "\n troop: " + Utils.troopStrBeanToMsgString(a.troop) + "\n";
                        if(!isAttack)
                        {
                           arrCol = colonyUnderAttackColors;
                           bgCol = colonyUnderAttackBgColor;
                           isAttack = true;
                        }
                     }
                  }
                  if(city.cityManager.enemyValleyArmies != null && city.cityManager.enemyValleyArmies.length > 0)
                  {
                     for each(a in city.cityManager.enemyValleyArmies)
                     {
                        if(cnt++ >= 10)
                        {
                           break;
                        }
                        tTip += "Valley Attack " + a.king + " [" + (a.alliance != null ? a.alliance : "none") + "] " + Map.fieldIdToCoordString(a.startFieldId) + " => " + Map.fieldIdToCoordString(a.targetFieldId) + "\n" + (a.reachTime > 0 ? "  Arrival Time: " + " in " + Utils.formatEndTime(a.reachTime) + " @ " + Utils.getLogTimeStr(a.reachTime) : "  Arrival Time: UNKNOWN ") + "\n troop: " + Utils.troopStrBeanToMsgString(a.troop) + "\n";
                        if(!isAttack)
                        {
                           arrCol = colonyUnderAttackColors;
                           bgCol = colonyUnderAttackBgColor;
                           isAttack = true;
                        }
                     }
                  }
                  if(arrCol.length >= 1)
                  {
                     tab.setStyle("fillColors",arrCol);
                     tab.setStyle("backgroundColor",bgCol);
                  }
                  tab.toolTip = tTip;
                  if(doOneTab)
                  {
                     break;
                  }
               }
               i++;
            }
         }
         catch(err:Error)
         {
         }
      }
      
      public function __pauseButton_click(param1:MouseEvent) : void
      {
         this.doPauseResume();
      }
      
      public function getEnemyArmies() : ArrayCollection
      {
         return this.currentPlayer.enemyArmysArray;
      }
      
      [Bindable(event="propertyChange")]
      public function get _clearLogBtn() : Button
      {
         return this._1882046310_clearLogBtn;
      }
      
      public function resetSkypeWarningTimer(param1:int) : void
      {
         this.skypeWarningTimer.stop();
         this.skypeWarningTimer.delay = param1 * 1000;
         this.processEnemySkypeWarning();
      }
      
      public function set _accountInfo(param1:AccountInfo) : void
      {
         var _loc2_:Object = this._243786428_accountInfo;
         if(_loc2_ !== param1)
         {
            this._243786428_accountInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_accountInfo",_loc2_,param1));
         }
      }
      
      public function ___MainScreen_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function set currentPlayer(param1:PlayerBean) : void
      {
         var _loc2_:Object = this._2145417798currentPlayer;
         if(_loc2_ !== param1)
         {
            this._2145417798currentPlayer = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"currentPlayer",_loc2_,param1));
         }
      }
      
      private function modifyCtrlBtns(param1:TimerEvent = null) : void
      {
         var _loc2_:String = Connection.getInstance().paused ? "Resume" : "Pause";
         if(this.pauseButton.label != _loc2_)
         {
            this.pauseButton.label = _loc2_;
            if(_loc2_ == "Pause")
            {
               this.pauseButton.setStyle("icon",PauseIcon);
            }
            if(_loc2_ == "Resume")
            {
               this.pauseButton.setStyle("icon",ResumeIcon);
            }
            if(_loc2_ == "Pause")
            {
               this.enableLogoutButton();
            }
         }
      }
      
      public function set _serverClockTimeField(param1:Label) : void
      {
         var _loc2_:Object = this._773017919_serverClockTimeField;
         if(_loc2_ !== param1)
         {
            this._773017919_serverClockTimeField = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_serverClockTimeField",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MainScreen = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MainScreen_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_MainScreenWatcherSetupUtil");
            watcherSetupUtilClass["init"](null);
         }
         _watcherSetupUtil.setup(this,function(param1:String):*
         {
            return target[param1];
         },bindings,watchers);
         i = 0;
         while(i < bindings.length)
         {
            Binding(bindings[i]).execute();
            i++;
         }
         mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
         mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      private function get cache() : ObjectProxy
      {
         return this._94416770cache;
      }
      
      public function logMsg(param1:String, param2:String = "#000000") : void
      {
         this.showNewMsg("logs",param1,param2);
      }
      
      public function set _cityPanelBeansArray(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1587488048_cityPanelBeansArray;
         if(_loc2_ !== param1)
         {
            this._1587488048_cityPanelBeansArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cityPanelBeansArray",_loc2_,param1));
         }
      }
      
      private function updateMiscInfo(param1:PlayerInfoBean) : void
      {
         if(this.currentPlayer.playerInfo.userName != param1.userName)
         {
            this.setWindowTitle(param1.userName + "(" + this.config.server + ") RE for Age II");
         }
         if((this.currentPlayer.playerInfo.alliance == null ? "" : this.currentPlayer.playerInfo.allianceLevel) != (param1.alliance == null ? "" : param1.allianceLevel))
         {
            if(param1.alliance != null)
            {
               if(this._accountInfo.allianceInfo.allianceDiplo != null)
               {
                  this._accountInfo.allianceInfo.allianceDiplo.setMemberLevel(param1.levelId);
               }
               if(this._accountInfo.allianceInfo.members != null)
               {
                  this._accountInfo.allianceInfo.members.setMemberLevel(param1.levelId);
               }
            }
         }
      }
      
      public function ___logTab_itemClick(param1:ItemClickEvent) : void
      {
         this.onLogTabClick(this._logTab,param1.relatedObject);
      }
      
      public function set pauseButton(param1:Button) : void
      {
         var _loc2_:Object = this._2003593416pauseButton;
         if(_loc2_ !== param1)
         {
            this._2003593416pauseButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"pauseButton",_loc2_,param1));
         }
      }
      
      private function evtEnemyArmiesUpdate(param1:EnemyArmysUpdate) : void
      {
         this.updateEnemyArmies(param1.armysArray);
      }
      
      [Bindable(event="propertyChange")]
      public function get topInfo() : TopInfo
      {
         return this._1140201565topInfo;
      }
      
      public function set _logTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._1611115216_logTab;
         if(_loc2_ !== param1)
         {
            this._1611115216_logTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_logTab",_loc2_,param1));
         }
      }
      
      public function set _cityPanel(param1:CityPanel) : void
      {
         var _loc2_:Object = this._1685431770_cityPanel;
         if(_loc2_ !== param1)
         {
            this._1685431770_cityPanel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cityPanel",_loc2_,param1));
         }
      }
      
      private function updateLocalArmies() : void
      {
         var _loc3_:CityState = null;
         var _loc4_:int = 0;
         var _loc5_:ArmyBean = null;
         var _loc1_:Array = new Array();
         var _loc2_:Array = new Array();
         for each(_loc3_ in cities)
         {
            _loc1_.push(_loc3_.castle.fieldId);
            _loc2_.push([]);
         }
         for each(_loc5_ in this.currentPlayer.selfArmysArray)
         {
            _loc4_ = int(_loc1_.indexOf(_loc5_.startFieldId));
            if(_loc4_ != -1)
            {
               (_loc2_[_loc4_] as Array).push(_loc5_);
            }
         }
         for each(_loc3_ in cities)
         {
            _loc3_.cityManager._updateLocalArmies(_loc2_[_loc1_.indexOf(_loc3_.castle.fieldId)] as Array);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get logs() : TextArea
      {
         return this._3327407logs;
      }
      
      [Bindable(event="propertyChange")]
      private function get currentPlayer() : PlayerBean
      {
         return this._2145417798currentPlayer;
      }
      
      private function onSetAllGoals(param1:Object = null) : void
      {
         var _loc2_:CastleBean = null;
         for each(_loc2_ in this.currentPlayer.castlesArray)
         {
            this._cityPanel.onSetGoals(_loc2_.id);
         }
      }
      
      public function get unpauseTimerIsRunning() : Boolean
      {
         return this.unpauseTimer != null && this.unpauseTimer.running;
      }
      
      private function onUnpauseTimer(param1:TimerEvent) : void
      {
         if(Connection.getInstance().paused)
         {
            this.doPauseResume();
         }
      }
      
      private function onSkypeLoginResponse(param1:SkypeResponse) : void
      {
         if(param1.ok == 1)
         {
            this.showNewMsg("logs",param1.msg);
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
      }
      
      private function processEnemyAudioWarning(param1:ArrayCollection, param2:Boolean) : void
      {
         var _loc6_:ArmyBean = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = new Array();
         var _loc5_:CityState = null;
         for each(_loc6_ in param1)
         {
            if(!(_loc4_[_loc6_.targetFieldId] || (_loc5_ = getCityFromFieldId(_loc6_.targetFieldId)) == null || _loc5_.cityManager.isJunkTroop(_loc6_.troop)))
            {
               _loc3_ = true;
               _loc4_[_loc6_.targetFieldId] = 1;
            }
         }
         if(param2)
         {
            if(_loc3_)
            {
               if(param1.length > 1)
               {
                  this.attackSeveralSound.play();
               }
               else
               {
                  this.attackSound.play();
               }
            }
            else if(this.lastWarningStatus)
            {
               this.attackEndedSound.play();
            }
         }
         this.lastWarningStatus = _loc3_;
         this.doCityTabColors();
      }
      
      [Bindable(event="propertyChange")]
      public function get _cityPanel() : CityPanel
      {
         return this._1685431770_cityPanel;
      }
      
      private function newMouseMoveEvent(param1:MouseEvent) : void
      {
         this.setLastActiveTime();
      }
      
      public function evtConnectionLost(param1:ConnectionLost) : void
      {
         var _loc2_:Array = new Array("Kicked by server","Server starting","Server shutting down","Another user has logged into your account","Server down for maintanence","Username not allowed","Too many frequent login attempts","Unknown reason for disconnect");
         this.showNewMsg("logs","<b>DISCONNECTED > " + _loc2_[param1.reasonCode < 0 || param1.reasonCode > 6 ? 7 : param1.reasonCode] + "</b>");
         var _loc3_:Number = getMainTownCityState() == null ? 1 : getMainTownCityState().cityManager._getReloginWaitCfg();
         if(param1.reasonCode == ConnectionLost.KICK_BY_OTHER && !Connection.getInstance().paused)
         {
            this.scheduleUnpauseTimer(Utils.rand((_loc3_ - 2) * 60 * 1000,(_loc3_ + 2) * 60 * 1000));
         }
         else if(param1.reasonCode == ConnectionLost.LOGIN_FREQUENTLY && !Connection.getInstance().paused)
         {
            this.scheduleUnpauseTimer(Utils.rand(15 * 60 * 1000,17 * 60 * 1000));
         }
         else if(param1.reasonCode != ConnectionLost.KICK_BY_OTHER && param1.reasonCode != ConnectionLost.LOGIN_FREQUENTLY && !Connection.getInstance().paused)
         {
            this.refresh();
         }
      }
      
      private function evtColonyUpdate(param1:ColonyUpdate) : void
      {
         var _loc2_:CastleBean = null;
         Utils.callLater(5000,this.processEnemyAudioWarning,[this.currentPlayer.enemyArmysArray,false]);
         for each(_loc2_ in this.currentPlayer.castlesArray)
         {
            if(_loc2_.id == param1.castleId)
            {
               _loc2_.colonyBeansArray = param1.colonyBeansArray;
               break;
            }
         }
         this.doCityTabLabel(param1.castleId);
         this.doCityTabColors(param1.castleId);
      }
      
      public function set refreshButton(param1:Button) : void
      {
         var _loc2_:Object = this._2033767917refreshButton;
         if(_loc2_ !== param1)
         {
            this._2033767917refreshButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"refreshButton",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get refreshButton() : Button
      {
         return this._2033767917refreshButton;
      }
      
      public function ___MainScreen_VBox1_mouseMove(param1:MouseEvent) : void
      {
         this.newMouseMoveEvent(param1);
      }
      
      private function evtItemUpdate(param1:ItemUpdate) : void
      {
         var _loc4_:ItemBean = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         for each(_loc4_ in param1.itemsArray)
         {
            _loc2_ = 0;
            _loc3_ = false;
            _loc5_ = 0;
            while(_loc5_ < this.currentPlayer.itemsArray.length)
            {
               if(this.currentPlayer.itemsArray[_loc5_].id == _loc4_.id)
               {
                  _loc3_ = true;
                  _loc2_ = int(this.currentPlayer.itemsArray[_loc5_].count);
                  if(_loc4_.count > 0)
                  {
                     this.currentPlayer.itemsArray[_loc5_] = _loc4_;
                     break;
                  }
                  this.currentPlayer.itemsArray.removeItemAt(_loc5_);
                  break;
               }
               _loc5_++;
            }
            if(!_loc3_)
            {
               this.currentPlayer.itemsArray.addItem(_loc4_);
            }
            getMainTownCityState().cityManager.logMsg("ITEM UPDATE >  " + (_loc4_.count - _loc2_ > 0 ? "+" : "") + (_loc4_.count - _loc2_) + " " + Items.getItemName(_loc4_.id) + ", new count " + _loc4_.count,"#00006A");
         }
      }
   }
}

