// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.newarmy.NewArmyWin

package autoevony.gui.newarmy
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.ClassFactory;
    import com.evony.common.beans.HeroBean;
    import com.evony.common.beans.ResourceBean;
    import mx.controls.TextInput;
    import mx.controls.ComboBox;
    import mx.controls.CheckBox;
    import com.evony.common.beans.TroopBean;
    import mx.controls.Label;
    import flash.utils.Timer;
    import mx.controls.Text;
    import mx.collections.ArrayCollection;
    import autoevony.gui.RowColorDataGrid;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Image;
    import com.evony.common.constants.ObjConstants;
    import mx.core.mx_internal;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.popUpWinShowEvent;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.paramBeans.NewArmyParam;
    import autoevony.player.Map;
    import autoevony.common.Utils;
    import autoevony.common.CityStateCommands;
    import mx.binding.BindingManager;
    import com.evony.common.server.events.HeroUpdate;
    import mx.events.ListEvent;
    import autoevony.gui.MainScreen;
    import flash.events.KeyboardEvent;
    import com.evony.common.beans.ItemBean;
    import com.evony.common.server.events.ItemUpdate;
    import com.evony.common.server.events.SelfArmysUpdate;
    import com.evony.client.response.ResponseDispatcher;
    import flash.net.SharedObject;
    import flash.events.TimerEvent;
    import flash.ui.Keyboard;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.common.server.events.ResourceUpdate;
    import com.evony.common.constants.HeroConstants;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.client.action.ActionFactory;
    import autoevony.scripts.CityState;
    import com.evony.common.constants.FieldConstants;
    import mx.events.FlexEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import flash.net.SharedObjectFlushStatus;
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

    public class NewArmyWin extends Canvas implements IBindingClient 
    {

        private static var newArmyViewCfg:Array = [{
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }, {
            "target":0,
            "quickTarget":-1,
            "mission":1,
            "hero":-1,
            "heroTypes":{
                "HH":true,
                "LH":true,
                "Pol":true,
                "Atk":true,
                "Int":true
            },
            "campTime":{
                "hour":0,
                "min":0,
                "sec":0,
                "ms":0
            },
            "campType":0
        }];
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _282413427_tInputWo:TroopInput;
        private var _129437214_tInputS:TroopInput;
        private var _129437218_tInputW:TroopInput;
        private var _1645570160_rInputG:ResourceInput;
        private var _1898746486_deployBtn:Button;
        private var _129437196_tInputA:TroopInput;
        private var castleId:int;
        private var _876583532availableRallySlots:int = 0;
        public var _NewArmyWin_ClassFactory1:ClassFactory;
        public var _NewArmyWin_ClassFactory2:ClassFactory;
        private var _1754828491selectedHero:HeroBean = null;
        private var ctyInd:int;
        private var _341064690resource:ResourceBean = null;
        private var _816969280_tInputCata:TroopInput;
        private var _861252683fieldId:int = 0;
        private var _77820867_inputCampTimeHr:TextInput;
        private var closeFunc:Function = null;
        public var _NewArmyWin_Button4:Button;
        private var _1948436464_yInput:TextInput;
        private var _1702837304_inputTroopCfgName:TextInput;
        private var _129437213_tInputR:TroopInput;
        private var _1043134288_selectQuickCoords:ComboBox;
        private var _77821023_inputCampTimeMs:TextInput;
        private var _564559437foodNeeded:Number = 0;
        private var _1805325788_showHH:CheckBox;
        private var seenArmies:Array = null;
        private var selectedTroop:TroopBean = null;
        private var _130526835_showInt:CheckBox;
        public var _NewArmyWin_Label10:Label;
        public var _NewArmyWin_Label11:Label;
        public var _NewArmyWin_Label12:Label;
        public var _NewArmyWin_Label13:Label;
        public var _NewArmyWin_Label14:Label;
        public var _NewArmyWin_Label15:Label;
        public var _NewArmyWin_Label16:Label;
        public var _NewArmyWin_Label17:Label;
        public var _NewArmyWin_Label18:Label;
        private var _1805325912_showLH:CheckBox;
        private var _181090216_applyStygandrsBannerOfTheHorde:CheckBox;
        private var _1706017285_availRallySlots:Label;
        private var _1882515783_inputCampTimeMin:TextInput;
        private var _282413543_tInputSw:TroopInput;
        public var _NewArmyWin_Label32:Label;
        public var _NewArmyWin_Label33:Label;
        public var _NewArmyWin_Label34:Label;
        public var _NewArmyWin_Label35:Label;
        public var _NewArmyWin_Label36:Label;
        public var _NewArmyWin_Label37:Label;
        public var _NewArmyWin_Label39:Label;
        private var armiesUpdateTimer:Timer = null;
        public var _NewArmyWin_Text1:Text;
        private var _1645570148_rInputS:ResourceInput;
        private var _681912583travelTime:Number = 0;
        private var _1645570144_rInputW:ResourceInput;
        public var _NewArmyWin_Label41:Label;
        public var _NewArmyWin_Label43:Label;
        public var _NewArmyWin_Label45:Label;
        private var _252657020_applyStygandrsBannerOfTheHordeLabel:Label;
        private var isFirstMarch:Boolean = true;
        public var _NewArmyWin_Label2:Label;
        private var _1483390883maxDispatchLimit:int = 0;
        public var _NewArmyWin_Label7:Label;
        public var _NewArmyWin_Label8:Label;
        public var _NewArmyWin_Label9:Label;
        private var _1592359477_selectMissionType:ComboBox;
        private var _129437198_tInputC:TroopInput;
        private var waitingForArmyResponse:Boolean = false;
        private var _1215952832loadCapacity:Number = 0;
        private var _110634834troop:TroopBean = null;
        private var _2075147496_selectTroopCfgName:ComboBox;
        private var _1684939609savedTroopCfg:ArrayCollection = null;
        private var _1239375627_applyWarEnsignLabel:Label;
        private var _1882510152_inputCampTimeSec:TextInput;
        private var _1919807313_xInput:TextInput;
        private var _1999462250_selectCampType:ComboBox;
        private var _568004427_selectHero:ComboBox;
        private var emptyHero:HeroBean = null;
        private var _282414046_tInputCp:TroopInput;
        private var _129437211_tInputP:TroopInput;
        private var _129437215_tInputT:TroopInput;
        private var _1645570158_rInputI:ResourceInput;
        private var _1645570161_rInputF:ResourceInput;
        private var _129437197_tInputB:TroopInput;
        public var _NewArmyWin_RowColorDataGrid1:RowColorDataGrid;
        private var _130533585_showPol:CheckBox;
        private var _1244701377_applyWarEnsign:CheckBox;
        private var _25601152camptTime:Number = 0;
        private var _130519324_showAtk:CheckBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":780,
                    "height":535,
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
                            return ({"windowTitle":"New Army"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"_NewArmyWin_Text1",
                        "stylesFactory":function ():void
                        {
                            this.left = "16";
                            this.top = "12";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":244,
                                "height":22,
                                "styleName":"newArmyTroop"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.top = "45";
                            this.bottom = "15";
                            this.right = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":410,
                                            "height":337,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.right = "3";
                                                    this.top = "3";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 3;
                                                    this.verticalGap = 3;
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
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":26,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Dispatch limit:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label2",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_applyWarEnsignLabel",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Apply War Ensign",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to apply War Ensign to increase army size by 25%"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_applyWarEnsign",
                                                                        "events":{"change":"___applyWarEnsign_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":false,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to apply War Ensign to increase army size by 25%"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":6});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":24,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Available Rally Slots:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_availRallySlots",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_applyStygandrsBannerOfTheHordeLabel",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Apply Stygandr's Banner",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to apply Stygandr's Banner of the Horde to increase army size by 10x"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_applyStygandrsBannerOfTheHorde",
                                                                        "events":{"change":"___applyStygandrsBannerOfTheHorde_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":false,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to apply Stygandr's Banner of the Horde to increase army size by 10x"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":6});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
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
                                                                    "percentWidth":100,
                                                                    "height":30,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":15});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___NewArmyWin_Button1_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.fontSize = 10;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Clear",
                                                                                "height":19,
                                                                                "focusEnabled":false,
                                                                                "styleName":"REwinBtn"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"percentWidth":100});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154,
                                                                                "toolTip":"Workers"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputWo"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label7",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154,
                                                                                "toolTip":"Warriors"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputW"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label8",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398,
                                                                                "toolTip":"Scouts"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputS"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label9",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496,
                                                                                "toolTip":"Pikemen"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputP"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label10",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794,
                                                                                "toolTip":"Swordsmen"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputSw"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label11",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722,
                                                                                "toolTip":"Archers"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputA"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label12",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226,
                                                                                "toolTip":"Cavalry"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputC"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label13",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280,
                                                                                "toolTip":"Cataphract"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputCata"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label14",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488,
                                                                                "toolTip":"Transporters"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputT"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label15",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212,
                                                                                "toolTip":"Ballista"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputB"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label16",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924,
                                                                                "toolTip":"Battering Rams"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputR"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label17",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940,
                                                                                "toolTip":"Catapults"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TroopInput,
                                                                        "id":"_tInputCp"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label18",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":91,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"height":4});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":36,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"_inputTroopCfgName",
                                                                        "events":{"change":"___inputTroopCfgName_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":200,
                                                                                "height":22,
                                                                                "text":"",
                                                                                "maxChars":20,
                                                                                "restrict":"a-z,A-Z,0-9",
                                                                                "styleName":"textInput"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___NewArmyWin_Button2_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Save Preset",
                                                                                "focusEnabled":false,
                                                                                "styleName":"REwinBtn"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":40,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"_selectTroopCfgName",
                                                                        "events":{"change":"___selectTroopCfgName_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":200,
                                                                                "height":22,
                                                                                "styleName":"ComboBox"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___NewArmyWin_Button3_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"Delete Preset",
                                                                                "focusEnabled":false,
                                                                                "styleName":"REwinCancelBtn"
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
                                        this.left = "413";
                                        this.right = "0";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":164,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.right = "3";
                                                    this.top = "3";
                                                    this.bottom = "3";
                                                    this.horizontalGap = 3;
                                                    this.verticalGap = 2;
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
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":30,
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
                                                                                "width":78,
                                                                                "text":"Target:",
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
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":5});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"_selectQuickCoords",
                                                                        "events":{"change":"___selectQuickCoords_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
                                                                                "height":22,
                                                                                "styleName":"ComboBox"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":30,
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
                                                                                "width":78,
                                                                                "text":"Mission:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"_selectMissionType",
                                                                        "events":{"change":"___selectMissionType_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":170,
                                                                                "height":22,
                                                                                "styleName":"ComboBox"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 5;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":30,
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
                                                                                "width":78,
                                                                                "text":"Hero:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"_selectHero",
                                                                        "events":{"change":"___selectHero_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":240,
                                                                                "height":22,
                                                                                "styleName":"ComboBox"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.horizontalAlign = "center";
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":30,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_NewArmyWin_Button4",
                                                                        "events":{"click":"___NewArmyWin_Button4_click"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.fontSize = 10;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "label":"View",
                                                                                "height":19,
                                                                                "focusEnabled":false,
                                                                                "includeInLayout":true,
                                                                                "styleName":"REwinBtn"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":15});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "events":{"click":"___NewArmyWin_Label22_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"HH",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to show Historic Heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showHH",
                                                                        "events":{"change":"___showHH_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":true,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to show Historic Heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":8});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "events":{"click":"___NewArmyWin_Label23_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"LH",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to show Legendary Heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showLH",
                                                                        "events":{"change":"___showLH_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":true,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to show Legendary Heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":8});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "events":{"click":"___NewArmyWin_Label24_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Pol",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to show Politic type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showPol",
                                                                        "events":{"change":"___showPol_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":true,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to show Politic type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":8});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "events":{"click":"___NewArmyWin_Label25_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Atk",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to show Attack type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showAtk",
                                                                        "events":{"change":"___showAtk_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":true,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to show Attack type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":8});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "events":{"click":"___NewArmyWin_Label26_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Int",
                                                                                "styleName":"newArmyTroop",
                                                                                "toolTip":"Mark to show Intel type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showInt",
                                                                        "events":{"change":"___showInt_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "selected":true,
                                                                                "styleName":"REcheckBox",
                                                                                "toolTip":"Mark to show Intel type heroes in the selection list"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":30,
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
                                                                                "width":78,
                                                                                "text":"Camp Time:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":5});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"_inputCampTimeHr",
                                                                        "events":{"change":"___inputCampTimeHr_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":30,
                                                                                "height":22,
                                                                                "text":"0",
                                                                                "maxChars":2,
                                                                                "restrict":"0-9",
                                                                                "styleName":"textInput"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.fontSize = 14;
                                                                            this.paddingLeft = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":8,
                                                                                "text":":",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"_inputCampTimeMin",
                                                                        "events":{"change":"___inputCampTimeMin_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":30,
                                                                                "height":22,
                                                                                "text":"0",
                                                                                "maxChars":2,
                                                                                "restrict":"0-9",
                                                                                "styleName":"textInput"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.fontSize = 14;
                                                                            this.paddingLeft = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":8,
                                                                                "text":":",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"_inputCampTimeSec",
                                                                        "events":{"change":"___inputCampTimeSec_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":30,
                                                                                "height":22,
                                                                                "text":"0",
                                                                                "maxChars":2,
                                                                                "restrict":"0-9",
                                                                                "styleName":"textInput"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                            this.fontSize = 14;
                                                                            this.paddingLeft = 0;
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":8,
                                                                                "text":".",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":TextInput,
                                                                        "id":"_inputCampTimeMs",
                                                                        "events":{"change":"___inputCampTimeMs_change"},
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "center";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":30,
                                                                                "height":22,
                                                                                "text":"0",
                                                                                "maxChars":2,
                                                                                "restrict":"0-9",
                                                                                "styleName":"textInput"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"width":5});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ComboBox,
                                                                        "id":"_selectCampType",
                                                                        "events":{"change":"___selectCampType_change"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":90,
                                                                                "height":22,
                                                                                "styleName":"ComboBox"
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
                                        this.left = "413";
                                        this.right = "0";
                                        this.top = "167";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":170,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.right = "3";
                                                    this.top = "3";
                                                    this.bottom = "3";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalGap = 3;
                                                    this.verticalGap = 3;
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
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":25,
                                                                    "horizontalScrollPolicy":"off",
                                                                    "verticalScrollPolicy":"off",
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Load capacity:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label32",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ResourceInput,
                                                                        "id":"_rInputF"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label33",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ResourceInput,
                                                                        "id":"_rInputW"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label34",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ResourceInput,
                                                                        "id":"_rInputS"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label35",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ResourceInput,
                                                                        "id":"_rInputI"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label36",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
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
                                                                        "type":Image,
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":23,
                                                                                "height":23,
                                                                                "source":_embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":ResourceInput,
                                                                        "id":"_rInputG"
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label37",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":130,
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
                                        this.left = "0";
                                        this.top = "340";
                                        this.bottom = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":532,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":RowColorDataGrid,
                                                "id":"_NewArmyWin_RowColorDataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.headerStyleName = "columnHeaderSyle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REdataGrid",
                                                        "allowDragSelection":false,
                                                        "allowMultipleSelection":false,
                                                        "doubleClickEnabled":false,
                                                        "dragEnabled":false,
                                                        "draggableColumns":false,
                                                        "editable":false,
                                                        "enabled":true,
                                                        "horizontalScrollPolicy":"off",
                                                        "minHeight":50,
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":23,
                                                        "variableRowHeight":true,
                                                        "selectable":false,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "columns":[_NewArmyWin_DataGridColumn1_c(), _NewArmyWin_DataGridColumn2_c(), _NewArmyWin_DataGridColumn3_c(), _NewArmyWin_DataGridColumn4_c(), _NewArmyWin_DataGridColumn5_c()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "535";
                                        this.right = "0";
                                        this.top = "340";
                                        this.bottom = "33";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "3";
                                                    this.right = "3";
                                                    this.top = "3";
                                                    this.bottom = "3";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalGap = 3;
                                                    this.verticalGap = 3;
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
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":20,
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
                                                                                "width":100,
                                                                                "text":"Distance:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label39",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":20,
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
                                                                                "width":100,
                                                                                "text":"Required food:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label41",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":20,
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
                                                                                "width":100,
                                                                                "text":"One-way time:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label43",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 3;
                                                                this.verticalAlign = "middle";
                                                                this.paddingLeft = 0;
                                                                this.paddingRight = 0;
                                                                this.paddingTop = 0;
                                                                this.paddingBottom = 0;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "height":20,
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
                                                                                "width":100,
                                                                                "text":"Arrival time:",
                                                                                "styleName":"newArmyTroop"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_NewArmyWin_Label45",
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"newArmyTroop"});
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
                                        this.left = "535";
                                        this.right = "0";
                                        this.bottom = "0";
                                        this.horizontalGap = 5;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                        this.paddingLeft = 0;
                                        this.paddingRight = 0;
                                        this.paddingTop = 0;
                                        this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":30,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":125});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_deployBtn",
                                                "events":{"click":"___deployBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Deploy",
                                                        "focusEnabled":false,
                                                        "enabled":true,
                                                        "styleName":"REwinBtn"
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
                        "events":{"click":"___NewArmyWin_Button6_click"},
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
        private var _991165677missionTypeArray:ArrayCollection = new ArrayCollection([{
            "label":"Transport",
            "data":ObjConstants.ARMY_MISSION_TRANS
        }, {
            "label":"Reinforce",
            "data":ObjConstants.ARMY_MISSION_SEND
        }, {
            "label":"Scout",
            "data":ObjConstants.ARMY_MISSION_SCOUT
        }, {
            "label":"Attack",
            "data":ObjConstants.ARMY_MISSION_OCCUPY
        }, {
            "label":"Colonize",
            "data":ObjConstants.ARMY_MISSION_COLONIZE
        }]);
        private var _99168185heros:ArrayCollection = new ArrayCollection();
        private var _2087571216localArmiesData:ArrayCollection = new ArrayCollection();
        private var _276213653quickCoords:ArrayCollection = new ArrayCollection([{
            "label":"none",
            "data":-1
        }]);
        private var _embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098;
        private var _embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896;
        private var _embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212;
        private var _embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056;
        private var _embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048;
        private var _embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722;
        private var _embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212;
        private var _embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226;
        private var _embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280;
        private var _embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940;
        private var _embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496;
        private var _embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924;
        private var _embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398;
        private var _embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794;
        private var _embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488;
        private var _embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154;
        private var _embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NewArmyWin()
        {
            mx_internal::_document = this;
            this.width = 780;
            this.height = 535;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", this.___NewArmyWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NewArmyWin._watcherSetupUtil = _arg_1;
        }


        private function onMarchResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
                this.updateResourceInfo();
                return;
            };
        }

        private function updateTroop():void
        {
            this.troop = this.selectedCity.cityManager.troop;
        }

        [Bindable(event="propertyChange")]
        private function get resource():ResourceBean
        {
            return (this._341064690resource);
        }

        public function set _tInputA(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437196_tInputA;
            if (_local_2 !== _arg_1)
            {
                this._129437196_tInputA = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputA", _local_2, _arg_1));
            };
        }

        public function set _tInputB(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437197_tInputB;
            if (_local_2 !== _arg_1)
            {
                this._129437197_tInputB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputB", _local_2, _arg_1));
            };
        }

        public function set _tInputC(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437198_tInputC;
            if (_local_2 !== _arg_1)
            {
                this._129437198_tInputC = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputC", _local_2, _arg_1));
            };
        }

        public function ___inputTroopCfgName_change(_arg_1:Event):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get _tInputCp():TroopInput
        {
            return (this._282414046_tInputCp);
        }

        private function set resource(_arg_1:ResourceBean):void
        {
            var _local_2:Object = this._341064690resource;
            if (_local_2 !== _arg_1)
            {
                this._341064690resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _local_2, _arg_1));
            };
        }

        public function set _tInputP(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437211_tInputP;
            if (_local_2 !== _arg_1)
            {
                this._129437211_tInputP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputP", _local_2, _arg_1));
            };
        }

        public function set _tInputSw(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._282413543_tInputSw;
            if (_local_2 !== _arg_1)
            {
                this._282413543_tInputSw = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputSw", _local_2, _arg_1));
            };
        }

        public function set _tInputR(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437213_tInputR;
            if (_local_2 !== _arg_1)
            {
                this._129437213_tInputR = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputR", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_Label22_click(_arg_1:MouseEvent):void
        {
            this._showHH.selected = (!(this._showHH.selected));
            this.onChangeHeroFilter();
        }

        public function set _tInputS(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437214_tInputS;
            if (_local_2 !== _arg_1)
            {
                this._129437214_tInputS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputS", _local_2, _arg_1));
            };
        }

        public function ___xInput_change(_arg_1:Event):void
        {
            this.onCoordChange((_arg_1.currentTarget as TextInput));
        }

        public function set _tInputCp(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._282414046_tInputCp;
            if (_local_2 !== _arg_1)
            {
                this._282414046_tInputCp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputCp", _local_2, _arg_1));
            };
        }

        public function set _tInputT(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437215_tInputT;
            if (_local_2 !== _arg_1)
            {
                this._129437215_tInputT = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputT", _local_2, _arg_1));
            };
        }

        public function ___showAtk_change(_arg_1:Event):void
        {
            this.onChangeHeroFilter();
        }

        private function updateTroopInfo():void
        {
            this.updateTroop();
            this.selectedTroop.peasants = int(this._tInputWo.tInput.text);
            this.selectedTroop.militia = int(this._tInputW.tInput.text);
            this.selectedTroop.scouter = int(this._tInputS.tInput.text);
            this.selectedTroop.pikemen = int(this._tInputP.tInput.text);
            this.selectedTroop.swordsmen = int(this._tInputSw.tInput.text);
            this.selectedTroop.archer = int(this._tInputA.tInput.text);
            this.selectedTroop.lightCavalry = int(this._tInputC.tInput.text);
            this.selectedTroop.heavyCavalry = int(this._tInputCata.tInput.text);
            this.selectedTroop.carriage = int(this._tInputT.tInput.text);
            this.selectedTroop.ballista = int(this._tInputB.tInput.text);
            this.selectedTroop.batteringRam = int(this._tInputR.tInput.text);
            this.selectedTroop.catapult = int(this._tInputCp.tInput.text);
            this.updateLoadCapacity();
        }

        public function set _tInputW(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._129437218_tInputW;
            if (_local_2 !== _arg_1)
            {
                this._129437218_tInputW = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputW", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get maxDispatchLimit():int
        {
            return (this._1483390883maxDispatchLimit);
        }

        [Bindable(event="propertyChange")]
        private function get quickCoords():ArrayCollection
        {
            return (this._276213653quickCoords);
        }

        [Bindable(event="propertyChange")]
        public function get _inputCampTimeMs():TextInput
        {
            return (this._77821023_inputCampTimeMs);
        }

        [Bindable(event="propertyChange")]
        public function get _applyStygandrsBannerOfTheHorde():CheckBox
        {
            return (this._181090216_applyStygandrsBannerOfTheHorde);
        }

        private function doMarch():String
        {
            var _local_1:ArmyBean;
            var _local_2:NewArmyParam;
            var _local_3:Number;
            if (Map.coordStringToFieldId(((this._xInput.text + ",") + this._yInput.text)) == this.fieldId)
            {
                return ("Destination is the current castle!");
            };
            if (this.loadCapacity < ((((Number(this._rInputG.rInput.text) + Number(this._rInputF.rInput.text)) + Number(this._rInputW.rInput.text)) + Number(this._rInputS.rInput.text)) + Number(this._rInputI.rInput.text)))
            {
                return ("Total selected resources exceeds the selected army's carry limit!");
            };
            if (this.maxDispatchLimit < Utils.getTotalTroopCount(this.selectedTroop))
            {
                return ("Selected troop count exceeds maximum army size!");
            };
            this.updateAvailableRallySlots();
            if (this.availableRallySlots < 1)
            {
                return ("No available rally slots!");
            };
            this.seenArmies = new Array();
            for each (_local_1 in this.selectedCity.cityManager.localArmies)
            {
                this.seenArmies.push(_local_1.armyId);
            };
            _local_2 = this.getNewArmy();
            _local_3 = this.selectedCity.cityManager.getCampTimeChangeBuffsFactor();
            this.updateCamptTime();
            if (int((int(this.camptTime) * _local_3)) > ((24 * 60) * 60))
            {
                return (("Camp time exceeds server limit at " + Utils.formatTime((int(this.camptTime) * _local_3))) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]");
            };
            _local_2.restTime = int(this.camptTime);
            CityStateCommands.newArmy(this.castleId, _local_2, this.onMarchResponse);
            this.resource.gold = (this.resource.gold - _local_2.resource.gold);
            this.resource.food = (this.resource.food - (_local_2.resource.food + this.foodNeeded));
            this.resource.wood = (this.resource.wood - _local_2.resource.wood);
            this.resource.stone = (this.resource.stone - _local_2.resource.stone);
            this.resource.iron = (this.resource.iron - _local_2.resource.iron);
            return (null);
        }

        private function onChangeCampTime(_arg_1:TextInput):void
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
                    _local_2 = ((_arg_1.id == "inputCampTimeHr") ? 23 : ((_arg_1.id == "inputCampTimeMs") ? 99 : 59));
                    if (int(_arg_1.text) > _local_2)
                    {
                        _arg_1.text = ("" + _local_2);
                    };
                };
            };
            this.updateTravelTime();
        }

        private function _NewArmyWin_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._NewArmyWin_ClassFactory2 = _local_1;
            BindingManager.executeBindings(this, "_NewArmyWin_ClassFactory2", this._NewArmyWin_ClassFactory2);
            return (_local_1);
        }

        private function updateSelectedhero():void
        {
            if ((((this.heros.length > 0) && (!(this._selectHero.selectedItem == null))) && (!(this._selectHero.selectedItem.heroBean == null))))
            {
                this.selectedHero = (this._selectHero.selectedItem.heroBean as HeroBean);
            }
            else
            {
                this.selectedHero = null;
            };
            this.updateTravelTime();
        }

        [Bindable(event="propertyChange")]
        public function get _selectCampType():ComboBox
        {
            return (this._1999462250_selectCampType);
        }

        private function onHeroUpdate(_arg_1:HeroUpdate):void
        {
            if (_arg_1.castleId == this.castleId)
            {
                Utils.callLater(100, this.setFreeHeros);
            };
        }

        [Bindable(event="propertyChange")]
        public function get _selectHero():ComboBox
        {
            return (this._568004427_selectHero);
        }

        private function updateCamptTime():void
        {
            this.camptTime = this.selectedCity._parseRestTime((((((((((this._selectCampType.selectedIndex == 0) ? "" : "@") + this._inputCampTimeHr.text) + ":") + this._inputCampTimeMin.text) + ":") + this._inputCampTimeSec.text) + ".") + this._inputCampTimeMs.text), this.travelTime);
        }

        [Bindable(event="propertyChange")]
        public function get _inputCampTimeSec():TextInput
        {
            return (this._1882510152_inputCampTimeSec);
        }

        private function set maxDispatchLimit(_arg_1:int):void
        {
            var _local_2:Object = this._1483390883maxDispatchLimit;
            if (_local_2 !== _arg_1)
            {
                this._1483390883maxDispatchLimit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxDispatchLimit", _local_2, _arg_1));
            };
        }

        public function ___selectMissionType_change(_arg_1:ListEvent):void
        {
            this.onChangeMissionType();
        }

        private function _NewArmyWin_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._NewArmyWin_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_NewArmyWin_ClassFactory1", this._NewArmyWin_ClassFactory1);
            return (_local_1);
        }

        public function set _inputCampTimeMs(_arg_1:TextInput):void
        {
            var _local_2:Object = this._77821023_inputCampTimeMs;
            if (_local_2 !== _arg_1)
            {
                this._77821023_inputCampTimeMs = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputCampTimeMs", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_Button4_click(_arg_1:MouseEvent):void
        {
            MainScreen.getInstance()._cityPanel._onViewHeroBtn(this.selectedHero.id);
        }

        public function set _applyStygandrsBannerOfTheHorde(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._181090216_applyStygandrsBannerOfTheHorde;
            if (_local_2 !== _arg_1)
            {
                this._181090216_applyStygandrsBannerOfTheHorde = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_applyStygandrsBannerOfTheHorde", _local_2, _arg_1));
            };
        }

        public function ___xInput_keyDown(_arg_1:KeyboardEvent):void
        {
            this.keyDownHandle(_arg_1);
        }

        private function onDeployBtn():void
        {
            this._deployBtn.enabled = false;
            var msg:String = this.doMarch();
            if (msg != null)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, msg));
                this._deployBtn.enabled = true;
                return;
            };
            Utils.callLater(this.selectedCity.lag, function ():void
            {
                _deployBtn.enabled = true;
            });
        }

        [Bindable(event="propertyChange")]
        public function get _showPol():CheckBox
        {
            return (this._130533585_showPol);
        }

        public function set _showLH(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1805325912_showLH;
            if (_local_2 !== _arg_1)
            {
                this._1805325912_showLH = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showLH", _local_2, _arg_1));
            };
        }

        private function postTroopChange():void
        {
            this.updateTroopInfo();
            this.updateMaxDispatchLimit();
            this.updateResourceInfo();
            this.updateTravelTime();
        }

        private function set quickCoords(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._276213653quickCoords;
            if (_local_2 !== _arg_1)
            {
                this._276213653quickCoords = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "quickCoords", _local_2, _arg_1));
            };
        }

        public function set _showInt(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._130526835_showInt;
            if (_local_2 !== _arg_1)
            {
                this._130526835_showInt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showInt", _local_2, _arg_1));
            };
        }

        private function restoreMissionInfo():void
        {
            var _local_1:int;
            this._xInput.text = ("" + Map.getX(newArmyViewCfg[this.ctyInd].target));
            this._yInput.text = ("" + Map.getY(newArmyViewCfg[this.ctyInd].target));
            if (newArmyViewCfg[this.ctyInd].quickTarget != 1)
            {
                _local_1 = 0;
                while (_local_1 < this.quickCoords.length)
                {
                    if (this.quickCoords[_local_1].data == newArmyViewCfg[this.ctyInd].quickTarget)
                    {
                        this._selectQuickCoords.selectedIndex = _local_1;
                        this.onQuickCoordsChange();
                        break;
                    };
                    _local_1++;
                };
            };
            if (newArmyViewCfg[this.ctyInd].mission != 1)
            {
                _local_1 = 0;
                while (_local_1 < this.missionTypeArray.length)
                {
                    if (this.missionTypeArray[_local_1].data == newArmyViewCfg[this.ctyInd].mission)
                    {
                        this._selectMissionType.selectedIndex = _local_1;
                        this.onChangeMissionType();
                        break;
                    };
                    _local_1++;
                };
            };
            this._showHH.selected = newArmyViewCfg[this.ctyInd].heroTypes.HH;
            this._showLH.selected = newArmyViewCfg[this.ctyInd].heroTypes.LH;
            this._showPol.selected = newArmyViewCfg[this.ctyInd].heroTypes.Pol;
            this._showAtk.selected = newArmyViewCfg[this.ctyInd].heroTypes.Atk;
            this._showInt.selected = newArmyViewCfg[this.ctyInd].heroTypes.Int;
            this.onChangeHeroFilter();
            if (newArmyViewCfg[this.ctyInd].hero != -1)
            {
                _local_1 = 0;
                while (_local_1 < this.heros.length)
                {
                    if ((this.heros[_local_1].heroBean as HeroBean).id == newArmyViewCfg[this.ctyInd].hero)
                    {
                        this._selectHero.selectedIndex = _local_1;
                        this.updateSelectedhero();
                        break;
                    };
                    _local_1++;
                };
            };
            this._inputCampTimeHr.text = ("" + newArmyViewCfg[this.ctyInd].campTime.hour);
            this._inputCampTimeMin.text = ("" + newArmyViewCfg[this.ctyInd].campTime.min);
            this._inputCampTimeSec.text = ("" + newArmyViewCfg[this.ctyInd].campTime.sec);
            this._inputCampTimeMs.text = ("" + newArmyViewCfg[this.ctyInd].campTime.ms);
            this._selectCampType.selectedIndex = newArmyViewCfg[this.ctyInd].campType;
            this.updateTravelTime();
        }

        public function set _deployBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1898746486_deployBtn;
            if (_local_2 !== _arg_1)
            {
                this._1898746486_deployBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_deployBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _applyWarEnsignLabel():Label
        {
            return (this._1239375627_applyWarEnsignLabel);
        }

        private function onChangeMissionType():void
        {
            this._showHH.selected = (((this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS) || (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND)) || (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SCOUT));
            this._showLH.selected = (((this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS) || (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND)) || (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SCOUT));
            this._showPol.selected = ((this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS) || (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND));
            this._showAtk.selected = true;
            this._showInt.selected = true;
            this.setFreeHeros();
            this.updateTravelTime();
        }

        private function onChangeCampType():void
        {
            this.updateTravelTime();
        }

        private function onItemUpdate(_arg_1:ItemUpdate=null):void
        {
            var _local_3:ItemBean;
            var _local_2:Boolean;
            for each (_local_3 in _arg_1.itemsArray)
            {
                if (((_local_3.id == "player.troop.1.a") || (_local_3.id == "player.item.stygandrsbannerofthehorde")))
                {
                    _local_2 = true;
                    break;
                };
            };
            if (_local_2)
            {
                Utils.callLater(150, this.updateEnableApplyWarEnsignAndBanner);
            };
        }

        public function ___inputCampTimeSec_change(_arg_1:Event):void
        {
            this.onChangeCampTime((_arg_1.currentTarget as TextInput));
        }

        [Bindable(event="propertyChange")]
        private function get travelTime():Number
        {
            return (this._681912583travelTime);
        }

        private function onSelfArmiesUpdate(update:SelfArmysUpdate=null):void
        {
            Utils.callLater(100, function ():void
            {
                updateAvailableRallySlots();
                updateTroop();
                updateLocalArmiesData();
            });
        }

        private function init():void
        {
            MainScreen.getInstance()._cityPanel.setMarchWin(this);
            this.ctyInd = MainScreen.getInstance().getSelectedCityIndex();
            this.fieldId = MainScreen.getInstance().getSelectedCity().castle.fieldId;
            this.castleId = MainScreen.getInstance().getSelectedCity().castleId;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.onSelfArmiesUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, this.onResourceUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, this.onHeroUpdate);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            this.emptyHero = new HeroBean();
            this.emptyHero.name = " - - ";
            this.emptyHero.id = -1;
            this.selectedTroop = new TroopBean();
            this.updateTroopInfo();
            this.updateEnableApplyWarEnsignAndBanner();
            this.updateAvailableRallySlots();
            this.updateResourceInfo();
            this.updateLoadCapacity();
            this.setQuickCoords();
            this.setFreeHeros();
            var _local_1:SharedObject = SharedObject.getLocal("newArmyTroopCfgs");
            this.savedTroopCfg = new ArrayCollection((_local_1.data.now as Array));
            if (((this.savedTroopCfg == null) || (this.savedTroopCfg.length == 0)))
            {
                this.savedTroopCfg = new ArrayCollection([{
                    "label":"none",
                    "troopCfg":"wo:0"
                }]);
            };
            this.restoreMissionInfo();
            this.armiesUpdateTimer = new Timer(2000);
            this.armiesUpdateTimer.addEventListener(TimerEvent.TIMER, this.updateLocalArmiesData);
            this.armiesUpdateTimer.start();
            Utils.callLater(50, this.updateLocalArmiesData);
        }

        public function updateInfo(_arg_1:Function=null):void
        {
            this.closeFunc = _arg_1;
        }

        public function set _tInputWo(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._282413427_tInputWo;
            if (_local_2 !== _arg_1)
            {
                this._282413427_tInputWo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputWo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _showAtk():CheckBox
        {
            return (this._130519324_showAtk);
        }

        internal function onMaxBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + this.getMax(_arg_1));
            _arg_1.setFocus();
            this.moveCursorToEnd(_arg_1);
            if (_arg_1.id == "tInput")
            {
                this.postTroopChange();
            };
        }

        private function keyDownHandle(_arg_1:KeyboardEvent):void
        {
            if ((((_arg_1.keyCode == Keyboard.NUMPAD_DECIMAL) || (_arg_1.keyCode == Keyboard.PERIOD)) || (_arg_1.keyCode == Keyboard.COMMA)))
            {
                this._yInput.setFocus();
            };
        }

        public function set _selectCampType(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1999462250_selectCampType;
            if (_local_2 !== _arg_1)
            {
                this._1999462250_selectCampType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectCampType", _local_2, _arg_1));
            };
        }

        private function getArrivalTime(_arg_1:Number):String
        {
            return (Utils.getLogTimeStr(((new Date().getTime() - 700) + (_arg_1 * 1000))));
        }

        [Bindable(event="propertyChange")]
        private function get selectedHero():HeroBean
        {
            return (this._1754828491selectedHero);
        }

        [Bindable(event="propertyChange")]
        public function get _applyWarEnsign():CheckBox
        {
            return (this._1244701377_applyWarEnsign);
        }

        public function ___NewArmyWin_Label26_click(_arg_1:MouseEvent):void
        {
            this._showInt.selected = (!(this._showInt.selected));
            this.onChangeHeroFilter();
        }

        private function updateResourceInfo():void
        {
            if (this.resource == null)
            {
                this.resource = new ResourceBean();
            };
            var _local_1:CastleResourceBean = this.selectedCity.cityManager.resource;
            this.resource.gold = _local_1.gold;
            this.resource.food = _local_1.food.amount;
            this.resource.wood = _local_1.wood.amount;
            this.resource.stone = _local_1.stone.amount;
            this.resource.iron = _local_1.iron.amount;
            _local_1 = null;
        }

        public function ___applyStygandrsBannerOfTheHorde_change(_arg_1:Event):void
        {
            this.updateMaxDispatchLimit();
        }

        internal function onMinBtn(_arg_1:TextInput):void
        {
            _arg_1.text = ("" + 0);
            _arg_1.setFocus();
            if (_arg_1.id == "tInput")
            {
                this.postTroopChange();
            };
        }

        public function set _selectHero(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._568004427_selectHero;
            if (_local_2 !== _arg_1)
            {
                this._568004427_selectHero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectHero", _local_2, _arg_1));
            };
        }

        public function set _inputCampTimeSec(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1882510152_inputCampTimeSec;
            if (_local_2 !== _arg_1)
            {
                this._1882510152_inputCampTimeSec = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputCampTimeSec", _local_2, _arg_1));
            };
        }

        public function set _inputCampTimeMin(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1882515783_inputCampTimeMin;
            if (_local_2 !== _arg_1)
            {
                this._1882515783_inputCampTimeMin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputCampTimeMin", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_Button3_click(_arg_1:MouseEvent):void
        {
            this.onDeleteTroopCfg();
        }

        [Bindable(event="propertyChange")]
        public function get _applyStygandrsBannerOfTheHordeLabel():Label
        {
            return (this._252657020_applyStygandrsBannerOfTheHordeLabel);
        }

        [Bindable(event="propertyChange")]
        private function get availableRallySlots():int
        {
            return (this._876583532availableRallySlots);
        }

        public function set _showPol(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._130533585_showPol;
            if (_local_2 !== _arg_1)
            {
                this._130533585_showPol = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showPol", _local_2, _arg_1));
            };
        }

        private function getCityIdInfo(_arg_1:int):String
        {
            var _local_2:String = MainScreen.getCityFromFieldId(_arg_1).castle.name;
            return (((_local_2.length > 15) ? _local_2.substr(0, 16) : _local_2) + Map.fieldIdToCoordString(_arg_1));
        }

        internal function onViewArmyBtn(_arg_1:Object):void
        {
            MainScreen.getInstance()._cityPanel._onViewArmyBtn(this.castleId, _arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputCata():TroopInput
        {
            return (this._816969280_tInputCata);
        }

        [Bindable(event="propertyChange")]
        public function get _selectMissionType():ComboBox
        {
            return (this._1592359477_selectMissionType);
        }

        [Bindable(event="propertyChange")]
        private function get foodNeeded():Number
        {
            return (this._564559437foodNeeded);
        }

        [Bindable(event="propertyChange")]
        public function get _showHH():CheckBox
        {
            return (this._1805325788_showHH);
        }

        public function set _applyWarEnsignLabel(_arg_1:Label):void
        {
            var _local_2:Object = this._1239375627_applyWarEnsignLabel;
            if (_local_2 !== _arg_1)
            {
                this._1239375627_applyWarEnsignLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_applyWarEnsignLabel", _local_2, _arg_1));
            };
        }

        private function close():void
        {
            this.armiesUpdateTimer.stop();
            this.armiesUpdateTimer.removeEventListener(TimerEvent.TIMER, this.updateLocalArmiesData);
            this.armiesUpdateTimer = null;
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE, this.onSelfArmiesUpdate);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE, this.onResourceUpdate);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE, this.onHeroUpdate);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE, this.onItemUpdate);
            this.saveMissionInfo();
            this.troop = null;
            this.selectedTroop = null;
            this.resource = null;
            this.localArmiesData.removeAll();
            this.localArmiesData = null;
            this.quickCoords.removeAll();
            this.quickCoords = null;
            this.heros.removeAll();
            this.heros = null;
            this.selectedHero = null;
            this.emptyHero = null;
            this.savedTroopCfg.removeAll();
            this.savedTroopCfg = null;
            this.seenArmies = null;
            MainScreen.getInstance()._cityPanel.onMarchWinClosed(this.castleId);
            this.closeFunc.apply(null, [this]);
        }

        [Bindable(event="propertyChange")]
        public function get _availRallySlots():Label
        {
            return (this._1706017285_availRallySlots);
        }

        public function ___NewArmyWin_Label25_click(_arg_1:MouseEvent):void
        {
            this._showAtk.selected = (!(this._showAtk.selected));
            this.onChangeHeroFilter();
        }

        private function updateAvailableRallySlots():void
        {
            this.availableRallySlots = (this.selectedCity.cityManager.getMaxRallySlots() - this.selectedCity.cityManager.getUsedRallySlots());
        }

        [Bindable(event="propertyChange")]
        public function get _tInputA():TroopInput
        {
            return (this._129437196_tInputA);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputC():TroopInput
        {
            return (this._129437198_tInputC);
        }

        private function set travelTime(_arg_1:Number):void
        {
            var _local_2:Object = this._681912583travelTime;
            if (_local_2 !== _arg_1)
            {
                this._681912583travelTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "travelTime", _local_2, _arg_1));
            };
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
        public function get _tInputP():TroopInput
        {
            return (this._129437211_tInputP);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputR():TroopInput
        {
            return (this._129437213_tInputR);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputS():TroopInput
        {
            return (this._129437214_tInputS);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputT():TroopInput
        {
            return (this._129437215_tInputT);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputSw():TroopInput
        {
            return (this._282413543_tInputSw);
        }

        [Bindable(event="propertyChange")]
        public function get _tInputB():TroopInput
        {
            return (this._129437197_tInputB);
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

        private function set localArmiesData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2087571216localArmiesData;
            if (_local_2 !== _arg_1)
            {
                this._2087571216localArmiesData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "localArmiesData", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _tInputW():TroopInput
        {
            return (this._129437218_tInputW);
        }

        private function getMax(_arg_1:TextInput):Number
        {
            var _local_2:int;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            if (_arg_1.id == "tInput")
            {
                _local_2 = 0;
                _local_3 = 0;
                if (_arg_1 != this._tInputWo.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputWo.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.peasants;
                };
                if (_arg_1 != this._tInputW.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputW.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.militia;
                };
                if (_arg_1 != this._tInputS.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputS.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.scouter;
                };
                if (_arg_1 != this._tInputP.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputP.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.pikemen;
                };
                if (_arg_1 != this._tInputSw.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputSw.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.swordsmen;
                };
                if (_arg_1 != this._tInputA.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputA.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.archer;
                };
                if (_arg_1 != this._tInputC.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputC.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.lightCavalry;
                };
                if (_arg_1 != this._tInputCata.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputCata.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.heavyCavalry;
                };
                if (_arg_1 != this._tInputT.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputT.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.carriage;
                };
                if (_arg_1 != this._tInputB.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputB.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.ballista;
                };
                if (_arg_1 != this._tInputR.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputR.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.batteringRam;
                };
                if (_arg_1 != this._tInputCp.tInput)
                {
                    _local_2 = (_local_2 + int(this._tInputCp.tInput.text));
                }
                else
                {
                    _local_3 = this.troop.catapult;
                };
                return (Math.floor(Math.min(((_local_3 < 0) ? (_local_3 * -1) : _local_3), (this.maxDispatchLimit - _local_2))));
            };
            if (_arg_1.id == "rInput")
            {
                _local_4 = 0;
                _local_5 = 0;
                if (_arg_1 != this._rInputG.rInput)
                {
                    _local_4 = (_local_4 + ((Number(this._rInputG.rInput.text) > 0) ? Number(this._rInputG.rInput.text) : 0));
                }
                else
                {
                    _local_5 = this.resource.gold;
                };
                if (_arg_1 != this._rInputF.rInput)
                {
                    _local_4 = (_local_4 + ((Number(this._rInputF.rInput.text) > 0) ? Number(this._rInputF.rInput.text) : 0));
                }
                else
                {
                    _local_5 = (this.resource.food - (this.foodNeeded + (this.foodNeeded * 1.15)));
                };
                if (_arg_1 != this._rInputW.rInput)
                {
                    _local_4 = (_local_4 + ((Number(this._rInputW.rInput.text) > 0) ? Number(this._rInputW.rInput.text) : 0));
                }
                else
                {
                    _local_5 = this.resource.wood;
                };
                if (_arg_1 != this._rInputS.rInput)
                {
                    _local_4 = (_local_4 + ((Number(this._rInputS.rInput.text) > 0) ? Number(this._rInputS.rInput.text) : 0));
                }
                else
                {
                    _local_5 = this.resource.stone;
                };
                if (_arg_1 != this._rInputI.rInput)
                {
                    _local_4 = (_local_4 + ((Number(this._rInputI.rInput.text) > 0) ? Number(this._rInputI.rInput.text) : 0));
                }
                else
                {
                    _local_5 = this.resource.iron;
                };
                return (Math.floor(Math.min(_local_5, (((this.loadCapacity - _local_4) > 0) ? (this.loadCapacity - _local_4) : 0))));
            };
            return (0);
        }

        public function set _selectTroopCfgName(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2075147496_selectTroopCfgName;
            if (_local_2 !== _arg_1)
            {
                this._2075147496_selectTroopCfgName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectTroopCfgName", _local_2, _arg_1));
            };
        }

        private function onResourceUpdate(_arg_1:ResourceUpdate=null):void
        {
            if (_arg_1.castleId == this.castleId)
            {
                Utils.callLater(100, this.updateResourceInfo);
            };
        }

        private function onLoadTroopCfg():void
        {
            if (this._selectTroopCfgName.selectedItem.label == "none")
            {
                return;
            };
            var _local_1:String = this._selectTroopCfgName.selectedItem.troopCfg;
            var _local_2:TroopBean = Utils.getTroops(_local_1);
            this._tInputWo.tInput.text = ("" + _local_2.peasants);
            this._tInputW.tInput.text = ("" + _local_2.militia);
            this._tInputS.tInput.text = ("" + _local_2.scouter);
            this._tInputP.tInput.text = ("" + _local_2.pikemen);
            this._tInputSw.tInput.text = ("" + _local_2.swordsmen);
            this._tInputA.tInput.text = ("" + _local_2.archer);
            this._tInputC.tInput.text = ("" + _local_2.lightCavalry);
            this._tInputCata.tInput.text = ("" + _local_2.heavyCavalry);
            this._tInputT.tInput.text = ("" + _local_2.carriage);
            this._tInputB.tInput.text = ("" + _local_2.ballista);
            this._tInputR.tInput.text = ("" + _local_2.batteringRam);
            this._tInputCp.tInput.text = ("" + _local_2.catapult);
            this.postTroopChange();
        }

        public function set _showAtk(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._130519324_showAtk;
            if (_local_2 !== _arg_1)
            {
                this._130519324_showAtk = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showAtk", _local_2, _arg_1));
            };
        }

        private function onDeleteTroopCfg(_arg_1:Boolean=false, _arg_2:Boolean=false):void
        {
            if (this._selectTroopCfgName.selectedItem.label == "none")
            {
                return;
            };
            if (((!(_arg_1)) && (_arg_2)))
            {
                return;
            };
            if (!_arg_2)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Are you sure you want to permanently delete this saved troop configuration?", this.onDeleteTroopCfg, "Yes", "No", [true]));
                return;
            };
            this.savedTroopCfg.removeItemAt(this._selectTroopCfgName.selectedIndex);
            var _local_3:SharedObject = SharedObject.getLocal("newArmyTroopCfgs");
            _local_3.data.now = this.savedTroopCfg.toArray();
            _local_3.flush();
            this._selectTroopCfgName.selectedIndex = 0;
        }

        public function ___NewArmyWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.onSaveTroopCfg();
        }

        internal function onTroopChange(_arg_1:TextInput):void
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
                    _local_2 = this.getMax(_arg_1);
                    if (int(_arg_1.text) > _local_2)
                    {
                        _arg_1.text = ("" + _local_2);
                    };
                };
            };
            this.postTroopChange();
        }

        private function getLoadCapacity(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:String, _arg_7:String, _arg_8:String, _arg_9:String, _arg_10:String, _arg_11:String, _arg_12:String):Number
        {
            var _local_13:TroopBean = new TroopBean();
            _local_13.peasants = int(_arg_1);
            _local_13.militia = int(_arg_2);
            _local_13.scouter = int(_arg_3);
            _local_13.pikemen = int(_arg_4);
            _local_13.swordsmen = int(_arg_5);
            _local_13.archer = int(_arg_6);
            _local_13.lightCavalry = int(_arg_7);
            _local_13.heavyCavalry = int(_arg_8);
            _local_13.carriage = int(_arg_9);
            _local_13.ballista = int(_arg_10);
            _local_13.batteringRam = int(_arg_11);
            _local_13.catapult = int(_arg_12);
            return (this.loadCapacity = this.selectedCity.cityManager.getMaxTroopLoad(_local_13));
        }

        public function ___deployBtn_click(_arg_1:MouseEvent):void
        {
            this.onDeployBtn();
        }

        [Bindable(event="propertyChange")]
        public function get _showLH():CheckBox
        {
            return (this._1805325912_showLH);
        }

        public function ___selectHero_change(_arg_1:ListEvent):void
        {
            this.updateSelectedhero();
        }

        private function set selectedHero(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._1754828491selectedHero;
            if (_local_2 !== _arg_1)
            {
                this._1754828491selectedHero = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedHero", _local_2, _arg_1));
            };
        }

        private function setFreeHeros():void
        {
            var _local_3:int;
            var _local_4:int;
            var _local_7:HeroBean;
            var _local_8:int;
            var _local_9:Object;
            var _local_1:Boolean;
            var _local_2:int;
            var _local_5:* = "";
            var _local_6:int = ((this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND) ? 1 : ((this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS) ? 2 : 4));
            this.heros.removeAll();
            for each (_local_7 in this.selectedCity.cityManager.heroes)
            {
                if (!(((_local_7.stamina < _local_6) || ((!(this._showHH.selected)) && (_local_7.isHero == 1))) || ((!(this._showLH.selected)) && (_local_7.isHero == 4))))
                {
                    if (_local_7.isHero != 2)
                    {
                        _local_1 = ((_local_7.politics == _local_7.intelligence) && (_local_7.politics == _local_7.attack));
                        if (((!(this._showPol.selected)) && (((!(_local_1)) && (_local_7.politics >= Math.max(_local_7.intelligence, _local_7.attack))) || ((_local_1) && (_local_7.management >= Math.max(_local_7.stratagem, _local_7.power)))))) continue;
                        if (((!(this._showAtk.selected)) && (((!(_local_1)) && (_local_7.attack >= Math.max(_local_7.politics, _local_7.intelligence))) || ((_local_1) && (_local_7.power >= Math.max(_local_7.management, _local_7.stratagem)))))) continue;
                        if (((!(this._showInt.selected)) && (((!(_local_1)) && (_local_7.intelligence >= Math.max(_local_7.politics, _local_7.attack))) || ((_local_1) && (_local_7.stratagem >= Math.max(_local_7.management, _local_7.power)))))) continue;
                    };
                    if (_local_7.status == HeroConstants.HERO_FREE_STATU)
                    {
                        _local_5 = ((((((((_local_7.name + " (") + _local_7.level) + ") ") + Math.round(Utils.getTotalPointsForHeroAttribute(_local_7, "management"))) + "/") + Math.round((_local_3 = Utils.getTotalPointsForHeroAttribute(_local_7, "power")))) + "/") + Math.round((_local_4 = Utils.getTotalPointsForHeroAttribute(_local_7, "stratagem"))));
                        if (this.heros.length == 0)
                        {
                            this.heros.addItem({
                                "label":_local_5,
                                "heroBean":_local_7
                            });
                        }
                        else
                        {
                            if (_local_7.isHero == 2)
                            {
                                this.heros.addItemAt({
                                    "label":_local_5,
                                    "heroBean":_local_7
                                }, 0);
                            }
                            else
                            {
                                _local_2 = 0;
                                for each (_local_9 in this.heros)
                                {
                                    if (((!((_local_9.heroBean as HeroBean).isHero == 2)) && ((_local_7.level > (_local_9.heroBean as HeroBean).level) || ((_local_7.level == (_local_9.heroBean as HeroBean).level) && ((_local_3 > Utils.getTotalPointsForHeroAttribute((_local_9.heroBean as HeroBean), "power")) || ((_local_3 == Utils.getTotalPointsForHeroAttribute((_local_9.heroBean as HeroBean), "power")) && (_local_4 >= Utils.getTotalPointsForHeroAttribute((_local_9.heroBean as HeroBean), "stratagem")))))))) break;
                                    _local_2++;
                                };
                                this.heros.addItemAt({
                                    "label":_local_5,
                                    "heroBean":_local_7
                                }, _local_2);
                            };
                        };
                    };
                };
            };
            _local_8 = this._selectMissionType.selectedItem.data;
            if ((((_local_8 == ObjConstants.ARMY_MISSION_TRANS) || (_local_8 == ObjConstants.ARMY_MISSION_SEND)) || (_local_8 == ObjConstants.ARMY_MISSION_SCOUT)))
            {
                this.heros.addItemAt({
                    "label":this.emptyHero.name,
                    "heroBean":this.emptyHero
                }, 0);
            };
            if (((this.heros.length > 1) && (!(this.selectedHero == null))))
            {
                _local_2 = 0;
                for each (_local_9 in this.heros)
                {
                    if ((_local_9.heroBean as HeroBean).id == this.selectedHero.id)
                    {
                        this._selectHero.selectedIndex = _local_2;
                        return;
                    };
                    _local_2++;
                };
            };
            this._selectHero.selectedIndex = 0;
            this.updateSelectedhero();
        }

        private function _NewArmyWin_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "View";
            _local_1.dataField = "col5";
            _local_1.width = 57;
            _local_1.itemRenderer = this._NewArmyWin_ClassFactory2_i();
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get _showInt():CheckBox
        {
            return (this._130526835_showInt);
        }

        [Bindable(event="propertyChange")]
        public function get _deployBtn():Button
        {
            return (this._1898746486_deployBtn);
        }

        public function set _applyWarEnsign(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1244701377_applyWarEnsign;
            if (_local_2 !== _arg_1)
            {
                this._1244701377_applyWarEnsign = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_applyWarEnsign", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _tInputWo():TroopInput
        {
            return (this._282413427_tInputWo);
        }

        public function ___applyWarEnsign_change(_arg_1:Event):void
        {
            this.updateMaxDispatchLimit();
        }

        private function onClearTroopInputBtn():void
        {
            this._selectTroopCfgName.selectedIndex = 0;
            this._tInputWo.tInput.text = "0";
            this._tInputW.tInput.text = "0";
            this._tInputS.tInput.text = "0";
            this._tInputP.tInput.text = "0";
            this._tInputSw.tInput.text = "0";
            this._tInputA.tInput.text = "0";
            this._tInputC.tInput.text = "0";
            this._tInputCata.tInput.text = "0";
            this._tInputT.tInput.text = "0";
            this._tInputB.tInput.text = "0";
            this._tInputR.tInput.text = "0";
            this._tInputCp.tInput.text = "0";
            this.postTroopChange();
        }

        public function ___selectTroopCfgName_change(_arg_1:ListEvent):void
        {
            this.onLoadTroopCfg();
        }

        private function saveMissionInfo():void
        {
            newArmyViewCfg[this.ctyInd].target = Map.coordStringToFieldId(((this._xInput.text + ",") + this._yInput.text));
            newArmyViewCfg[this.ctyInd].quickTarget = ((this._selectQuickCoords.selectedIndex != 0) ? this._selectQuickCoords.selectedItem.data : -1);
            newArmyViewCfg[this.ctyInd].mission = this._selectMissionType.selectedItem.data;
            newArmyViewCfg[this.ctyInd].hero = ((((!(this._selectHero.selectedItem == null)) && (!(this._selectHero.selectedItem.heroBean.name == null))) && (!((this._selectHero.selectedItem.heroBean as HeroBean).name == this.emptyHero.name))) ? (this._selectHero.selectedItem.heroBean as HeroBean).id : -1);
            newArmyViewCfg[this.ctyInd].heroTypes.HH = this._showHH.selected;
            newArmyViewCfg[this.ctyInd].heroTypes.LH = this._showLH.selected;
            newArmyViewCfg[this.ctyInd].heroTypes.Pol = this._showPol.selected;
            newArmyViewCfg[this.ctyInd].heroTypes.Atk = this._showAtk.selected;
            newArmyViewCfg[this.ctyInd].heroTypes.Int = this._showInt.selected;
            newArmyViewCfg[this.ctyInd].campTime.hour = int(this._inputCampTimeHr.text);
            newArmyViewCfg[this.ctyInd].campTime.min = int(this._inputCampTimeMin.text);
            newArmyViewCfg[this.ctyInd].campTime.sec = int(this._inputCampTimeSec.text);
            newArmyViewCfg[this.ctyInd].campTime.ms = int(this._inputCampTimeMs.text);
            newArmyViewCfg[this.ctyInd].campType = this._selectCampType.selectedIndex;
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

        internal function onRecallSelfArmyBtn(_arg_1:int):void
        {
            if (_arg_1 == -1)
            {
                return;
            };
            this.selectedCity.cityManager.logMsg(("Recall self army with armyId: " + _arg_1));
            ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId, _arg_1);
        }

        private function set troop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        private function get selectedCity():CityState
        {
            return (MainScreen.getCityFromCastleId(this.castleId));
        }

        public function set _selectQuickCoords(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1043134288_selectQuickCoords;
            if (_local_2 !== _arg_1)
            {
                this._1043134288_selectQuickCoords = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectQuickCoords", _local_2, _arg_1));
            };
        }

        private function setQuickCoords():void
        {
            var _local_1:CityState;
            for each (_local_1 in MainScreen.getCities())
            {
                if (_local_1.castle.fieldId != this.fieldId)
                {
                    this.quickCoords.addItem({
                        "label":(((_local_1.castle.name.length > 3) ? _local_1.castle.name.substr(0, 3) : _local_1.castle.name) + Map.fieldIdToCoordString(_local_1.castle.fieldId)),
                        "data":_local_1.castle.fieldId
                    });
                };
            };
        }

        private function updateTravelTime():void
        {
            var _local_1:int = Map.coordStringToFieldId(((this._xInput.text + ",") + this._yInput.text));
            var _local_2:Number = this.selectedCity.cityManager.getBaseTravelTime(this.fieldId, _local_1, this.selectedTroop);
            var _local_3:int = this._selectMissionType.selectedItem.data;
            var _local_4:int = ((((!(MainScreen.getCityFromFieldId(_local_1) == null)) || ((((Map.getType(_local_1) == FieldConstants.TYPE_CASTLE) && (!(Map.getDetailInfo(_local_1, 30).allianceName == null))) && (!(this.selectedCity.player.playerInfo.alliance == null))) && (Map.getDetailInfo(_local_1, 30).allianceName == this.selectedCity.player.playerInfo.alliance))) && ((_local_3 == ObjConstants.ARMY_MISSION_SEND) || (_local_3 == ObjConstants.ARMY_MISSION_TRANS))) ? this.selectedCity._getReliefStationSpeedupFactor() : 1);
            var _local_5:Number = ((((!(this._selectHero.selectedItem == null)) && (!(this._selectHero.selectedItem.heroBean.name == null))) && (!(this._selectHero.selectedItem.heroBean.name == this.emptyHero.name))) ? Utils.getHeroSpeedFactor(this._selectHero.selectedItem.heroBean) : 1);
            this.travelTime = ((_local_2 / _local_4) / _local_5);
            this.updateCamptTime();
            this.updateFoodNeeded();
        }

        private function _NewArmyWin_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Action";
            _local_1.dataField = "col4";
            _local_1.width = 65;
            _local_1.itemRenderer = this._NewArmyWin_ClassFactory1_i();
            return (_local_1);
        }

        private function set savedTroopCfg(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1684939609savedTroopCfg;
            if (_local_2 !== _arg_1)
            {
                this._1684939609savedTroopCfg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "savedTroopCfg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _inputCampTimeMin():TextInput
        {
            return (this._1882515783_inputCampTimeMin);
        }

        public function ___yInput_change(_arg_1:Event):void
        {
            this.onCoordChange((_arg_1.currentTarget as TextInput));
        }

        public function ___NewArmyWin_Label24_click(_arg_1:MouseEvent):void
        {
            this._showPol.selected = (!(this._showPol.selected));
            this.onChangeHeroFilter();
        }

        private function _NewArmyWin_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Remain time";
            _local_1.dataField = "col3";
            _local_1.width = 90;
            return (_local_1);
        }

        public function set _applyStygandrsBannerOfTheHordeLabel(_arg_1:Label):void
        {
            var _local_2:Object = this._252657020_applyStygandrsBannerOfTheHordeLabel;
            if (_local_2 !== _arg_1)
            {
                this._252657020_applyStygandrsBannerOfTheHordeLabel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_applyStygandrsBannerOfTheHordeLabel", _local_2, _arg_1));
            };
        }

        public function ___showPol_change(_arg_1:Event):void
        {
            this.onChangeHeroFilter();
        }

        public function ___NewArmyWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function set camptTime(_arg_1:Number):void
        {
            var _local_2:Object = this._25601152camptTime;
            if (_local_2 !== _arg_1)
            {
                this._25601152camptTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "camptTime", _local_2, _arg_1));
            };
        }

        private function updateLocalArmiesData(_arg_1:Object=null):void
        {
            this.selectedCity.cityManager._populate_A_Tab(this.localArmiesData);
        }

        [Bindable(event="propertyChange")]
        private function get localArmiesData():ArrayCollection
        {
            return (this._2087571216localArmiesData);
        }

        [Bindable(event="propertyChange")]
        private function get missionTypeArray():ArrayCollection
        {
            return (this._991165677missionTypeArray);
        }

        private function _NewArmyWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.getCityIdInfo(this.fieldId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Text1.text = _arg_1;
            }, "_NewArmyWin_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Utils.formatInt(((((((((((((this.maxDispatchLimit - int(this._tInputWo.tInput.text)) - int(this._tInputW.tInput.text)) - int(this._tInputS.tInput.text)) - int(this._tInputP.tInput.text)) - int(this._tInputSw.tInput.text)) - int(this._tInputA.tInput.text)) - int(this._tInputC.tInput.text)) - int(this._tInputCata.tInput.text)) - int(this._tInputT.tInput.text)) - int(this._tInputB.tInput.text)) - int(this._tInputR.tInput.text)) - int(this._tInputCp.tInput.text))) + " / ") + Utils.formatInt(this.maxDispatchLimit));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label2.text = _arg_1;
            }, "_NewArmyWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.availableRallySlots;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _availRallySlots.text = _arg_1;
            }, "_availRallySlots.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.peasants);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label7.text = _arg_1;
            }, "_NewArmyWin_Label7.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.militia);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label8.text = _arg_1;
            }, "_NewArmyWin_Label8.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.scouter);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label9.text = _arg_1;
            }, "_NewArmyWin_Label9.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.pikemen);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label10.text = _arg_1;
            }, "_NewArmyWin_Label10.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.swordsmen);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label11.text = _arg_1;
            }, "_NewArmyWin_Label11.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.archer);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label12.text = _arg_1;
            }, "_NewArmyWin_Label12.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.lightCavalry);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label13.text = _arg_1;
            }, "_NewArmyWin_Label13.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.heavyCavalry);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label14.text = _arg_1;
            }, "_NewArmyWin_Label14.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.carriage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label15.text = _arg_1;
            }, "_NewArmyWin_Label15.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.ballista);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label16.text = _arg_1;
            }, "_NewArmyWin_Label16.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.batteringRam);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label17.text = _arg_1;
            }, "_NewArmyWin_Label17.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.troop.catapult);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label18.text = _arg_1;
            }, "_NewArmyWin_Label18.text");
            result[14] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.savedTroopCfg);
            }, function (_arg_1:Object):void
            {
                _selectTroopCfgName.dataProvider = _arg_1;
            }, "_selectTroopCfgName.dataProvider");
            result[15] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.quickCoords);
            }, function (_arg_1:Object):void
            {
                _selectQuickCoords.dataProvider = _arg_1;
            }, "_selectQuickCoords.dataProvider");
            result[16] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.missionTypeArray);
            }, function (_arg_1:Object):void
            {
                _selectMissionType.dataProvider = _arg_1;
            }, "_selectMissionType.dataProvider");
            result[17] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.heros);
            }, function (_arg_1:Object):void
            {
                _selectHero.dataProvider = _arg_1;
            }, "_selectHero.dataProvider");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.selectedHero == null)) && (!(this.selectedHero.id == -1)));
            }, function (_arg_1:Boolean):void
            {
                _NewArmyWin_Button4.visible = _arg_1;
            }, "_NewArmyWin_Button4.visible");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((!(this.selectedHero == null)) && (!(this.selectedHero.id == -1)));
            }, function (_arg_1:Boolean):void
            {
                _NewArmyWin_Button4.enabled = _arg_1;
            }, "_NewArmyWin_Button4.enabled");
            result[20] = binding;
            binding = new Binding(this, function ():Object
            {
                return (["+ time", "@ time"]);
            }, function (_arg_1:Object):void
            {
                _selectCampType.dataProvider = _arg_1;
            }, "_selectCampType.dataProvider");
            result[21] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Utils.formatNum((((((this.loadCapacity - Number(this._rInputG.rInput.text)) - Number(this._rInputF.rInput.text)) - Number(this._rInputW.rInput.text)) - Number(this._rInputS.rInput.text)) - Number(this._rInputI.rInput.text)), 0) + " / ") + Utils.formatNum(this.loadCapacity));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label32.text = _arg_1;
            }, "_NewArmyWin_Label32.text");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.resource.food, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label33.text = _arg_1;
            }, "_NewArmyWin_Label33.text");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.resource.wood, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label34.text = _arg_1;
            }, "_NewArmyWin_Label34.text");
            result[24] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.resource.stone, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label35.text = _arg_1;
            }, "_NewArmyWin_Label35.text");
            result[25] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.resource.iron, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label36.text = _arg_1;
            }, "_NewArmyWin_Label36.text");
            result[26] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.resource.gold, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label37.text = _arg_1;
            }, "_NewArmyWin_Label37.text");
            result[27] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.localArmiesData);
            }, function (_arg_1:Object):void
            {
                _NewArmyWin_RowColorDataGrid1.dataProvider = _arg_1;
            }, "_NewArmyWin_RowColorDataGrid1.dataProvider");
            result[28] = binding;
            binding = new Binding(this, function ():Class
            {
                return (NewArmy_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _NewArmyWin_ClassFactory1.generator = _arg_1;
            }, "_NewArmyWin_ClassFactory1.generator");
            result[29] = binding;
            binding = new Binding(this, function ():Class
            {
                return (NewArmy_inlineComponent1);
            }, function (_arg_1:Class):void
            {
                _NewArmyWin_ClassFactory2.generator = _arg_1;
            }, "_NewArmyWin_ClassFactory2.generator");
            result[30] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(Map.fieldDistance(this.fieldId, Map.getFieldId(int(this._xInput.text), int(this._yInput.text))), 3);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label39.text = _arg_1;
            }, "_NewArmyWin_Label39.text");
            result[31] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatNum(this.foodNeeded, 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label41.text = _arg_1;
            }, "_NewArmyWin_Label41.text");
            result[32] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatTime((this.travelTime + this.camptTime));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label43.text = _arg_1;
            }, "_NewArmyWin_Label43.text");
            result[33] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.getArrivalTime((this.travelTime + this.camptTime));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NewArmyWin_Label45.text = _arg_1;
            }, "_NewArmyWin_Label45.text");
            result[34] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get _selectTroopCfgName():ComboBox
        {
            return (this._2075147496_selectTroopCfgName);
        }

        public function ___showInt_change(_arg_1:Event):void
        {
            this.onChangeHeroFilter();
        }

        public function set _rInputF(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1645570161_rInputF;
            if (_local_2 !== _arg_1)
            {
                this._1645570161_rInputF = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rInputF", _local_2, _arg_1));
            };
        }

        public function ___NewArmyWin_Button1_click(_arg_1:MouseEvent):void
        {
            this.onClearTroopInputBtn();
        }

        public function set _rInputG(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1645570160_rInputG;
            if (_local_2 !== _arg_1)
            {
                this._1645570160_rInputG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rInputG", _local_2, _arg_1));
            };
        }

        public function set _rInputI(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1645570158_rInputI;
            if (_local_2 !== _arg_1)
            {
                this._1645570158_rInputI = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rInputI", _local_2, _arg_1));
            };
        }

        private function getNewArmy(_arg_1:Boolean=true):NewArmyParam
        {
            var _local_2:NewArmyParam = new NewArmyParam();
            _local_2.missionType = this._selectMissionType.selectedItem.data;
            _local_2.targetPoint = Map.coordStringToFieldId(((this._xInput.text + ",") + this._yInput.text));
            if (((!(this._selectHero.selectedItem == null)) && ((this._selectHero.selectedItem.heroBean as HeroBean).id >= 0)))
            {
                _local_2.heroId = (this._selectHero.selectedItem.heroBean as HeroBean).id;
            };
            _local_2.troops = this.selectedTroop;
            _local_2.resource = new ResourceBean();
            if (_arg_1)
            {
                _local_2.resource.gold = Number(this._rInputG.rInput.text);
                _local_2.resource.food = Number(this._rInputF.rInput.text);
                _local_2.resource.wood = Number(this._rInputW.rInput.text);
                _local_2.resource.stone = Number(this._rInputS.rInput.text);
                _local_2.resource.iron = Number(this._rInputI.rInput.text);
            };
            _local_2.restTime = this.camptTime;
            _local_2.useFlag = this._applyWarEnsign.selected;
            _local_2.useItem = this._applyStygandrsBannerOfTheHorde.selected;
            return (_local_2);
        }

        private function set availableRallySlots(_arg_1:int):void
        {
            var _local_2:Object = this._876583532availableRallySlots;
            if (_local_2 !== _arg_1)
            {
                this._876583532availableRallySlots = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "availableRallySlots", _local_2, _arg_1));
            };
        }

        private function updateLoadCapacity():void
        {
            this.loadCapacity = this.selectedCity.cityManager.getMaxTroopLoad(this.selectedTroop);
        }

        private function _NewArmyWin_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Target";
            _local_1.dataField = "col2";
            _local_1.width = 225;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        public function set _rInputS(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1645570148_rInputS;
            if (_local_2 !== _arg_1)
            {
                this._1645570148_rInputS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rInputS", _local_2, _arg_1));
            };
        }

        public function set _rInputW(_arg_1:ResourceInput):void
        {
            var _local_2:Object = this._1645570144_rInputW;
            if (_local_2 !== _arg_1)
            {
                this._1645570144_rInputW = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_rInputW", _local_2, _arg_1));
            };
        }

        private function _NewArmyWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.getCityIdInfo(this.fieldId);
            _local_1 = ((Utils.formatInt(((((((((((((this.maxDispatchLimit - int(this._tInputWo.tInput.text)) - int(this._tInputW.tInput.text)) - int(this._tInputS.tInput.text)) - int(this._tInputP.tInput.text)) - int(this._tInputSw.tInput.text)) - int(this._tInputA.tInput.text)) - int(this._tInputC.tInput.text)) - int(this._tInputCata.tInput.text)) - int(this._tInputT.tInput.text)) - int(this._tInputB.tInput.text)) - int(this._tInputR.tInput.text)) - int(this._tInputCp.tInput.text))) + " / ") + Utils.formatInt(this.maxDispatchLimit));
            _local_1 = this.availableRallySlots;
            _local_1 = Utils.formatInt(this.troop.peasants);
            _local_1 = Utils.formatInt(this.troop.militia);
            _local_1 = Utils.formatInt(this.troop.scouter);
            _local_1 = Utils.formatInt(this.troop.pikemen);
            _local_1 = Utils.formatInt(this.troop.swordsmen);
            _local_1 = Utils.formatInt(this.troop.archer);
            _local_1 = Utils.formatInt(this.troop.lightCavalry);
            _local_1 = Utils.formatInt(this.troop.heavyCavalry);
            _local_1 = Utils.formatInt(this.troop.carriage);
            _local_1 = Utils.formatInt(this.troop.ballista);
            _local_1 = Utils.formatInt(this.troop.batteringRam);
            _local_1 = Utils.formatInt(this.troop.catapult);
            _local_1 = this.savedTroopCfg;
            _local_1 = this.quickCoords;
            _local_1 = this.missionTypeArray;
            _local_1 = this.heros;
            _local_1 = ((!(this.selectedHero == null)) && (!(this.selectedHero.id == -1)));
            _local_1 = ((!(this.selectedHero == null)) && (!(this.selectedHero.id == -1)));
            _local_1 = ["+ time", "@ time"];
            _local_1 = ((Utils.formatNum((((((this.loadCapacity - Number(this._rInputG.rInput.text)) - Number(this._rInputF.rInput.text)) - Number(this._rInputW.rInput.text)) - Number(this._rInputS.rInput.text)) - Number(this._rInputI.rInput.text)), 0) + " / ") + Utils.formatNum(this.loadCapacity));
            _local_1 = Utils.formatNum(this.resource.food, 0);
            _local_1 = Utils.formatNum(this.resource.wood, 0);
            _local_1 = Utils.formatNum(this.resource.stone, 0);
            _local_1 = Utils.formatNum(this.resource.iron, 0);
            _local_1 = Utils.formatNum(this.resource.gold, 0);
            _local_1 = this.localArmiesData;
            _local_1 = NewArmy_inlineComponent0;
            _local_1 = NewArmy_inlineComponent1;
            _local_1 = Utils.formatNum(Map.fieldDistance(this.fieldId, Map.getFieldId(int(this._xInput.text), int(this._yInput.text))), 3);
            _local_1 = Utils.formatNum(this.foodNeeded, 0);
            _local_1 = Utils.formatTime((this.travelTime + this.camptTime));
            _local_1 = this.getArrivalTime((this.travelTime + this.camptTime));
        }

        private function updateMaxDispatchLimit():void
        {
            this.maxDispatchLimit = ((this.selectedCity.cityManager.getRallyDispatchPerArmyLimit(true) * (((this._applyWarEnsign.enabled) && (this._applyWarEnsign.selected)) ? 1.25 : 1)) * (((this._applyStygandrsBannerOfTheHorde.enabled) && (this._applyStygandrsBannerOfTheHorde.selected)) ? 10 : 1));
        }

        [Bindable(event="propertyChange")]
        public function get _selectQuickCoords():ComboBox
        {
            return (this._1043134288_selectQuickCoords);
        }

        [Bindable(event="propertyChange")]
        public function get _xInput():TextInput
        {
            return (this._1919807313_xInput);
        }

        [Bindable(event="propertyChange")]
        private function get troop():TroopBean
        {
            return (this._110634834troop);
        }

        public function ___showHH_change(_arg_1:Event):void
        {
            this.onChangeHeroFilter();
        }

        public function ___selectCampType_change(_arg_1:ListEvent):void
        {
            this.onChangeCampType();
        }

        public function ___NewArmyWin_Button6_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function updateFoodNeeded():void
        {
            this.foodNeeded = this.selectedCity.cityManager.getFoodNeededToMarch(this.getNewArmy(false));
        }

        private function updateEnableApplyWarEnsignAndBanner():void
        {
            var _local_3:ItemBean;
            var _local_1:Boolean;
            var _local_2:Boolean;
            for each (_local_3 in MainScreen.getPlayer().itemsArray)
            {
                if (((_local_3.id == "player.troop.1.a") && (_local_3.count > 0)))
                {
                    _local_1 = true;
                };
                if (((_local_3.id == "player.item.stygandrsbannerofthehorde") && (_local_3.count > 0)))
                {
                    _local_2 = true;
                };
            };
            if (!_local_1)
            {
                this._applyWarEnsign.selected = false;
                this._applyWarEnsign.enabled = false;
                this._applyWarEnsignLabel.enabled = false;
            }
            else
            {
                this._applyWarEnsign.enabled = true;
                this._applyWarEnsignLabel.enabled = true;
            };
            if (!_local_2)
            {
                this._applyStygandrsBannerOfTheHorde.selected = false;
                this._applyStygandrsBannerOfTheHorde.enabled = false;
                this._applyStygandrsBannerOfTheHordeLabel.enabled = false;
            }
            else
            {
                this._applyStygandrsBannerOfTheHorde.enabled = true;
                this._applyStygandrsBannerOfTheHordeLabel.enabled = true;
            };
            this.updateMaxDispatchLimit();
        }

        [Bindable(event="propertyChange")]
        private function get savedTroopCfg():ArrayCollection
        {
            return (this._1684939609savedTroopCfg);
        }

        private function set foodNeeded(_arg_1:Number):void
        {
            var _local_2:Object = this._564559437foodNeeded;
            if (_local_2 !== _arg_1)
            {
                this._564559437foodNeeded = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodNeeded", _local_2, _arg_1));
            };
        }

        public function ___showLH_change(_arg_1:Event):void
        {
            this.onChangeHeroFilter();
        }

        private function set fieldId(_arg_1:int):void
        {
            var _local_2:Object = this._861252683fieldId;
            if (_local_2 !== _arg_1)
            {
                this._861252683fieldId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldId", _local_2, _arg_1));
            };
        }

        private function _NewArmyWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Army";
            _local_1.dataField = "col1";
            _local_1.width = 95;
            return (_local_1);
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

        public function ___NewArmyWin_Label23_click(_arg_1:MouseEvent):void
        {
            this._showLH.selected = (!(this._showLH.selected));
            this.onChangeHeroFilter();
        }

        public function set _tInputCata(_arg_1:TroopInput):void
        {
            var _local_2:Object = this._816969280_tInputCata;
            if (_local_2 !== _arg_1)
            {
                this._816969280_tInputCata = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_tInputCata", _local_2, _arg_1));
            };
        }

        public function set _inputCampTimeHr(_arg_1:TextInput):void
        {
            var _local_2:Object = this._77820867_inputCampTimeHr;
            if (_local_2 !== _arg_1)
            {
                this._77820867_inputCampTimeHr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputCampTimeHr", _local_2, _arg_1));
            };
        }

        private function set loadCapacity(_arg_1:Number):void
        {
            var _local_2:Object = this._1215952832loadCapacity;
            if (_local_2 !== _arg_1)
            {
                this._1215952832loadCapacity = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "loadCapacity", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _rInputF():ResourceInput
        {
            return (this._1645570161_rInputF);
        }

        [Bindable(event="propertyChange")]
        public function get _rInputG():ResourceInput
        {
            return (this._1645570160_rInputG);
        }

        override public function initialize():void
        {
            var target:NewArmyWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._NewArmyWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil");
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
        public function get _rInputI():ResourceInput
        {
            return (this._1645570158_rInputI);
        }

        [Bindable(event="propertyChange")]
        public function get _rInputS():ResourceInput
        {
            return (this._1645570148_rInputS);
        }

        internal function onResoChange(_arg_1:TextInput):void
        {
            var _local_2:Number;
            _arg_1.text = ("" + Number(_arg_1.text));
            if (Number(_arg_1.text) == 0)
            {
                this.moveCursorToEnd(_arg_1);
            }
            else
            {
                if (Number(_arg_1.text) < 0)
                {
                    _arg_1.text = ("" + 0);
                    this.moveCursorToEnd(_arg_1);
                }
                else
                {
                    _local_2 = this.getMax(_arg_1);
                    if (Number(_arg_1.text) > _local_2)
                    {
                        _arg_1.text = ("" + _local_2);
                    };
                };
            };
            this.updateResourceInfo();
        }

        [Bindable(event="propertyChange")]
        public function get _rInputW():ResourceInput
        {
            return (this._1645570144_rInputW);
        }

        [Bindable(event="propertyChange")]
        private function get camptTime():Number
        {
            return (this._25601152camptTime);
        }

        public function set _selectMissionType(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1592359477_selectMissionType;
            if (_local_2 !== _arg_1)
            {
                this._1592359477_selectMissionType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_selectMissionType", _local_2, _arg_1));
            };
        }

        public function ___selectQuickCoords_change(_arg_1:ListEvent):void
        {
            this.onQuickCoordsChange();
        }

        public function set _inputTroopCfgName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1702837304_inputTroopCfgName;
            if (_local_2 !== _arg_1)
            {
                this._1702837304_inputTroopCfgName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_inputTroopCfgName", _local_2, _arg_1));
            };
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
            this._selectQuickCoords.selectedIndex = 0;
            this.updateTravelTime();
        }

        public function ___inputCampTimeMs_change(_arg_1:Event):void
        {
            this.onChangeCampTime((_arg_1.currentTarget as TextInput));
        }

        [Bindable(event="propertyChange")]
        private function get fieldId():int
        {
            return (this._861252683fieldId);
        }

        public function set _showHH(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1805325788_showHH;
            if (_local_2 !== _arg_1)
            {
                this._1805325788_showHH = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_showHH", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get heros():ArrayCollection
        {
            return (this._99168185heros);
        }

        [Bindable(event="propertyChange")]
        public function get _inputCampTimeHr():TextInput
        {
            return (this._77820867_inputCampTimeHr);
        }

        [Bindable(event="propertyChange")]
        public function get _inputTroopCfgName():TextInput
        {
            return (this._1702837304_inputTroopCfgName);
        }

        public function ___inputCampTimeHr_change(_arg_1:Event):void
        {
            this.onChangeCampTime((_arg_1.currentTarget as TextInput));
        }

        private function onSaveTroopCfg():void
        {
            var _local_4:Object;
            var _local_5:SharedObject;
            var _local_6:String;
            if (((this._inputTroopCfgName.text == "") || (this._inputTroopCfgName.text.charAt(0) == " ")))
            {
                return;
            };
            var _local_1:String = Utils.troopBeanToString(this.selectedTroop);
            var _local_2:String = this._inputTroopCfgName.text;
            var _local_3:int;
            for each (_local_4 in this.savedTroopCfg)
            {
                if (_local_4.label == _local_2)
                {
                    this.savedTroopCfg.removeItemAt(_local_3);
                    break;
                };
                _local_3++;
            };
            this.savedTroopCfg.addItemAt({
                "label":_local_2,
                "troopCfg":_local_1
            }, _local_3);
            _local_5 = SharedObject.getLocal("newArmyTroopCfgs");
            _local_5.data.now = this.savedTroopCfg.toArray();
            this._selectTroopCfgName.selectedIndex = _local_3;
            this._inputTroopCfgName.text = "";
            _local_6 = "";
            if (_local_5.flush() != SharedObjectFlushStatus.FLUSHED)
            {
                _local_6 = "SAVING PROBLEM:  You may need to increase flash local storage.";
            }
            else
            {
                _local_6 = (("The troop configuration '" + _local_2) + "' was saved successfully.");
            };
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _local_6));
        }

        [Bindable(event="propertyChange")]
        private function get loadCapacity():Number
        {
            return (this._1215952832loadCapacity);
        }

        public function ___inputCampTimeMin_change(_arg_1:Event):void
        {
            this.onChangeCampTime((_arg_1.currentTarget as TextInput));
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

        private function onChangeHeroFilter():void
        {
            this.setFreeHeros();
        }

        private function onQuickCoordsChange():void
        {
            if (this._selectQuickCoords.selectedIndex == 0)
            {
                return;
            };
            this._xInput.text = ("" + Map.getX(this._selectQuickCoords.selectedItem.data));
            this._yInput.text = ("" + Map.getY(this._selectQuickCoords.selectedItem.data));
            this.updateTravelTime();
        }

        [Bindable(event="propertyChange")]
        public function get _yInput():TextInput
        {
            return (this._1948436464_yInput);
        }

        public function set _availRallySlots(_arg_1:Label):void
        {
            var _local_2:Object = this._1706017285_availRallySlots;
            if (_local_2 !== _arg_1)
            {
                this._1706017285_availRallySlots = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_availRallySlots", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui.newarmy

