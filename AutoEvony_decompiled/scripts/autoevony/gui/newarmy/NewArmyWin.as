package autoevony.gui.newarmy
{
   import autoevony.common.CityStateCommands;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.RowColorDataGrid;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.CastleResourceBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.ResourceBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.constants.FieldConstants;
   import com.evony.common.constants.HeroConstants;
   import com.evony.common.constants.ObjConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.paramBeans.NewArmyParam;
   import com.evony.common.server.events.HeroUpdate;
   import com.evony.common.server.events.ItemUpdate;
   import com.evony.common.server.events.ResourceUpdate;
   import com.evony.common.server.events.SelfArmysUpdate;
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
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ComboBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class NewArmyWin extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
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
      },{
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
      },{
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
      },{
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
      },{
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
      },{
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
      },{
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
      },{
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
      },{
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
      },{
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
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496;
      
      private var _282413427_tInputWo:TroopInput;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924;
      
      private var _129437214_tInputS:TroopInput;
      
      private var _129437218_tInputW:TroopInput;
      
      private var _99168185heros:ArrayCollection = new ArrayCollection();
      
      private var _1645570160_rInputG:ResourceInput;
      
      private var _1898746486_deployBtn:Button;
      
      private var _129437196_tInputA:TroopInput;
      
      private var castleId:int;
      
      mx_internal var _bindingsByDestination:Object = {};
      
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
      
      private var _embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722;
      
      private var _1948436464_yInput:TextInput;
      
      private var _1702837304_inputTroopCfgName:TextInput;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154;
      
      private var _129437213_tInputR:TroopInput;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488;
      
      private var _1043134288_selectQuickCoords:ComboBox;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154;
      
      private var _77821023_inputCampTimeMs:TextInput;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794;
      
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
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _276213653quickCoords:ArrayCollection = new ArrayCollection([{
         "label":"none",
         "data":-1
      }]);
      
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
      
      private var _embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212;
      
      private var _embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048;
      
      private var _110634834troop:TroopBean = null;
      
      private var _2075147496_selectTroopCfgName:ComboBox;
      
      private var _1684939609savedTroopCfg:ArrayCollection = null;
      
      private var _1239375627_applyWarEnsignLabel:Label;
      
      private var _1882510152_inputCampTimeSec:TextInput;
      
      private var _991165677missionTypeArray:ArrayCollection = new ArrayCollection([{
         "label":"Transport",
         "data":ObjConstants.ARMY_MISSION_TRANS
      },{
         "label":"Reinforce",
         "data":ObjConstants.ARMY_MISSION_SEND
      },{
         "label":"Scout",
         "data":ObjConstants.ARMY_MISSION_SCOUT
      },{
         "label":"Attack",
         "data":ObjConstants.ARMY_MISSION_OCCUPY
      },{
         "label":"Colonize",
         "data":ObjConstants.ARMY_MISSION_COLONIZE
      }]);
      
      private var _1919807313_xInput:TextInput;
      
      private var _1999462250_selectCampType:ComboBox;
      
      private var _568004427_selectHero:ComboBox;
      
      private var emptyHero:HeroBean = null;
      
      private var _282414046_tInputCp:TroopInput;
      
      private var _129437211_tInputP:TroopInput;
      
      private var _129437215_tInputT:TroopInput;
      
      private var _1645570158_rInputI:ResourceInput;
      
      private var _1645570161_rInputF:ResourceInput;
      
      private var _embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056;
      
      private var _129437197_tInputB:TroopInput;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212;
      
      private var _2087571216localArmiesData:ArrayCollection = new ArrayCollection();
      
      public var _NewArmyWin_RowColorDataGrid1:RowColorDataGrid;
      
      mx_internal var _watchers:Array = [];
      
      private var _130533585_showPol:CheckBox;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280;
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940;
      
      private var _1244701377_applyWarEnsign:CheckBox;
      
      private var _embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896:Class = NewArmyWin__embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896;
      
      private var _25601152camptTime:Number = 0;
      
      private var _130519324_showAtk:CheckBox;
      
      mx_internal var _bindings:Array = [];
      
      private var _embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226:Class = NewArmyWin__embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":780,
               "height":535,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"windowTitle":"New Army"};
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"_NewArmyWin_Text1",
                  "stylesFactory":function():void
                  {
                     this.left = "16";
                     this.top = "12";
                     this.textAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":244,
                        "height":22,
                        "styleName":"newArmyTroop"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "15";
                     this.top = "45";
                     this.bottom = "15";
                     this.right = "15";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "0";
                              this.top = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":410,
                                 "height":337,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":26,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Dispatch limit:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label2",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_applyWarEnsignLabel",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Apply War Ensign",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to apply War Ensign to increase army size by 25%"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_applyWarEnsign",
                                                      "events":{"change":"___applyWarEnsign_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":false,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to apply War Ensign to increase army size by 25%"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":6};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":24,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Available Rally Slots:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_availRallySlots",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_applyStygandrsBannerOfTheHordeLabel",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Apply Stygandr\'s Banner",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to apply Stygandr\'s Banner of the Horde to increase army size by 10x"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_applyStygandrsBannerOfTheHorde",
                                                      "events":{"change":"___applyStygandrsBannerOfTheHorde_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":false,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to apply Stygandr\'s Banner of the Horde to increase army size by 10x"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":6};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.horizontalAlign = "right";
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":15};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "events":{"click":"___NewArmyWin_Button1_click"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.fontSize = 10;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "label":"Clear",
                                                            "height":19,
                                                            "focusEnabled":false,
                                                            "styleName":"REwinBtn"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"percentWidth":100};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_wo_icon_png_43741154,
                                                            "toolTip":"Workers"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputWo"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label7",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_w_icon_png_367385154,
                                                            "toolTip":"Warriors"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputW"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label8",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_s_icon_png_724491398,
                                                            "toolTip":"Scouts"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputS"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label9",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_p_icon_png_1427655496,
                                                            "toolTip":"Pikemen"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputP"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label10",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_sw_icon_png_656076794,
                                                            "toolTip":"Swordsmen"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputSw"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label11",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_a_icon_png_384125722,
                                                            "toolTip":"Archers"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputA"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label12",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_c_icon_png_1441123226,
                                                            "toolTip":"Cavalry"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputC"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label13",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_cata_icon_png_1823416280,
                                                            "toolTip":"Cataphract"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputCata"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label14",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_t_icon_png_706362488,
                                                            "toolTip":"Transporters"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputT"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label15",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_b_icon_png_353381212,
                                                            "toolTip":"Ballista"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputB"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label16",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_r_icon_png_350636924,
                                                            "toolTip":"Battering Rams"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputR"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label17",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_troopLogo_cp_icon_png_666664940,
                                                            "toolTip":"Catapults"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TroopInput,
                                                      "id":"_tInputCp"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label18",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":91,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Spacer,
                                             "propertiesFactory":function():Object
                                             {
                                                return {"height":4};
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 5;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":36,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_inputTroopCfgName",
                                                      "events":{"change":"___inputTroopCfgName_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":200,
                                                            "height":22,
                                                            "text":"",
                                                            "maxChars":20,
                                                            "restrict":"a-z,A-Z,0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "events":{"click":"___NewArmyWin_Button2_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "label":"Save Preset",
                                                            "focusEnabled":false,
                                                            "styleName":"REwinBtn"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 5;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":40,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":ComboBox,
                                                      "id":"_selectTroopCfgName",
                                                      "events":{"change":"___selectTroopCfgName_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":200,
                                                            "height":22,
                                                            "styleName":"ComboBox"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Button,
                                                      "events":{"click":"___NewArmyWin_Button3_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "label":"Delete Preset",
                                                            "focusEnabled":false,
                                                            "styleName":"REwinCancelBtn"
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
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "413";
                              this.right = "0";
                              this.top = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":164,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 5;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":78,
                                                            "text":"Target:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_xInput",
                                                      "events":{
                                                         "change":"___xInput_change",
                                                         "keyDown":"___xInput_keyDown"
                                                      },
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":40,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":3,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_yInput",
                                                      "events":{"change":"___yInput_change"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":40,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":3,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":5};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ComboBox,
                                                      "id":"_selectQuickCoords",
                                                      "events":{"change":"___selectQuickCoords_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "height":22,
                                                            "styleName":"ComboBox"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 5;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":78,
                                                            "text":"Mission:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ComboBox,
                                                      "id":"_selectMissionType",
                                                      "events":{"change":"___selectMissionType_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":170,
                                                            "height":22,
                                                            "styleName":"ComboBox"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 5;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":78,
                                                            "text":"Hero:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ComboBox,
                                                      "id":"_selectHero",
                                                      "events":{"change":"___selectHero_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":240,
                                                            "height":22,
                                                            "styleName":"ComboBox"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 0;
                                                this.horizontalAlign = "center";
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Button,
                                                      "id":"_NewArmyWin_Button4",
                                                      "events":{"click":"___NewArmyWin_Button4_click"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.fontSize = 10;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "label":"View",
                                                            "height":19,
                                                            "focusEnabled":false,
                                                            "includeInLayout":true,
                                                            "styleName":"REwinBtn"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":15};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "events":{"click":"___NewArmyWin_Label22_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"HH",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to show Historic Heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_showHH",
                                                      "events":{"change":"___showHH_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":true,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to show Historic Heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":8};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "events":{"click":"___NewArmyWin_Label23_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"LH",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to show Legendary Heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_showLH",
                                                      "events":{"change":"___showLH_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":true,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to show Legendary Heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":8};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "events":{"click":"___NewArmyWin_Label24_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Pol",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to show Politic type heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_showPol",
                                                      "events":{"change":"___showPol_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":true,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to show Politic type heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":8};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "events":{"click":"___NewArmyWin_Label25_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Atk",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to show Attack type heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_showAtk",
                                                      "events":{"change":"___showAtk_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":true,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to show Attack type heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":8};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "events":{"click":"___NewArmyWin_Label26_click"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Int",
                                                            "styleName":"newArmyTroop",
                                                            "toolTip":"Mark to show Intel type heroes in the selection list"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":CheckBox,
                                                      "id":"_showInt",
                                                      "events":{"change":"___showInt_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "selected":true,
                                                            "styleName":"REcheckBox",
                                                            "toolTip":"Mark to show Intel type heroes in the selection list"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 0;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":30,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":78,
                                                            "text":"Camp Time:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":5};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_inputCampTimeHr",
                                                      "events":{"change":"___inputCampTimeHr_change"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":30,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":2,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                         this.fontSize = 14;
                                                         this.paddingLeft = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":8,
                                                            "text":":",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_inputCampTimeMin",
                                                      "events":{"change":"___inputCampTimeMin_change"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":30,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":2,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                         this.fontSize = 14;
                                                         this.paddingLeft = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":8,
                                                            "text":":",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_inputCampTimeSec",
                                                      "events":{"change":"___inputCampTimeSec_change"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":30,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":2,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                         this.fontSize = 14;
                                                         this.paddingLeft = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":8,
                                                            "text":".",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":TextInput,
                                                      "id":"_inputCampTimeMs",
                                                      "events":{"change":"___inputCampTimeMs_change"},
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "center";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":30,
                                                            "height":22,
                                                            "text":"0",
                                                            "maxChars":2,
                                                            "restrict":"0-9",
                                                            "styleName":"textInput"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Spacer,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"width":5};
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ComboBox,
                                                      "id":"_selectCampType",
                                                      "events":{"change":"___selectCampType_change"},
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":90,
                                                            "height":22,
                                                            "styleName":"ComboBox"
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
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "413";
                              this.right = "0";
                              this.top = "167";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":170,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":25,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Load capacity:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label32",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_resoLogo_f_icon_png_472776098
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ResourceInput,
                                                      "id":"_rInputF"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label33",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_resoLogo_w_icon_png_313115048
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ResourceInput,
                                                      "id":"_rInputW"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label34",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_resoLogo_s_icon_png_332564056
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ResourceInput,
                                                      "id":"_rInputS"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label35",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_resoLogo_i_icon_png_627990212
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ResourceInput,
                                                      "id":"_rInputI"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label36",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
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
                                                      "type":Image,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":23,
                                                            "height":23,
                                                            "source":_embed_mxml_autoevony_gui_images_resoLogo_g_icon_png_195689896
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":ResourceInput,
                                                      "id":"_rInputG"
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label37",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":130,
                                                            "styleName":"newArmyTroop"
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
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "0";
                              this.top = "340";
                              this.bottom = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":532,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":RowColorDataGrid,
                                    "id":"_NewArmyWin_RowColorDataGrid1",
                                    "stylesFactory":function():void
                                    {
                                       this.headerStyleName = "columnHeaderSyle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
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
                                          "columns":[_NewArmyWin_DataGridColumn1_c(),_NewArmyWin_DataGridColumn2_c(),_NewArmyWin_DataGridColumn3_c(),_NewArmyWin_DataGridColumn4_c(),_NewArmyWin_DataGridColumn5_c()]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "535";
                              this.right = "0";
                              this.top = "340";
                              this.bottom = "33";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":20,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":100,
                                                            "text":"Distance:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label39",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":20,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":100,
                                                            "text":"Required food:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label41",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":20,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":100,
                                                            "text":"One-way time:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label43",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":HBox,
                                             "stylesFactory":function():void
                                             {
                                                this.horizontalGap = 3;
                                                this.verticalAlign = "middle";
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 0;
                                                this.paddingBottom = 0;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":20,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "width":100,
                                                            "text":"Arrival time:",
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_NewArmyWin_Label45",
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {"styleName":"newArmyTroop"};
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
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":30,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function():Object
                                    {
                                       return {"width":125};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_deployBtn",
                                    "events":{"click":"___deployBtn_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Deploy",
                                          "focusEnabled":false,
                                          "enabled":true,
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 })]
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___NewArmyWin_Button6_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "2";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"close"};
                  }
               })]
            };
         }
      });
      
      public function NewArmyWin()
      {
         super();
         mx_internal::_document = this;
         this.width = 780;
         this.height = 535;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___NewArmyWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         NewArmyWin._watcherSetupUtil = param1;
      }
      
      private function onMarchResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
            this.updateResourceInfo();
            return;
         }
      }
      
      private function updateTroop() : void
      {
         this.troop = this.selectedCity.cityManager.troop;
      }
      
      [Bindable(event="propertyChange")]
      private function get resource() : ResourceBean
      {
         return this._341064690resource;
      }
      
      public function set _tInputA(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437196_tInputA;
         if(_loc2_ !== param1)
         {
            this._129437196_tInputA = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputA",_loc2_,param1));
         }
      }
      
      public function set _tInputB(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437197_tInputB;
         if(_loc2_ !== param1)
         {
            this._129437197_tInputB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputB",_loc2_,param1));
         }
      }
      
      public function set _tInputC(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437198_tInputC;
         if(_loc2_ !== param1)
         {
            this._129437198_tInputC = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputC",_loc2_,param1));
         }
      }
      
      public function ___inputTroopCfgName_change(param1:Event) : void
      {
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputCp() : TroopInput
      {
         return this._282414046_tInputCp;
      }
      
      private function set resource(param1:ResourceBean) : void
      {
         var _loc2_:Object = this._341064690resource;
         if(_loc2_ !== param1)
         {
            this._341064690resource = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resource",_loc2_,param1));
         }
      }
      
      public function set _tInputP(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437211_tInputP;
         if(_loc2_ !== param1)
         {
            this._129437211_tInputP = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputP",_loc2_,param1));
         }
      }
      
      public function set _tInputSw(param1:TroopInput) : void
      {
         var _loc2_:Object = this._282413543_tInputSw;
         if(_loc2_ !== param1)
         {
            this._282413543_tInputSw = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputSw",_loc2_,param1));
         }
      }
      
      public function set _tInputR(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437213_tInputR;
         if(_loc2_ !== param1)
         {
            this._129437213_tInputR = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputR",_loc2_,param1));
         }
      }
      
      public function ___NewArmyWin_Label22_click(param1:MouseEvent) : void
      {
         this._showHH.selected = !this._showHH.selected;
         this.onChangeHeroFilter();
      }
      
      public function set _tInputS(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437214_tInputS;
         if(_loc2_ !== param1)
         {
            this._129437214_tInputS = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputS",_loc2_,param1));
         }
      }
      
      public function ___xInput_change(param1:Event) : void
      {
         this.onCoordChange(param1.currentTarget as TextInput);
      }
      
      public function set _tInputCp(param1:TroopInput) : void
      {
         var _loc2_:Object = this._282414046_tInputCp;
         if(_loc2_ !== param1)
         {
            this._282414046_tInputCp = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputCp",_loc2_,param1));
         }
      }
      
      public function set _tInputT(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437215_tInputT;
         if(_loc2_ !== param1)
         {
            this._129437215_tInputT = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputT",_loc2_,param1));
         }
      }
      
      public function ___showAtk_change(param1:Event) : void
      {
         this.onChangeHeroFilter();
      }
      
      private function updateTroopInfo() : void
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
      
      public function set _tInputW(param1:TroopInput) : void
      {
         var _loc2_:Object = this._129437218_tInputW;
         if(_loc2_ !== param1)
         {
            this._129437218_tInputW = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputW",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get maxDispatchLimit() : int
      {
         return this._1483390883maxDispatchLimit;
      }
      
      [Bindable(event="propertyChange")]
      private function get quickCoords() : ArrayCollection
      {
         return this._276213653quickCoords;
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputCampTimeMs() : TextInput
      {
         return this._77821023_inputCampTimeMs;
      }
      
      [Bindable(event="propertyChange")]
      public function get _applyStygandrsBannerOfTheHorde() : CheckBox
      {
         return this._181090216_applyStygandrsBannerOfTheHorde;
      }
      
      private function doMarch() : String
      {
         var _loc1_:ArmyBean = null;
         var _loc2_:NewArmyParam = null;
         var _loc3_:Number = NaN;
         if(Map.coordStringToFieldId(this._xInput.text + "," + this._yInput.text) == this.fieldId)
         {
            return "Destination is the current castle!";
         }
         if(this.loadCapacity < Number(this._rInputG.rInput.text) + Number(this._rInputF.rInput.text) + Number(this._rInputW.rInput.text) + Number(this._rInputS.rInput.text) + Number(this._rInputI.rInput.text))
         {
            return "Total selected resources exceeds the selected army\'s carry limit!";
         }
         if(this.maxDispatchLimit < Utils.getTotalTroopCount(this.selectedTroop))
         {
            return "Selected troop count exceeds maximum army size!";
         }
         this.updateAvailableRallySlots();
         if(this.availableRallySlots < 1)
         {
            return "No available rally slots!";
         }
         this.seenArmies = new Array();
         for each(_loc1_ in this.selectedCity.cityManager.localArmies)
         {
            this.seenArmies.push(_loc1_.armyId);
         }
         _loc2_ = this.getNewArmy();
         _loc3_ = this.selectedCity.cityManager.getCampTimeChangeBuffsFactor();
         this.updateCamptTime();
         if(int(int(this.camptTime) * _loc3_) > 24 * 60 * 60)
         {
            return "Camp time exceeds server limit at " + Utils.formatTime(int(this.camptTime) * _loc3_) + "! Example camp time limits: [normal 24h] [1xFF ~10h:8m:24s] [2xFF ~2h:9m:36s]";
         }
         _loc2_.restTime = int(this.camptTime);
         CityStateCommands.newArmy(this.castleId,_loc2_,this.onMarchResponse);
         this.resource.gold -= _loc2_.resource.gold;
         this.resource.food -= _loc2_.resource.food + this.foodNeeded;
         this.resource.wood -= _loc2_.resource.wood;
         this.resource.stone -= _loc2_.resource.stone;
         this.resource.iron -= _loc2_.resource.iron;
         return null;
      }
      
      private function onChangeCampTime(param1:TextInput) : void
      {
         var _loc2_:int = 0;
         param1.text = "" + int(param1.text);
         if(int(param1.text) == 0)
         {
            this.moveCursorToEnd(param1);
         }
         else if(int(param1.text) < 0)
         {
            param1.text = "" + 0;
            this.moveCursorToEnd(param1);
         }
         else
         {
            _loc2_ = param1.id == "inputCampTimeHr" ? 23 : (param1.id == "inputCampTimeMs" ? 99 : 59);
            if(int(param1.text) > _loc2_)
            {
               param1.text = "" + _loc2_;
            }
         }
         this.updateTravelTime();
      }
      
      private function _NewArmyWin_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._NewArmyWin_ClassFactory2 = _loc1_;
         BindingManager.executeBindings(this,"_NewArmyWin_ClassFactory2",this._NewArmyWin_ClassFactory2);
         return _loc1_;
      }
      
      private function updateSelectedhero() : void
      {
         if(this.heros.length > 0 && this._selectHero.selectedItem != null && this._selectHero.selectedItem.heroBean != null)
         {
            this.selectedHero = this._selectHero.selectedItem.heroBean as HeroBean;
         }
         else
         {
            this.selectedHero = null;
         }
         this.updateTravelTime();
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectCampType() : ComboBox
      {
         return this._1999462250_selectCampType;
      }
      
      private function onHeroUpdate(param1:HeroUpdate) : void
      {
         if(param1.castleId == this.castleId)
         {
            Utils.callLater(100,this.setFreeHeros);
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectHero() : ComboBox
      {
         return this._568004427_selectHero;
      }
      
      private function updateCamptTime() : void
      {
         this.camptTime = this.selectedCity._parseRestTime((this._selectCampType.selectedIndex == 0 ? "" : "@") + this._inputCampTimeHr.text + ":" + this._inputCampTimeMin.text + ":" + this._inputCampTimeSec.text + "." + this._inputCampTimeMs.text,this.travelTime);
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputCampTimeSec() : TextInput
      {
         return this._1882510152_inputCampTimeSec;
      }
      
      private function set maxDispatchLimit(param1:int) : void
      {
         var _loc2_:Object = this._1483390883maxDispatchLimit;
         if(_loc2_ !== param1)
         {
            this._1483390883maxDispatchLimit = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxDispatchLimit",_loc2_,param1));
         }
      }
      
      public function ___selectMissionType_change(param1:ListEvent) : void
      {
         this.onChangeMissionType();
      }
      
      private function _NewArmyWin_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._NewArmyWin_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_NewArmyWin_ClassFactory1",this._NewArmyWin_ClassFactory1);
         return _loc1_;
      }
      
      public function set _inputCampTimeMs(param1:TextInput) : void
      {
         var _loc2_:Object = this._77821023_inputCampTimeMs;
         if(_loc2_ !== param1)
         {
            this._77821023_inputCampTimeMs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputCampTimeMs",_loc2_,param1));
         }
      }
      
      public function ___NewArmyWin_Button4_click(param1:MouseEvent) : void
      {
         MainScreen.getInstance()._cityPanel._onViewHeroBtn(this.selectedHero.id);
      }
      
      public function set _applyStygandrsBannerOfTheHorde(param1:CheckBox) : void
      {
         var _loc2_:Object = this._181090216_applyStygandrsBannerOfTheHorde;
         if(_loc2_ !== param1)
         {
            this._181090216_applyStygandrsBannerOfTheHorde = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_applyStygandrsBannerOfTheHorde",_loc2_,param1));
         }
      }
      
      public function ___xInput_keyDown(param1:KeyboardEvent) : void
      {
         this.keyDownHandle(param1);
      }
      
      private function onDeployBtn() : void
      {
         var msg:String;
         this._deployBtn.enabled = false;
         msg = this.doMarch();
         if(msg != null)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,msg));
            this._deployBtn.enabled = true;
            return;
         }
         Utils.callLater(this.selectedCity.lag,function():void
         {
            _deployBtn.enabled = true;
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get _showPol() : CheckBox
      {
         return this._130533585_showPol;
      }
      
      public function set _showLH(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1805325912_showLH;
         if(_loc2_ !== param1)
         {
            this._1805325912_showLH = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showLH",_loc2_,param1));
         }
      }
      
      private function postTroopChange() : void
      {
         this.updateTroopInfo();
         this.updateMaxDispatchLimit();
         this.updateResourceInfo();
         this.updateTravelTime();
      }
      
      private function set quickCoords(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._276213653quickCoords;
         if(_loc2_ !== param1)
         {
            this._276213653quickCoords = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"quickCoords",_loc2_,param1));
         }
      }
      
      public function set _showInt(param1:CheckBox) : void
      {
         var _loc2_:Object = this._130526835_showInt;
         if(_loc2_ !== param1)
         {
            this._130526835_showInt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showInt",_loc2_,param1));
         }
      }
      
      private function restoreMissionInfo() : void
      {
         var _loc1_:int = 0;
         this._xInput.text = "" + Map.getX(newArmyViewCfg[this.ctyInd].target);
         this._yInput.text = "" + Map.getY(newArmyViewCfg[this.ctyInd].target);
         if(newArmyViewCfg[this.ctyInd].quickTarget != 1)
         {
            _loc1_ = 0;
            while(_loc1_ < this.quickCoords.length)
            {
               if(this.quickCoords[_loc1_].data == newArmyViewCfg[this.ctyInd].quickTarget)
               {
                  this._selectQuickCoords.selectedIndex = _loc1_;
                  this.onQuickCoordsChange();
                  break;
               }
               _loc1_++;
            }
         }
         if(newArmyViewCfg[this.ctyInd].mission != 1)
         {
            _loc1_ = 0;
            while(_loc1_ < this.missionTypeArray.length)
            {
               if(this.missionTypeArray[_loc1_].data == newArmyViewCfg[this.ctyInd].mission)
               {
                  this._selectMissionType.selectedIndex = _loc1_;
                  this.onChangeMissionType();
                  break;
               }
               _loc1_++;
            }
         }
         this._showHH.selected = newArmyViewCfg[this.ctyInd].heroTypes.HH;
         this._showLH.selected = newArmyViewCfg[this.ctyInd].heroTypes.LH;
         this._showPol.selected = newArmyViewCfg[this.ctyInd].heroTypes.Pol;
         this._showAtk.selected = newArmyViewCfg[this.ctyInd].heroTypes.Atk;
         this._showInt.selected = newArmyViewCfg[this.ctyInd].heroTypes.Int;
         this.onChangeHeroFilter();
         if(newArmyViewCfg[this.ctyInd].hero != -1)
         {
            _loc1_ = 0;
            while(_loc1_ < this.heros.length)
            {
               if((this.heros[_loc1_].heroBean as HeroBean).id == newArmyViewCfg[this.ctyInd].hero)
               {
                  this._selectHero.selectedIndex = _loc1_;
                  this.updateSelectedhero();
                  break;
               }
               _loc1_++;
            }
         }
         this._inputCampTimeHr.text = "" + newArmyViewCfg[this.ctyInd].campTime.hour;
         this._inputCampTimeMin.text = "" + newArmyViewCfg[this.ctyInd].campTime.min;
         this._inputCampTimeSec.text = "" + newArmyViewCfg[this.ctyInd].campTime.sec;
         this._inputCampTimeMs.text = "" + newArmyViewCfg[this.ctyInd].campTime.ms;
         this._selectCampType.selectedIndex = newArmyViewCfg[this.ctyInd].campType;
         this.updateTravelTime();
      }
      
      public function set _deployBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1898746486_deployBtn;
         if(_loc2_ !== param1)
         {
            this._1898746486_deployBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_deployBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _applyWarEnsignLabel() : Label
      {
         return this._1239375627_applyWarEnsignLabel;
      }
      
      private function onChangeMissionType() : void
      {
         this._showHH.selected = this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS || this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND || this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SCOUT;
         this._showLH.selected = this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS || this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND || this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SCOUT;
         this._showPol.selected = this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS || this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND;
         this._showAtk.selected = true;
         this._showInt.selected = true;
         this.setFreeHeros();
         this.updateTravelTime();
      }
      
      private function onChangeCampType() : void
      {
         this.updateTravelTime();
      }
      
      private function onItemUpdate(param1:ItemUpdate = null) : void
      {
         var _loc3_:ItemBean = null;
         var _loc2_:Boolean = false;
         for each(_loc3_ in param1.itemsArray)
         {
            if(_loc3_.id == "player.troop.1.a" || _loc3_.id == "player.item.stygandrsbannerofthehorde")
            {
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_)
         {
            Utils.callLater(150,this.updateEnableApplyWarEnsignAndBanner);
         }
      }
      
      public function ___inputCampTimeSec_change(param1:Event) : void
      {
         this.onChangeCampTime(param1.currentTarget as TextInput);
      }
      
      [Bindable(event="propertyChange")]
      private function get travelTime() : Number
      {
         return this._681912583travelTime;
      }
      
      private function onSelfArmiesUpdate(param1:SelfArmysUpdate = null) : void
      {
         var update:SelfArmysUpdate = param1;
         Utils.callLater(100,function():void
         {
            updateAvailableRallySlots();
            updateTroop();
            updateLocalArmiesData();
         });
      }
      
      private function init() : void
      {
         MainScreen.getInstance()._cityPanel.setMarchWin(this);
         this.ctyInd = MainScreen.getInstance().getSelectedCityIndex();
         this.fieldId = MainScreen.getInstance().getSelectedCity().castle.fieldId;
         this.castleId = MainScreen.getInstance().getSelectedCity().castleId;
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.onSelfArmiesUpdate);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE,this.onResourceUpdate);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.onHeroUpdate);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
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
         var _loc1_:SharedObject = SharedObject.getLocal("newArmyTroopCfgs");
         this.savedTroopCfg = new ArrayCollection(_loc1_.data.now as Array);
         if(this.savedTroopCfg == null || this.savedTroopCfg.length == 0)
         {
            this.savedTroopCfg = new ArrayCollection([{
               "label":"none",
               "troopCfg":"wo:0"
            }]);
         }
         this.restoreMissionInfo();
         this.armiesUpdateTimer = new Timer(2000);
         this.armiesUpdateTimer.addEventListener(TimerEvent.TIMER,this.updateLocalArmiesData);
         this.armiesUpdateTimer.start();
         Utils.callLater(50,this.updateLocalArmiesData);
      }
      
      public function updateInfo(param1:Function = null) : void
      {
         this.closeFunc = param1;
      }
      
      public function set _tInputWo(param1:TroopInput) : void
      {
         var _loc2_:Object = this._282413427_tInputWo;
         if(_loc2_ !== param1)
         {
            this._282413427_tInputWo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputWo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _showAtk() : CheckBox
      {
         return this._130519324_showAtk;
      }
      
      internal function onMaxBtn(param1:TextInput) : void
      {
         param1.text = "" + this.getMax(param1);
         param1.setFocus();
         this.moveCursorToEnd(param1);
         if(param1.id == "tInput")
         {
            this.postTroopChange();
         }
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.NUMPAD_DECIMAL || param1.keyCode == Keyboard.PERIOD || param1.keyCode == Keyboard.COMMA)
         {
            this._yInput.setFocus();
         }
      }
      
      public function set _selectCampType(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1999462250_selectCampType;
         if(_loc2_ !== param1)
         {
            this._1999462250_selectCampType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectCampType",_loc2_,param1));
         }
      }
      
      private function getArrivalTime(param1:Number) : String
      {
         return Utils.getLogTimeStr(new Date().getTime() - 700 + param1 * 1000);
      }
      
      [Bindable(event="propertyChange")]
      private function get selectedHero() : HeroBean
      {
         return this._1754828491selectedHero;
      }
      
      [Bindable(event="propertyChange")]
      public function get _applyWarEnsign() : CheckBox
      {
         return this._1244701377_applyWarEnsign;
      }
      
      public function ___NewArmyWin_Label26_click(param1:MouseEvent) : void
      {
         this._showInt.selected = !this._showInt.selected;
         this.onChangeHeroFilter();
      }
      
      private function updateResourceInfo() : void
      {
         if(this.resource == null)
         {
            this.resource = new ResourceBean();
         }
         var _loc1_:CastleResourceBean = this.selectedCity.cityManager.resource;
         this.resource.gold = _loc1_.gold;
         this.resource.food = _loc1_.food.amount;
         this.resource.wood = _loc1_.wood.amount;
         this.resource.stone = _loc1_.stone.amount;
         this.resource.iron = _loc1_.iron.amount;
         _loc1_ = null;
      }
      
      public function ___applyStygandrsBannerOfTheHorde_change(param1:Event) : void
      {
         this.updateMaxDispatchLimit();
      }
      
      internal function onMinBtn(param1:TextInput) : void
      {
         param1.text = "" + 0;
         param1.setFocus();
         if(param1.id == "tInput")
         {
            this.postTroopChange();
         }
      }
      
      public function set _selectHero(param1:ComboBox) : void
      {
         var _loc2_:Object = this._568004427_selectHero;
         if(_loc2_ !== param1)
         {
            this._568004427_selectHero = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectHero",_loc2_,param1));
         }
      }
      
      public function set _inputCampTimeSec(param1:TextInput) : void
      {
         var _loc2_:Object = this._1882510152_inputCampTimeSec;
         if(_loc2_ !== param1)
         {
            this._1882510152_inputCampTimeSec = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputCampTimeSec",_loc2_,param1));
         }
      }
      
      public function set _inputCampTimeMin(param1:TextInput) : void
      {
         var _loc2_:Object = this._1882515783_inputCampTimeMin;
         if(_loc2_ !== param1)
         {
            this._1882515783_inputCampTimeMin = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputCampTimeMin",_loc2_,param1));
         }
      }
      
      public function ___NewArmyWin_Button3_click(param1:MouseEvent) : void
      {
         this.onDeleteTroopCfg();
      }
      
      [Bindable(event="propertyChange")]
      public function get _applyStygandrsBannerOfTheHordeLabel() : Label
      {
         return this._252657020_applyStygandrsBannerOfTheHordeLabel;
      }
      
      [Bindable(event="propertyChange")]
      private function get availableRallySlots() : int
      {
         return this._876583532availableRallySlots;
      }
      
      public function set _showPol(param1:CheckBox) : void
      {
         var _loc2_:Object = this._130533585_showPol;
         if(_loc2_ !== param1)
         {
            this._130533585_showPol = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showPol",_loc2_,param1));
         }
      }
      
      private function getCityIdInfo(param1:int) : String
      {
         var _loc2_:String = MainScreen.getCityFromFieldId(param1).castle.name;
         return (_loc2_.length > 15 ? _loc2_.substr(0,16) : _loc2_) + Map.fieldIdToCoordString(param1);
      }
      
      internal function onViewArmyBtn(param1:Object) : void
      {
         MainScreen.getInstance()._cityPanel._onViewArmyBtn(this.castleId,param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputCata() : TroopInput
      {
         return this._816969280_tInputCata;
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectMissionType() : ComboBox
      {
         return this._1592359477_selectMissionType;
      }
      
      [Bindable(event="propertyChange")]
      private function get foodNeeded() : Number
      {
         return this._564559437foodNeeded;
      }
      
      [Bindable(event="propertyChange")]
      public function get _showHH() : CheckBox
      {
         return this._1805325788_showHH;
      }
      
      public function set _applyWarEnsignLabel(param1:Label) : void
      {
         var _loc2_:Object = this._1239375627_applyWarEnsignLabel;
         if(_loc2_ !== param1)
         {
            this._1239375627_applyWarEnsignLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_applyWarEnsignLabel",_loc2_,param1));
         }
      }
      
      private function close() : void
      {
         this.armiesUpdateTimer.stop();
         this.armiesUpdateTimer.removeEventListener(TimerEvent.TIMER,this.updateLocalArmiesData);
         this.armiesUpdateTimer = null;
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.onSelfArmiesUpdate);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_RESOURCE_UPDATE,this.onResourceUpdate);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.onHeroUpdate);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
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
         this.closeFunc.apply(null,[this]);
      }
      
      [Bindable(event="propertyChange")]
      public function get _availRallySlots() : Label
      {
         return this._1706017285_availRallySlots;
      }
      
      public function ___NewArmyWin_Label25_click(param1:MouseEvent) : void
      {
         this._showAtk.selected = !this._showAtk.selected;
         this.onChangeHeroFilter();
      }
      
      private function updateAvailableRallySlots() : void
      {
         this.availableRallySlots = this.selectedCity.cityManager.getMaxRallySlots() - this.selectedCity.cityManager.getUsedRallySlots();
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputA() : TroopInput
      {
         return this._129437196_tInputA;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputC() : TroopInput
      {
         return this._129437198_tInputC;
      }
      
      private function set travelTime(param1:Number) : void
      {
         var _loc2_:Object = this._681912583travelTime;
         if(_loc2_ !== param1)
         {
            this._681912583travelTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"travelTime",_loc2_,param1));
         }
      }
      
      private function moveCursorToEnd(param1:TextInput) : void
      {
         var txtCtrl:TextInput = param1;
         Utils.callLater(50,function():void
         {
            var _loc1_:int = txtCtrl.text.length;
            if(txtCtrl.selectionEndIndex != _loc1_ || txtCtrl.selectionBeginIndex != _loc1_)
            {
               txtCtrl.selectionEndIndex = txtCtrl.selectionBeginIndex = _loc1_;
            }
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputP() : TroopInput
      {
         return this._129437211_tInputP;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputR() : TroopInput
      {
         return this._129437213_tInputR;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputS() : TroopInput
      {
         return this._129437214_tInputS;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputT() : TroopInput
      {
         return this._129437215_tInputT;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputSw() : TroopInput
      {
         return this._282413543_tInputSw;
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputB() : TroopInput
      {
         return this._129437197_tInputB;
      }
      
      private function set missionTypeArray(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._991165677missionTypeArray;
         if(_loc2_ !== param1)
         {
            this._991165677missionTypeArray = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"missionTypeArray",_loc2_,param1));
         }
      }
      
      private function set localArmiesData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2087571216localArmiesData;
         if(_loc2_ !== param1)
         {
            this._2087571216localArmiesData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"localArmiesData",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputW() : TroopInput
      {
         return this._129437218_tInputW;
      }
      
      private function getMax(param1:TextInput) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(param1.id == "tInput")
         {
            _loc2_ = 0;
            _loc3_ = 0;
            if(param1 != this._tInputWo.tInput)
            {
               _loc2_ += int(this._tInputWo.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.peasants;
            }
            if(param1 != this._tInputW.tInput)
            {
               _loc2_ += int(this._tInputW.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.militia;
            }
            if(param1 != this._tInputS.tInput)
            {
               _loc2_ += int(this._tInputS.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.scouter;
            }
            if(param1 != this._tInputP.tInput)
            {
               _loc2_ += int(this._tInputP.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.pikemen;
            }
            if(param1 != this._tInputSw.tInput)
            {
               _loc2_ += int(this._tInputSw.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.swordsmen;
            }
            if(param1 != this._tInputA.tInput)
            {
               _loc2_ += int(this._tInputA.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.archer;
            }
            if(param1 != this._tInputC.tInput)
            {
               _loc2_ += int(this._tInputC.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.lightCavalry;
            }
            if(param1 != this._tInputCata.tInput)
            {
               _loc2_ += int(this._tInputCata.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.heavyCavalry;
            }
            if(param1 != this._tInputT.tInput)
            {
               _loc2_ += int(this._tInputT.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.carriage;
            }
            if(param1 != this._tInputB.tInput)
            {
               _loc2_ += int(this._tInputB.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.ballista;
            }
            if(param1 != this._tInputR.tInput)
            {
               _loc2_ += int(this._tInputR.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.batteringRam;
            }
            if(param1 != this._tInputCp.tInput)
            {
               _loc2_ += int(this._tInputCp.tInput.text);
            }
            else
            {
               _loc3_ = this.troop.catapult;
            }
            return Math.floor(Math.min(_loc3_ < 0 ? _loc3_ * -1 : _loc3_,this.maxDispatchLimit - _loc2_));
         }
         if(param1.id == "rInput")
         {
            _loc4_ = 0;
            _loc5_ = 0;
            if(param1 != this._rInputG.rInput)
            {
               _loc4_ += Number(this._rInputG.rInput.text) > 0 ? Number(this._rInputG.rInput.text) : 0;
            }
            else
            {
               _loc5_ = this.resource.gold;
            }
            if(param1 != this._rInputF.rInput)
            {
               _loc4_ += Number(this._rInputF.rInput.text) > 0 ? Number(this._rInputF.rInput.text) : 0;
            }
            else
            {
               _loc5_ = this.resource.food - (this.foodNeeded + this.foodNeeded * 1.15);
            }
            if(param1 != this._rInputW.rInput)
            {
               _loc4_ += Number(this._rInputW.rInput.text) > 0 ? Number(this._rInputW.rInput.text) : 0;
            }
            else
            {
               _loc5_ = this.resource.wood;
            }
            if(param1 != this._rInputS.rInput)
            {
               _loc4_ += Number(this._rInputS.rInput.text) > 0 ? Number(this._rInputS.rInput.text) : 0;
            }
            else
            {
               _loc5_ = this.resource.stone;
            }
            if(param1 != this._rInputI.rInput)
            {
               _loc4_ += Number(this._rInputI.rInput.text) > 0 ? Number(this._rInputI.rInput.text) : 0;
            }
            else
            {
               _loc5_ = this.resource.iron;
            }
            return Math.floor(Math.min(_loc5_,this.loadCapacity - _loc4_ > 0 ? this.loadCapacity - _loc4_ : 0));
         }
         return 0;
      }
      
      public function set _selectTroopCfgName(param1:ComboBox) : void
      {
         var _loc2_:Object = this._2075147496_selectTroopCfgName;
         if(_loc2_ !== param1)
         {
            this._2075147496_selectTroopCfgName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectTroopCfgName",_loc2_,param1));
         }
      }
      
      private function onResourceUpdate(param1:ResourceUpdate = null) : void
      {
         if(param1.castleId == this.castleId)
         {
            Utils.callLater(100,this.updateResourceInfo);
         }
      }
      
      private function onLoadTroopCfg() : void
      {
         if(this._selectTroopCfgName.selectedItem.label == "none")
         {
            return;
         }
         var _loc1_:String = this._selectTroopCfgName.selectedItem.troopCfg;
         var _loc2_:TroopBean = Utils.getTroops(_loc1_);
         this._tInputWo.tInput.text = "" + _loc2_.peasants;
         this._tInputW.tInput.text = "" + _loc2_.militia;
         this._tInputS.tInput.text = "" + _loc2_.scouter;
         this._tInputP.tInput.text = "" + _loc2_.pikemen;
         this._tInputSw.tInput.text = "" + _loc2_.swordsmen;
         this._tInputA.tInput.text = "" + _loc2_.archer;
         this._tInputC.tInput.text = "" + _loc2_.lightCavalry;
         this._tInputCata.tInput.text = "" + _loc2_.heavyCavalry;
         this._tInputT.tInput.text = "" + _loc2_.carriage;
         this._tInputB.tInput.text = "" + _loc2_.ballista;
         this._tInputR.tInput.text = "" + _loc2_.batteringRam;
         this._tInputCp.tInput.text = "" + _loc2_.catapult;
         this.postTroopChange();
      }
      
      public function set _showAtk(param1:CheckBox) : void
      {
         var _loc2_:Object = this._130519324_showAtk;
         if(_loc2_ !== param1)
         {
            this._130519324_showAtk = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showAtk",_loc2_,param1));
         }
      }
      
      private function onDeleteTroopCfg(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(this._selectTroopCfgName.selectedItem.label == "none")
         {
            return;
         }
         if(!param1 && param2)
         {
            return;
         }
         if(!param2)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to permanently delete this saved troop configuration?",this.onDeleteTroopCfg,"Yes","No",[true]));
            return;
         }
         this.savedTroopCfg.removeItemAt(this._selectTroopCfgName.selectedIndex);
         var _loc3_:SharedObject = SharedObject.getLocal("newArmyTroopCfgs");
         _loc3_.data.now = this.savedTroopCfg.toArray();
         _loc3_.flush();
         this._selectTroopCfgName.selectedIndex = 0;
      }
      
      public function ___NewArmyWin_Button2_click(param1:MouseEvent) : void
      {
         this.onSaveTroopCfg();
      }
      
      internal function onTroopChange(param1:TextInput) : void
      {
         var _loc2_:int = 0;
         param1.text = "" + int(param1.text);
         if(int(param1.text) == 0)
         {
            this.moveCursorToEnd(param1);
         }
         else if(int(param1.text) < 0)
         {
            param1.text = "" + 0;
            this.moveCursorToEnd(param1);
         }
         else
         {
            _loc2_ = this.getMax(param1);
            if(int(param1.text) > _loc2_)
            {
               param1.text = "" + _loc2_;
            }
         }
         this.postTroopChange();
      }
      
      private function getLoadCapacity(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:String, param10:String, param11:String, param12:String) : Number
      {
         var _loc13_:TroopBean = new TroopBean();
         _loc13_.peasants = int(param1);
         _loc13_.militia = int(param2);
         _loc13_.scouter = int(param3);
         _loc13_.pikemen = int(param4);
         _loc13_.swordsmen = int(param5);
         _loc13_.archer = int(param6);
         _loc13_.lightCavalry = int(param7);
         _loc13_.heavyCavalry = int(param8);
         _loc13_.carriage = int(param9);
         _loc13_.ballista = int(param10);
         _loc13_.batteringRam = int(param11);
         _loc13_.catapult = int(param12);
         return this.loadCapacity = this.selectedCity.cityManager.getMaxTroopLoad(_loc13_);
      }
      
      public function ___deployBtn_click(param1:MouseEvent) : void
      {
         this.onDeployBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get _showLH() : CheckBox
      {
         return this._1805325912_showLH;
      }
      
      public function ___selectHero_change(param1:ListEvent) : void
      {
         this.updateSelectedhero();
      }
      
      private function set selectedHero(param1:HeroBean) : void
      {
         var _loc2_:Object = this._1754828491selectedHero;
         if(_loc2_ !== param1)
         {
            this._1754828491selectedHero = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"selectedHero",_loc2_,param1));
         }
      }
      
      private function setFreeHeros() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:HeroBean = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc5_:String = "";
         var _loc6_:int = this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_SEND ? 1 : (this._selectMissionType.selectedItem.data == ObjConstants.ARMY_MISSION_TRANS ? 2 : 4);
         this.heros.removeAll();
         for each(_loc7_ in this.selectedCity.cityManager.heroes)
         {
            if(!(_loc7_.stamina < _loc6_ || !this._showHH.selected && _loc7_.isHero == 1 || !this._showLH.selected && _loc7_.isHero == 4))
            {
               if(_loc7_.isHero != 2)
               {
                  _loc1_ = _loc7_.politics == _loc7_.intelligence && _loc7_.politics == _loc7_.attack;
                  if(!this._showPol.selected && (!_loc1_ && _loc7_.politics >= Math.max(_loc7_.intelligence,_loc7_.attack) || _loc1_ && _loc7_.management >= Math.max(_loc7_.stratagem,_loc7_.power)))
                  {
                     continue;
                  }
                  if(!this._showAtk.selected && (!_loc1_ && _loc7_.attack >= Math.max(_loc7_.politics,_loc7_.intelligence) || _loc1_ && _loc7_.power >= Math.max(_loc7_.management,_loc7_.stratagem)))
                  {
                     continue;
                  }
                  if(!this._showInt.selected && (!_loc1_ && _loc7_.intelligence >= Math.max(_loc7_.politics,_loc7_.attack) || _loc1_ && _loc7_.stratagem >= Math.max(_loc7_.management,_loc7_.power)))
                  {
                     continue;
                  }
               }
               if(_loc7_.status == HeroConstants.HERO_FREE_STATU)
               {
                  _loc5_ = _loc7_.name + " (" + _loc7_.level + ") " + Math.round(Utils.getTotalPointsForHeroAttribute(_loc7_,"management")) + "/" + Math.round(_loc3_ = Utils.getTotalPointsForHeroAttribute(_loc7_,"power")) + "/" + Math.round(_loc4_ = Utils.getTotalPointsForHeroAttribute(_loc7_,"stratagem"));
                  if(this.heros.length == 0)
                  {
                     this.heros.addItem({
                        "label":_loc5_,
                        "heroBean":_loc7_
                     });
                  }
                  else if(_loc7_.isHero == 2)
                  {
                     this.heros.addItemAt({
                        "label":_loc5_,
                        "heroBean":_loc7_
                     },0);
                  }
                  else
                  {
                     _loc2_ = 0;
                     for each(_loc9_ in this.heros)
                     {
                        if((_loc9_.heroBean as HeroBean).isHero != 2 && (_loc7_.level > (_loc9_.heroBean as HeroBean).level || _loc7_.level == (_loc9_.heroBean as HeroBean).level && (_loc3_ > Utils.getTotalPointsForHeroAttribute(_loc9_.heroBean as HeroBean,"power") || _loc3_ == Utils.getTotalPointsForHeroAttribute(_loc9_.heroBean as HeroBean,"power") && _loc4_ >= Utils.getTotalPointsForHeroAttribute(_loc9_.heroBean as HeroBean,"stratagem"))))
                        {
                           break;
                        }
                        _loc2_++;
                     }
                     this.heros.addItemAt({
                        "label":_loc5_,
                        "heroBean":_loc7_
                     },_loc2_);
                  }
               }
            }
         }
         _loc8_ = int(this._selectMissionType.selectedItem.data);
         if(_loc8_ == ObjConstants.ARMY_MISSION_TRANS || _loc8_ == ObjConstants.ARMY_MISSION_SEND || _loc8_ == ObjConstants.ARMY_MISSION_SCOUT)
         {
            this.heros.addItemAt({
               "label":this.emptyHero.name,
               "heroBean":this.emptyHero
            },0);
         }
         if(this.heros.length > 1 && this.selectedHero != null)
         {
            _loc2_ = 0;
            for each(_loc9_ in this.heros)
            {
               if((_loc9_.heroBean as HeroBean).id == this.selectedHero.id)
               {
                  this._selectHero.selectedIndex = _loc2_;
                  return;
               }
               _loc2_++;
            }
         }
         this._selectHero.selectedIndex = 0;
         this.updateSelectedhero();
      }
      
      private function _NewArmyWin_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "View";
         _loc1_.dataField = "col5";
         _loc1_.width = 57;
         _loc1_.itemRenderer = this._NewArmyWin_ClassFactory2_i();
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _showInt() : CheckBox
      {
         return this._130526835_showInt;
      }
      
      [Bindable(event="propertyChange")]
      public function get _deployBtn() : Button
      {
         return this._1898746486_deployBtn;
      }
      
      public function set _applyWarEnsign(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1244701377_applyWarEnsign;
         if(_loc2_ !== param1)
         {
            this._1244701377_applyWarEnsign = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_applyWarEnsign",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _tInputWo() : TroopInput
      {
         return this._282413427_tInputWo;
      }
      
      public function ___applyWarEnsign_change(param1:Event) : void
      {
         this.updateMaxDispatchLimit();
      }
      
      private function onClearTroopInputBtn() : void
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
      
      public function ___selectTroopCfgName_change(param1:ListEvent) : void
      {
         this.onLoadTroopCfg();
      }
      
      private function saveMissionInfo() : void
      {
         newArmyViewCfg[this.ctyInd].target = Map.coordStringToFieldId(this._xInput.text + "," + this._yInput.text);
         newArmyViewCfg[this.ctyInd].quickTarget = this._selectQuickCoords.selectedIndex != 0 ? this._selectQuickCoords.selectedItem.data : -1;
         newArmyViewCfg[this.ctyInd].mission = this._selectMissionType.selectedItem.data;
         newArmyViewCfg[this.ctyInd].hero = this._selectHero.selectedItem != null && this._selectHero.selectedItem.heroBean.name != null && (this._selectHero.selectedItem.heroBean as HeroBean).name != this.emptyHero.name ? (this._selectHero.selectedItem.heroBean as HeroBean).id : -1;
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
      
      public function set _xInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1919807313_xInput;
         if(_loc2_ !== param1)
         {
            this._1919807313_xInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_xInput",_loc2_,param1));
         }
      }
      
      internal function onRecallSelfArmyBtn(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         this.selectedCity.cityManager.logMsg("Recall self army with armyId: " + param1);
         ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId,param1);
      }
      
      private function set troop(param1:TroopBean) : void
      {
         var _loc2_:Object = this._110634834troop;
         if(_loc2_ !== param1)
         {
            this._110634834troop = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troop",_loc2_,param1));
         }
      }
      
      private function get selectedCity() : CityState
      {
         return MainScreen.getCityFromCastleId(this.castleId);
      }
      
      public function set _selectQuickCoords(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1043134288_selectQuickCoords;
         if(_loc2_ !== param1)
         {
            this._1043134288_selectQuickCoords = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectQuickCoords",_loc2_,param1));
         }
      }
      
      private function setQuickCoords() : void
      {
         var _loc1_:CityState = null;
         for each(_loc1_ in MainScreen.getCities())
         {
            if(_loc1_.castle.fieldId != this.fieldId)
            {
               this.quickCoords.addItem({
                  "label":(_loc1_.castle.name.length > 3 ? _loc1_.castle.name.substr(0,3) : _loc1_.castle.name) + Map.fieldIdToCoordString(_loc1_.castle.fieldId),
                  "data":_loc1_.castle.fieldId
               });
            }
         }
      }
      
      private function updateTravelTime() : void
      {
         var _loc1_:int = Map.coordStringToFieldId(this._xInput.text + "," + this._yInput.text);
         var _loc2_:Number = this.selectedCity.cityManager.getBaseTravelTime(this.fieldId,_loc1_,this.selectedTroop);
         var _loc3_:int = int(this._selectMissionType.selectedItem.data);
         var _loc4_:int = (MainScreen.getCityFromFieldId(_loc1_) != null || Map.getType(_loc1_) == FieldConstants.TYPE_CASTLE && Map.getDetailInfo(_loc1_,30).allianceName != null && this.selectedCity.player.playerInfo.alliance != null && Map.getDetailInfo(_loc1_,30).allianceName == this.selectedCity.player.playerInfo.alliance) && (_loc3_ == ObjConstants.ARMY_MISSION_SEND || _loc3_ == ObjConstants.ARMY_MISSION_TRANS) ? this.selectedCity._getReliefStationSpeedupFactor() : 1;
         var _loc5_:Number = this._selectHero.selectedItem != null && this._selectHero.selectedItem.heroBean.name != null && this._selectHero.selectedItem.heroBean.name != this.emptyHero.name ? Utils.getHeroSpeedFactor(this._selectHero.selectedItem.heroBean) : 1;
         this.travelTime = _loc2_ / _loc4_ / _loc5_;
         this.updateCamptTime();
         this.updateFoodNeeded();
      }
      
      private function _NewArmyWin_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Action";
         _loc1_.dataField = "col4";
         _loc1_.width = 65;
         _loc1_.itemRenderer = this._NewArmyWin_ClassFactory1_i();
         return _loc1_;
      }
      
      private function set savedTroopCfg(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1684939609savedTroopCfg;
         if(_loc2_ !== param1)
         {
            this._1684939609savedTroopCfg = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"savedTroopCfg",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputCampTimeMin() : TextInput
      {
         return this._1882515783_inputCampTimeMin;
      }
      
      public function ___yInput_change(param1:Event) : void
      {
         this.onCoordChange(param1.currentTarget as TextInput);
      }
      
      public function ___NewArmyWin_Label24_click(param1:MouseEvent) : void
      {
         this._showPol.selected = !this._showPol.selected;
         this.onChangeHeroFilter();
      }
      
      private function _NewArmyWin_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Remain time";
         _loc1_.dataField = "col3";
         _loc1_.width = 90;
         return _loc1_;
      }
      
      public function set _applyStygandrsBannerOfTheHordeLabel(param1:Label) : void
      {
         var _loc2_:Object = this._252657020_applyStygandrsBannerOfTheHordeLabel;
         if(_loc2_ !== param1)
         {
            this._252657020_applyStygandrsBannerOfTheHordeLabel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_applyStygandrsBannerOfTheHordeLabel",_loc2_,param1));
         }
      }
      
      public function ___showPol_change(param1:Event) : void
      {
         this.onChangeHeroFilter();
      }
      
      public function ___NewArmyWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function set camptTime(param1:Number) : void
      {
         var _loc2_:Object = this._25601152camptTime;
         if(_loc2_ !== param1)
         {
            this._25601152camptTime = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"camptTime",_loc2_,param1));
         }
      }
      
      private function updateLocalArmiesData(param1:Object = null) : void
      {
         this.selectedCity.cityManager._populate_A_Tab(this.localArmiesData);
      }
      
      [Bindable(event="propertyChange")]
      private function get localArmiesData() : ArrayCollection
      {
         return this._2087571216localArmiesData;
      }
      
      [Bindable(event="propertyChange")]
      private function get missionTypeArray() : ArrayCollection
      {
         return this._991165677missionTypeArray;
      }
      
      private function _NewArmyWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getCityIdInfo(this.fieldId);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Text1.text = param1;
         },"_NewArmyWin_Text1.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.maxDispatchLimit - int(this._tInputWo.tInput.text) - int(this._tInputW.tInput.text) - int(this._tInputS.tInput.text) - int(this._tInputP.tInput.text) - int(this._tInputSw.tInput.text) - int(this._tInputA.tInput.text) - int(this._tInputC.tInput.text) - int(this._tInputCata.tInput.text) - int(this._tInputT.tInput.text) - int(this._tInputB.tInput.text) - int(this._tInputR.tInput.text) - int(this._tInputCp.tInput.text)) + " / " + Utils.formatInt(this.maxDispatchLimit);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label2.text = param1;
         },"_NewArmyWin_Label2.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.availableRallySlots;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _availRallySlots.text = param1;
         },"_availRallySlots.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.peasants);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label7.text = param1;
         },"_NewArmyWin_Label7.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.militia);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label8.text = param1;
         },"_NewArmyWin_Label8.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.scouter);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label9.text = param1;
         },"_NewArmyWin_Label9.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.pikemen);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label10.text = param1;
         },"_NewArmyWin_Label10.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.swordsmen);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label11.text = param1;
         },"_NewArmyWin_Label11.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.archer);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label12.text = param1;
         },"_NewArmyWin_Label12.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.lightCavalry);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label13.text = param1;
         },"_NewArmyWin_Label13.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.heavyCavalry);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label14.text = param1;
         },"_NewArmyWin_Label14.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.carriage);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label15.text = param1;
         },"_NewArmyWin_Label15.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.ballista);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label16.text = param1;
         },"_NewArmyWin_Label16.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.batteringRam);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label17.text = param1;
         },"_NewArmyWin_Label17.text");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.troop.catapult);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label18.text = param1;
         },"_NewArmyWin_Label18.text");
         result[14] = binding;
         binding = new Binding(this,function():Object
         {
            return this.savedTroopCfg;
         },function(param1:Object):void
         {
            _selectTroopCfgName.dataProvider = param1;
         },"_selectTroopCfgName.dataProvider");
         result[15] = binding;
         binding = new Binding(this,function():Object
         {
            return this.quickCoords;
         },function(param1:Object):void
         {
            _selectQuickCoords.dataProvider = param1;
         },"_selectQuickCoords.dataProvider");
         result[16] = binding;
         binding = new Binding(this,function():Object
         {
            return this.missionTypeArray;
         },function(param1:Object):void
         {
            _selectMissionType.dataProvider = param1;
         },"_selectMissionType.dataProvider");
         result[17] = binding;
         binding = new Binding(this,function():Object
         {
            return this.heros;
         },function(param1:Object):void
         {
            _selectHero.dataProvider = param1;
         },"_selectHero.dataProvider");
         result[18] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.selectedHero != null && this.selectedHero.id != -1;
         },function(param1:Boolean):void
         {
            _NewArmyWin_Button4.visible = param1;
         },"_NewArmyWin_Button4.visible");
         result[19] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.selectedHero != null && this.selectedHero.id != -1;
         },function(param1:Boolean):void
         {
            _NewArmyWin_Button4.enabled = param1;
         },"_NewArmyWin_Button4.enabled");
         result[20] = binding;
         binding = new Binding(this,function():Object
         {
            return ["+ time","@ time"];
         },function(param1:Object):void
         {
            _selectCampType.dataProvider = param1;
         },"_selectCampType.dataProvider");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.loadCapacity - Number(this._rInputG.rInput.text) - Number(this._rInputF.rInput.text) - Number(this._rInputW.rInput.text) - Number(this._rInputS.rInput.text) - Number(this._rInputI.rInput.text),0) + " / " + Utils.formatNum(this.loadCapacity);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label32.text = param1;
         },"_NewArmyWin_Label32.text");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.resource.food,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label33.text = param1;
         },"_NewArmyWin_Label33.text");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.resource.wood,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label34.text = param1;
         },"_NewArmyWin_Label34.text");
         result[24] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.resource.stone,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label35.text = param1;
         },"_NewArmyWin_Label35.text");
         result[25] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.resource.iron,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label36.text = param1;
         },"_NewArmyWin_Label36.text");
         result[26] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.resource.gold,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label37.text = param1;
         },"_NewArmyWin_Label37.text");
         result[27] = binding;
         binding = new Binding(this,function():Object
         {
            return this.localArmiesData;
         },function(param1:Object):void
         {
            _NewArmyWin_RowColorDataGrid1.dataProvider = param1;
         },"_NewArmyWin_RowColorDataGrid1.dataProvider");
         result[28] = binding;
         binding = new Binding(this,function():Class
         {
            return NewArmy_inlineComponent0;
         },function(param1:Class):void
         {
            _NewArmyWin_ClassFactory1.generator = param1;
         },"_NewArmyWin_ClassFactory1.generator");
         result[29] = binding;
         binding = new Binding(this,function():Class
         {
            return NewArmy_inlineComponent1;
         },function(param1:Class):void
         {
            _NewArmyWin_ClassFactory2.generator = param1;
         },"_NewArmyWin_ClassFactory2.generator");
         result[30] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(Map.fieldDistance(this.fieldId,Map.getFieldId(int(this._xInput.text),int(this._yInput.text))),3);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label39.text = param1;
         },"_NewArmyWin_Label39.text");
         result[31] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this.foodNeeded,0);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label41.text = param1;
         },"_NewArmyWin_Label41.text");
         result[32] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatTime(this.travelTime + this.camptTime);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label43.text = param1;
         },"_NewArmyWin_Label43.text");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getArrivalTime(this.travelTime + this.camptTime);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _NewArmyWin_Label45.text = param1;
         },"_NewArmyWin_Label45.text");
         result[34] = binding;
         return result;
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectTroopCfgName() : ComboBox
      {
         return this._2075147496_selectTroopCfgName;
      }
      
      public function ___showInt_change(param1:Event) : void
      {
         this.onChangeHeroFilter();
      }
      
      public function set _rInputF(param1:ResourceInput) : void
      {
         var _loc2_:Object = this._1645570161_rInputF;
         if(_loc2_ !== param1)
         {
            this._1645570161_rInputF = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rInputF",_loc2_,param1));
         }
      }
      
      public function ___NewArmyWin_Button1_click(param1:MouseEvent) : void
      {
         this.onClearTroopInputBtn();
      }
      
      public function set _rInputG(param1:ResourceInput) : void
      {
         var _loc2_:Object = this._1645570160_rInputG;
         if(_loc2_ !== param1)
         {
            this._1645570160_rInputG = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rInputG",_loc2_,param1));
         }
      }
      
      public function set _rInputI(param1:ResourceInput) : void
      {
         var _loc2_:Object = this._1645570158_rInputI;
         if(_loc2_ !== param1)
         {
            this._1645570158_rInputI = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rInputI",_loc2_,param1));
         }
      }
      
      private function getNewArmy(param1:Boolean = true) : NewArmyParam
      {
         var _loc2_:NewArmyParam = new NewArmyParam();
         _loc2_.missionType = this._selectMissionType.selectedItem.data;
         _loc2_.targetPoint = Map.coordStringToFieldId(this._xInput.text + "," + this._yInput.text);
         if(this._selectHero.selectedItem != null && (this._selectHero.selectedItem.heroBean as HeroBean).id >= 0)
         {
            _loc2_.heroId = (this._selectHero.selectedItem.heroBean as HeroBean).id;
         }
         _loc2_.troops = this.selectedTroop;
         _loc2_.resource = new ResourceBean();
         if(param1)
         {
            _loc2_.resource.gold = Number(this._rInputG.rInput.text);
            _loc2_.resource.food = Number(this._rInputF.rInput.text);
            _loc2_.resource.wood = Number(this._rInputW.rInput.text);
            _loc2_.resource.stone = Number(this._rInputS.rInput.text);
            _loc2_.resource.iron = Number(this._rInputI.rInput.text);
         }
         _loc2_.restTime = this.camptTime;
         _loc2_.useFlag = this._applyWarEnsign.selected;
         _loc2_.useItem = this._applyStygandrsBannerOfTheHorde.selected;
         return _loc2_;
      }
      
      private function set availableRallySlots(param1:int) : void
      {
         var _loc2_:Object = this._876583532availableRallySlots;
         if(_loc2_ !== param1)
         {
            this._876583532availableRallySlots = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"availableRallySlots",_loc2_,param1));
         }
      }
      
      private function updateLoadCapacity() : void
      {
         this.loadCapacity = this.selectedCity.cityManager.getMaxTroopLoad(this.selectedTroop);
      }
      
      private function _NewArmyWin_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Target";
         _loc1_.dataField = "col2";
         _loc1_.width = 225;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      public function set _rInputS(param1:ResourceInput) : void
      {
         var _loc2_:Object = this._1645570148_rInputS;
         if(_loc2_ !== param1)
         {
            this._1645570148_rInputS = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rInputS",_loc2_,param1));
         }
      }
      
      public function set _rInputW(param1:ResourceInput) : void
      {
         var _loc2_:Object = this._1645570144_rInputW;
         if(_loc2_ !== param1)
         {
            this._1645570144_rInputW = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_rInputW",_loc2_,param1));
         }
      }
      
      private function _NewArmyWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.getCityIdInfo(this.fieldId);
         _loc1_ = Utils.formatInt(this.maxDispatchLimit - int(this._tInputWo.tInput.text) - int(this._tInputW.tInput.text) - int(this._tInputS.tInput.text) - int(this._tInputP.tInput.text) - int(this._tInputSw.tInput.text) - int(this._tInputA.tInput.text) - int(this._tInputC.tInput.text) - int(this._tInputCata.tInput.text) - int(this._tInputT.tInput.text) - int(this._tInputB.tInput.text) - int(this._tInputR.tInput.text) - int(this._tInputCp.tInput.text)) + " / " + Utils.formatInt(this.maxDispatchLimit);
         _loc1_ = this.availableRallySlots;
         _loc1_ = Utils.formatInt(this.troop.peasants);
         _loc1_ = Utils.formatInt(this.troop.militia);
         _loc1_ = Utils.formatInt(this.troop.scouter);
         _loc1_ = Utils.formatInt(this.troop.pikemen);
         _loc1_ = Utils.formatInt(this.troop.swordsmen);
         _loc1_ = Utils.formatInt(this.troop.archer);
         _loc1_ = Utils.formatInt(this.troop.lightCavalry);
         _loc1_ = Utils.formatInt(this.troop.heavyCavalry);
         _loc1_ = Utils.formatInt(this.troop.carriage);
         _loc1_ = Utils.formatInt(this.troop.ballista);
         _loc1_ = Utils.formatInt(this.troop.batteringRam);
         _loc1_ = Utils.formatInt(this.troop.catapult);
         _loc1_ = this.savedTroopCfg;
         _loc1_ = this.quickCoords;
         _loc1_ = this.missionTypeArray;
         _loc1_ = this.heros;
         _loc1_ = this.selectedHero != null && this.selectedHero.id != -1;
         _loc1_ = this.selectedHero != null && this.selectedHero.id != -1;
         _loc1_ = ["+ time","@ time"];
         _loc1_ = Utils.formatNum(this.loadCapacity - Number(this._rInputG.rInput.text) - Number(this._rInputF.rInput.text) - Number(this._rInputW.rInput.text) - Number(this._rInputS.rInput.text) - Number(this._rInputI.rInput.text),0) + " / " + Utils.formatNum(this.loadCapacity);
         _loc1_ = Utils.formatNum(this.resource.food,0);
         _loc1_ = Utils.formatNum(this.resource.wood,0);
         _loc1_ = Utils.formatNum(this.resource.stone,0);
         _loc1_ = Utils.formatNum(this.resource.iron,0);
         _loc1_ = Utils.formatNum(this.resource.gold,0);
         _loc1_ = this.localArmiesData;
         _loc1_ = NewArmy_inlineComponent0;
         _loc1_ = NewArmy_inlineComponent1;
         _loc1_ = Utils.formatNum(Map.fieldDistance(this.fieldId,Map.getFieldId(int(this._xInput.text),int(this._yInput.text))),3);
         _loc1_ = Utils.formatNum(this.foodNeeded,0);
         _loc1_ = Utils.formatTime(this.travelTime + this.camptTime);
         _loc1_ = this.getArrivalTime(this.travelTime + this.camptTime);
      }
      
      private function updateMaxDispatchLimit() : void
      {
         this.maxDispatchLimit = this.selectedCity.cityManager.getRallyDispatchPerArmyLimit(true) * (this._applyWarEnsign.enabled && this._applyWarEnsign.selected ? 1.25 : 1) * (this._applyStygandrsBannerOfTheHorde.enabled && this._applyStygandrsBannerOfTheHorde.selected ? 10 : 1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _selectQuickCoords() : ComboBox
      {
         return this._1043134288_selectQuickCoords;
      }
      
      [Bindable(event="propertyChange")]
      public function get _xInput() : TextInput
      {
         return this._1919807313_xInput;
      }
      
      [Bindable(event="propertyChange")]
      private function get troop() : TroopBean
      {
         return this._110634834troop;
      }
      
      public function ___showHH_change(param1:Event) : void
      {
         this.onChangeHeroFilter();
      }
      
      public function ___selectCampType_change(param1:ListEvent) : void
      {
         this.onChangeCampType();
      }
      
      public function ___NewArmyWin_Button6_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function updateFoodNeeded() : void
      {
         this.foodNeeded = this.selectedCity.cityManager.getFoodNeededToMarch(this.getNewArmy(false));
      }
      
      private function updateEnableApplyWarEnsignAndBanner() : void
      {
         var _loc3_:ItemBean = null;
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         for each(_loc3_ in MainScreen.getPlayer().itemsArray)
         {
            if(_loc3_.id == "player.troop.1.a" && _loc3_.count > 0)
            {
               _loc1_ = true;
            }
            if(_loc3_.id == "player.item.stygandrsbannerofthehorde" && _loc3_.count > 0)
            {
               _loc2_ = true;
            }
         }
         if(!_loc1_)
         {
            this._applyWarEnsign.selected = false;
            this._applyWarEnsign.enabled = false;
            this._applyWarEnsignLabel.enabled = false;
         }
         else
         {
            this._applyWarEnsign.enabled = true;
            this._applyWarEnsignLabel.enabled = true;
         }
         if(!_loc2_)
         {
            this._applyStygandrsBannerOfTheHorde.selected = false;
            this._applyStygandrsBannerOfTheHorde.enabled = false;
            this._applyStygandrsBannerOfTheHordeLabel.enabled = false;
         }
         else
         {
            this._applyStygandrsBannerOfTheHorde.enabled = true;
            this._applyStygandrsBannerOfTheHordeLabel.enabled = true;
         }
         this.updateMaxDispatchLimit();
      }
      
      [Bindable(event="propertyChange")]
      private function get savedTroopCfg() : ArrayCollection
      {
         return this._1684939609savedTroopCfg;
      }
      
      private function set foodNeeded(param1:Number) : void
      {
         var _loc2_:Object = this._564559437foodNeeded;
         if(_loc2_ !== param1)
         {
            this._564559437foodNeeded = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"foodNeeded",_loc2_,param1));
         }
      }
      
      public function ___showLH_change(param1:Event) : void
      {
         this.onChangeHeroFilter();
      }
      
      private function set fieldId(param1:int) : void
      {
         var _loc2_:Object = this._861252683fieldId;
         if(_loc2_ !== param1)
         {
            this._861252683fieldId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fieldId",_loc2_,param1));
         }
      }
      
      private function _NewArmyWin_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Army";
         _loc1_.dataField = "col1";
         _loc1_.width = 95;
         return _loc1_;
      }
      
      private function set heros(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._99168185heros;
         if(_loc2_ !== param1)
         {
            this._99168185heros = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heros",_loc2_,param1));
         }
      }
      
      public function ___NewArmyWin_Label23_click(param1:MouseEvent) : void
      {
         this._showLH.selected = !this._showLH.selected;
         this.onChangeHeroFilter();
      }
      
      public function set _tInputCata(param1:TroopInput) : void
      {
         var _loc2_:Object = this._816969280_tInputCata;
         if(_loc2_ !== param1)
         {
            this._816969280_tInputCata = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_tInputCata",_loc2_,param1));
         }
      }
      
      public function set _inputCampTimeHr(param1:TextInput) : void
      {
         var _loc2_:Object = this._77820867_inputCampTimeHr;
         if(_loc2_ !== param1)
         {
            this._77820867_inputCampTimeHr = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputCampTimeHr",_loc2_,param1));
         }
      }
      
      private function set loadCapacity(param1:Number) : void
      {
         var _loc2_:Object = this._1215952832loadCapacity;
         if(_loc2_ !== param1)
         {
            this._1215952832loadCapacity = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"loadCapacity",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _rInputF() : ResourceInput
      {
         return this._1645570161_rInputF;
      }
      
      [Bindable(event="propertyChange")]
      public function get _rInputG() : ResourceInput
      {
         return this._1645570160_rInputG;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:NewArmyWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._NewArmyWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_newarmy_NewArmyWinWatcherSetupUtil");
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
      public function get _rInputI() : ResourceInput
      {
         return this._1645570158_rInputI;
      }
      
      [Bindable(event="propertyChange")]
      public function get _rInputS() : ResourceInput
      {
         return this._1645570148_rInputS;
      }
      
      internal function onResoChange(param1:TextInput) : void
      {
         var _loc2_:Number = NaN;
         param1.text = "" + Number(param1.text);
         if(Number(param1.text) == 0)
         {
            this.moveCursorToEnd(param1);
         }
         else if(Number(param1.text) < 0)
         {
            param1.text = "" + 0;
            this.moveCursorToEnd(param1);
         }
         else
         {
            _loc2_ = this.getMax(param1);
            if(Number(param1.text) > _loc2_)
            {
               param1.text = "" + _loc2_;
            }
         }
         this.updateResourceInfo();
      }
      
      [Bindable(event="propertyChange")]
      public function get _rInputW() : ResourceInput
      {
         return this._1645570144_rInputW;
      }
      
      [Bindable(event="propertyChange")]
      private function get camptTime() : Number
      {
         return this._25601152camptTime;
      }
      
      public function set _selectMissionType(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1592359477_selectMissionType;
         if(_loc2_ !== param1)
         {
            this._1592359477_selectMissionType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_selectMissionType",_loc2_,param1));
         }
      }
      
      public function ___selectQuickCoords_change(param1:ListEvent) : void
      {
         this.onQuickCoordsChange();
      }
      
      public function set _inputTroopCfgName(param1:TextInput) : void
      {
         var _loc2_:Object = this._1702837304_inputTroopCfgName;
         if(_loc2_ !== param1)
         {
            this._1702837304_inputTroopCfgName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputTroopCfgName",_loc2_,param1));
         }
      }
      
      private function onCoordChange(param1:TextInput) : void
      {
         var _loc2_:int = 0;
         param1.text = "" + int(param1.text);
         if(int(param1.text) == 0)
         {
            this.moveCursorToEnd(param1);
         }
         else if(int(param1.text) < 0)
         {
            param1.text = "" + 0;
            this.moveCursorToEnd(param1);
         }
         else
         {
            _loc2_ = MainScreen.getPlayer().mapSizeX - 1;
            if(int(param1.text) > _loc2_)
            {
               param1.text = "" + _loc2_;
            }
         }
         this._selectQuickCoords.selectedIndex = 0;
         this.updateTravelTime();
      }
      
      public function ___inputCampTimeMs_change(param1:Event) : void
      {
         this.onChangeCampTime(param1.currentTarget as TextInput);
      }
      
      [Bindable(event="propertyChange")]
      private function get fieldId() : int
      {
         return this._861252683fieldId;
      }
      
      public function set _showHH(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1805325788_showHH;
         if(_loc2_ !== param1)
         {
            this._1805325788_showHH = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showHH",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get heros() : ArrayCollection
      {
         return this._99168185heros;
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputCampTimeHr() : TextInput
      {
         return this._77820867_inputCampTimeHr;
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputTroopCfgName() : TextInput
      {
         return this._1702837304_inputTroopCfgName;
      }
      
      public function ___inputCampTimeHr_change(param1:Event) : void
      {
         this.onChangeCampTime(param1.currentTarget as TextInput);
      }
      
      private function onSaveTroopCfg() : void
      {
         var _loc4_:Object = null;
         var _loc5_:SharedObject = null;
         var _loc6_:* = null;
         if(this._inputTroopCfgName.text == "" || this._inputTroopCfgName.text.charAt(0) == " ")
         {
            return;
         }
         var _loc1_:String = Utils.troopBeanToString(this.selectedTroop);
         var _loc2_:String = this._inputTroopCfgName.text;
         var _loc3_:int = 0;
         for each(_loc4_ in this.savedTroopCfg)
         {
            if(_loc4_.label == _loc2_)
            {
               this.savedTroopCfg.removeItemAt(_loc3_);
               break;
            }
            _loc3_++;
         }
         this.savedTroopCfg.addItemAt({
            "label":_loc2_,
            "troopCfg":_loc1_
         },_loc3_);
         _loc5_ = SharedObject.getLocal("newArmyTroopCfgs");
         _loc5_.data.now = this.savedTroopCfg.toArray();
         this._selectTroopCfgName.selectedIndex = _loc3_;
         this._inputTroopCfgName.text = "";
         _loc6_ = "";
         if(_loc5_.flush() != SharedObjectFlushStatus.FLUSHED)
         {
            _loc6_ = "SAVING PROBLEM:  You may need to increase flash local storage.";
         }
         else
         {
            _loc6_ = "The troop configuration \'" + _loc2_ + "\' was saved successfully.";
         }
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,_loc6_));
      }
      
      [Bindable(event="propertyChange")]
      private function get loadCapacity() : Number
      {
         return this._1215952832loadCapacity;
      }
      
      public function ___inputCampTimeMin_change(param1:Event) : void
      {
         this.onChangeCampTime(param1.currentTarget as TextInput);
      }
      
      public function set _yInput(param1:TextInput) : void
      {
         var _loc2_:Object = this._1948436464_yInput;
         if(_loc2_ !== param1)
         {
            this._1948436464_yInput = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_yInput",_loc2_,param1));
         }
      }
      
      private function onChangeHeroFilter() : void
      {
         this.setFreeHeros();
      }
      
      private function onQuickCoordsChange() : void
      {
         if(this._selectQuickCoords.selectedIndex == 0)
         {
            return;
         }
         this._xInput.text = "" + Map.getX(this._selectQuickCoords.selectedItem.data);
         this._yInput.text = "" + Map.getY(this._selectQuickCoords.selectedItem.data);
         this.updateTravelTime();
      }
      
      [Bindable(event="propertyChange")]
      public function get _yInput() : TextInput
      {
         return this._1948436464_yInput;
      }
      
      public function set _availRallySlots(param1:Label) : void
      {
         var _loc2_:Object = this._1706017285_availRallySlots;
         if(_loc2_ !== param1)
         {
            this._1706017285_availRallySlots = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_availRallySlots",_loc2_,param1));
         }
      }
   }
}

