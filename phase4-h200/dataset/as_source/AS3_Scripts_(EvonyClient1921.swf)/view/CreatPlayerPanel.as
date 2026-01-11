// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.CreatPlayerPanel

package view
{
    import mx.containers.VBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.util.EvonyAnimation;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.containers.Canvas;
    import mx.controls.RadioButtonGroup;
    import mx.controls.Image;
    import mx.controls.RadioButton;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.effects.WipeLeft;
    import mx.controls.Text;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import mx.controls.SWFLoader;
    import view.ui.CreatPlayerMap;
    import mx.containers.HBox;
    import mx.core.UIComponent;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.common.MouseManager;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.MsgDispacther;
    import com.evony.client.action.ActionFactory;
    import mx.managers.PopUpManager;
    import com.evony.util.InputTextFilter;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.util.InputTextControl;
    import flash.events.Event;
    import mx.events.ItemClickEvent;
    import com.evony.common.beans.ZoneInfoBean;
    import com.evony.eum.LogoEumDefine;
    import com.evony.common.module.common.ZoneInfoResponse;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.display.Bitmap;
    import view.ui.CreatPlayerAreaChangeEvent;
    import mx.core.Application;
    import flash.display.DisplayObject;
    import mx.events.FlexEvent;
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

    public class CreatPlayerPanel extends VBox implements IBindingClient 
    {

        public static const EVENT_AREA_CHANGE:String = "CreatPlayerPanel.areaChange";
        public static const EVENT_AREA_OVER:String = "CreatPlayerPanel.areaOver";
        public static const EVENT_AREA_MOVE:String = "CreatPlayerPanel.areaMove";
        public static const EVENT_AREA_OUT:String = "CreatPlayerPanel.areaOut";
        private static var instance:CreatPlayerPanel;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var flagMC:EvonyAnimation;
        public var _CreatPlayerPanel_Label1:Label;
        public var _CreatPlayerPanel_Label2:Label;
        public var _CreatPlayerPanel_Label5:Label;
        public var _CreatPlayerPanel_Label4:Label;
        public var _CreatPlayerPanel_Label6:Label;
        public var countryNun:int = 0;
        private var _624601640cp_cityName:TextInput;
        private var _2067273540showMsg:Canvas;
        private var _1354303084cp_sex:RadioButtonGroup;
        private var _1006753127discript_users:Canvas;
        private var _1246832046discript_random:Canvas;
        private var faceArrayIndex:int = 0;
        private var _164873551radiogroup3:RadioButtonGroup;
        private var _785423899cityNum:Label;
        private var sex:int = 0;
        private var _966495294cp_zone:TextInput;
        public var _CreatPlayerPanel_Image2:Image;
        public var _CreatPlayerPanel_RadioButton1:RadioButton;
        public var _CreatPlayerPanel_RadioButton2:RadioButton;
        public var _CreatPlayerPanel_Label10:Label;
        public var _CreatPlayerPanel_Label11:Label;
        public var _CreatPlayerPanel_Label12:Label;
        public var _CreatPlayerPanel_Label13:Label;
        public var _CreatPlayerPanel_Label14:Label;
        private var _262140283mapContainer:Canvas;
        private var _1760498230bt_createPlayer:Button;
        private var _1828964878choiseVS:ViewStack;
        private var _3649607wipe:WipeLeft;
        public var _CreatPlayerPanel_Text1:Text;
        private var _1476752575countryName:String = "";
        private var _1780570216cp_username:TextInput;
        private var _1026093505zhouName:Label;
        private var _965896190cp_flag:TextInput;
        private var _94935213crowd:Label;
        private var _951530617content:Canvas;
        private var _1098677438hostNum:Label;
        private var _164873550radiogroup2:RadioButtonGroup;
        private var zoneId:int;
        private var countryAry:ArrayCollection;
        private var _571486424faceSource:String;
        private var faceArray:ArrayCollection;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":VBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"content",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":1200,
                                "height":700,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.left = "0";
                                        this.right = "0";
                                        this.bottom = "270";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"worldmapbg"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "0";
                                        this.left = "0";
                                        this.right = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":281,
                                            "styleName":"loginfbg"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":SWFLoader,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "0";
                                        this.right = "0";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/createplayerbg.swf"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"mapContainer",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":450,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":505,
                                                        "y":246,
                                                        "town":"Lombardy"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":412,
                                                        "y":244,
                                                        "town":"Burgundy"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":661,
                                                        "y":168,
                                                        "town":"Carinthia"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":396,
                                                        "y":115,
                                                        "town":"Lower"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":503,
                                                        "y":44,
                                                        "town":"Saxony"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":428,
                                                        "y":45,
                                                        "town":"Friesland"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":486,
                                                        "y":111,
                                                        "town":"Franconia"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":648,
                                                        "y":267,
                                                        "town":"Tuscany"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":685,
                                                        "y":240,
                                                        "town":"Romagna"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":446,
                                                        "y":179,
                                                        "town":"Swabia"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":376,
                                                        "y":165,
                                                        "town":"UpperLorraine"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":565,
                                                        "y":130,
                                                        "town":"Bohemia"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":587,
                                                        "y":50,
                                                        "town":"NorthMarch"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":652,
                                                        "y":106,
                                                        "town":"Moravia"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":587,
                                                        "y":202,
                                                        "town":"Bavaria"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CreatPlayerMap,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":630,
                                                        "y":65,
                                                        "town":"Thuringia"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CreatPlayerPanel_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xAE0000;
                                        this.textDecoration = "underline";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":141,
                                            "x":753,
                                            "y":467,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CreatPlayerPanel_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xAE0000;
                                        this.textDecoration = "underline";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":141,
                                            "x":703,
                                            "y":507
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"showMsg",
                                    "stylesFactory":function ():void
                                    {
                                        this.cornerRadius = 5;
                                        this.borderStyle = "none";
                                        this.borderThickness = 2;
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":164,
                                            "width":330,
                                            "height":155,
                                            "visible":true,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":ViewStack,
                                                "id":"choiseVS",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Canvas,
                                                            "id":"discript_users",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":VBox,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.horizontalAlign = "left";
                                                                            this.verticalGap = 11;
                                                                            this.left = "5";
                                                                            this.right = "5";
                                                                            this.top = "5";
                                                                            this.bottom = "5";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "horizontalScrollPolicy":"off",
                                                                                "verticalScrollPolicy":"off",
                                                                                "childDescriptors":[new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":Label,
                                                                                                "id":"zhouName",
                                                                                                "stylesFactory":function ():void
                                                                                                {
                                                                                                    this.fontSize = 30;
                                                                                                    this.fontWeight = "bold";
                                                                                                    this.color = 0xFFFFFF;
                                                                                                }
                                                                                            })]
                                                                                        });
                                                                                    }
                                                                                }), new UIComponentDescriptor({
                                                                                    "type":HBox,
                                                                                    "stylesFactory":function ():void
                                                                                    {
                                                                                        this.horizontalAlign = "center";
                                                                                        this.horizontalGap = 0;
                                                                                    },
                                                                                    "propertiesFactory":function ():Object
                                                                                    {
                                                                                        return ({
                                                                                            "percentWidth":100,
                                                                                            "horizontalScrollPolicy":"off",
                                                                                            "verticalScrollPolicy":"off",
                                                                                            "childDescriptors":[new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentHeight":100,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_CreatPlayerPanel_Label4",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.textAlign = "right";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "styleName":"discreationStyle2",
                                                                                                                    "percentWidth":100
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_CreatPlayerPanel_Label5",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.textAlign = "right";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "styleName":"discreationStyle2",
                                                                                                                    "percentWidth":100
                                                                                                                });
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"_CreatPlayerPanel_Label6",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.textAlign = "right";
                                                                                                            },
                                                                                                            "propertiesFactory":function ():Object
                                                                                                            {
                                                                                                                return ({
                                                                                                                    "styleName":"discreationStyle2",
                                                                                                                    "percentWidth":100
                                                                                                                });
                                                                                                            }
                                                                                                        })]
                                                                                                    });
                                                                                                }
                                                                                            }), new UIComponentDescriptor({
                                                                                                "type":VBox,
                                                                                                "propertiesFactory":function ():Object
                                                                                                {
                                                                                                    return ({
                                                                                                        "percentHeight":100,
                                                                                                        "horizontalScrollPolicy":"off",
                                                                                                        "verticalScrollPolicy":"off",
                                                                                                        "childDescriptors":[new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"hostNum",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.textAlign = "left";
                                                                                                                this.fontWeight = "bold";
                                                                                                                this.fontSize = 14;
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"cityNum",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.textAlign = "left";
                                                                                                                this.fontSize = 14;
                                                                                                                this.fontWeight = "bold";
                                                                                                            }
                                                                                                        }), new UIComponentDescriptor({
                                                                                                            "type":Label,
                                                                                                            "id":"crowd",
                                                                                                            "stylesFactory":function ():void
                                                                                                            {
                                                                                                                this.color = 0xFFFFFF;
                                                                                                                this.textAlign = "left";
                                                                                                                this.fontSize = 14;
                                                                                                                this.fontWeight = "bold";
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
                                            "x":270,
                                            "y":465,
                                            "width":200,
                                            "height":180,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "0";
                                                    this.left = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/head.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_CreatPlayerPanel_Image2",
                                                "events":{"complete":"___CreatPlayerPanel_Image2_complete"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "15";
                                                    this.left = "39";
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "15";
                                                    this.left = "39";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/face_Reflective.png"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CreatPlayerPanel_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"previous",
                                            "y":605,
                                            "x":330
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___CreatPlayerPanel_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"next",
                                            "y":605,
                                            "x":361
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":449,
                                            "y":460,
                                            "width":298,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                    this.horizontalGap = 0;
                                                    this.horizontalAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":298,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CreatPlayerPanel_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontSize = 12;
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"commonNormalColor",
                                                                    "percentWidth":35
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"cp_username",
                                                            "events":{"change":"__cp_username_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"YellowInput",
                                                                    "percentWidth":60,
                                                                    "restrict":"a-z\\A-Z\\0-9"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "y":40,
                                                        "x":23,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CreatPlayerPanel_Label11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontSize = 12;
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"commonNormalColor",
                                                                    "percentWidth":35
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"cp_flag",
                                                            "events":{"change":"__cp_flag_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":62,
                                                                    "styleName":"YellowInput"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "y":80,
                                                        "x":23,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CreatPlayerPanel_Label12",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontSize = 12;
                                                                this.fontWeight = "bold";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"commonNormalColor",
                                                                    "percentWidth":35
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"cp_cityName",
                                                            "events":{"change":"__cp_cityName_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"YellowInput",
                                                                    "percentWidth":60
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "y":120,
                                                        "x":23,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CreatPlayerPanel_Label13",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                                this.fontWeight = "bold";
                                                                this.fontSize = 12;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"commonNormalColor",
                                                                    "percentWidth":35
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"cp_zone",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.focusThickness = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "maxChars":3,
                                                                    "styleName":"YellowInput",
                                                                    "percentWidth":60,
                                                                    "enabled":true,
                                                                    "editable":false
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
                                    "id":"discript_random",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":616,
                                            "height":22,
                                            "y":625,
                                            "x":293,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_CreatPlayerPanel_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xAE0000;
                                                    this.textDecoration = "underline";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_CreatPlayerPanel_RadioButton1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "groupName":"cp_sex",
                                            "selected":true,
                                            "x":280,
                                            "y":643
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"_CreatPlayerPanel_RadioButton2",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "groupName":"cp_sex",
                                            "x":385,
                                            "y":643
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CreatPlayerPanel_Label14",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xAE0000;
                                        this.textDecoration = "underline";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":141,
                                            "x":753,
                                            "y":550,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"bt_createPlayer",
                                    "events":{"click":"__bt_createPlayer_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.bottom = "20";
                                        this.left = "550";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"y125"});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var flagContainer:UIComponent = new UIComponent();
        public var countryArrayCollection:ArrayCollection = new ArrayCollection();
        private var zoneInfoTooltip:ZoneInfoTooltip = ZoneInfoTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CreatPlayerPanel()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            _CreatPlayerPanel_RadioButtonGroup3_i();
            _CreatPlayerPanel_RadioButtonGroup1_i();
            _CreatPlayerPanel_RadioButtonGroup2_i();
            _CreatPlayerPanel_WipeLeft1_i();
            this.addEventListener("creationComplete", ___CreatPlayerPanel_VBox1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CreatPlayerPanel._watcherSetupUtil = _arg_1;
        }


        public function set mapContainer(_arg_1:Canvas):void
        {
            var _local_2:Object = this._262140283mapContainer;
            if (_local_2 !== _arg_1)
            {
                this._262140283mapContainer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapContainer", _local_2, _arg_1));
            };
        }

        public function __bt_createPlayer_click(_arg_1:MouseEvent):void
        {
            doCreatePlayer();
        }

        private function init():void
        {
            instance = this;
            content.addChild(this.flagContainer);
            MouseManager.setNormal();
            trace((this.className + ".init()"));
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.COMMON_ZONE_INFO, onZoneInfo);
            MsgDispacther.getInstance().addEventListener(CreatPlayerPanel.EVENT_AREA_CHANGE, choiceArea);
            MsgDispacther.getInstance().addEventListener(CreatPlayerPanel.EVENT_AREA_OVER, overHandler);
            MsgDispacther.getInstance().addEventListener(CreatPlayerPanel.EVENT_AREA_MOVE, moveHandler);
            MsgDispacther.getInstance().addEventListener(CreatPlayerPanel.EVENT_AREA_OUT, outHandler);
            ActionFactory.getInstance().getCommonCommands().zoneInfo();
            this.resetFaceArray();
        }

        [Bindable(event="propertyChange")]
        public function get choiseVS():ViewStack
        {
            return (this._1828964878choiseVS);
        }

        private function outHandler(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this.zoneInfoTooltip);
        }

        private function _CreatPlayerPanel_RadioButtonGroup3_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            cp_sex = _local_1;
            _local_1.addEventListener("itemClick", __cp_sex_itemClick);
            _local_1.initialized(this, "cp_sex");
            return (_local_1);
        }

        public function set discript_users(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1006753127discript_users;
            if (_local_2 !== _arg_1)
            {
                this._1006753127discript_users = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "discript_users", _local_2, _arg_1));
            };
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceArrayIndex = (this.faceArrayIndex + _arg_1);
            if (this.faceArrayIndex < 0)
            {
                this.faceArrayIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceArrayIndex >= this.faceArray.length)
                {
                    this.faceArrayIndex = 0;
                };
            };
            this.faceSource = this.faceArray[this.faceArrayIndex];
        }

        private function doCreatePlayer():void
        {
            if (InputTextFilter.specialCharFilter(cp_username.text))
            {
                AlertWin.show(Lang.msg("玩家名字不合法"), null);
            }
            else
            {
                if (InputTextFilter.specialCharFilter(cp_flag.text))
                {
                    AlertWin.show(Lang.msg("旗号名字不合法"), null);
                }
                else
                {
                    ActionFactory.getInstance().getCommonCommands().createNewPlayer(this.cp_username.text, this.sex, this.faceSource, this.cp_flag.text, this.cp_cityName.text, int(this.zoneId), "");
                };
            };
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            moveToMouse(zoneInfoTooltip);
        }

        private function textChange(_arg_1:Event):void
        {
            var _local_4:String;
            var _local_2:int;
            InputTextControl.textChange(_arg_1);
            TextInput(_arg_1.currentTarget).maxChars = 20;
            var _local_3:int;
            while (_local_3 < _arg_1.target.text.length)
            {
                _local_4 = _arg_1.target.text.substr(_local_3, 1);
                if (InputTextFilter.isChinese(_local_4))
                {
                    _local_2 = (_local_2 + 2);
                }
                else
                {
                    _local_2 = (_local_2 + 1);
                };
                if (((_arg_1.currentTarget == this.cp_username) && (_local_2 > 10)))
                {
                    this.cp_username.text = this.cp_username.text.substring(0, _local_3);
                    this.cp_username.maxChars = this.cp_username.length;
                    return;
                };
                if (((_arg_1.currentTarget == this.cp_flag) && (_local_2 > 4)))
                {
                    this.cp_flag.text = this.cp_flag.text.substring(0, _local_3);
                    this.cp_flag.maxChars = this.cp_flag.length;
                    return;
                };
                if (((_arg_1.currentTarget == this.cp_cityName) && (_local_2 > 10)))
                {
                    this.cp_cityName.text = this.cp_cityName.text.substring(0, _local_3);
                    this.cp_cityName.maxChars = this.cp_cityName.length;
                    return;
                };
                _local_3++;
            };
        }

        public function set choiseVS(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1828964878choiseVS;
            if (_local_2 !== _arg_1)
            {
                this._1828964878choiseVS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "choiseVS", _local_2, _arg_1));
            };
        }

        private function _CreatPlayerPanel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("字数限制10");
            _local_1 = Lang.msg("字数限制4");
            _local_1 = (Lang.msg("玩家数") + ": ");
            _local_1 = (Lang.msg("城池数量") + ": ");
            _local_1 = (Lang.msg("Crowding") + ": ");
            _local_1 = this.faceSource;
            _local_1 = (Lang.msg("绰号") + ": ");
            _local_1 = Lang.msg("绰号");
            _local_1 = (Lang.msg("玩家旗号") + ": ");
            _local_1 = Lang.msg("军旗");
            _local_1 = (Lang.msg("城堡名称") + ": ");
            _local_1 = Lang.msg("城堡名称");
            _local_1 = (Lang.msg("地理位置") + ": ");
            _local_1 = countryName;
            _local_1 = Lang.msg("选择洲的描述提示");
            _local_1 = Lang.msg("男");
            _local_1 = Lang.msg("女");
            _local_1 = Lang.msg("字数限制10");
            _local_1 = Lang.msg("开始游戏");
        }

        private function handleSex(_arg_1:ItemClickEvent):void
        {
            this.sex = _arg_1.index;
            this.resetFaceArray();
        }

        [Bindable(event="propertyChange")]
        public function get countryName():String
        {
            return (this._1476752575countryName);
        }

        public function set cityNum(_arg_1:Label):void
        {
            var _local_2:Object = this._785423899cityNum;
            if (_local_2 !== _arg_1)
            {
                this._785423899cityNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityNum", _local_2, _arg_1));
            };
        }

        public function __cp_username_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get cityNum():Label
        {
            return (this._785423899cityNum);
        }

        [Bindable(event="propertyChange")]
        public function get showMsg():Canvas
        {
            return (this._2067273540showMsg);
        }

        public function __cp_sex_itemClick(_arg_1:ItemClickEvent):void
        {
            handleSex(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get cp_zone():TextInput
        {
            return (this._966495294cp_zone);
        }

        [Bindable(event="propertyChange")]
        public function get radiogroup2():RadioButtonGroup
        {
            return (this._164873550radiogroup2);
        }

        [Bindable(event="propertyChange")]
        public function get radiogroup3():RadioButtonGroup
        {
            return (this._164873551radiogroup3);
        }

        public function set cp_cityName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._624601640cp_cityName;
            if (_local_2 !== _arg_1)
            {
                this._624601640cp_cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_cityName", _local_2, _arg_1));
            };
        }

        private function setArrayName(_arg_1:ZoneInfoBean):void
        {
            zhouName.text = _arg_1.name;
            trace(((((this.className + ".setArrayName(): playerCount:") + _arg_1.playerCount) + " castleCount:") + _arg_1.castleCount));
            hostNum.text = ((_arg_1.playerCount + "") as String);
            cityNum.text = ((_arg_1.castleCount + "") as String);
            crowd.text = ((_arg_1.rate + "%") as String);
            this.zoneId = _arg_1.id;
        }

        [Bindable(event="propertyChange")]
        public function get cp_cityName():TextInput
        {
            return (this._624601640cp_cityName);
        }

        [Bindable(event="propertyChange")]
        public function get wipe():WipeLeft
        {
            return (this._3649607wipe);
        }

        [Bindable(event="propertyChange")]
        public function get zhouName():Label
        {
            return (this._1026093505zhouName);
        }

        [Bindable(event="propertyChange")]
        public function get discript_random():Canvas
        {
            return (this._1246832046discript_random);
        }

        public function set crowd(_arg_1:Label):void
        {
            var _local_2:Object = this._94935213crowd;
            if (_local_2 !== _arg_1)
            {
                this._94935213crowd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "crowd", _local_2, _arg_1));
            };
        }

        public function set cp_flag(_arg_1:TextInput):void
        {
            var _local_2:Object = this._965896190cp_flag;
            if (_local_2 !== _arg_1)
            {
                this._965896190cp_flag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_flag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cp_username():TextInput
        {
            return (this._1780570216cp_username);
        }

        private function _CreatPlayerPanel_RadioButtonGroup2_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            radiogroup3 = _local_1;
            _local_1.initialized(this, "radiogroup3");
            return (_local_1);
        }

        private function resetFaceArray():void
        {
            this.faceArrayIndex = 0;
            if (this.sex == 0)
            {
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            this.faceSource = this.faceArray[this.faceArrayIndex];
        }

        public function set cp_sex(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._1354303084cp_sex;
            if (_local_2 !== _arg_1)
            {
                this._1354303084cp_sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_sex", _local_2, _arg_1));
            };
        }

        private function onZoneInfo(_arg_1:ZoneInfoResponse):void
        {
            this.countryAry = _arg_1.zonesArray;
            countryNun = countryAry.length;
            randomName();
        }

        public function set cp_zone(_arg_1:TextInput):void
        {
            var _local_2:Object = this._966495294cp_zone;
            if (_local_2 !== _arg_1)
            {
                this._966495294cp_zone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_zone", _local_2, _arg_1));
            };
        }

        public function set zhouName(_arg_1:Label):void
        {
            var _local_2:Object = this._1026093505zhouName;
            if (_local_2 !== _arg_1)
            {
                this._1026093505zhouName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zhouName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get content():Canvas
        {
            return (this._951530617content);
        }

        public function set countryName(_arg_1:String):void
        {
            var _local_2:Object = this._1476752575countryName;
            if (_local_2 !== _arg_1)
            {
                this._1476752575countryName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "countryName", _local_2, _arg_1));
            };
        }

        public function set hostNum(_arg_1:Label):void
        {
            var _local_2:Object = this._1098677438hostNum;
            if (_local_2 !== _arg_1)
            {
                this._1098677438hostNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hostNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get mapContainer():Canvas
        {
            return (this._262140283mapContainer);
        }

        public function __cp_cityName_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        public function set showMsg(_arg_1:Canvas):void
        {
            var _local_2:Object = this._2067273540showMsg;
            if (_local_2 !== _arg_1)
            {
                this._2067273540showMsg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showMsg", _local_2, _arg_1));
            };
        }

        public function set wipe(_arg_1:WipeLeft):void
        {
            var _local_2:Object = this._3649607wipe;
            if (_local_2 !== _arg_1)
            {
                this._3649607wipe = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wipe", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:CreatPlayerPanel;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CreatPlayerPanel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_CreatPlayerPanelWatcherSetupUtil");
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
        public function get discript_users():Canvas
        {
            return (this._1006753127discript_users);
        }

        private function _CreatPlayerPanel_RadioButtonGroup1_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            radiogroup2 = _local_1;
            _local_1.initialized(this, "radiogroup2");
            return (_local_1);
        }

        public function set discript_random(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1246832046discript_random;
            if (_local_2 !== _arg_1)
            {
                this._1246832046discript_random = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "discript_random", _local_2, _arg_1));
            };
        }

        private function selectName(_arg_1:Event):void
        {
            countryName = ((ZoneInfoBean(_arg_1.target.value).name + "") as String);
            this.choiseVS.selectedChild = discript_users;
        }

        public function ___CreatPlayerPanel_Button1_click(_arg_1:MouseEvent):void
        {
            changeFace(-1);
        }

        public function set radiogroup2(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._164873550radiogroup2;
            if (_local_2 !== _arg_1)
            {
                this._164873550radiogroup2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radiogroup2", _local_2, _arg_1));
            };
        }

        public function set bt_createPlayer(_arg_1:Button):void
        {
            var _local_2:Object = this._1760498230bt_createPlayer;
            if (_local_2 !== _arg_1)
            {
                this._1760498230bt_createPlayer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bt_createPlayer", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get crowd():Label
        {
            return (this._94935213crowd);
        }

        private function _CreatPlayerPanel_WipeLeft1_i():WipeLeft
        {
            var _local_1:WipeLeft = new WipeLeft();
            wipe = _local_1;
            _local_1.duration = 200;
            return (_local_1);
        }

        private function _CreatPlayerPanel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("字数限制10");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label1.text = _arg_1;
            }, "_CreatPlayerPanel_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("字数限制4");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label2.text = _arg_1;
            }, "_CreatPlayerPanel_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label4.text = _arg_1;
            }, "_CreatPlayerPanel_Label4.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城池数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label5.text = _arg_1;
            }, "_CreatPlayerPanel_Label5.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("Crowding") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label6.text = _arg_1;
            }, "_CreatPlayerPanel_Label6.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.faceSource);
            }, function (_arg_1:Object):void
            {
                _CreatPlayerPanel_Image2.source = _arg_1;
            }, "_CreatPlayerPanel_Image2.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("绰号") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label10.text = _arg_1;
            }, "_CreatPlayerPanel_Label10.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("绰号");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cp_username.text = _arg_1;
            }, "cp_username.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("玩家旗号") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label11.text = _arg_1;
            }, "_CreatPlayerPanel_Label11.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军旗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cp_flag.text = _arg_1;
            }, "cp_flag.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("城堡名称") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label12.text = _arg_1;
            }, "_CreatPlayerPanel_Label12.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城堡名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cp_cityName.text = _arg_1;
            }, "cp_cityName.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("地理位置") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label13.text = _arg_1;
            }, "_CreatPlayerPanel_Label13.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = countryName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cp_zone.text = _arg_1;
            }, "cp_zone.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择洲的描述提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Text1.text = _arg_1;
            }, "_CreatPlayerPanel_Text1.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("男");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_RadioButton1.label = _arg_1;
            }, "_CreatPlayerPanel_RadioButton1.label");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("女");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_RadioButton2.label = _arg_1;
            }, "_CreatPlayerPanel_RadioButton2.label");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("字数限制10");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreatPlayerPanel_Label14.text = _arg_1;
            }, "_CreatPlayerPanel_Label14.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开始游戏");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                bt_createPlayer.label = _arg_1;
            }, "bt_createPlayer.label");
            result[18] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get cp_sex():RadioButtonGroup
        {
            return (this._1354303084cp_sex);
        }

        private function set faceSource(_arg_1:String):void
        {
            var _local_2:Object = this._571486424faceSource;
            if (_local_2 !== _arg_1)
            {
                this._571486424faceSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceSource", _local_2, _arg_1));
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function set radiogroup3(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._164873551radiogroup3;
            if (_local_2 !== _arg_1)
            {
                this._164873551radiogroup3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "radiogroup3", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hostNum():Label
        {
            return (this._1098677438hostNum);
        }

        [Bindable(event="propertyChange")]
        public function get bt_createPlayer():Button
        {
            return (this._1760498230bt_createPlayer);
        }

        public function set cp_username(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1780570216cp_username;
            if (_local_2 !== _arg_1)
            {
                this._1780570216cp_username = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_username", _local_2, _arg_1));
            };
        }

        private function overHandler(_arg_1:CreatPlayerAreaChangeEvent):void
        {
            this.zoneInfoTooltip.zoneInfo = ZoneInfoBean(this.countryAry.getItemAt(_arg_1.areaId));
            moveToMouse(zoneInfoTooltip);
            PopUpManager.addPopUp(this.zoneInfoTooltip, this);
        }

        public function ___CreatPlayerPanel_Image2_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        private function choiceArea(_arg_1:CreatPlayerAreaChangeEvent):void
        {
            var _local_3:CreatPlayerMap;
            var _local_2:int;
            while (_local_2 < this.mapContainer.getChildren().length)
            {
                _local_3 = (this.mapContainer.getChildAt(_local_2) as CreatPlayerMap);
                _local_3.gotoUp();
                _local_2++;
            };
            _arg_1.creatPlayerMap.gotoSelect();
            countryName = ((ZoneInfoBean(this.countryAry.getItemAt(_arg_1.areaId)).name + "") as String);
            setArrayName(ZoneInfoBean(this.countryAry.getItemAt(_arg_1.areaId)));
            this.choiseVS.selectedChild = discript_users;
            if (this.flagMC == null)
            {
                this.flagMC = new EvonyAnimation();
                this.flagMC.load(EvonyAnimation.TYPE_Banner, -1);
                this.flagMC.gotoAndStopNative("yellow_s");
                this.flagContainer.addChild(this.flagMC);
            };
            this.flagContainer.x = (stage.mouseX - 30);
            this.flagContainer.y = (stage.mouseY - 50);
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        private function moveToMouse(_arg_1:DisplayObject):void
        {
            _arg_1.x = (stage.mouseX + 10);
            _arg_1.y = (stage.mouseY + 20);
            var _local_2:int = Application.application.width;
            var _local_3:int = Application.application.height;
            if ((this.x + this.width) > _local_2)
            {
                _arg_1.x = (_local_2 - _arg_1.width);
            };
            if ((_arg_1.y + _arg_1.height) > _local_3)
            {
                _arg_1.y = (_local_3 - _arg_1.height);
            };
            if (((_arg_1.x == (_local_2 - _arg_1.width)) && (_arg_1.y == (_local_3 - _arg_1.height))))
            {
                _arg_1.x = ((stage.mouseX - _arg_1.width) - 10);
            };
        }

        public function ___CreatPlayerPanel_VBox1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___CreatPlayerPanel_Button2_click(_arg_1:MouseEvent):void
        {
            changeFace(1);
        }

        private function randomName():void
        {
            var _local_3:Boolean;
            var _local_4:int;
            var _local_1:int = int(int((Math.random() * 16)));
            var _local_2:ZoneInfoBean = ZoneInfoBean(countryAry.getItemAt(_local_1));
            if (_local_2.rate < 100)
            {
                this.zoneId = _local_1;
            }
            else
            {
                _local_3 = true;
                _local_4 = 0;
                while (_local_4 < countryAry.length)
                {
                    _local_2 = ZoneInfoBean(countryAry.getItemAt(_local_4));
                    if (_local_2.rate < 100)
                    {
                        _local_3 = false;
                        this.zoneId = _local_4;
                        break;
                    };
                    _local_4++;
                };
                if (_local_3)
                {
                    AlertWin.show(Lang.msg("服务器已满"));
                };
            };
            countryName = ((_local_1 + "") as String);
            countryName = Lang.msg("随机");
            setArrayName(ZoneInfoBean(countryAry.getItemAt(_local_1)));
        }

        public function __cp_flag_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        public function set content(_arg_1:Canvas):void
        {
            var _local_2:Object = this._951530617content;
            if (_local_2 !== _arg_1)
            {
                this._951530617content = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "content", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cp_flag():TextInput
        {
            return (this._965896190cp_flag);
        }


    }
}//package view

