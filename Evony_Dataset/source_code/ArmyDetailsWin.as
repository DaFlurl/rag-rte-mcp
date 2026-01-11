package autoevony.gui
{
   import autoevony.common.Items;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.ArmyBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.FieldBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.TroopBean;
   import com.evony.common.constants.ArmyConstants;
   import com.evony.common.constants.TFConstants;
   import com.evony.common.server.events.ItemUpdate;
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
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.ListEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class ArmyDetailsWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public var _ArmyDetailsWin_Text6:Text;
      
      public var _ArmyDetailsWin_Text7:Text;
      
      public var _ArmyDetailsWin_Text9:Text;
      
      public var _ArmyDetailsWin_Text8:Text;
      
      public var _ArmyDetailsWin_Text1:Text;
      
      private var _971377469itemSelectInfo:ArrayCollection = null;
      
      public var _ArmyDetailsWin_Text4:Text;
      
      public var _ArmyDetailsWin_DataGrid1:DataGrid;
      
      private var _617648668troopData:ArrayCollection = null;
      
      private var _342540263resoData:ArrayCollection = null;
      
      private var _1220405362_itemSelect:ComboBox;
      
      private var castleId:int;
      
      public var _ArmyDetailsWin_PopUpWinBase1:PopUpWinBase;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      public var _ArmyDetailsWin_Label9:Label;
      
      private var _3002781army:ArmyBean = null;
      
      private var _838170928armyLandsIn:String = "--:--:--";
      
      private var lastTime:Number = 0;
      
      public var _ArmyDetailsWin_Text10:Text;
      
      public var _ArmyDetailsWin_Text11:Text;
      
      private var armyId:int;
      
      mx_internal var _watchers:Array = [];
      
      private var updateTimeTimer:Timer = null;
      
      private var _1414939017armyType:String = null;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      public var _ArmyDetailsWin_Button2:Button;
      
      private var closeFunc:Function = null;
      
      private var _2127813052itemCount:int = 0;
      
      private var useFunc:Function = null;
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":495,
               "height":484,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "id":"_ArmyDetailsWin_PopUpWinBase1",
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"_ArmyDetailsWin_Text1",
                  "stylesFactory":function():void
                  {
                     this.left = "16";
                     this.top = "12";
                     this.textAlign = "center";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":114,
                        "height":22,
                        "styleName":"newArmyTroop"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "15";
                     this.top = "50";
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
                              this.right = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":58,
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "3";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":40,
                                          "height":22,
                                          "text":"From:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text2",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "50";
                                       this.top = "3";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":250,
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "305";
                                       this.top = "3";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":40,
                                          "height":22,
                                          "text":"ETA:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text3",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "350";
                                       this.top = "3";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "28";
                                       this.right = "5";
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
                                       this.left = "5";
                                       this.top = "33";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":40,
                                          "height":22,
                                          "text":"To:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text4",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "50";
                                       this.top = "33";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":250,
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "305";
                                       this.top = "33";
                                       this.textAlign = "right";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":40,
                                          "height":22,
                                          "text":"In:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text5",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "350";
                                       this.top = "33";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
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
                              this.top = "65";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":230,
                                 "height":314,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_ArmyDetailsWin_DataGrid1",
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
                                          "rowHeight":24,
                                          "variableRowHeight":true,
                                          "selectable":false,
                                          "showHeaders":true,
                                          "sortableColumns":false,
                                          "visible":true,
                                          "wordWrap":false,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "columns":[_ArmyDetailsWin_DataGridColumn1_c(),_ArmyDetailsWin_DataGridColumn2_c()]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.top = "65";
                              this.right = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":230,
                                 "height":163,
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "3";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":60,
                                          "height":22,
                                          "text":"Mission:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text6",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "70";
                                       this.top = "3";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "28";
                                       this.right = "5";
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
                                       this.left = "5";
                                       this.top = "33";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":60,
                                          "height":22,
                                          "text":"Status:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text7",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "70";
                                       this.top = "33";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "58";
                                       this.right = "5";
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
                                       this.left = "5";
                                       this.top = "63";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":60,
                                          "height":22,
                                          "text":"Lord:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text8",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "70";
                                       this.top = "63";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "88";
                                       this.right = "5";
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
                                       this.left = "5";
                                       this.top = "93";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":60,
                                          "height":22,
                                          "text":"Alliance:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text9",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "70";
                                       this.top = "93";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "118";
                                       this.right = "5";
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
                                    "id":"_ArmyDetailsWin_Label9",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "123";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":60,
                                          "height":22,
                                          "text":"Hero:",
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text10",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "70";
                                       this.top = "123";
                                       this.right = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.top = "233";
                              this.right = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":230,
                                 "height":146,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_ArmyDetailsWin_DataGrid2",
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
                                          "rowHeight":24,
                                          "variableRowHeight":true,
                                          "selectable":false,
                                          "showHeaders":true,
                                          "sortableColumns":false,
                                          "visible":true,
                                          "wordWrap":false,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "columns":[_ArmyDetailsWin_DataGridColumn3_c(),_ArmyDetailsWin_DataGridColumn4_c()]
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
                              this.right = "0";
                              this.bottom = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":35,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":ComboBox,
                                    "id":"_itemSelect",
                                    "events":{"change":"___itemSelect_change"},
                                    "stylesFactory":function():void
                                    {
                                       this.top = "8";
                                       this.left = "0";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":230,
                                          "height":22,
                                          "styleName":"ComboBox"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ArmyDetailsWin_Button1_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.top = "8";
                                       this.left = "240";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Use Stratagem",
                                          "styleName":"REwinBtn"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ArmyDetailsWin_Text11",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "350";
                                       this.top = "10";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":22,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ArmyDetailsWin_Button2",
                                    "events":{"click":"___ArmyDetailsWin_Button2_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.top = "8";
                                       this.right = "0";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Recall",
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
                  "events":{"click":"___ArmyDetailsWin_Button3_click"},
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
      
      public var _ArmyDetailsWin_DataGrid2:DataGrid;
      
      public var _ArmyDetailsWin_Text2:Text;
      
      public var _ArmyDetailsWin_Text3:Text;
      
      public var _ArmyDetailsWin_Text5:Text;
      
      public function ArmyDetailsWin()
      {
         super();
         mx_internal::_document = this;
         this.width = 495;
         this.height = 484;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ArmyDetailsWin._watcherSetupUtil = param1;
      }
      
      private function canRecall(param1:int) : Boolean
      {
         if((this.armyType == "self" || this.armyType == "local") && (param1 == ArmyConstants.ARMY_FORWARD || param1 == ArmyConstants.ARMY_STAY))
         {
            return true;
         }
         if(this.armyType == "friendly" && param1 == ArmyConstants.ARMY_STAY)
         {
            return true;
         }
         return false;
      }
      
      private function onArmyUpdates(param1:Object = null) : void
      {
         Utils.callLater(100,this.updateArmy);
      }
      
      private function updateResoData() : void
      {
         if(this.resoData == null)
         {
            this.resoData = new ArrayCollection();
         }
         else
         {
            this.resoData.removeAll();
         }
         if(this.army.resource == null)
         {
            return;
         }
         if(this.army.resource.gold)
         {
            this.resoData.addItem({
               "type":"Gold",
               "amount":Utils.formatNum(this.army.resource.gold,0)
            });
         }
         if(this.army.resource.food)
         {
            this.resoData.addItem({
               "type":"Food",
               "amount":Utils.formatNum(this.army.resource.food,0)
            });
         }
         if(this.army.resource.wood)
         {
            this.resoData.addItem({
               "type":"Lumber",
               "amount":Utils.formatNum(this.army.resource.wood,0)
            });
         }
         if(this.army.resource.stone)
         {
            this.resoData.addItem({
               "type":"Stone",
               "amount":Utils.formatNum(this.army.resource.stone,0)
            });
         }
         if(this.army.resource.iron)
         {
            this.resoData.addItem({
               "type":"Iron",
               "amount":Utils.formatNum(this.army.resource.iron,0)
            });
         }
      }
      
      private function getArmy(param1:int, param2:String) : ArmyBean
      {
         var _loc4_:ArmyBean = null;
         var _loc3_:CityState = MainScreen.getCityFromCastleId(this.castleId);
         if(_loc3_ == null)
         {
            return null;
         }
         for each(_loc4_ in _loc3_.cityManager[param2 + "Armies"])
         {
            if(_loc4_.armyId == param1)
            {
               return _loc4_;
            }
         }
         if(param2 == "enemy")
         {
            for each(_loc4_ in _loc3_.cityManager.enemyValleyArmies)
            {
               if(_loc4_.armyId == param1)
               {
                  return _loc4_;
               }
            }
            for each(_loc4_ in _loc3_.cityManager.enemyColonyArmies)
            {
               if(_loc4_.armyId == param1)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function updateInfo(param1:Array, param2:Function = null) : void
      {
         this.castleId = param1[0];
         this.armyId = param1[1];
         this.armyType = param1[2];
         this.useFunc = param1[3];
         this.closeFunc = param2;
         this.updateArmy();
         if(this.army == null)
         {
            return;
         }
         if(this.armyType == "self" || this.armyType == "local")
         {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.onArmyUpdates);
         }
         else if(this.armyType == "friendly")
         {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE,this.onArmyUpdates);
         }
         else if(this.armyType == "enemy")
         {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE,this.onArmyUpdates);
         }
         this.updateTroopData();
         this.updateResoData();
         if(this.armyType == "enemy" || this.armyType == "friendly")
         {
            this.itemSelectInfo = new ArrayCollection([{
               "label":Items.getItemName("player.trick.bmjs").split("_").join(" "),
               "data":"player.trick.bmjs"
            },{
               "label":Items.getItemName("player.trick.gmdg").split("_").join(" "),
               "data":"player.trick.gmdg"
            },{
               "label":Items.getItemName("player.trick.ydsr").split("_").join(" "),
               "data":"player.trick.ydsr"
            }]);
         }
         else if(this.armyType == "self" || this.armyType == "local")
         {
            this.itemSelectInfo = new ArrayCollection([{
               "label":Items.getItemName("player.trick.jctq").split("_").join(" "),
               "data":"player.trick.jctq"
            },{
               "label":Items.getItemName("player.trick.qlbx").split("_").join(" "),
               "data":"player.trick.qlbx"
            },{
               "label":Items.getItemName("player.trick.xzxs").split("_").join(" "),
               "data":"player.trick.xzxs"
            },{
               "label":Items.getItemName("player.trick.yqxg").split("_").join(" "),
               "data":"player.trick.yqxg"
            }]);
         }
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
         Utils.callLater(50,this.updateItemCount);
         this.updateTimeTimer = new Timer(1000);
         this.updateTimeTimer.addEventListener(TimerEvent.TIMER,this.updateReachTime);
         this.updateTimeTimer.start();
      }
      
      [Bindable(event="propertyChange")]
      private function get resoData() : ArrayCollection
      {
         return this._342540263resoData;
      }
      
      public function set _itemSelect(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1220405362_itemSelect;
         if(_loc2_ !== param1)
         {
            this._1220405362_itemSelect = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_itemSelect",_loc2_,param1));
         }
      }
      
      private function updateReachTime(param1:TimerEvent = null) : void
      {
         this.armyLandsIn = this.army.reachTime > 0 ? Utils.formatEndTime(this.army.reachTime) : "--:--:--";
      }
      
      [Bindable(event="propertyChange")]
      private function get troopData() : ArrayCollection
      {
         return this._617648668troopData;
      }
      
      private function _ArmyDetailsWin_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Amount";
         _loc1_.dataField = "amount";
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function updateArmy() : void
      {
         if(this.armyType == null)
         {
            return;
         }
         this.army = this.getArmy(this.armyId,this.armyType);
         if(this.army == null)
         {
            this.close();
         }
      }
      
      private function set resoData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._342540263resoData;
         if(_loc2_ !== param1)
         {
            this._342540263resoData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resoData",_loc2_,param1));
         }
      }
      
      public function ___ArmyDetailsWin_Button1_click(param1:MouseEvent) : void
      {
         this.onApplyStratBtn();
      }
      
      [Bindable(event="propertyChange")]
      private function get itemSelectInfo() : ArrayCollection
      {
         return this._971377469itemSelectInfo;
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
      
      public function ___ArmyDetailsWin_Button2_click(param1:MouseEvent) : void
      {
         this.onRecallBtn();
      }
      
      private function set army(param1:ArmyBean) : void
      {
         var _loc2_:Object = this._3002781army;
         if(_loc2_ !== param1)
         {
            this._3002781army = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"army",_loc2_,param1));
         }
      }
      
      private function _ArmyDetailsWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = (this.armyType != null && this.armyType != "" ? this.armyType.charAt(0).toUpperCase() + this.armyType.substr(1) : "") + "Army Details";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_PopUpWinBase1.windowTitle = param1;
         },"_ArmyDetailsWin_PopUpWinBase1.windowTitle");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "[   " + this.army.armyId + "   ]";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text1.text = param1;
         },"_ArmyDetailsWin_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = (this.army.startFieldId < 0 ? "(unknown)" : Map.fieldIdToString(this.army.startFieldId)) + " " + (this.army.startPosName == null ? "(unknown)" : this.army.startPosName);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text2.text = param1;
         },"_ArmyDetailsWin_Text2.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.army.reachTime > 0 ? Utils.getTimeStr(this.army.reachTime) : "--:--:--";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text3.text = param1;
         },"_ArmyDetailsWin_Text3.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Map.fieldIdToString(this.army.targetFieldId) + " " + (this.army.targetPosName != null && this.army.targetPosName != "" ? this.army.targetPosName : this.getTarget(this.army.targetFieldId));
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text4.text = param1;
         },"_ArmyDetailsWin_Text4.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.armyLandsIn;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text5.text = param1;
         },"_ArmyDetailsWin_Text5.text");
         result[5] = binding;
         binding = new Binding(this,function():Object
         {
            return this.troopData;
         },function(param1:Object):void
         {
            _ArmyDetailsWin_DataGrid1.dataProvider = param1;
         },"_ArmyDetailsWin_DataGrid1.dataProvider");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = (this.armyType == "local" ? "" : this.armyType.charAt(0) + "-") + (this.army.missionType > 0 && this.army.missionType < Utils.MISSION_NAMES.length ? this.getMission(this.army.missionType) : "(unknown");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text6.text = param1;
         },"_ArmyDetailsWin_Text6.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.army.direction == ArmyConstants.ARMY_FORWARD ? "marching" : (this.army.direction == ArmyConstants.ARMY_BACKWARD ? "returning" : (this.army.direction == ArmyConstants.ARMY_STAY ? "camped" : ""));
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text7.text = param1;
         },"_ArmyDetailsWin_Text7.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.army.king == null ? "(unknown)" : this.army.king;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text8.text = param1;
         },"_ArmyDetailsWin_Text8.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.army.alliance;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text9.text = param1;
         },"_ArmyDetailsWin_Text9.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "HeroId: " + this.army.heroid;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Label9.toolTip = param1;
         },"_ArmyDetailsWin_Label9.toolTip");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.army.heroLevel < 1 && this.army.hero == null ? "(none)" : "(" + (this.army.heroLevel > 0 ? this.army.heroLevel : "unknown") + ") " + (this.army.hero == null || this.army.hero == "" ? "(unknown)" : this.army.hero);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text10.text = param1;
         },"_ArmyDetailsWin_Text10.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "HeroId: " + this.army.heroid;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text10.toolTip = param1;
         },"_ArmyDetailsWin_Text10.toolTip");
         result[13] = binding;
         binding = new Binding(this,function():Object
         {
            return this.resoData;
         },function(param1:Object):void
         {
            _ArmyDetailsWin_DataGrid2.dataProvider = param1;
         },"_ArmyDetailsWin_DataGrid2.dataProvider");
         result[14] = binding;
         binding = new Binding(this,function():Object
         {
            return this.itemSelectInfo;
         },function(param1:Object):void
         {
            _itemSelect.dataProvider = param1;
         },"_itemSelect.dataProvider");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "x" + this.itemCount;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ArmyDetailsWin_Text11.text = param1;
         },"_ArmyDetailsWin_Text11.text");
         result[16] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.canRecall(this.army.direction);
         },function(param1:Boolean):void
         {
            _ArmyDetailsWin_Button2.visible = param1;
         },"_ArmyDetailsWin_Button2.visible");
         result[17] = binding;
         return result;
      }
      
      private function set troopData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._617648668troopData;
         if(_loc2_ !== param1)
         {
            this._617648668troopData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troopData",_loc2_,param1));
         }
      }
      
      private function _ArmyDetailsWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = (this.armyType != null && this.armyType != "" ? this.armyType.charAt(0).toUpperCase() + this.armyType.substr(1) : "") + "Army Details";
         _loc1_ = "[   " + this.army.armyId + "   ]";
         _loc1_ = (this.army.startFieldId < 0 ? "(unknown)" : Map.fieldIdToString(this.army.startFieldId)) + " " + (this.army.startPosName == null ? "(unknown)" : this.army.startPosName);
         _loc1_ = this.army.reachTime > 0 ? Utils.getTimeStr(this.army.reachTime) : "--:--:--";
         _loc1_ = Map.fieldIdToString(this.army.targetFieldId) + " " + (this.army.targetPosName != null && this.army.targetPosName != "" ? this.army.targetPosName : this.getTarget(this.army.targetFieldId));
         _loc1_ = this.armyLandsIn;
         _loc1_ = this.troopData;
         _loc1_ = (this.armyType == "local" ? "" : this.armyType.charAt(0) + "-") + (this.army.missionType > 0 && this.army.missionType < Utils.MISSION_NAMES.length ? this.getMission(this.army.missionType) : "(unknown");
         _loc1_ = this.army.direction == ArmyConstants.ARMY_FORWARD ? "marching" : (this.army.direction == ArmyConstants.ARMY_BACKWARD ? "returning" : (this.army.direction == ArmyConstants.ARMY_STAY ? "camped" : ""));
         _loc1_ = this.army.king == null ? "(unknown)" : this.army.king;
         _loc1_ = this.army.alliance;
         _loc1_ = "HeroId: " + this.army.heroid;
         _loc1_ = this.army.heroLevel < 1 && this.army.hero == null ? "(none)" : "(" + (this.army.heroLevel > 0 ? this.army.heroLevel : "unknown") + ") " + (this.army.hero == null || this.army.hero == "" ? "(unknown)" : this.army.hero);
         _loc1_ = "HeroId: " + this.army.heroid;
         _loc1_ = this.resoData;
         _loc1_ = this.itemSelectInfo;
         _loc1_ = "x" + this.itemCount;
         _loc1_ = this.canRecall(this.army.direction);
      }
      
      private function updateTroopData() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Array = new Array(TFConstants.T_PEASANTS,TFConstants.T_MILITIA,TFConstants.T_SCOUTER,TFConstants.T_PIKEMAN,TFConstants.T_SWORDSMEN,TFConstants.T_ARCHER,TFConstants.T_LIGHTCAVALRY,TFConstants.T_HEAVYCAVALRY,TFConstants.T_CARRIAGE,TFConstants.T_BALLISTA,TFConstants.T_BATTERINGRAM,TFConstants.T_CATAPULT);
         var _loc2_:TroopBean = Utils.getTroopBeanFromTroopStrBean(this.army.troop);
         if(this.troopData == null)
         {
            this.troopData = new ArrayCollection();
         }
         else
         {
            this.troopData.removeAll();
         }
         for each(_loc3_ in _loc1_)
         {
            if(int(_loc2_[Utils.troopIntNames[_loc3_]]) > 0)
            {
               this.troopData.addItem({
                  "type":String(Utils.troopExtNames[_loc3_]),
                  "amount":Utils.formatInt(_loc2_[Utils.troopIntNames[_loc3_]])
               });
            }
         }
      }
      
      private function getMission(param1:int) : String
      {
         return (Utils.MISSION_NAMES[param1] as String).charAt(0).toUpperCase() + (Utils.MISSION_NAMES[param1] as String).substr(1);
      }
      
      public function ___itemSelect_change(param1:ListEvent) : void
      {
         this.updateItemCount();
      }
      
      private function _ArmyDetailsWin_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Troop Type";
         _loc1_.dataField = "type";
         _loc1_.width = 105;
         return _loc1_;
      }
      
      private function onRecallBtn() : void
      {
         var _loc1_:Date = new Date();
         if(_loc1_.getTime() < this.lastTime + 2000)
         {
            return;
         }
         this.lastTime = _loc1_.getTime();
         MainScreen.getCityFromCastleId(this.castleId).cityManager.logMsg("Recall self army with armyId: " + this.armyId);
         ActionFactory.getInstance().getArmyCommands().callBackArmy(this.castleId,this.armyId);
      }
      
      [Bindable(event="propertyChange")]
      private function get armyType() : String
      {
         return this._1414939017armyType;
      }
      
      private function set itemCount(param1:int) : void
      {
         var _loc2_:Object = this._2127813052itemCount;
         if(_loc2_ !== param1)
         {
            this._2127813052itemCount = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemCount",_loc2_,param1));
         }
      }
      
      private function set itemSelectInfo(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._971377469itemSelectInfo;
         if(_loc2_ !== param1)
         {
            this._971377469itemSelectInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemSelectInfo",_loc2_,param1));
         }
      }
      
      public function ___ArmyDetailsWin_Button3_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function getTarget(param1:int) : String
      {
         var _loc3_:FieldBean = null;
         var _loc4_:String = null;
         var _loc5_:ColonyBean = null;
         if(param1 < 0)
         {
            return "";
         }
         var _loc2_:CityState = null;
         _loc2_ = MainScreen.getCityFromFieldId(param1);
         if(_loc2_ != null)
         {
            return _loc2_.castle.name;
         }
         _loc2_ = MainScreen.getCityFromValleyFieldId(param1);
         if(_loc2_ != null)
         {
            for each(_loc3_ in _loc2_.cm.fields)
            {
               if(_loc3_.id == param1)
               {
                  return _loc3_.type + _loc3_.name + _loc3_.level;
               }
            }
            return "";
         }
         _loc2_ = MainScreen.getCityFromColonyFieldId(param1);
         if(_loc2_ != null)
         {
            _loc4_ = Map.getX(param1) + "." + Map.getY(param1);
            for each(_loc5_ in _loc2_.cm.colonies)
            {
               if(_loc5_.position == _loc4_)
               {
                  return _loc5_.cityName;
               }
            }
            return "";
         }
         return "";
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ArmyDetailsWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ArmyDetailsWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_ArmyDetailsWinWatcherSetupUtil");
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
      
      private function onApplyStratBtn() : void
      {
         var _loc1_:int = 0;
         if(this.army.startFieldId < 0)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You cannot use an army item if the source castle is unknown. Try creating or upgrading the Beacon Tower first."));
            return;
         }
         if(this.getItemCount(this._itemSelect.selectedItem.data) <= 0)
         {
            _loc1_ = Items.getItemEumById(this._itemSelect.selectedItem.data).price;
            if(MainScreen.getPlayer().playerInfo.medal - _loc1_ >= 0)
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You do not have any more of this item. Do you want to purchase and automatically use one for " + _loc1_ + " cents?",this.onConfirmBuyAndApplyStrat,"Yes","No"));
            }
            else
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You do not have any more of this item, and not enough Cents (coins) to buy this item from the Game Shop."));
            }
         }
         else
         {
            this.onConfirmBuyAndApplyStrat(true);
         }
      }
      
      private function set armyLandsIn(param1:String) : void
      {
         var _loc2_:Object = this._838170928armyLandsIn;
         if(_loc2_ !== param1)
         {
            this._838170928armyLandsIn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"armyLandsIn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get army() : ArmyBean
      {
         return this._3002781army;
      }
      
      [Bindable(event="propertyChange")]
      public function get _itemSelect() : ComboBox
      {
         return this._1220405362_itemSelect;
      }
      
      private function onConfirmBuyAndApplyStrat(param1:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         this.useFunc.apply(null,[this.army.startFieldId,this.army.armyId,this._itemSelect.selectedItem.data]);
      }
      
      private function _ArmyDetailsWin_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Amount";
         _loc1_.dataField = "amount";
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get itemCount() : int
      {
         return this._2127813052itemCount;
      }
      
      [Bindable(event="propertyChange")]
      private function get armyLandsIn() : String
      {
         return this._838170928armyLandsIn;
      }
      
      private function _ArmyDetailsWin_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Reso Type";
         _loc1_.dataField = "type";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function set armyType(param1:String) : void
      {
         var _loc2_:Object = this._1414939017armyType;
         if(_loc2_ !== param1)
         {
            this._1414939017armyType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"armyType",_loc2_,param1));
         }
      }
      
      private function updateItemCount() : void
      {
         this.itemCount = this.getItemCount(this._itemSelect.selectedItem.data);
      }
      
      private function close() : void
      {
         if(this.armyType == "self" || this.armyType == "local")
         {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_SELF_ARMYS_UPDATE,this.onArmyUpdates);
         }
         else if(this.armyType == "friendly")
         {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE,this.onArmyUpdates);
         }
         else if(this.armyType == "enemy")
         {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE,this.onArmyUpdates);
         }
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
         if(this.updateTimeTimer != null)
         {
            this.updateTimeTimer.stop();
            this.updateTimeTimer.removeEventListener(TimerEvent.TIMER,this.updateReachTime);
            this.updateTimeTimer = null;
         }
         if(this.itemSelectInfo != null)
         {
            this.itemSelectInfo.removeAll();
            this.itemSelectInfo = null;
         }
         if(this.troopData != null)
         {
            this.troopData.removeAll();
            this.troopData = null;
         }
         if(this.resoData != null)
         {
            this.resoData.removeAll();
            this.resoData = null;
         }
         this.useFunc = null;
         this.army = null;
         this.armyType = null;
         this.closeFunc.apply(null,[this]);
      }
      
      private function onItemUpdate(param1:ItemUpdate) : void
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in param1.itemsArray)
         {
            if(_loc2_.id == this._itemSelect.selectedItem.data)
            {
               Utils.callLater(50,this.updateItemCount);
               break;
            }
         }
      }
   }
}

