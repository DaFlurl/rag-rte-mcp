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
   import com.evony.common.module.alliance.AllianceInfoResponse;
   import com.evony.common.module.alliance.AllianceManagementResponse;
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
   import mx.controls.Label;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   import mx.utils.ObjectProxy;
   
   use namespace mx_internal;
   
   public class AllianceInfoWin extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var _1176657665_AllianceInfo_Label8:Label;
      
      private var _1770687502_AllianceInfo_Text6:Text;
      
      private var _1176657670_AllianceInfo_Label3:Label;
      
      private var _1032494288officalLevel:int = 0;
      
      private var _1812093596_AllianceInfo_Button1:Button;
      
      private var _832584058makeMid:Button;
      
      private var _1770687498_AllianceInfo_Text2:Text;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      private var _1770687500_AllianceInfo_Text4:Text;
      
      private var _689501127makeFriends:Button;
      
      private var _1176657669_AllianceInfo_Label4:Label;
      
      private var _1770687503_AllianceInfo_Text7:Text;
      
      private var _1176657666_AllianceInfo_Label7:Label;
      
      private var _1176657667_AllianceInfo_Label6:Label;
      
      private var _1176657668_AllianceInfo_Label5:Label;
      
      public var _AllianceInfoWin_PopUpWinBase1:PopUpWinBase;
      
      private var _1125982860curRank:int = 0;
      
      private var _1770687499_AllianceInfo_Text3:Text;
      
      private var _1176657671_AllianceInfo_Label2:Label;
      
      mx_internal var _watchers:Array = [];
      
      private var _1605786759allianceBean:ObjectProxy = new ObjectProxy();
      
      private var _602853347unionInfo:Canvas;
      
      private var _1770687501_AllianceInfo_Text5:Text;
      
      private var _1180125369isShow:Boolean = false;
      
      private var _1770687497_AllianceInfo_Text1:Text;
      
      private var _39953579makeArmy:Button;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var closeFunc:Function = null;
      
      mx_internal var _bindings:Array = [];
      
      private var _1606140770allianceName:String;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":290,
               "width":440,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "id":"_AllianceInfoWin_PopUpWinBase1",
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "id":"unionInfo",
                  "propertiesFactory":function():Object
                  {
                     return {
                        "height":290,
                        "horizontalScrollPolicy":"off",
                        "percentWidth":100,
                        "verticalScrollPolicy":"off",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":Button,
                           "id":"_AllianceInfo_Button1",
                           "events":{"click":"___AllianceInfo_Button1_click"},
                           "stylesFactory":function():void
                           {
                              this.bottom = "15";
                              this.right = "20";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "label":"Apply",
                                 "styleName":"REwinOkayBtn",
                                 "width":68
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.left = "21";
                              this.top = "67";
                              this.right = "215";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "styleName":"textBackground",
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function():void
                                    {
                                       this.left = "5";
                                       this.top = "5";
                                       this.bottom = "5";
                                       this.right = "5";
                                       this.horizontalAlign = "center";
                                       this.horizontalGap = 3;
                                       this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"childDescriptors":[new UIComponentDescriptor({
                                          "type":HBox,
                                          "stylesFactory":function():void
                                          {
                                             this.horizontalGap = 0;
                                             this.verticalAlign = "middle";
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label2",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Host: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text1",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
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
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label3",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Founder: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text2",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
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
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label4",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Members: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text3",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
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
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label5",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Ranking: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text4",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
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
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label6",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Honor: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text5",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
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
                                          },
                                          "propertiesFactory":function():Object
                                          {
                                             return {
                                                "percentHeight":100,
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor({
                                                   "type":Label,
                                                   "id":"_AllianceInfo_Label7",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "right";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "text":"Prestige: ",
                                                         "height":22,
                                                         "styleName":"focusColor",
                                                         "width":75
                                                      };
                                                   }
                                                }),new UIComponentDescriptor({
                                                   "type":Text,
                                                   "id":"_AllianceInfo_Text6",
                                                   "stylesFactory":function():void
                                                   {
                                                      this.textAlign = "left";
                                                   },
                                                   "propertiesFactory":function():Object
                                                   {
                                                      return {
                                                         "height":22,
                                                         "selectable":false,
                                                         "styleName":"labelWithBackGround",
                                                         "width":105
                                                      };
                                                   }
                                                })]
                                             };
                                          }
                                       })]};
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":Canvas,
                           "stylesFactory":function():void
                           {
                              this.top = "45";
                              this.bottom = "45";
                              this.right = "15";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":200,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceInfo_Label8",
                                    "stylesFactory":function():void
                                    {
                                       this.top = "5";
                                       this.textAlign = "center";
                                       this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "text":"Introduction",
                                          "percentWidth":100,
                                          "styleName":"focusColor"
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_AllianceInfo_Text7",
                                    "stylesFactory":function():void
                                    {
                                       this.top = "30";
                                       this.left = "5";
                                       this.right = "5";
                                       this.bottom = "0";
                                       this.textAlign = "left";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "selectable":false,
                                          "styleName":"ParamgraphText1"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":HBox,
                           "stylesFactory":function():void
                           {
                              this.horizontalGap = 2;
                              this.verticalGap = 0;
                              this.verticalAlign = "middle";
                              this.bottom = "15";
                              this.left = "20";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "width":210,
                                 "height":25,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"makeFriends",
                                    "events":{"click":"__makeFriends_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Friendly",
                                          "styleName":"REwinOkayBtn",
                                          "width":67
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"makeMid",
                                    "events":{"click":"__makeMid_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Neutral",
                                          "styleName":"REwinBtn",
                                          "width":67
                                       };
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"makeArmy",
                                    "events":{"click":"__makeArmy_click"},
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "label":"Hostile",
                                          "styleName":"REwinCancelBtn",
                                          "width":67
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
                  "events":{"click":"___AllianceInfoWin_Button5_click"},
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
      
      public function AllianceInfoWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 290;
         this.width = 440;
         this.addEventListener("creationComplete",this.___AllianceInfoWin_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AllianceInfoWin._watcherSetupUtil = param1;
      }
      
      public function ___AllianceInfoWin_Button5_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function set _AllianceInfo_Label5(param1:Label) : void
      {
         var _loc2_:Object = this._1176657668_AllianceInfo_Label5;
         if(_loc2_ !== param1)
         {
            this._1176657668_AllianceInfo_Label5 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label5",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text1() : Text
      {
         return this._1770687497_AllianceInfo_Text1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text2() : Text
      {
         return this._1770687498_AllianceInfo_Text2;
      }
      
      public function set _AllianceInfo_Label7(param1:Label) : void
      {
         var _loc2_:Object = this._1176657666_AllianceInfo_Label7;
         if(_loc2_ !== param1)
         {
            this._1176657666_AllianceInfo_Label7 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label7",_loc2_,param1));
         }
      }
      
      public function ___AllianceInfo_Button1_click(param1:MouseEvent) : void
      {
         this.joinUnion();
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text4() : Text
      {
         return this._1770687500_AllianceInfo_Text4;
      }
      
      public function set _AllianceInfo_Text2(param1:Text) : void
      {
         var _loc2_:Object = this._1770687498_AllianceInfo_Text2;
         if(_loc2_ !== param1)
         {
            this._1770687498_AllianceInfo_Text2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text2",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Label3(param1:Label) : void
      {
         var _loc2_:Object = this._1176657670_AllianceInfo_Label3;
         if(_loc2_ !== param1)
         {
            this._1176657670_AllianceInfo_Label3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label3",_loc2_,param1));
         }
      }
      
      public function updateInfo(param1:Object = null, param2:Function = null) : void
      {
         this.curRank = param1.rank;
         this.allianceBean.honor = param1.honor;
         this.allianceName = param1.name;
         this.officalLevel = MainScreen.getPlayer().playerInfo.levelId;
         var _loc3_:String = MainScreen.getPlayer().playerInfo.alliance;
         if(_loc3_ != null && _loc3_ != param1.name)
         {
            if(this.officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE || this.officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE || this.officalLevel == AllianceConstants.MIDDLE_ALLIANCE)
            {
               this.isShow = true;
            }
         }
         if(!this._AllianceInfo_Button1.enabled)
         {
            this._AllianceInfo_Button1.enabled = true;
         }
         this.closeFunc = param2;
         ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(this.allianceName,this.onGetAllianceInfo);
      }
      
      public function set _AllianceInfo_Label4(param1:Label) : void
      {
         var _loc2_:Object = this._1176657669_AllianceInfo_Label4;
         if(_loc2_ !== param1)
         {
            this._1176657669_AllianceInfo_Label4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label4",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Text1(param1:Text) : void
      {
         var _loc2_:Object = this._1770687497_AllianceInfo_Text1;
         if(_loc2_ !== param1)
         {
            this._1770687497_AllianceInfo_Text1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text1",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text3() : Text
      {
         return this._1770687499_AllianceInfo_Text3;
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE,this.onUserWantInAlliance);
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP,this.onSetAllianceFriendship);
      }
      
      [Bindable(event="propertyChange")]
      public function get unionInfo() : Canvas
      {
         return this._602853347unionInfo;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text6() : Text
      {
         return this._1770687502_AllianceInfo_Text6;
      }
      
      public function set _AllianceInfo_Text5(param1:Text) : void
      {
         var _loc2_:Object = this._1770687501_AllianceInfo_Text5;
         if(_loc2_ !== param1)
         {
            this._1770687501_AllianceInfo_Text5 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text5",_loc2_,param1));
         }
      }
      
      private function onGetAllianceInfo(param1:AllianceInfoResponse) : void
      {
         if(param1.ok == CommandResponse.OK_DEFAULT)
         {
            this.allianceBean["leader"] = param1.leader;
            this.allianceBean["creator"] = param1.creator;
            this.allianceBean["memberCount"] = param1.memberCount;
            this.allianceBean["prestigeCount"] = param1.prestigeCount;
            this.allianceBean["allinaceInfo"] = param1.allinaceInfo;
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text5() : Text
      {
         return this._1770687501_AllianceInfo_Text5;
      }
      
      public function __makeFriends_click(param1:MouseEvent) : void
      {
         this.submitRelation(param1);
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Text7() : Text
      {
         return this._1770687503_AllianceInfo_Text7;
      }
      
      private function submitRelation(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.makeFriends:
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName,AllianceConstants.FRIEND_ALLIANCE);
               break;
            case this.makeArmy:
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName,AllianceConstants.ENEMY_ALLIANCE);
               break;
            case this.makeMid:
               ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName,AllianceConstants.MIDDLE_ALLIANCE);
         }
      }
      
      public function set _AllianceInfo_Text7(param1:Text) : void
      {
         var _loc2_:Object = this._1770687503_AllianceInfo_Text7;
         if(_loc2_ !== param1)
         {
            this._1770687503_AllianceInfo_Text7 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text7",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Label8(param1:Label) : void
      {
         var _loc2_:Object = this._1176657665_AllianceInfo_Label8;
         if(_loc2_ !== param1)
         {
            this._1176657665_AllianceInfo_Label8 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label8",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Text3(param1:Text) : void
      {
         var _loc2_:Object = this._1770687499_AllianceInfo_Text3;
         if(_loc2_ !== param1)
         {
            this._1770687499_AllianceInfo_Text3 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text3",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Text4(param1:Text) : void
      {
         var _loc2_:Object = this._1770687500_AllianceInfo_Text4;
         if(_loc2_ !== param1)
         {
            this._1770687500_AllianceInfo_Text4 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text4",_loc2_,param1));
         }
      }
      
      public function set _AllianceInfo_Text6(param1:Text) : void
      {
         var _loc2_:Object = this._1770687502_AllianceInfo_Text6;
         if(_loc2_ !== param1)
         {
            this._1770687502_AllianceInfo_Text6 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Text6",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get officalLevel() : int
      {
         return this._1032494288officalLevel;
      }
      
      public function set unionInfo(param1:Canvas) : void
      {
         var _loc2_:Object = this._602853347unionInfo;
         if(_loc2_ !== param1)
         {
            this._602853347unionInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"unionInfo",_loc2_,param1));
         }
      }
      
      private function set curRank(param1:int) : void
      {
         var _loc2_:Object = this._1125982860curRank;
         if(_loc2_ !== param1)
         {
            this._1125982860curRank = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"curRank",_loc2_,param1));
         }
      }
      
      private function set allianceBean(param1:ObjectProxy) : void
      {
         var _loc2_:Object = this._1605786759allianceBean;
         if(_loc2_ !== param1)
         {
            this._1605786759allianceBean = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceBean",_loc2_,param1));
         }
      }
      
      public function set makeArmy(param1:Button) : void
      {
         var _loc2_:Object = this._39953579makeArmy;
         if(_loc2_ !== param1)
         {
            this._39953579makeArmy = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"makeArmy",_loc2_,param1));
         }
      }
      
      private function _AllianceInfoWin_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.allianceName;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfoWin_PopUpWinBase1.windowTitle = param1;
         },"_AllianceInfoWin_PopUpWinBase1.windowTitle");
         result[0] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.officalLevel == AllianceConstants.SAME_ALLIANCE;
         },function(param1:Boolean):void
         {
            _AllianceInfo_Button1.visible = param1;
         },"_AllianceInfo_Button1.visible");
         result[1] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.allianceBean.leader;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text1.text = param1;
         },"_AllianceInfo_Text1.text");
         result[2] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.allianceBean.creator;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text2.text = param1;
         },"_AllianceInfo_Text2.text");
         result[3] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.allianceBean.memberCount;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text3.text = param1;
         },"_AllianceInfo_Text3.text");
         result[4] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.curRank;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text4.text = param1;
         },"_AllianceInfo_Text4.text");
         result[5] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.allianceBean.honor);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text5.text = param1;
         },"_AllianceInfo_Text5.text");
         result[6] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = Utils.formatInt(this.allianceBean.prestigeCount);
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text6.text = param1;
         },"_AllianceInfo_Text6.text");
         result[7] = binding;
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.allianceBean.allinaceInfo;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _AllianceInfo_Text7.text = param1;
         },"_AllianceInfo_Text7.text");
         result[8] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeFriends.visible = param1;
         },"makeFriends.visible");
         result[9] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeFriends.includeInLayout = param1;
         },"makeFriends.includeInLayout");
         result[10] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeMid.visible = param1;
         },"makeMid.visible");
         result[11] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeMid.includeInLayout = param1;
         },"makeMid.includeInLayout");
         result[12] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeArmy.visible = param1;
         },"makeArmy.visible");
         result[13] = binding;
         binding = new Binding(this,function():Boolean
         {
            return this.isShow;
         },function(param1:Boolean):void
         {
            makeArmy.includeInLayout = param1;
         },"makeArmy.includeInLayout");
         result[14] = binding;
         return result;
      }
      
      public function set _AllianceInfo_Label6(param1:Label) : void
      {
         var _loc2_:Object = this._1176657667_AllianceInfo_Label6;
         if(_loc2_ !== param1)
         {
            this._1176657667_AllianceInfo_Label6 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label6",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get isShow() : Boolean
      {
         return this._1180125369isShow;
      }
      
      private function set officalLevel(param1:int) : void
      {
         var _loc2_:Object = this._1032494288officalLevel;
         if(_loc2_ !== param1)
         {
            this._1032494288officalLevel = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"officalLevel",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get allianceName() : String
      {
         return this._1606140770allianceName;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Button1() : Button
      {
         return this._1812093596_AllianceInfo_Button1;
      }
      
      public function set makeMid(param1:Button) : void
      {
         var _loc2_:Object = this._832584058makeMid;
         if(_loc2_ !== param1)
         {
            this._832584058makeMid = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"makeMid",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get allianceBean() : ObjectProxy
      {
         return this._1605786759allianceBean;
      }
      
      [Bindable(event="propertyChange")]
      private function get curRank() : int
      {
         return this._1125982860curRank;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AllianceInfoWin = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AllianceInfoWin_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil");
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
      public function get makeMid() : Button
      {
         return this._832584058makeMid;
      }
      
      public function set makeFriends(param1:Button) : void
      {
         var _loc2_:Object = this._689501127makeFriends;
         if(_loc2_ !== param1)
         {
            this._689501127makeFriends = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"makeFriends",_loc2_,param1));
         }
      }
      
      public function __makeMid_click(param1:MouseEvent) : void
      {
         this.submitRelation(param1);
      }
      
      private function onUserWantInAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
            this._AllianceInfo_Button1.enabled = true;
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Application for joining alliance " + this.allianceName + " is submitted. Please wait for approval."));
         }
      }
      
      private function set isShow(param1:Boolean) : void
      {
         var _loc2_:Object = this._1180125369isShow;
         if(_loc2_ !== param1)
         {
            this._1180125369isShow = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isShow",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get makeArmy() : Button
      {
         return this._39953579makeArmy;
      }
      
      private function set allianceName(param1:String) : void
      {
         var _loc2_:Object = this._1606140770allianceName;
         if(_loc2_ !== param1)
         {
            this._1606140770allianceName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceName",_loc2_,param1));
         }
      }
      
      private function joinUnion() : void
      {
         this._AllianceInfo_Button1.enabled = false;
         ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(this.allianceName);
      }
      
      private function _AllianceInfoWin_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.allianceName;
         _loc1_ = this.officalLevel == AllianceConstants.SAME_ALLIANCE;
         _loc1_ = this.allianceBean.leader;
         _loc1_ = this.allianceBean.creator;
         _loc1_ = this.allianceBean.memberCount;
         _loc1_ = this.curRank;
         _loc1_ = Utils.formatInt(this.allianceBean.honor);
         _loc1_ = Utils.formatInt(this.allianceBean.prestigeCount);
         _loc1_ = this.allianceBean.allinaceInfo;
         _loc1_ = this.isShow;
         _loc1_ = this.isShow;
         _loc1_ = this.isShow;
         _loc1_ = this.isShow;
         _loc1_ = this.isShow;
         _loc1_ = this.isShow;
      }
      
      public function set _AllianceInfo_Button1(param1:Button) : void
      {
         var _loc2_:Object = this._1812093596_AllianceInfo_Button1;
         if(_loc2_ !== param1)
         {
            this._1812093596_AllianceInfo_Button1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Button1",_loc2_,param1));
         }
      }
      
      public function ___AllianceInfoWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      private function onSetAllianceFriendship(param1:AllianceManagementResponse) : void
      {
         if(this.isPopUp)
         {
            if(param1.ok != CommandResponse.OK_DEFAULT)
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
            }
            else
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Diplomatic Relationship is changed successfully."));
            }
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get makeFriends() : Button
      {
         return this._689501127makeFriends;
      }
      
      public function __makeArmy_click(param1:MouseEvent) : void
      {
         this.submitRelation(param1);
      }
      
      public function set _AllianceInfo_Label2(param1:Label) : void
      {
         var _loc2_:Object = this._1176657671_AllianceInfo_Label2;
         if(_loc2_ !== param1)
         {
            this._1176657671_AllianceInfo_Label2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceInfo_Label2",_loc2_,param1));
         }
      }
      
      public function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE,this.onUserWantInAlliance);
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP,this.onSetAllianceFriendship);
         this.closeFunc.apply(null,[this]);
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label2() : Label
      {
         return this._1176657671_AllianceInfo_Label2;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label3() : Label
      {
         return this._1176657670_AllianceInfo_Label3;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label4() : Label
      {
         return this._1176657669_AllianceInfo_Label4;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label5() : Label
      {
         return this._1176657668_AllianceInfo_Label5;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label6() : Label
      {
         return this._1176657667_AllianceInfo_Label6;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label7() : Label
      {
         return this._1176657666_AllianceInfo_Label7;
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceInfo_Label8() : Label
      {
         return this._1176657665_AllianceInfo_Label8;
      }
   }
}

