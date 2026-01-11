package autoevony.gui
{
   import autoevony.common.CityStateCommands;
   import autoevony.common.GearType;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.controls.popup.PopUpWinManager;
   import autoevony.gui.controls.themes.ThemeManager;
   import autoevony.gui.newarmy.NewArmyWin;
   import autoevony.management.CityManager;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import autoevony.scripts.Script;
   import com.as3xls.xls.ExcelFile;
   import com.as3xls.xls.Sheet;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.CastleBean;
   import com.evony.common.beans.ColonyBean;
   import com.evony.common.beans.HeroBean;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.tech.ResearchResponse;
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
   import mx.containers.HDividedBox;
   import mx.containers.VBox;
   import mx.containers.ViewStack;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.DataGrid;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TabBar;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.controls.dataGridClasses.DataGridColumn;
   import mx.controls.tabBarClasses.Tab;
   import mx.core.ClassFactory;
   import mx.core.UIComponentDescriptor;
   import mx.core.UITextField;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CityPanel extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      internal static const SAVEALLEVENT:String = "SaveAll";
      
      internal static const SETALLGOALS:String = "SetAllGoals";
      
      private var _embed_mxml_autoevony_gui_images_loyGrieve_png_471597483:Class = CityPanel__embed_mxml_autoevony_gui_images_loyGrieve_png_471597483;
      
      public var _CityPanel_ClassFactory1:ClassFactory;
      
      public var _CityPanel_ClassFactory2:ClassFactory;
      
      public var _CityPanel_ClassFactory3:ClassFactory;
      
      public var _CityPanel_ClassFactory4:ClassFactory;
      
      public var _CityPanel_ClassFactory5:ClassFactory;
      
      public var _CityPanel_ClassFactory6:ClassFactory;
      
      public var _CityPanel_ClassFactory7:ClassFactory;
      
      public var _CityPanel_ClassFactory8:ClassFactory;
      
      public var _CityPanel_ClassFactory9:ClassFactory;
      
      private var _1405697728_buildings:Canvas;
      
      private var _1188674855_showEnemiesC:CheckBox;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1299164186_armies:Canvas;
      
      private var _355347286fortificationsData:ArrayCollection = new ArrayCollection();
      
      private var _2006530702gearsData:ArrayCollection = new ArrayCollection();
      
      private var _embed_mxml_autoevony_gui_images_pop_png_1631794581:Class = CityPanel__embed_mxml_autoevony_gui_images_pop_png_1631794581;
      
      private var _1487717191_heroes:Canvas;
      
      private var _2009763499troopsData:ArrayCollection = new ArrayCollection();
      
      private var _260377862_research:Canvas;
      
      public var _CityPanel_RowColorDataGrid1:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid2:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid3:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid4:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid5:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid6:RowColorDataGrid;
      
      public var _CityPanel_RowColorDataGrid7:RowColorDataGrid;
      
      private var _1649235507innHeroData:ArrayCollection = new ArrayCollection();
      
      private var _1476969531_gears:Canvas;
      
      private var _16113637researchData:ArrayCollection = new ArrayCollection();
      
      private var _1626662999valleyData:ArrayCollection = new ArrayCollection();
      
      private var _1188674836_showEnemiesV:CheckBox;
      
      private var _1839459670_showEnemies:CheckBox;
      
      public var _CityPanel_Button1:Button;
      
      public var _CityPanel_Button2:Button;
      
      public var _CityPanel_Button3:Button;
      
      public var _CityPanel_Button4:Button;
      
      public var _CityPanel_Button5:Button;
      
      public var _CityPanel_Button6:Button;
      
      public var _CityPanel_Button7:Button;
      
      private var _250546835_resource:Canvas;
      
      public var _CityPanel_Text1:Text;
      
      public var _CityPanel_Text2:Text;
      
      private var _1820295151_goalsTxt:TextArea;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _982909826buildingData:ArrayCollection = new ArrayCollection();
      
      private var _1892696025tradesData:ArrayCollection = new ArrayCollection();
      
      private var _embed_mxml_autoevony_gui_images_prod_png_99042219:Class = CityPanel__embed_mxml_autoevony_gui_images_prod_png_99042219;
      
      public var _CityPanel_Label1:Label;
      
      public var _CityPanel_Label3:Label;
      
      public var _CityPanel_Label4:Label;
      
      public var _CityPanel_Label5:Label;
      
      public var _CityPanel_Label7:Label;
      
      private var _1676058921troopQueueData:ArrayCollection = new ArrayCollection();
      
      private var _1647526287_cityInfoProd:Label;
      
      private var _1884649598_valley:Canvas;
      
      private var _496434264_inputNewCastleName:TextInput;
      
      private var _1415438617armyData:ArrayCollection = new ArrayCollection();
      
      private var _1202148967_castleBean:CastleBean = null;
      
      private var _1127919786_cityPanelBean:CityPanelBean;
      
      private var _1353628185_colony:Canvas;
      
      private var _746461325_stopButton:Button;
      
      private var _1464576923_trade:Canvas;
      
      private var _1238975450_scriptTxt:TextArea;
      
      private var _752649447_enemies:Canvas;
      
      private var _1507357726_runButton:Button;
      
      private var _35298671externalTroopData:ArrayCollection = new ArrayCollection();
      
      private var _623064501_troopQueues:Canvas;
      
      private var timer:Timer = null;
      
      internal var isInitialized:Boolean = false;
      
      public var _CityPanel_ClassFactory10:ClassFactory;
      
      public var _CityPanel_ClassFactory11:ClassFactory;
      
      private var _1197740996colonyData:ArrayCollection = new ArrayCollection();
      
      private var _1446694032_allinfo:ViewStack;
      
      private var _248346296_showSelf:CheckBox;
      
      private var _1942092334_innheroes:Canvas;
      
      private var _1742425533_goalTab:TabBar;
      
      private var _8659656_infoTab:TabBar;
      
      mx_internal var _watchers:Array = [];
      
      private var _384864040resourceData:ArrayCollection = new ArrayCollection();
      
      private var _embed_mxml_autoevony_gui_images_taxes_png_499416011:Class = CityPanel__embed_mxml_autoevony_gui_images_taxes_png_499416011;
      
      private var _271816895_renameBtn:Button;
      
      private var _749805761_clearTextBtn:Button;
      
      public var _CityPanel_DataGrid1:DataGrid;
      
      public var _CityPanel_DataGrid2:DataGrid;
      
      public var _CityPanel_DataGrid3:DataGrid;
      
      public var _CityPanel_DataGrid4:DataGrid;
      
      public var _CityPanel_DataGrid5:DataGrid;
      
      public var _CityPanel_DataGrid6:DataGrid;
      
      public var _CityPanel_DataGrid7:DataGrid;
      
      private var _1907625964_alltasks:ViewStack;
      
      private var _1321633669_showFriendlies:CheckBox;
      
      private var _1472639233_fortifications:Canvas;
      
      private var _1843183744_troops:Canvas;
      
      mx_internal var _bindings:Array = [];
      
      private var _619403580heroData:ArrayCollection = new ArrayCollection();
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "width":1200,
               "height":300,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":HDividedBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 3;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 0;
                              this.paddingLeft = 0;
                              this.paddingRight = 0;
                              this.paddingTop = 0;
                              this.paddingBottom = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "bottom";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":22,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":TabBar,
                                             "id":"_goalTab",
                                             "stylesFactory":function():void
                                             {
                                                this.tabStyleName = "REtabBarTab";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "dataProvider":"_alltasks",
                                                   "styleName":"REtabBar"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"_alltasks",
                                    "stylesFactory":function():void
                                    {
                                       this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "creationPolicy":"all",
                                          "percentWidth":100,
                                          "percentHeight":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Goals",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":VBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalGap = 0;
                                                         this.paddingLeft = 0;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 0;
                                                         this.paddingBottom = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentHeight":100,
                                                            "percentWidth":100,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_goalsTxt",
                                                               "events":{"change":"___goalsTxt_change"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "percentHeight":100,
                                                                     "styleName":"txtAreaStyle"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":HBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalGap = 0;
                                                                  this.verticalAlign = "middle";
                                                                  this.paddingLeft = 5;
                                                                  this.paddingRight = 5;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "height":28,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button1",
                                                                        "events":{"click":"___CityPanel_Button1_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "label":"March",
                                                                              "styleName":"REwinBtn",
                                                                              "toolTip":"Open a New Army window to manually customize and dispatch troops"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"percentWidth":100};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":50};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button2",
                                                                        "events":{"click":"___CityPanel_Button2_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Save File",
                                                                              "toolTip":"Save this town\'s currently entered goals to a text file"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button3",
                                                                        "events":{"click":"___CityPanel_Button3_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Load File",
                                                                              "toolTip":"Load goals from a text file into this town\'s goals window"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":60};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button4",
                                                                        "events":{"click":"___CityPanel_Button4_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Set Goals",
                                                                              "toolTip":"Set this town\'s currently entered goals"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":15};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button5",
                                                                        "events":{"click":"___CityPanel_Button5_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Save",
                                                                              "toolTip":"Save this town\'s currently entered goals"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button6",
                                                                        "events":{"click":"___CityPanel_Button6_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Load",
                                                                              "toolTip":"Load last saved goals for this town"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":15};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_CityPanel_Button7",
                                                                        "events":{"click":"___CityPanel_Button7_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Save All",
                                                                              "toolTip":"Save all goals and scripts for all towns"
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
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Script",
                                                   "percentWidth":100,
                                                   "percentHeight":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":VBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.verticalGap = 0;
                                                         this.paddingLeft = 0;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 0;
                                                         this.paddingBottom = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "percentHeight":100,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":TextArea,
                                                               "id":"_scriptTxt",
                                                               "events":{"change":"___scriptTxt_change"},
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "percentHeight":100,
                                                                     "styleName":"txtAreaStyle"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":HBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalGap = 0;
                                                                  this.verticalAlign = "middle";
                                                                  this.paddingLeft = 5;
                                                                  this.paddingRight = 5;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "height":28,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button8_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "label":"March",
                                                                              "styleName":"REwinBtn",
                                                                              "toolTip":"Open a New Army window to manually customize and dispatch troops"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"percentWidth":100};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":50};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button9_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Save File",
                                                                              "toolTip":"Save this town\'s currently entered script to a text file"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button10_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Load File",
                                                                              "toolTip":"Load a script from a text file into this town\'s script window"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":60};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_runButton",
                                                                        "events":{"click":"___runButton_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "label":"Run",
                                                                              "styleName":"REwinBtn",
                                                                              "toolTip":"Run currently entered script for this town"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "id":"_stopButton",
                                                                        "events":{"click":"___stopButton_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "label":"Stop",
                                                                              "styleName":"REwinBtn",
                                                                              "toolTip":"Stop currently running script for this town"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":15};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button13_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Save",
                                                                              "toolTip":"Save currently entered script for this town"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":5};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button14_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "styleName":"REwinBtn",
                                                                              "label":"Load",
                                                                              "toolTip":"Load last saved script for this town"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":HBox,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":15};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___CityPanel_Button15_click"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "label":"Save All",
                                                                              "styleName":"REwinBtn",
                                                                              "toolTip":"Save all goals and scripts for all towns"
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
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.verticalGap = 0;
                              this.paddingLeft = 0;
                              this.paddingRight = 0;
                              this.paddingTop = 0;
                              this.paddingBottom = 0;
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "percentHeight":100,
                                 "width":603,
                                 "horizontalScrollPolicy":"off",
                                 "verticalScrollPolicy":"off",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.horizontalGap = 0;
                                       this.verticalGap = 0;
                                       this.borderColor = 2236962;
                                       this.borderStyle = "solid";
                                       this.borderThickness = 1;
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":47,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":VBox,
                                             "stylesFactory":function():void
                                             {
                                                this.paddingLeft = 0;
                                                this.paddingRight = 0;
                                                this.paddingTop = 1;
                                                this.paddingBottom = 2;
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "percentWidth":100,
                                                   "height":45,
                                                   "styleName":"cityTopInfoDarkFadedBackground",
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                         this.paddingLeft = 10;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 0;
                                                         this.paddingBottom = 1;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "height":20,
                                                            "horizontalScrollPolicy":"off",
                                                            "verticalScrollPolicy":"off",
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "left";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":220,
                                                                     "height":20,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Canvas,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":220,
                                                                              "height":20,
                                                                              "horizontalScrollPolicy":"off",
                                                                              "verticalScrollPolicy":"off",
                                                                              "childDescriptors":[new UIComponentDescriptor({
                                                                                 "type":HBox,
                                                                                 "stylesFactory":function():void
                                                                                 {
                                                                                    this.left = "0";
                                                                                    this.horizontalAlign = "left";
                                                                                    this.paddingLeft = 0;
                                                                                    this.paddingRight = 0;
                                                                                    this.paddingTop = 0;
                                                                                    this.paddingBottom = 0;
                                                                                    this.horizontalGap = 20;
                                                                                 },
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "width":220,
                                                                                       "height":20,
                                                                                       "horizontalScrollPolicy":"off",
                                                                                       "verticalScrollPolicy":"off",
                                                                                       "childDescriptors":[new UIComponentDescriptor({
                                                                                          "type":Text,
                                                                                          "id":"_CityPanel_Text1",
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {
                                                                                                "styleName":"cityTopInfoText",
                                                                                                "toolTip":"City Name"
                                                                                             };
                                                                                          }
                                                                                       }),new UIComponentDescriptor({
                                                                                          "type":Button,
                                                                                          "id":"_renameBtn",
                                                                                          "events":{"click":"___renameBtn_click"},
                                                                                          "propertiesFactory":function():Object
                                                                                          {
                                                                                             return {
                                                                                                "width":16,
                                                                                                "height":16,
                                                                                                "toolTip":"Change castle name",
                                                                                                "styleName":"editBtn"
                                                                                             };
                                                                                          }
                                                                                       })]
                                                                                    };
                                                                                 }
                                                                              }),new UIComponentDescriptor({
                                                                                 "type":TextInput,
                                                                                 "id":"_inputNewCastleName",
                                                                                 "events":{
                                                                                    "enter":"___inputNewCastleName_enter",
                                                                                    "keyDown":"___inputNewCastleName_keyDown"
                                                                                 },
                                                                                 "stylesFactory":function():void
                                                                                 {
                                                                                    this.left = "0";
                                                                                 },
                                                                                 "propertiesFactory":function():Object
                                                                                 {
                                                                                    return {
                                                                                       "width":170,
                                                                                       "height":20,
                                                                                       "text":"",
                                                                                       "maxChars":10,
                                                                                       "restrict":" A-Za-z0-9",
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
                                                                                    this.left = "149";
                                                                                    this.top = "2";
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
                                                                              })]
                                                                           };
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":30,
                                                                     "height":17,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"source":_embed_mxml_autoevony_gui_images_loyGrieve_png_471597483};
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_CityPanel_Label1",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":43,
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Loyalty"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.textAlign = "center";
                                                                  this.fontSize = 12;
                                                                  this.color = 16777215;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":16,
                                                                     "text":"/"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_CityPanel_Label3",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":105,
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Public Grievance"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":30,
                                                                     "height":17,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"source":_embed_mxml_autoevony_gui_images_taxes_png_499416011};
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_CityPanel_Label4",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":50,
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Tax Rate"
                                                                  };
                                                               }
                                                            })]
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "height":2,
                                                            "styleName":"horizontalSeparator2pxLine"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":HBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                         this.paddingLeft = 10;
                                                         this.paddingRight = 0;
                                                         this.paddingTop = 1;
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
                                                               "type":Text,
                                                               "id":"_CityPanel_Text2",
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.color = 16777215;
                                                                  this.fontFamily = "DejaVu Sans";
                                                                  this.fontThickness = 20;
                                                                  this.fontSize = 13;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":220,
                                                                     "toolTip":"Location"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":30,
                                                                     "height":17,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"source":_embed_mxml_autoevony_gui_images_pop_png_1631794581};
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_CityPanel_Label5",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":63,
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Current Population"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.textAlign = "center";
                                                                  this.fontSize = 12;
                                                                  this.color = 16777215;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":16,
                                                                     "text":"/"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_CityPanel_Label7",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":85,
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Idle Population"
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":VBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.paddingTop = 0;
                                                                  this.paddingBottom = 0;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":30,
                                                                     "height":17,
                                                                     "horizontalScrollPolicy":"off",
                                                                     "verticalScrollPolicy":"off",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Image,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"source":_embed_mxml_autoevony_gui_images_prod_png_99042219};
                                                                        }
                                                                     })]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":Label,
                                                               "id":"_cityInfoProd",
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "width":50,
                                                                     "text":"",
                                                                     "styleName":"cityTopInfoText",
                                                                     "toolTip":"Production Rate"
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
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "height":2,
                                          "percentWidth":100,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
                                    {
                                       this.verticalAlign = "bottom";
                                       this.paddingLeft = 0;
                                       this.paddingRight = 0;
                                       this.paddingTop = 0;
                                       this.paddingBottom = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
                                          "height":22,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":TabBar,
                                             "id":"_infoTab",
                                             "stylesFactory":function():void
                                             {
                                                this.tabStyleName = "REtabBarTab";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "dataProvider":"_allinfo",
                                                   "percentWidth":100,
                                                   "styleName":"REtabBar"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"_allinfo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentHeight":100,
                                          "percentWidth":100,
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_resource",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"R",
                                                   "toolTip":"Resources Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid1",
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
                                                            "columns":[_CityPanel_DataGridColumn1_c(),_CityPanel_DataGridColumn2_c(),_CityPanel_DataGridColumn3_c(),_CityPanel_DataGridColumn4_c(),_CityPanel_DataGridColumn5_c(),_CityPanel_DataGridColumn6_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_valley",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"V",
                                                   "toolTip":"Valleys Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid1",
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
                                                            "columns":[_CityPanel_DataGridColumn7_c(),_CityPanel_DataGridColumn8_c(),_CityPanel_DataGridColumn9_c(),_CityPanel_DataGridColumn10_c(),_CityPanel_DataGridColumn11_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_colony",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"C",
                                                   "toolTip":"Colonies and Suzerain Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid2",
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
                                                            "columns":[_CityPanel_DataGridColumn12_c(),_CityPanel_DataGridColumn13_c(),_CityPanel_DataGridColumn14_c(),_CityPanel_DataGridColumn15_c(),_CityPanel_DataGridColumn16_c(),_CityPanel_DataGridColumn17_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_innheroes",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"I",
                                                   "toolTip":"Inn Heroes Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid2",
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
                                                            "columns":[_CityPanel_DataGridColumn18_c(),_CityPanel_DataGridColumn19_c(),_CityPanel_DataGridColumn20_c(),_CityPanel_DataGridColumn21_c(),_CityPanel_DataGridColumn22_c(),_CityPanel_DataGridColumn23_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_heroes",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"H",
                                                   "toolTip":"Heroes Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid3",
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
                                                            "columns":[_CityPanel_DataGridColumn24_c(),_CityPanel_DataGridColumn25_c(),_CityPanel_DataGridColumn26_c(),_CityPanel_DataGridColumn27_c(),_CityPanel_DataGridColumn28_c(),_CityPanel_DataGridColumn29_c(),_CityPanel_DataGridColumn30_c(),_CityPanel_DataGridColumn31_c(),_CityPanel_DataGridColumn32_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_buildings",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"B",
                                                   "toolTip":"Buildings Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid3",
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
                                                            "columns":[_CityPanel_DataGridColumn33_c(),_CityPanel_DataGridColumn34_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_research",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"S",
                                                   "toolTip":"Tech Research Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid4",
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
                                                            "columns":[_CityPanel_DataGridColumn35_c(),_CityPanel_DataGridColumn36_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_gears",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"G",
                                                   "toolTip":"Gear Research and Star Level Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid5",
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
                                                            "columns":[_CityPanel_DataGridColumn37_c(),_CityPanel_DataGridColumn38_c(),_CityPanel_DataGridColumn39_c(),_CityPanel_DataGridColumn40_c(),_CityPanel_DataGridColumn41_c(),_CityPanel_DataGridColumn42_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_armies",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"A",
                                                   "toolTip":"Armies Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid4",
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
                                                            "columns":[_CityPanel_DataGridColumn43_c(),_CityPanel_DataGridColumn44_c(),_CityPanel_DataGridColumn45_c(),_CityPanel_DataGridColumn46_c(),_CityPanel_DataGridColumn47_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_troops",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"T",
                                                   "toolTip":"Troops Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid5",
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
                                                            "columns":[_CityPanel_DataGridColumn48_c(),_CityPanel_DataGridColumn49_c(),_CityPanel_DataGridColumn50_c(),_CityPanel_DataGridColumn51_c(),_CityPanel_DataGridColumn52_c(),_CityPanel_DataGridColumn53_c(),_CityPanel_DataGridColumn54_c(),_CityPanel_DataGridColumn55_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_troopQueues",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Q",
                                                   "toolTip":"Troops Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":RowColorDataGrid,
                                                      "id":"_CityPanel_RowColorDataGrid6",
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
                                                            "columns":[_CityPanel_DataGridColumn56_c(),_CityPanel_DataGridColumn57_c(),_CityPanel_DataGridColumn58_c(),_CityPanel_DataGridColumn59_c(),_CityPanel_DataGridColumn60_c(),_CityPanel_DataGridColumn61_c(),_CityPanel_DataGridColumn62_c(),_CityPanel_DataGridColumn63_c(),_CityPanel_DataGridColumn64_c(),_CityPanel_DataGridColumn65_c(),_CityPanel_DataGridColumn66_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_fortifications",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"F",
                                                   "toolTip":"Wall Fortifications Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid6",
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
                                                            "columns":[_CityPanel_DataGridColumn67_c(),_CityPanel_DataGridColumn68_c(),_CityPanel_DataGridColumn69_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_trade",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"X",
                                                   "toolTip":"Market Transactions Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":DataGrid,
                                                      "id":"_CityPanel_DataGrid7",
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
                                                            "columns":[_CityPanel_DataGridColumn70_c(),_CityPanel_DataGridColumn71_c(),_CityPanel_DataGridColumn72_c(),_CityPanel_DataGridColumn73_c()]
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Canvas,
                                             "id":"_enemies",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"E",
                                                   "toolTip":"External Incoming Armies Info",
                                                   "percentHeight":100,
                                                   "percentWidth":100,
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":VBox,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.horizontalGap = 0;
                                                         this.verticalGap = 0;
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "percentHeight":100,
                                                            "childDescriptors":[new UIComponentDescriptor({
                                                               "type":RowColorDataGrid,
                                                               "id":"_CityPanel_RowColorDataGrid7",
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
                                                                     "columns":[_CityPanel_DataGridColumn74_c(),_CityPanel_DataGridColumn75_c(),_CityPanel_DataGridColumn76_c(),_CityPanel_DataGridColumn77_c(),_CityPanel_DataGridColumn78_c()]
                                                                  };
                                                               }
                                                            }),new UIComponentDescriptor({
                                                               "type":HBox,
                                                               "stylesFactory":function():void
                                                               {
                                                                  this.horizontalAlign = "center";
                                                                  this.verticalAlign = "middle";
                                                                  this.paddingLeft = 0;
                                                                  this.paddingRight = 0;
                                                                  this.borderColor = 592137;
                                                                  this.borderStyle = "solid";
                                                                  this.borderThickness = 1;
                                                               },
                                                               "propertiesFactory":function():Object
                                                               {
                                                                  return {
                                                                     "percentWidth":100,
                                                                     "height":27,
                                                                     "styleName":"cityTopInfoDarkFadedBackground",
                                                                     "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.color = 1048575;
                                                                           this.fontFamily = "DejaVu Sans";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "text":"Self:",
                                                                              "toolTip":"Mark to show incoming own armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":1,
                                                                              "toolTip":"Mark to show incoming own armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showSelf",
                                                                        "events":{"change":"___showSelf_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "selected":true,
                                                                              "styleName":"REcheckBox",
                                                                              "toolTip":"Mark to show incoming own armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":20};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.color = 1048575;
                                                                           this.fontFamily = "DejaVu Sans";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "text":"Ally:",
                                                                              "toolTip":"Mark to show incoming friendly armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":1,
                                                                              "toolTip":"Mark to show incoming friendly armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showFriendlies",
                                                                        "events":{"change":"___showFriendlies_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "selected":true,
                                                                              "styleName":"REcheckBox",
                                                                              "toolTip":"Mark to show incoming friendly armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":50};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.color = 1048575;
                                                                           this.fontFamily = "DejaVu Sans";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "text":"Enemy:",
                                                                              "toolTip":"Mark to show incoming enemy armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":1,
                                                                              "toolTip":"Mark to show incoming enemy armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showEnemies",
                                                                        "events":{"change":"___showEnemies_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "selected":true,
                                                                              "styleName":"REcheckBox",
                                                                              "toolTip":"Mark to show incoming enemy armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":20};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.color = 1048575;
                                                                           this.fontFamily = "DejaVu Sans";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "text":"Valley:",
                                                                              "toolTip":"Mark to show incoming enemy valley armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":1,
                                                                              "toolTip":"Mark to show incoming enemy valley armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showEnemiesV",
                                                                        "events":{"change":"___showEnemiesV_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "selected":true,
                                                                              "styleName":"REcheckBox",
                                                                              "toolTip":"Mark to show incoming enemy valley armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {"width":20};
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "stylesFactory":function():void
                                                                        {
                                                                           this.color = 1048575;
                                                                           this.fontFamily = "DejaVu Sans";
                                                                           this.fontSize = 12;
                                                                        },
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "text":"Colony:",
                                                                              "toolTip":"Mark to show incoming enemy colony armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":Spacer,
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "width":1,
                                                                              "toolTip":"Mark to show incoming enemy colony armies"
                                                                           };
                                                                        }
                                                                     }),new UIComponentDescriptor({
                                                                        "type":CheckBox,
                                                                        "id":"_showEnemiesC",
                                                                        "events":{"change":"___showEnemiesC_change"},
                                                                        "propertiesFactory":function():Object
                                                                        {
                                                                           return {
                                                                              "selected":true,
                                                                              "styleName":"REcheckBox",
                                                                              "toolTip":"Mark to show incoming enemy colony armies"
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
                                          })]
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
      });
      
      public function CityPanel()
      {
         super();
         mx_internal::_document = this;
         this.width = 1200;
         this.height = 300;
         this.addEventListener("creationComplete",this.___CityPanel_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CityPanel._watcherSetupUtil = param1;
      }
      
      internal function onSaveAll(param1:Object = null) : void
      {
         var _loc2_:CityState = null;
         if(param1 == null)
         {
            this.queueJobs.logMsg("Save all goals and scripts and various internal data");
            CityManager.cleanUpAndFlushAllTimingLists();
            this.queueJobs.dispatchEvent(new Event(SAVEALLEVENT));
         }
         else
         {
            for each(_loc2_ in MainScreen.getCities())
            {
               this.onSaveGoals(_loc2_.castleId,true);
               this.onSaveScript(_loc2_.castleId,true);
            }
         }
      }
      
      private function _CityPanel_DataGridColumn6_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Incoming";
         _loc1_.dataField = "col5";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn31_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Recall";
         _loc1_.width = 60;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory5_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn54_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Remain";
         _loc1_.dataField = "col6";
         _loc1_.width = 0.12;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn77_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Remain time";
         _loc1_.dataField = "col3";
         _loc1_.width = 95;
         return _loc1_;
      }
      
      private function _CityPanel_ClassFactory7_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory7 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory7",this._CityPanel_ClassFactory7);
         return _loc1_;
      }
      
      internal function onRunScript(param1:int) : void
      {
         var _loc2_:CityPanelBean = this.queueJobs.getCityPanelBean(param1);
         var _loc3_:Script = MainScreen.getCityFromCastleId(param1)._getScript();
         _loc2_.scriptIsRunning = true;
         _loc3_.set_m_script(_loc2_.scriptTxt);
      }
      
      [Bindable(event="propertyChange")]
      public function get _runButton() : Button
      {
         return this._1507357726_runButton;
      }
      
      public function setSelectedInfoTab(param1:String) : void
      {
         var _loc3_:Tab = null;
         var _loc2_:int = 0;
         for each(_loc3_ in this._infoTab.getChildren())
         {
            if(_loc3_.label == param1)
            {
               if(this._infoTab.selectedIndex != _loc2_)
               {
                  this._infoTab.selectedIndex = _loc2_;
               }
               break;
            }
            _loc2_++;
         }
      }
      
      private function _CityPanel_DataGridColumn42_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Upgrade";
         _loc1_.width = 75;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory7_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn5_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Days left";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.3;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      public function set _colony(param1:Canvas) : void
      {
         var _loc2_:Object = this._1353628185_colony;
         if(_loc2_ !== param1)
         {
            this._1353628185_colony = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_colony",_loc2_,param1));
         }
      }
      
      public function set _armies(param1:Canvas) : void
      {
         var _loc2_:Object = this._1299164186_armies;
         if(_loc2_ !== param1)
         {
            this._1299164186_armies = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_armies",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn65_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q9";
         _loc1_.dataField = "col9";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      public function _onViewHeroBtn(param1:Object) : void
      {
         var _loc2_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.HERO_MANAGEMENT_WIN);
         _loc2_.args = [param1];
         dispatchEvent(_loc2_);
      }
      
      public function ___showEnemiesV_change(param1:Event) : void
      {
         this.refresh_E_Tab();
      }
      
      public function ___CityPanel_Button4_click(param1:MouseEvent) : void
      {
         this.onSetGoals(this.castleId);
      }
      
      [Bindable(event="propertyChange")]
      public function get _armies() : Canvas
      {
         return this._1299164186_armies;
      }
      
      [Bindable(event="propertyChange")]
      public function get _scriptTxt() : TextArea
      {
         return this._1238975450_scriptTxt;
      }
      
      private function _CityPanel_ClassFactory6_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory6 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory6",this._CityPanel_ClassFactory6);
         return _loc1_;
      }
      
      internal function get castleId() : int
      {
         return this._cityPanelBean.castleId;
      }
      
      private function _CityPanel_DataGridColumn30_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Energy";
         _loc1_.dataField = "col5";
         _loc1_.width = 50;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn53_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Goal";
         _loc1_.dataField = "col5";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn76_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "From";
         _loc1_.dataField = "col2";
         _loc1_.width = 285;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      public function ___inputNewCastleName_enter(param1:FlexEvent) : void
      {
         this.onRename();
      }
      
      public function set _scriptTxt(param1:TextArea) : void
      {
         var _loc2_:Object = this._1238975450_scriptTxt;
         if(_loc2_ !== param1)
         {
            this._1238975450_scriptTxt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_scriptTxt",_loc2_,param1));
         }
      }
      
      public function set _runButton(param1:Button) : void
      {
         var _loc2_:Object = this._1507357726_runButton;
         if(_loc2_ !== param1)
         {
            this._1507357726_runButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_runButton",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _inputNewCastleName() : TextInput
      {
         return this._496434264_inputNewCastleName;
      }
      
      [Bindable(event="propertyChange")]
      public function get _trade() : Canvas
      {
         return this._1464576923_trade;
      }
      
      private function _CityPanel_DataGridColumn41_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Cooldown";
         _loc1_.dataField = "col5";
         _loc1_.width = 185;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn4_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Rate";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.15;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn64_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q8";
         _loc1_.dataField = "col8";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _valley() : Canvas
      {
         return this._1884649598_valley;
      }
      
      [Bindable(event="propertyChange")]
      public function get _troops() : Canvas
      {
         return this._1843183744_troops;
      }
      
      [Bindable(event="propertyChange")]
      private function get buildingData() : ArrayCollection
      {
         return this._982909826buildingData;
      }
      
      public function set _goalTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._1742425533_goalTab;
         if(_loc2_ !== param1)
         {
            this._1742425533_goalTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_goalTab",_loc2_,param1));
         }
      }
      
      private function _CityPanel_ClassFactory5_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory5 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory5",this._CityPanel_ClassFactory5);
         return _loc1_;
      }
      
      public function ___CityPanel_Button9_click(param1:MouseEvent) : void
      {
         this.onSaveToFile(this._scriptTxt);
      }
      
      private function _CityPanel_DataGridColumn52_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Queue";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.1;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn75_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Mission Type";
         _loc1_.dataField = "col1";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _allinfo() : ViewStack
      {
         return this._1446694032_allinfo;
      }
      
      public function ___clearTextBtn_click(param1:MouseEvent) : void
      {
         this._inputNewCastleName.text = "";
         this._inputNewCastleName.setFocus();
      }
      
      private function _CityPanel_DataGridColumn40_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Bonus";
         _loc1_.dataField = "col4";
         _loc1_.width = 65;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn3_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "All";
         _loc1_.dataField = "col6";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function set _inputNewCastleName(param1:TextInput) : void
      {
         var _loc2_:Object = this._496434264_inputNewCastleName;
         if(_loc2_ !== param1)
         {
            this._496434264_inputNewCastleName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_inputNewCastleName",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn63_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q7";
         _loc1_.dataField = "col7";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get _cityPanelBean() : CityPanelBean
      {
         return this._1127919786_cityPanelBean;
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
      
      [Bindable(event="propertyChange")]
      private function get fortificationsData() : ArrayCollection
      {
         return this._355347286fortificationsData;
      }
      
      public function setScriptState(param1:int, param2:Boolean) : void
      {
         this.queueJobs.getCityPanelBean(param1).scriptIsRunning = param2;
      }
      
      private function _CityPanel_ClassFactory4_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory4 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory4",this._CityPanel_ClassFactory4);
         return _loc1_;
      }
      
      public function set _trade(param1:Canvas) : void
      {
         var _loc2_:Object = this._1464576923_trade;
         if(_loc2_ !== param1)
         {
            this._1464576923_trade = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_trade",_loc2_,param1));
         }
      }
      
      private function get script() : Script
      {
         return this.city._getScript();
      }
      
      private function _CityPanel_DataGridColumn74_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "";
         _loc1_.width = 57;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory10_i();
         return _loc1_;
      }
      
      private function set _castleBean(param1:CastleBean) : void
      {
         var _loc2_:Object = this._1202148967_castleBean;
         if(_loc2_ !== param1)
         {
            this._1202148967_castleBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_castleBean",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn51_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "All";
         _loc1_.dataField = "col8";
         _loc1_.width = 0.12;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get resourceData() : ArrayCollection
      {
         return this._384864040resourceData;
      }
      
      [Bindable(event="propertyChange")]
      public function get _enemies() : Canvas
      {
         return this._752649447_enemies;
      }
      
      private function _CityPanel_DataGridColumn2_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Amount";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn62_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q6";
         _loc1_.dataField = "col6";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      public function set _valley(param1:Canvas) : void
      {
         var _loc2_:Object = this._1884649598_valley;
         if(_loc2_ !== param1)
         {
            this._1884649598_valley = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_valley",_loc2_,param1));
         }
      }
      
      private function onNewArmyBtn() : void
      {
         if(this._cityPanelBean.marchWin == null)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.TRAINING_FIELD_WIN));
         }
         else
         {
            PopUpWinManager.bringToFrontAndCenter(this._cityPanelBean.marchWin);
         }
      }
      
      public function set _troops(param1:Canvas) : void
      {
         var _loc2_:Object = this._1843183744_troops;
         if(_loc2_ !== param1)
         {
            this._1843183744_troops = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_troops",_loc2_,param1));
         }
      }
      
      private function set buildingData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._982909826buildingData;
         if(_loc2_ !== param1)
         {
            this._982909826buildingData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"buildingData",_loc2_,param1));
         }
      }
      
      public function ___CityPanel_Button3_click(param1:MouseEvent) : void
      {
         this.onLoadFromFile(this._goalsTxt);
      }
      
      private function _CityPanel_ClassFactory3_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory3 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory3",this._CityPanel_ClassFactory3);
         return _loc1_;
      }
      
      private function get queueJobs() : MainScreen
      {
         return parentDocument as MainScreen;
      }
      
      private function _CityPanel_DataGridColumn50_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Total";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.1;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn73_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Arrival";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      internal function init() : void
      {
         var xls:ExcelFile;
         var sheet:Sheet;
         this.timer = new Timer(5000);
         this.timer.addEventListener(TimerEvent.TIMER,this.populateInfoArea);
         this.timer.start();
         Utils.callLater(50,function():void
         {
            var _loc1_:Object = null;
            for each(_loc1_ in _allinfo.getChildren())
            {
               _loc1_.addEventListener(FlexEvent.SHOW,populateInfoArea);
            }
         });
         this.isInitialized = true;
      }
      
      public function setMarchWin(param1:NewArmyWin) : void
      {
         this._cityPanelBean.marchWin = param1;
      }
      
      private function set gearsData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2006530702gearsData;
         if(_loc2_ !== param1)
         {
            this._2006530702gearsData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gearsData",_loc2_,param1));
         }
      }
      
      public function set _allinfo(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1446694032_allinfo;
         if(_loc2_ !== param1)
         {
            this._1446694032_allinfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_allinfo",_loc2_,param1));
         }
      }
      
      private function set externalTroopData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._35298671externalTroopData;
         if(_loc2_ !== param1)
         {
            this._35298671externalTroopData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"externalTroopData",_loc2_,param1));
         }
      }
      
      private function onSaveGoals(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:SharedObject = SharedObject.getLocal("citygoals" + param1);
         _loc3_.data.now = this.queueJobs.getCityPanelBean(param1).goalsTxt;
         var _loc4_:String = _loc3_.flush();
         if(_loc4_ != "flushed")
         {
            this.city.cityManager.logMsg("SAVING PROBLEM: " + _loc4_ + ", you may need to increase flash local storage");
         }
         else if(!param2)
         {
            this.city.cityManager.logMsg("Goal has been saved successfully");
         }
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this._inputNewCastleName.text = "";
            this._inputNewCastleName.visible = false;
         }
      }
      
      private function _CityPanel_DataGridColumn1_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Resource";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      public function onMarchWinClosed(param1:int) : void
      {
         this.queueJobs.getCityPanelBean(param1).marchWin = null;
      }
      
      [Bindable(event="propertyChange")]
      private function get troopQueueData() : ArrayCollection
      {
         return this._1676058921troopQueueData;
      }
      
      private function _CityPanel_DataGridColumn61_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q5";
         _loc1_.dataField = "col5";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      private function _CityPanel_ClassFactory2_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory2 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory2",this._CityPanel_ClassFactory2);
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _showSelf() : CheckBox
      {
         return this._248346296_showSelf;
      }
      
      public function ___CityPanel_Button8_click(param1:MouseEvent) : void
      {
         this.onNewArmyBtn();
      }
      
      private function _CityPanel_DataGridColumn72_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Amount";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.3;
         return _loc1_;
      }
      
      public function set cityPanelBean(param1:CityPanelBean) : void
      {
         this._cityPanelBean = param1;
         if(this._cityPanelBean.marchWin != null)
         {
            PopUpWinManager.bringToFront(this._cityPanelBean.marchWin);
         }
      }
      
      public function set _showEnemies(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1839459670_showEnemies;
         if(_loc2_ !== param1)
         {
            this._1839459670_showEnemies = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showEnemies",_loc2_,param1));
         }
      }
      
      private function set troopsData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2009763499troopsData;
         if(_loc2_ !== param1)
         {
            this._2009763499troopsData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troopsData",_loc2_,param1));
         }
      }
      
      private function set _cityPanelBean(param1:CityPanelBean) : void
      {
         var _loc2_:Object = this._1127919786_cityPanelBean;
         if(_loc2_ !== param1)
         {
            this._1127919786_cityPanelBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cityPanelBean",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn19_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Type";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      public function _onRecallArmyBtn(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         this.city.cityManager.logMsg("Recalling friendly army with armyId: " + param1);
         ActionFactory.getInstance().getArmyCommands().callBackArmy(this.city.castleId,param1);
         if(this.externalTroopData != null)
         {
            Utils.callLater(3000,this.city.cityManager._populate_E_Tab,[this.externalTroopData,this._showEnemies ? this._showEnemies.selected : true,this._showEnemiesV ? this._showEnemiesV.selected : true,this._showEnemiesC ? this._showEnemiesC.selected : true,this._showFriendlies ? this._showFriendlies.selected : true,this._showSelf ? this._showSelf.selected : true]);
         }
      }
      
      private function set fortificationsData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._355347286fortificationsData;
         if(_loc2_ !== param1)
         {
            this._355347286fortificationsData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"fortificationsData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn60_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q4";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      internal function get city() : CityState
      {
         return MainScreen.getCityFromCastleId(this._cityPanelBean.castleId);
      }
      
      private function populateInfoArea(param1:Object = null) : void
      {
         var _loc2_:CityManager = this.city.cityManager;
         this._cityInfoProd.text = _loc2_.productionRate != -1 ? _loc2_.productionRate + "%" : "";
         if(param1 == null || this._allinfo.selectedChild == this._resource)
         {
            _loc2_._populate_R_Tab(this.resourceData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._valley)
         {
            _loc2_._populate_V_Tab(this.valleyData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._colony)
         {
            _loc2_._populate_C_Tab(this.colonyData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._innheroes)
         {
            _loc2_._populate_I_Tab(this.innHeroData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._heroes)
         {
            _loc2_._populate_H_Tab(this.heroData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._buildings)
         {
            _loc2_._populate_B_Tab(this.buildingData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._research)
         {
            _loc2_._populate_S_Tab(this.researchData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._gears)
         {
            _loc2_._populate_G_Tab(this.gearsData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._armies)
         {
            _loc2_._populate_A_Tab(this.armyData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._troops)
         {
            _loc2_._populate_T_Tab(this.troopsData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._troopQueues)
         {
            _loc2_._populate_Q_Tab(this.troopQueueData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._fortifications)
         {
            _loc2_._populate_F_Tab(this.fortificationsData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._trade)
         {
            _loc2_._populate_X_Tab(this.tradesData);
         }
         if(param1 == null || this._allinfo.selectedChild == this._enemies)
         {
            if(!(this._showEnemies == null || this._showEnemiesV == null || this._showEnemiesC == null || this._showFriendlies == null || this._showSelf == null))
            {
               _loc2_._populate_E_Tab(this.externalTroopData,this._showEnemies.selected,this._showEnemiesV.selected,this._showEnemiesC.selected,this._showFriendlies.selected,this._showSelf.selected);
            }
            else
            {
               _loc2_._populate_E_Tab(this.externalTroopData);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _resource() : Canvas
      {
         return this._250546835_resource;
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
      
      public function set _buildings(param1:Canvas) : void
      {
         var _loc2_:Object = this._1405697728_buildings;
         if(_loc2_ !== param1)
         {
            this._1405697728_buildings = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_buildings",_loc2_,param1));
         }
      }
      
      private function _CityPanel_ClassFactory11_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory11 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory11",this._CityPanel_ClassFactory11);
         return _loc1_;
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
      
      private function _CityPanel_ClassFactory1_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory1 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory1",this._CityPanel_ClassFactory1);
         return _loc1_;
      }
      
      private function set heroData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._619403580heroData;
         if(_loc2_ !== param1)
         {
            this._619403580heroData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"heroData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn71_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Resource";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function ___showFriendlies_change(param1:Event) : void
      {
         this.refresh_E_Tab();
      }
      
      [Bindable(event="propertyChange")]
      public function get _cityInfoProd() : Label
      {
         return this._1647526287_cityInfoProd;
      }
      
      public function set castleBean(param1:CastleBean) : void
      {
         this._castleBean = param1;
         this.populateInfoArea();
      }
      
      public function set _infoTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._8659656_infoTab;
         if(_loc2_ !== param1)
         {
            this._8659656_infoTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_infoTab",_loc2_,param1));
         }
      }
      
      internal function onUseArmyItem(param1:int, param2:int, param3:String) : void
      {
         ActionFactory.getInstance().getShopCommands().useTrickItem(param1,param2,param3);
      }
      
      private function logMsg(param1:String, param2:String = "#000000") : void
      {
         this.queueJobs.logMsg(param1,param2);
      }
      
      private function _CityPanel_DataGridColumn18_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Hero";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.2;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function set resourceData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._384864040resourceData;
         if(_loc2_ !== param1)
         {
            this._384864040resourceData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resourceData",_loc2_,param1));
         }
      }
      
      public function set _showEnemiesC(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1188674855_showEnemiesC;
         if(_loc2_ !== param1)
         {
            this._1188674855_showEnemiesC = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showEnemiesC",_loc2_,param1));
         }
      }
      
      private function onSaveToFile(param1:TextArea) : void
      {
         var outputFileName:String;
         var outputText:String;
         var saveFile:FileReference = null;
         var cP:CityPanelBean = null;
         var completedHandler:Function = null;
         var canceledHandler:Function = null;
         var errorHandler:Function = null;
         var source:TextArea = param1;
         if(source == null || source.text == "")
         {
            return;
         }
         outputText = source.text.replace(/\r\n?|\n/g,"\r\n");
         outputFileName = "";
         saveFile = null;
         cP = this._cityPanelBean;
         if(source.id == this._scriptTxt.id)
         {
            if(cP.lastSavedScriptFileName != null && cP.lastSavedScriptFileName != "")
            {
               outputFileName = cP.lastSavedScriptFileName;
            }
            else if(cP.lastLoadedScriptFileName != null && cP.lastLoadedScriptFileName != "")
            {
               outputFileName = cP.lastLoadedScriptFileName;
            }
            else
            {
               outputFileName = this.city.player.playerInfo.userName + "_" + this.city.castle.name + "_script.txt";
            }
         }
         if(source.id == this._goalsTxt.id)
         {
            if(cP.lastSavedGoalsFileName != null && cP.lastSavedGoalsFileName != "")
            {
               outputFileName = cP.lastSavedGoalsFileName;
            }
            else if(cP.lastLoadedGoalsFileName != null && cP.lastLoadedGoalsFileName != "")
            {
               outputFileName = cP.lastLoadedGoalsFileName;
            }
            else
            {
               outputFileName = this.city.player.playerInfo.userName + "_" + this.city.castle.name + "_goals.txt";
            }
         }
         saveFile = new FileReference();
         completedHandler = function(param1:Event):void
         {
            saveFile.removeEventListener(Event.COMPLETE,completedHandler);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            if(source.id == _scriptTxt.id)
            {
               cP.lastSavedScriptFileName = saveFile.name;
            }
            if(source.id == _goalsTxt.id)
            {
               cP.lastSavedGoalsFileName = saveFile.name;
            }
            city.cityManager.logMsg("The file \"" + saveFile.name + "\" has been saved successfully.");
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("The file has been saved successfully. " + param1);
            }
         };
         canceledHandler = function(param1:Event):void
         {
            saveFile.removeEventListener(Event.COMPLETE,completedHandler);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("The file save has been canceled. " + param1);
            }
         };
         errorHandler = function(param1:IOErrorEvent):void
         {
            saveFile.removeEventListener(Event.COMPLETE,completedHandler);
            saveFile.removeEventListener(Event.CANCEL,canceledHandler);
            saveFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile = null;
            if(Version.isTraceOn())
            {
               trace("An error occured while saving the file. " + param1);
            }
         };
         try
         {
            saveFile.addEventListener(Event.COMPLETE,completedHandler);
            saveFile.addEventListener(Event.CANCEL,canceledHandler);
            saveFile.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            saveFile.save(outputText,outputFileName);
         }
         catch(error:Error)
         {
            if(Version.isTraceOn())
            {
               trace(error);
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _troopQueues() : Canvas
      {
         return this._623064501_troopQueues;
      }
      
      private function _CityPanel_DataGridColumn29_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Base";
         _loc1_.dataField = "col4";
         _loc1_.width = 45;
         return _loc1_;
      }
      
      private function _CityPanel_ClassFactory10_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory10 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory10",this._CityPanel_ClassFactory10);
         return _loc1_;
      }
      
      public function ___CityPanel_Button2_click(param1:MouseEvent) : void
      {
         this.onSaveToFile(this._goalsTxt);
      }
      
      private function _CityPanel_DataGridColumn70_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "eXchange";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.2;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get innHeroData() : ArrayCollection
      {
         return this._1649235507innHeroData;
      }
      
      public function set _enemies(param1:Canvas) : void
      {
         var _loc2_:Object = this._752649447_enemies;
         if(_loc2_ !== param1)
         {
            this._752649447_enemies = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_enemies",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _innheroes() : Canvas
      {
         return this._1942092334_innheroes;
      }
      
      internal function _onRecallHeroBtn(param1:int) : void
      {
         this.city.cityManager.logMsg("Recalling hero with heroId: " + param1);
         ActionFactory.getInstance().getHeroCommand().callBackHero(this.city.castleId,param1);
         Utils.callLater(2500,this.city.cityManager._populate_H_Tab,[this.heroData]);
      }
      
      private function _CityPanel_DataGridColumn17_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Abandon";
         _loc1_.width = 0.2;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory2_i();
         return _loc1_;
      }
      
      public function set _showEnemiesV(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1188674836_showEnemiesV;
         if(_loc2_ !== param1)
         {
            this._1188674836_showEnemiesV = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showEnemiesV",_loc2_,param1));
         }
      }
      
      public function ___stopButton_click(param1:MouseEvent) : void
      {
         this.onStopScript();
      }
      
      private function set armyData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1415438617armyData;
         if(_loc2_ !== param1)
         {
            this._1415438617armyData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"armyData",_loc2_,param1));
         }
      }
      
      public function ___goalsTxt_change(param1:Event) : void
      {
         this.onTxtChange(this._goalsTxt);
      }
      
      public function ___renameBtn_click(param1:MouseEvent) : void
      {
         this.onRenameBtn();
      }
      
      public function set _research(param1:Canvas) : void
      {
         var _loc2_:Object = this._260377862_research;
         if(_loc2_ !== param1)
         {
            this._260377862_research = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_research",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn28_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Type";
         _loc1_.dataField = "col3";
         _loc1_.width = 80;
         return _loc1_;
      }
      
      private function onRename() : void
      {
         if(this._inputNewCastleName.text.length < 1 || this._inputNewCastleName.text == "" || this._inputNewCastleName.text == this._castleBean.name)
         {
            return;
         }
         ActionFactory.getInstance().getCityCommands().modifyCastleName(this.castleId,this._inputNewCastleName.text,this._castleBean.logUrl,this.onChangeNameResponse);
      }
      
      public function set _fortifications(param1:Canvas) : void
      {
         var _loc2_:Object = this._1472639233_fortifications;
         if(_loc2_ !== param1)
         {
            this._1472639233_fortifications = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_fortifications",_loc2_,param1));
         }
      }
      
      public function ___CityPanel_Button10_click(param1:MouseEvent) : void
      {
         this.onLoadFromFile(this._scriptTxt);
      }
      
      public function ___CityPanel_Canvas1_creationComplete(param1:FlexEvent) : void
      {
      }
      
      public function ___runButton_click(param1:MouseEvent) : void
      {
         this.onRunScript(this.castleId);
      }
      
      public function ___CityPanel_Button7_click(param1:MouseEvent) : void
      {
         this.onSaveAll();
      }
      
      private function getIdlePopColor(param1:int, param2:int) : String
      {
         return param1 - param2 >= 0 ? "0x00DA00" : (param1 - param2 < -100 ? "0xEC0000" : "0xDBDB00");
      }
      
      public function ___scriptTxt_change(param1:Event) : void
      {
         this.onTxtChange(this._scriptTxt);
      }
      
      private function _CityPanel_DataGridColumn16_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Event Time";
         _loc1_.dataField = "col5";
         _loc1_.width = 0.45;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn39_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Star";
         _loc1_.dataField = "col3";
         _loc1_.width = 50;
         return _loc1_;
      }
      
      private function refresh_E_Tab() : void
      {
         this.city.cityManager._populate_E_Tab(this.externalTroopData,this._showEnemies.selected,this._showEnemiesV.selected,this._showEnemiesC.selected,this._showFriendlies.selected,this._showSelf.selected);
      }
      
      [Bindable(event="propertyChange")]
      public function get _colony() : Canvas
      {
         return this._1353628185_colony;
      }
      
      private function _CityPanel_DataGridColumn27_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level";
         _loc1_.dataField = "col8";
         _loc1_.width = 45;
         return _loc1_;
      }
      
      internal function _onAbandonFieldBtn(param1:int) : void
      {
         this.queueJobs.logMsg("Abandon field: " + Map.fieldIdToString(param1));
         ActionFactory.getInstance().getFieldCommand().giveUpField(param1);
         Utils.callLater(2500,this.city.cityManager._populate_V_Tab,[this.valleyData]);
      }
      
      [Bindable(event="propertyChange")]
      public function get _goalTab() : TabBar
      {
         return this._1742425533_goalTab;
      }
      
      public function ___CityPanel_Button15_click(param1:MouseEvent) : void
      {
         this.onSaveAll();
      }
      
      private function onConfirmFireHero(param1:Boolean, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         this.city.cityManager.logMsg("Firing hero with heroId: " + param2);
         ActionFactory.getInstance().getHeroCommand().fireHero(this.city.castleId,param2);
         Utils.callLater(2500,this.city.cityManager._populate_H_Tab,[this.heroData]);
         this.city.cityManager.setHeroUpdateNeeded();
      }
      
      private function set troopQueueData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1676058921troopQueueData;
         if(_loc2_ !== param1)
         {
            this._1676058921troopQueueData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"troopQueueData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn15_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Relation";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.16;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn38_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level";
         _loc1_.dataField = "col2";
         _loc1_.width = 55;
         return _loc1_;
      }
      
      internal function onHideRename(param1:Object) : void
      {
         var evtObj:Object = param1;
         try
         {
            if(!this._inputNewCastleName.visible)
            {
               return;
            }
            if(evtObj == null)
            {
               return;
            }
            if(evtObj is UITextField)
            {
               if(Boolean(evtObj.parent) && Boolean(evtObj.parent.id) && evtObj.parent.id == "_inputNewCastleName")
               {
                  return;
               }
            }
            else if(Boolean(evtObj.id) && (evtObj.id == "_inputNewCastleName" || evtObj.id == "_clearTextBtn"))
            {
               return;
            }
            this._inputNewCastleName.text = "";
            this._inputNewCastleName.visible = false;
         }
         catch(error:Error)
         {
            if(Version.isTraceOn())
            {
               trace(error.message);
            }
         }
      }
      
      public function ___showSelf_change(param1:Event) : void
      {
         this.refresh_E_Tab();
      }
      
      internal function _hireHero(param1:String) : void
      {
         this.city.cityManager.logMsg("Hiring hero with Name: " + param1);
         CityStateCommands.hireHero(this.city.castleId,param1,this.onHireHeroResponse);
         Utils.callLater(2500,this.city.cityManager._populate_I_Tab,[this.innHeroData]);
      }
      
      [Bindable(event="propertyChange")]
      private function get _castleBean() : CastleBean
      {
         return this._1202148967_castleBean;
      }
      
      private function _CityPanel_DataGridColumn26_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Status";
         _loc1_.dataField = "col2";
         _loc1_.width = 55;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn49_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Avail";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.1;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      public function ___CityPanel_Button1_click(param1:MouseEvent) : void
      {
         this.onNewArmyBtn();
      }
      
      public function set _heroes(param1:Canvas) : void
      {
         var _loc2_:Object = this._1487717191_heroes;
         if(_loc2_ !== param1)
         {
            this._1487717191_heroes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_heroes",_loc2_,param1));
         }
      }
      
      public function set _showSelf(param1:CheckBox) : void
      {
         var _loc2_:Object = this._248346296_showSelf;
         if(_loc2_ !== param1)
         {
            this._248346296_showSelf = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showSelf",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get externalTroopData() : ArrayCollection
      {
         return this._35298671externalTroopData;
      }
      
      private function _CityPanel_DataGridColumn14_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Prestige";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.21;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn37_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Gear Name";
         _loc1_.dataField = "col1";
         _loc1_.width = 115;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get gearsData() : ArrayCollection
      {
         return this._2006530702gearsData;
      }
      
      [Bindable(event="propertyChange")]
      public function get _showEnemies() : CheckBox
      {
         return this._1839459670_showEnemies;
      }
      
      internal function _onAbandonColonyBtn(param1:int) : void
      {
         var _loc2_:ColonyBean = this.city.cityManager.getColony(param1);
         if(_loc2_ == null)
         {
            return;
         }
         this.queueJobs.logMsg("Begin abandon colony " + _loc2_.cityName + Map.fieldIdToCoordString(param1) + " by " + _loc2_.lordName + " of " + _loc2_.allianceName);
         ActionFactory.getInstance().getColonyCommands().abandonColony(this.city.castleId,_loc2_.castleId);
         Utils.callLater(2500,this.city.cityManager._populate_C_Tab,[this.colonyData]);
      }
      
      private function onStopScript() : void
      {
         this.queueJobs.logMsg("     Script Stopped");
         this.script.stop();
         this._cityPanelBean.scriptIsRunning = false;
      }
      
      private function _CityPanel_DataGridColumn25_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Hero";
         _loc1_.dataField = "col1";
         _loc1_.width = 90;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn48_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Troop";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.24;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _buildings() : Canvas
      {
         return this._1405697728_buildings;
      }
      
      [Bindable(event="propertyChange")]
      private function get troopsData() : ArrayCollection
      {
         return this._2009763499troopsData;
      }
      
      [Bindable(event="propertyChange")]
      private function get heroData() : ArrayCollection
      {
         return this._619403580heroData;
      }
      
      public function ___CityPanel_Button6_click(param1:MouseEvent) : void
      {
         this._cityPanelBean.onLoadGoals();
      }
      
      private function _CityPanel_DataGridColumn13_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Lord";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn36_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.35;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn59_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q3";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _infoTab() : TabBar
      {
         return this._8659656_infoTab;
      }
      
      private function _CityPanel_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _goalTab.enabled = param1;
         },"_goalTab.enabled");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._cityPanelBean.goalsTxt;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _goalsTxt.text = param1;
         },"_goalsTxt.text");
         result[1] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button1.enabled = param1;
         },"_CityPanel_Button1.enabled");
         result[2] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button2.enabled = param1;
         },"_CityPanel_Button2.enabled");
         result[3] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button3.enabled = param1;
         },"_CityPanel_Button3.enabled");
         result[4] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button4.enabled = param1;
         },"_CityPanel_Button4.enabled");
         result[5] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button5.enabled = param1;
         },"_CityPanel_Button5.enabled");
         result[6] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button6.enabled = param1;
         },"_CityPanel_Button6.enabled");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _CityPanel_Button7.enabled = param1;
         },"_CityPanel_Button7.enabled");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._cityPanelBean.scriptTxt;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _scriptTxt.text = param1;
         },"_scriptTxt.text");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return !this._cityPanelBean.scriptIsRunning;
         },function(param1:Boolean):void
         {
            _runButton.enabled = param1;
         },"_runButton.enabled");
         result[10] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._cityPanelBean.scriptIsRunning;
         },function(param1:Boolean):void
         {
            _stopButton.enabled = param1;
         },"_stopButton.enabled");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._castleBean.name.replace(new RegExp(String.fromCharCode(65279),"g"),"");
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Text1.text = param1;
         },"_CityPanel_Text1.text");
         result[12] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean.powerlevel == 4;
         },function(param1:Boolean):void
         {
            _renameBtn.visible = param1;
         },"_renameBtn.visible");
         result[13] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean.powerlevel == 4;
         },function(param1:Boolean):void
         {
            _renameBtn.includeInLayout = param1;
         },"_renameBtn.includeInLayout");
         result[14] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._inputNewCastleName.text.length > 0;
         },function(param1:Boolean):void
         {
            _clearTextBtn.visible = param1;
         },"_clearTextBtn.visible");
         result[15] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._castleBean.resource.support;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Label1.text = param1;
         },"_CityPanel_Label1.text");
         result[16] = binding;
         binding = new Binding(this,function():uint
         {
            return this.getLoyColor(this._castleBean.resource.support);
         },function(param1:uint):void
         {
            _CityPanel_Label1.setStyle("color",param1);
         },"_CityPanel_Label1.color");
         result[17] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._castleBean.resource.complaint;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Label3.text = param1;
         },"_CityPanel_Label3.text");
         result[18] = binding;
         binding = new Binding(this,function():uint
         {
            return this.getGrieveColor(this._castleBean.resource.complaint);
         },function(param1:uint):void
         {
            _CityPanel_Label3.setStyle("color",param1);
         },"_CityPanel_Label3.color");
         result[19] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._castleBean.resource.texRate + "%";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Label4.text = param1;
         },"_CityPanel_Label4.text");
         result[20] = binding;
         binding = new Binding(this,function():uint
         {
            return this.getTaxColor(this._castleBean.resource.texRate);
         },function(param1:uint):void
         {
            _CityPanel_Label4.setStyle("color",param1);
         },"_CityPanel_Label4.color");
         result[21] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Map.fieldIdToCoordString(this._castleBean.fieldId) + "  " + Map.getRegionName(this._castleBean.fieldId);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Text2.text = param1;
         },"_CityPanel_Text2.text");
         result[22] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this._castleBean.resource.curPopulation);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Label5.text = param1;
         },"_CityPanel_Label5.text");
         result[23] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatNum(this._castleBean.resource.curPopulation - this._castleBean.resource.workPeople);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _CityPanel_Label7.text = param1;
         },"_CityPanel_Label7.text");
         result[24] = binding;
         binding = new Binding(this,function():uint
         {
            return this.getIdlePopColor(this._castleBean.resource.curPopulation,this._castleBean.resource.workPeople);
         },function(param1:uint):void
         {
            _CityPanel_Label7.setStyle("color",param1);
         },"_CityPanel_Label7.color");
         result[25] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this._castleBean != null;
         },function(param1:Boolean):void
         {
            _infoTab.enabled = param1;
         },"_infoTab.enabled");
         result[26] = binding;
         binding = new Binding(this,function():Object
         {
            return this.resourceData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid1.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid1.dataProvider");
         result[27] = binding;
         binding = new Binding(this,function():Object
         {
            return this.valleyData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid1.dataProvider = param1;
         },"_CityPanel_DataGrid1.dataProvider");
         result[28] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent1;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory1.generator = param1;
         },"_CityPanel_ClassFactory1.generator");
         result[29] = binding;
         binding = new Binding(this,function():Object
         {
            return this.colonyData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid2.dataProvider = param1;
         },"_CityPanel_DataGrid2.dataProvider");
         result[30] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent0;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory2.generator = param1;
         },"_CityPanel_ClassFactory2.generator");
         result[31] = binding;
         binding = new Binding(this,function():Object
         {
            return this.innHeroData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid2.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid2.dataProvider");
         result[32] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent5;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory3.generator = param1;
         },"_CityPanel_ClassFactory3.generator");
         result[33] = binding;
         binding = new Binding(this,function():Object
         {
            return this.heroData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid3.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid3.dataProvider");
         result[34] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent2_3;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory4.generator = param1;
         },"_CityPanel_ClassFactory4.generator");
         result[35] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent2_1;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory5.generator = param1;
         },"_CityPanel_ClassFactory5.generator");
         result[36] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent2_2;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory6.generator = param1;
         },"_CityPanel_ClassFactory6.generator");
         result[37] = binding;
         binding = new Binding(this,function():Object
         {
            return this.buildingData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid3.dataProvider = param1;
         },"_CityPanel_DataGrid3.dataProvider");
         result[38] = binding;
         binding = new Binding(this,function():Object
         {
            return this.researchData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid4.dataProvider = param1;
         },"_CityPanel_DataGrid4.dataProvider");
         result[39] = binding;
         binding = new Binding(this,function():Object
         {
            return this.gearsData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid5.dataProvider = param1;
         },"_CityPanel_DataGrid5.dataProvider");
         result[40] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent7;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory7.generator = param1;
         },"_CityPanel_ClassFactory7.generator");
         result[41] = binding;
         binding = new Binding(this,function():Object
         {
            return this.armyData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid4.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid4.dataProvider");
         result[42] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent6;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory8.generator = param1;
         },"_CityPanel_ClassFactory8.generator");
         result[43] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent3;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory9.generator = param1;
         },"_CityPanel_ClassFactory9.generator");
         result[44] = binding;
         binding = new Binding(this,function():Object
         {
            return this.troopsData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid5.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid5.dataProvider");
         result[45] = binding;
         binding = new Binding(this,function():Object
         {
            return this.troopQueueData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid6.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid6.dataProvider");
         result[46] = binding;
         binding = new Binding(this,function():Object
         {
            return this.fortificationsData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid6.dataProvider = param1;
         },"_CityPanel_DataGrid6.dataProvider");
         result[47] = binding;
         binding = new Binding(this,function():Object
         {
            return this.tradesData;
         },function(param1:Object):void
         {
            _CityPanel_DataGrid7.dataProvider = param1;
         },"_CityPanel_DataGrid7.dataProvider");
         result[48] = binding;
         binding = new Binding(this,function():Object
         {
            return this.externalTroopData;
         },function(param1:Object):void
         {
            _CityPanel_RowColorDataGrid7.dataProvider = param1;
         },"_CityPanel_RowColorDataGrid7.dataProvider");
         result[49] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent6;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory10.generator = param1;
         },"_CityPanel_ClassFactory10.generator");
         result[50] = binding;
         binding = new Binding(this,function():Class
         {
            return CityPanel_inlineComponent4;
         },function(param1:Class):void
         {
            _CityPanel_ClassFactory11.generator = param1;
         },"_CityPanel_ClassFactory11.generator");
         result[51] = binding;
         return result;
      }
      
      public function ___inputNewCastleName_keyDown(param1:KeyboardEvent) : void
      {
         this.keyDownHandle(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _showEnemiesC() : CheckBox
      {
         return this._1188674855_showEnemiesC;
      }
      
      public function set _resource(param1:Canvas) : void
      {
         var _loc2_:Object = this._250546835_resource;
         if(_loc2_ !== param1)
         {
            this._250546835_resource = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_resource",_loc2_,param1));
         }
      }
      
      public function set _stopButton(param1:Button) : void
      {
         var _loc2_:Object = this._746461325_stopButton;
         if(_loc2_ !== param1)
         {
            this._746461325_stopButton = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_stopButton",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get armyData() : ArrayCollection
      {
         return this._1415438617armyData;
      }
      
      [Bindable(event="propertyChange")]
      public function get _showEnemiesV() : CheckBox
      {
         return this._1188674836_showEnemiesV;
      }
      
      private function onLoadFromFile(param1:TextArea) : void
      {
         var loadFile:FileReference = null;
         var cP:CityPanelBean = null;
         var selectedHandler:Function = null;
         var canceledHandler:Function = null;
         var completeHandler:Function = null;
         var errorHandler:Function = null;
         var target:TextArea = param1;
         loadFile = null;
         cP = this._cityPanelBean;
         selectedHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.SELECT,selectedHandler);
            loadFile.removeEventListener(Event.CANCEL,canceledHandler);
            loadFile.addEventListener(Event.COMPLETE,completeHandler);
            loadFile.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            loadFile.load();
         };
         canceledHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.SELECT,selectedHandler);
            loadFile.removeEventListener(Event.CANCEL,canceledHandler);
            if(Version.isTraceOn())
            {
               trace("The file load has been canceled. " + param1);
            }
            loadFile = null;
         };
         completeHandler = function(param1:Event):void
         {
            loadFile.removeEventListener(Event.COMPLETE,completeHandler);
            loadFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            var _loc2_:String = loadFile.data.readUTFBytes(loadFile.data.bytesAvailable).replace(/\r\n?|\n/g,"\n");
            if(target.id == _scriptTxt.id)
            {
               cP.scriptTxt = _loc2_;
               cP.lastLoadedScriptFileName = loadFile.name;
            }
            if(target.id == _goalsTxt.id)
            {
               cP.goalsTxt = _loc2_;
               cP.lastLoadedGoalsFileName = loadFile.name;
            }
            city.cityManager.logMsg("The contents of file \"" + loadFile.name + "\" was loaded successfully to the " + (target.id == _scriptTxt.id ? "Script" : (target.id == _goalsTxt.id ? "Goals" : "")) + " window.");
            loadFile = null;
         };
         errorHandler = function(param1:IOErrorEvent):void
         {
            loadFile.removeEventListener(Event.COMPLETE,completeHandler);
            loadFile.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
            if(Version.isTraceOn())
            {
               trace("Error loading file : " + param1.text);
            }
            city.cityManager.logMsg("An error occured while loading the file. " + param1,"#FF9933");
            loadFile = null;
         };
         loadFile = new FileReference();
         loadFile.addEventListener(Event.SELECT,selectedHandler);
         loadFile.addEventListener(Event.CANCEL,canceledHandler);
         loadFile.browse([new FileFilter("Text File","*.txt;*.text")]);
      }
      
      private function _CityPanel_DataGridColumn24_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "";
         _loc1_.width = 50;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory4_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn47_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Recall";
         _loc1_.width = 65;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory9_i();
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _research() : Canvas
      {
         return this._260377862_research;
      }
      
      [Bindable(event="propertyChange")]
      public function get _fortifications() : Canvas
      {
         return this._1472639233_fortifications;
      }
      
      public function ___showEnemies_change(param1:Event) : void
      {
         this.refresh_E_Tab();
      }
      
      public function ___CityPanel_Button14_click(param1:MouseEvent) : void
      {
         this._cityPanelBean.onLoadScript();
      }
      
      private function _CityPanel_DataGridColumn12_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Coord";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.18;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn35_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Research Name";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn58_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q2";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      public function set _showFriendlies(param1:CheckBox) : void
      {
         var _loc2_:Object = this._1321633669_showFriendlies;
         if(_loc2_ !== param1)
         {
            this._1321633669_showFriendlies = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_showFriendlies",_loc2_,param1));
         }
      }
      
      public function set _cityInfoProd(param1:Label) : void
      {
         var _loc2_:Object = this._1647526287_cityInfoProd;
         if(_loc2_ !== param1)
         {
            this._1647526287_cityInfoProd = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_cityInfoProd",_loc2_,param1));
         }
      }
      
      private function onRenameBtn() : void
      {
         this._inputNewCastleName.visible = true;
         this._inputNewCastleName.text = this._castleBean.name;
         this._inputNewCastleName.setFocus();
         Utils.callLater(100,function():void
         {
            _inputNewCastleName.selectionBeginIndex = 0;
            _inputNewCastleName.selectionEndIndex = _castleBean.name.length;
         });
      }
      
      private function onTxtChange(param1:TextArea) : void
      {
         var _loc2_:String = "." + param1.styleName;
         param1.setStyle("color","#" + int(ThemeManager.getStyle(_loc2_,"color")).toString(16).toUpperCase());
         param1.setStyle("fontFamily","" + ThemeManager.getStyle(_loc2_,"fontFamily"));
         this._cityPanelBean[param1.id.substr(1)] = param1.text;
      }
      
      private function getLoyColor(param1:int) : String
      {
         return param1 == 100 ? "0x00DA00" : (param1 <= 25 ? "0xEC0000" : "0xDBDB00");
      }
      
      private function onGearResearchResponse(param1:ResearchResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            this.city.cityManager.logMsg("An error was received while upgrading gear: " + param1.errorMsg + ": " + param1.ok,"#CC0000");
            return;
         }
         if(param1.tech.castleId != this.city.castleId)
         {
            return;
         }
         this.city.cityManager._handleGearCmdResponse(param1);
         var _loc2_:Date = new Date(param1.tech.endTime);
         this.city.cityManager.logMsg(GearType.toNameString(param1.tech.typeId) + " level " + (param1.tech.level + 1) + " research started.  Estimated finish time " + _loc2_.toLocaleString(),"");
      }
      
      private function _CityPanel_DataGridColumn23_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Hire";
         _loc1_.width = 0.12;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory3_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn9_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn69_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "In Queues";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.25;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _heroes() : Canvas
      {
         return this._1487717191_heroes;
      }
      
      internal function unInit() : void
      {
         var _loc1_:Object = null;
         this.timer.stop();
         this.timer.removeEventListener(TimerEvent.TIMER,this.populateInfoArea);
         this.timer = null;
         for each(_loc1_ in this._allinfo.getChildren())
         {
            _loc1_.removeEventListener(FlexEvent.SHOW,this.populateInfoArea);
         }
      }
      
      private function _CityPanel_DataGridColumn11_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Abandon";
         _loc1_.width = 0.2;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory1_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn34_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Level(s)";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.6;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn57_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q1";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      private function set valleyData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1626662999valleyData;
         if(_loc2_ !== param1)
         {
            this._1626662999valleyData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"valleyData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn46_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Remain time";
         _loc1_.dataField = "col3";
         _loc1_.width = 95;
         return _loc1_;
      }
      
      public function set _troopQueues(param1:Canvas) : void
      {
         var _loc2_:Object = this._623064501_troopQueues;
         if(_loc2_ !== param1)
         {
            this._623064501_troopQueues = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_troopQueues",_loc2_,param1));
         }
      }
      
      private function onHireHeroResponse(param1:CommandResponse) : void
      {
         this.city.cityManager.updateInn();
         if(param1.ok != 1)
         {
            this.city.cityManager.logMsg("An error occurred during hire hero: " + param1.errorMsg);
         }
      }
      
      private function _CityPanel_DataGridColumn22_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Base";
         _loc1_.dataField = "col5";
         _loc1_.width = 0.16;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn45_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Target";
         _loc1_.dataField = "col2";
         _loc1_.width = 285;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn8_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Type";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get _stopButton() : Button
      {
         return this._746461325_stopButton;
      }
      
      public function onSetGoals(param1:int) : void
      {
         var _loc2_:CityPanelBean = this.queueJobs.getCityPanelBean(param1);
         if(Utils.trim(_loc2_.goalsTxt) == "")
         {
            _loc2_.goalsTxt = "include default";
         }
         else
         {
            _loc2_.goalsTxt = _loc2_.goalsTxt.replace(/;/g,":");
         }
         MainScreen.getCityFromCastleId(param1).cityManager._readGoals(_loc2_.goalsTxt);
         this.queueJobs.doCityTabLabel(param1);
      }
      
      private function set colonyData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1197740996colonyData;
         if(_loc2_ !== param1)
         {
            this._1197740996colonyData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colonyData",_loc2_,param1));
         }
      }
      
      public function set _gears(param1:Canvas) : void
      {
         var _loc2_:Object = this._1476969531_gears;
         if(_loc2_ !== param1)
         {
            this._1476969531_gears = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_gears",_loc2_,param1));
         }
      }
      
      private function _CityPanel_ClassFactory9_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory9 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory9",this._CityPanel_ClassFactory9);
         return _loc1_;
      }
      
      internal function _onFireHeroBtn(param1:int) : void
      {
         var _loc2_:HeroBean = this.city.findHeroById(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.level >= 100 || _loc2_.management - _loc2_.level + _loc2_.remainPoint > 65 || _loc2_.power - _loc2_.level + _loc2_.remainPoint > 65 || _loc2_.stratagem - _loc2_.level + _loc2_.remainPoint > 65)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to fire this hero?\n" + _loc2_.name + "(" + _loc2_.level + ") " + _loc2_.management + "/" + _loc2_.power + "/" + _loc2_.stratagem,this.onConfirmFireHero,"Yes","No",[param1]));
         }
         else
         {
            this.onConfirmFireHero(true,param1);
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CityPanel = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CityPanel_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanelWatcherSetupUtil");
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
      public function get _showFriendlies() : CheckBox
      {
         return this._1321633669_showFriendlies;
      }
      
      private function _CityPanel_DataGridColumn10_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Distance";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      public function ___CityPanel_Button5_click(param1:MouseEvent) : void
      {
         this.onSaveGoals(this.castleId);
      }
      
      private function set innHeroData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1649235507innHeroData;
         if(_loc2_ !== param1)
         {
            this._1649235507innHeroData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"innHeroData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn68_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Available";
         _loc1_.dataField = "col2";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      public function set _innheroes(param1:Canvas) : void
      {
         var _loc2_:Object = this._1942092334_innheroes;
         if(_loc2_ !== param1)
         {
            this._1942092334_innheroes = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_innheroes",_loc2_,param1));
         }
      }
      
      private function getGrieveColor(param1:int) : String
      {
         return param1 == 0 ? "0x00DA00" : (param1 >= 75 ? "0xEC0000" : "0xDBDB00");
      }
      
      private function _CityPanel_DataGridColumn56_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "B/Pos";
         _loc1_.dataField = "col0";
         _loc1_.width = 0.1;
         _loc1_.showDataTips = true;
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get valleyData() : ArrayCollection
      {
         return this._1626662999valleyData;
      }
      
      internal function _onGearUpgradeBtn(param1:int) : void
      {
         this.city.cityManager.logMsg("Upgrade gear: " + GearType.toNameString(param1) + " to level " + (this.city.cityManager.getGearLevel(param1) + 1));
         ActionFactory.getInstance().getEquipmenttechCommands().research(this.city.castleId,param1,this.onGearResearchResponse);
         Utils.callLater(2500,this.city.cityManager._populate_G_Tab,[this.gearsData]);
      }
      
      private function _CityPanel_DataGridColumn21_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Stats";
         _loc1_.dataField = "col4";
         _loc1_.width = 0.16;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn44_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Army";
         _loc1_.dataField = "col1";
         _loc1_.width = 100;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn7_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Coord";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.2;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn33_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Building";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.3;
         return _loc1_;
      }
      
      private function set tradesData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1892696025tradesData;
         if(_loc2_ !== param1)
         {
            this._1892696025tradesData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tradesData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_DataGridColumn67_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Fortification";
         _loc1_.dataField = "col1";
         _loc1_.width = 0.25;
         return _loc1_;
      }
      
      public function _onViewArmyBtn(param1:int, param2:Object) : void
      {
         var _loc3_:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ARMY_DETAILS_WIN);
         _loc3_.args = [param1,param2.col5,param2.col6,this.onUseArmyItem];
         dispatchEvent(_loc3_);
      }
      
      [Bindable(event="propertyChange")]
      private function get colonyData() : ArrayCollection
      {
         return this._1197740996colonyData;
      }
      
      [Bindable(event="propertyChange")]
      public function get _gears() : Canvas
      {
         return this._1476969531_gears;
      }
      
      private function set researchData(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._16113637researchData;
         if(_loc2_ !== param1)
         {
            this._16113637researchData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"researchData",_loc2_,param1));
         }
      }
      
      private function _CityPanel_ClassFactory8_i() : ClassFactory
      {
         var _loc1_:ClassFactory = new ClassFactory();
         this._CityPanel_ClassFactory8 = _loc1_;
         BindingManager.executeBindings(this,"_CityPanel_ClassFactory8",this._CityPanel_ClassFactory8);
         return _loc1_;
      }
      
      public function ___showEnemiesC_change(param1:Event) : void
      {
         this.refresh_E_Tab();
      }
      
      private function _CityPanel_DataGridColumn55_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Reinf.";
         _loc1_.dataField = "col7";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn78_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Recall";
         _loc1_.width = 65;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory11_i();
         return _loc1_;
      }
      
      public function ___CityPanel_Button13_click(param1:MouseEvent) : void
      {
         this.onSaveScript(this.castleId);
      }
      
      private function _CityPanel_DataGridColumn32_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Fire";
         _loc1_.width = 48;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory6_i();
         return _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      private function get tradesData() : ArrayCollection
      {
         return this._1892696025tradesData;
      }
      
      public function set _goalsTxt(param1:TextArea) : void
      {
         var _loc2_:Object = this._1820295151_goalsTxt;
         if(_loc2_ !== param1)
         {
            this._1820295151_goalsTxt = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_goalsTxt",_loc2_,param1));
         }
      }
      
      public function set _alltasks(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1907625964_alltasks;
         if(_loc2_ !== param1)
         {
            this._1907625964_alltasks = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_alltasks",_loc2_,param1));
         }
      }
      
      public function _onRecallSelfArmyBtn(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         this.city.cityManager.logMsg("Recall self army with armyId: " + param1);
         ActionFactory.getInstance().getArmyCommands().callBackArmy(this.city.castleId,param1);
         Utils.callLater(2500,this.city.cityManager._populate_A_Tab,[this.armyData]);
      }
      
      [Bindable(event="propertyChange")]
      private function get researchData() : ArrayCollection
      {
         return this._16113637researchData;
      }
      
      private function onSaveScript(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:SharedObject = SharedObject.getLocal("citytab" + param1);
         _loc3_.data.now = this.queueJobs.getCityPanelBean(param1).scriptTxt;
         var _loc4_:String = _loc3_.flush();
         if(_loc4_ != "flushed")
         {
            this.city.cityManager.logMsg("SAVING PROBLEM: " + _loc4_ + ", you may need to adjust flash settings to increase local storage");
         }
         else if(!param2)
         {
            this.city.cityManager.logMsg("Script has been saved successfully");
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _alltasks() : ViewStack
      {
         return this._1907625964_alltasks;
      }
      
      private function _CityPanel_DataGridColumn20_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Lvl";
         _loc1_.dataField = "col3";
         _loc1_.width = 0.08;
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn43_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "";
         _loc1_.width = 57;
         _loc1_.itemRenderer = this._CityPanel_ClassFactory8_i();
         return _loc1_;
      }
      
      private function _CityPanel_DataGridColumn66_c() : DataGridColumn
      {
         var _loc1_:DataGridColumn = new DataGridColumn();
         _loc1_.headerText = "Q10";
         _loc1_.dataField = "col10";
         _loc1_.width = 0.1;
         return _loc1_;
      }
      
      private function getTaxColor(param1:int) : String
      {
         return param1 == 0 ? "0x00DA00" : (param1 >= 75 ? "0xEC0000" : "0xDBDB00");
      }
      
      [Bindable(event="propertyChange")]
      public function get _goalsTxt() : TextArea
      {
         return this._1820295151_goalsTxt;
      }
      
      private function onChangeNameResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error renaming castle: " + param1.errorMsg));
         }
         else
         {
            this._castleBean.name = this._inputNewCastleName.text;
            this._inputNewCastleName.text = "";
            this._inputNewCastleName.visible = false;
            this.queueJobs.doCityTabLabel(this._castleBean.id);
         }
      }
      
      private function _CityPanel_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._cityPanelBean.goalsTxt;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._castleBean != null;
         _loc1_ = this._cityPanelBean.scriptTxt;
         _loc1_ = !this._cityPanelBean.scriptIsRunning;
         _loc1_ = this._cityPanelBean.scriptIsRunning;
         _loc1_ = this._castleBean.name.replace(new RegExp(String.fromCharCode(65279),"g"),"");
         _loc1_ = this._castleBean.powerlevel == 4;
         _loc1_ = this._castleBean.powerlevel == 4;
         _loc1_ = this._inputNewCastleName.text.length > 0;
         _loc1_ = this._castleBean.resource.support;
         _loc1_ = this.getLoyColor(this._castleBean.resource.support);
         _loc1_ = this._castleBean.resource.complaint;
         _loc1_ = this.getGrieveColor(this._castleBean.resource.complaint);
         _loc1_ = this._castleBean.resource.texRate + "%";
         _loc1_ = this.getTaxColor(this._castleBean.resource.texRate);
         _loc1_ = Map.fieldIdToCoordString(this._castleBean.fieldId) + "  " + Map.getRegionName(this._castleBean.fieldId);
         _loc1_ = Utils.formatNum(this._castleBean.resource.curPopulation);
         _loc1_ = Utils.formatNum(this._castleBean.resource.curPopulation - this._castleBean.resource.workPeople);
         _loc1_ = this.getIdlePopColor(this._castleBean.resource.curPopulation,this._castleBean.resource.workPeople);
         _loc1_ = this._castleBean != null;
         _loc1_ = this.resourceData;
         _loc1_ = this.valleyData;
         _loc1_ = CityPanel_inlineComponent1;
         _loc1_ = this.colonyData;
         _loc1_ = CityPanel_inlineComponent0;
         _loc1_ = this.innHeroData;
         _loc1_ = CityPanel_inlineComponent5;
         _loc1_ = this.heroData;
         _loc1_ = CityPanel_inlineComponent2_3;
         _loc1_ = CityPanel_inlineComponent2_1;
         _loc1_ = CityPanel_inlineComponent2_2;
         _loc1_ = this.buildingData;
         _loc1_ = this.researchData;
         _loc1_ = this.gearsData;
         _loc1_ = CityPanel_inlineComponent7;
         _loc1_ = this.armyData;
         _loc1_ = CityPanel_inlineComponent6;
         _loc1_ = CityPanel_inlineComponent3;
         _loc1_ = this.troopsData;
         _loc1_ = this.troopQueueData;
         _loc1_ = this.fortificationsData;
         _loc1_ = this.tradesData;
         _loc1_ = this.externalTroopData;
         _loc1_ = CityPanel_inlineComponent6;
         _loc1_ = CityPanel_inlineComponent4;
      }
   }
}

