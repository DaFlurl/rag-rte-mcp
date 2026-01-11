// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Items.ItemViewWin

package autoevony.gui.info.Items
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.utils.ObjectProxy;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.TextInput;
    import mx.controls.Text;
    import mx.controls.Image;
    import flash.utils.Timer;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import com.evony.common.beans.ZoneInfoBean;
    import com.evony.common.beans.ItemBean;
    import autoevony.gui.MainScreen;
    import com.evony.common.beans.DisappearHeroBean;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.module.hero.DisappearHeroResponse;
    import autoevony.scripts.CityState;
    import com.evony.client.action.ActionFactory;
    import autoevony.common.Utils;
    import autoevony.player.Map;
    import com.evony.common.constants.BuildingConstants;
    import autoevony.player.LoginHelper;
    import autoevony.common.Items;
    import com.evony.common.module.shop.UseItemResultResponse;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.TimerEvent;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.ui.Keyboard;
    import mx.events.PropertyChangeEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
    import com.evony.common.module.common.ZoneInfoResponse;
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

    public class ItemViewWin extends Canvas implements IBindingClient 
    {

        private static var prevValues:ObjectProxy = new ObjectProxy({});
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ItemViewWin_HBox7:HBox;
        private var _847922810zoneInfo:ArrayCollection = null;
        private var _1330884373_buyBtn:Button;
        private var _1579933872_zone_Select:ComboBox;
        private var _2053243474_useCountInput1:ItemCountInput;
        private var pleaseStop:Boolean = true;
        public var _ItemViewWin_HBox4:HBox;
        private var _1469343204_pName:TextInput;
        private var howManyUsed:int = 0;
        private var _458286896_itemDescArea:Text;
        private var _344839367_closeWinBtn:Button;
        public var _ItemViewWin_Text1:Text;
        public var _ItemViewWin_Image1:Image;
        private var _1183315619_closeBtn:Button;
        private var howManyToUse:int = 0;
        private var timeOutTimer:Timer = null;
        private var _327260383_useBtnArea:HBox;
        private var _2041142742disappearHeros:ArrayCollection = null;
        private var _95768648_dh_Select:ComboBox;
        private var _9487016_useItemResultsArea:TextArea;
        private var _1095002739_openBtn:Button;
        private var _1919807313_xInput:TextInput;
        public var _ItemViewWin_Label1:Label;
        public var _ItemViewWin_Label2:Label;
        private var _1177034077itemData:ObjectProxy = null;
        public var _ItemViewWin_Label6:Label;
        public var _ItemViewWin_Label7:Label;
        public var _ItemViewWin_Label8:Label;
        private var closeFunc:Function = null;
        private var _1948436464_yInput:TextInput;
        public var _ItemViewWin_HBox2:HBox;
        public var _ItemViewWin_HBox3:HBox;
        public var _ItemViewWin_HBox5:HBox;
        public var _ItemViewWin_HBox6:HBox;
        public var _ItemViewWin_HBox9:HBox;
        private var _1872395380_useBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":364,
                    "width":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Item View"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":364,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "15";
                                        this.top = "50";
                                        this.right = "15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":74,
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "4";
                                                    this.top = "4";
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
                                                        "width":64,
                                                        "height":64,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Image,
                                                            "id":"_ItemViewWin_Image1",
                                                            "events":{"complete":"___ItemViewWin_Image1_complete"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":64,
                                                                    "height":64
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_ItemViewWin_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "73";
                                                    this.top = "4";
                                                    this.right = "5";
                                                    this.textAlign = "center";
                                                    this.verticalCenter = "middle";
                                                    this.fontSize = 16;
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"cityTopInfoText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ItemViewWin_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "73";
                                                    this.top = "28";
                                                    this.right = "5";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"newArmyTroop"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ItemViewWin_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "73";
                                                    this.top = "50";
                                                    this.right = "85";
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"newArmyTroop"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_buyBtn",
                                                "events":{"click":"___buyBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Buy More",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "15";
                                        this.top = "130";
                                        this.right = "15";
                                        this.bottom = "51";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_itemDescArea",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "5";
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"newArmyTroop"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_useItemResultsArea",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.top = "3";
                                                    this.right = "3";
                                                    this.bottom = "3";
                                                    this.backgroundAlpha = 0;
                                                    this.borderThickness = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "visible":false,
                                                        "text":"",
                                                        "editable":false,
                                                        "styleName":"newArmyTroop"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.right = "5";
                                                    this.bottom = "5";
                                                    this.horizontalGap = 5;
                                                    this.horizontalAlign = "center";
                                                    this.paddingLeft = 0;
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
                                                                    "percentHeight":100,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Players:",
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Number of Cities:",
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Player Rate:",
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
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
                                                                    "percentHeight":100,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ItemViewWin_Label6",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ItemViewWin_Label7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_ItemViewWin_Label8",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "percentWidth":100,
                                                                                "styleName":"newArmyTroop"
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
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "15";
                                        this.right = "15";
                                        this.bottom = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":35,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "135";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
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
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"How many to use?",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ItemCountInput,
                                                            "id":"_useCountInput1"
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "135";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
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
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Enter target coordinate:",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"_xInput",
                                                            "events":{
                                                                "change":"___xInput_change",
                                                                "keyDown":"___xInput_keyDown"
                                                            },
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":40,
                                                                    "height":22,
                                                                    "text":"0",
                                                                    "maxChars":3,
                                                                    "restrict":"0-9",
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"_yInput",
                                                            "events":{"change":"___yInput_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":40,
                                                                    "height":22,
                                                                    "text":"0",
                                                                    "maxChars":3,
                                                                    "restrict":"0-9",
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "135";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
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
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Enter target player name:",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"_pName",
                                                            "events":{"change":"___pName_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "height":22,
                                                                    "text":"",
                                                                    "restrict":"_ A-Za-z0-9",
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "135";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
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
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Select a state or choose random:",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"_zone_Select",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":135,
                                                                    "styleName":"ComboBox"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "3";
                                                    this.right = "135";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
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
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Select which hero to rescue:",
                                                                    "styleName":"newArmyTroop"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"_dh_Select",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":150,
                                                                    "styleName":"ComboBox"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_useBtnArea",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "3";
                                                    this.right = "5";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_useBtn",
                                                            "events":{"click":"___useBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Use",
                                                                    "styleName":"REwinBtn"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "id":"_ItemViewWin_HBox9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "3";
                                                    this.right = "5";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 5;
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.paddingLeft = 0;
                                                    this.paddingRight = 0;
                                                    this.paddingTop = 0;
                                                    this.paddingBottom = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":120,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_closeBtn",
                                                            "events":{"click":"___closeBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Close",
                                                                    "styleName":"REwinBtn"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_openBtn",
                                                            "events":{"click":"___openBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Open",
                                                                    "styleName":"REwinBtn"
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
                        "type":Button,
                        "id":"_closeWinBtn",
                        "events":{"click":"___closeWinBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ItemViewWin()
        {
            mx_internal::_document = this;
            this.height = 364;
            this.width = 500;
            this.addEventListener("creationComplete", this.___ItemViewWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ItemViewWin._watcherSetupUtil = _arg_1;
        }


        private function getIconUrl(_arg_1:String):String
        {
            return ("http://e2.eimg.us/" + _arg_1);
        }

        private function getRandomZone():ZoneInfoBean
        {
            return (ZoneInfoBean(this.zoneInfo.getItemAt(int((Math.random() * 16))).data));
        }

        private function getItemCount(_arg_1:String):int
        {
            var _local_2:ItemBean;
            for each (_local_2 in MainScreen.getPlayer().itemsArray)
            {
                if (((!(_local_2.id == null)) && (_local_2.id == _arg_1)))
                {
                    return (Math.max(_local_2.count, 0));
                };
            };
            return (0);
        }

        private function showRescueHeroSelector(_arg_1:String):Boolean
        {
            return (this.isSoF(_arg_1));
        }

        private function isCastleItem(_arg_1:String):Boolean
        {
            return ((((_arg_1 == "player.halloween.castle") || (_arg_1 == "player.halloween.castle.adv")) || (_arg_1 == "player.haunted.castle")) || (_arg_1 == "player.haunted.castle.adv"));
        }

        private function onGetDisappearHerosResponse(_arg_1:DisappearHeroResponse):void
        {
            var _local_2:DisappearHeroBean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((_arg_1.errorMsg + ": ") + _arg_1.ok)));
            }
            else
            {
                if (this.disappearHeros == null)
                {
                    this.disappearHeros = new ArrayCollection();
                }
                else
                {
                    this.disappearHeros.removeAll();
                };
                for each (_local_2 in _arg_1.herosArray)
                {
                    this.disappearHeros.addItem({
                        "label":(((((((((((("[" + _local_2.id) + "] ") + _local_2.name) + "(") + _local_2.level) + ")") + " ") + _local_2.management) + "/") + _local_2.power) + "/") + _local_2.stratagem),
                        "data":_local_2.id
                    });
                };
            };
        }

        private function init():void
        {
        }

        private function isDream(_arg_1:String):Boolean
        {
            return (_arg_1 == "player.truce.dream");
        }

        [Bindable(event="propertyChange")]
        public function get _yInput():TextInput
        {
            return (this._1948436464_yInput);
        }

        private function onUseBtn(_arg_1:String=""):void
        {
            var _local_4:int;
            if (((this._useBtnArea.visible) && (this._useBtn.label == "Cancel")))
            {
                this.pleaseStop = true;
                return;
            };
            var _local_2:String = this.itemData.id;
            if (this.isGateControl(_local_2))
            {
                this._openBtn.enabled = false;
                this._closeBtn.enabled = false;
            }
            else
            {
                this._useBtn.enabled = false;
            };
            this._closeWinBtn.enabled = false;
            if (this.showCoordFields(_local_2))
            {
                prevValues[_local_2.split(".").join("_")] = ((this._xInput.text + ",") + this._yInput.text);
            }
            else
            {
                if (this.showPlayerNameField(_local_2))
                {
                    prevValues[_local_2.split(".").join("_")] = this._pName.text;
                };
            };
            var _local_3:CityState = MainScreen.getInstance().getSelectedCity();
            if (((this.isTeleport(_local_2)) || (this.isAdvTeleport(_local_2))))
            {
                _local_3.cityManager._recallIncomingArmies();
                if (this.isTeleport(_local_2))
                {
                    ActionFactory.getInstance().getCityCommands().moveCastle(_local_3.castle.id, (this.zoneInfo.getItemAt(this._zone_Select.selectedIndex).data as ZoneInfoBean).id, this.onSpecialResponse);
                }
                else
                {
                    if (_local_2 != "player.move.castle.1.b")
                    {
                        if (((!((_local_4 = _local_3.cityManager.getLocalBuffIndexFromTypeId("MoveCastleCoolDownBuff")) == -1)) && (Utils.getServerTime() < _local_3.castle.buffsArray[_local_4].endTime)))
                        {
                            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((("The " + this.itemData.name) + " is on cooldown for this city for ") + Utils.formatTime(((_local_3.castle.buffsArray[_local_4].endTime - Utils.getServerTime()) / 1000)))));
                            this._useBtn.enabled = true;
                            this._closeWinBtn.enabled = true;
                        }
                        else
                        {
                            if (_local_2 == "player.more.castle.1.a")
                            {
                                ActionFactory.getInstance().getCityCommands().advMoveCastle(_local_3.castle.id, Map.getFieldId(int(this._xInput.text), int(this._yInput.text)), this.onSpecialResponse);
                            }
                            else
                            {
                                if (_local_2 == "player.more.castle.1.c")
                                {
                                    ActionFactory.getInstance().getCityCommands().WarMoveCastle(_local_3.castle.id, Map.getFieldId(int(this._xInput.text), int(this._yInput.text)), this.onSpecialResponse);
                                };
                            };
                        };
                    }
                    else
                    {
                        ActionFactory.getInstance().getCityCommands().uniteAdvMoveCastle(_local_3.castle.id, Map.getFieldId(int(this._xInput.text), int(this._yInput.text)), this.onSpecialResponse);
                    };
                };
            }
            else
            {
                if (this.isCastleStrat(_local_2))
                {
                    ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(_local_3.castle.id, Map.getFieldId(int(this._xInput.text), int(this._yInput.text)));
                    ActionFactory.getInstance().getShopCommands().useTrickItem(Map.getFieldId(int(this._xInput.text), int(this._yInput.text)), 0, _local_2, this.onSpecialResponse);
                }
                else
                {
                    if (((this.isDevil(_local_2)) || (this.isGateControl(_local_2))))
                    {
                        ActionFactory.getInstance().getShopCommands().useDevilItem(int(this._xInput.text), int(this._yInput.text), _local_2, _arg_1, this.onSpecialResponse);
                    }
                    else
                    {
                        if (this.isAngel(_local_2))
                        {
                            ActionFactory.getInstance().getShopCommands().useAngelItem(this._pName.text, _local_2, this.onSpecialResponse);
                        }
                        else
                        {
                            if (this.isSoF(_local_2))
                            {
                                if (_local_3.cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) <= (_local_3.cityManager.heroes.length - ((Utils.isRoyalFound(_local_3.cityManager.heroes)) ? 1 : 0)))
                                {
                                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Feasting hall is full! Free up a slot or select another city before trying to rescue a hero."));
                                    this._useBtn.enabled = true;
                                    this._closeWinBtn.enabled = true;
                                }
                                else
                                {
                                    if (((!(this.disappearHeros == null)) && (this.disappearHeros.length > 0)))
                                    {
                                        ActionFactory.getInstance().getHeroCommand().RecoverDisappearHero(_local_3.castle.id, this._dh_Select.selectedItem.data, this.onSpecialResponse);
                                    }
                                    else
                                    {
                                        this._useBtn.enabled = true;
                                        this._closeWinBtn.enabled = true;
                                    };
                                };
                            }
                            else
                            {
                                if (this.isTruce(_local_2))
                                {
                                    if (((!((_local_4 = _local_3.cityManager.getBuffIndexFromTypeId("PlayerPeaceBuff")) == -1)) && (Utils.getServerTime() < _local_3.player.buffsArray[_local_4].endTime)))
                                    {
                                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ("Account status is already protected under Truce Agreement for " + Utils.formatTime(((_local_3.player.buffsArray[_local_4].endTime - Utils.getServerTime()) / 1000)))));
                                        this._useBtn.enabled = true;
                                        this._closeWinBtn.enabled = true;
                                    }
                                    else
                                    {
                                        if (((!((_local_4 = _local_3.cityManager.getBuffIndexFromTypeId("PlayerPeaceCoolDownBuff")) == -1)) && (Utils.getServerTime() < _local_3.player.buffsArray[_local_4].endTime)))
                                        {
                                            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ("Truce Agreement has already been used within 24 hours and is on cooldown for " + Utils.formatTime(((_local_3.player.buffsArray[_local_4].endTime - Utils.getServerTime()) / 1000)))));
                                            this._useBtn.enabled = true;
                                            this._closeWinBtn.enabled = true;
                                        }
                                        else
                                        {
                                            ActionFactory.getInstance().getCityCommands().setStopWarState(_local_2, LoginHelper.getInstance().getHashedEvonyPw(), this.onSpecialResponse);
                                        };
                                    };
                                }
                                else
                                {
                                    if (((this.isSpeechOrCivCode(_local_2)) || (this.isCastleItem(_local_2))))
                                    {
                                        ActionFactory.getInstance().getShopCommands().useCastleGoods(_local_3.castle.id, _local_2, this.onSpecialResponse);
                                    }
                                    else
                                    {
                                        if (this.isHeroHunting(_local_2))
                                        {
                                            ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(_local_3.castle.id, this.onSpecialResponse);
                                        }
                                        else
                                        {
                                            if (int(this._useCountInput1._useCountInput.text) > 1)
                                            {
                                                this.onUseItems(int(this._useCountInput1._useCountInput.text));
                                            }
                                            else
                                            {
                                                ActionFactory.getInstance().getShopCommands().useGoods(_local_3.castle.id, _local_2, 1, this.onUseGood);
                                                this.timeOutTimer.start();
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function onUseGoods(_arg_1:UseItemResultResponse):void
        {
            var _local_2:String;
            var _local_3:ItemBean;
            this.timeOutTimer.reset();
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((((((("Error received after successfully using " + this.howManyUsed) + " of ") + this.itemData.name) + ". Item use has been stopped.  ") + _arg_1.errorMsg) + ": ") + _arg_1.ok)));
                this.cleanUpAfterUseItem();
            }
            else
            {
                this.howManyUsed++;
                _local_2 = "Item used successfully\n";
                for each (_local_3 in _arg_1.itemBeansArray)
                {
                    if (!((Items.getItemName(_local_3.id) == "money") && (_local_3.count == 0)))
                    {
                        _local_2 = (((((_local_2 + "  Got: ") + _local_3.count) + " ") + Items.getItemName(_local_3.id)) + "\n");
                    };
                };
                this._useItemResultsArea.text = (this._useItemResultsArea.text + _local_2);
                this.setScrollPos(this._useItemResultsArea);
                Utils.callLater(500, this.useGoods);
            };
        }

        private function useGoods():void
        {
            if (((this.pleaseStop) || ((this.howManyToUse - this.howManyUsed) < 1)))
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (((("Successfully used " + this.howManyUsed) + " ") + this.itemData.name) + ".")));
                this.cleanUpAfterUseItem();
            }
            else
            {
                ActionFactory.getInstance().getShopCommands().useGoods(MainScreen.getInstance().getSelectedCity().castle.id, this.itemData.id, 1, this.onUseGoods);
                this.timeOutTimer.start();
            };
        }

        public function updateInfo(_arg_1:Array=null, _arg_2:Function=null):void
        {
            this.itemData = new ObjectProxy(_arg_1[0]);
            this.updateItemCount();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            var _local_3:String = this.itemData.id;
            if (this.isTeleport(_local_3))
            {
                ActionFactory.getInstance().getCommonCommands().zoneInfo(this.onZoneInfoResponse);
            }
            else
            {
                if (this.isSoF(_local_3))
                {
                    ActionFactory.getInstance().getHeroCommand().GetDisappearHeros(this.onGetDisappearHerosResponse);
                };
            };
            if (this._useBtnArea.visible)
            {
                this._useBtn.label = (((this.isTeleport(_local_3)) || (this.isAdvTeleport(_local_3))) ? "Teleport" : ((this.isSoF(_local_3)) ? "Rescue" : "Use"));
            };
            this.closeFunc = _arg_2;
            var _local_4:String = this.getPrevValues(_local_3);
            if (_local_4 == null)
            {
                return;
            };
            if (this.showCoordFields(_local_3))
            {
                this._xInput.text = _local_4.split(",")[0];
                this._yInput.text = _local_4.split(",")[1];
            }
            else
            {
                if (this.showPlayerNameField(_local_3))
                {
                    this._pName.text = _local_4;
                };
            };
            this.timeOutTimer = new Timer(5000, 1);
            this.timeOutTimer.addEventListener(TimerEvent.TIMER, this.onTimeOut);
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.enterKeyDownHandle);
        }

        private function moveCursorToEnd(txtCtrl:TextInput):void
        {
            Utils.callLater(50, function ():void
            {
                var _local_1:int = txtCtrl.text.length;
                if (((!(txtCtrl.selectionEndIndex == _local_1)) || (!(txtCtrl.selectionBeginIndex == _local_1))))
                {
                    txtCtrl.selectionEndIndex = (txtCtrl.selectionBeginIndex = _local_1);
                };
            });
        }

        [Bindable(event="propertyChange")]
        public function get _buyBtn():Button
        {
            return (this._1330884373_buyBtn);
        }

        private function onUseGood(_arg_1:UseItemResultResponse):void
        {
            var _local_2:String;
            var _local_3:ItemBean;
            this.timeOutTimer.reset();
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((_arg_1.errorMsg + ": ") + _arg_1.ok)));
            }
            else
            {
                this._itemDescArea.visible = false;
                this._useItemResultsArea.visible = true;
                _local_2 = "Item used successfully\n";
                for each (_local_3 in _arg_1.itemBeansArray)
                {
                    if (!((Items.getItemName(_local_3.id) == "money") && (_local_3.count == 0)))
                    {
                        _local_2 = (((((_local_2 + "  Got: ") + _local_3.count) + " ") + Items.getItemName(_local_3.id)) + "\n");
                    };
                };
                this._useItemResultsArea.text = (this._useItemResultsArea.text + _local_2);
                this.setScrollPos(this._useItemResultsArea);
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Successfully used " + this.itemData.name) + ".")));
            };
            this._closeWinBtn.enabled = true;
            this._useBtn.enabled = true;
        }

        private function showCloseAndOpenBtns(_arg_1:String):Boolean
        {
            return (this.isGateControl(_arg_1));
        }

        public function ___buyBtn_click(_arg_1:MouseEvent):void
        {
            this.onBuyBtn();
        }

        [Bindable(event="propertyChange")]
        public function get _useBtnArea():HBox
        {
            return (this._327260383_useBtnArea);
        }

        private function _ItemViewWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.getIconUrl(this.itemData.iconUrl);
            _local_1 = this.itemData.name;
            _local_1 = ("Type: " + Items.getCommonType(this.itemData.itemType, this.itemData.id));
            _local_1 = ((("Price: " + Utils.formatInt(this.itemData.price)) + " ea          You own: ") + Utils.formatInt(this.itemData.count));
            _local_1 = (this.itemData.price > 0);
            _local_1 = ((this.itemData.price > 0) ? "Click to buy more of this item from the Game Shop." : "This item is not currently available from the Game Shop.");
            _local_1 = this.itemData.desc;
            _local_1 = this.itemData.itemDesc;
            _local_1 = ((this.showZoneSelector(this.itemData.id)) && (this._zone_Select.selectedIndex > 0));
            _local_1 = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.playerCount + "") : "");
            _local_1 = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.castleCount + "") : "");
            _local_1 = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.rate + "%") : "");
            _local_1 = this.showUseCount(this.itemData.id);
            _local_1 = this;
            _local_1 = this.enableUseBtn(this.itemData.count);
            _local_1 = this.showCoordFields(this.itemData.id);
            _local_1 = this.showPlayerNameField(this.itemData.id);
            _local_1 = this.showZoneSelector(this.itemData.id);
            _local_1 = this.zoneInfo;
            _local_1 = this.showRescueHeroSelector(this.itemData.id);
            _local_1 = this.disappearHeros;
            _local_1 = this.showUseBtn(this.itemData.id);
            _local_1 = ((this.enableUseBtn(this.itemData.count)) && ((this.disappearHeros == null) || ((!(this.disappearHeros == null)) && (this.disappearHeros.length > 0))));
            _local_1 = this.showCloseAndOpenBtns(this.itemData.id);
            _local_1 = this.enableUseBtn(this.itemData.count);
            _local_1 = this.enableUseBtn(this.itemData.count);
        }

        private function keyDownHandle(_arg_1:KeyboardEvent):void
        {
            if ((((_arg_1.keyCode == Keyboard.NUMPAD_DECIMAL) || (_arg_1.keyCode == Keyboard.PERIOD)) || (_arg_1.keyCode == Keyboard.COMMA)))
            {
                this._yInput.setFocus();
            };
        }

        public function set _buyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1330884373_buyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1330884373_buyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_buyBtn", _local_2, _arg_1));
            };
        }

        private function getPrevValues(_arg_1:String):String
        {
            _arg_1 = _arg_1.split(".").join("_");
            return (((!(prevValues[_arg_1] == undefined)) && (!(prevValues[_arg_1] == null))) ? prevValues[_arg_1] : "");
        }

        private function set zoneInfo(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._847922810zoneInfo;
            if (_local_2 !== _arg_1)
            {
                this._847922810zoneInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoneInfo", _local_2, _arg_1));
            };
        }

        private function isSpeechOrCivCode(_arg_1:String):Boolean
        {
            return ((_arg_1 == "player.heart.1.a") || (_arg_1 == "player.pop.1.a"));
        }

        internal function onMaxBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + this.itemData.count);
            _arg_1.setFocus();
            this.moveCursorToEnd(_arg_1);
        }

        private function enterKeyDownHandle(_arg_1:KeyboardEvent):void
        {
            if (((_arg_1.keyCode == Keyboard.ENTER) && (this.showUseBtn(this.itemData.id))))
            {
                this.onUseBtn();
            }
            else
            {
                if (_arg_1.keyCode == Keyboard.ESCAPE)
                {
                    this.close();
                };
            };
        }

        private function setScrollPos(target:TextArea):void
        {
            Utils.callLater(50, function ():void
            {
                target.verticalScrollPosition = target.maxVerticalScrollPosition;
            });
        }

        [Bindable(event="propertyChange")]
        public function get _pName():TextInput
        {
            return (this._1469343204_pName);
        }

        public function ___useBtn_click(_arg_1:MouseEvent):void
        {
            this.onUseBtn();
        }

        public function ___ItemViewWin_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set _pName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1469343204_pName;
            if (_local_2 !== _arg_1)
            {
                this._1469343204_pName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_pName", _local_2, _arg_1));
            };
        }

        public function ___closeBtn_click(_arg_1:MouseEvent):void
        {
            this.onUseBtn("0");
        }

        [Bindable(event="propertyChange")]
        public function get _dh_Select():ComboBox
        {
            return (this._95768648_dh_Select);
        }

        public function ___xInput_change(_arg_1:Event):void
        {
            this.onCoordChange((_arg_1.currentTarget as TextInput));
        }

        [Bindable(event="propertyChange")]
        public function get _closeWinBtn():Button
        {
            return (this._344839367_closeWinBtn);
        }

        private function onSpecialResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((_arg_1.errorMsg + ": ") + _arg_1.ok)));
            }
            else
            {
                if (((this.isTeleport(this.itemData.id)) || (this.isAdvTeleport(this.itemData.id))))
                {
                    MainScreen.getInstance().getSelectedCity().cityManager._resetLocalFieldsInfo();
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ("Successfully moved castle to " + ((this.isTeleport(this.itemData.id)) ? (this.zoneInfo.getItemAt(this._zone_Select.selectedIndex).data as ZoneInfoBean).name : ((int(this._xInput.text) + ",") + int(this._yInput.text))))));
                }
                else
                {
                    if ((((this.isCastleStrat(this.itemData.id)) || (this.isDevil(this.itemData.id))) || (this.isAngel(this.itemData.id))))
                    {
                        if (this.itemData.id == Items.getItemId("Advance_by_A_Hidden_Path"))
                        {
                            MainScreen.getInstance().getSelectedCity().cityManager._clearLastAmbushErrorTime();
                        };
                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((("Successfully applied " + this.itemData.name) + " to ") + ((this.isAngel(this.itemData.id)) ? this._pName.text : ((int(this._xInput.text) + ",") + int(this._yInput.text))))));
                    }
                    else
                    {
                        if (this.isSoF(this.itemData.id))
                        {
                            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ("Successfully recovered hero: " + this._dh_Select.selectedItem.label)));
                        }
                        else
                        {
                            if (this.isTruce(this.itemData.id))
                            {
                                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Successfully applied " + this.itemData.name) + ". Account status is Truce for 12 hours.")));
                            }
                            else
                            {
                                if (this.isSpeechOrCivCode(this.itemData.id))
                                {
                                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Successfully applied " + this.itemData.name) + " to the city.")));
                                }
                                else
                                {
                                    if (this.isHeroHunting(this.itemData.id))
                                    {
                                        dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Successfully applied " + this.itemData.name) + ". The hero list at the Inn has been refreshed.")));
                                    }
                                    else
                                    {
                                        if (this.isCastleItem(this.itemData.id))
                                        {
                                            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (((("Successfully applied " + this.itemData.name) + " to the ") + ((this.itemData.id.indexOf(".adv") == -1) ? "castle" : "account")) + ". Rally Spot will now dispatch up to 25% more troops for 15 days.")));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (this.isGateControl(this.itemData.id))
            {
                this._openBtn.enabled = true;
                this._closeBtn.enabled = true;
            }
            else
            {
                this._useBtn.enabled = true;
            };
            this._closeWinBtn.enabled = true;
            if ((((((((this.isTeleport(this.itemData.id)) || (this.isAdvTeleport(this.itemData.id))) || (this.isSoF(this.itemData.id))) || (this.isTruce(this.itemData.id))) || (this.isSpeechOrCivCode(this.itemData.id))) || (this.isHeroHunting(this.itemData.id))) || (this.isCastleItem(this.itemData.id))))
            {
                this.close();
            };
        }

        public function set _closeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1183315619_closeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1183315619_closeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_closeBtn", _local_2, _arg_1));
            };
        }

        private function showZoneSelector(_arg_1:String):Boolean
        {
            return (this.isTeleport(_arg_1));
        }

        public function set _useBtnArea(_arg_1:HBox):void
        {
            var _local_2:Object = this._327260383_useBtnArea;
            if (_local_2 !== _arg_1)
            {
                this._327260383_useBtnArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useBtnArea", _local_2, _arg_1));
            };
        }

        private function isTruce(_arg_1:String):Boolean
        {
            return (_arg_1 == "player.peace.1");
        }

        public function ___pName_change(_arg_1:Event):void
        {
        }

        private function _ItemViewWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.getIconUrl(this.itemData.iconUrl));
            }, function (_arg_1:Object):void
            {
                _ItemViewWin_Image1.source = _arg_1;
            }, "_ItemViewWin_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemData.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Text1.text = _arg_1;
            }, "_ItemViewWin_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("Type: " + Items.getCommonType(this.itemData.itemType, this.itemData.id));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Label1.text = _arg_1;
            }, "_ItemViewWin_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((("Price: " + Utils.formatInt(this.itemData.price)) + " ea          You own: ") + Utils.formatInt(this.itemData.count));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Label2.text = _arg_1;
            }, "_ItemViewWin_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.itemData.price > 0);
            }, function (_arg_1:Boolean):void
            {
                _buyBtn.enabled = _arg_1;
            }, "_buyBtn.enabled");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.itemData.price > 0) ? "Click to buy more of this item from the Game Shop." : "This item is not currently available from the Game Shop.");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _buyBtn.toolTip = _arg_1;
            }, "_buyBtn.toolTip");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemData.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _itemDescArea.text = _arg_1;
            }, "_itemDescArea.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.itemData.itemDesc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _itemDescArea.toolTip = _arg_1;
            }, "_itemDescArea.toolTip");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.showZoneSelector(this.itemData.id)) && (this._zone_Select.selectedIndex > 0));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox2.visible = _arg_1;
            }, "_ItemViewWin_HBox2.visible");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.playerCount + "") : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Label6.text = _arg_1;
            }, "_ItemViewWin_Label6.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.castleCount + "") : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Label7.text = _arg_1;
            }, "_ItemViewWin_Label7.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._zone_Select.selectedIndex > 0) ? (this._zone_Select.selectedItem.data.rate + "%") : "");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemViewWin_Label8.text = _arg_1;
            }, "_ItemViewWin_Label8.text");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showUseCount(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox3.visible = _arg_1;
            }, "_ItemViewWin_HBox3.visible");
            result[12] = binding;
            binding = new Binding(this, function ():*
            {
                return (this);
            }, function (_arg_1:*):void
            {
                _useCountInput1.parentWin = _arg_1;
            }, "_useCountInput1.parentWin");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.enableUseBtn(this.itemData.count));
            }, function (_arg_1:Boolean):void
            {
                _useCountInput1.enabled = _arg_1;
            }, "_useCountInput1.enabled");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showCoordFields(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox4.visible = _arg_1;
            }, "_ItemViewWin_HBox4.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showPlayerNameField(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox5.visible = _arg_1;
            }, "_ItemViewWin_HBox5.visible");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showZoneSelector(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox6.visible = _arg_1;
            }, "_ItemViewWin_HBox6.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.zoneInfo);
            }, function (_arg_1:Object):void
            {
                _zone_Select.dataProvider = _arg_1;
            }, "_zone_Select.dataProvider");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showRescueHeroSelector(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox7.visible = _arg_1;
            }, "_ItemViewWin_HBox7.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.disappearHeros);
            }, function (_arg_1:Object):void
            {
                _dh_Select.dataProvider = _arg_1;
            }, "_dh_Select.dataProvider");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showUseBtn(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _useBtnArea.visible = _arg_1;
            }, "_useBtnArea.visible");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.enableUseBtn(this.itemData.count)) && ((this.disappearHeros == null) || ((!(this.disappearHeros == null)) && (this.disappearHeros.length > 0))));
            }, function (_arg_1:Boolean):void
            {
                _useBtn.enabled = _arg_1;
            }, "_useBtn.enabled");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showCloseAndOpenBtns(this.itemData.id));
            }, function (_arg_1:Boolean):void
            {
                _ItemViewWin_HBox9.visible = _arg_1;
            }, "_ItemViewWin_HBox9.visible");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.enableUseBtn(this.itemData.count));
            }, function (_arg_1:Boolean):void
            {
                _closeBtn.enabled = _arg_1;
            }, "_closeBtn.enabled");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.enableUseBtn(this.itemData.count));
            }, function (_arg_1:Boolean):void
            {
                _openBtn.enabled = _arg_1;
            }, "_openBtn.enabled");
            result[25] = binding;
            return (result);
        }

        internal function onUseCountChange(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + int(_arg_1.text));
            if (int(_arg_1.text) == 0)
            {
                if (this.itemData.count > 0)
                {
                    _arg_1.text = ("" + 1);
                };
                this.moveCursorToEnd(_arg_1);
            }
            else
            {
                if (int(_arg_1.text) < 0)
                {
                    this.onMinBtn(_arg_1);
                }
                else
                {
                    if (int(_arg_1.text) > this.itemData.count)
                    {
                        _arg_1.text = ("" + this.itemData.count);
                    };
                };
            };
        }

        private function canUseItem(_arg_1:String):Boolean
        {
            if ((((((((((((((((((_arg_1 == "consume.key.3") || (_arg_1 == "consume.key.2")) || (_arg_1 == "consume.key.1")) || (_arg_1 == "consume.move.1")) || (_arg_1 == "player.more.castle.1.a")) || (_arg_1 == "player.heart.1.a ")) || (_arg_1 == "player.pop.1.a")) || (_arg_1.indexOf("equipment.box.") == 0)) || (_arg_1 == "alliance.ritual_of_pact.advanced")) || (_arg_1 == "alliance.ritual_of_pact.premium")) || (_arg_1 == "alliance.ritual_of_pact.ultimate")) || (_arg_1 == "player.speak.bronze_publicity_ambassador.permanent")) || (_arg_1 == "player.speak.bronze_publicity_ambassador.permanent.15")) || (_arg_1 == "player.speak.gold_publicity_ambassador.15")) || (_arg_1 == "player.speak.gold_publicity_ambassador.permanent")) || (_arg_1 == "player.speak.silver_publicity_ambassador.15")) || (_arg_1 == "player.speak.silver_publicity_ambassador.permanent")))
            {
                return (true);
            };
            if ((((this.isAngel(_arg_1)) || (this.isDevil(_arg_1))) || (this.isSoF(_arg_1))))
            {
                return (true);
            };
            if (((((((((((((((((((((((((((((((this.itemData.playerItem) && (!(this.isDream(_arg_1)))) && (!(_arg_1 == "player.troop.1.a"))) && (!(_arg_1 == "player.key.evony_easter_package"))) && (!(_arg_1 == "player.item.candy"))) && (!(_arg_1 == "player.item.turkeyhunt"))) && (!(_arg_1 == "player.item.snowball"))) && (!(_arg_1 == "player.item.pieceofrainbow"))) && (!(_arg_1 == "player.item.wolfpaw"))) && (!(_arg_1 == "player.bone.key"))) && (!(_arg_1 == "player.item.gildedhorn"))) && (!(_arg_1 == "player.item.candy.2013"))) && (!(_arg_1 == "player.item.harvesttoken"))) && (!(_arg_1 == "player.item.huntersstones"))) && (!(_arg_1 == "player.item.relicofthekrampus"))) && (!(_arg_1 == "player.item.quest.shakespear"))) && (!(_arg_1 == "player.key.keyofcrossing"))) && (!(_arg_1 == "player.key.birthdaykey"))) && (!(_arg_1 == "player.key.malebolgian"))) && (!(_arg_1 == "player.key.keyofdonar"))) && (!(_arg_1 == "player.item.candy.2014"))) && (!(_arg_1 == "player.item.harvesttoken.2014"))) && (!(_arg_1 == "player.key.jakekeyoftheharvest"))) && (!(_arg_1 == "player.key.starcrossedkey"))) && (!(_arg_1 == "player.key.faeryringkey"))) && (!(_arg_1 == "player.key.easterkey2015"))) && (!(_arg_1 == "player.key.birthdaykey.2015"))) && (!(_arg_1 == "player.key.thesquirrelskey"))) && (!(_arg_1 == "player.item.stygandrsbannerofthehorde"))) && (_arg_1.indexOf(".quest.") == -1)))
            {
                return (true);
            };
            return (false);
        }

        public function set _useCountInput1(_arg_1:ItemCountInput):void
        {
            var _local_2:Object = this._2053243474_useCountInput1;
            if (_local_2 !== _arg_1)
            {
                this._2053243474_useCountInput1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useCountInput1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemData():ObjectProxy
        {
            return (this._1177034077itemData);
        }

        [Bindable(event="propertyChange")]
        public function get _xInput():TextInput
        {
            return (this._1919807313_xInput);
        }

        public function set _useItemResultsArea(_arg_1:TextArea):void
        {
            var _local_2:Object = this._9487016_useItemResultsArea;
            if (_local_2 !== _arg_1)
            {
                this._9487016_useItemResultsArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useItemResultsArea", _local_2, _arg_1));
            };
        }

        internal function onMinBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + ((this.itemData.count > 0) ? 1 : 0));
            _arg_1.setFocus();
            this.moveCursorToEnd(_arg_1);
        }

        private function onTimeOut(_arg_1:TimerEvent=null):void
        {
            var _local_2:UseItemResultResponse = new UseItemResultResponse("shop.useGoods", {
                "ok":-1,
                "errorMsg":"ERROR: TimeOut Occurred. No response received within a timely manner.",
                "msg":"",
                "packageId":12345,
                "itemBeansArray":new ArrayCollection(),
                "gamblingItemsBeansArray":new ArrayCollection()
            });
            this.onUseGoods(_local_2);
        }

        public function set _closeWinBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._344839367_closeWinBtn;
            if (_local_2 !== _arg_1)
            {
                this._344839367_closeWinBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_closeWinBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _openBtn():Button
        {
            return (this._1095002739_openBtn);
        }

        private function isAdvTeleport(_arg_1:String):Boolean
        {
            return (((_arg_1 == "player.more.castle.1.a") || (_arg_1 == "player.move.castle.1.b")) || (_arg_1 == "player.more.castle.1.c"));
        }

        private function isTeleport(_arg_1:String):Boolean
        {
            return (_arg_1 == "consume.move.1");
        }

        public function set _dh_Select(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._95768648_dh_Select;
            if (_local_2 !== _arg_1)
            {
                this._95768648_dh_Select = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_dh_Select", _local_2, _arg_1));
            };
        }

        private function onUseItems(_arg_1:int):void
        {
            this._itemDescArea.visible = false;
            this._useItemResultsArea.visible = true;
            this.howManyToUse = _arg_1;
            this.pleaseStop = false;
            this._useBtn.label = "Cancel";
            this._useBtn.enabled = true;
            this.useGoods();
        }

        [Bindable(event="propertyChange")]
        private function get zoneInfo():ArrayCollection
        {
            return (this._847922810zoneInfo);
        }

        [Bindable(event="propertyChange")]
        public function get _useBtn():Button
        {
            return (this._1872395380_useBtn);
        }

        private function isCastleStrat(_arg_1:String):Boolean
        {
            return ((((((((((((((((_arg_1 == "player.trick.bxez") || (_arg_1 == "player.trick.adcc")) || (_arg_1 == "player.trick.bxez")) || (_arg_1 == "player.trick.chdj")) || (_arg_1 == "player.trick.cmjb")) || (_arg_1 == "player.trick.fslc")) || (_arg_1 == "player.trick.jbqy")) || (_arg_1 == "player.trick.kcj")) || (_arg_1 == "player.trick.lywh")) || (_arg_1 == "player.trick.mrj")) || (_arg_1 == "player.trick.pzyy")) || (_arg_1 == "player.trick.smmf")) || (_arg_1 == "player.trick.tblj")) || (_arg_1 == "player.trick.wwjz")) || (_arg_1 == "player.trick.yyhz")) || (_arg_1 == "player.trick.zsmj"));
        }

        private function isGateControl(_arg_1:String):Boolean
        {
            return (_arg_1 == "player.box.present.money.77");
        }

        [Bindable(event="propertyChange")]
        public function get _zone_Select():ComboBox
        {
            return (this._1579933872_zone_Select);
        }

        private function isHeroHunting(_arg_1:String):Boolean
        {
            return (_arg_1 == "consume.refreshtavern.1");
        }

        private function onBuyResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((_arg_1.errorMsg + ": ") + _arg_1.ok)));
            };
            this._buyBtn.enabled = true;
        }

        override public function initialize():void
        {
            var target:ItemViewWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._ItemViewWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil");
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

        private function showPlayerNameField(_arg_1:String):Boolean
        {
            return (this.isAngel(_arg_1));
        }

        public function ___openBtn_click(_arg_1:MouseEvent):void
        {
            this.onUseBtn("1");
        }

        public function ___ItemViewWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function cleanUpAfterUseItem():void
        {
            this.pleaseStop = true;
            this.howManyToUse = 0;
            this.howManyUsed = 0;
            this._useBtn.label = "Use";
            this._useBtn.enabled = true;
            this._closeWinBtn.enabled = true;
        }

        private function onCoordChange(_arg_1:TextInput):void
        {
            var _local_2:int;
            _arg_1.text = ("" + int(_arg_1.text));
            if (int(_arg_1.text) == 0)
            {
                this.moveCursorToEnd(_arg_1);
            }
            else
            {
                if (int(_arg_1.text) < 0)
                {
                    _arg_1.text = ("" + 0);
                    this.moveCursorToEnd(_arg_1);
                }
                else
                {
                    _local_2 = (MainScreen.getPlayer().mapSizeX - 1);
                    if (int(_arg_1.text) > _local_2)
                    {
                        _arg_1.text = ("" + _local_2);
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get _useItemResultsArea():TextArea
        {
            return (this._9487016_useItemResultsArea);
        }

        public function set _xInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1919807313_xInput;
            if (_local_2 !== _arg_1)
            {
                this._1919807313_xInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_xInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _closeBtn():Button
        {
            return (this._1183315619_closeBtn);
        }

        public function set _itemDescArea(_arg_1:Text):void
        {
            var _local_2:Object = this._458286896_itemDescArea;
            if (_local_2 !== _arg_1)
            {
                this._458286896_itemDescArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemDescArea", _local_2, _arg_1));
            };
        }

        private function showUseBtn(_arg_1:String):Boolean
        {
            return ((((((this.canUseItem(_arg_1)) || (this.isTeleport(_arg_1))) || (this.isAdvTeleport(_arg_1))) || (this.isCastleStrat(_arg_1))) || (this.isDevil(_arg_1))) || ((this.isAngel(_arg_1)) && (!(this.isGateControl(_arg_1)))));
        }

        private function set disappearHeros(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2041142742disappearHeros;
            if (_local_2 !== _arg_1)
            {
                this._2041142742disappearHeros = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disappearHeros", _local_2, _arg_1));
            };
        }

        private function onBuyBtn():void
        {
            var _local_1:popUpWinShowEvent;
            if ((MainScreen.getPlayer().playerInfo.medal - this.itemData.price) >= 0)
            {
                _local_1 = new popUpWinShowEvent(popUpWinShowEvent.BUY_ITEM_WIN);
                _local_1.args = [this.itemData, this.onBuyItem];
                dispatchEvent(_local_1);
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "You do not have enough Cents to buy this item from the Game Shop."));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _useCountInput1():ItemCountInput
        {
            return (this._2053243474_useCountInput1);
        }

        private function set itemData(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1177034077itemData;
            if (_local_2 !== _arg_1)
            {
                this._1177034077itemData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemData", _local_2, _arg_1));
            };
        }

        public function set _zone_Select(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1579933872_zone_Select;
            if (_local_2 !== _arg_1)
            {
                this._1579933872_zone_Select = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_zone_Select", _local_2, _arg_1));
            };
        }

        public function ___yInput_change(_arg_1:Event):void
        {
            this.onCoordChange((_arg_1.currentTarget as TextInput));
        }

        private function enableUseBtn(_arg_1:int):Boolean
        {
            return (_arg_1 > 0);
        }

        private function showCoordFields(_arg_1:String):Boolean
        {
            return ((((this.isAdvTeleport(_arg_1)) || (this.isCastleStrat(_arg_1))) || (this.isGateControl(_arg_1))) || (this.isDevil(_arg_1)));
        }

        public function ___xInput_keyDown(_arg_1:KeyboardEvent):void
        {
            this.keyDownHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get disappearHeros():ArrayCollection
        {
            return (this._2041142742disappearHeros);
        }

        private function onZoneInfoResponse(_arg_1:ZoneInfoResponse):void
        {
            var _local_2:ZoneInfoBean;
            var _local_3:ObjectProxy;
            var _local_4:int;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, ((_arg_1.errorMsg + ": ") + _arg_1.ok)));
            }
            else
            {
                _local_2 = null;
                _local_3 = null;
                if (this.zoneInfo == null)
                {
                    this.zoneInfo = new ArrayCollection();
                }
                else
                {
                    this.zoneInfo.removeAll();
                };
                _local_4 = 0;
                while (_local_4 < _arg_1.zonesArray.length)
                {
                    _local_2 = (_arg_1.zonesArray.getItemAt(_local_4) as ZoneInfoBean);
                    _local_3 = new ObjectProxy({
                        "label":_local_2.name,
                        "data":_local_2
                    });
                    this.zoneInfo.addItem(_local_3);
                    _local_4++;
                };
                _local_3 = new ObjectProxy({
                    "label":"Random",
                    "data":this.getRandomZone()
                });
                this.zoneInfo.addItemAt(_local_3, 0);
                this._zone_Select.selectedIndex = 0;
                _local_2 = null;
                _local_3 = null;
            };
        }

        [Bindable(event="propertyChange")]
        public function get _itemDescArea():Text
        {
            return (this._458286896_itemDescArea);
        }

        private function isSoF(_arg_1:String):Boolean
        {
            return (_arg_1 == "player.item.stoneoffinding");
        }

        internal function onBuyItem(_arg_1:int):void
        {
            ActionFactory.getInstance().getShopCommands().buy(this.itemData.id, _arg_1, this.onBuyResponse);
        }

        public function ___closeWinBtn_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function showUseCount(_arg_1:String):Boolean
        {
            return (((((((((((this.canUseItem(_arg_1)) && (!(this.isTruce(_arg_1)))) && (!(this.isCastleStrat(_arg_1)))) && (!(this.isTeleport(_arg_1)))) && (!(this.isAdvTeleport(_arg_1)))) && (!(this.isGateControl(_arg_1)))) && (!(this.isAngel(_arg_1)))) && (!(this.isDevil(_arg_1)))) && (!(this.isSoF(_arg_1)))) && (!(this.isCastleItem(_arg_1)))) && (!(this.isSpeechOrCivCode(_arg_1))));
        }

        public function set _openBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1095002739_openBtn;
            if (_local_2 !== _arg_1)
            {
                this._1095002739_openBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_openBtn", _local_2, _arg_1));
            };
        }

        public function set _yInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1948436464_yInput;
            if (_local_2 !== _arg_1)
            {
                this._1948436464_yInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_yInput", _local_2, _arg_1));
            };
        }

        private function isDevil(_arg_1:String):Boolean
        {
            return (((_arg_1 == "player.box.present.money.74") || (_arg_1 == "player.box.present.money.75")) || (_arg_1 == "player.box.present.money.76"));
        }

        public function set _useBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1872395380_useBtn;
            if (_local_2 !== _arg_1)
            {
                this._1872395380_useBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_useBtn", _local_2, _arg_1));
            };
        }

        private function updateItemCount():void
        {
            this.itemData.count = this.getItemCount(this.itemData.id);
        }

        private function isAngel(_arg_1:String):Boolean
        {
            return (((_arg_1 == "player.box.present.money.70") || (_arg_1 == "player.box.present.money.71")) || (_arg_1 == "player.box.present.money.72"));
        }

        private function onItemUpdate(_arg_1:ItemUpdate):void
        {
            var _local_2:ItemBean;
            for each (_local_2 in _arg_1.itemsArray)
            {
                if (_local_2.id == this.itemData.id)
                {
                    this.itemData.count = int(_local_2.count);
                    if (int(this._useCountInput1._useCountInput.text) > this.itemData.count)
                    {
                        this.onMaxBtn(this._useCountInput1._useCountInput);
                    };
                    break;
                };
            };
        }

        private function close():void
        {
            if (this.timeOutTimer != null)
            {
                this.timeOutTimer.stop();
                this.timeOutTimer.removeEventListener(TimerEvent.TIMER, this.onTimeOut);
                this.timeOutTimer = null;
            };
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            this.removeEventListener(KeyboardEvent.KEY_DOWN, this.enterKeyDownHandle);
            this.itemData = null;
            if (this.zoneInfo != null)
            {
                this.zoneInfo.removeAll();
                this.zoneInfo = null;
            };
            if (this.disappearHeros != null)
            {
                this.disappearHeros.removeAll();
                this.disappearHeros = null;
            };
            this.closeFunc.apply(null, [this]);
        }


    }
}//package autoevony.gui.info.Items

