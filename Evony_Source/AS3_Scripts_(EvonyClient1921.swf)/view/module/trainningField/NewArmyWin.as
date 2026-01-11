// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.NewArmyWin

package view.module.trainningField
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.ComboBox;
    import mx.controls.CheckBox;
    import com.evony.common.beans.CastleResourceBean;
    import view.ui.NumberInput;
    import com.evony.common.beans.ResourceInfoBean;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.beans.TroopBean;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.containers.Tile;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import com.evony.common.constants.ObjConstants;
    import com.evony.data.NewArmyEventData;
    import com.evony.common.beans.HeroBean;
    import flash.utils.Timer;
    import com.evony.common.paramBeans.NewArmyParam;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.events.ListEvent;
    import flash.geom.Point;
    import com.evony.Context;
    import com.evony.Coordinate;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.evony.util.UIUtil;
    import flash.events.TimerEvent;
    import com.evony.common.constants.HeroConstants;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import view.AllWindows;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.army.TroopParamResponse;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.FieldConstants;
    import view.castle.MainFramePlayerBuff;
    import com.evony.common.beans.BuffBean;
    import mx.binding.utils.BindingUtils;
    import flash.external.ExternalInterface;
    import view.ui.AlertWin;
    import mx.events.FlexEvent;
    import com.evony.MsgDispacther;
    import mx.binding.Binding;
    import com.evony.common.constants.TFConstants;
    import com.evony.common.beans.ResourceBean;
    import com.evony.eum.TroopEumDefine;
    import com.evony.eum.TroopEum;
    import com.evony.events.WindowChangeEvent;
    import com.evony.common.module.common.TroopConfigResponse;
    import flash.utils.getDefinitionByName;
    import com.evony.common.beans.MapCastleBean;
    import com.evony.common.module.field.OtherFieldInfoResponse;
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

    public class NewArmyWin extends BaseFunctionWindow implements IBindingClient 
    {

        private static var recSize:int = 60000;
        public static const EVENT_SHOW:String = "NewArmy.open";
        public static const EVENT_COORDINATE:String = "coordinate";
        public static var instance:NewArmyWin = new (NewArmyWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var curSel:String;
        public var _NewArmyWin_Text1:Text;
        public var _NewArmyWin_Text2:Text;
        public var _NewArmyWin_Text3:Text;
        public var _NewArmyWin_Text5:Text;
        public var _NewArmyWin_Text7:Text;
        public var _NewArmyWin_Text9:Text;
        public var _NewArmyWin_Text4:Text;
        public var _NewArmyWin_Text6:Text;
        public var _NewArmyWin_Text8:Text;
        private var TypeId:int;
        private var _1386265523input_food:ResourceInput;
        private var _1386771970input_wood:ResourceInput;
        private var _2127717941input_swordsmen:TroopInput;
        private var _620580248input_archer:TroopInput;
        public var _NewArmyWin_Label1:Label;
        public var _NewArmyWin_Label4:Label;
        public var _NewArmyWin_Label5:Label;
        public var _NewArmyWin_Label6:Label;
        public var _NewArmyWin_Label7:Label;
        public var _NewArmyWin_Label8:Label;
        public var _NewArmyWin_Label9:Label;
        private var loadSkillParam:int;
        private var _1119728796troopMinBtn:Button;
        private var _613351659mimuteInput:TextInput;
        public var _NewArmyWin_ComboBox1:ComboBox;
        private var loads:Number = 0;
        private var _304455483useHorde:CheckBox;
        private var portableFood:int = 0;
        private var _865670275needTime:int;
        private var _839012660troopConfig:ComboBox;
        private var _802491405maxTroopLimit:int;
        private var _2059551634input_pikemen:TroopInput;
        private var distane:Number;
        private var _1219601176input_heavyCavalry:TroopInput;
        private var Costnum:int;
        private var _979992646hourInput:TextInput;
        public var _NewArmyWin_Text10:Text;
        private var encampTime:Number = 0;
        private var _341064690resource:CastleResourceBean;
        private var _1140689133input_catapult:TroopInput;
        private var _865259028needFood:int;
        private var _926713076returnBtn:Button;
        private var _426045858input_militia:TroopInput;
        private var _1730759999leftSpace:int;
        private var _1954847043input_x:NumberInput;
        public var _NewArmyWin_CheckBox3:CheckBox;
        private var _779951690troopAmount:int = 0;
        public var _NewArmyWin_Button1:Button;
        private var _148431469useFlag:CheckBox;
        public var _NewArmyWin_Button6:Button;
        public var _NewArmyWin_Button2:Button;
        private var _1134711072reachTime:String;
        private var _1049650600input_peasants:TroopInput;
        private var _2108485791heroSelCom:ComboBox;
        private var _243631393disCount:Number;
        private var _1707425309input_batteringRam:TroopInput;
        private var troopTypeAry:Array;
        private var _1386357789input_iron:ResourceInput;
        private var _2095366482needTimeStr:String;
        private var transportSpeedAdd:Boolean = false;
        private var stowListOpen:Boolean = false;
        private var _2116085169missionTypeSelectedIndex:int = 0;
        private var _1081154686maxNum:int;
        private var marchSkillParam:int;
        private var _378942766foodBean:ResourceInfoBean;
        private var _826047651troopCanAdd:int = 0;
        private var _1112638538troopMaxBtn:Button;
        private var transportStationParam:int;
        private var _1726188733setBtnEnable:Boolean = false;
        private var _1369421801input_lightCavalry:TroopInput;
        private var _435361974input_scouter:TroopInput;
        private var _1367558920castle:CastleBean;
        private var _1954847044input_y:NumberInput;
        public var _NewArmyWin_Label10:Label;
        public var _NewArmyWin_Label11:Label;
        private var _36713392input_stone:ResourceInput;
        private var _865287327troops:TroopBean;
        private var watcher:ChangeWatcher;
        private var troopAmountAry:Array;
        private var _821205909input_ballista:TroopInput;
        private var _1718011141leftFood:Number;
        private var _1386295221input_gold:ResourceInput;
        private var _1098902761input_carriage:TroopInput;
        private var troopObjAry:Array;
        private var driveSkillParam:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "34";
                            this.top = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":360,
                                "height":135,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "left";
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"Propertyname2",
                                                        "x":10,
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "6";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":90,
                                                        "text":"X=",
                                                        "styleName":"commonNormalColor"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":NumberInput,
                                                "id":"input_x",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "styleName":"textInput",
                                                        "x":96,
                                                        "maxChars":3,
                                                        "onDataChange":targetChange
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "6";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":150,
                                                        "text":"Y=",
                                                        "styleName":"commonNormalColor"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":NumberInput,
                                                "id":"input_y",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "styleName":"textInput",
                                                        "x":173,
                                                        "maxChars":3,
                                                        "onDataChange":targetChange
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_NewArmyWin_Button1",
                                    "events":{"click":"___NewArmyWin_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.horizontalGap = 0;
                                        this.top = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "35";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "styleName":"Propertyname2",
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"_NewArmyWin_ComboBox1",
                                                "events":{"change":"___NewArmyWin_ComboBox1_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "35";
                                                    this.left = "90";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":223});
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.horizontalGap = 0;
                                        this.top = "70";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "70";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "styleName":"Propertyname2",
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"heroSelCom",
                                                "events":{"change":"__heroSelCom_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "70";
                                                    this.left = "90";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":223,
                                                        "labelField":"name"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.horizontalGap = 0;
                                        this.top = "105";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "105";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"Propertyname2",
                                                        "x":10,
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"hourInput",
                                                "events":{"change":"__hourInput_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "105";
                                                    this.left = "90";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":45,
                                                        "restrict":"0-9",
                                                        "maxChars":3,
                                                        "styleName":"textInput"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "105";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"x":146});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"mimuteInput",
                                                "events":{"change":"__mimuteInput_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "195";
                                                    this.top = "105";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":40,
                                                        "restrict":"0-9",
                                                        "maxChars":2,
                                                        "styleName":"textInput"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label8",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "240";
                                                    this.top = "105";
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "34";
                            this.bottom = "110";
                            this.top = "183";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":360,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "2";
                                        this.top = "5";
                                        this.verticalGap = 4;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_food",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"resourceType":"food"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_wood",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"resourceType":"wood"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_stone",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"resourceType":"stone"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_iron",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"resourceType":"iron"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_gold",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"resourceType":"gold"});
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                            this.right = "34";
                            this.bottom = "17";
                            this.horizontalGap = 10;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_NewArmyWin_Button2",
                                    "events":{"click":"___NewArmyWin_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"returnBtn",
                                    "events":{"click":"__returnBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "40";
                            this.bottom = "100";
                            this.left = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":384,
                                "styleName":"textBackground",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "width":384,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":384,
                                                        "height":66,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_NewArmyWin_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "5";
                                                                this.top = "2";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"contentHeader2"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"troopMinBtn",
                                                            "events":{"click":"__troopMinBtn_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "110";
                                                                this.top = "28";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b75"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"troopMaxBtn",
                                                            "events":{"click":"__troopMaxBtn_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.left = "5";
                                                                this.top = "28";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b75"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":CheckBox,
                                                            "id":"useFlag",
                                                            "events":{"change":"__useFlag_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "0";
                                                                this.left = "215";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":165});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":CheckBox,
                                                            "id":"useHorde",
                                                            "events":{"change":"__useHorde_change"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "38";
                                                                this.left = "215";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":165});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Tile,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 4;
                                                    this.verticalGap = 7;
                                                    this.borderStyle = "none";
                                                    this.paddingLeft = 4;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":245,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_peasants"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_militia"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_scouter"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_pikemen"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_swordsmen"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_archer"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_lightCavalry"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_heavyCavalry"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_carriage"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_ballista"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_batteringRam"
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_catapult"
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
                                        this.left = "10";
                                        this.bottom = "5";
                                        this.horizontalCenter = "0";
                                        this.horizontalGap = 12;
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_NewArmyWin_Label10"
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"troopConfig",
                                                "events":{"change":"__troopConfig_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":180});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_NewArmyWin_Button6",
                                                "events":{"click":"___NewArmyWin_Button6_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.right = "34";
                            this.bottom = "45";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":360,
                                "styleName":"textBackground",
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_NewArmyWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.horizontalGap = 0;
                                        this.bottom = "5";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":190,
                                            "height":25,
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"selectable":false});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":90,
                                                        "selectable":false
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
                                        this.horizontalGap = 0;
                                        this.bottom = "5";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":162,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text4",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "selectable":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "selectable":false
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
                            this.bottom = "45";
                            this.left = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":50,
                                "styleName":"textBackground",
                                "width":384,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_NewArmyWin_Text6",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"selectable":false});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.horizontalGap = 0;
                                        this.bottom = "5";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "width":150,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ParamgraphText2",
                                                        "selectable":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text8",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":85,
                                                        "selectable":false
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
                                        this.horizontalGap = 0;
                                        this.left = "160";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":185,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ParamgraphText2",
                                                        "selectable":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_NewArmyWin_Text10",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":75,
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_NewArmyWin_Label11",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"PropertyName1",
                                "x":33
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"_NewArmyWin_CheckBox3",
                        "events":{"change":"___NewArmyWin_CheckBox3_change"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.color = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"x":320});
                        }
                    })]
                });
            }
        });
        private var _991165677missionTypeArray:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("运输"),
            "data":ObjConstants.ARMY_MISSION_TRANS
        }, {
            "label":Lang.msg("派遣"),
            "data":ObjConstants.ARMY_MISSION_SEND
        }, {
            "label":Lang.msg("侦察"),
            "data":ObjConstants.ARMY_MISSION_SCOUT
        }, {
            "label":Lang.msg("攻击"),
            "data":ObjConstants.ARMY_MISSION_OCCUPY
        }, {
            "label":Lang.msg("殖民"),
            "data":ObjConstants.ARMY_MISSION_COLONIZE
        }]);
        private var _1853610967setTroopArray:ArrayCollection = new ArrayCollection([{"label":"Normal"}, {"label":"Last setting"}, {"label":"Settings 1"}, {"label":"Settings 2"}, {"label":"Settings 3"}]);
        private var _99168185heros:ArrayCollection = new ArrayCollection();
        private var _158692185newArmyData:NewArmyEventData = new NewArmyEventData();
        private var selectedHero:HeroBean = getEmptyHeroBean();
        private var lastTroopSet:TroopBean = new TroopBean();
        private var costObj:Object = new Object();
        private var loadObj:Object = new Object();
        private var speedObj:Object = new Object();
        private var speedAry:Array = new Array();
        private var myTimer:Timer = new Timer(1000, 0);
        private var param:NewArmyParam = new NewArmyParam();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NewArmyWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.creationPolicy = "all";
            this.addEventListener("creationComplete", ___NewArmyWin_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___NewArmyWin_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NewArmyWin._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():NewArmyWin
        {
            if (instance == null)
            {
                instance = new (NewArmyWin)();
            };
            return (instance);
        }


        [Bindable(event="propertyChange")]
        public function get input_wood():ResourceInput
        {
            return (this._1386771970input_wood);
        }

        public function set input_wood(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1386771970input_wood;
            if (_local_2 !== _arg_1)
            {
                this._1386771970input_wood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_wood", _local_2, _arg_1));
            };
        }

        private function set maxTroopLimit(_arg_1:int):void
        {
            var _local_2:Object = this._802491405maxTroopLimit;
            if (_local_2 !== _arg_1)
            {
                this._802491405maxTroopLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxTroopLimit", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get needFood():int
        {
            return (this._865259028needFood);
        }

        [Bindable(event="propertyChange")]
        public function get input_batteringRam():TroopInput
        {
            return (this._1707425309input_batteringRam);
        }

        private function onMissionTypeChange(_arg_1:ListEvent):void
        {
            this.newArmyData.missionType = ComboBox(_arg_1.target).selectedItem.data;
        }

        private function set resource(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._341064690resource;
            if (_local_2 !== _arg_1)
            {
                this._341064690resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _local_2, _arg_1));
            };
        }

        public function countDistance(_arg_1:Point=null, _arg_2:Point=null):Number
        {
            var _local_3:Point;
            var _local_4:Point;
            var _local_5:int = Context.mapSizeX;
            var _local_6:int = Context.mapSizeY;
            var _local_7:Coordinate = new Coordinate(Context.getInstance().getCurCastle().fieldId);
            if (_arg_1 == null)
            {
                _local_3 = new Point(_local_7.x, _local_7.y);
            }
            else
            {
                _local_3 = _arg_1;
            };
            if (_arg_2 == null)
            {
                _local_4 = new Point(this.newArmyData.x, this.newArmyData.y);
            }
            else
            {
                _local_4 = _arg_2;
            };
            var _local_8:Number = Point.distance(_local_3, _local_4);
            var _local_9:Point = new Point((_local_4.x + _local_5), _local_4.y);
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_9));
            var _local_10:Point = new Point((_local_4.x - _local_5), _local_4.y);
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_10));
            var _local_11:Point = new Point(_local_4.x, (_local_4.y + _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_11));
            var _local_12:Point = new Point(_local_4.x, (_local_4.y - _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_12));
            var _local_13:Point = new Point((_local_4.x - _local_5), (_local_4.y + _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_13));
            var _local_14:Point = new Point((_local_4.x - _local_5), (_local_4.y - _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_14));
            var _local_15:Point = new Point((_local_4.x + _local_5), (_local_4.y + _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_15));
            var _local_16:Point = new Point((_local_4.x + _local_5), (_local_4.y - _local_6));
            _local_8 = Math.min(_local_8, Point.distance(_local_3, _local_16));
            return (_local_8);
        }

        [Bindable(event="propertyChange")]
        private function get maxTroopLimit():int
        {
            return (this._802491405maxTroopLimit);
        }

        private function set missionTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._991165677missionTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._991165677missionTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "missionTypeArray", _local_2, _arg_1));
            };
        }

        public function __mimuteInput_change(_arg_1:Event):void
        {
            timeInPutChange();
        }

        private function setDefaultHero():void
        {
            if ((((this.newArmyData.missionType == ObjConstants.ARMY_MISSION_OCCUPY) || (this.newArmyData.missionType == ObjConstants.ARMY_MISSION_COLONIZE)) && (this.heros.length > 1)))
            {
                this.heroSelCom.selectedIndex = 1;
                this.selectedHero = this.heros[1];
                if (this.TypeId != 0)
                {
                    this.speedFood(this.Costnum, this.TypeId, this.distane);
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get setTroopArray():ArrayCollection
        {
            return (this._1853610967setTroopArray);
        }

        [Bindable(event="propertyChange")]
        public function get input_iron():ResourceInput
        {
            return (this._1386357789input_iron);
        }

        public function set input_heavyCavalry(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1219601176input_heavyCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1219601176input_heavyCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_heavyCavalry", _local_2, _arg_1));
            };
        }

        private function set needFood(_arg_1:int):void
        {
            var _local_2:Object = this._865259028needFood;
            if (_local_2 !== _arg_1)
            {
                this._865259028needFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needFood", _local_2, _arg_1));
            };
        }

        public function set mimuteInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._613351659mimuteInput;
            if (_local_2 !== _arg_1)
            {
                this._613351659mimuteInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mimuteInput", _local_2, _arg_1));
            };
        }

        public function set input_batteringRam(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1707425309input_batteringRam;
            if (_local_2 !== _arg_1)
            {
                this._1707425309input_batteringRam = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_batteringRam", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get resource():CastleResourceBean
        {
            return (this._341064690resource);
        }

        public function ___NewArmyWin_Button2_click(_arg_1:MouseEvent):void
        {
            sendArmy();
        }

        private function timerHandler(_arg_1:TimerEvent=null):void
        {
            if (!UIUtil.isUIComponentVisible(this))
            {
                this.myTimer.stop();
                trace((this.className + " 被隐藏了. timer stop"));
                return;
            };
            this.reachTime = getNowTime(this.needTime, this.encampTime);
        }

        private function set leftFood(_arg_1:Number):void
        {
            var _local_2:Object = this._1718011141leftFood;
            if (_local_2 !== _arg_1)
            {
                this._1718011141leftFood = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftFood", _local_2, _arg_1));
            };
        }

        public function set input_iron(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1386357789input_iron;
            if (_local_2 !== _arg_1)
            {
                this._1386357789input_iron = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_iron", _local_2, _arg_1));
            };
        }

        private function set disCount(_arg_1:Number):void
        {
            var _local_2:Object = this._243631393disCount;
            if (_local_2 !== _arg_1)
            {
                this._243631393disCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disCount", _local_2, _arg_1));
            };
        }

        private function set setTroopArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1853610967setTroopArray;
            if (_local_2 !== _arg_1)
            {
                this._1853610967setTroopArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "setTroopArray", _local_2, _arg_1));
            };
        }

        private function set foodBean(_arg_1:ResourceInfoBean):void
        {
            var _local_2:Object = this._378942766foodBean;
            if (_local_2 !== _arg_1)
            {
                this._378942766foodBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hourInput():TextInput
        {
            return (this._979992646hourInput);
        }

        private function setFreeHeros():void
        {
            var _local_1:HeroBean;
            this.heros.removeAll();
            selectedHero = getEmptyHeroBean();
            this.heros.addItem(selectedHero);
            for each (_local_1 in castle.herosArray)
            {
                if (_local_1.status == HeroConstants.HERO_FREE_STATU)
                {
                    this.heros.addItem(_local_1);
                };
            };
            this.setDefaultHero();
        }

        [Bindable(event="propertyChange")]
        public function get input_militia():TroopInput
        {
            return (this._426045858input_militia);
        }

        public function __heroSelCom_change(_arg_1:ListEvent):void
        {
            heroSelected(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get input_pikemen():TroopInput
        {
            return (this._2059551634input_pikemen);
        }

        public function set troopConfig(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._839012660troopConfig;
            if (_local_2 !== _arg_1)
            {
                this._839012660troopConfig = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopConfig", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input_ballista():TroopInput
        {
            return (this._821205909input_ballista);
        }

        public function set returnBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._926713076returnBtn;
            if (_local_2 !== _arg_1)
            {
                this._926713076returnBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "returnBtn", _local_2, _arg_1));
            };
        }

        public function __troopMinBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        private function set leftSpace(_arg_1:int):void
        {
            var _local_2:Object = this._1730759999leftSpace;
            if (_local_2 !== _arg_1)
            {
                this._1730759999leftSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftSpace", _local_2, _arg_1));
            };
        }

        public function set input_y(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._1954847044input_y;
            if (_local_2 !== _arg_1)
            {
                this._1954847044input_y = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_y", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopMaxBtn():Button
        {
            return (this._1112638538troopMaxBtn);
        }

        public function __useHorde_change(_arg_1:Event):void
        {
            useFlagChange();
        }

        private function changeSet(_arg_1:Event):void
        {
            curSel = ComboBox(_arg_1.target).selectedLabel;
            switch (curSel)
            {
                case "Normal":
                    setBtnEnable = false;
                    break;
                case "Last setting":
                    setBtnEnable = false;
                    this.setTroopInput(lastTroopSet);
                    return;
                case "Settings 1":
                    setBtnEnable = true;
                    break;
                case "Settings 2":
                    setBtnEnable = true;
                    break;
                case "Settings 3":
                    setBtnEnable = true;
                    break;
            };
            var _local_2:int;
            while (_local_2 < Context.getInstance().getPlayerBean().troopConfigBeansArray.length)
            {
                if (curSel == Context.getInstance().getPlayerBean().getTroopConfigBeans(_local_2).name)
                {
                    this.setTroopInput(Context.getInstance().getPlayerBean().getTroopConfigBeans(_local_2).troop);
                    return;
                };
                _local_2++;
            };
            var _local_3:int;
            while (_local_3 < this.troopObjAry.length)
            {
                troopObjAry[_local_3].refresh();
                _local_3++;
            };
        }

        public function set input_x(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._1954847043input_x;
            if (_local_2 !== _arg_1)
            {
                this._1954847043input_x = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_x", _local_2, _arg_1));
            };
        }

        private function getNowTime(_arg_1:Number, _arg_2:Number):String
        {
            var _local_3:Number = (_arg_1 + _arg_2);
            var _local_4:Number = new Date().valueOf();
            var _local_5:Date = new Date((_local_3 + _local_4));
            var _local_6:Number = (_local_5.getMonth() + 1);
            var _local_7:Number = _local_5.getDate();
            var _local_8:Number = _local_5.getHours();
            var _local_9:Number = _local_5.getMinutes();
            var _local_10:Number = _local_5.getSeconds();
            return (((((((((((((("" + _local_6) + "-") + "") + _local_7) + "") + " ") + _local_8) + ":") + "") + _local_9) + ":") + "") + _local_10) + "");
        }

        public function set troopMaxBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1112638538troopMaxBtn;
            if (_local_2 !== _arg_1)
            {
                this._1112638538troopMaxBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMaxBtn", _local_2, _arg_1));
            };
        }

        public function set hourInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._979992646hourInput;
            if (_local_2 !== _arg_1)
            {
                this._979992646hourInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hourInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get needTime():int
        {
            return (this._865670275needTime);
        }

        [Bindable(event="propertyChange")]
        private function get newArmyData():NewArmyEventData
        {
            return (this._158692185newArmyData);
        }

        private function targetChange(_arg_1:int=0):void
        {
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            trace(("value:" + _arg_1));
            var _local_2:ArrayCollection = Context.getInstance().getCurCastle().buildingsArray;
            var _local_3:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            var _local_4:Boolean;
            var _local_5:int;
            while (_local_5 < _local_2.length)
            {
                if (_local_2.getItemAt(_local_5).typeId == BuildingConstants.TYPE_TRANSPORT_STATION)
                {
                    _local_4 = true;
                    break;
                };
                _local_5++;
            };
            if (((_local_4) && ((!(_local_3.alliance == null)) || (_local_3.castleCount > 1))))
            {
                _local_6 = int(this.input_x.text);
                _local_7 = int(this.input_y.text);
                _local_8 = ((_local_7 * Context.mapSizeY) + _local_6);
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GET_OTHER_FIELD_INFO, otherFieldInfo, false, 0, true);
                ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(Context.getInstance().getCurCastle().id, _local_8);
            }
            else
            {
                _local_9 = 0;
                while (_local_9 < this.troopObjAry.length)
                {
                    this.speedFood(troopObjAry[_local_9].currentValue, troopObjAry[_local_9].type, this.getdistance());
                    _local_9++;
                };
            };
            this.disCount = this.getdistance();
            if (((!(this.hourInput.text == "")) || (!(this.mimuteInput.text == ""))))
            {
                this.timeInPutChange();
            };
        }

        [Bindable(event="propertyChange")]
        private function get troopCanAdd():int
        {
            return (this._826047651troopCanAdd);
        }

        [Bindable(event="propertyChange")]
        public function get troopMinBtn():Button
        {
            return (this._1119728796troopMinBtn);
        }

        [Bindable(event="propertyChange")]
        private function get needTimeStr():String
        {
            return (this._2095366482needTimeStr);
        }

        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1.target.id == "returnBtn")
            {
                myTimer.stop();
                if (TrainningField.instance == null)
                {
                    this.onClose(null);
                }
                else
                {
                    AllWindows.switchToBuildingWindow(TrainningField.EVENT_SHOW, TrainningField.instance.getBuildingBean());
                };
            }
            else
            {
                if (_arg_1.target.id == "troopMaxBtn")
                {
                    _local_2 = 0;
                    while (_local_2 < this.troopObjAry.length)
                    {
                        this.troopObjAry[_local_2].currentValue = int(this.troopAmountAry[_local_2]);
                        this.troopObjAry[_local_2].txtInput.text = String(this.troopAmountAry[_local_2]);
                        this.speedFood(int(this.troopAmountAry[_local_2]), this.troopObjAry[_local_2].type, this.disCount);
                        _local_2++;
                    };
                }
                else
                {
                    if (_arg_1.target.id == "troopMinBtn")
                    {
                        _local_3 = 0;
                        while (_local_3 < this.troopObjAry.length)
                        {
                            this.troopObjAry[_local_3].currentValue = 0;
                            this.troopObjAry[_local_3].txtInput.text = "0";
                            this.speedFood(0, this.troopObjAry[_local_3].type, this.disCount);
                            _local_3++;
                        };
                    };
                };
            };
        }

        private function heroSelected(_arg_1:ListEvent):void
        {
            this.selectedHero = (ComboBox(_arg_1.target).selectedItem as HeroBean);
            this.speedFood(this.Costnum, this.TypeId, this.distane);
            var _local_2:int;
            while (_local_2 < this.troopObjAry.length)
            {
                this.speedFood(troopObjAry[_local_2].currentValue, troopObjAry[_local_2].type, this.getdistance());
                _local_2++;
            };
        }

        private function onGetTroopParam(_arg_1:TroopParamResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.loadSkillParam = _arg_1.loadSkillParam;
                this.marchSkillParam = _arg_1.marchSkillParam;
                this.driveSkillParam = _arg_1.driveSkillParam;
                this.transportStationParam = _arg_1.transportStationParam;
            };
        }

        public function ___NewArmyWin_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        public function get input_scouter():TroopInput
        {
            return (this._435361974input_scouter);
        }

        private function openStowList():void
        {
            myTimer.stop();
            AllWindows.switchToFuncWindow(StowLists.EVENT_SHOW);
            stowListOpen = true;
        }

        private function set troopAmount(_arg_1:int):void
        {
            var _local_2:Object = this._779951690troopAmount;
            if (_local_2 !== _arg_1)
            {
                this._779951690troopAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopAmount", _local_2, _arg_1));
            };
        }

        public function set heroSelCom(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2108485791heroSelCom;
            if (_local_2 !== _arg_1)
            {
                this._2108485791heroSelCom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroSelCom", _local_2, _arg_1));
            };
        }

        public function set input_militia(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._426045858input_militia;
            if (_local_2 !== _arg_1)
            {
                this._426045858input_militia = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_militia", _local_2, _arg_1));
            };
        }

        public function __returnBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get useHorde():CheckBox
        {
            return (this._304455483useHorde);
        }

        private function set troops(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._865287327troops;
            if (_local_2 !== _arg_1)
            {
                this._865287327troops = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troops", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            var _local_2:ArrayCollection;
            var _local_3:int;
            var _local_4:BuildingBean;
            var _local_5:HeroBean;
            var _local_6:Object;
            var _local_1:Number = 1;
            this.castle = Context.getInstance().getCurCastle();
            switch (this.castle.powerlevel)
            {
                case FieldConstants.POWER_NORMAL:
                    _local_1 = 1;
                    break;
                case FieldConstants.POWER_COUNTY:
                    _local_1 = 1.25;
                    break;
                case FieldConstants.POWER_STATE:
                    _local_1 = 1.5;
                    break;
                case FieldConstants.POWER_NATION:
                    _local_1 = 2;
                    break;
                case FieldConstants.POWER_WORLD:
                    _local_1 = 3;
                    break;
            };
            _local_2 = MainFramePlayerBuff.instance.bar.buffsArray;
            _local_3 = 0;
            while (_local_3 < _local_2.length)
            {
                if (((BuffBean(_local_2[_local_3]).typeId == "HauntedCastleBuf") || (BuffBean(_local_2[_local_3]).typeId == "HauntedCastleAdvBuf")))
                {
                    _local_1 = (_local_1 + 0.25);
                };
                if (BuffBean(_local_2[_local_3]).typeId == "EasterPVPBuff")
                {
                    _local_1 = (_local_1 + 0.1);
                };
                _local_3++;
            };
            for each (_local_4 in this.castle.buildingsArray)
            {
                if (_local_4.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
                {
                    this.maxTroopLimit = ((_local_4.level * 10000) * _local_1);
                    if (_local_4.level > 10)
                    {
                        this.maxTroopLimit = (((10 * 10000) * _local_1) + ((_local_4.level - 10) * 15000));
                    };
                    this.maxNum = this.maxTroopLimit;
                    this.troopCanAdd = this.maxTroopLimit;
                };
            };
            this.troops = castle.troop;
            this.resource = castle.resource;
            this.foodBean = this.castle.resource.food;
            troopObjAry = [this.input_peasants.numInput, this.input_militia.numInput, this.input_scouter.numInput, this.input_pikemen.numInput, this.input_swordsmen.numInput, this.input_archer.numInput, this.input_carriage.numInput, this.input_lightCavalry.numInput, this.input_heavyCavalry.numInput, this.input_ballista.numInput, this.input_batteringRam.numInput, this.input_catapult.numInput];
            troopAmountAry = [this.troops.peasants, this.troops.militia, this.troops.scouter, this.troops.pikemen, this.troops.swordsmen, this.troops.archer, this.troops.carriage, this.troops.lightCavalry, this.troops.heavyCavalry, this.troops.ballista, this.troops.batteringRam, this.troops.catapult];
            this.missionTypeSelectedIndex = -1;
            if (((!(this.eventData == null)) && (this.eventData is NewArmyEventData)))
            {
                this.newArmyData = (this.eventData as NewArmyEventData);
                this.eventData = null;
            }
            else
            {
                this.newArmyData = new NewArmyEventData();
                this.newArmyData.x = 0;
                this.newArmyData.y = 0;
                this.newArmyData.missionType = ObjConstants.ARMY_MISSION_TRANS;
            };
            _local_3 = 0;
            while (_local_3 < this.missionTypeArray.length)
            {
                _local_6 = this.missionTypeArray[_local_3];
                if (_local_6.data == this.newArmyData.missionType)
                {
                    this.missionTypeSelectedIndex = _local_3;
                    break;
                };
                _local_3++;
            };
            this.heros.removeAll();
            selectedHero = getEmptyHeroBean();
            this.heros.addItem(selectedHero);
            for each (_local_5 in castle.herosArray)
            {
                if (_local_5.status == HeroConstants.HERO_FREE_STATU)
                {
                    this.heros.addItem(_local_5);
                };
            };
            this.setDefaultHero();
            this.leftFood = Math.floor(this.resource.food.amount);
            ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
            if (myTimer != null)
            {
                if (!myTimer.running)
                {
                    myTimer.start();
                };
            };
            this.disCount = this.getdistance();
            if (((this.initialized) && (!(this.stowListOpen))))
            {
                this.numInit();
                troopConfig.selectedIndex = 0;
            }
            else
            {
                this.stowListOpen = false;
            };
            if (watcher != null)
            {
                watcher.unwatch();
            };
            watcher = BindingUtils.bindProperty(this, "foodChange", foodBean, "amount");
            ActionFactory.getInstance().getArmyCommands().IsDropItemInCastle(this.newArmyData.x, this.newArmyData.y);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY__IS_DROP_ITEM_IN_CASTLE, onCastleDrop);
        }

        public function set input_pikemen(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._2059551634input_pikemen;
            if (_local_2 !== _arg_1)
            {
                this._2059551634input_pikemen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_pikemen", _local_2, _arg_1));
            };
        }

        private function resourceGross():int
        {
            return ((((this.input_food.numInput.currentValue + this.input_gold.numInput.currentValue) + this.input_wood.numInput.currentValue) + this.input_stone.numInput.currentValue) + this.input_iron.numInput.currentValue);
        }

        [Bindable(event="propertyChange")]
        private function get reachTime():String
        {
            return (this._1134711072reachTime);
        }

        public function set input_ballista(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._821205909input_ballista;
            if (_local_2 !== _arg_1)
            {
                this._821205909input_ballista = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_ballista", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input_carriage():TroopInput
        {
            return (this._1098902761input_carriage);
        }

        [Bindable(event="propertyChange")]
        private function get setBtnEnable():Boolean
        {
            return (this._1726188733setBtnEnable);
        }

        private function timeInPutChange():void
        {
            var _local_2:Number;
            var _local_1:int;
            for each (_local_2 in costObj)
            {
                _local_1 = (_local_1 + _local_2);
            };
            if (int(this.hourInput.text) >= 24)
            {
                this.hourInput.text = "24";
                this.mimuteInput.text = "00";
            };
            if (int(this.mimuteInput.text) > 60)
            {
                this.mimuteInput.text = "60";
            };
            this.encampTime = ((((int(this.hourInput.text) * 60) + int(this.mimuteInput.text)) * 60) * 1000);
            this.needFood = int((this.portableFood + (_local_1 * ((this.encampTime / 1000) / 3600))));
            this.leftFood = Math.floor((this.resource.food.amount - this.needFood));
            this.leftSpace = (this.loads - this.needFood);
            this.needTimeStr = UIUtil.timeToString(((this.needTime + this.encampTime) / 1000));
        }

        private function onIsCallBack(_arg_1:Boolean):void
        {
            switch (_arg_1)
            {
                case true:
                    this.param.backAfterConstruct = true;
                    break;
                case false:
                    this.param.backAfterConstruct = false;
                    break;
            };
            ActionFactory.getInstance().getArmyCommands().newArmy(this.castle.id, param);
        }

        [Bindable(event="propertyChange")]
        private function get troopAmount():int
        {
            return (this._779951690troopAmount);
        }

        [Bindable(event="propertyChange")]
        public function get input_catapult():TroopInput
        {
            return (this._1140689133input_catapult);
        }

        private function onNewArmyResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (param.useFlag)
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameUse", "player.troop.1.a", "War Ensign", "宝物", "30");
                    };
                };
                AlertWin.show(Lang.msg("出征成功您可以在军情情报中看到你的部队的信息"));
                this.setFreeHeros();
                lastTroopSet = param.troops;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get castle():CastleBean
        {
            return (this._1367558920castle);
        }

        public function __troopConfig_change(_arg_1:ListEvent):void
        {
            changeSet(_arg_1);
        }

        public function ___NewArmyWin_ComboBox1_change(_arg_1:ListEvent):void
        {
            onMissionTypeChange(_arg_1);
        }

        private function set needTime(_arg_1:int):void
        {
            var _local_2:Object = this._865670275needTime;
            if (_local_2 !== _arg_1)
            {
                this._865670275needTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needTime", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set maxNum(_arg_1:int):void
        {
            var _local_2:Object = this._1081154686maxNum;
            if (_local_2 !== _arg_1)
            {
                this._1081154686maxNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxNum", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_CheckBox3_change(_arg_1:Event):void
        {
            changeAlpha(_arg_1);
        }

        private function init():void
        {
            troopTypeAry = [this.input_archer, this.input_ballista, this.input_batteringRam, this.input_carriage, this.input_swordsmen, this.input_scouter, this.input_catapult, this.input_heavyCavalry, this.input_lightCavalry, this.input_militia, this.input_peasants, this.input_pikemen];
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            MsgDispacther.getInstance().addEventListener(AllWindows.EVENT_CHANGE, onGetCoordinate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_GET_TROOP_PARAM, onGetTroopParam);
        }

        [Bindable(event="propertyChange")]
        public function get returnBtn():Button
        {
            return (this._926713076returnBtn);
        }

        [Bindable(event="propertyChange")]
        private function get leftFood():Number
        {
            return (this._1718011141leftFood);
        }

        private function _NewArmyWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出征");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("目标") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label1.text = _arg_1;
            }, "_NewArmyWin_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.newArmyData.x;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                input_x.text = _arg_1;
            }, "input_x.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.newArmyData.y;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                input_y.text = _arg_1;
            }, "input_y.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("收藏列表");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Button1.label = _arg_1;
            }, "_NewArmyWin_Button1.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("出征任务") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label4.text = _arg_1;
            }, "_NewArmyWin_Label4.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (missionTypeArray);
            }, function (_arg_1:Object):void
            {
                _NewArmyWin_ComboBox1.dataProvider = _arg_1;
            }, "_NewArmyWin_ComboBox1.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.missionTypeSelectedIndex);
            }, function (_arg_1:int):void
            {
                _NewArmyWin_ComboBox1.selectedIndex = _arg_1;
            }, "_NewArmyWin_ComboBox1.selectedIndex");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("英雄") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label5.text = _arg_1;
            }, "_NewArmyWin_Label5.text");
            result[8] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heros);
            }, function (_arg_1:Object):void
            {
                heroSelCom.dataProvider = _arg_1;
            }, "heroSelCom.dataProvider");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("宿营时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label6.text = _arg_1;
            }, "_NewArmyWin_Label6.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("小时");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label7.text = _arg_1;
            }, "_NewArmyWin_Label7.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("分钟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label8.text = _arg_1;
            }, "_NewArmyWin_Label8.text");
            result[12] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.leftFood);
            }, function (_arg_1:Number):void
            {
                input_food.limit = _arg_1;
            }, "input_food.limit");
            result[13] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.leftSpace);
            }, function (_arg_1:int):void
            {
                input_food.leftSource = _arg_1;
            }, "input_food.leftSource");
            result[14] = binding;
            binding = new Binding(this, function ():Function
            {
                return (carryResouce);
            }, function (_arg_1:Function):void
            {
                input_food.onDataFun = _arg_1;
            }, "input_food.onDataFun");
            result[15] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.wood.amount);
            }, function (_arg_1:Number):void
            {
                input_wood.limit = _arg_1;
            }, "input_wood.limit");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.leftSpace);
            }, function (_arg_1:int):void
            {
                input_wood.leftSource = _arg_1;
            }, "input_wood.leftSource");
            result[17] = binding;
            binding = new Binding(this, function ():Function
            {
                return (carryResouce);
            }, function (_arg_1:Function):void
            {
                input_wood.onDataFun = _arg_1;
            }, "input_wood.onDataFun");
            result[18] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.stone.amount);
            }, function (_arg_1:Number):void
            {
                input_stone.limit = _arg_1;
            }, "input_stone.limit");
            result[19] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.leftSpace);
            }, function (_arg_1:int):void
            {
                input_stone.leftSource = _arg_1;
            }, "input_stone.leftSource");
            result[20] = binding;
            binding = new Binding(this, function ():Function
            {
                return (carryResouce);
            }, function (_arg_1:Function):void
            {
                input_stone.onDataFun = _arg_1;
            }, "input_stone.onDataFun");
            result[21] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.iron.amount);
            }, function (_arg_1:Number):void
            {
                input_iron.limit = _arg_1;
            }, "input_iron.limit");
            result[22] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.leftSpace);
            }, function (_arg_1:int):void
            {
                input_iron.leftSource = _arg_1;
            }, "input_iron.leftSource");
            result[23] = binding;
            binding = new Binding(this, function ():Function
            {
                return (carryResouce);
            }, function (_arg_1:Function):void
            {
                input_iron.onDataFun = _arg_1;
            }, "input_iron.onDataFun");
            result[24] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.gold);
            }, function (_arg_1:Number):void
            {
                input_gold.limit = _arg_1;
            }, "input_gold.limit");
            result[25] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.leftSpace);
            }, function (_arg_1:int):void
            {
                input_gold.leftSource = _arg_1;
            }, "input_gold.leftSource");
            result[26] = binding;
            binding = new Binding(this, function ():Function
            {
                return (carryResouce);
            }, function (_arg_1:Function):void
            {
                input_gold.onDataFun = _arg_1;
            }, "input_gold.onDataFun");
            result[27] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Button2.label = _arg_1;
            }, "_NewArmyWin_Button2.label");
            result[28] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                returnBtn.label = _arg_1;
            }, "returnBtn.label");
            result[29] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label9.text = _arg_1;
            }, "_NewArmyWin_Label9.text");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("清空");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                troopMinBtn.label = _arg_1;
            }, "troopMinBtn.label");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最大");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                troopMaxBtn.label = _arg_1;
            }, "troopMaxBtn.label");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择军旗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                useFlag.label = _arg_1;
            }, "useFlag.label");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择Horde");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                useHorde.label = _arg_1;
            }, "useHorde.label");
            result[34] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PEASANTS);
            }, function (_arg_1:int):void
            {
                input_peasants.troopType = _arg_1;
            }, "input_peasants.troopType");
            result[35] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.peasants);
            }, function (_arg_1:int):void
            {
                input_peasants.limit = _arg_1;
            }, "input_peasants.limit");
            result[36] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_peasants.maxLimit = _arg_1;
            }, "input_peasants.maxLimit");
            result[37] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_peasants.fun = _arg_1;
            }, "input_peasants.fun");
            result[38] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_peasants.distance = _arg_1;
            }, "input_peasants.distance");
            result[39] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_MILITIA);
            }, function (_arg_1:int):void
            {
                input_militia.troopType = _arg_1;
            }, "input_militia.troopType");
            result[40] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.militia);
            }, function (_arg_1:int):void
            {
                input_militia.limit = _arg_1;
            }, "input_militia.limit");
            result[41] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_militia.maxLimit = _arg_1;
            }, "input_militia.maxLimit");
            result[42] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_militia.fun = _arg_1;
            }, "input_militia.fun");
            result[43] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_militia.distance = _arg_1;
            }, "input_militia.distance");
            result[44] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SCOUTER);
            }, function (_arg_1:int):void
            {
                input_scouter.troopType = _arg_1;
            }, "input_scouter.troopType");
            result[45] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.scouter);
            }, function (_arg_1:int):void
            {
                input_scouter.limit = _arg_1;
            }, "input_scouter.limit");
            result[46] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_scouter.maxLimit = _arg_1;
            }, "input_scouter.maxLimit");
            result[47] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_scouter.fun = _arg_1;
            }, "input_scouter.fun");
            result[48] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_scouter.distance = _arg_1;
            }, "input_scouter.distance");
            result[49] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PIKEMAN);
            }, function (_arg_1:int):void
            {
                input_pikemen.troopType = _arg_1;
            }, "input_pikemen.troopType");
            result[50] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.pikemen);
            }, function (_arg_1:int):void
            {
                input_pikemen.limit = _arg_1;
            }, "input_pikemen.limit");
            result[51] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_pikemen.maxLimit = _arg_1;
            }, "input_pikemen.maxLimit");
            result[52] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_pikemen.fun = _arg_1;
            }, "input_pikemen.fun");
            result[53] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_pikemen.distance = _arg_1;
            }, "input_pikemen.distance");
            result[54] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SWORDSMEN);
            }, function (_arg_1:int):void
            {
                input_swordsmen.troopType = _arg_1;
            }, "input_swordsmen.troopType");
            result[55] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.swordsmen);
            }, function (_arg_1:int):void
            {
                input_swordsmen.limit = _arg_1;
            }, "input_swordsmen.limit");
            result[56] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_swordsmen.maxLimit = _arg_1;
            }, "input_swordsmen.maxLimit");
            result[57] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_swordsmen.fun = _arg_1;
            }, "input_swordsmen.fun");
            result[58] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_swordsmen.distance = _arg_1;
            }, "input_swordsmen.distance");
            result[59] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_ARCHER);
            }, function (_arg_1:int):void
            {
                input_archer.troopType = _arg_1;
            }, "input_archer.troopType");
            result[60] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.archer);
            }, function (_arg_1:int):void
            {
                input_archer.limit = _arg_1;
            }, "input_archer.limit");
            result[61] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_archer.maxLimit = _arg_1;
            }, "input_archer.maxLimit");
            result[62] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_archer.fun = _arg_1;
            }, "input_archer.fun");
            result[63] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_archer.distance = _arg_1;
            }, "input_archer.distance");
            result[64] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_LIGHTCAVALRY);
            }, function (_arg_1:int):void
            {
                input_lightCavalry.troopType = _arg_1;
            }, "input_lightCavalry.troopType");
            result[65] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.lightCavalry);
            }, function (_arg_1:int):void
            {
                input_lightCavalry.limit = _arg_1;
            }, "input_lightCavalry.limit");
            result[66] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_lightCavalry.maxLimit = _arg_1;
            }, "input_lightCavalry.maxLimit");
            result[67] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_lightCavalry.fun = _arg_1;
            }, "input_lightCavalry.fun");
            result[68] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_lightCavalry.distance = _arg_1;
            }, "input_lightCavalry.distance");
            result[69] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_HEAVYCAVALRY);
            }, function (_arg_1:int):void
            {
                input_heavyCavalry.troopType = _arg_1;
            }, "input_heavyCavalry.troopType");
            result[70] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.heavyCavalry);
            }, function (_arg_1:int):void
            {
                input_heavyCavalry.limit = _arg_1;
            }, "input_heavyCavalry.limit");
            result[71] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_heavyCavalry.maxLimit = _arg_1;
            }, "input_heavyCavalry.maxLimit");
            result[72] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_heavyCavalry.fun = _arg_1;
            }, "input_heavyCavalry.fun");
            result[73] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_heavyCavalry.distance = _arg_1;
            }, "input_heavyCavalry.distance");
            result[74] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CARRIAGE);
            }, function (_arg_1:int):void
            {
                input_carriage.troopType = _arg_1;
            }, "input_carriage.troopType");
            result[75] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.carriage);
            }, function (_arg_1:int):void
            {
                input_carriage.limit = _arg_1;
            }, "input_carriage.limit");
            result[76] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_carriage.maxLimit = _arg_1;
            }, "input_carriage.maxLimit");
            result[77] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_carriage.fun = _arg_1;
            }, "input_carriage.fun");
            result[78] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_carriage.distance = _arg_1;
            }, "input_carriage.distance");
            result[79] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BALLISTA);
            }, function (_arg_1:int):void
            {
                input_ballista.troopType = _arg_1;
            }, "input_ballista.troopType");
            result[80] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.ballista);
            }, function (_arg_1:int):void
            {
                input_ballista.limit = _arg_1;
            }, "input_ballista.limit");
            result[81] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_ballista.maxLimit = _arg_1;
            }, "input_ballista.maxLimit");
            result[82] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_ballista.fun = _arg_1;
            }, "input_ballista.fun");
            result[83] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_ballista.distance = _arg_1;
            }, "input_ballista.distance");
            result[84] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BATTERINGRAM);
            }, function (_arg_1:int):void
            {
                input_batteringRam.troopType = _arg_1;
            }, "input_batteringRam.troopType");
            result[85] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.batteringRam);
            }, function (_arg_1:int):void
            {
                input_batteringRam.limit = _arg_1;
            }, "input_batteringRam.limit");
            result[86] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_batteringRam.maxLimit = _arg_1;
            }, "input_batteringRam.maxLimit");
            result[87] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_batteringRam.fun = _arg_1;
            }, "input_batteringRam.fun");
            result[88] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_batteringRam.distance = _arg_1;
            }, "input_batteringRam.distance");
            result[89] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CATAPULT);
            }, function (_arg_1:int):void
            {
                input_catapult.troopType = _arg_1;
            }, "input_catapult.troopType");
            result[90] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.catapult);
            }, function (_arg_1:int):void
            {
                input_catapult.limit = _arg_1;
            }, "input_catapult.limit");
            result[91] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.troopCanAdd);
            }, function (_arg_1:int):void
            {
                input_catapult.maxLimit = _arg_1;
            }, "input_catapult.maxLimit");
            result[92] = binding;
            binding = new Binding(this, function ():Function
            {
                return (speedFood);
            }, function (_arg_1:Function):void
            {
                input_catapult.fun = _arg_1;
            }, "input_catapult.fun");
            result[93] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_catapult.distance = _arg_1;
            }, "input_catapult.distance");
            result[94] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("之前设置") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label10.text = _arg_1;
            }, "_NewArmyWin_Label10.text");
            result[95] = binding;
            binding = new Binding(this, function ():Object
            {
                return (setTroopArray);
            }, function (_arg_1:Object):void
            {
                troopConfig.dataProvider = _arg_1;
            }, "troopConfig.dataProvider");
            result[96] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (setBtnEnable);
            }, function (_arg_1:Boolean):void
            {
                _NewArmyWin_Button6.enabled = _arg_1;
            }, "_NewArmyWin_Button6.enabled");
            result[97] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("保存属性");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Button6.label = _arg_1;
            }, "_NewArmyWin_Button6.label");
            result[98] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("估计出征时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text1.text = _arg_1;
            }, "_NewArmyWin_Text1.text");
            result[99] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("单程时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text2.text = _arg_1;
            }, "_NewArmyWin_Text2.text");
            result[100] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.needTimeStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text3.text = _arg_1;
            }, "_NewArmyWin_Text3.text");
            result[101] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("到达时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text4.text = _arg_1;
            }, "_NewArmyWin_Text4.text");
            result[102] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.reachTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text5.text = _arg_1;
            }, "_NewArmyWin_Text5.text");
            result[103] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出征要求及负重");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text6.text = _arg_1;
            }, "_NewArmyWin_Text6.text");
            result[104] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("出征耗粮") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text7.text = _arg_1;
            }, "_NewArmyWin_Text7.text");
            result[105] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.needFood;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text8.text = _arg_1;
            }, "_NewArmyWin_Text8.text");
            result[106] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所剩负载") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text9.text = _arg_1;
            }, "_NewArmyWin_Text9.text");
            result[107] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.leftSpace;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text10.text = _arg_1;
            }, "_NewArmyWin_Text10.text");
            result[108] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("出征上限") + " ") + this.troopCanAdd);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label11.text = _arg_1;
            }, "_NewArmyWin_Label11.text");
            result[109] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("半透明");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_CheckBox3.label = _arg_1;
            }, "_NewArmyWin_CheckBox3.label");
            result[110] = binding;
            return (result);
        }

        public function ___NewArmyWin_Button1_click(_arg_1:MouseEvent):void
        {
            openStowList();
        }

        [Bindable(event="propertyChange")]
        private function get missionTypeArray():ArrayCollection
        {
            return (this._991165677missionTypeArray);
        }

        [Bindable(event="propertyChange")]
        public function get mimuteInput():TextInput
        {
            return (this._613351659mimuteInput);
        }

        [Bindable(event="propertyChange")]
        public function get input_heavyCavalry():TroopInput
        {
            return (this._1219601176input_heavyCavalry);
        }

        [Bindable(event="propertyChange")]
        private function get disCount():Number
        {
            return (this._243631393disCount);
        }

        private function useFlagChange():void
        {
            if (this.useFlag.selected)
            {
                this.maxNum = (this.maxTroopLimit * 1.25);
                this.troopCanAdd = (this.maxNum - this.troopAmount);
            }
            else
            {
                this.maxNum = this.maxTroopLimit;
                this.troopCanAdd = (this.maxNum - this.troopAmount);
            };
            if (this.useHorde.selected)
            {
                this.maxNum = (this.maxNum * 10);
                this.troopCanAdd = (this.maxNum - this.troopAmount);
            };
        }

        public function set useFlag(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._148431469useFlag;
            if (_local_2 !== _arg_1)
            {
                this._148431469useFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useFlag", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get troopConfig():ComboBox
        {
            return (this._839012660troopConfig);
        }

        public function set input_archer(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._620580248input_archer;
            if (_local_2 !== _arg_1)
            {
                this._620580248input_archer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_archer", _local_2, _arg_1));
            };
        }

        public function set troopMinBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1119728796troopMinBtn;
            if (_local_2 !== _arg_1)
            {
                this._1119728796troopMinBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMinBtn", _local_2, _arg_1));
            };
        }

        private function _NewArmyWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("出征");
            _local_1 = (Lang.msg("目标") + ": ");
            _local_1 = this.newArmyData.x;
            _local_1 = this.newArmyData.y;
            _local_1 = Lang.msg("收藏列表");
            _local_1 = (Lang.msg("出征任务") + ": ");
            _local_1 = missionTypeArray;
            _local_1 = this.missionTypeSelectedIndex;
            _local_1 = (Lang.msg("英雄") + ": ");
            _local_1 = this.heros;
            _local_1 = (Lang.msg("宿营时间") + ": ");
            _local_1 = Lang.msg("小时");
            _local_1 = Lang.msg("分钟");
            _local_1 = this.leftFood;
            _local_1 = this.leftSpace;
            _local_1 = carryResouce;
            _local_1 = this.resource.wood.amount;
            _local_1 = this.leftSpace;
            _local_1 = carryResouce;
            _local_1 = this.resource.stone.amount;
            _local_1 = this.leftSpace;
            _local_1 = carryResouce;
            _local_1 = this.resource.iron.amount;
            _local_1 = this.leftSpace;
            _local_1 = carryResouce;
            _local_1 = this.resource.gold;
            _local_1 = this.leftSpace;
            _local_1 = carryResouce;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("返回");
            _local_1 = Lang.msg("选择军队");
            _local_1 = Lang.msg("清空");
            _local_1 = Lang.msg("最大");
            _local_1 = Lang.msg("选择军旗");
            _local_1 = Lang.msg("选择Horde");
            _local_1 = TFConstants.T_PEASANTS;
            _local_1 = troops.peasants;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_MILITIA;
            _local_1 = troops.militia;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_SCOUTER;
            _local_1 = troops.scouter;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_PIKEMAN;
            _local_1 = troops.pikemen;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_SWORDSMEN;
            _local_1 = troops.swordsmen;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_ARCHER;
            _local_1 = troops.archer;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_LIGHTCAVALRY;
            _local_1 = troops.lightCavalry;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_HEAVYCAVALRY;
            _local_1 = troops.heavyCavalry;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_CARRIAGE;
            _local_1 = troops.carriage;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_BALLISTA;
            _local_1 = troops.ballista;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_BATTERINGRAM;
            _local_1 = troops.batteringRam;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_CATAPULT;
            _local_1 = troops.catapult;
            _local_1 = this.troopCanAdd;
            _local_1 = speedFood;
            _local_1 = this.disCount;
            _local_1 = (Lang.msg("之前设置") + ":");
            _local_1 = setTroopArray;
            _local_1 = setBtnEnable;
            _local_1 = Lang.msg("保存属性");
            _local_1 = Lang.msg("估计出征时间");
            _local_1 = (Lang.msg("单程时间") + ": ");
            _local_1 = this.needTimeStr;
            _local_1 = (Lang.msg("到达时间") + ": ");
            _local_1 = this.reachTime;
            _local_1 = Lang.msg("出征要求及负重");
            _local_1 = (Lang.msg("出征耗粮") + ": ");
            _local_1 = this.needFood;
            _local_1 = (Lang.msg("所剩负载") + ": ");
            _local_1 = this.leftSpace;
            _local_1 = ((Lang.msg("出征上限") + " ") + this.troopCanAdd);
            _local_1 = Lang.msg("半透明");
        }

        [Bindable(event="propertyChange")]
        private function get foodBean():ResourceInfoBean
        {
            return (this._378942766foodBean);
        }

        [Bindable(event="propertyChange")]
        private function get leftSpace():int
        {
            return (this._1730759999leftSpace);
        }

        [Bindable(event="propertyChange")]
        public function get input_x():NumberInput
        {
            return (this._1954847043input_x);
        }

        private function sendArmy():void
        {
            var _local_3:int;
            param.resource = new ResourceBean();
            param.troops = new TroopBean();
            param.resource.wood = this.input_wood.numInput.currentValue;
            param.resource.food = this.input_food.numInput.currentValue;
            param.resource.iron = this.input_iron.numInput.currentValue;
            param.resource.gold = this.input_gold.numInput.currentValue;
            param.resource.stone = this.input_stone.numInput.currentValue;
            param.troops.peasants = this.input_peasants.numInput.currentValue;
            param.troops.militia = this.input_militia.numInput.currentValue;
            param.troops.scouter = this.input_scouter.numInput.currentValue;
            param.troops.pikemen = this.input_pikemen.numInput.currentValue;
            param.troops.swordsmen = this.input_swordsmen.numInput.currentValue;
            param.troops.archer = this.input_archer.numInput.currentValue;
            param.troops.carriage = this.input_carriage.numInput.currentValue;
            param.troops.lightCavalry = this.input_lightCavalry.numInput.currentValue;
            param.troops.heavyCavalry = this.input_heavyCavalry.numInput.currentValue;
            param.troops.ballista = this.input_ballista.numInput.currentValue;
            param.troops.batteringRam = this.input_batteringRam.numInput.currentValue;
            param.troops.catapult = this.input_catapult.numInput.currentValue;
            if (this.selectedHero != null)
            {
                param.heroId = this.selectedHero.id;
            };
            var _local_1:int = int(this.input_x.text);
            var _local_2:int = int(this.input_y.text);
            param.targetPoint = ((_local_2 * Context.mapSizeY) + _local_1);
            param.missionType = newArmyData.missionType;
            param.restTime = (this.encampTime / 1000);
            param.useFlag = this.useFlag.selected;
            param.useItem = this.useHorde.selected;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_NEW_ARMY, onNewArmyResponse, false, 0, true);
            this.troopAmount = 0;
            while (_local_3 < troopTypeAry.length)
            {
                this.troopAmount = (this.troopAmount + TroopInput(troopTypeAry[_local_3]).numInput.currentValue);
                _local_3++;
            };
            if (this.needFood > this.resource.food.amount)
            {
                AlertWin.show(Lang.msg("资源不够出征耗粮大于本城资源"));
            }
            else
            {
                if (this.troopAmount == 0)
                {
                    AlertWin.show(Lang.msg("请最少选一名士兵"));
                }
                else
                {
                    if (this.leftSpace < 0)
                    {
                        AlertWin.show(Lang.msg("负重空间不够"));
                    }
                    else
                    {
                        if (newArmyData.missionType == ObjConstants.ARMY_MISSION_CONSTRUCT)
                        {
                            AlertWin.show(Lang.msg("是否遣送部队回城"), onIsCallBack, Lang.msg("是"), Lang.msg("否"));
                        }
                        else
                        {
                            ActionFactory.getInstance().getArmyCommands().newArmy(this.castle.id, param);
                        };
                    };
                };
            };
        }

        private function onCastleDrop(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function getdistance():Number
        {
            var _local_1:Number;
            var _local_2:Point;
            if (this.initialized)
            {
                _local_2 = new Point(int(this.input_x.text), int(this.input_y.text));
                _local_1 = this.countDistance(null, _local_2);
            }
            else
            {
                _local_1 = this.countDistance(null, null);
            };
            return (_local_1);
        }

        private function speedFood(_arg_1:int, _arg_2:int, _arg_3:Number):void
        {
            var _local_9:int;
            var _local_10:Number;
            var _local_11:int;
            var _local_12:int;
            var _local_15:BuffBean;
            var _local_17:Number;
            var _local_18:Number;
            this.portableFood = 0;
            this.loads = 0;
            this.TypeId = _arg_2;
            this.Costnum = _arg_1;
            this.distane = _arg_3;
            var _local_4:Number = (_arg_3 * NewArmyWin.recSize);
            var _local_5:TroopEum = TroopEumDefine.getTroopEumByType(_arg_2);
            var _local_6:Number = (_local_5.foodRequest * 2);
            var _local_7:Number = ((_local_5.load * _arg_1) * (1 + (this.loadSkillParam / 100)));
            var _local_8:int = _local_5.speed;
            this.troopAmount = 0;
            while (_local_9 < troopTypeAry.length)
            {
                this.troopAmount = (this.troopAmount + TroopInput(troopTypeAry[_local_9]).numInput.currentValue);
                _local_9++;
            };
            this.troopCanAdd = (this.maxNum - this.troopAmount);
            switch (_arg_2)
            {
                case TFConstants.T_ARCHER:
                    costObj["T_ARCHER"] = (_local_6 * _arg_1);
                    loadObj["T_ARCHER"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_ARCHER"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_ARCHER"] = 0;
                    };
                    break;
                case TFConstants.T_BALLISTA:
                    costObj["T_BALLISTA"] = (_local_6 * _arg_1);
                    loadObj["T_BALLISTA"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_BALLISTA"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_BALLISTA"] = 0;
                    };
                    break;
                case TFConstants.T_BATTERINGRAM:
                    costObj["T_BATTERINGRAM"] = (_local_6 * _arg_1);
                    loadObj["T_BATTERINGRAM"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_BATTERINGRAM"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_BATTERINGRAM"] = 0;
                    };
                    break;
                case TFConstants.T_CARRIAGE:
                    costObj["T_CARRIAGE"] = (_local_6 * _arg_1);
                    loadObj["T_CARRIAGE"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_CARRIAGE"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_CARRIAGE"] = 0;
                    };
                    break;
                case TFConstants.T_CATAPULT:
                    costObj["T_CATAPULT"] = (_local_6 * _arg_1);
                    loadObj["T_CATAPULT"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_CATAPULT"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_CATAPULT"] = 0;
                    };
                    break;
                case TFConstants.T_HEAVYCAVALRY:
                    costObj["T_HEAVYCAVALRY"] = (_local_6 * _arg_1);
                    loadObj["T_HEAVYCAVALRY"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_HEAVYCAVALRY"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_HEAVYCAVALRY"] = 0;
                    };
                    break;
                case TFConstants.T_LIGHTCAVALRY:
                    costObj["T_LIGHTCAVALRY"] = (_local_6 * _arg_1);
                    loadObj["T_LIGHTCAVALRY"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_LIGHTCAVALRY"] = ((_local_8 * (1 + (this.driveSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_LIGHTCAVALRY"] = 0;
                    };
                    break;
                case TFConstants.T_MILITIA:
                    costObj["T_MILITIA"] = (_local_6 * _arg_1);
                    loadObj["T_MILITIA"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_MILITIA"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_MILITIA"] = 0;
                    };
                    break;
                case TFConstants.T_PEASANTS:
                    costObj["T_PEASANTS"] = (_local_6 * _arg_1);
                    loadObj["T_PEASANTS"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_PEASANTS"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_PEASANTS"] = 0;
                    };
                    break;
                case TFConstants.T_PIKEMAN:
                    costObj["T_PIKEMAN"] = (_local_6 * _arg_1);
                    loadObj["T_PIKEMAN"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_PIKEMAN"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_PIKEMAN"] = 0;
                    };
                    break;
                case TFConstants.T_SCOUTER:
                    costObj["T_SCOUTER"] = (_local_6 * _arg_1);
                    loadObj["T_SCOUTER"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_SCOUTER"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_SCOUTER"] = 0;
                    };
                    break;
                case TFConstants.T_SWORDSMEN:
                    costObj["T_SWORDSMEN"] = (_local_6 * _arg_1);
                    loadObj["T_SWORDSMEN"] = _local_7;
                    if (_arg_1 != 0)
                    {
                        speedObj["T_SWORDSMEN"] = ((_local_8 * (1 + (this.marchSkillParam / 100))) * (1 + (this.selectedHero.speed / 100)));
                    }
                    else
                    {
                        speedObj["T_SWORDSMEN"] = 0;
                    };
                    break;
            };
            for each (_local_10 in loadObj)
            {
                this.loads = (this.loads + _local_10);
            };
            speedAry.splice(0);
            for each (_local_11 in speedObj)
            {
                if (_local_11 > 0)
                {
                    speedAry.push(_local_11);
                };
            };
            _local_12 = 0;
            if (speedAry.length > 0)
            {
                _local_12 = speedAry[0];
            };
            _local_9 = 0;
            while (_local_9 < speedAry.length)
            {
                if (_local_12 > speedAry[_local_9])
                {
                    _local_12 = speedAry[_local_9];
                };
                _local_9++;
            };
            if (transportSpeedAdd)
            {
                _local_12 = (transportStationParam * _local_12);
            };
            if (_local_12 != 0)
            {
                this.needTime = ((_local_4 / _local_12) * 1000);
            }
            else
            {
                this.needTime = 0;
            };
            var _local_13:Number = 0;
            var _local_14:int = Context.getInstance().getTimeDiff();
            for each (_local_15 in Context.getInstance().getCurCastle().buffsArray)
            {
                if (_local_15.typeId.indexOf("IncArmyActionTimeBuff") != -1)
                {
                    if (_local_15.endTime > _local_13)
                    {
                        _local_13 = _local_15.endTime;
                    };
                };
            };
            if (_local_13 > 0)
            {
                _local_18 = (new Date().valueOf() - _local_14);
                if ((_local_13 - _local_18) > ((8 * 3600) * 1000))
                {
                    this.needTime = (this.needTime + ((this.needTime * 60) / 100));
                }
                else
                {
                    if ((_local_13 - _local_18) > ((4 * 3600) * 1000))
                    {
                        this.needTime = (this.needTime + ((this.needTime * 40) / 100));
                    }
                    else
                    {
                        this.needTime = (this.needTime + ((this.needTime * 20) / 100));
                    };
                };
            };
            var _local_16:Number = 0;
            for each (_local_15 in Context.getInstance().getPlayerBean().buffsArray)
            {
                if (_local_15.typeId.indexOf("ReduceArmyActionBuff") != -1)
                {
                    if (_local_15.endTime > _local_16)
                    {
                        _local_16 = _local_15.endTime;
                    };
                };
            };
            if (_local_16 > 0)
            {
                _local_18 = (new Date().valueOf() - _local_14);
                if ((_local_16 - _local_18) > ((8 * 3600) * 1000))
                {
                    this.needTime = (this.needTime - ((this.needTime * 105) / 100));
                }
                else
                {
                    if ((_local_16 - _local_18) > ((4 * 3600) * 1000))
                    {
                        this.needTime = (this.needTime - ((this.needTime * 70) / 100));
                    }
                    else
                    {
                        this.needTime = (this.needTime - ((this.needTime * 35) / 100));
                    };
                };
            };
            for each (_local_15 in Context.getInstance().getPlayerBean().buffsArray)
            {
                if (_local_15.typeId.indexOf("HarvesterWagesBuff") != -1)
                {
                    this.needTime = ((this.needTime * 90) / 100);
                };
            };
            this.needTimeStr = UIUtil.timeToString((this.needTime / 1000));
            for each (_local_17 in costObj)
            {
                this.portableFood = (this.portableFood + (_local_17 * ((this.needTime / 3600) / 1000)));
                trace(("portableFood:" + this.portableFood));
            };
            this.needFood = int(this.portableFood);
            if (((!(this.newArmyData.isNpc)) && ((this.newArmyData.missionType == ObjConstants.ARMY_MISSION_OCCUPY) || (this.newArmyData.missionType == ObjConstants.ARMY_MISSION_COLONIZE))))
            {
                for each (_local_15 in Context.getInstance().getPlayerBean().buffsArray)
                {
                    if (_local_15.typeId.indexOf("EasterPVPBuff") != -1)
                    {
                        this.needFood = (Number(this.needFood) * (1 - 0.2));
                    };
                };
            };
            this.leftFood = Math.floor((this.resource.food.amount - this.needFood));
            this.leftSpace = Math.floor((this.loads - this.portableFood));
            if (((!(this.hourInput.text == "")) || (!(this.mimuteInput.text == ""))))
            {
                this.timeInPutChange();
            };
        }

        private function set newArmyData(_arg_1:NewArmyEventData):void
        {
            var _local_2:Object = this._158692185newArmyData;
            if (_local_2 !== _arg_1)
            {
                this._158692185newArmyData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newArmyData", _local_2, _arg_1));
            };
        }

        public function set input_peasants(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1049650600input_peasants;
            if (_local_2 !== _arg_1)
            {
                this._1049650600input_peasants = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_peasants", _local_2, _arg_1));
            };
        }

        private function set troopCanAdd(_arg_1:int):void
        {
            var _local_2:Object = this._826047651troopCanAdd;
            if (_local_2 !== _arg_1)
            {
                this._826047651troopCanAdd = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopCanAdd", _local_2, _arg_1));
            };
        }

        override protected function onClose(_arg_1:Event):void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            myTimer.stop();
        }

        public function set foodChange(_arg_1:Number):void
        {
            this.leftFood = Math.floor((_arg_1 - this.needFood));
        }

        public function set input_stone(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._36713392input_stone;
            if (_local_2 !== _arg_1)
            {
                this._36713392input_stone = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_stone", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get heroSelCom():ComboBox
        {
            return (this._2108485791heroSelCom);
        }

        private function set missionTypeSelectedIndex(_arg_1:int):void
        {
            var _local_2:Object = this._2116085169missionTypeSelectedIndex;
            if (_local_2 !== _arg_1)
            {
                this._2116085169missionTypeSelectedIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "missionTypeSelectedIndex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get troops():TroopBean
        {
            return (this._865287327troops);
        }

        public function set input_gold(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1386295221input_gold;
            if (_local_2 !== _arg_1)
            {
                this._1386295221input_gold = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_gold", _local_2, _arg_1));
            };
        }

        public function set input_scouter(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._435361974input_scouter;
            if (_local_2 !== _arg_1)
            {
                this._435361974input_scouter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_scouter", _local_2, _arg_1));
            };
        }

        public function set input_food(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1386265523input_food;
            if (_local_2 !== _arg_1)
            {
                this._1386265523input_food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_food", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_Button6_click(_arg_1:MouseEvent):void
        {
            setTroopConfig();
        }

        [Bindable(event="propertyChange")]
        public function get input_y():NumberInput
        {
            return (this._1954847044input_y);
        }

        private function setTroopConfig():void
        {
            var setTroopConfigResponse:Function;
            setTroopConfigResponse = function (_arg_1:TroopConfigResponse):void
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    Context.getInstance().getPlayerBean().troopConfigBeansArray = _arg_1.troopConfigBeansArray;
                    AlertWin.show("Setting saved.");
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            var temBean:TroopBean = new TroopBean();
            temBean.peasants = this.input_peasants.numInput.currentValue;
            temBean.militia = this.input_militia.numInput.currentValue;
            temBean.scouter = this.input_scouter.numInput.currentValue;
            temBean.pikemen = this.input_pikemen.numInput.currentValue;
            temBean.swordsmen = this.input_swordsmen.numInput.currentValue;
            temBean.archer = this.input_archer.numInput.currentValue;
            temBean.carriage = this.input_carriage.numInput.currentValue;
            temBean.lightCavalry = this.input_lightCavalry.numInput.currentValue;
            temBean.heavyCavalry = this.input_heavyCavalry.numInput.currentValue;
            temBean.ballista = this.input_ballista.numInput.currentValue;
            temBean.batteringRam = this.input_batteringRam.numInput.currentValue;
            temBean.catapult = this.input_catapult.numInput.currentValue;
            ActionFactory.getInstance().getCommonCommands().setTroopConfig(this.curSel, temBean, setTroopConfigResponse);
        }

        public function __troopMaxBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        private function set needTimeStr(_arg_1:String):void
        {
            var _local_2:Object = this._2095366482needTimeStr;
            if (_local_2 !== _arg_1)
            {
                this._2095366482needTimeStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needTimeStr", _local_2, _arg_1));
            };
        }

        private function set heros(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._99168185heros;
            if (_local_2 !== _arg_1)
            {
                this._99168185heros = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heros", _local_2, _arg_1));
            };
        }

        private function set setBtnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1726188733setBtnEnable;
            if (_local_2 !== _arg_1)
            {
                this._1726188733setBtnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "setBtnEnable", _local_2, _arg_1));
            };
        }

        private function getEmptyHeroBean():HeroBean
        {
            var _local_1:HeroBean = new HeroBean();
            _local_1.name = " - - ";
            _local_1.id = -1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get maxNum():int
        {
            return (this._1081154686maxNum);
        }

        public function set useHorde(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._304455483useHorde;
            if (_local_2 !== _arg_1)
            {
                this._304455483useHorde = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useHorde", _local_2, _arg_1));
            };
        }

        private function changeAlpha(_arg_1:Event):void
        {
            if (_arg_1.target.selected)
            {
                this.alpha = 0.4;
            }
            else
            {
                this.alpha = 1;
            };
        }

        override public function initialize():void
        {
            var target:NewArmyWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NewArmyWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_NewArmyWinWatcherSetupUtil");
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

        private function otherFieldInfo(_arg_1:OtherFieldInfoResponse):void
        {
            var _local_4:MapCastleBean;
            var _local_2:MapCastleBean = _arg_1.bean;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
                this.input_x.text = "0";
                this.input_y.text = "0";
                return;
            };
            var _local_3:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            _local_4 = _arg_1.bean;
            if (((_local_4.userName == _local_3.userName) || (_local_4.allianceName == _local_3.alliance)))
            {
                if (_local_4.type > 10)
                {
                    this.transportSpeedAdd = true;
                    ActionFactory.getInstance().getArmyCommands().getTroopParam(castle.id);
                };
            }
            else
            {
                this.transportSpeedAdd = false;
            };
            var _local_5:int;
            while (_local_5 < this.troopObjAry.length)
            {
                this.speedFood(troopObjAry[_local_5].currentValue, troopObjAry[_local_5].type, this.getdistance());
                _local_5++;
            };
        }

        private function setTroopInput(_arg_1:TroopBean):void
        {
            this.input_peasants.numInput.value = _arg_1.peasants;
            this.input_militia.numInput.value = _arg_1.militia;
            this.input_scouter.numInput.value = _arg_1.scouter;
            this.input_pikemen.numInput.value = _arg_1.pikemen;
            this.input_swordsmen.numInput.value = _arg_1.swordsmen;
            this.input_archer.numInput.value = _arg_1.archer;
            this.input_carriage.numInput.value = _arg_1.carriage;
            this.input_lightCavalry.numInput.value = _arg_1.lightCavalry;
            this.input_heavyCavalry.numInput.value = _arg_1.heavyCavalry;
            this.input_ballista.numInput.value = _arg_1.ballista;
            this.input_batteringRam.numInput.value = _arg_1.batteringRam;
            this.input_catapult.numInput.value = _arg_1.catapult;
        }

        [Bindable(event="propertyChange")]
        public function get useFlag():CheckBox
        {
            return (this._148431469useFlag);
        }

        [Bindable(event="propertyChange")]
        public function get input_peasants():TroopInput
        {
            return (this._1049650600input_peasants);
        }

        [Bindable(event="propertyChange")]
        private function get missionTypeSelectedIndex():int
        {
            return (this._2116085169missionTypeSelectedIndex);
        }

        [Bindable(event="propertyChange")]
        public function get input_gold():ResourceInput
        {
            return (this._1386295221input_gold);
        }

        private function numInit():void
        {
            this.input_wood.numInput.refresh();
            this.input_food.numInput.refresh();
            this.input_iron.numInput.refresh();
            this.input_gold.numInput.refresh();
            this.input_stone.numInput.refresh();
            var _local_1:int;
            while (_local_1 < this.troopObjAry.length)
            {
                troopObjAry[_local_1].refresh();
                _local_1++;
            };
            this.useFlag.selected = false;
            this.useHorde.selected = false;
        }

        public function __hourInput_change(_arg_1:Event):void
        {
            timeInPutChange();
        }

        [Bindable(event="propertyChange")]
        private function get heros():ArrayCollection
        {
            return (this._99168185heros);
        }

        [Bindable(event="propertyChange")]
        public function get input_stone():ResourceInput
        {
            return (this._36713392input_stone);
        }

        [Bindable(event="propertyChange")]
        public function get input_food():ResourceInput
        {
            return (this._1386265523input_food);
        }

        private function set reachTime(_arg_1:String):void
        {
            var _local_2:Object = this._1134711072reachTime;
            if (_local_2 !== _arg_1)
            {
                this._1134711072reachTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reachTime", _local_2, _arg_1));
            };
        }

        public function __useFlag_change(_arg_1:Event):void
        {
            useFlagChange();
        }

        [Bindable(event="propertyChange")]
        public function get input_archer():TroopInput
        {
            return (this._620580248input_archer);
        }

        public function set input_carriage(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1098902761input_carriage;
            if (_local_2 !== _arg_1)
            {
                this._1098902761input_carriage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_carriage", _local_2, _arg_1));
            };
        }

        private function onGetCoordinate(_arg_1:WindowChangeEvent):void
        {
            var _local_2:Coordinate;
            if (_arg_1.getId() == NewArmyWin.EVENT_COORDINATE)
            {
                if (_arg_1.getEventData() != null)
                {
                    _local_2 = (_arg_1.getEventData() as Coordinate);
                    this.newArmyData.x = _local_2.x;
                    this.newArmyData.y = _local_2.y;
                };
            };
            targetChange();
        }

        public function set input_lightCavalry(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1369421801input_lightCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1369421801input_lightCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_lightCavalry", _local_2, _arg_1));
            };
        }

        private function carryResouce(_arg_1:int):void
        {
            this.leftSpace = ((this.loads - this.needFood) - this.resourceGross());
        }

        public function set input_catapult(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1140689133input_catapult;
            if (_local_2 !== _arg_1)
            {
                this._1140689133input_catapult = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_catapult", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input_lightCavalry():TroopInput
        {
            return (this._1369421801input_lightCavalry);
        }

        private function set castle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._1367558920castle;
            if (_local_2 !== _arg_1)
            {
                this._1367558920castle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castle", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input_swordsmen():TroopInput
        {
            return (this._2127717941input_swordsmen);
        }

        public function set input_swordsmen(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._2127717941input_swordsmen;
            if (_local_2 !== _arg_1)
            {
                this._2127717941input_swordsmen = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_swordsmen", _local_2, _arg_1));
            };
        }

        override public function destroy():void
        {
        }


    }
}//package view.module.trainningField

