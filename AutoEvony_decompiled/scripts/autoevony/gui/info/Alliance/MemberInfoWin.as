package autoevony.gui.info.Alliance
{
   import autoevony.common.Utils;
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.MainScreen;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.constants.AllianceConstants;
   import com.evony.common.module.CommandResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
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
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class MemberInfoWin extends Canvas implements IBindingClient
   {
      
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public var _MemberInfoWin_Text8:Text;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":350,
               "width":490,
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
                     return {"windowTitle":"Member Info"};
                  }
               }),new UIComponentDescriptor({
                  "type":ComboBox,
                  "id":"officePostCB",
                  "stylesFactory":function():void
                  {
                     this.left = "40";
                     this.bottom = "30";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "width":110,
                        "styleName":"ComboBox",
                        "height":22
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "40";
                     this.right = "40";
                     this.top = "45";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":149,
                        "styleName":"textBackground",
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.left = "5";
                              this.top = "10";
                              this.bottom = "10";
                              this.verticalGap = 5;
                              this.right = "130";
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Lord: ",
                                                   "height":22,
                                                   "percentWidth":35,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text1",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":65,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Alliance: ",
                                                   "height":22,
                                                   "percentWidth":35,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text2",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":65,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Position: ",
                                                   "height":22,
                                                   "percentWidth":35,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text3",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":65,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Rank: ",
                                                   "height":22,
                                                   "percentWidth":35,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text4",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":65,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Title: ",
                                                   "height":22,
                                                   "percentWidth":35,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text5",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":65,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
                                                };
                                             }
                                          })]
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Image,
                           "id":"_MemberInfoWin_Image1",
                           "events":{"complete":"___MemberInfoWin_Image1_complete"},
                           "stylesFactory":function():void
                           {
                              this.top = "20";
                              this.right = "30";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":100,
                                 "width":100
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "40";
                     this.right = "40";
                     this.top = "200";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":89,
                        "styleName":"textBackground",
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":VBox,
                           "stylesFactory":function():void
                           {
                              this.top = "5";
                              this.left = "5";
                              this.right = "5";
                              this.bottom = "5";
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Population: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text6",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                                   "text":"Ranking: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text7",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Cities: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text8",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                                   "text":"Prestige: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text9",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "percentWidth":100,
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
                                                   "text":"Honor: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text10",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                                                   "text":"Position: ",
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "styleName":"focusColor"
                                                };
                                             }
                                          }),new UIComponentDescriptor({
                                             "type":Text,
                                             "id":"_MemberInfoWin_Text11",
                                             "stylesFactory":function():void
                                             {
                                                this.textAlign = "left";
                                             },
                                             "propertiesFactory":function():Object
                                             {
                                                return {
                                                   "height":22,
                                                   "percentWidth":25,
                                                   "selectable":false,
                                                   "styleName":"labelWithBackGround"
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
                     this.right = "40";
                     this.bottom = "30";
                     this.horizontalGap = 3;
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"resetLevel",
                           "events":{"click":"__resetLevel_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"Change Permission",
                                 "styleName":"REwinBtn"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_MemberInfoWin_Button2",
                           "events":{"click":"___MemberInfoWin_Button2_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"Expel",
                                 "styleName":"REwinBtn"
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Button,
                           "id":"_MemberInfoWin_Button3",
                           "events":{"click":"___MemberInfoWin_Button3_click"},
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"Write",
                                 "visible":false,
                                 "styleName":"REwinBtn"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___MemberInfoWin_Button4_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "7";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"close"};
                  }
               })]
            };
         }
      });
      
      public var _MemberInfoWin_Text11:Text;
      
      public var _MemberInfoWin_Text7:Text;
      
      public var _MemberInfoWin_Text9:Text;
      
      public var _MemberInfoWin_Text2:Text;
      
      public var _MemberInfoWin_Text4:Text;
      
      private var _1443179717dataPCB:ArrayCollection = new ArrayCollection([{
         "label":"Member",
         "data":AllianceConstants.LAST_POWER_FOR_ALLIANCE
      },{
         "label":"Officer",
         "data":AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE
      },{
         "label":"Presbyter",
         "data":AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE
      },{
         "label":"Vice Host",
         "data":AllianceConstants.TOP2_POWER_FOR_ALLIANCE
      }]);
      
      private var _112621893canChangePower:Boolean = false;
      
      public var _MemberInfoWin_Button2:Button;
      
      public var _MemberInfoWin_Button3:Button;
      
      public var _MemberInfoWin_Image1:Image;
      
      private var _2067570601isOwner:Boolean;
      
      mx_internal var _watchers:Array = [];
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1366077706memberLevel:int;
      
      private var _19962424memberInfoBean:Object;
      
      private var closeFunc:Function = null;
      
      private var _1748641499officePostCB:ComboBox;
      
      mx_internal var _bindings:Array = [];
      
      public var _MemberInfoWin_Text10:Text;
      
      private var _497023925curMemberId:int;
      
      public var _MemberInfoWin_Text1:Text;
      
      private var _1694398603resetLevel:Button;
      
      public var _MemberInfoWin_Text3:Text;
      
      public var _MemberInfoWin_Text5:Text;
      
      public var _MemberInfoWin_Text6:Text;
      
      public function MemberInfoWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 350;
         this.width = 490;
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
         this.addEventListener("creationComplete",this.___MemberInfoWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         MemberInfoWin._watcherSetupUtil = param1;
      }
      
      public function ___MemberInfoWin_Button4_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function getIconUrl(param1:String) : String
      {
         return "http://e2.eimg.us/" + param1;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:MemberInfoWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._MemberInfoWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil");
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
      private function get memberLevel() : int
      {
         return this._1366077706memberLevel;
      }
      
      private function turnBack() : void
      {
         this.close();
      }
      
      private function getLevelId() : int
      {
         return MainScreen.getPlayer().playerInfo.levelId;
      }
      
      private function onSetPowerForUser(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Set permission successfully."));
            MainScreen.getInstance()._accountInfo.allianceInfo.members.fetchPage();
            this.close();
         }
      }
      
      public function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE,this.onSetPowerForUser);
         this.closeFunc.apply(null,[this]);
      }
      
      private function _MemberInfoWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Object
         {
            return this.dataPCB;
         },function(param1:Object):void
         {
            officePostCB.dataProvider = param1;
         },"officePostCB.dataProvider");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.canChangePower;
         },function(param1:Boolean):void
         {
            officePostCB.visible = param1;
         },"officePostCB.visible");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.userName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text1.text = param1;
         },"_MemberInfoWin_Text1.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.alliance;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text2.text = param1;
         },"_MemberInfoWin_Text2.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.allianceLevel;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text3.text = param1;
         },"_MemberInfoWin_Text3.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.office;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text4.text = param1;
         },"_MemberInfoWin_Text4.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.titleStr;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text5.text = param1;
         },"_MemberInfoWin_Text5.text");
         result[6] = binding;
         binding = new Binding(this,function():Object
         {
            return this.getIconUrl(this.memberInfoBean.faceUrl);
         },function(param1:Object):void
         {
            _MemberInfoWin_Image1.source = param1;
         },"_MemberInfoWin_Image1.source");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.memberInfoBean.population);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text6.text = param1;
         },"_MemberInfoWin_Text6.text");
         result[8] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.memberInfoBean.ranking);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text7.text = param1;
         },"_MemberInfoWin_Text7.text");
         result[9] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.castleCount;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text8.text = param1;
         },"_MemberInfoWin_Text8.text");
         result[10] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.memberInfoBean.prestige);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text9.text = param1;
         },"_MemberInfoWin_Text9.text");
         result[11] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.memberInfoBean.honor);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text10.text = param1;
         },"_MemberInfoWin_Text10.text");
         result[12] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.memberInfoBean.allianceLevel;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _MemberInfoWin_Text11.text = param1;
         },"_MemberInfoWin_Text11.text");
         result[13] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.canChangePower;
         },function(param1:Boolean):void
         {
            resetLevel.visible = param1;
         },"resetLevel.visible");
         result[14] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.memberInfoBean.levelId > this.getLevelId() ? true : false;
         },function(param1:Boolean):void
         {
            _MemberInfoWin_Button2.enabled = param1;
         },"_MemberInfoWin_Button2.enabled");
         result[15] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isOwner;
         },function(param1:Boolean):void
         {
            _MemberInfoWin_Button3.includeInLayout = param1;
         },"_MemberInfoWin_Button3.includeInLayout");
         result[16] = binding;
         return result;
      }
      
      public function updateInfo(param1:Object = null, param2:Function = null) : void
      {
         this.memberInfoBean = param1;
         this.memberLevel = MainScreen.getPlayer().playerInfo.levelId;
         this.canChangePower = this._canChangePower();
         if(MainScreen.getPlayer().playerInfo.userName != param1.userName)
         {
            this.isOwner = true;
         }
         else
         {
            this.isOwner = false;
         }
         switch(param1.levelId)
         {
            case AllianceConstants.LAST_POWER_FOR_ALLIANCE:
               this.officePostCB.selectedIndex = 0;
               break;
            case AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE:
               this.officePostCB.selectedIndex = 1;
               break;
            case AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE:
               this.officePostCB.selectedIndex = 2;
               break;
            case AllianceConstants.TOP2_POWER_FOR_ALLIANCE:
               this.officePostCB.selectedIndex = 3;
         }
         this.closeFunc = param2;
      }
      
      public function ___MemberInfoWin_Button2_click(param1:MouseEvent) : void
      {
         this.fireMember();
      }
      
      private function getTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "Civilian";
         }
         if(param1 == 1)
         {
            return "Knight";
         }
         if(param1 == 2)
         {
            return "Baronet";
         }
         if(param1 == 3)
         {
            return "Baron";
         }
         if(param1 == 4)
         {
            return "Viscount";
         }
         if(param1 == 5)
         {
            return "Earl";
         }
         if(param1 == 6)
         {
            return "Marquis";
         }
         if(param1 == 7)
         {
            return "Duke";
         }
         if(param1 == 8)
         {
            return "Furstin";
         }
         if(param1 == 9)
         {
            return "Prinzessin";
         }
         return "";
      }
      
      private function set memberLevel(param1:int) : void
      {
         var _loc2_:Object = this._1366077706memberLevel;
         if(_loc2_ !== param1)
         {
            this._1366077706memberLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"memberLevel",_loc2_,param1));
         }
      }
      
      public function __resetLevel_click(param1:MouseEvent) : void
      {
         this.changePower();
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE,this.onSetPowerForUser);
      }
      
      private function set memberInfoBean(param1:Object) : void
      {
         var _loc2_:Object = this._19962424memberInfoBean;
         if(_loc2_ !== param1)
         {
            this._19962424memberInfoBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"memberInfoBean",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get isOwner() : Boolean
      {
         return this._2067570601isOwner;
      }
      
      private function changePower() : void
      {
         if(this.officePostCB.selectedItem["data"] != this.memberInfoBean.levelId)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(this.memberInfoBean.userName,this.officePostCB.selectedItem["data"]);
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"This player is " + this.officePostCB.selectedLabel + " already."));
         }
      }
      
      private function writeMail() : void
      {
         this.close();
      }
      
      private function set dataPCB(param1:ArrayCollection) : void
      {
         var _loc2_:Object = this._1443179717dataPCB;
         if(_loc2_ !== param1)
         {
            this._1443179717dataPCB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"dataPCB",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get curMemberId() : int
      {
         return this._497023925curMemberId;
      }
      
      public function set officePostCB(param1:ComboBox) : void
      {
         var _loc2_:Object = this._1748641499officePostCB;
         if(_loc2_ !== param1)
         {
            this._1748641499officePostCB = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"officePostCB",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get dataPCB() : ArrayCollection
      {
         return this._1443179717dataPCB;
      }
      
      [Bindable(event="propertyChange")]
      public function get resetLevel() : Button
      {
         return this._1694398603resetLevel;
      }
      
      public function ___MemberInfoWin_Button3_click(param1:MouseEvent) : void
      {
         this.writeMail();
      }
      
      [Bindable(event="propertyChange")]
      private function get memberInfoBean() : Object
      {
         return this._19962424memberInfoBean;
      }
      
      private function set isOwner(param1:Boolean) : void
      {
         var _loc2_:Object = this._2067570601isOwner;
         if(_loc2_ !== param1)
         {
            this._2067570601isOwner = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isOwner",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get canChangePower() : Boolean
      {
         return this._112621893canChangePower;
      }
      
      public function ___MemberInfoWin_Image1_complete(param1:Event) : void
      {
         ImageSmooth.onLoadComplete(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get officePostCB() : ComboBox
      {
         return this._1748641499officePostCB;
      }
      
      private function set canChangePower(param1:Boolean) : void
      {
         var _loc2_:Object = this._112621893canChangePower;
         if(_loc2_ !== param1)
         {
            this._112621893canChangePower = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canChangePower",_loc2_,param1));
         }
      }
      
      private function _canChangePower() : Boolean
      {
         if(this.memberLevel < this.memberInfoBean.levelId)
         {
            this.resetLevel.enabled = true;
         }
         else
         {
            this.resetLevel.enabled = false;
         }
         return this.memberInfoBean.userName == MainScreen.getPlayer().playerInfo.userName ? false : this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE;
      }
      
      public function ___MemberInfoWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function _MemberInfoWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.dataPCB;
         _loc1_ = this.canChangePower;
         _loc1_ = this.memberInfoBean.userName;
         _loc1_ = this.memberInfoBean.alliance;
         _loc1_ = this.memberInfoBean.allianceLevel;
         _loc1_ = this.memberInfoBean.office;
         _loc1_ = this.memberInfoBean.titleStr;
         _loc1_ = this.getIconUrl(this.memberInfoBean.faceUrl);
         _loc1_ = Utils.formatInt(this.memberInfoBean.population);
         _loc1_ = Utils.formatInt(this.memberInfoBean.ranking);
         _loc1_ = this.memberInfoBean.castleCount;
         _loc1_ = Utils.formatInt(this.memberInfoBean.prestige);
         _loc1_ = Utils.formatInt(this.memberInfoBean.honor);
         _loc1_ = this.memberInfoBean.allianceLevel;
         _loc1_ = this.canChangePower;
         _loc1_ = this.memberInfoBean.levelId > this.getLevelId() ? true : false;
         _loc1_ = this.isOwner;
      }
      
      private function onKickOutMemberFromAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Expelled member successfully."));
            MainScreen.getInstance()._accountInfo.allianceInfo.members.fetchPage();
            this.close();
         }
      }
      
      private function fireMember() : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.memberInfoBean.userName,this.onKickOutMemberFromAlliance);
      }
      
      public function set resetLevel(param1:Button) : void
      {
         var _loc2_:Object = this._1694398603resetLevel;
         if(_loc2_ !== param1)
         {
            this._1694398603resetLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"resetLevel",_loc2_,param1));
         }
      }
      
      private function set curMemberId(param1:int) : void
      {
         var _loc2_:Object = this._497023925curMemberId;
         if(_loc2_ !== param1)
         {
            this._497023925curMemberId = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curMemberId",_loc2_,param1));
         }
      }
   }
}

