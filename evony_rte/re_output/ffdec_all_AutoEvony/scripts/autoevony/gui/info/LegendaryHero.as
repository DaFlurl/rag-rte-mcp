package autoevony.gui.info
{
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import com.evony.client.action.ActionFactory;
   import com.evony.common.beans.RandomHeroBean;
   import com.evony.common.constants.BuildingConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.hero.RandomHeroResponse;
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
   import mx.containers.Canvas;
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.Image;
   import mx.controls.Label;
   import mx.controls.Spacer;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class LegendaryHero extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static const MAL_FACES:Array = new Array("faceA8.jpg","faceA1.jpg","faceA2.jpg","faceA3.jpg","faceA4.jpg","faceA5.jpg","faceA6.jpg","faceA7.jpg","faceA9.jpg","faceA10.jpg","faceA11.jpg","faceA12.jpg","faceA13.jpg","faceA14.jpg","faceA15.jpg","faceA16.jpg","faceA17.jpg","faceA18.jpg","faceA19.jpg","faceA20.jpg","faceA21.jpg","faceA22.jpg","faceA23.jpg","faceA24.jpg","faceA25.jpg");
      
      private static const FEM_FACES:Array = new Array("faceB1.jpg","faceB2.jpg","faceB3.jpg","faceB4.jpg","faceB5.jpg","faceB6.jpg","faceB7.jpg","faceB8.jpg","faceB9.jpg");
      
      public var bCostSure:Boolean = true;
      
      private var _879022499txtCost:Label;
      
      public var _LegendaryHero_Image1:Image;
      
      private var _3052620chk2:CheckBox;
      
      public var _LegendaryHero_Label4:Label;
      
      public var _LegendaryHero_Label6:Label;
      
      public var _LegendaryHero_Label2:Label;
      
      private var _3052621chk3:CheckBox;
      
      private var _2096610540playername:TextInput;
      
      mx_internal var _watchers:Array = [];
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1476239533randomHeroBean:RandomHeroBean;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var sex:int = 0;
      
      private var _553707709rollsLeft:Label;
      
      private var _3052619chk1:CheckBox;
      
      private var _571486424faceSource:String;
      
      mx_internal var _bindings:Array = [];
      
      private var faceIndex:int = 0;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":VBox,
               "stylesFactory":function():void
               {
                  this.horizontalGap = 0;
                  this.verticalGap = 0;
                  this.left = "3";
                  this.right = "3";
                  this.top = "3";
                  this.bottom = "3";
                  this.horizontalAlign = "center";
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "horizontalScrollPolicy":"off",
                     "verticalScrollPolicy":"off",
                     "childDescriptors":[new UIComponentDescriptor({
                        "type":Spacer,
                        "propertiesFactory":function():Object
                        {
                           return {"percentHeight":30};
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function():void
                        {
                           this.horizontalGap = 0;
                           this.verticalGap = 0;
                           this.paddingLeft = 20;
                           this.paddingRight = 20;
                           this.paddingTop = 25;
                           this.paddingBottom = 25;
                           this.horizontalAlign = "center";
                           this.verticalAlign = "bottom";
                           this.borderColor = 2236962;
                           this.borderThickness = 1;
                           this.borderStyle = "solid";
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
                                    this.horizontalGap = 0;
                                    this.verticalGap = 0;
                                    this.paddingLeft = 0;
                                    this.paddingRight = 0;
                                    this.paddingTop = 0;
                                    this.paddingBottom = 0;
                                    this.horizontalAlign = "center";
                                    this.verticalAlign = "middle";
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
                                             this.horizontalGap = 0;
                                             this.verticalGap = 0;
                                             this.paddingLeft = 0;
                                             this.paddingRight = 0;
                                             this.paddingTop = 0;
                                             this.paddingBottom = 0;
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
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
                                                      this.horizontalGap = 0;
                                                      this.verticalGap = 5;
                                                      this.paddingLeft = 0;
                                                      this.paddingRight = 0;
                                                      this.paddingTop = 0;
                                                      this.paddingBottom = 0;
                                                      this.horizontalAlign = "right";
                                                      this.verticalAlign = "middle";
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
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "center";
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
                                                                        this.horizontalAlign = "right";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":90,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "text":"Politics:",
                                                                                    "styleName":"ParamgraphText1"
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
                                                                        this.horizontalAlign = "left";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":35,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_LegendaryHero_Label2",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontWeight = "bold";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "styleName":"ParamgraphText1"
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
                                                               this.horizontalGap = 3;
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "center";
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
                                                                        this.horizontalAlign = "right";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":90,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "text":"Attack:",
                                                                                    "styleName":"ParamgraphText1"
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
                                                                        this.horizontalAlign = "left";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":35,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_LegendaryHero_Label4",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontWeight = "bold";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "styleName":"ParamgraphText1"
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
                                                               this.horizontalGap = 3;
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "center";
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
                                                                        this.horizontalAlign = "right";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":90,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "text":"Intelligence:",
                                                                                    "styleName":"ParamgraphText1"
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
                                                                        this.horizontalAlign = "left";
                                                                     },
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":35,
                                                                           "horizontalScrollPolicy":"off",
                                                                           "verticalScrollPolicy":"off",
                                                                           "childDescriptors":[new UIComponentDescriptor({
                                                                              "type":Label,
                                                                              "id":"_LegendaryHero_Label6",
                                                                              "stylesFactory":function():void
                                                                              {
                                                                                 this.fontWeight = "bold";
                                                                              },
                                                                              "propertiesFactory":function():Object
                                                                              {
                                                                                 return {
                                                                                    "height":19,
                                                                                    "styleName":"ParamgraphText1"
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
                                                      this.horizontalGap = 0;
                                                      this.verticalGap = 5;
                                                      this.paddingLeft = 10;
                                                      this.paddingRight = 0;
                                                      this.paddingTop = 0;
                                                      this.paddingBottom = 0;
                                                      this.horizontalAlign = "left";
                                                      this.verticalAlign = "middle";
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
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "left";
                                                               this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "horizontalScrollPolicy":"off",
                                                                  "verticalScrollPolicy":"off",
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":CheckBox,
                                                                     "id":"chk1",
                                                                     "events":{"change":"__chk1_change"},
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":19,
                                                                           "height":19,
                                                                           "styleName":"REcheckBox",
                                                                           "toolTip":"Locked attributes do not change during the reset"
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "height":19,
                                                                           "styleName":"ParamgraphText1",
                                                                           "text":"Lock",
                                                                           "toolTip":"Locked attributes do not change during the reset"
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
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "left";
                                                               this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "horizontalScrollPolicy":"off",
                                                                  "verticalScrollPolicy":"off",
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":CheckBox,
                                                                     "id":"chk2",
                                                                     "events":{"change":"__chk2_change"},
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":19,
                                                                           "height":19,
                                                                           "styleName":"REcheckBox",
                                                                           "toolTip":"Locked attributes do not change during the reset"
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "height":19,
                                                                           "styleName":"ParamgraphText1",
                                                                           "text":"Lock",
                                                                           "toolTip":"Locked attributes do not change during the reset"
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
                                                               this.verticalGap = 0;
                                                               this.paddingLeft = 0;
                                                               this.paddingRight = 0;
                                                               this.paddingTop = 0;
                                                               this.paddingBottom = 0;
                                                               this.horizontalAlign = "left";
                                                               this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function():Object
                                                            {
                                                               return {
                                                                  "horizontalScrollPolicy":"off",
                                                                  "verticalScrollPolicy":"off",
                                                                  "childDescriptors":[new UIComponentDescriptor({
                                                                     "type":CheckBox,
                                                                     "id":"chk3",
                                                                     "events":{"change":"__chk3_change"},
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "width":19,
                                                                           "height":19,
                                                                           "styleName":"REcheckBox",
                                                                           "toolTip":"Locked attributes do not change during the reset"
                                                                        };
                                                                     }
                                                                  }),new UIComponentDescriptor({
                                                                     "type":Label,
                                                                     "propertiesFactory":function():Object
                                                                     {
                                                                        return {
                                                                           "height":19,
                                                                           "styleName":"ParamgraphText1",
                                                                           "text":"Lock",
                                                                           "toolTip":"Locked attributes do not change during the reset"
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
                                             this.horizontalGap = 0;
                                             this.verticalGap = 0;
                                             this.paddingLeft = 0;
                                             this.paddingRight = 0;
                                             this.paddingTop = 10;
                                             this.paddingBottom = 0;
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "horizontalScrollPolicy":"off",
                                                "verticalScrollPolicy":"off",
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"rollsLeft",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.color = 16777215;
                                                      this.fontWeight = "bold";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"styleName":"ParamgraphText1"};
                                                   }
                                                })]
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":HBox,
                                          "stylesFactory":function():void
                                          {
                                             this.horizontalGap = 0;
                                             this.verticalGap = 0;
                                             this.paddingLeft = 0;
                                             this.paddingRight = 0;
                                             this.paddingTop = 0;
                                             this.paddingBottom = 0;
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "horizontalScrollPolicy":"off",
                                                "verticalScrollPolicy":"off",
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"txtCost",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.color = 16711680;
                                                      this.fontWeight = "bold";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "styleName":"ParamgraphText1",
                                                         "text":""
                                                      };
                                                   }
                                                })]
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "events":{"click":"___LegendaryHero_Button1_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "label":"Roll New Attributes",
                                                "styleName":"REwinBtn",
                                                "toolTip":"Roll for new random attributes. All unlocked attributes will be permanently replaced."
                                             };
                                          }
                                       })]
                                    };
                                 }
                              }),new UIComponentDescriptor({
                                 "type":VBox,
                                 "stylesFactory":function():void
                                 {
                                    this.horizontalGap = 0;
                                    this.verticalGap = 0;
                                    this.paddingLeft = 20;
                                    this.paddingRight = 0;
                                    this.paddingTop = 0;
                                    this.paddingBottom = 0;
                                    this.horizontalAlign = "center";
                                    this.verticalAlign = "middle";
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
                                             this.horizontalGap = 8;
                                             this.verticalGap = 0;
                                             this.paddingLeft = 0;
                                             this.paddingRight = 0;
                                             this.paddingTop = 0;
                                             this.paddingBottom = 0;
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "horizontalScrollPolicy":"off",
                                                "verticalScrollPolicy":"off",
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Button,
                                                   "events":{"click":"___LegendaryHero_Button2_click"},
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"styleName":"previousBtn"};
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Image,
                                                   "id":"_LegendaryHero_Image1",
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "width":80,
                                                         "height":80
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Button,
                                                   "events":{"click":"___LegendaryHero_Button3_click"},
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {"styleName":"nextBtn"};
                                                   }
                                                })]
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":HBox,
                                          "stylesFactory":function():void
                                          {
                                             this.horizontalGap = 5;
                                             this.verticalGap = 0;
                                             this.paddingLeft = 0;
                                             this.paddingRight = 0;
                                             this.paddingTop = 10;
                                             this.paddingBottom = 10;
                                             this.horizontalAlign = "center";
                                             this.verticalAlign = "middle";
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
                                                         "styleName":"ParamgraphText1",
                                                         "text":"Name: "
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":TextInput,
                                                   "id":"playername"
                                                })]
                                             };
                                          }
                                       }),new UIComponentDescriptor({
                                          "type":Button,
                                          "events":{"click":"___LegendaryHero_Button4_click"},
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "label":"Recruit",
                                                "styleName":"REwinBtn",
                                                "toolTip":"Accept this hero with the above attributes.\r[requires and consumes 1 Legendary Ring]"
                                             };
                                          }
                                       })]
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":Spacer,
                        "propertiesFactory":function():Object
                        {
                           return {"percentHeight":70};
                        }
                     })]
                  };
               }
            })]};
         }
      });
      
      private var faceArray:Array = new Array();
      
      public function LegendaryHero()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___LegendaryHero_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         LegendaryHero._watcherSetupUtil = param1;
      }
      
      private function getIconUrl(param1:String) : String
      {
         return "http://e2.eimg.us/" + param1;
      }
      
      public function ___LegendaryHero_Button3_click(param1:MouseEvent) : void
      {
         this.changeFace(1);
      }
      
      public function __chk3_change(param1:Event) : void
      {
         this.onLockChange3();
      }
      
      private function _LegendaryHero_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.randomHeroBean.management;
         _loc1_ = this.randomHeroBean.power;
         _loc1_ = this.randomHeroBean.stratagem;
         _loc1_ = "You have " + this.randomHeroBean.resetcount + "/3 free rolls remaining today.";
         _loc1_ = this.getIconUrl(this.faceSource);
      }
      
      private function updateData(param1:Object = null) : void
      {
         ActionFactory.getInstance().getHeroCommand().GetRandomHero(this.onHeroResponse);
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:LegendaryHero = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._LegendaryHero_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_LegendaryHeroWatcherSetupUtil");
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
      
      public function set chk3(param1:CheckBox) : void
      {
         var _loc2_:Object = this._3052621chk3;
         if(_loc2_ !== param1)
         {
            this._3052621chk3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chk3",_loc2_,param1));
         }
      }
      
      public function set rollsLeft(param1:Label) : void
      {
         var _loc2_:Object = this._553707709rollsLeft;
         if(_loc2_ !== param1)
         {
            this._553707709rollsLeft = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"rollsLeft",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get faceSource() : String
      {
         return this._571486424faceSource;
      }
      
      private function init() : void
      {
         if(MainScreen.getPlayer() == null)
         {
            Utils.callLater(1500,this.init);
            return;
         }
         this.sex = MainScreen.getPlayer().playerInfo.sex;
         this.faceArray = (MAL_FACES.join(",") + "," + FEM_FACES.join(",")).split(",");
         var _loc1_:int = 0;
         while(_loc1_ < this.faceArray.length)
         {
            if("images/icon/player/" + this.faceArray[_loc1_].toString() == MainScreen.getPlayer().playerInfo.faceUrl)
            {
               this.faceIndex = _loc1_;
               break;
            }
            _loc1_++;
         }
         this.faceSource = "images/icon/player/" + this.faceArray[this.faceIndex];
         this.playername.text = MainScreen.getPlayer().playerInfo.userName;
         addEventListener(FlexEvent.SHOW,this.updateData);
         addEventListener(Event.RENDER,this.onRender);
      }
      
      private function onItemSelectedOk(param1:Boolean = false) : void
      {
         if(param1)
         {
            ActionFactory.getInstance().getHeroCommand().RetSetHeroAttri(this.chk1.selected,this.chk2.selected,this.chk3.selected,false,this.onHeroResponse);
         }
      }
      
      public function __chk2_change(param1:Event) : void
      {
         this.onLockChange2();
      }
      
      private function onOkayToRecruit(param1:Boolean = false) : void
      {
         if(param1)
         {
            ActionFactory.getInstance().getHeroCommand().GenSaveRandomHero(MainScreen.getInstance().getSelectedCity().castle.id,this.playername.text,this.faceSource,this.onResponse);
            this.updateData();
         }
      }
      
      public function ___LegendaryHero_Button1_click(param1:MouseEvent) : void
      {
         this.onReset();
      }
      
      private function changeFace(param1:int) : void
      {
         this.faceIndex += param1;
         if(this.faceIndex < 0)
         {
            this.faceIndex = this.faceArray.length - 1;
         }
         else if(this.faceIndex >= this.faceArray.length)
         {
            this.faceIndex = 0;
         }
         this.faceSource = "images/icon/player/" + this.faceArray[this.faceIndex];
      }
      
      private function onReset() : void
      {
         if(this.bCostSure)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,this.rollsLeft.text + " " + this.txtCost.text + " Are you sure you want to roll new Stats?",this.onItemSelectedOk,"Yes","Cancel"));
         }
         else
         {
            this.onItemSelectedOk(true);
         }
      }
      
      public function ___LegendaryHero_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function set faceSource(param1:String) : void
      {
         var _loc2_:Object = this._571486424faceSource;
         if(_loc2_ !== param1)
         {
            this._571486424faceSource = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"faceSource",_loc2_,param1));
         }
      }
      
      public function set chk1(param1:CheckBox) : void
      {
         var _loc2_:Object = this._3052619chk1;
         if(_loc2_ !== param1)
         {
            this._3052619chk1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chk1",_loc2_,param1));
         }
      }
      
      public function set chk2(param1:CheckBox) : void
      {
         var _loc2_:Object = this._3052620chk2;
         if(_loc2_ !== param1)
         {
            this._3052620chk2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chk2",_loc2_,param1));
         }
      }
      
      private function calCost() : void
      {
         var _loc1_:int = 0;
         if(this.randomHeroBean.resetcount == 0)
         {
            _loc1_ = 0;
            if(this.chk1.selected)
            {
               _loc1_++;
            }
            if(this.chk2.selected)
            {
               _loc1_++;
            }
            if(this.chk3.selected)
            {
               _loc1_++;
            }
            if(_loc1_ == 2)
            {
               this.txtCost.text = "This reset costs 40 coins and 40,000 gold.";
            }
            else if(_loc1_ == 1)
            {
               this.txtCost.text = "This reset costs 20 coins and 20,000 gold.";
            }
            else
            {
               this.txtCost.text = "This reset costs 10 coins and 10,000 gold.";
            }
         }
         else
         {
            this.txtCost.text = "";
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get randomHeroBean() : RandomHeroBean
      {
         return this._1476239533randomHeroBean;
      }
      
      [Bindable(event="propertyChange")]
      public function get rollsLeft() : Label
      {
         return this._553707709rollsLeft;
      }
      
      private function onResponse(param1:CommandResponse) : void
      {
         if(param1.ok != 1)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            MainScreen.getInstance()._cityPanel.setSelectedInfoTab("H");
         }
      }
      
      public function set txtCost(param1:Label) : void
      {
         var _loc2_:Object = this._879022499txtCost;
         if(_loc2_ !== param1)
         {
            this._879022499txtCost = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"txtCost",_loc2_,param1));
         }
      }
      
      public function ___LegendaryHero_Button4_click(param1:MouseEvent) : void
      {
         this.onRecruit();
      }
      
      private function _LegendaryHero_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.randomHeroBean.management;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _LegendaryHero_Label2.text = param1;
         },"_LegendaryHero_Label2.text");
         result[0] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.randomHeroBean.power;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _LegendaryHero_Label4.text = param1;
         },"_LegendaryHero_Label4.text");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.randomHeroBean.stratagem;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _LegendaryHero_Label6.text = param1;
         },"_LegendaryHero_Label6.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = "You have " + this.randomHeroBean.resetcount + "/3 free rolls remaining today.";
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            rollsLeft.text = param1;
         },"rollsLeft.text");
         result[3] = binding;
         binding = new Binding(this,function():Object
         {
            return this.getIconUrl(this.faceSource);
         },function(param1:Object):void
         {
            _LegendaryHero_Image1.source = param1;
         },"_LegendaryHero_Image1.source");
         result[4] = binding;
         return result;
      }
      
      public function ___LegendaryHero_Button2_click(param1:MouseEvent) : void
      {
         this.changeFace(-1);
      }
      
      [Bindable(event="propertyChange")]
      public function get chk3() : CheckBox
      {
         return this._3052621chk3;
      }
      
      [Bindable(event="propertyChange")]
      public function get chk1() : CheckBox
      {
         return this._3052619chk1;
      }
      
      public function __chk1_change(param1:Event) : void
      {
         this.onLockChange1();
      }
      
      private function onRender(param1:Object) : void
      {
         if(MainScreen.getPlayer() == null)
         {
            return;
         }
         removeEventListener(Event.RENDER,this.onRender);
         this.updateData();
      }
      
      private function onHeroResponse(param1:RandomHeroResponse) : void
      {
         if(param1.ok)
         {
            this.randomHeroBean = param1.randomherobean;
            this.chk1.selected = this.randomHeroBean.lockmanagement;
            this.chk2.selected = this.randomHeroBean.lockpower;
            this.chk3.selected = this.randomHeroBean.lockstratagem;
            this.calCost();
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get txtCost() : Label
      {
         return this._879022499txtCost;
      }
      
      private function onRecruit() : void
      {
         var _loc1_:int = MainScreen.getInstance().getSelectedCity().cityManager.getBuildingLevel(BuildingConstants.TYPE_HEROS_MANSION);
         if(_loc1_ < 1)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"No Feasting Hall in current City. Please build one or select another City before recruiting."));
         }
         else if(_loc1_ <= MainScreen.getInstance().getSelectedCity().cityManager.heroes.length)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"No available Feasting Hall spot in current City. Please upgrade or select another City before recruiting."));
         }
         else if(this.playername.text.length == 0)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You must enter a valid name for your new hero before recruiting."));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to recruit this hero?",this.onOkayToRecruit,"Yes","Cancel"));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get chk2() : CheckBox
      {
         return this._3052620chk2;
      }
      
      private function set randomHeroBean(param1:RandomHeroBean) : void
      {
         var _loc2_:Object = this._1476239533randomHeroBean;
         if(_loc2_ !== param1)
         {
            this._1476239533randomHeroBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"randomHeroBean",_loc2_,param1));
         }
      }
      
      private function resetFaceArray() : void
      {
         this.faceIndex = 0;
         if(this.sex != 0)
         {
            this.faceArray = FEM_FACES;
         }
         else
         {
            this.faceArray = MAL_FACES;
         }
         this.faceSource = "images/icon/player/" + this.faceArray[this.faceIndex];
      }
      
      private function onLockChange1() : void
      {
         if(this.chk2.selected && this.chk3.selected)
         {
            this.chk1.selected = false;
            return;
         }
         this.calCost();
      }
      
      private function onLockChange2() : void
      {
         if(this.chk1.selected && this.chk3.selected)
         {
            this.chk2.selected = false;
            return;
         }
         this.calCost();
      }
      
      private function onLockChange3() : void
      {
         if(this.chk1.selected && this.chk2.selected)
         {
            this.chk3.selected = false;
            return;
         }
         this.calCost();
      }
      
      public function set playername(param1:TextInput) : void
      {
         var _loc2_:Object = this._2096610540playername;
         if(_loc2_ !== param1)
         {
            this._2096610540playername = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"playername",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get playername() : TextInput
      {
         return this._2096610540playername;
      }
   }
}

