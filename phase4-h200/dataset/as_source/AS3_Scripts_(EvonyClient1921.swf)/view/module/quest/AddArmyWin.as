// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.AddArmyWin

package view.module.quest
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.trainningField.ResourceInput;
    import view.module.trainningField.TroopInput;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import com.evony.common.beans.CastleResourceBean;
    import mx.controls.Text;
    import view.ui.NumberInput;
    import mx.controls.CheckBox;
    import mx.controls.ComboBox;
    import com.evony.common.beans.ResourceInfoBean;
    import com.evony.common.beans.CastleBean;
    import mx.binding.utils.ChangeWatcher;
    import com.evony.common.beans.TroopBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.containers.Tile;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import com.evony.common.constants.ObjConstants;
    import com.evony.data.NewArmyEventData;
    import com.evony.common.beans.HeroBean;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.events.ListEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import mx.binding.Binding;
    import com.evony.common.constants.TFConstants;
    import com.evony.Context;
    import com.evony.common.constants.HeroConstants;
    import com.evony.common.paramBeans.NewArmyParam;
    import com.evony.common.beans.ResourceBean;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
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

    public class AddArmyWin extends Canvas implements IBindingClient 
    {

        private static var recSize:int = 60000;
        public static const EVENT_SHOW:String = "NewArmy.open";
        public static const EVENT_COORDINATE:String = "coordinate";
        public static var stance:AddArmyWin = new (AddArmyWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1386265523input_food:ResourceInput;
        private var _1386771970input_wood:ResourceInput;
        private var _2127717941input_swordsmen:TroopInput;
        private var _620580248input_archer:TroopInput;
        private var loadSkillParam:int;
        private var _1119728796troopMinBtn:Button;
        private var _613351659mimuteInput:TextInput;
        private var loads:int = 0;
        private var portableFood:int = 0;
        private var _865670275needTime:int;
        private var _802491405maxTroopLimit:int;
        private var _2059551634input_pikemen:TroopInput;
        private var _1219601176input_heavyCavalry:TroopInput;
        private var _979992646hourInput:TextInput;
        public var _AddArmyWin_Label10:Label;
        private var encampTime:Number = 0;
        private var _341064690resource:CastleResourceBean;
        public var _AddArmyWin_Text1:Text;
        public var _AddArmyWin_Text2:Text;
        public var _AddArmyWin_Text3:Text;
        public var _AddArmyWin_Text4:Text;
        public var _AddArmyWin_Text6:Text;
        private var _1140689133input_catapult:TroopInput;
        private var _865259028needFood:int;
        public var _AddArmyWin_Text5:Text;
        private var _426045858input_militia:TroopInput;
        private var _1730759999leftSpace:int;
        private var _1954847043input_x:NumberInput;
        private var _148431469useFlag:CheckBox;
        private var _779951690troopAmount:int = 0;
        private var _1134711072reachTime:String;
        private var _1049650600input_peasants:TroopInput;
        private var _2108485791heroSelCom:ComboBox;
        private var _243631393disCount:Number;
        private var _1707425309input_batteringRam:TroopInput;
        private var _2095366482needTimeStr:String;
        private var troopTypeAry:Array;
        private var _1386357789input_iron:ResourceInput;
        private var transportSpeedAdd:Boolean = false;
        private var _2116085169missionTypeSelectedIndex:int = 0;
        private var _1081154686maxNum:int;
        private var marchSkillParam:int;
        private var _378942766foodBean:ResourceInfoBean;
        private var _826047651troopCanAdd:int = 0;
        private var _1112638538troopMaxBtn:Button;
        public var _AddArmyWin_ComboBox1:ComboBox;
        public var _AddArmyWin_Label2:Label;
        private var transportStationParam:int;
        public var _AddArmyWin_Label5:Label;
        public var _AddArmyWin_Label6:Label;
        public var _AddArmyWin_Label7:Label;
        public var _AddArmyWin_Label8:Label;
        public var _AddArmyWin_Label9:Label;
        private var _1369421801input_lightCavalry:TroopInput;
        private var _435361974input_scouter:TroopInput;
        private var _1367558920castle:CastleBean;
        private var questId:int;
        private var _1954847044input_y:NumberInput;
        private var _36713392input_stone:ResourceInput;
        private var watcher:ChangeWatcher;
        public var _AddArmyWin_Button1:Button;
        public var _AddArmyWin_Button2:Button;
        private var _865287327troops:TroopBean;
        private var troopAmountAry:Array;
        private var _821205909input_ballista:TroopInput;
        private var _1718011141leftFood:Number;
        private var _1386295221input_gold:ResourceInput;
        private var _1098902761input_carriage:TroopInput;
        private var addArmy:Boolean = false;
        private var troopObjAry:Array;
        private var driveSkillParam:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":819,
                    "height":495,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"Dispatch Armed Forces",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
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
                                                "id":"_AddArmyWin_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "styleName":"commonNormalColor",
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
                                                        "editable":false
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
                                                        "editable":false
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AddArmyWin_Button1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.right = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":95
                                        });
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
                                                "id":"_AddArmyWin_Label5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "35";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "styleName":"commonNormalColor",
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ComboBox,
                                                "id":"_AddArmyWin_ComboBox1",
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
                                                "id":"_AddArmyWin_Label6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "70";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "styleName":"commonNormalColor",
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
                                        return ({
                                            "enabled":false,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_AddArmyWin_Label7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "105";
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":10,
                                                        "width":80
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"hourInput",
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
                                                "id":"_AddArmyWin_Label8",
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
                                                "id":"_AddArmyWin_Label9",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "240";
                                                    this.top = "105";
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
                                                    return ({
                                                        "leftSource":0,
                                                        "resourceType":"food",
                                                        "enabled":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_wood",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "leftSource":0,
                                                        "resourceType":"wood",
                                                        "enabled":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_stone",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "leftSource":0,
                                                        "resourceType":"stone",
                                                        "enabled":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_iron",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "leftSource":0,
                                                        "resourceType":"iron",
                                                        "enabled":false
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":ResourceInput,
                                                "id":"input_gold",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "leftSource":0,
                                                        "resourceType":"gold",
                                                        "enabled":false
                                                    });
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
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AddArmyWin_Button2",
                                    "events":{"click":"___AddArmyWin_Button2_click"},
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
                            this.top = "43";
                            this.bottom = "110";
                            this.left = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":384,
                                "styleName":"textBackground",
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
                                                            "id":"_AddArmyWin_Label10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.fontWeight = "bold";
                                                                this.left = "5";
                                                                this.top = "2";
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
                                                                return ({
                                                                    "styleName":"b95",
                                                                    "width":95
                                                                });
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
                                                                return ({
                                                                    "styleName":"b95",
                                                                    "width":95
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":CheckBox,
                                                            "id":"useFlag",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.top = "28";
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
                                                "type":MyHRule,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":98});
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
                                                            "id":"input_peasants",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_militia",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_scouter",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_pikemen",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_swordsmen",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_archer",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_lightCavalry",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_heavyCavalry",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_carriage",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_ballista",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_batteringRam",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TroopInput,
                                                            "id":"input_catapult",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"maxLimit":100000000});
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
                                    "id":"_AddArmyWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
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
                                                "id":"_AddArmyWin_Text2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"selectable":false});
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
                                                "id":"_AddArmyWin_Text3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
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
                                "height":60,
                                "styleName":"textBackground",
                                "width":384,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_AddArmyWin_Text4",
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
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
                                                "id":"_AddArmyWin_Text5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"selectable":false});
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
                                                "id":"_AddArmyWin_Text6",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                    this.fontWeight = "bold";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"selectable":false});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":33,
                                "y":458,
                                "text":"Current troops dispatch limit: "
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AddArmyWin_Button5_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _991165677missionTypeArray:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("协助反殖民"),
            "data":ObjConstants.ARMY_MISSION_ANTI_COLONIAL
        }]);
        private var _99168185heros:ArrayCollection = new ArrayCollection();
        private var _158692185newArmyData:NewArmyEventData = new NewArmyEventData();
        private var selectedHero:HeroBean = getEmptyHeroBean();
        private var costObj:Object = new Object();
        private var loadObj:Object = new Object();
        private var speedObj:Object = new Object();
        private var speedAry:Array = new Array();
        private var myTimer:Timer = new Timer(1000, 0);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AddArmyWin()
        {
            mx_internal::_document = this;
            this.width = 819;
            this.height = 495;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AddArmyWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AddArmyWin._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null, _arg_2:String="0", _arg_3:String="0", _arg_4:Boolean=false):void
        {
            PopUpManager.addPopUp(stance, MainFrame.instance, true);
            PopUpManager.centerPopUp(stance);
            stance.questId = (_arg_1 as int);
            stance.input_x.text = _arg_2;
            stance.input_y.text = _arg_3;
            stance.addArmy = _arg_4;
            stance.refresh();
        }


        public function ___AddArmyWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
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

        [Bindable(event="propertyChange")]
        private function get maxTroopLimit():int
        {
            return (this._802491405maxTroopLimit);
        }

        [Bindable(event="propertyChange")]
        private function get resource():CastleResourceBean
        {
            return (this._341064690resource);
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

        [Bindable(event="propertyChange")]
        private function get needFood():int
        {
            return (this._865259028needFood);
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
        public function get input_batteringRam():TroopInput
        {
            return (this._1707425309input_batteringRam);
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

        [Bindable(event="propertyChange")]
        public function get input_iron():ResourceInput
        {
            return (this._1386357789input_iron);
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

        public function set input_heavyCavalry(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1219601176input_heavyCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1219601176input_heavyCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_heavyCavalry", _local_2, _arg_1));
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

        public function __troopMinBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get hourInput():TextInput
        {
            return (this._979992646hourInput);
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
        public function get input_ballista():TroopInput
        {
            return (this._821205909input_ballista);
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

        [Bindable(event="propertyChange")]
        public function get troopMaxBtn():Button
        {
            return (this._1112638538troopMaxBtn);
        }

        private function sentTroopsResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("派军成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
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

        [Bindable(event="propertyChange")]
        private function get needTime():int
        {
            return (this._865670275needTime);
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

        public function set input_y(_arg_1:NumberInput):void
        {
            var _local_2:Object = this._1954847044input_y;
            if (_local_2 !== _arg_1)
            {
                this._1954847044input_y = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_y", _local_2, _arg_1));
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
        private function get troopAmount():int
        {
            return (this._779951690troopAmount);
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

        [Bindable(event="propertyChange")]
        public function get troopMinBtn():Button
        {
            return (this._1119728796troopMinBtn);
        }

        [Bindable(event="propertyChange")]
        private function get troopCanAdd():int
        {
            return (this._826047651troopCanAdd);
        }

        [Bindable(event="propertyChange")]
        private function get newArmyData():NewArmyEventData
        {
            return (this._158692185newArmyData);
        }

        private function _AddArmyWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("目标") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label2.text = _arg_1;
            }, "_AddArmyWin_Label2.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("收藏列表");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Button1.label = _arg_1;
            }, "_AddArmyWin_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("出征任务") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label5.text = _arg_1;
            }, "_AddArmyWin_Label5.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (missionTypeArray);
            }, function (_arg_1:Object):void
            {
                _AddArmyWin_ComboBox1.dataProvider = _arg_1;
            }, "_AddArmyWin_ComboBox1.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.missionTypeSelectedIndex);
            }, function (_arg_1:int):void
            {
                _AddArmyWin_ComboBox1.selectedIndex = _arg_1;
            }, "_AddArmyWin_ComboBox1.selectedIndex");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("英雄") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label6.text = _arg_1;
            }, "_AddArmyWin_Label6.text");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heros);
            }, function (_arg_1:Object):void
            {
                heroSelCom.dataProvider = _arg_1;
            }, "heroSelCom.dataProvider");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("宿营时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label7.text = _arg_1;
            }, "_AddArmyWin_Label7.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("小时");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label8.text = _arg_1;
            }, "_AddArmyWin_Label8.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("分钟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label9.text = _arg_1;
            }, "_AddArmyWin_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.food.amount);
            }, function (_arg_1:Number):void
            {
                input_food.limit = _arg_1;
            }, "input_food.limit");
            result[10] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.wood.amount);
            }, function (_arg_1:Number):void
            {
                input_wood.limit = _arg_1;
            }, "input_wood.limit");
            result[11] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.stone.amount);
            }, function (_arg_1:Number):void
            {
                input_stone.limit = _arg_1;
            }, "input_stone.limit");
            result[12] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.iron.amount);
            }, function (_arg_1:Number):void
            {
                input_iron.limit = _arg_1;
            }, "input_iron.limit");
            result[13] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.resource.gold);
            }, function (_arg_1:Number):void
            {
                input_gold.limit = _arg_1;
            }, "input_gold.limit");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Button2.label = _arg_1;
            }, "_AddArmyWin_Button2.label");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Label10.text = _arg_1;
            }, "_AddArmyWin_Label10.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("清空");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                troopMinBtn.label = _arg_1;
            }, "troopMinBtn.label");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("最大");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                troopMaxBtn.label = _arg_1;
            }, "troopMaxBtn.label");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择军旗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                useFlag.label = _arg_1;
            }, "useFlag.label");
            result[19] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PEASANTS);
            }, function (_arg_1:int):void
            {
                input_peasants.troopType = _arg_1;
            }, "input_peasants.troopType");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.peasants);
            }, function (_arg_1:int):void
            {
                input_peasants.limit = _arg_1;
            }, "input_peasants.limit");
            result[21] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_peasants.distance = _arg_1;
            }, "input_peasants.distance");
            result[22] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_MILITIA);
            }, function (_arg_1:int):void
            {
                input_militia.troopType = _arg_1;
            }, "input_militia.troopType");
            result[23] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.militia);
            }, function (_arg_1:int):void
            {
                input_militia.limit = _arg_1;
            }, "input_militia.limit");
            result[24] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_militia.distance = _arg_1;
            }, "input_militia.distance");
            result[25] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SCOUTER);
            }, function (_arg_1:int):void
            {
                input_scouter.troopType = _arg_1;
            }, "input_scouter.troopType");
            result[26] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.scouter);
            }, function (_arg_1:int):void
            {
                input_scouter.limit = _arg_1;
            }, "input_scouter.limit");
            result[27] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_scouter.distance = _arg_1;
            }, "input_scouter.distance");
            result[28] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PIKEMAN);
            }, function (_arg_1:int):void
            {
                input_pikemen.troopType = _arg_1;
            }, "input_pikemen.troopType");
            result[29] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.pikemen);
            }, function (_arg_1:int):void
            {
                input_pikemen.limit = _arg_1;
            }, "input_pikemen.limit");
            result[30] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_pikemen.distance = _arg_1;
            }, "input_pikemen.distance");
            result[31] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SWORDSMEN);
            }, function (_arg_1:int):void
            {
                input_swordsmen.troopType = _arg_1;
            }, "input_swordsmen.troopType");
            result[32] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.swordsmen);
            }, function (_arg_1:int):void
            {
                input_swordsmen.limit = _arg_1;
            }, "input_swordsmen.limit");
            result[33] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_swordsmen.distance = _arg_1;
            }, "input_swordsmen.distance");
            result[34] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_ARCHER);
            }, function (_arg_1:int):void
            {
                input_archer.troopType = _arg_1;
            }, "input_archer.troopType");
            result[35] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.archer);
            }, function (_arg_1:int):void
            {
                input_archer.limit = _arg_1;
            }, "input_archer.limit");
            result[36] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_archer.distance = _arg_1;
            }, "input_archer.distance");
            result[37] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_LIGHTCAVALRY);
            }, function (_arg_1:int):void
            {
                input_lightCavalry.troopType = _arg_1;
            }, "input_lightCavalry.troopType");
            result[38] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.lightCavalry);
            }, function (_arg_1:int):void
            {
                input_lightCavalry.limit = _arg_1;
            }, "input_lightCavalry.limit");
            result[39] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_lightCavalry.distance = _arg_1;
            }, "input_lightCavalry.distance");
            result[40] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_HEAVYCAVALRY);
            }, function (_arg_1:int):void
            {
                input_heavyCavalry.troopType = _arg_1;
            }, "input_heavyCavalry.troopType");
            result[41] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.heavyCavalry);
            }, function (_arg_1:int):void
            {
                input_heavyCavalry.limit = _arg_1;
            }, "input_heavyCavalry.limit");
            result[42] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_heavyCavalry.distance = _arg_1;
            }, "input_heavyCavalry.distance");
            result[43] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CARRIAGE);
            }, function (_arg_1:int):void
            {
                input_carriage.troopType = _arg_1;
            }, "input_carriage.troopType");
            result[44] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.carriage);
            }, function (_arg_1:int):void
            {
                input_carriage.limit = _arg_1;
            }, "input_carriage.limit");
            result[45] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_carriage.distance = _arg_1;
            }, "input_carriage.distance");
            result[46] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BALLISTA);
            }, function (_arg_1:int):void
            {
                input_ballista.troopType = _arg_1;
            }, "input_ballista.troopType");
            result[47] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.ballista);
            }, function (_arg_1:int):void
            {
                input_ballista.limit = _arg_1;
            }, "input_ballista.limit");
            result[48] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_ballista.distance = _arg_1;
            }, "input_ballista.distance");
            result[49] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BATTERINGRAM);
            }, function (_arg_1:int):void
            {
                input_batteringRam.troopType = _arg_1;
            }, "input_batteringRam.troopType");
            result[50] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.batteringRam);
            }, function (_arg_1:int):void
            {
                input_batteringRam.limit = _arg_1;
            }, "input_batteringRam.limit");
            result[51] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_batteringRam.distance = _arg_1;
            }, "input_batteringRam.distance");
            result[52] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CATAPULT);
            }, function (_arg_1:int):void
            {
                input_catapult.troopType = _arg_1;
            }, "input_catapult.troopType");
            result[53] = binding;
            binding = new Binding(this, function ():int
            {
                return (troops.catapult);
            }, function (_arg_1:int):void
            {
                input_catapult.limit = _arg_1;
            }, "input_catapult.limit");
            result[54] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.disCount);
            }, function (_arg_1:Number):void
            {
                input_catapult.distance = _arg_1;
            }, "input_catapult.distance");
            result[55] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("估计出征时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text1.text = _arg_1;
            }, "_AddArmyWin_Text1.text");
            result[56] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("单程时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text2.text = _arg_1;
            }, "_AddArmyWin_Text2.text");
            result[57] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("到达时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text3.text = _arg_1;
            }, "_AddArmyWin_Text3.text");
            result[58] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出征要求及负重");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text4.text = _arg_1;
            }, "_AddArmyWin_Text4.text");
            result[59] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("出征耗粮") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text5.text = _arg_1;
            }, "_AddArmyWin_Text5.text");
            result[60] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所剩负载") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddArmyWin_Text6.text = _arg_1;
            }, "_AddArmyWin_Text6.text");
            result[61] = binding;
            return (result);
        }

        private function heroSelected(_arg_1:ListEvent):void
        {
            this.selectedHero = (ComboBox(_arg_1.target).selectedItem as HeroBean);
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

        [Bindable(event="propertyChange")]
        public function get input_scouter():TroopInput
        {
            return (this._435361974input_scouter);
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

        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1.target.id == "troopMaxBtn")
            {
                _local_2 = 0;
                while (_local_2 < this.troopObjAry.length)
                {
                    this.troopObjAry[_local_2].currentValue = int(this.troopAmountAry[_local_2]);
                    this.troopObjAry[_local_2].txtInput.text = String(this.troopAmountAry[_local_2]);
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
                        _local_3++;
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get needTimeStr():String
        {
            return (this._2095366482needTimeStr);
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

        private function refresh():void
        {
            var _local_1:HeroBean;
            this.castle = Context.getInstance().getCurCastle();
            this.resource = castle.resource;
            this.troops = castle.troop;
            troopObjAry = [this.input_peasants.numInput, this.input_militia.numInput, this.input_scouter.numInput, this.input_pikemen.numInput, this.input_swordsmen.numInput, this.input_archer.numInput, this.input_carriage.numInput, this.input_lightCavalry.numInput, this.input_heavyCavalry.numInput, this.input_ballista.numInput, this.input_batteringRam.numInput, this.input_catapult.numInput];
            troopAmountAry = [this.troops.peasants, this.troops.militia, this.troops.scouter, this.troops.pikemen, this.troops.swordsmen, this.troops.archer, this.troops.carriage, this.troops.lightCavalry, this.troops.heavyCavalry, this.troops.ballista, this.troops.batteringRam, this.troops.catapult];
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
            this.numInit();
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
        private function get reachTime():String
        {
            return (this._1134711072reachTime);
        }

        [Bindable(event="propertyChange")]
        public function get input_carriage():TroopInput
        {
            return (this._1098902761input_carriage);
        }

        [Bindable(event="propertyChange")]
        public function get input_catapult():TroopInput
        {
            return (this._1140689133input_catapult);
        }

        [Bindable(event="propertyChange")]
        private function get castle():CastleBean
        {
            return (this._1367558920castle);
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

        private function set needTime(_arg_1:int):void
        {
            var _local_2:Object = this._865670275needTime;
            if (_local_2 !== _arg_1)
            {
                this._865670275needTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needTime", _local_2, _arg_1));
            };
        }

        public function init():void
        {
            stance = this;
        }

        [Bindable(event="propertyChange")]
        private function get leftFood():Number
        {
            return (this._1718011141leftFood);
        }

        [Bindable(event="propertyChange")]
        public function get input_heavyCavalry():TroopInput
        {
            return (this._1219601176input_heavyCavalry);
        }

        private function sentTroops():void
        {
            var _local_1:NewArmyParam = new NewArmyParam();
            _local_1.resource = new ResourceBean();
            _local_1.troops = new TroopBean();
            _local_1.resource.wood = 0;
            _local_1.resource.food = 0;
            _local_1.resource.iron = 0;
            _local_1.resource.gold = 0;
            _local_1.resource.stone = 0;
            _local_1.troops.peasants = this.input_peasants.numInput.currentValue;
            _local_1.troops.militia = this.input_militia.numInput.currentValue;
            _local_1.troops.scouter = this.input_scouter.numInput.currentValue;
            _local_1.troops.pikemen = this.input_pikemen.numInput.currentValue;
            _local_1.troops.swordsmen = this.input_swordsmen.numInput.currentValue;
            _local_1.troops.archer = this.input_archer.numInput.currentValue;
            _local_1.troops.carriage = this.input_carriage.numInput.currentValue;
            _local_1.troops.lightCavalry = this.input_lightCavalry.numInput.currentValue;
            _local_1.troops.heavyCavalry = this.input_heavyCavalry.numInput.currentValue;
            _local_1.troops.ballista = this.input_ballista.numInput.currentValue;
            _local_1.troops.batteringRam = this.input_batteringRam.numInput.currentValue;
            _local_1.troops.catapult = this.input_catapult.numInput.currentValue;
            _local_1.missionType = ObjConstants.ARMY_MISSION_ANTI_COLONIAL;
            _local_1.restTime = 0;
            _local_1.useFlag = false;
            var _local_2:int = int(this.input_x.text);
            var _local_3:int = int(this.input_y.text);
            _local_1.targetPoint = ((_local_3 * Context.mapSizeY) + _local_2);
            if (!addArmy)
            {
                if (this.selectedHero != null)
                {
                    _local_1.heroId = this.selectedHero.id;
                };
                ActionFactory.getInstance().getCommissionQuestCommands().acceptCommissionQuest(this.castle.id, this.questId, _local_1, sentTroopsResponse);
            }
            else
            {
                _local_1.heroId = -1;
                ActionFactory.getInstance().getCommissionQuestCommands().addCommissionQuestArmy(this.castle.id, this.questId, _local_1, sentTroopsResponse);
            };
        }

        [Bindable(event="propertyChange")]
        private function get disCount():Number
        {
            return (this._243631393disCount);
        }

        [Bindable(event="propertyChange")]
        public function get mimuteInput():TextInput
        {
            return (this._613351659mimuteInput);
        }

        [Bindable(event="propertyChange")]
        private function get missionTypeArray():ArrayCollection
        {
            return (this._991165677missionTypeArray);
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

        public function set input_peasants(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1049650600input_peasants;
            if (_local_2 !== _arg_1)
            {
                this._1049650600input_peasants = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_peasants", _local_2, _arg_1));
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

        private function onClose():void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get input_y():NumberInput
        {
            return (this._1954847044input_y);
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

        public function set input_food(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1386265523input_food;
            if (_local_2 !== _arg_1)
            {
                this._1386265523input_food = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_food", _local_2, _arg_1));
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

        override public function initialize():void
        {
            var target:AddArmyWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AddArmyWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_AddArmyWinWatcherSetupUtil");
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
        public function get useFlag():CheckBox
        {
            return (this._148431469useFlag);
        }

        [Bindable(event="propertyChange")]
        public function get input_archer():TroopInput
        {
            return (this._620580248input_archer);
        }

        [Bindable(event="propertyChange")]
        public function get input_peasants():TroopInput
        {
            return (this._1049650600input_peasants);
        }

        public function ___AddArmyWin_Button5_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        private function get missionTypeSelectedIndex():int
        {
            return (this._2116085169missionTypeSelectedIndex);
        }

        [Bindable(event="propertyChange")]
        public function get input_food():ResourceInput
        {
            return (this._1386265523input_food);
        }

        [Bindable(event="propertyChange")]
        public function get input_gold():ResourceInput
        {
            return (this._1386295221input_gold);
        }

        private function numInit():void
        {
            var _local_1:int;
            while (_local_1 < this.troopObjAry.length)
            {
                troopObjAry[_local_1].refresh();
                _local_1++;
            };
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

        private function _AddArmyWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (Lang.msg("目标") + ": ");
            _local_1 = Lang.msg("收藏列表");
            _local_1 = (Lang.msg("出征任务") + ": ");
            _local_1 = missionTypeArray;
            _local_1 = this.missionTypeSelectedIndex;
            _local_1 = (Lang.msg("英雄") + ": ");
            _local_1 = this.heros;
            _local_1 = (Lang.msg("宿营时间") + ": ");
            _local_1 = Lang.msg("小时");
            _local_1 = Lang.msg("分钟");
            _local_1 = this.resource.food.amount;
            _local_1 = this.resource.wood.amount;
            _local_1 = this.resource.stone.amount;
            _local_1 = this.resource.iron.amount;
            _local_1 = this.resource.gold;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("选择军队");
            _local_1 = Lang.msg("清空");
            _local_1 = Lang.msg("最大");
            _local_1 = Lang.msg("选择军旗");
            _local_1 = TFConstants.T_PEASANTS;
            _local_1 = troops.peasants;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_MILITIA;
            _local_1 = troops.militia;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_SCOUTER;
            _local_1 = troops.scouter;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_PIKEMAN;
            _local_1 = troops.pikemen;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_SWORDSMEN;
            _local_1 = troops.swordsmen;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_ARCHER;
            _local_1 = troops.archer;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_LIGHTCAVALRY;
            _local_1 = troops.lightCavalry;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_HEAVYCAVALRY;
            _local_1 = troops.heavyCavalry;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_CARRIAGE;
            _local_1 = troops.carriage;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_BALLISTA;
            _local_1 = troops.ballista;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_BATTERINGRAM;
            _local_1 = troops.batteringRam;
            _local_1 = this.disCount;
            _local_1 = TFConstants.T_CATAPULT;
            _local_1 = troops.catapult;
            _local_1 = this.disCount;
            _local_1 = Lang.msg("估计出征时间");
            _local_1 = (Lang.msg("单程时间") + ": ");
            _local_1 = (Lang.msg("到达时间") + ": ");
            _local_1 = Lang.msg("出征要求及负重");
            _local_1 = (Lang.msg("出征耗粮") + ": ");
            _local_1 = (Lang.msg("所剩负载") + ": ");
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

        [Bindable(event="propertyChange")]
        public function get input_swordsmen():TroopInput
        {
            return (this._2127717941input_swordsmen);
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

        public function set input_lightCavalry(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._1369421801input_lightCavalry;
            if (_local_2 !== _arg_1)
            {
                this._1369421801input_lightCavalry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input_lightCavalry", _local_2, _arg_1));
            };
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

        public function ___AddArmyWin_Button2_click(_arg_1:MouseEvent):void
        {
            sentTroops();
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


    }
}//package view.module.quest

