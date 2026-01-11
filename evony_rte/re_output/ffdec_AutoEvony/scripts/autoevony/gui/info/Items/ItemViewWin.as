package autoevony.gui.info.Items
{
   import autoevony.common.Items;
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import autoevony.player.LoginHelper;
   import autoevony.player.Map;
   import autoevony.scripts.CityState;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.DisappearHeroBean;
   import com.evony.common.beans.ItemBean;
   import com.evony.common.beans.ZoneInfoBean;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.common.ZoneInfoResponse;
   import com.evony.common.module.hero.DisappearHeroResponse;
   import com.evony.common.module.shop.UseItemResultResponse;
   import com.evony.common.server.events.ItemUpdate;
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
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.ComboBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.controls.TextArea;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class ItemViewWin extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static var prevValues:ObjectProxy = new ObjectProxy({});
      
      public var _ItemViewWin_HBox7:HBox;
      
      private var _847922810zoneInfo:ArrayCollection = null;
      
      private var _1330884373_buyBtn:Button;
      
      private var _1579933872_zone_Select:ComboBox;
      
      private var _2053243474_useCountInput1:ItemCountInput;
      
      private var pleaseStop:Boolean = true;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":364,
               "width":500,
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
                     return {"windowTitle":"Item View"};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "height":364,
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "15";
                              this.top = "50";
                              this.right = "15";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":74,
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":64,
                                          "height":64,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Image,
                                             "id":"_ItemViewWin_Image1",
                                             "events":{"complete":"___ItemViewWin_Image1_complete"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":64,
                                                   "height":64
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ItemViewWin_Text1",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "73";
                                       this.top = "4";
                                       this.right = "5";
                                       this.textAlign = "center";
                                       this.verticalCenter = "middle";
                                       this.fontSize = 16;
                                       this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"cityTopInfoText"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ItemViewWin_Label1",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "73";
                                       this.top = "28";
                                       this.right = "5";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"newArmyTroop"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ItemViewWin_Label2",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "73";
                                       this.top = "50";
                                       this.right = "85";
                                       this.textAlign = "center";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"newArmyTroop"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_buyBtn",
                                    "events":{"click":"___buyBtn_click"},
                                    "stylesFactory":function():void
                                    {
                                       this.right = "5";
                                       this.bottom = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Buy More",
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
                              this.left = "15";
                              this.top = "130";
                              this.right = "15";
                              this.bottom = "51";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_itemDescArea",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "5";
                                       this.right = "5";
                                       this.bottom = "5";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"styleName":"newArmyTroop"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_useItemResultsArea",
                                    "stylesFactory":function():void
                                    {
                                       this.left = "3";
                                       this.top = "3";
                                       this.right = "3";
                                       this.bottom = "3";
                                       this.backgroundAlpha = 0;
                                       this.borderThickness = 0;
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "visible":false,
                                          "text":"",
                                          "editable":false,
                                          "styleName":"newArmyTroop"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox2",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":VBox,
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
                                                   "percentHeight":100,
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
                                                            "text":"Players:",
                                                            "percentWidth":100,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Number of Cities:",
                                                            "percentWidth":100,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "right";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "text":"Player Rate:",
                                                            "percentWidth":100,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   })]
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":VBox,
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
                                                   "percentHeight":100,
                                                   "horizontalScrollPolicy":"off",
                                                   "verticalScrollPolicy":"off",
                                                   "childDescriptors":[new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_ItemViewWin_Label6",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_ItemViewWin_Label7",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
                                                            "styleName":"newArmyTroop"
                                                         };
                                                      }
                                                   }),new UIComponentDescriptor({
                                                      "type":Label,
                                                      "id":"_ItemViewWin_Label8",
                                                      "stylesFactory":function():void
                                                      {
                                                         this.textAlign = "left";
                                                      },
                                                      "propertiesFactory":function():Object
                                                      {
                                                         return {
                                                            "percentWidth":100,
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
                              this.left = "15";
                              this.right = "15";
                              this.bottom = "10";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":35,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox3",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"How many to use?",
                                                   "styleName":"newArmyTroop"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ItemCountInput,
                                             "id":"_useCountInput1"
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox4",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"Enter target coordinate:",
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
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox5",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"Enter target player name:",
                                                   "styleName":"newArmyTroop"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":TextInput,
                                             "id":"_pName",
                                             "events":{"change":"___pName_change"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":100,
                                                   "height":22,
                                                   "text":"",
                                                   "restrict":"_ A-Za-z0-9",
                                                   "styleName":"textInput"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox6",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"Select a state or choose random:",
                                                   "styleName":"newArmyTroop"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ComboBox,
                                             "id":"_zone_Select",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":135,
                                                   "styleName":"ComboBox"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox7",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Label,
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "text":"Select which hero to rescue:",
                                                   "styleName":"newArmyTroop"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":ComboBox,
                                             "id":"_dh_Select",
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "width":150,
                                                   "styleName":"ComboBox"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_useBtnArea",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":120,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_useBtn",
                                             "events":{"click":"___useBtn_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Use",
                                                   "styleName":"REwinBtn"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemViewWin_HBox9",
                                    "stylesFactory":function():void
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
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "width":120,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off",
                                          "childDescriptors":[new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_closeBtn",
                                             "events":{"click":"___closeBtn_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Close",
                                                   "styleName":"REwinBtn"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Button,
                                             "id":"_openBtn",
                                             "events":{"click":"___openBtn_click"},
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "label":"Open",
                                                   "styleName":"REwinBtn"
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
                  "type":Button,
                  "id":"_closeWinBtn",
                  "events":{"click":"___closeWinBtn_click"},
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
      
      public var _ItemViewWin_HBox4:HBox;
      
      private var _1469343204_pName:TextInput;
      
      private var howManyUsed:int = 0;
      
      private var _458286896_itemDescArea:Text;
      
      private var _344839367_closeWinBtn:Button;
      
      public var _ItemViewWin_Text1:Text;
      
      public var _ItemViewWin_Image1:Image;
      
      private var _1183315619_closeBtn:Button;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var howManyToUse:int = 0;
      
      private var timeOutTimer:Timer = null;
      
      private var _327260383_useBtnArea:HBox;
      
      private var _2041142742disappearHeros:ArrayCollection = null;
      
      private var _95768648_dh_Select:ComboBox;
      
      mx_internal var _watchers:Array = [];
      
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
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindings:Array = [];
      
      private var _1948436464_yInput:TextInput;
      
      public var _ItemViewWin_HBox2:HBox;
      
      public var _ItemViewWin_HBox3:HBox;
      
      public var _ItemViewWin_HBox5:HBox;
      
      public var _ItemViewWin_HBox6:HBox;
      
      public var _ItemViewWin_HBox9:HBox;
      
      private var _1872395380_useBtn:Button;
      
      public function ItemViewWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 364;
         this.width = 500;
         this.addEventListener("creationComplete",this.___ItemViewWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ItemViewWin._watcherSetupUtil = param1;
      }
      
      private function getIconUrl(param1:String) : String
      {
         return "http://e2.eimg.us/" + param1;
      }
      
      private function getRandomZone() : ZoneInfoBean
      {
         return ZoneInfoBean(this.zoneInfo.getItemAt(int(Math.random() * 16)).data);
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
      
      private function showRescueHeroSelector(param1:String) : Boolean
      {
         return this.isSoF(param1);
      }
      
      private function isCastleItem(param1:String) : Boolean
      {
         return param1 == "player.halloween.castle" || param1 == "player.halloween.castle.adv" || param1 == "player.haunted.castle" || param1 == "player.haunted.castle.adv";
      }
      
      private function onGetDisappearHerosResponse(param1:DisappearHeroResponse) : void
      {
         var _loc2_:DisappearHeroBean = null;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + ": " + param1.ok));
         }
         else
         {
            if(this.disappearHeros == null)
            {
               this.disappearHeros = new ArrayCollection();
            }
            else
            {
               this.disappearHeros.removeAll();
            }
            for each(_loc2_ in param1.herosArray)
            {
               this.disappearHeros.addItem({
                  "label":"[" + _loc2_.id + "] " + _loc2_.name + "(" + _loc2_.level + ")" + " " + _loc2_.management + "/" + _loc2_.power + "/" + _loc2_.stratagem,
                  "data":_loc2_.id
               });
            }
         }
      }
      
      private function init() : void
      {
      }
      
      private function isDream(param1:String) : Boolean
      {
         return param1 == "player.truce.dream";
      }
      
      [Bindable(event="propertyChange")]
      public function get _yInput() : TextInput
      {
         return this._1948436464_yInput;
      }
      
      private function onUseBtn(param1:String = "") : void
      {
         var _loc4_:int = 0;
         if(this._useBtnArea.visible && this._useBtn.label == "Cancel")
         {
            this.pleaseStop = true;
            return;
         }
         var _loc2_:String = this.itemData.id;
         if(this.isGateControl(_loc2_))
         {
            this._openBtn.enabled = false;
            this._closeBtn.enabled = false;
         }
         else
         {
            this._useBtn.enabled = false;
         }
         this._closeWinBtn.enabled = false;
         if(this.showCoordFields(_loc2_))
         {
            prevValues[_loc2_.split(".").join("_")] = this._xInput.text + "," + this._yInput.text;
         }
         else if(this.showPlayerNameField(_loc2_))
         {
            prevValues[_loc2_.split(".").join("_")] = this._pName.text;
         }
         var _loc3_:CityState = MainScreen.getInstance().getSelectedCity();
         if(this.isTeleport(_loc2_) || this.isAdvTeleport(_loc2_))
         {
            _loc3_.cityManager._recallIncomingArmies();
            if(this.isTeleport(_loc2_))
            {
               ActionFactory.getInstance().getCityCommands().moveCastle(_loc3_.castle.id,(this.zoneInfo.getItemAt(this._zone_Select.selectedIndex).data as ZoneInfoBean).id,this.onSpecialResponse);
            }
            else if(_loc2_ != "player.move.castle.1.b")
            {
               _loc4_ = _loc3_.cityManager.getLocalBuffIndexFromTypeId("MoveCastleCoolDownBuff");
               if(_loc4_ != -1 && Utils.getServerTime() < _loc3_.castle.buffsArray[_loc4_].endTime)
               {
                  dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"The " + this.itemData.name + " is on cooldown for this city for " + Utils.formatTime((_loc3_.castle.buffsArray[_loc4_].endTime - Utils.getServerTime()) / 1000)));
                  this._useBtn.enabled = true;
                  this._closeWinBtn.enabled = true;
               }
               else if(_loc2_ == "player.more.castle.1.a")
               {
                  ActionFactory.getInstance().getCityCommands().advMoveCastle(_loc3_.castle.id,Map.getFieldId(int(this._xInput.text),int(this._yInput.text)),this.onSpecialResponse);
               }
               else if(_loc2_ == "player.more.castle.1.c")
               {
                  ActionFactory.getInstance().getCityCommands().WarMoveCastle(_loc3_.castle.id,Map.getFieldId(int(this._xInput.text),int(this._yInput.text)),this.onSpecialResponse);
               }
            }
            else
            {
               ActionFactory.getInstance().getCityCommands().uniteAdvMoveCastle(_loc3_.castle.id,Map.getFieldId(int(this._xInput.text),int(this._yInput.text)),this.onSpecialResponse);
            }
         }
         else if(this.isCastleStrat(_loc2_))
         {
            ActionFactory.getInstance().getFieldCommand().getOtherFieldInfo(_loc3_.castle.id,Map.getFieldId(int(this._xInput.text),int(this._yInput.text)));
            ActionFactory.getInstance().getShopCommands().useTrickItem(Map.getFieldId(int(this._xInput.text),int(this._yInput.text)),0,_loc2_,this.onSpecialResponse);
         }
         else if(this.isDevil(_loc2_) || this.isGateControl(_loc2_))
         {
            ActionFactory.getInstance().getShopCommands().useDevilItem(int(this._xInput.text),int(this._yInput.text),_loc2_,param1,this.onSpecialResponse);
         }
         else if(this.isAngel(_loc2_))
         {
            ActionFactory.getInstance().getShopCommands().useAngelItem(this._pName.text,_loc2_,this.onSpecialResponse);
         }
         else if(this.isSoF(_loc2_))
         {
            if(_loc3_.cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION) <= _loc3_.cityManager.heroes.length - (Utils.isRoyalFound(_loc3_.cityManager.heroes) ? 1 : 0))
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Feasting hall is full! Free up a slot or select another city before trying to rescue a hero."));
               this._useBtn.enabled = true;
               this._closeWinBtn.enabled = true;
            }
            else if(this.disappearHeros != null && this.disappearHeros.length > 0)
            {
               ActionFactory.getInstance().getHeroCommand().RecoverDisappearHero(_loc3_.castle.id,this._dh_Select.selectedItem.data,this.onSpecialResponse);
            }
            else
            {
               this._useBtn.enabled = true;
               this._closeWinBtn.enabled = true;
            }
         }
         else if(this.isTruce(_loc2_))
         {
            _loc4_ = _loc3_.cityManager.getBuffIndexFromTypeId("PlayerPeaceBuff");
            if(_loc4_ != -1 && Utils.getServerTime() < _loc3_.player.buffsArray[_loc4_].endTime)
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Account status is already protected under Truce Agreement for " + Utils.formatTime((_loc3_.player.buffsArray[_loc4_].endTime - Utils.getServerTime()) / 1000)));
               this._useBtn.enabled = true;
               this._closeWinBtn.enabled = true;
            }
            else
            {
               _loc4_ = _loc3_.cityManager.getBuffIndexFromTypeId("PlayerPeaceCoolDownBuff");
               if(_loc4_ != -1 && Utils.getServerTime() < _loc3_.player.buffsArray[_loc4_].endTime)
               {
                  dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Truce Agreement has already been used within 24 hours and is on cooldown for " + Utils.formatTime((_loc3_.player.buffsArray[_loc4_].endTime - Utils.getServerTime()) / 1000)));
                  this._useBtn.enabled = true;
                  this._closeWinBtn.enabled = true;
               }
               else
               {
                  ActionFactory.getInstance().getCityCommands().setStopWarState(_loc2_,LoginHelper.getInstance().getHashedEvonyPw(),this.onSpecialResponse);
               }
            }
         }
         else if(this.isSpeechOrCivCode(_loc2_) || this.isCastleItem(_loc2_))
         {
            ActionFactory.getInstance().getShopCommands().useCastleGoods(_loc3_.castle.id,_loc2_,this.onSpecialResponse);
         }
         else if(this.isHeroHunting(_loc2_))
         {
            ActionFactory.getInstance().getHeroCommand().refreshHerosListFromTavern(_loc3_.castle.id,this.onSpecialResponse);
         }
         else if(int(this._useCountInput1._useCountInput.text) > 1)
         {
            this.onUseItems(int(this._useCountInput1._useCountInput.text));
         }
         else
         {
            ActionFactory.getInstance().getShopCommands().useGoods(_loc3_.castle.id,_loc2_,1,this.onUseGood);
            this.timeOutTimer.start();
         }
      }
      
      private function onUseGoods(param1:UseItemResultResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:ItemBean = null;
         this.timeOutTimer.reset();
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Error received after successfully using " + this.howManyUsed + " of " + this.itemData.name + ". Item use has been stopped.  " + param1.errorMsg + ": " + param1.ok));
            this.cleanUpAfterUseItem();
         }
         else
         {
            ++this.howManyUsed;
            _loc2_ = "Item used successfully\n";
            for each(_loc3_ in param1.itemBeansArray)
            {
               if(!(Items.getItemName(_loc3_.id) == "money" && _loc3_.count == 0))
               {
                  _loc2_ = _loc2_ + "  Got: " + _loc3_.count + " " + Items.getItemName(_loc3_.id) + "\n";
               }
            }
            this._useItemResultsArea.text += _loc2_;
            this.setScrollPos(this._useItemResultsArea);
            Utils.callLater(500,this.useGoods);
         }
      }
      
      private function useGoods() : void
      {
         if(this.pleaseStop || this.howManyToUse - this.howManyUsed < 1)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully used " + this.howManyUsed + " " + this.itemData.name + "."));
            this.cleanUpAfterUseItem();
         }
         else
         {
            ActionFactory.getInstance().getShopCommands().useGoods(MainScreen.getInstance().getSelectedCity().castle.id,this.itemData.id,1,this.onUseGoods);
            this.timeOutTimer.start();
         }
      }
      
      public function updateInfo(param1:Array = null, param2:Function = null) : void
      {
         this.itemData = new ObjectProxy(param1[0]);
         this.updateItemCount();
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
         var _loc3_:String = this.itemData.id;
         if(this.isTeleport(_loc3_))
         {
            ActionFactory.getInstance().getCommonCommands().zoneInfo(this.onZoneInfoResponse);
         }
         else if(this.isSoF(_loc3_))
         {
            ActionFactory.getInstance().getHeroCommand().GetDisappearHeros(this.onGetDisappearHerosResponse);
         }
         if(this._useBtnArea.visible)
         {
            this._useBtn.label = this.isTeleport(_loc3_) || this.isAdvTeleport(_loc3_) ? "Teleport" : (this.isSoF(_loc3_) ? "Rescue" : "Use");
         }
         this.closeFunc = param2;
         var _loc4_:String = this.getPrevValues(_loc3_);
         if(_loc4_ == null)
         {
            return;
         }
         if(this.showCoordFields(_loc3_))
         {
            this._xInput.text = _loc4_.split(",")[0];
            this._yInput.text = _loc4_.split(",")[1];
         }
         else if(this.showPlayerNameField(_loc3_))
         {
            this._pName.text = _loc4_;
         }
         this.timeOutTimer = new Timer(5000,1);
         this.timeOutTimer.addEventListener(TimerEvent.TIMER,this.onTimeOut);
         this.addEventListener(KeyboardEvent.KEY_DOWN,this.enterKeyDownHandle);
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
      public function get _buyBtn() : Button
      {
         return this._1330884373_buyBtn;
      }
      
      private function onUseGood(param1:UseItemResultResponse) : void
      {
         var _loc2_:* = null;
         var _loc3_:ItemBean = null;
         this.timeOutTimer.reset();
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + ": " + param1.ok));
         }
         else
         {
            this._itemDescArea.visible = false;
            this._useItemResultsArea.visible = true;
            _loc2_ = "Item used successfully\n";
            for each(_loc3_ in param1.itemBeansArray)
            {
               if(!(Items.getItemName(_loc3_.id) == "money" && _loc3_.count == 0))
               {
                  _loc2_ = _loc2_ + "  Got: " + _loc3_.count + " " + Items.getItemName(_loc3_.id) + "\n";
               }
            }
            this._useItemResultsArea.text += _loc2_;
            this.setScrollPos(this._useItemResultsArea);
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully used " + this.itemData.name + "."));
         }
         this._closeWinBtn.enabled = true;
         this._useBtn.enabled = true;
      }
      
      private function showCloseAndOpenBtns(param1:String) : Boolean
      {
         return this.isGateControl(param1);
      }
      
      public function ___buyBtn_click(param1:MouseEvent) : void
      {
         this.onBuyBtn();
      }
      
      [Bindable(event="propertyChange")]
      public function get _useBtnArea() : HBox
      {
         return this._327260383_useBtnArea;
      }
      
      private function _ItemViewWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.getIconUrl(this.itemData.iconUrl);
         _loc1_ = this.itemData.name;
         _loc1_ = "Type: " + Items.getCommonType(this.itemData.itemType,this.itemData.id);
         _loc1_ = "Price: " + Utils.formatInt(this.itemData.price) + " ea          You own: " + Utils.formatInt(this.itemData.count);
         _loc1_ = this.itemData.price > 0;
         _loc1_ = this.itemData.price > 0 ? "Click to buy more of this item from the Game Shop." : "This item is not currently available from the Game Shop.";
         _loc1_ = this.itemData.desc;
         _loc1_ = this.itemData.itemDesc;
         _loc1_ = this.showZoneSelector(this.itemData.id) && this._zone_Select.selectedIndex > 0;
         _loc1_ = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.playerCount + "" : "";
         _loc1_ = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.castleCount + "" : "";
         _loc1_ = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.rate + "%" : "";
         _loc1_ = this.showUseCount(this.itemData.id);
         _loc1_ = this;
         _loc1_ = this.enableUseBtn(this.itemData.count);
         _loc1_ = this.showCoordFields(this.itemData.id);
         _loc1_ = this.showPlayerNameField(this.itemData.id);
         _loc1_ = this.showZoneSelector(this.itemData.id);
         _loc1_ = this.zoneInfo;
         _loc1_ = this.showRescueHeroSelector(this.itemData.id);
         _loc1_ = this.disappearHeros;
         _loc1_ = this.showUseBtn(this.itemData.id);
         _loc1_ = this.enableUseBtn(this.itemData.count) && (this.disappearHeros == null || this.disappearHeros != null && this.disappearHeros.length > 0);
         _loc1_ = this.showCloseAndOpenBtns(this.itemData.id);
         _loc1_ = this.enableUseBtn(this.itemData.count);
         _loc1_ = this.enableUseBtn(this.itemData.count);
      }
      
      private function keyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.NUMPAD_DECIMAL || param1.keyCode == Keyboard.PERIOD || param1.keyCode == Keyboard.COMMA)
         {
            this._yInput.setFocus();
         }
      }
      
      public function set _buyBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1330884373_buyBtn;
         if(_loc2_ !== param1)
         {
            this._1330884373_buyBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_buyBtn",_loc2_,param1));
         }
      }
      
      private function getPrevValues(param1:String) : String
      {
         param1 = param1.split(".").join("_");
         return prevValues[param1] != undefined && prevValues[param1] != null ? prevValues[param1] : "";
      }
      
      private function set zoneInfo(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._847922810zoneInfo;
         if(_loc2_ !== param1)
         {
            this._847922810zoneInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"zoneInfo",_loc2_,param1));
         }
      }
      
      private function isSpeechOrCivCode(param1:String) : Boolean
      {
         return param1 == "player.heart.1.a" || param1 == "player.pop.1.a";
      }
      
      internal function onMaxBtn(param1:TextInput) : void
      {
         param1.text = "" + this.itemData.count;
         param1.setFocus();
         this.moveCursorToEnd(param1);
      }
      
      private function enterKeyDownHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER && this.showUseBtn(this.itemData.id))
         {
            this.onUseBtn();
         }
         else if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.close();
         }
      }
      
      private function setScrollPos(param1:TextArea) : void
      {
         var target:TextArea = param1;
         Utils.callLater(50,function():void
         {
            target.verticalScrollPosition = target.maxVerticalScrollPosition;
         });
      }
      
      [Bindable(event="propertyChange")]
      public function get _pName() : TextInput
      {
         return this._1469343204_pName;
      }
      
      public function ___useBtn_click(param1:MouseEvent) : void
      {
         this.onUseBtn();
      }
      
      public function ___ItemViewWin_Image1_complete(param1:Event) : void
      {
         ImageSmooth.onLoadComplete(param1);
      }
      
      public function set _pName(param1:TextInput) : void
      {
         var _loc2_:Object = this._1469343204_pName;
         if(_loc2_ !== param1)
         {
            this._1469343204_pName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_pName",_loc2_,param1));
         }
      }
      
      public function ___closeBtn_click(param1:MouseEvent) : void
      {
         this.onUseBtn("0");
      }
      
      [Bindable(event="propertyChange")]
      public function get _dh_Select() : ComboBox
      {
         return this._95768648_dh_Select;
      }
      
      public function ___xInput_change(param1:Event) : void
      {
         this.onCoordChange(param1.currentTarget as TextInput);
      }
      
      [Bindable(event="propertyChange")]
      public function get _closeWinBtn() : Button
      {
         return this._344839367_closeWinBtn;
      }
      
      private function onSpecialResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + ": " + param1.ok));
         }
         else if(this.isTeleport(this.itemData.id) || this.isAdvTeleport(this.itemData.id))
         {
            MainScreen.getInstance().getSelectedCity().cityManager._resetLocalFieldsInfo();
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully moved castle to " + (this.isTeleport(this.itemData.id) ? (this.zoneInfo.getItemAt(this._zone_Select.selectedIndex).data as ZoneInfoBean).name : int(this._xInput.text) + "," + int(this._yInput.text))));
         }
         else if(this.isCastleStrat(this.itemData.id) || this.isDevil(this.itemData.id) || this.isAngel(this.itemData.id))
         {
            if(this.itemData.id == Items.getItemId("Advance_by_A_Hidden_Path"))
            {
               MainScreen.getInstance().getSelectedCity().cityManager._clearLastAmbushErrorTime();
            }
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully applied " + this.itemData.name + " to " + (this.isAngel(this.itemData.id) ? this._pName.text : int(this._xInput.text) + "," + int(this._yInput.text))));
         }
         else if(this.isSoF(this.itemData.id))
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully recovered hero: " + this._dh_Select.selectedItem.label));
         }
         else if(this.isTruce(this.itemData.id))
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully applied " + this.itemData.name + ". Account status is Truce for 12 hours."));
         }
         else if(this.isSpeechOrCivCode(this.itemData.id))
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully applied " + this.itemData.name + " to the city."));
         }
         else if(this.isHeroHunting(this.itemData.id))
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully applied " + this.itemData.name + ". The hero list at the Inn has been refreshed."));
         }
         else if(this.isCastleItem(this.itemData.id))
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Successfully applied " + this.itemData.name + " to the " + (this.itemData.id.indexOf(".adv") == -1 ? "castle" : "account") + ". Rally Spot will now dispatch up to 25% more troops for 15 days."));
         }
         if(this.isGateControl(this.itemData.id))
         {
            this._openBtn.enabled = true;
            this._closeBtn.enabled = true;
         }
         else
         {
            this._useBtn.enabled = true;
         }
         this._closeWinBtn.enabled = true;
         if(this.isTeleport(this.itemData.id) || this.isAdvTeleport(this.itemData.id) || this.isSoF(this.itemData.id) || this.isTruce(this.itemData.id) || this.isSpeechOrCivCode(this.itemData.id) || this.isHeroHunting(this.itemData.id) || this.isCastleItem(this.itemData.id))
         {
            this.close();
         }
      }
      
      public function set _closeBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1183315619_closeBtn;
         if(_loc2_ !== param1)
         {
            this._1183315619_closeBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_closeBtn",_loc2_,param1));
         }
      }
      
      private function showZoneSelector(param1:String) : Boolean
      {
         return this.isTeleport(param1);
      }
      
      public function set _useBtnArea(param1:HBox) : void
      {
         var _loc2_:Object = this._327260383_useBtnArea;
         if(_loc2_ !== param1)
         {
            this._327260383_useBtnArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useBtnArea",_loc2_,param1));
         }
      }
      
      private function isTruce(param1:String) : Boolean
      {
         return param1 == "player.peace.1";
      }
      
      public function ___pName_change(param1:Event) : void
      {
      }
      
      private function _ItemViewWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.getIconUrl(this.itemData.iconUrl);
         },function(param1:Object):void
         {
            _ItemViewWin_Image1.source = param1;
         },"_ItemViewWin_Image1.source");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.itemData.name;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Text1.text = param1;
         },"_ItemViewWin_Text1.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "Type: " + Items.getCommonType(this.itemData.itemType,this.itemData.id);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Label1.text = param1;
         },"_ItemViewWin_Label1.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "Price: " + Utils.formatInt(this.itemData.price) + " ea          You own: " + Utils.formatInt(this.itemData.count);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Label2.text = param1;
         },"_ItemViewWin_Label2.text");
         result[3] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.itemData.price > 0;
         },function(param1:Boolean):void
         {
            _buyBtn.enabled = param1;
         },"_buyBtn.enabled");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.itemData.price > 0 ? "Click to buy more of this item from the Game Shop." : "This item is not currently available from the Game Shop.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _buyBtn.toolTip = param1;
         },"_buyBtn.toolTip");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.itemData.desc;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _itemDescArea.text = param1;
         },"_itemDescArea.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.itemData.itemDesc;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _itemDescArea.toolTip = param1;
         },"_itemDescArea.toolTip");
         result[7] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Boolean(this.showZoneSelector(this.itemData.id)) && this._zone_Select.selectedIndex > 0;
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox2.visible = param1;
         },"_ItemViewWin_HBox2.visible");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.playerCount + "" : "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Label6.text = param1;
         },"_ItemViewWin_Label6.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.castleCount + "" : "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Label7.text = param1;
         },"_ItemViewWin_Label7.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this._zone_Select.selectedIndex > 0 ? this._zone_Select.selectedItem.data.rate + "%" : "";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _ItemViewWin_Label8.text = param1;
         },"_ItemViewWin_Label8.text");
         result[11] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showUseCount(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox3.visible = param1;
         },"_ItemViewWin_HBox3.visible");
         result[12] = binding;
         binding = new Binding(this,function():*
         {
            return this;
         },function(param1:*):void
         {
            _useCountInput1.parentWin = param1;
         },"_useCountInput1.parentWin");
         result[13] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.enableUseBtn(this.itemData.count);
         },function(param1:Boolean):void
         {
            _useCountInput1.enabled = param1;
         },"_useCountInput1.enabled");
         result[14] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showCoordFields(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox4.visible = param1;
         },"_ItemViewWin_HBox4.visible");
         result[15] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showPlayerNameField(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox5.visible = param1;
         },"_ItemViewWin_HBox5.visible");
         result[16] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showZoneSelector(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox6.visible = param1;
         },"_ItemViewWin_HBox6.visible");
         result[17] = binding;
         binding = new Binding(this,function():Object
         {
            return this.zoneInfo;
         },function(param1:Object):void
         {
            _zone_Select.dataProvider = param1;
         },"_zone_Select.dataProvider");
         result[18] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showRescueHeroSelector(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox7.visible = param1;
         },"_ItemViewWin_HBox7.visible");
         result[19] = binding;
         binding = new Binding(this,function():Object
         {
            return this.disappearHeros;
         },function(param1:Object):void
         {
            _dh_Select.dataProvider = param1;
         },"_dh_Select.dataProvider");
         result[20] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showUseBtn(this.itemData.id);
         },function(param1:Boolean):void
         {
            _useBtnArea.visible = param1;
         },"_useBtnArea.visible");
         result[21] = binding;
         binding = new Binding(this,function():Boolean
         {
            return Boolean(this.enableUseBtn(this.itemData.count)) && (this.disappearHeros == null || this.disappearHeros != null && this.disappearHeros.length > 0);
         },function(param1:Boolean):void
         {
            _useBtn.enabled = param1;
         },"_useBtn.enabled");
         result[22] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.showCloseAndOpenBtns(this.itemData.id);
         },function(param1:Boolean):void
         {
            _ItemViewWin_HBox9.visible = param1;
         },"_ItemViewWin_HBox9.visible");
         result[23] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.enableUseBtn(this.itemData.count);
         },function(param1:Boolean):void
         {
            _closeBtn.enabled = param1;
         },"_closeBtn.enabled");
         result[24] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.enableUseBtn(this.itemData.count);
         },function(param1:Boolean):void
         {
            _openBtn.enabled = param1;
         },"_openBtn.enabled");
         result[25] = binding;
         return result;
      }
      
      internal function onUseCountChange(param1:TextInput) : void
      {
         param1.text = "" + int(param1.text);
         if(int(param1.text) == 0)
         {
            if(this.itemData.count > 0)
            {
               param1.text = "" + 1;
            }
            this.moveCursorToEnd(param1);
         }
         else if(int(param1.text) < 0)
         {
            this.onMinBtn(param1);
         }
         else if(int(param1.text) > this.itemData.count)
         {
            param1.text = "" + this.itemData.count;
         }
      }
      
      private function canUseItem(param1:String) : Boolean
      {
         if(param1 == "consume.key.3" || param1 == "consume.key.2" || param1 == "consume.key.1" || param1 == "consume.move.1" || param1 == "player.more.castle.1.a" || param1 == "player.heart.1.a " || param1 == "player.pop.1.a" || param1.indexOf("equipment.box.") == 0 || param1 == "alliance.ritual_of_pact.advanced" || param1 == "alliance.ritual_of_pact.premium" || param1 == "alliance.ritual_of_pact.ultimate" || param1 == "player.speak.bronze_publicity_ambassador.permanent" || param1 == "player.speak.bronze_publicity_ambassador.permanent.15" || param1 == "player.speak.gold_publicity_ambassador.15" || param1 == "player.speak.gold_publicity_ambassador.permanent" || param1 == "player.speak.silver_publicity_ambassador.15" || param1 == "player.speak.silver_publicity_ambassador.permanent")
         {
            return true;
         }
         if(this.isAngel(param1) || this.isDevil(param1) || this.isSoF(param1))
         {
            return true;
         }
         if(this.itemData.playerItem && !this.isDream(param1) && param1 != "player.troop.1.a" && param1 != "player.key.evony_easter_package" && param1 != "player.item.candy" && param1 != "player.item.turkeyhunt" && param1 != "player.item.snowball" && param1 != "player.item.pieceofrainbow" && param1 != "player.item.wolfpaw" && param1 != "player.bone.key" && param1 != "player.item.gildedhorn" && param1 != "player.item.candy.2013" && param1 != "player.item.harvesttoken" && param1 != "player.item.huntersstones" && param1 != "player.item.relicofthekrampus" && param1 != "player.item.quest.shakespear" && param1 != "player.key.keyofcrossing" && param1 != "player.key.birthdaykey" && param1 != "player.key.malebolgian" && param1 != "player.key.keyofdonar" && param1 != "player.item.candy.2014" && param1 != "player.item.harvesttoken.2014" && param1 != "player.key.jakekeyoftheharvest" && param1 != "player.key.starcrossedkey" && param1 != "player.key.faeryringkey" && param1 != "player.key.easterkey2015" && param1 != "player.key.birthdaykey.2015" && param1 != "player.key.thesquirrelskey" && param1 != "player.item.stygandrsbannerofthehorde" && param1
         .indexOf(".quest.") == -1)
         {
            return true;
         }
         return false;
      }
      
      public function set _useCountInput1(param1:ItemCountInput) : void
      {
         var _loc2_:Object = this._2053243474_useCountInput1;
         if(_loc2_ !== param1)
         {
            this._2053243474_useCountInput1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useCountInput1",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get itemData() : ObjectProxy
      {
         return this._1177034077itemData;
      }
      
      [Bindable(event="propertyChange")]
      public function get _xInput() : TextInput
      {
         return this._1919807313_xInput;
      }
      
      public function set _useItemResultsArea(param1:TextArea) : void
      {
         var _loc2_:Object = this._9487016_useItemResultsArea;
         if(_loc2_ !== param1)
         {
            this._9487016_useItemResultsArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useItemResultsArea",_loc2_,param1));
         }
      }
      
      internal function onMinBtn(param1:TextInput) : void
      {
         param1.text = "" + (this.itemData.count > 0 ? 1 : 0);
         param1.setFocus();
         this.moveCursorToEnd(param1);
      }
      
      private function onTimeOut(param1:TimerEvent = null) : void
      {
         var _loc2_:UseItemResultResponse = new UseItemResultResponse("shop.useGoods",{
            "ok":-1,
            "errorMsg":"ERROR: TimeOut Occurred. No response received within a timely manner.",
            "msg":"",
            "packageId":12345,
            "itemBeansArray":new ArrayCollection(),
            "gamblingItemsBeansArray":new ArrayCollection()
         });
         this.onUseGoods(_loc2_);
      }
      
      public function set _closeWinBtn(param1:Button) : void
      {
         var _loc2_:Object = this._344839367_closeWinBtn;
         if(_loc2_ !== param1)
         {
            this._344839367_closeWinBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_closeWinBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _openBtn() : Button
      {
         return this._1095002739_openBtn;
      }
      
      private function isAdvTeleport(param1:String) : Boolean
      {
         return param1 == "player.more.castle.1.a" || param1 == "player.move.castle.1.b" || param1 == "player.more.castle.1.c";
      }
      
      private function isTeleport(param1:String) : Boolean
      {
         return param1 == "consume.move.1";
      }
      
      public function set _dh_Select(param1:ComboBox) : void
      {
         var _loc2_:Object = this._95768648_dh_Select;
         if(_loc2_ !== param1)
         {
            this._95768648_dh_Select = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_dh_Select",_loc2_,param1));
         }
      }
      
      private function onUseItems(param1:int) : void
      {
         this._itemDescArea.visible = false;
         this._useItemResultsArea.visible = true;
         this.howManyToUse = param1;
         this.pleaseStop = false;
         this._useBtn.label = "Cancel";
         this._useBtn.enabled = true;
         this.useGoods();
      }
      
      [Bindable(event="propertyChange")]
      private function get zoneInfo() : ArrayCollection
      {
         return this._847922810zoneInfo;
      }
      
      [Bindable(event="propertyChange")]
      public function get _useBtn() : Button
      {
         return this._1872395380_useBtn;
      }
      
      private function isCastleStrat(param1:String) : Boolean
      {
         return param1 == "player.trick.bxez" || param1 == "player.trick.adcc" || param1 == "player.trick.bxez" || param1 == "player.trick.chdj" || param1 == "player.trick.cmjb" || param1 == "player.trick.fslc" || param1 == "player.trick.jbqy" || param1 == "player.trick.kcj" || param1 == "player.trick.lywh" || param1 == "player.trick.mrj" || param1 == "player.trick.pzyy" || param1 == "player.trick.smmf" || param1 == "player.trick.tblj" || param1 == "player.trick.wwjz" || param1 == "player.trick.yyhz" || param1 == "player.trick.zsmj";
      }
      
      private function isGateControl(param1:String) : Boolean
      {
         return param1 == "player.box.present.money.77";
      }
      
      [Bindable(event="propertyChange")]
      public function get _zone_Select() : ComboBox
      {
         return this._1579933872_zone_Select;
      }
      
      private function isHeroHunting(param1:String) : Boolean
      {
         return param1 == "consume.refreshtavern.1";
      }
      
      private function onBuyResponse(param1:CommandResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + ": " + param1.ok));
         }
         this._buyBtn.enabled = true;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ItemViewWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ItemViewWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Items_ItemViewWinWatcherSetupUtil");
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
      
      private function showPlayerNameField(param1:String) : Boolean
      {
         return this.isAngel(param1);
      }
      
      public function ___openBtn_click(param1:MouseEvent) : void
      {
         this.onUseBtn("1");
      }
      
      public function ___ItemViewWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function cleanUpAfterUseItem() : void
      {
         this.pleaseStop = true;
         this.howManyToUse = 0;
         this.howManyUsed = 0;
         this._useBtn.label = "Use";
         this._useBtn.enabled = true;
         this._closeWinBtn.enabled = true;
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
      }
      
      [Bindable(event="propertyChange")]
      public function get _useItemResultsArea() : TextArea
      {
         return this._9487016_useItemResultsArea;
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
      
      [Bindable(event="propertyChange")]
      public function get _closeBtn() : Button
      {
         return this._1183315619_closeBtn;
      }
      
      public function set _itemDescArea(param1:Text) : void
      {
         var _loc2_:Object = this._458286896_itemDescArea;
         if(_loc2_ !== param1)
         {
            this._458286896_itemDescArea = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_itemDescArea",_loc2_,param1));
         }
      }
      
      private function showUseBtn(param1:String) : Boolean
      {
         return this.canUseItem(param1) || this.isTeleport(param1) || this.isAdvTeleport(param1) || this.isCastleStrat(param1) || this.isDevil(param1) || this.isAngel(param1) && !this.isGateControl(param1);
      }
      
      private function set disappearHeros(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._2041142742disappearHeros;
         if(_loc2_ !== param1)
         {
            this._2041142742disappearHeros = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"disappearHeros",_loc2_,param1));
         }
      }
      
      private function onBuyBtn() : void
      {
         var _loc1_:popUpWinShowEvent = null;
         if(MainScreen.getPlayer().playerInfo.medal - this.itemData.price >= 0)
         {
            _loc1_ = new popUpWinShowEvent(popUpWinShowEvent.BUY_ITEM_WIN);
            _loc1_.args = [this.itemData,this.onBuyItem];
            dispatchEvent(_loc1_);
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You do not have enough Cents to buy this item from the Game Shop."));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _useCountInput1() : ItemCountInput
      {
         return this._2053243474_useCountInput1;
      }
      
      private function set itemData(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._1177034077itemData;
         if(_loc2_ !== param1)
         {
            this._1177034077itemData = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemData",_loc2_,param1));
         }
      }
      
      public function set _zone_Select(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1579933872_zone_Select;
         if(_loc2_ !== param1)
         {
            this._1579933872_zone_Select = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_zone_Select",_loc2_,param1));
         }
      }
      
      public function ___yInput_change(param1:Event) : void
      {
         this.onCoordChange(param1.currentTarget as TextInput);
      }
      
      private function enableUseBtn(param1:int) : Boolean
      {
         return param1 > 0;
      }
      
      private function showCoordFields(param1:String) : Boolean
      {
         return this.isAdvTeleport(param1) || this.isCastleStrat(param1) || this.isGateControl(param1) || this.isDevil(param1);
      }
      
      public function ___xInput_keyDown(param1:KeyboardEvent) : void
      {
         this.keyDownHandle(param1);
      }
      
      [Bindable(event="propertyChange")]
      private function get disappearHeros() : ArrayCollection
      {
         return this._2041142742disappearHeros;
      }
      
      private function onZoneInfoResponse(param1:ZoneInfoResponse) : void
      {
         var _loc2_:ZoneInfoBean = null;
         var _loc3_:ObjectProxy = null;
         var _loc4_:int = 0;
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg + ": " + param1.ok));
         }
         else
         {
            _loc2_ = null;
            _loc3_ = null;
            if(this.zoneInfo == null)
            {
               this.zoneInfo = new ArrayCollection();
            }
            else
            {
               this.zoneInfo.removeAll();
            }
            _loc4_ = 0;
            while(_loc4_ < param1.zonesArray.length)
            {
               _loc2_ = param1.zonesArray.getItemAt(_loc4_) as ZoneInfoBean;
               _loc3_ = new ObjectProxy({
                  "label":_loc2_.name,
                  "data":_loc2_
               });
               this.zoneInfo.addItem(_loc3_);
               _loc4_++;
            }
            _loc3_ = new ObjectProxy({
               "label":"Random",
               "data":this.getRandomZone()
            });
            this.zoneInfo.addItemAt(_loc3_,0);
            this._zone_Select.selectedIndex = 0;
            _loc2_ = null;
            _loc3_ = null;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _itemDescArea() : Text
      {
         return this._458286896_itemDescArea;
      }
      
      private function isSoF(param1:String) : Boolean
      {
         return param1 == "player.item.stoneoffinding";
      }
      
      internal function onBuyItem(param1:int) : void
      {
         ActionFactory.getInstance().getShopCommands().buy(this.itemData.id,param1,this.onBuyResponse);
      }
      
      public function ___closeWinBtn_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function showUseCount(param1:String) : Boolean
      {
         return this.canUseItem(param1) && !this.isTruce(param1) && !this.isCastleStrat(param1) && !this.isTeleport(param1) && !this.isAdvTeleport(param1) && !this.isGateControl(param1) && !this.isAngel(param1) && !this.isDevil(param1) && !this.isSoF(param1) && !this.isCastleItem(param1) && !this.isSpeechOrCivCode(param1);
      }
      
      public function set _openBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1095002739_openBtn;
         if(_loc2_ !== param1)
         {
            this._1095002739_openBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_openBtn",_loc2_,param1));
         }
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
      
      private function isDevil(param1:String) : Boolean
      {
         return param1 == "player.box.present.money.74" || param1 == "player.box.present.money.75" || param1 == "player.box.present.money.76";
      }
      
      public function set _useBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1872395380_useBtn;
         if(_loc2_ !== param1)
         {
            this._1872395380_useBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_useBtn",_loc2_,param1));
         }
      }
      
      private function updateItemCount() : void
      {
         this.itemData.count = this.getItemCount(this.itemData.id);
      }
      
      private function isAngel(param1:String) : Boolean
      {
         return param1 == "player.box.present.money.70" || param1 == "player.box.present.money.71" || param1 == "player.box.present.money.72";
      }
      
      private function onItemUpdate(param1:ItemUpdate) : void
      {
         var _loc2_:ItemBean = null;
         for each(_loc2_ in param1.itemsArray)
         {
            if(_loc2_.id == this.itemData.id)
            {
               this.itemData.count = int(_loc2_.count);
               if(int(this._useCountInput1._useCountInput.text) > this.itemData.count)
               {
                  this.onMaxBtn(this._useCountInput1._useCountInput);
               }
               break;
            }
         }
      }
      
      private function close() : void
      {
         if(this.timeOutTimer != null)
         {
            this.timeOutTimer.stop();
            this.timeOutTimer.removeEventListener(TimerEvent.TIMER,this.onTimeOut);
            this.timeOutTimer = null;
         }
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.SERVER_ITEM_UPDATE,this.onItemUpdate);
         this.removeEventListener(KeyboardEvent.KEY_DOWN,this.enterKeyDownHandle);
         this.itemData = null;
         if(this.zoneInfo != null)
         {
            this.zoneInfo.removeAll();
            this.zoneInfo = null;
         }
         if(this.disappearHeros != null)
         {
            this.disappearHeros.removeAll();
            this.disappearHeros = null;
         }
         this.closeFunc.apply(null,[this]);
      }
   }
}

