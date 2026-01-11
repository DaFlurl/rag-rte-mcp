package autoevony.gui
{
   import autoevony.gui.info.Alliance.AllianceView;
   import autoevony.gui.info.HistoricalHeroes;
   import autoevony.gui.info.Items.ItemInfo;
   import autoevony.gui.info.LegendaryHero;
   import autoevony.gui.info.Mail.MailsView;
   import autoevony.gui.info.Reports.ReportView;
   import autoevony.gui.info.Stats.StatsView;
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
   import mx.containers.ViewStack;
   import mx.controls.TabBar;
   import mx.controls.tabBarClasses.Tab;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class AccountInfo extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private static var instance:AccountInfo = null;
      
      private static var createAllFlag:Boolean = false;
      
      private var _10605819mailInfo:MailsView;
      
      private var _1606004101allianceInfo:AllianceView;
      
      private var _1219205682hhInfo:HistoricalHeroes;
      
      mx_internal var _watchers:Array = [];
      
      private var _1631638246accountInfoTab:TabBar;
      
      private var _341646643accountInfoStack:ViewStack;
      
      private var _1104689078lhInfo:LegendaryHero;
      
      private var _1177195105itemInfo:ItemInfo;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      public var _AccountInfo_HBox1:HBox;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _1317377314statInfo:StatsView;
      
      mx_internal var _bindings:Array = [];
      
      private var _1931047938reportInfo:ReportView;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "creationPolicy":"all",
               "childDescriptors":[new UIComponentDescriptor({
                  "type":VBox,
                  "stylesFactory":function():void
                  {
                     this.horizontalGap = 0;
                     this.verticalGap = 0;
                     this.left = "0";
                     this.right = "0";
                     this.top = "3";
                     this.bottom = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "percentWidth":100,
                        "percentHeight":100,
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":HBox,
                           "id":"_AccountInfo_HBox1",
                           "stylesFactory":function():void
                           {
                              this.verticalAlign = "bottom";
                              this.borderColor = 2237479;
                              this.borderStyle = "solid";
                              this.borderSides = "bottom";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "height":22,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":TabBar,
                                    "id":"accountInfoTab",
                                    "stylesFactory":function():void
                                    {
                                       this.tabStyleName = "REtabBarAccountTabs";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {
                                          "dataProvider":"accountInfoStack",
                                          "styleName":"REtabBar"
                                       };
                                    }
                                 })]
                              };
                           }
                        }),new UIComponentDescriptor({
                           "type":ViewStack,
                           "id":"accountInfoStack",
                           "stylesFactory":function():void
                           {
                              this.bottom = "0";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "creationPolicy":"all",
                                 "percentWidth":100,
                                 "percentHeight":100,
                                 "childDescriptors":[new UIComponentDescriptor({
                                    "type":MailsView,
                                    "id":"mailInfo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Mail"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":AllianceView,
                                    "id":"allianceInfo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Alliance"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":StatsView,
                                    "id":"statInfo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Statistics"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":HistoricalHeroes,
                                    "id":"hhInfo",
                                    "stylesFactory":function():void
                                    {
                                       this.borderColor = 2237479;
                                       this.borderThickness = 1;
                                       this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Historic Heroes"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":LegendaryHero,
                                    "id":"lhInfo",
                                    "stylesFactory":function():void
                                    {
                                       this.borderColor = 2237479;
                                       this.borderThickness = 1;
                                       this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Legendary Hero"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ItemInfo,
                                    "id":"itemInfo",
                                    "stylesFactory":function():void
                                    {
                                       this.borderColor = 2237479;
                                       this.borderThickness = 1;
                                       this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Items"};
                                    }
                                 }),new UIComponentDescriptor({
                                    "type":ReportView,
                                    "id":"reportInfo",
                                    "propertiesFactory":function():Object
                                    {
                                       return {"label":"Reports"};
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
      
      public function AccountInfo()
      {
         super();
         mx_internal::_document = this;
         this.creationPolicy = "all";
         this.percentWidth = 100;
         this.percentHeight = 100;
         this.addEventListener("creationComplete",this.___AccountInfo_Canvas1_creationComplete);
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         AccountInfo._watcherSetupUtil = param1;
      }
      
      public static function getInstance() : AccountInfo
      {
         if(!createAllFlag)
         {
            MainScreen.getInstance().logMsg("Before accessing information in any GUI in the account tab, please make sure you view it first!!!");
            instance.createComponentsFromDescriptors(true);
            createAllFlag = true;
         }
         return instance;
      }
      
      [Bindable(event="propertyChange")]
      public function get reportInfo() : ReportView
      {
         return this._1931047938reportInfo;
      }
      
      public function set reportInfo(param1:ReportView) : void
      {
         var _loc2_:Object = this._1931047938reportInfo;
         if(_loc2_ !== param1)
         {
            this._1931047938reportInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get allianceInfo() : AllianceView
      {
         return this._1606004101allianceInfo;
      }
      
      public function set allianceInfo(param1:AllianceView) : void
      {
         var _loc2_:Object = this._1606004101allianceInfo;
         if(_loc2_ !== param1)
         {
            this._1606004101allianceInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"allianceInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get mailInfo() : MailsView
      {
         return this._10605819mailInfo;
      }
      
      public function set mailInfo(param1:MailsView) : void
      {
         var _loc2_:Object = this._10605819mailInfo;
         if(_loc2_ !== param1)
         {
            this._10605819mailInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mailInfo",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:AccountInfo = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._AccountInfo_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_AccountInfoWatcherSetupUtil");
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
      public function get accountInfoTab() : TabBar
      {
         return this._1631638246accountInfoTab;
      }
      
      public function set lhInfo(param1:LegendaryHero) : void
      {
         var _loc2_:Object = this._1104689078lhInfo;
         if(_loc2_ !== param1)
         {
            this._1104689078lhInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"lhInfo",_loc2_,param1));
         }
      }
      
      public function set hhInfo(param1:HistoricalHeroes) : void
      {
         var _loc2_:Object = this._1219205682hhInfo;
         if(_loc2_ !== param1)
         {
            this._1219205682hhInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"hhInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get statInfo() : StatsView
      {
         return this._1317377314statInfo;
      }
      
      private function init() : void
      {
         if(instance == null)
         {
            instance = this;
         }
         createAllFlag = true;
      }
      
      public function set accountInfoStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._341646643accountInfoStack;
         if(_loc2_ !== param1)
         {
            this._341646643accountInfoStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"accountInfoStack",_loc2_,param1));
         }
      }
      
      private function _AccountInfo_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Number
         {
            return (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Historic Heroes" || (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Legendary Hero" || (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Items" ? 0 : 1;
         },function(param1:Number):void
         {
            _AccountInfo_HBox1.setStyle("borderThickness",param1);
         },"_AccountInfo_HBox1.borderThickness");
         result[0] = binding;
         return result;
      }
      
      public function set accountInfoTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._1631638246accountInfoTab;
         if(_loc2_ !== param1)
         {
            this._1631638246accountInfoTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"accountInfoTab",_loc2_,param1));
         }
      }
      
      public function set itemInfo(param1:ItemInfo) : void
      {
         var _loc2_:Object = this._1177195105itemInfo;
         if(_loc2_ !== param1)
         {
            this._1177195105itemInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"itemInfo",_loc2_,param1));
         }
      }
      
      public function set statInfo(param1:StatsView) : void
      {
         var _loc2_:Object = this._1317377314statInfo;
         if(_loc2_ !== param1)
         {
            this._1317377314statInfo = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"statInfo",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get accountInfoStack() : ViewStack
      {
         return this._341646643accountInfoStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get hhInfo() : HistoricalHeroes
      {
         return this._1219205682hhInfo;
      }
      
      public function toDebugString() : String
      {
         return "fields: mailInfo allianceInfo statInfo hhInfo lhInfo itemInfo reportInfo";
      }
      
      [Bindable(event="propertyChange")]
      public function get lhInfo() : LegendaryHero
      {
         return this._1104689078lhInfo;
      }
      
      private function _AccountInfo_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Historic Heroes" || (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Legendary Hero" || (this.accountInfoTab.getChildAt(this.accountInfoTab.selectedIndex) as Tab).label == "Items" ? 0 : 1;
      }
      
      public function ___AccountInfo_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      [Bindable(event="propertyChange")]
      public function get itemInfo() : ItemInfo
      {
         return this._1177195105itemInfo;
      }
   }
}

