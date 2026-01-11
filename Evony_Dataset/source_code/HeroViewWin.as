package autoevony.gui.heroview
{
   import autoevony.common.GearType;
   import autoevony.common.Items;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.EquipmentBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.constants.EquipmentTech;
   import com.evony.common.constants.HeroConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.server.events.HeroUpdate;
   import com.evony.factory.ItemManager;
   import com.evony.util.ImageSmooth;
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
   import mx.controls.ComboBox;
   import mx.controls.DataGrid;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class HeroViewWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _239157743addIntPoints:int = 0;
      
      private var _199062930_gearSlot_Chest:ComboBox;
      
      private var castleId:int = 0;
      
      public var _HeroViewWin_Canvas5:Canvas;
      
      public var _HeroViewWin_Canvas7:Canvas;
      
      private var _1417811556_gearSlot_Shield:ComboBox;
      
      private var _185172081_gearSlot_RingR:ComboBox;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1660987701mountChangeOptions:ArrayCollection = new ArrayCollection([{
         "label":"off",
         "data":0
      },{
         "label":"on",
         "data":1
      }]);
      
      public var _HeroViewWin_Button10:Button;
      
      public var _HeroViewWin_Button11:Button;
      
      public var _HeroViewWin_Button12:Button;
      
      public var _HeroViewWin_Button13:Button;
      
      public var _HeroViewWin_Button14:Button;
      
      public var _HeroViewWin_Button15:Button;
      
      public var _HeroViewWin_Button16:Button;
      
      public var _HeroViewWin_Button17:Button;
      
      public var _HeroViewWin_Button18:Button;
      
      public var _HeroViewWin_Button19:Button;
      
      private var _189603962_gearSlot_Mount:ComboBox;
      
      public var _HeroViewWin_Label13:Label;
      
      public var _HeroViewWin_Label14:Label;
      
      public var _HeroViewWin_Label15:Label;
      
      public var _HeroViewWin_Label17:Label;
      
      public var _HeroViewWin_Label18:Label;
      
      public var _HeroViewWin_Label19:Label;
      
      public var _HeroViewWin_Label16:Label;
      
      private var _1530117294_gearSlot_Neck:ComboBox;
      
      private var _490062342addAtkPoints:int = 0;
      
      private var _1955904597slotChangeAllOptions:ArrayCollection = new ArrayCollection([{
         "label":"-- --",
         "data":0
      },{
         "label":"Pol",
         "data":EquipmentTech.POLITICS
      },{
         "label":"Atk",
         "data":EquipmentTech.ATTACK
      },{
         "label":"Int",
         "data":EquipmentTech.INTELLIGENCE
      }]);
      
      public var _HeroViewWin_Label20:Label;
      
      public var _HeroViewWin_Label21:Label;
      
      public var _HeroViewWin_Label22:Label;
      
      public var _HeroViewWin_Label23:Label;
      
      public var _HeroViewWin_Label24:Label;
      
      public var _HeroViewWin_Label25:Label;
      
      public var _HeroViewWin_Label26:Label;
      
      public var _HeroViewWin_Label27:Label;
      
      public var _HeroViewWin_Label28:Label;
      
      private var _1530478630_gearSlot_Back:ComboBox;
      
      private var pointArr:Array = [0,0.4,0.75,1,1.32,1.74,2.3,3.04,4.01,5.29,6.98,9.22,12.17,16.06,21.2,27.98];
      
      private var _1530296109_gearSlot_Head:ComboBox;
      
      public var _HeroViewWin_DataGrid1:DataGrid;
      
      public var _HeroViewWin_Text1:Text;
      
      public var _HeroViewWin_Text2:Text;
      
      public var _HeroViewWin_Text3:Text;
      
      public var _HeroViewWin_Text4:Text;
      
      public var _HeroViewWin_Text5:Text;
      
      public var _HeroViewWin_Text6:Text;
      
      public var _HeroViewWin_Text7:Text;
      
      public var _HeroViewWin_Text8:Text;
      
      public var _HeroViewWin_Text9:Text;
      
      private var _1684867889_oneClickChange:ComboBox;
      
      private var _528734990_heroIcon:Image;
      
      private var _1598388080slotChangeOptions:ArrayCollection = new ArrayCollection([{
         "label":"none",
         "data":0
      },{
         "label":"Pol",
         "data":EquipmentTech.POLITICS
      },{
         "label":"Atk",
         "data":EquipmentTech.ATTACK
      },{
         "label":"Int",
         "data":EquipmentTech.INTELLIGENCE
      }]);
      
      private var closeFunc:Function = null;
      
      private var isReleasing:Boolean = false;
      
      private var _196832018_changeMayorRecallBtn:Button;
      
      private var _180797203_gearSlot_Waist:ComboBox;
      
      private var _1876103794_gearSlot_CharmR:ComboBox;
      
      private var _1068688913addPolPoints:int = 0;
      
      private var _1916961226_fireReleaseBtn:Button;
      
      private var _1530355551_gearSlot_Feet:ComboBox;
      
      private var isFiring:Boolean = false;
      
      private var _1530176744_gearSlot_Legs:ComboBox;
      
      private var _3198970hero:HeroBean = null;
      
      private var _185172087_gearSlot_RingL:ComboBox;
      
      private var _386306150_inputNewHeroName:TextInput;
      
      private var _1115529603_heroView_ClassFactory0:ClassFactory;
      
      public var _HeroViewWin_Button3:Button;
      
      public var _HeroViewWin_Button4:Button;
      
      public var _HeroViewWin_Button5:Button;
      
      private var _271816895_renameBtn:Button;
      
      public var _HeroViewWin_Button7:Button;
      
      mx_internal var _watchers:Array = [];
      
      public var _HeroViewWin_Button9:Button;
      
      private var _825717997_gearSlot_Shoulder:ComboBox;
      
      private var _749805761_clearTextBtn:Button;
      
      private var _1876103800_gearSlot_CharmL:ComboBox;
      
      private var _180290756_gearSlot_Wrist:ComboBox;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      public var _HeroViewWin_Text10:Text;
      
      public var _HeroViewWin_Text11:Text;
      
      public var _HeroViewWin_Text12:Text;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":723,
               "height":490,
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
                     return {"windowTitle":"Hero View"};
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
                                 "width":390,
                                 "height":142,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_heroIcon",
                                    "events":{"complete":"___heroIcon_complete"},
                                    "stylesFactory":function():void
                                    {
                                       this.top = "3";
                                       this.left = "3";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":100,
                                          "width":100
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "106";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "y":10,
                                          "text":"Name: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                       this.top = "11";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_renameBtn",
                                    "events":{"click":"___renameBtn_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":275,
                                          "y":12,
                                          "width":16,
                                          "height":16,
                                          "toolTip":"Change hero name",
                                          "styleName":"editBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"_inputNewHeroName",
                                    "events":{
                                       "enter":"___inputNewHeroName_enter",
                                       "keyDown":"___inputNewHeroName_keyDown"
                                    },
                                    "stylesFactory":function():void
                                    {
                                       this.left = "158";
                                       this.top = "10";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":150,
                                          "height":22,
                                          "text":"",
                                          "maxChars":10,
                                          "restrict":"A-Za-z0-9",
                                          "visible":false,
                                          "styleName":"textInput"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_clearTextBtn",
                                    "events":{"click":"___clearTextBtn_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "287";
                                       this.top = "13";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":16,
                                          "height":16,
                                          "toolTip":"Clear text",
                                          "styleName":"clearTextBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "103";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":230,
                                          "height":2,
                                          "y":34,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "106";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "y":39,
                                          "text":"Level: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text2",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "y":39,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "103";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":230,
                                          "height":2,
                                          "y":60,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "106";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "y":65,
                                          "text":"Exp: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text3",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":20,
                                          "y":65,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button3",
                                    "events":{"click":"___HeroViewWin_Button3_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "10";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":10,
                                          "label":"Info",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button4",
                                    "events":{"click":"___HeroViewWin_Button4_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":275,
                                          "y":40,
                                          "width":16,
                                          "height":16,
                                          "styleName":"REaddAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button5",
                                    "events":{"click":"___HeroViewWin_Button5_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "52";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":69,
                                          "height":12,
                                          "width":12,
                                          "styleName":"REaddBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_fireReleaseBtn",
                                    "events":{"click":"___fireReleaseBtn_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "16";
                                       this.top = "110";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"REwinBtn"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button7",
                                    "events":{"click":"___HeroViewWin_Button7_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "123";
                                       this.top = "110";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Persuade",
                                          "toolTip":"Click to persuade this hero.",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_changeMayorRecallBtn",
                                    "events":{"click":"___changeMayorRecallBtn_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "16";
                                       this.top = "110";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"REwinBtn"};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "0";
                              this.top = "145";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":390,
                                 "height":153,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "5";
                                       this.left = "3";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "text":"Politics: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text4",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "65";
                                       this.top = "5";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":100,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button9",
                                    "events":{"click":"___HeroViewWin_Button9_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":6,
                                          "styleName":"REaddAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button10",
                                    "events":{"click":"___HeroViewWin_Button10_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "180";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":6,
                                          "styleName":"REsubAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "0";
                                       this.top = "26";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "31";
                                       this.left = "3";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "text":"Attack: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text5",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "65";
                                       this.top = "31";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":100,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button11",
                                    "events":{"click":"___HeroViewWin_Button11_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":32,
                                          "styleName":"REaddAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button12",
                                    "events":{"click":"___HeroViewWin_Button12_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "180";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":32,
                                          "styleName":"REsubAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "0";
                                       this.top = "52";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "57";
                                       this.left = "3";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "text":"Intell: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text6",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "65";
                                       this.top = "57";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":100,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button13",
                                    "events":{"click":"___HeroViewWin_Button13_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "160";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":58,
                                          "styleName":"REaddAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button14",
                                    "events":{"click":"___HeroViewWin_Button14_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "180";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":16,
                                          "width":16,
                                          "y":58,
                                          "styleName":"REsubAttributeBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "0";
                                       this.top = "78";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "87";
                                       this.left = "3";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "text":"Remain: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text7",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "65";
                                       this.top = "87";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":100,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button15",
                                    "events":{"click":"___HeroViewWin_Button15_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "117";
                                       this.top = "85";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Redist",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button16",
                                    "events":{"click":"___HeroViewWin_Button16_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "16";
                                       this.bottom = "10";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Save",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button17",
                                    "events":{"click":"___HeroViewWin_Button17_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "95";
                                       this.bottom = "10";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Reset",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "5";
                                       this.right = "80";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "width":100,
                                          "text":"Loyalty: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text8",
                                    "stylesFactory":function():void
                                    {
                                       this.top = "5";
                                       this.right = "1";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":90,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button18",
                                    "events":{"click":"___HeroViewWin_Button18_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "12";
                                       this.top = "9";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":12,
                                          "height":12,
                                          "styleName":"REaddBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.right = "0";
                                       this.top = "26";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "31";
                                       this.right = "80";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "width":100,
                                          "text":"Energy: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text9",
                                    "stylesFactory":function():void
                                    {
                                       this.top = "31";
                                       this.right = "1";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":90,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_HeroViewWin_Button19",
                                    "events":{"click":"___HeroViewWin_Button19_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "12";
                                       this.top = "35";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":12,
                                          "height":12,
                                          "styleName":"REaddBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.right = "0";
                                       this.top = "52";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "57";
                                       this.right = "80";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "width":100,
                                          "text":"Leadership: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text10",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "1";
                                       this.top = "57";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":90,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.right = "0";
                                       this.top = "78";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "83";
                                       this.right = "80";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "width":100,
                                          "text":"Speed: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text11",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "1";
                                       this.top = "83";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":90,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.right = "0";
                                       this.top = "104";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":180,
                                          "height":2,
                                          "styleName":"horizontalSeparator2pxLine"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.top = "109";
                                       this.right = "80";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":24,
                                          "width":100,
                                          "text":"Salary: ",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_HeroViewWin_Text12",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "1";
                                       this.top = "109";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":90,
                                          "selectable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_HeroViewWin_Canvas5",
                           "stylesFactory":function():void
                           {
                              this.left = "0";
                              this.top = "301";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":390,
                                 "height":35,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___HeroViewWin_Button20_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "45";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "y":5,
                                          "label":"Award Item",
                                          "styleName":"REwinBtn"
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
                              this.top = "335";
                              this.bottom = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":390,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_HeroViewWin_DataGrid1",
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
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "columns":[_HeroViewWin_DataGridColumn1_c(),_HeroViewWin_DataGridColumn2_c()]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "id":"_HeroViewWin_Canvas7",
                           "stylesFactory":function():void
                           {
                              this.right = "0";
                              this.top = "0";
                              this.bottom = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":300,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_HeroViewWin_Image2",
                                    "events":{"complete":"___HeroViewWin_Image2_complete"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "x":27,
                                          "y":0
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label13",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "201";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":17,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Head",
                                    "events":{"change":"___gearSlot_Head_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "100";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":15,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label14",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":72,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Chest",
                                    "events":{"change":"___gearSlot_Chest_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":70,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label15",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":117,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Weapon",
                                    "events":{"change":"___gearSlot_Weapon_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":115,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label16",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":162,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Shield",
                                    "events":{"change":"___gearSlot_Shield_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":160,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label17",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":207,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Legs",
                                    "events":{"change":"___gearSlot_Legs_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":205,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label18",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":252,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_CharmL",
                                    "events":{"change":"___gearSlot_CharmL_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":250,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label19",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":292,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_RingL",
                                    "events":{"change":"___gearSlot_RingL_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":290,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label20",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "265";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":355,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Mount",
                                    "events":{"change":"___gearSlot_Mount_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "36";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":353,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label21",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":27,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Neck",
                                    "events":{"change":"___gearSlot_Neck_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":25,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label22",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":72,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Shoulder",
                                    "events":{"change":"___gearSlot_Shoulder_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":70,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label23",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":117,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Back",
                                    "events":{"change":"___gearSlot_Back_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":115,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label24",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":162,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Wrist",
                                    "events":{"change":"___gearSlot_Wrist_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":160,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label25",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":207,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Waist",
                                    "events":{"change":"___gearSlot_Waist_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":205,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label26",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":252,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_CharmR",
                                    "events":{"change":"___gearSlot_CharmR_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":250,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label27",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":292,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_RingR",
                                    "events":{"change":"___gearSlot_RingR_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":290,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroViewWin_Label28",
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "y":337,
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_gearSlot_Feet",
                                    "events":{"change":"___gearSlot_Feet_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":70,
                                          "height":22,
                                          "y":335,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_HeroViewWin_Image3",
                                    "events":{"click":"___HeroViewWin_Image3_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":34,
                                          "height":44,
                                          "x":20,
                                          "y":10,
                                          "toolTip":"Unequip all gear"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.right = "82";
                                       this.bottom = "13";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "text":"change all:",
                                          "styleName":"PropertyName1"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_oneClickChange",
                                    "events":{"change":"___oneClickChange_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.left = "219";
                                       this.bottom = "15";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "width":70,
                                          "toolTip":"One Click Equipment Change. You can change all parts of your equipment to that with a different set of attributes with one click.",
                                          "styleName":"ComboBox"
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
                  "events":{"click":"___HeroViewWin_Button21_click"},
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
      
      public var _HeroViewWin_Image2:Image;
      
      public var _HeroViewWin_Image3:Image;
      
      private var _1306293169_gearSlot_Weapon:ComboBox;
      
      public function HeroViewWin()
      {
         super();
         mx_internal::_document = this;
         this.width = 723;
         this.height = 490;
         this.verticalScrollPolicy = "off";
         this.horizontalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___HeroViewWin_Canvas1_creationComplete);
         this.addEventListener("mouseUp",this.___HeroViewWin_Canvas1_mouseUp);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         HeroViewWin._watcherSetupUtil = param1;
      }
      
      private function getIconUrl(param1:String) : String
      {
         return "http://e2.eimg.us/" + param1;
      }
      
      private function onUseItemBtn(param1:int) : void
      {
         var _loc2_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.HERO_APPLY_ITEM_WIN);
         _loc2_.winTitle = param1 == 0 ? "Educate Hero" : (param1 == 1 ? "Reward Hero" : (param1 == 2 ? "Recuperate Hero" : (param1 == 3 ? "Award Hero" : "")));
         _loc2_.objParam = {
            "func":this.useItem,
            "hLevel":this.hero.level
         };
         dispatchEvent(_loc2_);
      }
      
      private function onGearSlotChange(param1:ComboBox, param2:int) : void
      {
         if(int(param1.selectedItem.data) == 0)
         {
            ActionFactory.getInstance().getEquipmentCommands().TakeOffEquipmenttech(this.hero.id,"0",param2);
         }
         else
         {
            ActionFactory.getInstance().getEquipmentCommands().WearEquipmenttech(this.hero.id,"0",int(param1.selectedItem.data),param2);
         }
         this._oneClickChange.selectedIndex = 0;
      }
      
      public function ___HeroViewWin_Button12_click(param1:MouseEvent) : void
      {
         --this.addAtkPoints;
      }
      
      private function _HeroViewWin_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Remain Time";
         _loc1_.dataField = "endTime";
         _loc1_.showDataTips = true;
         _loc1_.itemRenderer = this._HeroViewWin_ClassFactory1_i();
         return _loc1_;
      }
      
      public function ___HeroViewWin_Button3_click(param1:MouseEvent) : void
      {
         this.onInfoBtn();
      }
      
      private function set hero(param1:HeroBean) : void
      {
         var _loc2_:Object = this._3198970hero;
         if(_loc2_ !== param1)
         {
            this._3198970hero = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hero",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get addPolPoints() : int
      {
         return this._1068688913addPolPoints;
      }
      
      [Bindable(event="propertyChange")]
      private function get hero() : HeroBean
      {
         return this._3198970hero;
      }
      
      public function ___inputNewHeroName_enter(param1:FlexEvent) : void
      {
         this.onRename();
      }
      
      private function onFireResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.isFiring = false;
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error firing hero: " + param1.errorMsg));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get addIntPoints() : int
      {
         return this._239157743addIntPoints;
      }
      
      public function ___inputNewHeroName_keyDown(param1:KeyboardEvent) : void
      {
         this.keyDownHandle(param1);
      }
      
      private function set addAtkPoints(param1:int) : void
      {
         var _loc2_:Object = this._490062342addAtkPoints;
         if(_loc2_ !== param1)
         {
            this._490062342addAtkPoints = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addAtkPoints",_loc2_,param1));
         }
      }
      
      private function onRedistBtn() : void
      {
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to redistribute attribute points for " + this.hero.name + "(" + this.hero.level + ")? It will cost " + Math.ceil(this.hero.level / 10) + " Holy Water.",this.onConfirmWashHero,"Yes","No"));
      }
      
      public function set _gearSlot_Shoulder(param1:ComboBox) : void
      {
         var _loc2_:Object = this._825717997_gearSlot_Shoulder;
         if(_loc2_ !== param1)
         {
            this._825717997_gearSlot_Shoulder = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Shoulder",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get addAtkPoints() : int
      {
         return this._490062342addAtkPoints;
      }
      
      private function onUnequipAll() : void
      {
         ActionFactory.getInstance().getEquipmentCommands().TakeOffAllEquipmenttech(this.hero.id);
      }
      
      public function set _changeMayorRecallBtn(param1:Button) : void
      {
         var _loc2_:Object = this._196832018_changeMayorRecallBtn;
         if(_loc2_ !== param1)
         {
            this._196832018_changeMayorRecallBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_changeMayorRecallBtn",_loc2_,param1));
         }
      }
      
      private function _HeroViewWin_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Buff Name";
         _loc1_.dataField = "descName";
         _loc1_.width = 250;
         return _loc1_;
      }
      
      public function set _gearSlot_Legs(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1530176744_gearSlot_Legs;
         if(_loc2_ !== param1)
         {
            this._1530176744_gearSlot_Legs = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Legs",_loc2_,param1));
         }
      }
      
      private function set addIntPoints(param1:int) : void
      {
         var _loc2_:Object = this._239157743addIntPoints;
         if(_loc2_ !== param1)
         {
            this._239157743addIntPoints = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addIntPoints",_loc2_,param1));
         }
      }
      
      public function ___changeMayorRecallBtn_click(param1:MouseEvent) : void
      {
         this.onChangeMayorRecallBtn(this._changeMayorRecallBtn.label);
      }
      
      private function onLostHero(param1:String, param2:int) : void
      {
         if(this.isFiring)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully fired hero " + param1 + "(" + param2 + ")."));
         }
         else if(this.isReleasing)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully released captured hero " + param1 + "(" + param2 + ")."));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Hero View closed because the hero " + param1 + "(" + param2 + ") is no longer in the city."));
         }
         this.close();
      }
      
      public function ___gearSlot_RingR_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_RING_R);
      }
      
      private function onConfirmWashHero(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc2_:int = this.getItemCount(Items.getItemId("Holy_Water"));
         var _loc3_:int = Math.ceil(this.hero.level / 10);
         if(_loc2_ >= _loc3_)
         {
            this.doWashHero(true);
         }
         else
         {
            _loc4_ = Items.getItemEumByName("Holy_Water").price * (_loc3_ - _loc2_);
            if(MainScreen.getPlayer().playerInfo.medal >= _loc4_)
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Not enough Holy Water (" + _loc2_ + "/" + _loc3_ + "). Do you want to purchase and automatically use " + (_loc3_ - _loc2_) + " additional Holy Water for " + _loc4_ + " cents?",this.doWashHero,"Yes","No"));
            }
            else
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error washing hero: Not enough Holy Water (" + _loc2_ + "/" + _loc3_ + ") and not enough coins to buy the required amount (" + MainScreen.getPlayer().playerInfo.medal + "/" + _loc4_ + ")."));
            }
         }
      }
      
      public function ___HeroViewWin_Button17_click(param1:MouseEvent) : void
      {
         this.addPolPoints = 0;
         this.addAtkPoints = 0;
         this.addIntPoints = 0;
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Weapon() : ComboBox
      {
         return this._1306293169_gearSlot_Weapon;
      }
      
      private function onHideRename(param1:Object) : void
      {
         var evtObj:Object = param1;
         try
         {
            if(!this._inputNewHeroName.visible)
            {
               return;
            }
            if(evtObj == null)
            {
               return;
            }
            if(evtObj is UITextField)
            {
               if(Boolean(evtObj.parent) && Boolean(evtObj.parent.id) && evtObj.parent.id == "_inputNewHeroName")
               {
                  return;
               }
            }
            else if(Boolean(evtObj.id) && (evtObj.id == "_inputNewHeroName" || evtObj.id == "_clearTextBtn"))
            {
               return;
            }
            this._inputNewHeroName.text = "";
            this._inputNewHeroName.visible = false;
         }
         catch(error:Error)
         {
            if(Version.isTraceOn())
            {
               trace(error.message);
            }
         }
      }
      
      private function onWearAllChange(param1:ComboBox) : void
      {
         var _loc2_:int = int(param1.selectedItem.data);
         if(_loc2_ < 1 || _loc2_ > 3)
         {
            return;
         }
         ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(this.hero.id,_loc2_);
      }
      
      private function updateHero(param1:HeroUpdate) : void
      {
         var update:HeroUpdate = param1;
         if(update.castleId != this.castleId || update.hero.id != this.hero.id)
         {
            return;
         }
         Utils.callLater(100,function(param1:int, param2:String, param3:int):void
         {
            hero = getHero(param1);
            if(hero == null)
            {
               onLostHero(param2,param3);
               return;
            }
            if(hero.remainPoint == 0)
            {
               addPolPoints = 0;
               addAtkPoints = 0;
               addIntPoints = 0;
            }
         },[this.hero.id,this.hero.name,this.hero.level]);
      }
      
      public function ___oneClickChange_change(param1:ListEvent) : void
      {
         this.onWearAllChange(param1.currentTarget as ComboBox);
      }
      
      public function ___gearSlot_CharmL_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L);
      }
      
      public function ___HeroViewWin_Button20_click(param1:MouseEvent) : void
      {
         this.onUseItemBtn(3);
      }
      
      private function set mountChangeOptions(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1660987701mountChangeOptions;
         if(_loc2_ !== param1)
         {
            this._1660987701mountChangeOptions = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mountChangeOptions",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Chest() : ComboBox
      {
         return this._199062930_gearSlot_Chest;
      }
      
      private function getHero(param1:int) : HeroBean
      {
         var _loc2_:HeroBean = null;
         for each(_loc2_ in MainScreen.getCityFromCastleId(this.castleId).cityManager.heroes)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function set _oneClickChange(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1684867889_oneClickChange;
         if(_loc2_ !== param1)
         {
            this._1684867889_oneClickChange = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_oneClickChange",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _heroView_ClassFactory0() : ClassFactory
      {
         return this._1115529603_heroView_ClassFactory0;
      }
      
      public function ___gearSlot_Shoulder_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_SHOULDERS);
      }
      
      public function set _gearSlot_Wrist(param1:ComboBox) : void
      {
         var _loc2_:Object = this._180290756_gearSlot_Wrist;
         if(_loc2_ !== param1)
         {
            this._180290756_gearSlot_Wrist = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Wrist",_loc2_,param1));
         }
      }
      
      private function _HeroViewWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.getIconUrl(this.hero.logoUrl);
         _loc1_ = this.hero.name;
         _loc1_ = this.hero.isHero == 0 && (this.hero.status == HeroConstants.HERO_FREE_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU);
         _loc1_ = this._inputNewHeroName.text.length > 0;
         _loc1_ = this.hero.level + (Utils.getUnappliedLevels(this.hero) > 0 ? "   (+" + Utils.getUnappliedLevels(this.hero) + ")" : "");
         _loc1_ = Utils.formatInt(this.hero.experience) + " / " + Utils.formatInt(this.hero.upgradeExp);
         _loc1_ = this.hero.isHero == 1;
         _loc1_ = this.hero.experience - this.hero.upgradeExp >= 0 && (this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU);
         _loc1_ = !Utils.isHeroMaxLvl(this.hero);
         _loc1_ = this.hero.status == HeroConstants.HERO_FREE_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU;
         _loc1_ = !Utils.isHeroMaxLvl(this.hero);
         _loc1_ = this.hero.status != HeroConstants.HERO_SEIZED_STATU ? "Dismiss" : "Release";
         _loc1_ = this.hero.isHero != 2;
         _loc1_ = this.hero.status == HeroConstants.HERO_SEIZED_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.hero.status == HeroConstants.HERO_SEIZED_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to fire this hero." : "Status must be free before firing this hero.";
         _loc1_ = this.hero.status == HeroConstants.HERO_SEIZED_STATU;
         _loc1_ = this.hero.status == HeroConstants.HERO_SEIZED_STATU;
         _loc1_ = this.hero.status == HeroConstants.HERO_GUARD_STATU || this.hero.status == HeroConstants.HERO_SEND_STATU ? "Recall Hero" : (this.hero.status == HeroConstants.HERO_CHIEF_STATU ? "Remove Mayor" : "Appoint Mayor");
         _loc1_ = this.hero.status == HeroConstants.HERO_GUARD_STATU || this.hero.status == HeroConstants.HERO_SEND_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = Utils.fixNumber(this.hero.management + this.hero.politics) + (this.hero.managementBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.management + this.hero.politics) * this.hero.managementBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addPolPoints + "]" : "");
         _loc1_ = this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.addPolPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = Utils.fixNumber(this.hero.power + this.hero.attack) + (this.hero.powerBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.power + this.hero.attack) * this.hero.powerBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addAtkPoints + "]" : "");
         _loc1_ = this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.addAtkPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = Utils.fixNumber(this.hero.stratagem + this.hero.intelligence) + (this.hero.stratagemBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.stratagem + this.hero.intelligence) * this.hero.stratagemBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addIntPoints + "]" : "");
         _loc1_ = this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.addIntPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints;
         _loc1_ = this.hero.remainPoint < this.hero.level;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.addPolPoints + this.addAtkPoints + this.addIntPoints > 0 && (this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU);
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to save current attribute configuration." : "Hero status must be free before saving attribute configuration.";
         _loc1_ = this.addPolPoints + this.addAtkPoints + this.addIntPoints > 0;
         _loc1_ = this.hero.remainPoint > 0;
         _loc1_ = this.hero.isHero != 2 ? this.hero.loyalty : "--";
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.hero.isHero != 2 ? this.hero.loyalty < 100 : false;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to reward and increase the loyalty of this hero." : "Hero status must be free before using an item.";
         _loc1_ = this.hero.stamina + " / " + this.hero.maxStrength;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.hero.stamina < this.hero.maxStrength;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to use an item to replenish the strength of this hero." : "Hero status must be free before using an item.";
         _loc1_ = this.hero.leadership;
         _loc1_ = this.hero.speed;
         _loc1_ = this.hero.isHero != 2 ? Utils.formatInt(this.hero.level * 20) + "/hr" : "--";
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.hero.buffsArray;
         _loc1_ = BuffsArray_inlineComponent0;
         _loc1_ = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         _loc1_ = this.hero.sex ? this.getIconUrl("images/EmbedImages/playInfo/heroMan.png") : this.getIconUrl("images/EmbedImages/playInfo/heroWoman.png");
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.mountChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean).addAttributeType > 0 ? 1 : 0;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean);
         _loc1_ = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean).equipmenttech) + ":";
         _loc1_ = this.slotChangeOptions;
         _loc1_ = (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean).addAttributeType;
         _loc1_ = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean);
         _loc1_ = this.getIconUrl("images/icon/hero/replenish.png");
         _loc1_ = this.slotChangeAllOptions;
      }
      
      public function ___HeroViewWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function ___gearSlot_Chest_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_CHEST);
      }
      
      public function ___HeroViewWin_Button5_click(param1:MouseEvent) : void
      {
         this.onUseItemBtn(0);
      }
      
      public function set _gearSlot_Weapon(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1306293169_gearSlot_Weapon;
         if(_loc2_ !== param1)
         {
            this._1306293169_gearSlot_Weapon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Weapon",_loc2_,param1));
         }
      }
      
      public function ___HeroViewWin_Button14_click(param1:MouseEvent) : void
      {
         --this.addIntPoints;
      }
      
      public function ___gearSlot_Mount_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
      }
      
      public function set _gearSlot_Neck(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1530117294_gearSlot_Neck;
         if(_loc2_ !== param1)
         {
            this._1530117294_gearSlot_Neck = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Neck",_loc2_,param1));
         }
      }
      
      private function onChangeMayorRecallBtn(param1:String) : void
      {
         if(param1 == "Recall Hero")
         {
            ActionFactory.getInstance().getHeroCommand().callBackHero(this.castleId,this.hero.id,this.onCallBackHeroResponse);
         }
         else if(param1 == "Remove Mayor")
         {
            ActionFactory.getInstance().getHeroCommand().dischargeChief(this.castleId,this.onDischargeChiefResponse);
         }
         else if(param1 == "Appoint Mayor")
         {
            ActionFactory.getInstance().getHeroCommand().promoteToChief(this.castleId,this.hero.id,this.onPromoteToChiefResponse);
         }
      }
      
      public function ___HeroViewWin_Button11_click(param1:MouseEvent) : void
      {
         ++this.addAtkPoints;
      }
      
      [Bindable(event="propertyChange")]
      public function get _renameBtn() : Button
      {
         return this._271816895_renameBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _clearTextBtn() : Button
      {
         return this._749805761_clearTextBtn;
      }
      
      public function ___clearTextBtn_click(param1:MouseEvent) : void
      {
         this._inputNewHeroName.text = "";
         this._inputNewHeroName.setFocus();
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Feet() : ComboBox
      {
         return this._1530355551_gearSlot_Feet;
      }
      
      private function onSaveBtn() : void
      {
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to save this distribution of attribute points? It will cost " + Math.ceil(this.hero.level / 10) + " Holy Water to undo the changes.",this.onConfirmSave,"Yes","No"));
      }
      
      private function onDischargeChiefResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error removing mayor: " + param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully removed mayor."));
         }
      }
      
      public function ___HeroViewWin_Button19_click(param1:MouseEvent) : void
      {
         this.onUseItemBtn(2);
      }
      
      public function ___gearSlot_Head_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_HEAD);
      }
      
      public function ___gearSlot_Legs_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_LEG_L);
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Head() : ComboBox
      {
         return this._1530296109_gearSlot_Head;
      }
      
      public function set _gearSlot_Chest(param1:ComboBox) : void
      {
         var _loc2_:Object = this._199062930_gearSlot_Chest;
         if(_loc2_ !== param1)
         {
            this._199062930_gearSlot_Chest = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Chest",_loc2_,param1));
         }
      }
      
      private function doWashHero(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         ActionFactory.getInstance().getHeroCommand().resetPoint(this.castleId,this.hero.id);
      }
      
      private function onConfirmRelease(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         this.isReleasing = true;
         ActionFactory.getInstance().getHeroCommand().releaseHero(this.castleId,this.hero.id,this.onReleaseResponse);
      }
      
      private function set slotChangeOptions(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1598388080slotChangeOptions;
         if(_loc2_ !== param1)
         {
            this._1598388080slotChangeOptions = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slotChangeOptions",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Waist() : ComboBox
      {
         return this._180797203_gearSlot_Waist;
      }
      
      public function ___fireReleaseBtn_click(param1:MouseEvent) : void
      {
         this.onFireReleaseBtn(this._fireReleaseBtn.label);
      }
      
      public function ___HeroViewWin_Canvas1_mouseUp(param1:MouseEvent) : void
      {
         this.onHideRename(param1.target);
      }
      
      private function onConfirmSave(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         ActionFactory.getInstance().getHeroCommand().addPoint2(this.castleId,this.hero.id,this.addPolPoints,this.addAtkPoints,this.addIntPoints);
         this.addPolPoints = 0;
         this.addAtkPoints = 0;
         this.addIntPoints = 0;
      }
      
      public function ___HeroViewWin_Button16_click(param1:MouseEvent) : void
      {
         this.onSaveBtn();
      }
      
      private function onPersuade(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error persuading hero: " + param1.errorMsg));
         }
      }
      
      private function onConfirmPersuade(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         ActionFactory.getInstance().getHeroCommand().tryGetSeizedHero(this.castleId,this.hero.id,this.onPersuade);
      }
      
      private function getItemCount(param1:String) : int
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in MainScreen.getPlayer().itemsArray)
         {
            if(_loc2_.id != null && _loc2_.id == param1)
            {
               return Math.max(_loc2_.count,0);
            }
         }
         return 0;
      }
      
      public function set _heroView_ClassFactory0(param1:ClassFactory) : void
      {
         var _loc2_:Object = this._1115529603_heroView_ClassFactory0;
         if(_loc2_ !== param1)
         {
            this._1115529603_heroView_ClassFactory0 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_heroView_ClassFactory0",_loc2_,param1));
         }
      }
      
      public function set _gearSlot_Mount(param1:ComboBox) : void
      {
         var _loc2_:Object = this._189603962_gearSlot_Mount;
         if(_loc2_ !== param1)
         {
            this._189603962_gearSlot_Mount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Mount",_loc2_,param1));
         }
      }
      
      public function ___HeroViewWin_Button7_click(param1:MouseEvent) : void
      {
         this.onPersuadeBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get _changeMayorRecallBtn() : Button
      {
         return this._196832018_changeMayorRecallBtn;
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Shoulder() : ComboBox
      {
         return this._825717997_gearSlot_Shoulder;
      }
      
      public function ___gearSlot_RingL_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_RING_L);
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Legs() : ComboBox
      {
         return this._1530176744_gearSlot_Legs;
      }
      
      public function set _gearSlot_RingL(param1:ComboBox) : void
      {
         var _loc2_:Object = this._185172087_gearSlot_RingL;
         if(_loc2_ !== param1)
         {
            this._185172087_gearSlot_RingL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_RingL",_loc2_,param1));
         }
      }
      
      public function updateInfo(param1:Array, param2:Function = null) : void
      {
         this.closeFunc = param2;
         this.castleId = this.getCastleId(param1[0] as int);
         if(this.castleId == 0)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Hero View closed because the hero is no longer in the city."));
            this.close();
            return;
         }
         this.hero = this.getHero(param1[0] as int);
         if(this.hero != null)
         {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.updateHero);
         }
      }
      
      public function set _gearSlot_CharmR(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1876103794_gearSlot_CharmR;
         if(_loc2_ !== param1)
         {
            this._1876103794_gearSlot_CharmR = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_CharmR",_loc2_,param1));
         }
      }
      
      public function set _gearSlot_RingR(param1:ComboBox) : void
      {
         var _loc2_:Object = this._185172081_gearSlot_RingR;
         if(_loc2_ !== param1)
         {
            this._185172081_gearSlot_RingR = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_RingR",_loc2_,param1));
         }
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this._inputNewHeroName.text = "";
            this._inputNewHeroName.visible = false;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _heroIcon() : Image
      {
         return this._528734990_heroIcon;
      }
      
      public function set _inputNewHeroName(param1:TextInput) : void
      {
         var _loc2_:Object = this._386306150_inputNewHeroName;
         if(_loc2_ !== param1)
         {
            this._386306150_inputNewHeroName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputNewHeroName",_loc2_,param1));
         }
      }
      
      public function ___gearSlot_Feet_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_FEET);
      }
      
      public function set _gearSlot_Shield(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1417811556_gearSlot_Shield;
         if(_loc2_ !== param1)
         {
            this._1417811556_gearSlot_Shield = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Shield",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Wrist() : ComboBox
      {
         return this._180290756_gearSlot_Wrist;
      }
      
      public function ___HeroViewWin_Button13_click(param1:MouseEvent) : void
      {
         ++this.addIntPoints;
      }
      
      private function useItem(param1:String) : void
      {
         if(param1 != "gold")
         {
            ActionFactory.getInstance().getHeroCommand().useItem(this.castleId,this.hero.id,param1,this.onUseItemResponse);
         }
         else
         {
            ActionFactory.getInstance().getHeroCommand().awardGold(this.castleId,this.hero.id,this.onAwardGoldResponse);
         }
      }
      
      private function init() : void
      {
      }
      
      public function ___HeroViewWin_Button4_click(param1:MouseEvent) : void
      {
         this.onLvlUpBtn();
      }
      
      [Bindable(event="propertyChange")]
      private function get mountChangeOptions() : ArrayCollection
      {
         return this._1660987701mountChangeOptions;
      }
      
      public function ___gearSlot_Waist_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_WAIST);
      }
      
      public function set _gearSlot_Feet(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1530355551_gearSlot_Feet;
         if(_loc2_ !== param1)
         {
            this._1530355551_gearSlot_Feet = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Feet",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _oneClickChange() : ComboBox
      {
         return this._1684867889_oneClickChange;
      }
      
      public function set _gearSlot_CharmL(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1876103800_gearSlot_CharmL;
         if(_loc2_ !== param1)
         {
            this._1876103800_gearSlot_CharmL = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_CharmL",_loc2_,param1));
         }
      }
      
      private function onRenameBtn() : void
      {
         this._inputNewHeroName.visible = true;
         this._inputNewHeroName.text = this.hero.name;
         this._inputNewHeroName.setFocus();
         Utils.callLater(100,function():void
         {
            _inputNewHeroName.selectionBeginIndex = 0;
            _inputNewHeroName.selectionEndIndex = hero.name.length;
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Neck() : ComboBox
      {
         return this._1530117294_gearSlot_Neck;
      }
      
      public function ___gearSlot_Neck_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_NECKLACE);
      }
      
      private function set slotChangeAllOptions(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1955904597slotChangeAllOptions;
         if(_loc2_ !== param1)
         {
            this._1955904597slotChangeAllOptions = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"slotChangeAllOptions",_loc2_,param1));
         }
      }
      
      private function onFireReleaseBtn(param1:String) : void
      {
         if(param1 == "Dismiss")
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to fire this hero?\n" + this.hero.name + "(" + this.hero.level + ")",this.onConfirmFire,"Yes","No"));
         }
         else if(param1 == "Release")
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to release this captured hero?\n" + this.hero.name + "(" + this.hero.level + ")",this.onConfirmRelease,"Yes","No"));
         }
      }
      
      public function ___HeroViewWin_Button10_click(param1:MouseEvent) : void
      {
         --this.addPolPoints;
      }
      
      public function set _renameBtn(param1:Button) : void
      {
         var _loc2_:Object = this._271816895_renameBtn;
         if(_loc2_ !== param1)
         {
            this._271816895_renameBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_renameBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get slotChangeOptions() : ArrayCollection
      {
         return this._1598388080slotChangeOptions;
      }
      
      public function set _clearTextBtn(param1:Button) : void
      {
         var _loc2_:Object = this._749805761_clearTextBtn;
         if(_loc2_ !== param1)
         {
            this._749805761_clearTextBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_clearTextBtn",_loc2_,param1));
         }
      }
      
      public function ___HeroViewWin_Image2_complete(param1:Event) : void
      {
         ImageSmooth.onLoadComplete(param1);
      }
      
      private function onReleaseResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.isReleasing = false;
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error releasing captured hero: " + param1.errorMsg));
         }
      }
      
      public function ___HeroViewWin_Button9_click(param1:MouseEvent) : void
      {
         ++this.addPolPoints;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:HeroViewWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._HeroViewWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_heroview_HeroViewWinWatcherSetupUtil");
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
      
      public function ___HeroViewWin_Button18_click(param1:MouseEvent) : void
      {
         this.onUseItemBtn(1);
      }
      
      private function onAwardGoldResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error awarding gold:  " + param1.errorMsg + ": " + param1.ok));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Gold awarded successfully."));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_RingR() : ComboBox
      {
         return this._185172081_gearSlot_RingR;
      }
      
      private function _HeroViewWin_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._heroView_ClassFactory0 = _loc1_;
         BindingManager.executeBindings(this,"_heroView_ClassFactory0",this._heroView_ClassFactory0);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_RingL() : ComboBox
      {
         return this._185172087_gearSlot_RingL;
      }
      
      public function set _fireReleaseBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1916961226_fireReleaseBtn;
         if(_loc2_ !== param1)
         {
            this._1916961226_fireReleaseBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_fireReleaseBtn",_loc2_,param1));
         }
      }
      
      private function getToolTip(param1:EquipmentBean) : String
      {
         return ItemManager.heroPosArray[param1.heroPos - 1] + "  (Lv." + param1.lv + ") (*" + param1.euipmenttechStarLv + ")\n" + "+" + Utils.fixNumber(param1.addAttribute + this.pointArr[param1.euipmenttechStarLv]) + " " + (param1.heroPos == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L ? "Speed" : (param1.addAttributeType == EquipmentTech.POLITICS ? "Politics" : (param1.addAttributeType == EquipmentTech.ATTACK ? "Attack" : (param1.addAttributeType == EquipmentTech.INTELLIGENCE ? "Intelligence" : "None"))));
      }
      
      private function getCastleId(param1:int) : int
      {
         var _loc6_:HeroBean = null;
         var _loc2_:int = 0;
         var _loc3_:int = int(MainScreen.getCities().length);
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            for each(_loc6_ in MainScreen.getCities()[_loc5_].cityManager.heroes)
            {
               if(_loc6_.id == param1)
               {
                  _loc2_ = int(MainScreen.getCities()[_loc5_].castleId);
                  _loc4_ = true;
                  break;
               }
            }
            if(_loc4_)
            {
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function ___HeroViewWin_Button21_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function set _gearSlot_Back(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1530478630_gearSlot_Back;
         if(_loc2_ !== param1)
         {
            this._1530478630_gearSlot_Back = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Back",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_CharmL() : ComboBox
      {
         return this._1876103800_gearSlot_CharmL;
      }
      
      private function onConfirmFire(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         this.isFiring = true;
         ActionFactory.getInstance().getHeroCommand().fireHero(this.castleId,this.hero.id,this.onFireResponse);
      }
      
      public function ___gearSlot_CharmR_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R);
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_CharmR() : ComboBox
      {
         return this._1876103794_gearSlot_CharmR;
      }
      
      private function onUseItemResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error applying item:  " + param1.errorMsg + ": " + param1.ok));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Item applied successfully."));
         }
      }
      
      private function onLvlUpBtn() : void
      {
         ActionFactory.getInstance().getHeroCommand().levelUp(this.castleId,this.hero.id);
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Mount() : ComboBox
      {
         return this._189603962_gearSlot_Mount;
      }
      
      public function ___HeroViewWin_Button15_click(param1:MouseEvent) : void
      {
         this.onRedistBtn();
      }
      
      public function ___heroIcon_complete(param1:Event) : void
      {
         ImageSmooth.onLoadComplete(param1);
      }
      
      public function ___gearSlot_Weapon_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_WEAPON_L);
      }
      
      public function set _gearSlot_Head(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1530296109_gearSlot_Head;
         if(_loc2_ !== param1)
         {
            this._1530296109_gearSlot_Head = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Head",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Shield() : ComboBox
      {
         return this._1417811556_gearSlot_Shield;
      }
      
      private function onPromoteToChiefResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error setting mayor: " + param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully set hero " + this.hero.name + "(" + this.hero.level + ") as mayor."));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _fireReleaseBtn() : Button
      {
         return this._1916961226_fireReleaseBtn;
      }
      
      public function ___gearSlot_Shield_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_SHIELD_L);
      }
      
      public function ___gearSlot_Back_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_BACK);
      }
      
      [Bindable(event="propertyChange")]
      private function get slotChangeAllOptions() : ArrayCollection
      {
         return this._1955904597slotChangeAllOptions;
      }
      
      private function _HeroViewWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.getIconUrl(this.hero.logoUrl);
         },function(param1:Object):void
         {
            _heroIcon.source = param1;
         },"_heroIcon.source");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.name;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text1.text = param1;
         },"_HeroViewWin_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.isHero == 0 && (this.hero.status == HeroConstants.HERO_FREE_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU);
         },function(param1:Boolean):void
         {
            _renameBtn.visible = param1;
         },"_renameBtn.visible");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._inputNewHeroName.text.length > 0;
         },function(param1:Boolean):void
         {
            _clearTextBtn.visible = param1;
         },"_clearTextBtn.visible");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.level + (Utils.getUnappliedLevels(this.hero) > 0 ? "   (+" + Utils.getUnappliedLevels(this.hero) + ")" : "");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text2.text = param1;
         },"_HeroViewWin_Text2.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.hero.experience) + " / " + Utils.formatInt(this.hero.upgradeExp);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text3.text = param1;
         },"_HeroViewWin_Text3.text");
         result[5] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.isHero == 1;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button3.visible = param1;
         },"_HeroViewWin_Button3.visible");
         result[6] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.experience - this.hero.upgradeExp >= 0 && (this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU);
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button4.enabled = param1;
         },"_HeroViewWin_Button4.enabled");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return !Utils.isHeroMaxLvl(this.hero);
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button4.visible = param1;
         },"_HeroViewWin_Button4.visible");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_FREE_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button5.enabled = param1;
         },"_HeroViewWin_Button5.enabled");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return !Utils.isHeroMaxLvl(this.hero);
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button5.visible = param1;
         },"_HeroViewWin_Button5.visible");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status != HeroConstants.HERO_SEIZED_STATU ? "Dismiss" : "Release";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _fireReleaseBtn.label = param1;
         },"_fireReleaseBtn.label");
         result[11] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.isHero != 2;
         },function(param1:Boolean):void
         {
            _fireReleaseBtn.visible = param1;
         },"_fireReleaseBtn.visible");
         result[12] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_SEIZED_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _fireReleaseBtn.enabled = param1;
         },"_fireReleaseBtn.enabled");
         result[13] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status == HeroConstants.HERO_SEIZED_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to fire this hero." : "Status must be free before firing this hero.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _fireReleaseBtn.toolTip = param1;
         },"_fireReleaseBtn.toolTip");
         result[14] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_SEIZED_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button7.visible = param1;
         },"_HeroViewWin_Button7.visible");
         result[15] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_SEIZED_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button7.enabled = param1;
         },"_HeroViewWin_Button7.enabled");
         result[16] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status == HeroConstants.HERO_GUARD_STATU || this.hero.status == HeroConstants.HERO_SEND_STATU ? "Recall Hero" : (this.hero.status == HeroConstants.HERO_CHIEF_STATU ? "Remove Mayor" : "Appoint Mayor");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _changeMayorRecallBtn.label = param1;
         },"_changeMayorRecallBtn.label");
         result[17] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_GUARD_STATU || this.hero.status == HeroConstants.HERO_SEND_STATU || this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _changeMayorRecallBtn.visible = param1;
         },"_changeMayorRecallBtn.visible");
         result[18] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.fixNumber(this.hero.management + this.hero.politics) + (this.hero.managementBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.management + this.hero.politics) * this.hero.managementBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addPolPoints + "]" : "");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text4.text = param1;
         },"_HeroViewWin_Text4.text");
         result[19] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button9.enabled = param1;
         },"_HeroViewWin_Button9.enabled");
         result[20] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button9.visible = param1;
         },"_HeroViewWin_Button9.visible");
         result[21] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.addPolPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button10.enabled = param1;
         },"_HeroViewWin_Button10.enabled");
         result[22] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button10.visible = param1;
         },"_HeroViewWin_Button10.visible");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.fixNumber(this.hero.power + this.hero.attack) + (this.hero.powerBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.power + this.hero.attack) * this.hero.powerBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addAtkPoints + "]" : "");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text5.text = param1;
         },"_HeroViewWin_Text5.text");
         result[24] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button11.enabled = param1;
         },"_HeroViewWin_Button11.enabled");
         result[25] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button11.visible = param1;
         },"_HeroViewWin_Button11.visible");
         result[26] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.addAtkPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button12.enabled = param1;
         },"_HeroViewWin_Button12.enabled");
         result[27] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button12.visible = param1;
         },"_HeroViewWin_Button12.visible");
         result[28] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.fixNumber(this.hero.stratagem + this.hero.intelligence) + (this.hero.stratagemBuffAdded > 0 && this.hero.remainPoint == 0 ? "+" + Math.round((this.hero.stratagem + this.hero.intelligence) * this.hero.stratagemBuffAdded / 100) : "") + (this.hero.remainPoint > 0 ? " [+" + this.addIntPoints + "]" : "");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text6.text = param1;
         },"_HeroViewWin_Text6.text");
         result[29] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button13.enabled = param1;
         },"_HeroViewWin_Button13.enabled");
         result[30] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button13.visible = param1;
         },"_HeroViewWin_Button13.visible");
         result[31] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.addIntPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button14.enabled = param1;
         },"_HeroViewWin_Button14.enabled");
         result[32] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button14.visible = param1;
         },"_HeroViewWin_Button14.visible");
         result[33] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.remainPoint - this.addPolPoints - this.addAtkPoints - this.addIntPoints;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text7.text = param1;
         },"_HeroViewWin_Text7.text");
         result[34] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint < this.hero.level;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button15.enabled = param1;
         },"_HeroViewWin_Button15.enabled");
         result[35] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button15.visible = param1;
         },"_HeroViewWin_Button15.visible");
         result[36] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.addPolPoints + this.addAtkPoints + this.addIntPoints > 0 && (this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU);
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button16.enabled = param1;
         },"_HeroViewWin_Button16.enabled");
         result[37] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button16.visible = param1;
         },"_HeroViewWin_Button16.visible");
         result[38] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to save current attribute configuration." : "Hero status must be free before saving attribute configuration.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Button16.toolTip = param1;
         },"_HeroViewWin_Button16.toolTip");
         result[39] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.addPolPoints + this.addAtkPoints + this.addIntPoints > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button17.enabled = param1;
         },"_HeroViewWin_Button17.enabled");
         result[40] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.remainPoint > 0;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button17.visible = param1;
         },"_HeroViewWin_Button17.visible");
         result[41] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.isHero != 2 ? this.hero.loyalty : "--";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text8.text = param1;
         },"_HeroViewWin_Text8.text");
         result[42] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button18.enabled = param1;
         },"_HeroViewWin_Button18.enabled");
         result[43] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.isHero != 2 ? this.hero.loyalty < 100 : false;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button18.visible = param1;
         },"_HeroViewWin_Button18.visible");
         result[44] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to reward and increase the loyalty of this hero." : "Hero status must be free before using an item.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Button18.toolTip = param1;
         },"_HeroViewWin_Button18.toolTip");
         result[45] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.stamina + " / " + this.hero.maxStrength;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text9.text = param1;
         },"_HeroViewWin_Text9.text");
         result[46] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button19.enabled = param1;
         },"_HeroViewWin_Button19.enabled");
         result[47] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.stamina < this.hero.maxStrength;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Button19.visible = param1;
         },"_HeroViewWin_Button19.visible");
         result[48] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU ? "Click to use an item to replenish the strength of this hero." : "Hero status must be free before using an item.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Button19.toolTip = param1;
         },"_HeroViewWin_Button19.toolTip");
         result[49] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.leadership;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text10.text = param1;
         },"_HeroViewWin_Text10.text");
         result[50] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.speed;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text11.text = param1;
         },"_HeroViewWin_Text11.text");
         result[51] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.hero.isHero != 2 ? Utils.formatInt(this.hero.level * 20) + "/hr" : "--";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Text12.text = param1;
         },"_HeroViewWin_Text12.text");
         result[52] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Canvas5.enabled = param1;
         },"_HeroViewWin_Canvas5.enabled");
         result[53] = binding;
         binding = new Binding(this,function():Object
         {
            return this.hero.buffsArray;
         },function(param1:Object):void
         {
            _HeroViewWin_DataGrid1.dataProvider = param1;
         },"_HeroViewWin_DataGrid1.dataProvider");
         result[54] = binding;
         binding = new Binding(this,function():Class
         {
            return BuffsArray_inlineComponent0;
         },function(param1:Class):void
         {
            _heroView_ClassFactory0.generator = param1;
         },"_heroView_ClassFactory0.generator");
         result[55] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.hero.status == HeroConstants.HERO_CHIEF_STATU || this.hero.status == HeroConstants.HERO_FREE_STATU;
         },function(param1:Boolean):void
         {
            _HeroViewWin_Canvas7.enabled = param1;
         },"_HeroViewWin_Canvas7.enabled");
         result[56] = binding;
         binding = new Binding(this,function():Object
         {
            return !!this.hero.sex ? this.getIconUrl("images/EmbedImages/playInfo/heroMan.png") : this.getIconUrl("images/EmbedImages/playInfo/heroWoman.png");
         },function(param1:Object):void
         {
            _HeroViewWin_Image2.source = param1;
         },"_HeroViewWin_Image2.source");
         result[57] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label13.text = param1;
         },"_HeroViewWin_Label13.text");
         result[58] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Head.dataProvider = param1;
         },"_gearSlot_Head.dataProvider");
         result[59] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Head.selectedIndex = param1;
         },"_gearSlot_Head.selectedIndex");
         result[60] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_HEAD - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Head.toolTip = param1;
         },"_gearSlot_Head.toolTip");
         result[61] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label14.text = param1;
         },"_HeroViewWin_Label14.text");
         result[62] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Chest.dataProvider = param1;
         },"_gearSlot_Chest.dataProvider");
         result[63] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Chest.selectedIndex = param1;
         },"_gearSlot_Chest.selectedIndex");
         result[64] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_CHEST - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Chest.toolTip = param1;
         },"_gearSlot_Chest.toolTip");
         result[65] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label15.text = param1;
         },"_HeroViewWin_Label15.text");
         result[66] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Weapon.dataProvider = param1;
         },"_gearSlot_Weapon.dataProvider");
         result[67] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Weapon.selectedIndex = param1;
         },"_gearSlot_Weapon.selectedIndex");
         result[68] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WEAPON_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Weapon.toolTip = param1;
         },"_gearSlot_Weapon.toolTip");
         result[69] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label16.text = param1;
         },"_HeroViewWin_Label16.text");
         result[70] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Shield.dataProvider = param1;
         },"_gearSlot_Shield.dataProvider");
         result[71] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Shield.selectedIndex = param1;
         },"_gearSlot_Shield.selectedIndex");
         result[72] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHIELD_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Shield.toolTip = param1;
         },"_gearSlot_Shield.toolTip");
         result[73] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label17.text = param1;
         },"_HeroViewWin_Label17.text");
         result[74] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Legs.dataProvider = param1;
         },"_gearSlot_Legs.dataProvider");
         result[75] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Legs.selectedIndex = param1;
         },"_gearSlot_Legs.selectedIndex");
         result[76] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_LEG_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Legs.toolTip = param1;
         },"_gearSlot_Legs.toolTip");
         result[77] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label18.text = param1;
         },"_HeroViewWin_Label18.text");
         result[78] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_CharmL.dataProvider = param1;
         },"_gearSlot_CharmL.dataProvider");
         result[79] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_CharmL.selectedIndex = param1;
         },"_gearSlot_CharmL.selectedIndex");
         result[80] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_CharmL.toolTip = param1;
         },"_gearSlot_CharmL.toolTip");
         result[81] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label19.text = param1;
         },"_HeroViewWin_Label19.text");
         result[82] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_RingL.dataProvider = param1;
         },"_gearSlot_RingL.dataProvider");
         result[83] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_RingL.selectedIndex = param1;
         },"_gearSlot_RingL.selectedIndex");
         result[84] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_RingL.toolTip = param1;
         },"_gearSlot_RingL.toolTip");
         result[85] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label20.text = param1;
         },"_HeroViewWin_Label20.text");
         result[86] = binding;
         binding = new Binding(this,function():Object
         {
            return this.mountChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Mount.dataProvider = param1;
         },"_gearSlot_Mount.dataProvider");
         result[87] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean).addAttributeType > 0 ? 1 : 0;
         },function(param1:int):void
         {
            _gearSlot_Mount.selectedIndex = param1;
         },"_gearSlot_Mount.selectedIndex");
         result[88] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_MOUNT_L - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Mount.toolTip = param1;
         },"_gearSlot_Mount.toolTip");
         result[89] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label21.text = param1;
         },"_HeroViewWin_Label21.text");
         result[90] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Neck.dataProvider = param1;
         },"_gearSlot_Neck.dataProvider");
         result[91] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Neck.selectedIndex = param1;
         },"_gearSlot_Neck.selectedIndex");
         result[92] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_NECKLACE - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Neck.toolTip = param1;
         },"_gearSlot_Neck.toolTip");
         result[93] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label22.text = param1;
         },"_HeroViewWin_Label22.text");
         result[94] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Shoulder.dataProvider = param1;
         },"_gearSlot_Shoulder.dataProvider");
         result[95] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Shoulder.selectedIndex = param1;
         },"_gearSlot_Shoulder.selectedIndex");
         result[96] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_SHOULDERS - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Shoulder.toolTip = param1;
         },"_gearSlot_Shoulder.toolTip");
         result[97] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label23.text = param1;
         },"_HeroViewWin_Label23.text");
         result[98] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Back.dataProvider = param1;
         },"_gearSlot_Back.dataProvider");
         result[99] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Back.selectedIndex = param1;
         },"_gearSlot_Back.selectedIndex");
         result[100] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_BACK - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Back.toolTip = param1;
         },"_gearSlot_Back.toolTip");
         result[101] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label24.text = param1;
         },"_HeroViewWin_Label24.text");
         result[102] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Wrist.dataProvider = param1;
         },"_gearSlot_Wrist.dataProvider");
         result[103] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Wrist.selectedIndex = param1;
         },"_gearSlot_Wrist.selectedIndex");
         result[104] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WRIST - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Wrist.toolTip = param1;
         },"_gearSlot_Wrist.toolTip");
         result[105] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label25.text = param1;
         },"_HeroViewWin_Label25.text");
         result[106] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Waist.dataProvider = param1;
         },"_gearSlot_Waist.dataProvider");
         result[107] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Waist.selectedIndex = param1;
         },"_gearSlot_Waist.selectedIndex");
         result[108] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_WAIST - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Waist.toolTip = param1;
         },"_gearSlot_Waist.toolTip");
         result[109] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label26.text = param1;
         },"_HeroViewWin_Label26.text");
         result[110] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_CharmR.dataProvider = param1;
         },"_gearSlot_CharmR.dataProvider");
         result[111] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_CharmR.selectedIndex = param1;
         },"_gearSlot_CharmR.selectedIndex");
         result[112] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_ACCESORIES_R - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_CharmR.toolTip = param1;
         },"_gearSlot_CharmR.toolTip");
         result[113] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label27.text = param1;
         },"_HeroViewWin_Label27.text");
         result[114] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_RingR.dataProvider = param1;
         },"_gearSlot_RingR.dataProvider");
         result[115] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_RingR.selectedIndex = param1;
         },"_gearSlot_RingR.selectedIndex");
         result[116] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_RING_R - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_RingR.toolTip = param1;
         },"_gearSlot_RingR.toolTip");
         result[117] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = GearType.toAbbrString((this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean).equipmenttech) + ":";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _HeroViewWin_Label28.text = param1;
         },"_HeroViewWin_Label28.text");
         result[118] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeOptions;
         },function(param1:Object):void
         {
            _gearSlot_Feet.dataProvider = param1;
         },"_gearSlot_Feet.dataProvider");
         result[119] = binding;
         binding = new Binding(this,function():int
         {
            return (this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean).addAttributeType;
         },function(param1:int):void
         {
            _gearSlot_Feet.selectedIndex = param1;
         },"_gearSlot_Feet.selectedIndex");
         result[120] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.getToolTip(this.hero.equipmentbeanArray.getItemAt(EquipmentTech.EQUIPMENT_SLOT_FEET - 1) as EquipmentBean);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _gearSlot_Feet.toolTip = param1;
         },"_gearSlot_Feet.toolTip");
         result[121] = binding;
         binding = new Binding(this,function():Object
         {
            return this.getIconUrl("images/icon/hero/replenish.png");
         },function(param1:Object):void
         {
            _HeroViewWin_Image3.source = param1;
         },"_HeroViewWin_Image3.source");
         result[122] = binding;
         binding = new Binding(this,function():Object
         {
            return this.slotChangeAllOptions;
         },function(param1:Object):void
         {
            _oneClickChange.dataProvider = param1;
         },"_oneClickChange.dataProvider");
         result[123] = binding;
         return result;
      }
      
      private function set addPolPoints(param1:int) : void
      {
         var _loc2_:Object = this._1068688913addPolPoints;
         if(_loc2_ !== param1)
         {
            this._1068688913addPolPoints = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"addPolPoints",_loc2_,param1));
         }
      }
      
      private function onCallBackHeroResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error recalling hero: " + param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully recalled hero " + this.hero.name + "(" + this.hero.level + ")."));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputNewHeroName() : TextInput
      {
         return this._386306150_inputNewHeroName;
      }
      
      [Bindable(event="propertyChange")]
      public function get _gearSlot_Back() : ComboBox
      {
         return this._1530478630_gearSlot_Back;
      }
      
      public function ___HeroViewWin_Image3_click(param1:MouseEvent) : void
      {
         this.onUnequipAll();
      }
      
      public function set _heroIcon(param1:Image) : void
      {
         var _loc2_:Object = this._528734990_heroIcon;
         if(_loc2_ !== param1)
         {
            this._528734990_heroIcon = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_heroIcon",_loc2_,param1));
         }
      }
      
      public function ___renameBtn_click(param1:MouseEvent) : void
      {
         this.onRenameBtn();
      }
      
      public function set _gearSlot_Waist(param1:ComboBox) : void
      {
         var _loc2_:Object = this._180797203_gearSlot_Waist;
         if(_loc2_ !== param1)
         {
            this._180797203_gearSlot_Waist = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gearSlot_Waist",_loc2_,param1));
         }
      }
      
      private function onInfoBtn() : void
      {
         var _loc1_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.HERO_DESC_WIN);
         _loc1_.objParam = this.hero.infro;
         dispatchEvent(_loc1_);
      }
      
      public function ___gearSlot_Wrist_change(param1:ListEvent) : void
      {
         this.onGearSlotChange(param1.currentTarget as ComboBox,EquipmentTech.EQUIPMENT_SLOT_WRIST);
      }
      
      private function onPersuadeBtn() : void
      {
         dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to persuade " + this.hero.name + "(" + this.hero.level + ")? It will cost " + this.hero.level * 1000 + " gold" + (Boolean(this.hero.itemId) && this.hero.itemAmount > 0 ? " and " + this.hero.itemAmount + " " + Items.getItemName(this.hero.itemId).split("_").join(" ") + (this.hero.itemAmount > 1 ? "s" : "") : "") + ".",this.onConfirmPersuade,"Yes","No"));
      }
      
      private function onChangeNameResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error renaming hero: " + param1.errorMsg));
         }
      }
      
      private function onRename() : void
      {
         if(this._inputNewHeroName.text.length < 1 || this._inputNewHeroName.text == "" || this._inputNewHeroName.text == this.hero.name)
         {
            return;
         }
         ActionFactory.getInstance().getHeroCommand().changeName(this.castleId,this.hero.id,this._inputNewHeroName.text,this.onChangeNameResponse);
         Utils.callLater(100,function():void
         {
            _inputNewHeroName.text = "";
            _inputNewHeroName.visible = false;
         });
      }
      
      private function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_HERO_UPDATE,this.updateHero);
         this.closeFunc.apply(null,[this]);
      }
   }
}

