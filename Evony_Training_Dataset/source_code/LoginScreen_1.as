package autoevony.gui
{
   import autoevony.common.Utils;
   import autoevony.event.OnLoginEvent;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.themes.ThemeManager;
   import autoevony.player.LoginHelper;
   import com.adobe.net.proxies.ProxySocket;
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
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ComboBox;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class LoginScreen extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1826091151serverNumT:TextInput;
      
      public var _LoginScreen_Label10:Label;
      
      private var _646327716autoRun:CheckBox;
      
      private var _1216985755password:TextInput;
      
      private var _2084288539autoLoginMinTime:TextInput;
      
      private var _1127701075_proxyHostInput:TextInput;
      
      private var _1039690024notice:Label;
      
      private var _65589314_proxyUnInput:TextInput;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _398369958autoScript:CheckBox;
      
      private var _109422308_AutoEvony2_VersionLabel:Label;
      
      private var _625163220_skypePwInput:TextInput;
      
      private var _1990880759autoLoginMaxTime:TextInput;
      
      private var delay:int;
      
      private var _1132676506_themeSelect:ComboBox;
      
      mx_internal var _watchers:Array = [];
      
      private var _1377687758button:Button;
      
      private var _265713450username:TextInput;
      
      private var _1461600075_proxySelect:ComboBox;
      
      private var _958099744_loginTypeSelect:ComboBox;
      
      private var _1643599610autoLogin:CheckBox;
      
      private var _1594434776proxySelectInfo:ArrayCollection = new ArrayCollection([{
         "label":"none",
         "data":""
      },{
         "label":"HTTP",
         "data":ProxySocket.PROXY_TYPE_HTTP
      },{
         "label":"SOCKS4",
         "data":ProxySocket.PROXY_TYPE_SOCKS4
      },{
         "label":"SOCKS5",
         "data":ProxySocket.PROXY_TYPE_SOCKS5
      }]);
      
      private var _740274470_skypeUnInput:TextInput;
      
      private var _180700564_proxyPwInput:TextInput;
      
      private var _1968786910secCode:TextInput;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var autoTimer:Timer = null;
      
      public var cmdLineParamStr:String = "";
      
      private var _1334536422_proxyPortInput:TextInput;
      
      private var _1655281043loginTypeSelectInfo:ArrayCollection = new ArrayCollection([{
         "label":"evony.com (recommended)",
         "data":"ev"
      },{
         "label":"facebook.com (beta)",
         "data":"fb"
      }]);
      
      public var _LoginScreen_Label7:Label;
      
      public var _LoginScreen_Label8:Label;
      
      public var _LoginScreen_Label9:Label;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":950,
               "height":600,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.horizontalCenter = "0";
                     this.verticalCenter = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":850,
                        "height":450,
                        "styleName":"REmainLoginForm",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "30";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Login Type:",
                                 "enabled":true,
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ComboBox,
                           "id":"_loginTypeSelect",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "30";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":200,
                                 "height":22,
                                 "enabled":true,
                                 "styleName":"ComboBox"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "60";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Username:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"username",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "60";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "styleName":"textInput",
                                 "toolTip":"Enter your evony.com login email."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "90";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Password:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"password",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "90";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "displayAsPassword":true,
                                 "styleName":"textInput",
                                 "toolTip":"Enter your evony.com login password."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "120";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Security Code:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"secCode",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "120";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "displayAsPassword":true,
                                 "maxChars":10,
                                 "styleName":"textInput",
                                 "toolTip":"Enter your security code. Leave blank if you do not have one."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "150";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Server Num:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"serverNumT",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "150";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "maxChars":6,
                                 "styleName":"textInput",
                                 "toolTip":"Enter your server number.  Ex: na61"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "430";
                              this.top = "60";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Proxy Type:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ComboBox,
                           "id":"_proxySelect",
                           "stylesFactory":function():void
                           {
                              this.left = "550";
                              this.top = "60";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":100,
                                 "height":22,
                                 "styleName":"ComboBox"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_LoginScreen_Label7",
                           "stylesFactory":function():void
                           {
                              this.left = "670";
                              this.top = "60";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":50,
                                 "text":"Port:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_proxyPortInput",
                           "stylesFactory":function():void
                           {
                              this.left = "730";
                              this.top = "60";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":70,
                                 "text":"8080",
                                 "restrict":"0-9",
                                 "styleName":"textInput",
                                 "toolTip":"Enter the port number for the proxy server."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_LoginScreen_Label8",
                           "stylesFactory":function():void
                           {
                              this.left = "430";
                              this.top = "90";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"IP/HostName:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_proxyHostInput",
                           "stylesFactory":function():void
                           {
                              this.left = "550";
                              this.top = "90";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "restrict":"a-zA-Z0-9.-",
                                 "styleName":"textInput",
                                 "toolTip":"Enter the IP address or host name for the proxy server."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_LoginScreen_Label9",
                           "stylesFactory":function():void
                           {
                              this.left = "430";
                              this.top = "120";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Username:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_proxyUnInput",
                           "stylesFactory":function():void
                           {
                              this.left = "550";
                              this.top = "120";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "styleName":"textInput",
                                 "toolTip":"Enter the username for the proxy server if it requires authentication."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_LoginScreen_Label10",
                           "stylesFactory":function():void
                           {
                              this.left = "430";
                              this.top = "150";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Password:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_proxyPwInput",
                           "stylesFactory":function():void
                           {
                              this.left = "550";
                              this.top = "150";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "styleName":"textInput",
                                 "toolTip":"Enter the password for the proxy server if it requires authentication."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.top = "186";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":2,
                                 "styleName":"horizontalSeparator2pxLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "200";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Auto Goals:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"autoRun",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "200";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"REtoggleBox",
                                 "toolTip":"Enable set all goals upon successful login"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "240";
                              this.top = "200";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Auto Scripts:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"autoScript",
                           "stylesFactory":function():void
                           {
                              this.left = "360";
                              this.top = "200";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"REtoggleBox",
                                 "toolTip":"Enable run all scripts upon successful login.\r[experienced users only, use caution]"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.top = "236";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":2,
                                 "styleName":"horizontalSeparator2pxLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "30";
                              this.top = "250";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":110,
                                 "text":"Auto Login:",
                                 "styleName":"REmainFormText",
                                 "toolTip":"Enable automatic login."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":CheckBox,
                           "id":"autoLogin",
                           "events":{"change":"__autoLogin_change"},
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "250";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"styleName":"REtoggleBox"};
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "190";
                              this.top = "250";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":70,
                                 "text":"min:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"autoLoginMinTime",
                           "stylesFactory":function():void
                           {
                              this.left = "270";
                              this.top = "250";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":50,
                                 "text":"1",
                                 "restrict":"0-9",
                                 "enabled":true,
                                 "styleName":"textInput",
                                 "toolTip":"Enter the minimum delay in seconds for automatic login."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "320";
                              this.top = "250";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":70,
                                 "text":"max:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"autoLoginMaxTime",
                           "stylesFactory":function():void
                           {
                              this.left = "400";
                              this.top = "250";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":50,
                                 "text":"600",
                                 "restrict":"0-9",
                                 "enabled":true,
                                 "styleName":"textInput",
                                 "toolTip":"Enter the maximum delay in seconds for automatic login."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"button",
                           "events":{"click":"__button_click"},
                           "stylesFactory":function():void
                           {
                              this.right = "50";
                              this.top = "250";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "minWidth":75,
                                 "label":"Login",
                                 "styleName":"REwinBtn",
                                 "toolTip":"Login to the server and begin managing all aspects of your towns and account now!"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.top = "286";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":2,
                                 "styleName":"horizontalSeparator2pxLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "10";
                              this.top = "300";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":130,
                                 "text":"Skype Username:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_skypeUnInput",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "300";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "styleName":"textInput",
                                 "toolTip":"Optional, but necessary to use the automated skype warning features."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "stylesFactory":function():void
                           {
                              this.left = "10";
                              this.top = "330";
                              this.textAlign = "right";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":130,
                                 "text":"Skype Password:",
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":TextInput,
                           "id":"_skypePwInput",
                           "stylesFactory":function():void
                           {
                              this.left = "150";
                              this.top = "330";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":250,
                                 "displayAsPassword":true,
                                 "styleName":"textInput",
                                 "toolTip":"Enter the password for the Skype username entered above."
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.top = "366";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":2,
                                 "styleName":"horizontalSeparator2pxLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"notice",
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.bottom = "50";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "styleName":"REmainFormText"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.left = "20";
                              this.right = "20";
                              this.bottom = "40";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":2,
                                 "styleName":"horizontalSeparator2pxLine"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Label,
                           "id":"_AutoEvony2_VersionLabel",
                           "stylesFactory":function():void
                           {
                              this.bottom = "10";
                              this.textAlign = "center";
                              this.color = 16777215;
                              this.fontFamily = "DejaVu Sans";
                              this.fontSize = 10;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {"percentWidth":100};
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":ComboBox,
                  "id":"_themeSelect",
                  "events":{"change":"___themeSelect_change"},
                  "stylesFactory":function():void
                  {
                     this.right = "35";
                     this.bottom = "25";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":180,
                        "height":22,
                        "enabled":true,
                        "styleName":"ComboBox"
                     };
                  }
               })]
            };
         }
      });
      
      private var _1406231949themeSelectInfo:Array = ThemeManager.themes.themeList;
      
      public function LoginScreen()
      {
         super();
         mx_internal::_document = this;
         this.width = 950;
         this.height = 600;
         this.minWidth = 680;
         this.minHeight = 580;
         this.addEventListener("creationComplete",this.___LoginScreen_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         LoginScreen._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get autoLogin() : CheckBox
      {
         return this._1643599610autoLogin;
      }
      
      private function set proxySelectInfo(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1594434776proxySelectInfo;
         if(_loc2_ !== param1)
         {
            this._1594434776proxySelectInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"proxySelectInfo",_loc2_,param1));
         }
      }
      
      private function init() : void
      {
         this.getSettings();
      }
      
      [Bindable(event="propertyChange")]
      public function get autoLoginMinTime() : TextInput
      {
         return this._2084288539autoLoginMinTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get _proxyPortInput() : TextInput
      {
         return this._1334536422_proxyPortInput;
      }
      
      public function __button_click(param1:MouseEvent) : void
      {
         this.onStartBtn();
      }
      
      public function set _proxyPwInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._180700564_proxyPwInput;
         if(_loc2_ !== param1)
         {
            this._180700564_proxyPwInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_proxyPwInput",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get button() : Button
      {
         return this._1377687758button;
      }
      
      public function set _proxyPortInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1334536422_proxyPortInput;
         if(_loc2_ !== param1)
         {
            this._1334536422_proxyPortInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_proxyPortInput",_loc2_,param1));
         }
      }
      
      public function set password(param1:TextInput) : void
      {
         var _loc2_:Object = this._1216985755password;
         if(_loc2_ !== param1)
         {
            this._1216985755password = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"password",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _skypePwInput() : TextInput
      {
         return this._625163220_skypePwInput;
      }
      
      [Bindable(event="propertyChange")]
      public function get _proxyUnInput() : TextInput
      {
         return this._65589314_proxyUnInput;
      }
      
      [Bindable(event="propertyChange")]
      public function get _proxySelect() : ComboBox
      {
         return this._1461600075_proxySelect;
      }
      
      [Bindable(event="propertyChange")]
      public function get _proxyHostInput() : TextInput
      {
         return this._1127701075_proxyHostInput;
      }
      
      public function set _skypePwInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._625163220_skypePwInput;
         if(_loc2_ !== param1)
         {
            this._625163220_skypePwInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_skypePwInput",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get autoRun() : CheckBox
      {
         return this._646327716autoRun;
      }
      
      [Bindable(event="propertyChange")]
      public function get autoScript() : CheckBox
      {
         return this._398369958autoScript;
      }
      
      public function set button(param1:Button) : void
      {
         var _loc2_:Object = this._1377687758button;
         if(_loc2_ !== param1)
         {
            this._1377687758button = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"button",_loc2_,param1));
         }
      }
      
      private function onAutoLoginChange(param1:Boolean = false) : void
      {
         if(this.autoLogin.selected)
         {
            this.onAutoLogin();
         }
         else
         {
            if(param1)
            {
               this.autoLoginMinTime.enabled = true;
            }
            this.autoLoginMaxTime.enabled = true;
            this.cancelAutoLogin();
         }
      }
      
      private function _LoginScreen_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.loginTypeSelectInfo;
         },function(param1:Object):void
         {
            _loginTypeSelect.dataProvider = param1;
         },"_loginTypeSelect.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Object
         {
            return this.proxySelectInfo;
         },function(param1:Object):void
         {
            _proxySelect.dataProvider = param1;
         },"_proxySelect.dataProvider");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex != 0;
         },function(param1:Boolean):void
         {
            _LoginScreen_Label7.enabled = param1;
         },"_LoginScreen_Label7.enabled");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex != 0;
         },function(param1:Boolean):void
         {
            _proxyPortInput.enabled = param1;
         },"_proxyPortInput.enabled");
         result[3] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex != 0;
         },function(param1:Boolean):void
         {
            _LoginScreen_Label8.enabled = param1;
         },"_LoginScreen_Label8.enabled");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex != 0;
         },function(param1:Boolean):void
         {
            _proxyHostInput.enabled = param1;
         },"_proxyHostInput.enabled");
         result[5] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex == 3;
         },function(param1:Boolean):void
         {
            _LoginScreen_Label9.enabled = param1;
         },"_LoginScreen_Label9.enabled");
         result[6] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex == 3;
         },function(param1:Boolean):void
         {
            _proxyUnInput.enabled = param1;
         },"_proxyUnInput.enabled");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex == 3;
         },function(param1:Boolean):void
         {
            _LoginScreen_Label10.enabled = param1;
         },"_LoginScreen_Label10.enabled");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._proxySelect.selectedIndex == 3;
         },function(param1:Boolean):void
         {
            _proxyPwInput.enabled = param1;
         },"_proxyPwInput.enabled");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._skypeUnInput.text.length > 0;
         },function(param1:Boolean):void
         {
            _skypePwInput.enabled = param1;
         },"_skypePwInput.enabled");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            notice.text = param1;
         },"notice.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "RE for Age II: " + Version.getVersionStr() + " - running on: Flash Player " + (Utils.isFlashDebugPlayer() ? "Debugger " : " ") + Utils.getFlashPlayerType();
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AutoEvony2_VersionLabel.text = param1;
         },"_AutoEvony2_VersionLabel.text");
         result[12] = binding;
         binding = new Binding(this,function():Object
         {
            return this.themeSelectInfo;
         },function(param1:Object):void
         {
            _themeSelect.dataProvider = param1;
         },"_themeSelect.dataProvider");
         result[13] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get serverNumT() : TextInput
      {
         return this._1826091151serverNumT;
      }
      
      [Bindable(event="propertyChange")]
      private function get themeSelectInfo() : Array
      {
         return this._1406231949themeSelectInfo;
      }
      
      [Bindable(event="propertyChange")]
      private function get loginTypeSelectInfo() : ArrayCollection
      {
         return this._1655281043loginTypeSelectInfo;
      }
      
      public function __autoLogin_change(param1:Event) : void
      {
         this.onAutoLoginChange(true);
      }
      
      [Bindable(event="propertyChange")]
      public function get _themeSelect() : ComboBox
      {
         return this._1132676506_themeSelect;
      }
      
      public function set _proxyUnInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._65589314_proxyUnInput;
         if(_loc2_ !== param1)
         {
            this._65589314_proxyUnInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_proxyUnInput",_loc2_,param1));
         }
      }
      
      private function onSetTheme(param1:String) : void
      {
         ThemeManager.loadTheme(null,param1);
      }
      
      private function delayedInit(param1:Object = null) : void
      {
         var _loc2_:SharedObject = SharedObject.getLocal("config");
         var _loc3_:LoginHelper = new LoginHelper(_loc2_.data.now);
         if(param1 != null && param1.theme != undefined)
         {
            this._themeSelect.selectedIndex = this.themeSelectInfo.indexOf(param1.theme) != -1 ? int(this.themeSelectInfo.indexOf(param1.theme)) : 0;
         }
         else
         {
            this._themeSelect.selectedIndex = this.themeSelectInfo.indexOf(_loc3_.theme) != -1 ? int(this.themeSelectInfo.indexOf(_loc3_.theme)) : 0;
         }
         if(param1 != null && param1.logintype != undefined)
         {
            this._loginTypeSelect.selectedIndex = param1.logintype == "ev" ? 0 : (param1.logintype == "fb" ? 1 : 0);
         }
         else
         {
            this._loginTypeSelect.selectedIndex = _loc3_.loginType == "ev" ? 0 : (_loc3_.loginType == "fb" ? 1 : 0);
         }
         this.username.text = param1 != null && param1.username != undefined ? param1.username : _loc3_.username;
         this.password.text = param1 != null && param1.password != undefined ? param1.password : _loc3_.password;
         this.secCode.text = param1 != null && param1.seccode != undefined ? param1.seccode : _loc3_.secCode;
         this.serverNumT.text = param1 != null && param1.server != undefined ? param1.server : _loc3_.server;
         this.autoRun.selected = param1 != null && param1.autogoals != undefined ? Boolean(param1.autogoals) : _loc3_.autoRun;
         this.autoScript.selected = param1 != null && param1.autoscripts != undefined ? Boolean(param1.autoscripts) : _loc3_.autoScript;
         this.autoLogin.selected = param1 != null && param1.autologin != undefined ? Boolean(param1.autologin) : _loc3_.autoLogin;
         this._skypeUnInput.text = param1 != null && param1.skypeun != undefined ? param1.skypeun : _loc3_.skypeUn;
         this._skypePwInput.text = param1 != null && param1.skypepw != undefined ? param1.skypepw : _loc3_.skypePw;
         if(param1 != null && param1.proxytype != undefined)
         {
            if(param1.proxytype == ProxySocket.PROXY_TYPE_HTTP)
            {
               this._proxySelect.selectedIndex = 1;
            }
            if(param1.proxytype == ProxySocket.PROXY_TYPE_SOCKS4)
            {
               this._proxySelect.selectedIndex = 2;
            }
            if(param1.proxytype == ProxySocket.PROXY_TYPE_SOCKS5)
            {
               this._proxySelect.selectedIndex = 3;
            }
         }
         else if(Boolean(_loc3_.proxyType) && _loc3_.proxyType != null)
         {
            if(_loc3_.proxyType == ProxySocket.PROXY_TYPE_HTTP)
            {
               this._proxySelect.selectedIndex = 1;
            }
            if(_loc3_.proxyType == ProxySocket.PROXY_TYPE_SOCKS4)
            {
               this._proxySelect.selectedIndex = 2;
            }
            if(_loc3_.proxyType == ProxySocket.PROXY_TYPE_SOCKS5)
            {
               this._proxySelect.selectedIndex = 3;
            }
         }
         if(param1 != null && param1.proxyport != undefined)
         {
            this._proxyPortInput.text = param1.proxyport;
         }
         else if(Boolean(_loc3_.proxyPort) && _loc3_.proxyPort != null)
         {
            this._proxyPortInput.text = _loc3_.proxyPort;
         }
         if(param1 != null && param1.proxyhost != undefined)
         {
            this._proxyHostInput.text = param1.proxyhost;
         }
         else if(Boolean(_loc3_.proxyHost) && _loc3_.proxyHost != null)
         {
            this._proxyHostInput.text = _loc3_.proxyHost;
         }
         if(param1 != null && param1.proxyun != undefined)
         {
            this._proxyUnInput.text = param1.proxyun;
         }
         else if(Boolean(_loc3_.proxyUn) && _loc3_.proxyUn != null)
         {
            this._proxyUnInput.text = _loc3_.proxyUn;
         }
         if(param1 != null && param1.proxypw != undefined)
         {
            this._proxyPwInput.text = param1.proxypw;
         }
         else if(Boolean(_loc3_.proxyPw) && _loc3_.proxyPw != null)
         {
            this._proxyPwInput.text = _loc3_.proxyPw;
         }
         if(param1 != null && param1.autologinmintime != undefined)
         {
            this.autoLoginMinTime.text = param1.autologinmintime;
         }
         else if(_loc3_.autoLoginMinTime != null && _loc3_.autoLoginMinTime != "")
         {
            this.autoLoginMinTime.text = _loc3_.autoLoginMinTime;
         }
         if(param1 != null && param1.autologinmaxtime != undefined)
         {
            this.autoLoginMaxTime.text = param1.autologinmaxtime;
         }
         else if(_loc3_.autoLoginMaxTime != null && _loc3_.autoLoginMaxTime != "")
         {
            this.autoLoginMaxTime.text = _loc3_.autoLoginMaxTime;
         }
         if(this.autoLogin.selected)
         {
            this.onAutoLogin();
         }
         this.onSetTheme(this.themeSelectInfo[this._themeSelect.selectedIndex]);
      }
      
      private function autoTimerHandler(param1:TimerEvent) : void
      {
         --this.delay;
         if(this.delay <= 0)
         {
            this.autoTimer.stop();
            this.autoTimer.removeEventListener(TimerEvent.TIMER,this.autoTimerHandler);
            this.autoTimer = null;
            this.button.label = "Login";
            this.button.toolTip = "Login to the server and begin managing your account now!";
            this.notice.text = "";
            this.onStartBtn();
         }
         else
         {
            this.notice.text = Utils.getLogTimeStr(new Date().getTime()) + ": Auto start in " + this.delay + " seconds...";
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:LoginScreen = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._LoginScreen_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_LoginScreenWatcherSetupUtil");
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
      
      private function getSettings() : void
      {
         var onCompleteHandler:Function = null;
         var loader:URLLoader = null;
         onCompleteHandler = function(param1:Event):void
         {
            var _loc9_:String = null;
            loader.removeEventListener(Event.COMPLETE,onCompleteHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR,onCompleteHandler);
            var _loc2_:URLLoader = URLLoader(param1.target);
            var _loc3_:String = _loc2_.data;
            var _loc4_:URLVariables = new URLVariables(_loc3_.replace(/\r\n?|\n/g,""));
            var _loc5_:Array = ["logintype","username","password","seccode","server","proxytype","proxyport","proxyhost","proxyun","proxypw","autogoals","autoscripts","autologin","autologinmintime","autologinmaxtime","skypeun","skypepw","theme"];
            var _loc6_:Object = new Object();
            var _loc7_:String = null;
            var _loc8_:String = null;
            for(_loc9_ in _loc4_)
            {
               if(Version.isTraceOn())
               {
                  trace(Utils.trim(_loc9_.replace(/\r\n?|\n/g,"")).toLowerCase() + " = " + Utils.trim(_loc4_[_loc9_].replace(/\r\n?|\n/g,"")) + ";");
               }
               if(_loc5_.indexOf(_loc7_ = Utils.trim(_loc9_.replace(/\r\n?|\n/g,"")).toLowerCase()) != -1 && (_loc8_ = Utils.trim(_loc4_[_loc9_].replace(/\r\n?|\n/g,""))) != "")
               {
                  _loc6_[_loc7_] = _loc8_.toLowerCase() == "true" ? true : (_loc8_.toLowerCase() == "false" ? false : _loc8_);
               }
            }
            delayedInit(_loc6_);
         };
         var onIoErrorHandler:Function = function(param1:IOErrorEvent):void
         {
            loader.removeEventListener(Event.COMPLETE,onCompleteHandler);
            loader.removeEventListener(IOErrorEvent.IO_ERROR,onCompleteHandler);
            if(Version.isTraceOn())
            {
               trace("Missing or inappropriately named login.cfg file.");
            }
            delayedInit();
         };
         var req:URLRequest = new URLRequest("login.cfg");
         loader = new URLLoader();
         loader.dataFormat = URLLoaderDataFormat.VARIABLES;
         loader.addEventListener(Event.COMPLETE,onCompleteHandler);
         loader.addEventListener(IOErrorEvent.IO_ERROR,onIoErrorHandler);
         try
         {
            loader.load(req);
         }
         catch(error:ArgumentError)
         {
            if(Version.isTraceOn())
            {
               trace("An ArgumentError has occurred while loading login.cfg file.");
            }
            delayedInit();
         }
         catch(error:SecurityError)
         {
            if(Version.isTraceOn())
            {
               trace("A SecurityError has occurred while loading login.cfg file.");
            }
            delayedInit();
         }
         catch(error:Error)
         {
            if(Version.isTraceOn())
            {
               trace("Unable to load login.cfg file: " + error);
            }
            delayedInit();
         }
      }
      
      public function set _proxySelect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1461600075_proxySelect;
         if(_loc2_ !== param1)
         {
            this._1461600075_proxySelect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_proxySelect",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get password() : TextInput
      {
         return this._1216985755password;
      }
      
      [Bindable(event="propertyChange")]
      public function get _proxyPwInput() : TextInput
      {
         return this._180700564_proxyPwInput;
      }
      
      private function cancelAutoLogin() : Boolean
      {
         if(this.autoTimer != null)
         {
            this.autoTimer.stop();
            this.notice.text = "";
            this.autoTimer.addEventListener(TimerEvent.TIMER,this.autoTimerHandler);
            this.autoTimer = null;
            this.button.label = "Login";
            this.button.toolTip = "Login to the server and begin managing your account now!";
            return true;
         }
         return false;
      }
      
      public function onStartBtn() : void
      {
         if(this.cancelAutoLogin())
         {
            return;
         }
         var _loc1_:String = null;
         if(Utils.trim(this.username.text) == "")
         {
            _loc1_ = "The Username field cannot be blank.";
         }
         else if(Utils.trim(this.password.text) == "")
         {
            _loc1_ = "The Password field cannot be blank.";
         }
         else if(Utils.trim(this.serverNumT.text) == "")
         {
            _loc1_ = "The Server Num field cannot be blank.";
         }
         else if(this._proxySelect.selectedIndex > 0 && (Utils.trim(this._proxyPortInput.text) == "" || this._proxyPortInput.text == "0"))
         {
            _loc1_ = "The Port field cannot be blank if a proxy type has been selected.";
         }
         else if(this._proxySelect.selectedIndex > 0 && Utils.trim(this._proxyHostInput.text) == "")
         {
            _loc1_ = "The IP/HostName field cannot be blank if a proxy type has been selected.";
         }
         if(_loc1_)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,_loc1_));
            return;
         }
         var _loc2_:String = "";
         var _loc3_:RegExp = new RegExp("(http://)?(www\\.)?([^.]+)\\.?.*");
         var _loc4_:Object = _loc3_.exec(this.serverNumT.text);
         if(_loc4_ == null || _loc4_.length < 4 || _loc4_[3].length == 0)
         {
            this.notice.text = "Unable to find the server id from " + this.serverNumT.text;
            return;
         }
         this.serverNumT.text = _loc2_ = _loc4_[3];
         this.username.text = Utils.trim(this.username.text);
         this.password.text = Utils.trim(this.password.text);
         this._proxyPortInput.text = Utils.trim(this._proxyPortInput.text);
         this._proxyHostInput.text = Utils.trim(this._proxyHostInput.text);
         this._proxyUnInput.text = Utils.trim(this._proxyUnInput.text);
         this._proxyPwInput.text = Utils.trim(this._proxyPwInput.text);
         this.button.enabled = false;
         var _loc5_:Boolean = dispatchEvent(new OnLoginEvent());
         if(Version.isTraceOn())
         {
            trace("*****  dispatch event  -  " + OnLoginEvent.ON_LOGIN_EVENT + "=" + _loc5_);
         }
      }
      
      public function set _proxyHostInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1127701075_proxyHostInput;
         if(_loc2_ !== param1)
         {
            this._1127701075_proxyHostInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_proxyHostInput",_loc2_,param1));
         }
      }
      
      public function set _skypeUnInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._740274470_skypeUnInput;
         if(_loc2_ !== param1)
         {
            this._740274470_skypeUnInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_skypeUnInput",_loc2_,param1));
         }
      }
      
      public function set autoScript(param1:CheckBox) : void
      {
         var _loc2_:Object = this._398369958autoScript;
         if(_loc2_ !== param1)
         {
            this._398369958autoScript = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoScript",_loc2_,param1));
         }
      }
      
      public function set secCode(param1:TextInput) : void
      {
         var _loc2_:Object = this._1968786910secCode;
         if(_loc2_ !== param1)
         {
            this._1968786910secCode = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"secCode",_loc2_,param1));
         }
      }
      
      public function set autoRun(param1:CheckBox) : void
      {
         var _loc2_:Object = this._646327716autoRun;
         if(_loc2_ !== param1)
         {
            this._646327716autoRun = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoRun",_loc2_,param1));
         }
      }
      
      public function set _loginTypeSelect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._958099744_loginTypeSelect;
         if(_loc2_ !== param1)
         {
            this._958099744_loginTypeSelect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_loginTypeSelect",_loc2_,param1));
         }
      }
      
      public function set username(param1:TextInput) : void
      {
         var _loc2_:Object = this._265713450username;
         if(_loc2_ !== param1)
         {
            this._265713450username = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"username",_loc2_,param1));
         }
      }
      
      public function ___themeSelect_change(param1:ListEvent) : void
      {
         this.onSetTheme(this.themeSelectInfo[this._themeSelect.selectedIndex]);
      }
      
      public function set _AutoEvony2_VersionLabel(param1:Label) : void
      {
         var _loc2_:Object = this._109422308_AutoEvony2_VersionLabel;
         if(_loc2_ !== param1)
         {
            this._109422308_AutoEvony2_VersionLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AutoEvony2_VersionLabel",_loc2_,param1));
         }
      }
      
      public function set autoLoginMinTime(param1:TextInput) : void
      {
         var _loc2_:Object = this._2084288539autoLoginMinTime;
         if(_loc2_ !== param1)
         {
            this._2084288539autoLoginMinTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoLoginMinTime",_loc2_,param1));
         }
      }
      
      private function onAutoLogin() : void
      {
         var _loc1_:String = null;
         if(this.username.text == "")
         {
            _loc1_ = "The Username field cannot be blank.";
         }
         else if(this.password.text == "")
         {
            _loc1_ = "The Password field cannot be blank.";
         }
         else if(this.serverNumT.text == "")
         {
            _loc1_ = "The Server Num field cannot be blank.";
         }
         else if(int(this.autoLoginMinTime.text) > int(this.autoLoginMaxTime.text))
         {
            _loc1_ = "The min delay time cannot be greater than the max delay time.";
         }
         else if(this._proxySelect.selectedIndex > 0 && (this._proxyPortInput.text == "" || this._proxyPortInput.text == "0"))
         {
            _loc1_ = "The Port field cannot be blank if a proxy type has been selected.";
         }
         else if(this._proxySelect.selectedIndex > 0 && this._proxyHostInput.text == "")
         {
            _loc1_ = "The IP/HostName field cannot be blank if a proxy type has been selected.";
         }
         if(_loc1_)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,_loc1_));
            this.autoLogin.selected = false;
            return;
         }
         this.autoLoginMinTime.enabled = false;
         this.autoLoginMaxTime.enabled = false;
         if(this.autoTimer != null)
         {
            return;
         }
         this.delay = Utils.rand(int(this.autoLoginMinTime.text),int(this.autoLoginMaxTime.text));
         this.button.label = "Stop Auto Login";
         this.button.toolTip = "Cancel the Auto Login process and timer.";
         this.autoTimer = new Timer(1000);
         this.autoTimer.addEventListener(TimerEvent.TIMER,this.autoTimerHandler);
         this.autoTimer.start();
      }
      
      public function set notice(param1:Label) : void
      {
         var _loc2_:Object = this._1039690024notice;
         if(_loc2_ !== param1)
         {
            this._1039690024notice = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"notice",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get secCode() : TextInput
      {
         return this._1968786910secCode;
      }
      
      [Bindable(event="propertyChange")]
      public function get notice() : Label
      {
         return this._1039690024notice;
      }
      
      private function _LoginScreen_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.loginTypeSelectInfo;
         _loc1_ = this.proxySelectInfo;
         _loc1_ = this._proxySelect.selectedIndex != 0;
         _loc1_ = this._proxySelect.selectedIndex != 0;
         _loc1_ = this._proxySelect.selectedIndex != 0;
         _loc1_ = this._proxySelect.selectedIndex != 0;
         _loc1_ = this._proxySelect.selectedIndex == 3;
         _loc1_ = this._proxySelect.selectedIndex == 3;
         _loc1_ = this._proxySelect.selectedIndex == 3;
         _loc1_ = this._proxySelect.selectedIndex == 3;
         _loc1_ = this._skypeUnInput.text.length > 0;
         _loc1_ = "";
         _loc1_ = "RE for Age II: " + Version.getVersionStr() + " - running on: Flash Player " + (Utils.isFlashDebugPlayer() ? "Debugger " : " ") + Utils.getFlashPlayerType();
         _loc1_ = this.themeSelectInfo;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AutoEvony2_VersionLabel() : Label
      {
         return this._109422308_AutoEvony2_VersionLabel;
      }
      
      private function set themeSelectInfo(param1:Array) : void
      {
         var _loc2_:Object = this._1406231949themeSelectInfo;
         if(_loc2_ !== param1)
         {
            this._1406231949themeSelectInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"themeSelectInfo",_loc2_,param1));
         }
      }
      
      public function ___LoginScreen_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get _skypeUnInput() : TextInput
      {
         return this._740274470_skypeUnInput;
      }
      
      [Bindable(event="propertyChange")]
      public function get _loginTypeSelect() : ComboBox
      {
         return this._958099744_loginTypeSelect;
      }
      
      [Bindable(event="propertyChange")]
      private function get proxySelectInfo() : ArrayCollection
      {
         return this._1594434776proxySelectInfo;
      }
      
      public function set serverNumT(param1:TextInput) : void
      {
         var _loc2_:Object = this._1826091151serverNumT;
         if(_loc2_ !== param1)
         {
            this._1826091151serverNumT = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"serverNumT",_loc2_,param1));
         }
      }
      
      private function set loginTypeSelectInfo(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1655281043loginTypeSelectInfo;
         if(_loc2_ !== param1)
         {
            this._1655281043loginTypeSelectInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loginTypeSelectInfo",_loc2_,param1));
         }
      }
      
      public function set autoLoginMaxTime(param1:TextInput) : void
      {
         var _loc2_:Object = this._1990880759autoLoginMaxTime;
         if(_loc2_ !== param1)
         {
            this._1990880759autoLoginMaxTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoLoginMaxTime",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get autoLoginMaxTime() : TextInput
      {
         return this._1990880759autoLoginMaxTime;
      }
      
      [Bindable(event="propertyChange")]
      public function get username() : TextInput
      {
         return this._265713450username;
      }
      
      public function set _themeSelect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1132676506_themeSelect;
         if(_loc2_ !== param1)
         {
            this._1132676506_themeSelect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_themeSelect",_loc2_,param1));
         }
      }
      
      public function set autoLogin(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1643599610autoLogin;
         if(_loc2_ !== param1)
         {
            this._1643599610autoLogin = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoLogin",_loc2_,param1));
         }
      }
   }
}

