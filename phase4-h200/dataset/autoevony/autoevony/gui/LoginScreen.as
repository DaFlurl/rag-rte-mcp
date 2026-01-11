// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.LoginScreen

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.controls.CheckBox;
    import mx.controls.ComboBox;
    import mx.controls.Button;
    import flash.utils.Timer;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.adobe.net.proxies.ProxySocket;
    import autoevony.gui.controls.themes.ThemeManager;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import autoevony.common.Utils;
    import flash.events.Event;
    import flash.net.SharedObject;
    import autoevony.player.LoginHelper;
    import flash.events.TimerEvent;
    import flash.utils.getDefinitionByName;
    import flash.net.URLLoader;
    import flash.events.IOErrorEvent;
    import flash.net.URLVariables;
    import flash.net.URLRequest;
    import flash.net.URLLoaderDataFormat;
    import autoevony.event.popUpWinShowEvent;
    import autoevony.event.OnLoginEvent;
    import mx.events.ListEvent;
    import mx.events.FlexEvent;
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
        private var _398369958autoScript:CheckBox;
        private var _109422308_AutoEvony2_VersionLabel:Label;
        private var _625163220_skypePwInput:TextInput;
        private var _1990880759autoLoginMaxTime:TextInput;
        private var delay:int;
        private var _1132676506_themeSelect:ComboBox;
        private var _1377687758button:Button;
        private var _265713450username:TextInput;
        private var _1461600075_proxySelect:ComboBox;
        private var _958099744_loginTypeSelect:ComboBox;
        private var _1643599610autoLogin:CheckBox;
        private var _740274470_skypeUnInput:TextInput;
        private var _180700564_proxyPwInput:TextInput;
        private var _1968786910secCode:TextInput;
        private var autoTimer:Timer = null;
        public var cmdLineParamStr:String = "";
        private var _1334536422_proxyPortInput:TextInput;
        public var _LoginScreen_Label7:Label;
        public var _LoginScreen_Label8:Label;
        public var _LoginScreen_Label9:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":950,
                    "height":600,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":850,
                                "height":450,
                                "styleName":"REmainLoginForm",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "30";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Login Type:",
                                            "enabled":true,
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_loginTypeSelect",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":200,
                                            "height":22,
                                            "enabled":true,
                                            "styleName":"ComboBox"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "60";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Username:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"username",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "styleName":"textInput",
                                            "toolTip":"Enter your evony.com login email."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "90";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Password:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"password",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "90";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "displayAsPassword":true,
                                            "styleName":"textInput",
                                            "toolTip":"Enter your evony.com login password."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "120";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Security Code:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"secCode",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "120";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "displayAsPassword":true,
                                            "maxChars":10,
                                            "styleName":"textInput",
                                            "toolTip":"Enter your security code. Leave blank if you do not have one."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "150";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Server Num:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"serverNumT",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "150";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "maxChars":6,
                                            "styleName":"textInput",
                                            "toolTip":"Enter your server number.  Ex: na61"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "430";
                                        this.top = "60";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Proxy Type:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_proxySelect",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "550";
                                        this.top = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":100,
                                            "height":22,
                                            "styleName":"ComboBox"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginScreen_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "670";
                                        this.top = "60";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "text":"Port:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_proxyPortInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "730";
                                        this.top = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":70,
                                            "text":"8080",
                                            "restrict":"0-9",
                                            "styleName":"textInput",
                                            "toolTip":"Enter the port number for the proxy server."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginScreen_Label8",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "430";
                                        this.top = "90";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"IP/HostName:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_proxyHostInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "550";
                                        this.top = "90";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "restrict":"a-zA-Z0-9.-",
                                            "styleName":"textInput",
                                            "toolTip":"Enter the IP address or host name for the proxy server."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginScreen_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "430";
                                        this.top = "120";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Username:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_proxyUnInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "550";
                                        this.top = "120";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "styleName":"textInput",
                                            "toolTip":"Enter the username for the proxy server if it requires authentication."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_LoginScreen_Label10",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "430";
                                        this.top = "150";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Password:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_proxyPwInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "550";
                                        this.top = "150";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "styleName":"textInput",
                                            "toolTip":"Enter the password for the proxy server if it requires authentication."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.top = "186";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":2,
                                            "styleName":"horizontalSeparator2pxLine"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Auto Goals:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"autoRun",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "200";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REtoggleBox",
                                            "toolTip":"Enable set all goals upon successful login"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "240";
                                        this.top = "200";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Auto Scripts:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"autoScript",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "360";
                                        this.top = "200";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"REtoggleBox",
                                            "toolTip":"Enable run all scripts upon successful login.\r[experienced users only, use caution]"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.top = "236";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":2,
                                            "styleName":"horizontalSeparator2pxLine"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "30";
                                        this.top = "250";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "text":"Auto Login:",
                                            "styleName":"REmainFormText",
                                            "toolTip":"Enable automatic login."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"autoLogin",
                                    "events":{"change":"__autoLogin_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "250";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"REtoggleBox"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "190";
                                        this.top = "250";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":70,
                                            "text":"min:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"autoLoginMinTime",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "270";
                                        this.top = "250";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "text":"1",
                                            "restrict":"0-9",
                                            "enabled":true,
                                            "styleName":"textInput",
                                            "toolTip":"Enter the minimum delay in seconds for automatic login."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "320";
                                        this.top = "250";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":70,
                                            "text":"max:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"autoLoginMaxTime",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "400";
                                        this.top = "250";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "text":"600",
                                            "restrict":"0-9",
                                            "enabled":true,
                                            "styleName":"textInput",
                                            "toolTip":"Enter the maximum delay in seconds for automatic login."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"button",
                                    "events":{"click":"__button_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "50";
                                        this.top = "250";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "minWidth":75,
                                            "label":"Login",
                                            "styleName":"REwinBtn",
                                            "toolTip":"Login to the server and begin managing all aspects of your towns and account now!"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.top = "286";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":2,
                                            "styleName":"horizontalSeparator2pxLine"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.top = "300";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":130,
                                            "text":"Skype Username:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_skypeUnInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "300";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "styleName":"textInput",
                                            "toolTip":"Optional, but necessary to use the automated skype warning features."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.top = "330";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":130,
                                            "text":"Skype Password:",
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_skypePwInput",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "150";
                                        this.top = "330";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":250,
                                            "displayAsPassword":true,
                                            "styleName":"textInput",
                                            "toolTip":"Enter the password for the Skype username entered above."
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.top = "366";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":2,
                                            "styleName":"horizontalSeparator2pxLine"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.bottom = "50";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"REmainFormText"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.right = "20";
                                        this.bottom = "40";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":2,
                                            "styleName":"horizontalSeparator2pxLine"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AutoEvony2_VersionLabel",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "10";
                                        this.textAlign = "center";
                                        this.color = 0xFFFFFF;
                                        this.fontFamily = "DejaVu Sans";
                                        this.fontSize = 10;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":100});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ComboBox,
                        "id":"_themeSelect",
                        "events":{"change":"___themeSelect_change"},
                        "stylesFactory":function ():void
                        {
                            this.right = "35";
                            this.bottom = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":180,
                                "height":22,
                                "enabled":true,
                                "styleName":"ComboBox"
                            });
                        }
                    })]
                });
            }
        });
        private var _1594434776proxySelectInfo:ArrayCollection = new ArrayCollection([{
            "label":"none",
            "data":""
        }, {
            "label":"HTTP",
            "data":ProxySocket.PROXY_TYPE_HTTP
        }, {
            "label":"SOCKS4",
            "data":ProxySocket.PROXY_TYPE_SOCKS4
        }, {
            "label":"SOCKS5",
            "data":ProxySocket.PROXY_TYPE_SOCKS5
        }]);
        private var _1655281043loginTypeSelectInfo:ArrayCollection = new ArrayCollection([{
            "label":"evony.com (recommended)",
            "data":"ev"
        }, {
            "label":"facebook.com (beta)",
            "data":"fb"
        }]);
        private var _1406231949themeSelectInfo:Array = ThemeManager.themes.themeList;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function LoginScreen()
        {
            mx_internal::_document = this;
            this.width = 950;
            this.height = 600;
            this.minWidth = 680;
            this.minHeight = 580;
            this.addEventListener("creationComplete", this.___LoginScreen_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LoginScreen._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get autoLogin():CheckBox
        {
            return (this._1643599610autoLogin);
        }

        private function set proxySelectInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1594434776proxySelectInfo;
            if (_local_2 !== _arg_1)
            {
                this._1594434776proxySelectInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "proxySelectInfo", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            this.getSettings();
        }

        [Bindable(event="propertyChange")]
        public function get autoLoginMinTime():TextInput
        {
            return (this._2084288539autoLoginMinTime);
        }

        [Bindable(event="propertyChange")]
        public function get _proxyPortInput():TextInput
        {
            return (this._1334536422_proxyPortInput);
        }

        public function __button_click(_arg_1:MouseEvent):void
        {
            this.onStartBtn();
        }

        public function set _proxyPwInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._180700564_proxyPwInput;
            if (_local_2 !== _arg_1)
            {
                this._180700564_proxyPwInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_proxyPwInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get button():Button
        {
            return (this._1377687758button);
        }

        public function set _proxyPortInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1334536422_proxyPortInput;
            if (_local_2 !== _arg_1)
            {
                this._1334536422_proxyPortInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_proxyPortInput", _local_2, _arg_1));
            };
        }

        public function set password(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1216985755password;
            if (_local_2 !== _arg_1)
            {
                this._1216985755password = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "password", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _skypePwInput():TextInput
        {
            return (this._625163220_skypePwInput);
        }

        [Bindable(event="propertyChange")]
        public function get _proxyUnInput():TextInput
        {
            return (this._65589314_proxyUnInput);
        }

        [Bindable(event="propertyChange")]
        public function get _proxySelect():ComboBox
        {
            return (this._1461600075_proxySelect);
        }

        [Bindable(event="propertyChange")]
        public function get _proxyHostInput():TextInput
        {
            return (this._1127701075_proxyHostInput);
        }

        public function set _skypePwInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._625163220_skypePwInput;
            if (_local_2 !== _arg_1)
            {
                this._625163220_skypePwInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_skypePwInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get autoRun():CheckBox
        {
            return (this._646327716autoRun);
        }

        [Bindable(event="propertyChange")]
        public function get autoScript():CheckBox
        {
            return (this._398369958autoScript);
        }

        public function set button(_arg_1:Button):void
        {
            var _local_2:Object = this._1377687758button;
            if (_local_2 !== _arg_1)
            {
                this._1377687758button = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "button", _local_2, _arg_1));
            };
        }

        private function onAutoLoginChange(_arg_1:Boolean=false):void
        {
            if (this.autoLogin.selected)
            {
                this.onAutoLogin();
            }
            else
            {
                if (_arg_1)
                {
                    this.autoLoginMinTime.enabled = true;
                };
                this.autoLoginMaxTime.enabled = true;
                this.cancelAutoLogin();
            };
        }

        private function _LoginScreen_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.loginTypeSelectInfo);
            }, function (_arg_1:Object):void
            {
                _loginTypeSelect.dataProvider = _arg_1;
            }, "_loginTypeSelect.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.proxySelectInfo);
            }, function (_arg_1:Object):void
            {
                _proxySelect.dataProvider = _arg_1;
            }, "_proxySelect.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._proxySelect.selectedIndex == 0));
            }, function (_arg_1:Boolean):void
            {
                _LoginScreen_Label7.enabled = _arg_1;
            }, "_LoginScreen_Label7.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._proxySelect.selectedIndex == 0));
            }, function (_arg_1:Boolean):void
            {
                _proxyPortInput.enabled = _arg_1;
            }, "_proxyPortInput.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._proxySelect.selectedIndex == 0));
            }, function (_arg_1:Boolean):void
            {
                _LoginScreen_Label8.enabled = _arg_1;
            }, "_LoginScreen_Label8.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this._proxySelect.selectedIndex == 0));
            }, function (_arg_1:Boolean):void
            {
                _proxyHostInput.enabled = _arg_1;
            }, "_proxyHostInput.enabled");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._proxySelect.selectedIndex == 3);
            }, function (_arg_1:Boolean):void
            {
                _LoginScreen_Label9.enabled = _arg_1;
            }, "_LoginScreen_Label9.enabled");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._proxySelect.selectedIndex == 3);
            }, function (_arg_1:Boolean):void
            {
                _proxyUnInput.enabled = _arg_1;
            }, "_proxyUnInput.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._proxySelect.selectedIndex == 3);
            }, function (_arg_1:Boolean):void
            {
                _LoginScreen_Label10.enabled = _arg_1;
            }, "_LoginScreen_Label10.enabled");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._proxySelect.selectedIndex == 3);
            }, function (_arg_1:Boolean):void
            {
                _proxyPwInput.enabled = _arg_1;
            }, "_proxyPwInput.enabled");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._skypeUnInput.text.length > 0);
            }, function (_arg_1:Boolean):void
            {
                _skypePwInput.enabled = _arg_1;
            }, "_skypePwInput.enabled");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                notice.text = _arg_1;
            }, "notice.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((("RE for Age II: " + Version.getVersionStr()) + " - running on: Flash Player ") + ((Utils.isFlashDebugPlayer()) ? "Debugger " : " ")) + Utils.getFlashPlayerType());
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AutoEvony2_VersionLabel.text = _arg_1;
            }, "_AutoEvony2_VersionLabel.text");
            result[12] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.themeSelectInfo);
            }, function (_arg_1:Object):void
            {
                _themeSelect.dataProvider = _arg_1;
            }, "_themeSelect.dataProvider");
            result[13] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get serverNumT():TextInput
        {
            return (this._1826091151serverNumT);
        }

        [Bindable(event="propertyChange")]
        private function get themeSelectInfo():Array
        {
            return (this._1406231949themeSelectInfo);
        }

        [Bindable(event="propertyChange")]
        private function get loginTypeSelectInfo():ArrayCollection
        {
            return (this._1655281043loginTypeSelectInfo);
        }

        public function __autoLogin_change(_arg_1:Event):void
        {
            this.onAutoLoginChange(true);
        }

        [Bindable(event="propertyChange")]
        public function get _themeSelect():ComboBox
        {
            return (this._1132676506_themeSelect);
        }

        public function set _proxyUnInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._65589314_proxyUnInput;
            if (_local_2 !== _arg_1)
            {
                this._65589314_proxyUnInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_proxyUnInput", _local_2, _arg_1));
            };
        }

        private function onSetTheme(_arg_1:String):void
        {
            ThemeManager.loadTheme(null, _arg_1);
        }

        private function delayedInit(_arg_1:Object=null):void
        {
            var _local_2:SharedObject = SharedObject.getLocal("config");
            var _local_3:LoginHelper = new LoginHelper(_local_2.data.now);
            if (((!(_arg_1 == null)) && (!(_arg_1.theme == undefined))))
            {
                this._themeSelect.selectedIndex = ((this.themeSelectInfo.indexOf(_arg_1.theme) != -1) ? this.themeSelectInfo.indexOf(_arg_1.theme) : 0);
            }
            else
            {
                this._themeSelect.selectedIndex = ((this.themeSelectInfo.indexOf(_local_3.theme) != -1) ? this.themeSelectInfo.indexOf(_local_3.theme) : 0);
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.logintype == undefined))))
            {
                this._loginTypeSelect.selectedIndex = ((_arg_1.logintype == "ev") ? 0 : ((_arg_1.logintype == "fb") ? 1 : 0));
            }
            else
            {
                this._loginTypeSelect.selectedIndex = ((_local_3.loginType == "ev") ? 0 : ((_local_3.loginType == "fb") ? 1 : 0));
            };
            this.username.text = (((!(_arg_1 == null)) && (!(_arg_1.username == undefined))) ? _arg_1.username : _local_3.username);
            this.password.text = (((!(_arg_1 == null)) && (!(_arg_1.password == undefined))) ? _arg_1.password : _local_3.password);
            this.secCode.text = (((!(_arg_1 == null)) && (!(_arg_1.seccode == undefined))) ? _arg_1.seccode : _local_3.secCode);
            this.serverNumT.text = (((!(_arg_1 == null)) && (!(_arg_1.server == undefined))) ? _arg_1.server : _local_3.server);
            this.autoRun.selected = (((!(_arg_1 == null)) && (!(_arg_1.autogoals == undefined))) ? _arg_1.autogoals : _local_3.autoRun);
            this.autoScript.selected = (((!(_arg_1 == null)) && (!(_arg_1.autoscripts == undefined))) ? _arg_1.autoscripts : _local_3.autoScript);
            this.autoLogin.selected = (((!(_arg_1 == null)) && (!(_arg_1.autologin == undefined))) ? _arg_1.autologin : _local_3.autoLogin);
            this._skypeUnInput.text = (((!(_arg_1 == null)) && (!(_arg_1.skypeun == undefined))) ? _arg_1.skypeun : _local_3.skypeUn);
            this._skypePwInput.text = (((!(_arg_1 == null)) && (!(_arg_1.skypepw == undefined))) ? _arg_1.skypepw : _local_3.skypePw);
            if (((!(_arg_1 == null)) && (!(_arg_1.proxytype == undefined))))
            {
                if (_arg_1.proxytype == ProxySocket.PROXY_TYPE_HTTP)
                {
                    this._proxySelect.selectedIndex = 1;
                };
                if (_arg_1.proxytype == ProxySocket.PROXY_TYPE_SOCKS4)
                {
                    this._proxySelect.selectedIndex = 2;
                };
                if (_arg_1.proxytype == ProxySocket.PROXY_TYPE_SOCKS5)
                {
                    this._proxySelect.selectedIndex = 3;
                };
            }
            else
            {
                if (((_local_3.proxyType) && (!(_local_3.proxyType == null))))
                {
                    if (_local_3.proxyType == ProxySocket.PROXY_TYPE_HTTP)
                    {
                        this._proxySelect.selectedIndex = 1;
                    };
                    if (_local_3.proxyType == ProxySocket.PROXY_TYPE_SOCKS4)
                    {
                        this._proxySelect.selectedIndex = 2;
                    };
                    if (_local_3.proxyType == ProxySocket.PROXY_TYPE_SOCKS5)
                    {
                        this._proxySelect.selectedIndex = 3;
                    };
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.proxyport == undefined))))
            {
                this._proxyPortInput.text = _arg_1.proxyport;
            }
            else
            {
                if (((_local_3.proxyPort) && (!(_local_3.proxyPort == null))))
                {
                    this._proxyPortInput.text = _local_3.proxyPort;
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.proxyhost == undefined))))
            {
                this._proxyHostInput.text = _arg_1.proxyhost;
            }
            else
            {
                if (((_local_3.proxyHost) && (!(_local_3.proxyHost == null))))
                {
                    this._proxyHostInput.text = _local_3.proxyHost;
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.proxyun == undefined))))
            {
                this._proxyUnInput.text = _arg_1.proxyun;
            }
            else
            {
                if (((_local_3.proxyUn) && (!(_local_3.proxyUn == null))))
                {
                    this._proxyUnInput.text = _local_3.proxyUn;
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.proxypw == undefined))))
            {
                this._proxyPwInput.text = _arg_1.proxypw;
            }
            else
            {
                if (((_local_3.proxyPw) && (!(_local_3.proxyPw == null))))
                {
                    this._proxyPwInput.text = _local_3.proxyPw;
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.autologinmintime == undefined))))
            {
                this.autoLoginMinTime.text = _arg_1.autologinmintime;
            }
            else
            {
                if (((!(_local_3.autoLoginMinTime == null)) && (!(_local_3.autoLoginMinTime == ""))))
                {
                    this.autoLoginMinTime.text = _local_3.autoLoginMinTime;
                };
            };
            if (((!(_arg_1 == null)) && (!(_arg_1.autologinmaxtime == undefined))))
            {
                this.autoLoginMaxTime.text = _arg_1.autologinmaxtime;
            }
            else
            {
                if (((!(_local_3.autoLoginMaxTime == null)) && (!(_local_3.autoLoginMaxTime == ""))))
                {
                    this.autoLoginMaxTime.text = _local_3.autoLoginMaxTime;
                };
            };
            if (this.autoLogin.selected)
            {
                this.onAutoLogin();
            };
            this.onSetTheme(this.themeSelectInfo[this._themeSelect.selectedIndex]);
        }

        private function autoTimerHandler(_arg_1:TimerEvent):void
        {
            this.delay--;
            if (this.delay <= 0)
            {
                this.autoTimer.stop();
                this.autoTimer.removeEventListener(TimerEvent.TIMER, this.autoTimerHandler);
                this.autoTimer = null;
                this.button.label = "Login";
                this.button.toolTip = "Login to the server and begin managing your account now!";
                this.notice.text = "";
                this.onStartBtn();
            }
            else
            {
                this.notice.text = (((Utils.getLogTimeStr(new Date().getTime()) + ": Auto start in ") + this.delay) + " seconds...");
            };
        }

        override public function initialize():void
        {
            var target:LoginScreen;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._LoginScreen_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_LoginScreenWatcherSetupUtil");
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

        private function getSettings():void
        {
            var onCompleteHandler:Function;
            var loader:URLLoader;
            onCompleteHandler = function (_arg_1:Event):void
            {
                var _local_9:String;
                loader.removeEventListener(Event.COMPLETE, onCompleteHandler);
                loader.removeEventListener(IOErrorEvent.IO_ERROR, onCompleteHandler);
                var _local_2:URLLoader = URLLoader(_arg_1.target);
                var _local_3:String = _local_2.data;
                var _local_4:URLVariables = new URLVariables(_local_3.replace(/\r\n?|\n/g, ""));
                var _local_5:Array = ["logintype", "username", "password", "seccode", "server", "proxytype", "proxyport", "proxyhost", "proxyun", "proxypw", "autogoals", "autoscripts", "autologin", "autologinmintime", "autologinmaxtime", "skypeun", "skypepw", "theme"];
                var _local_6:Object = new Object();
                var _local_7:String;
                var _local_8:String;
                for (_local_9 in _local_4)
                {
                    if (Version.isTraceOn())
                    {
                        trace((((Utils.trim(_local_9.replace(/\r\n?|\n/g, "")).toLowerCase() + " = ") + Utils.trim(_local_4[_local_9].replace(/\r\n?|\n/g, ""))) + ";"));
                    };
                    if (((!(_local_5.indexOf((_local_7 = Utils.trim(_local_9.replace(/\r\n?|\n/g, "")).toLowerCase())) == -1)) && (!((_local_8 = Utils.trim(_local_4[_local_9].replace(/\r\n?|\n/g, ""))) == ""))))
                    {
                        _local_6[_local_7] = ((_local_8.toLowerCase() == "true") ? true : ((_local_8.toLowerCase() == "false") ? false : _local_8));
                    };
                };
                delayedInit(_local_6);
            };
            var onIoErrorHandler:Function = function (_arg_1:IOErrorEvent):void
            {
                loader.removeEventListener(Event.COMPLETE, onCompleteHandler);
                loader.removeEventListener(IOErrorEvent.IO_ERROR, onCompleteHandler);
                if (Version.isTraceOn())
                {
                    trace("Missing or inappropriately named login.cfg file.");
                };
                delayedInit();
            };
            var req:URLRequest = new URLRequest("login.cfg");
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.VARIABLES;
            loader.addEventListener(Event.COMPLETE, onCompleteHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
            try
            {
                loader.load(req);
            }
            catch(error:ArgumentError)
            {
                if (Version.isTraceOn())
                {
                    trace("An ArgumentError has occurred while loading login.cfg file.");
                };
                delayedInit();
            }
            catch(error:SecurityError)
            {
                if (Version.isTraceOn())
                {
                    trace("A SecurityError has occurred while loading login.cfg file.");
                };
                delayedInit();
            }
            catch(error:Error)
            {
                if (Version.isTraceOn())
                {
                    trace(("Unable to load login.cfg file: " + error));
                };
                delayedInit();
            };
        }

        public function set _proxySelect(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1461600075_proxySelect;
            if (_local_2 !== _arg_1)
            {
                this._1461600075_proxySelect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_proxySelect", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get password():TextInput
        {
            return (this._1216985755password);
        }

        [Bindable(event="propertyChange")]
        public function get _proxyPwInput():TextInput
        {
            return (this._180700564_proxyPwInput);
        }

        private function cancelAutoLogin():Boolean
        {
            if (this.autoTimer != null)
            {
                this.autoTimer.stop();
                this.notice.text = "";
                this.autoTimer.addEventListener(TimerEvent.TIMER, this.autoTimerHandler);
                this.autoTimer = null;
                this.button.label = "Login";
                this.button.toolTip = "Login to the server and begin managing your account now!";
                return (true);
            };
            return (false);
        }

        public function onStartBtn():void
        {
            if (this.cancelAutoLogin())
            {
                return;
            };
            var _local_1:String;
            if (Utils.trim(this.username.text) == "")
            {
                _local_1 = "The Username field cannot be blank.";
            }
            else
            {
                if (Utils.trim(this.password.text) == "")
                {
                    _local_1 = "The Password field cannot be blank.";
                }
                else
                {
                    if (Utils.trim(this.serverNumT.text) == "")
                    {
                        _local_1 = "The Server Num field cannot be blank.";
                    }
                    else
                    {
                        if (((this._proxySelect.selectedIndex > 0) && ((Utils.trim(this._proxyPortInput.text) == "") || (this._proxyPortInput.text == "0"))))
                        {
                            _local_1 = "The Port field cannot be blank if a proxy type has been selected.";
                        }
                        else
                        {
                            if (((this._proxySelect.selectedIndex > 0) && (Utils.trim(this._proxyHostInput.text) == "")))
                            {
                                _local_1 = "The IP/HostName field cannot be blank if a proxy type has been selected.";
                            };
                        };
                    };
                };
            };
            if (_local_1)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _local_1));
                return;
            };
            var _local_2:* = "";
            var _local_3:RegExp = new RegExp("(http://)?(www\\.)?([^.]+)\\.?.*");
            var _local_4:Object = _local_3.exec(this.serverNumT.text);
            if ((((_local_4 == null) || (_local_4.length < 4)) || (_local_4[3].length == 0)))
            {
                this.notice.text = ("Unable to find the server id from " + this.serverNumT.text);
                return;
            };
            this.serverNumT.text = (_local_2 = _local_4[3]);
            this.username.text = Utils.trim(this.username.text);
            this.password.text = Utils.trim(this.password.text);
            this._proxyPortInput.text = Utils.trim(this._proxyPortInput.text);
            this._proxyHostInput.text = Utils.trim(this._proxyHostInput.text);
            this._proxyUnInput.text = Utils.trim(this._proxyUnInput.text);
            this._proxyPwInput.text = Utils.trim(this._proxyPwInput.text);
            this.button.enabled = false;
            var _local_5:Boolean = dispatchEvent(new OnLoginEvent());
            if (Version.isTraceOn())
            {
                trace(((("*****  dispatch event  -  " + OnLoginEvent.ON_LOGIN_EVENT) + "=") + _local_5));
            };
        }

        public function set _proxyHostInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1127701075_proxyHostInput;
            if (_local_2 !== _arg_1)
            {
                this._1127701075_proxyHostInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_proxyHostInput", _local_2, _arg_1));
            };
        }

        public function set _skypeUnInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._740274470_skypeUnInput;
            if (_local_2 !== _arg_1)
            {
                this._740274470_skypeUnInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_skypeUnInput", _local_2, _arg_1));
            };
        }

        public function set autoScript(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._398369958autoScript;
            if (_local_2 !== _arg_1)
            {
                this._398369958autoScript = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoScript", _local_2, _arg_1));
            };
        }

        public function set secCode(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1968786910secCode;
            if (_local_2 !== _arg_1)
            {
                this._1968786910secCode = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "secCode", _local_2, _arg_1));
            };
        }

        public function set autoRun(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._646327716autoRun;
            if (_local_2 !== _arg_1)
            {
                this._646327716autoRun = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoRun", _local_2, _arg_1));
            };
        }

        public function set _loginTypeSelect(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._958099744_loginTypeSelect;
            if (_local_2 !== _arg_1)
            {
                this._958099744_loginTypeSelect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_loginTypeSelect", _local_2, _arg_1));
            };
        }

        public function set username(_arg_1:TextInput):void
        {
            var _local_2:Object = this._265713450username;
            if (_local_2 !== _arg_1)
            {
                this._265713450username = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "username", _local_2, _arg_1));
            };
        }

        public function ___themeSelect_change(_arg_1:ListEvent):void
        {
            this.onSetTheme(this.themeSelectInfo[this._themeSelect.selectedIndex]);
        }

        public function set _AutoEvony2_VersionLabel(_arg_1:Label):void
        {
            var _local_2:Object = this._109422308_AutoEvony2_VersionLabel;
            if (_local_2 !== _arg_1)
            {
                this._109422308_AutoEvony2_VersionLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AutoEvony2_VersionLabel", _local_2, _arg_1));
            };
        }

        public function set autoLoginMinTime(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2084288539autoLoginMinTime;
            if (_local_2 !== _arg_1)
            {
                this._2084288539autoLoginMinTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoLoginMinTime", _local_2, _arg_1));
            };
        }

        private function onAutoLogin():void
        {
            var _local_1:String;
            if (this.username.text == "")
            {
                _local_1 = "The Username field cannot be blank.";
            }
            else
            {
                if (this.password.text == "")
                {
                    _local_1 = "The Password field cannot be blank.";
                }
                else
                {
                    if (this.serverNumT.text == "")
                    {
                        _local_1 = "The Server Num field cannot be blank.";
                    }
                    else
                    {
                        if (int(this.autoLoginMinTime.text) > int(this.autoLoginMaxTime.text))
                        {
                            _local_1 = "The min delay time cannot be greater than the max delay time.";
                        }
                        else
                        {
                            if (((this._proxySelect.selectedIndex > 0) && ((this._proxyPortInput.text == "") || (this._proxyPortInput.text == "0"))))
                            {
                                _local_1 = "The Port field cannot be blank if a proxy type has been selected.";
                            }
                            else
                            {
                                if (((this._proxySelect.selectedIndex > 0) && (this._proxyHostInput.text == "")))
                                {
                                    _local_1 = "The IP/HostName field cannot be blank if a proxy type has been selected.";
                                };
                            };
                        };
                    };
                };
            };
            if (_local_1)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _local_1));
                this.autoLogin.selected = false;
                return;
            };
            this.autoLoginMinTime.enabled = false;
            this.autoLoginMaxTime.enabled = false;
            if (this.autoTimer != null)
            {
                return;
            };
            this.delay = Utils.rand(int(this.autoLoginMinTime.text), int(this.autoLoginMaxTime.text));
            this.button.label = "Stop Auto Login";
            this.button.toolTip = "Cancel the Auto Login process and timer.";
            this.autoTimer = new Timer(1000);
            this.autoTimer.addEventListener(TimerEvent.TIMER, this.autoTimerHandler);
            this.autoTimer.start();
        }

        public function set notice(_arg_1:Label):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get secCode():TextInput
        {
            return (this._1968786910secCode);
        }

        [Bindable(event="propertyChange")]
        public function get notice():Label
        {
            return (this._1039690024notice);
        }

        private function _LoginScreen_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.loginTypeSelectInfo;
            _local_1 = this.proxySelectInfo;
            _local_1 = (!(this._proxySelect.selectedIndex == 0));
            _local_1 = (!(this._proxySelect.selectedIndex == 0));
            _local_1 = (!(this._proxySelect.selectedIndex == 0));
            _local_1 = (!(this._proxySelect.selectedIndex == 0));
            _local_1 = (this._proxySelect.selectedIndex == 3);
            _local_1 = (this._proxySelect.selectedIndex == 3);
            _local_1 = (this._proxySelect.selectedIndex == 3);
            _local_1 = (this._proxySelect.selectedIndex == 3);
            _local_1 = (this._skypeUnInput.text.length > 0);
            _local_1 = "";
            _local_1 = (((("RE for Age II: " + Version.getVersionStr()) + " - running on: Flash Player ") + ((Utils.isFlashDebugPlayer()) ? "Debugger " : " ")) + Utils.getFlashPlayerType());
            _local_1 = this.themeSelectInfo;
        }

        [Bindable(event="propertyChange")]
        public function get _AutoEvony2_VersionLabel():Label
        {
            return (this._109422308_AutoEvony2_VersionLabel);
        }

        private function set themeSelectInfo(_arg_1:Array):void
        {
            var _local_2:Object = this._1406231949themeSelectInfo;
            if (_local_2 !== _arg_1)
            {
                this._1406231949themeSelectInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "themeSelectInfo", _local_2, _arg_1));
            };
        }

        public function ___LoginScreen_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get _skypeUnInput():TextInput
        {
            return (this._740274470_skypeUnInput);
        }

        [Bindable(event="propertyChange")]
        public function get _loginTypeSelect():ComboBox
        {
            return (this._958099744_loginTypeSelect);
        }

        [Bindable(event="propertyChange")]
        private function get proxySelectInfo():ArrayCollection
        {
            return (this._1594434776proxySelectInfo);
        }

        public function set serverNumT(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1826091151serverNumT;
            if (_local_2 !== _arg_1)
            {
                this._1826091151serverNumT = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverNumT", _local_2, _arg_1));
            };
        }

        private function set loginTypeSelectInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1655281043loginTypeSelectInfo;
            if (_local_2 !== _arg_1)
            {
                this._1655281043loginTypeSelectInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loginTypeSelectInfo", _local_2, _arg_1));
            };
        }

        public function set autoLoginMaxTime(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1990880759autoLoginMaxTime;
            if (_local_2 !== _arg_1)
            {
                this._1990880759autoLoginMaxTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoLoginMaxTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get autoLoginMaxTime():TextInput
        {
            return (this._1990880759autoLoginMaxTime);
        }

        [Bindable(event="propertyChange")]
        public function get username():TextInput
        {
            return (this._265713450username);
        }

        public function set _themeSelect(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1132676506_themeSelect;
            if (_local_2 !== _arg_1)
            {
                this._1132676506_themeSelect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_themeSelect", _local_2, _arg_1));
            };
        }

        public function set autoLogin(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1643599610autoLogin;
            if (_local_2 !== _arg_1)
            {
                this._1643599610autoLogin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "autoLogin", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui

