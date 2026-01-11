package autoevony.gui.info.Reports
{
   import com.evony.common.constants.ObjConstants;
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
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class ReportView extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _3002781army:Reports;
      
      private var _1057242163reportInfoTab:TabBar;
      
      mx_internal var _watchers:Array = [];
      
      private var _109264638scout:Reports;
      
      private var _1897885786reportInfoStack:ViewStack;
      
      mx_internal var _bindings:Array = [];
      
      private var _110621028trade:Reports;
      
      private var _106069776other:Reports;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "creationPolicy":"none",
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
                     return {"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function():void
                        {
                           this.verticalAlign = "bottom";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":22,
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":TabBar,
                                 "id":"reportInfoTab",
                                 "stylesFactory":function():void
                                 {
                                    this.tabStyleName = "REtabBarTab";
                                 },
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "dataProvider":"reportInfoStack",
                                       "styleName":"REtabBar"
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"reportInfoStack",
                        "stylesFactory":function():void
                        {
                           this.borderColor = 2236962;
                           this.borderThickness = 1;
                           this.borderStyle = "solid";
                        },
                        "propertiesFactory":function():Object
                        {
                           return {
                              "creationPolicy":"all",
                              "percentHeight":100,
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Reports,
                                 "id":"army",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"label":"Army"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Reports,
                                 "id":"scout",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"label":"Scout"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Reports,
                                 "id":"trade",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"label":"Trade"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":Reports,
                                 "id":"other",
                                 "propertiesFactory":function():Object
                                 {
                                    return {"label":"Other"};
                                 }
                              })]
                           };
                        }
                     })]};
                  }
               })]
            };
         }
      });
      
      public function ReportView()
      {
         super();
         mx_internal::_document = this;
         this.creationPolicy = "none";
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         ReportView._watcherSetupUtil = param1;
      }
      
      private function _ReportView_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = ObjConstants.REPORT_TYPE_ARMY;
         _loc1_ = ObjConstants.REPORT_TYPE_SCOUT;
         _loc1_ = ObjConstants.REPORT_TYPE_TRADE;
         _loc1_ = ObjConstants.REPORT_TYPE_OTHER;
      }
      
      public function set trade(param1:Reports) : void
      {
         var _loc2_:Object = this._110621028trade;
         if(_loc2_ !== param1)
         {
            this._110621028trade = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"trade",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reportInfoTab() : TabBar
      {
         return this._1057242163reportInfoTab;
      }
      
      [Bindable(event="propertyChange")]
      public function get scout() : Reports
      {
         return this._109264638scout;
      }
      
      private function _ReportView_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():int
         {
            return ObjConstants.REPORT_TYPE_ARMY;
         },function(param1:int):void
         {
            army.reportType = param1;
         },"army.reportType");
         result[0] = binding;
         binding = new Binding(this,function():int
         {
            return ObjConstants.REPORT_TYPE_SCOUT;
         },function(param1:int):void
         {
            scout.reportType = param1;
         },"scout.reportType");
         result[1] = binding;
         binding = new Binding(this,function():int
         {
            return ObjConstants.REPORT_TYPE_TRADE;
         },function(param1:int):void
         {
            trade.reportType = param1;
         },"trade.reportType");
         result[2] = binding;
         binding = new Binding(this,function():int
         {
            return ObjConstants.REPORT_TYPE_OTHER;
         },function(param1:int):void
         {
            other.reportType = param1;
         },"other.reportType");
         result[3] = binding;
         return result;
      }
      
      public function toDebugString() : String
      {
         return "field: army scout trade other";
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:ReportView = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._ReportView_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Reports_ReportViewWatcherSetupUtil");
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
      
      public function set reportInfoStack(param1:ViewStack) : void
      {
         var _loc2_:Object = this._1897885786reportInfoStack;
         if(_loc2_ !== param1)
         {
            this._1897885786reportInfoStack = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportInfoStack",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get army() : Reports
      {
         return this._3002781army;
      }
      
      public function set other(param1:Reports) : void
      {
         var _loc2_:Object = this._106069776other;
         if(_loc2_ !== param1)
         {
            this._106069776other = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"other",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get reportInfoStack() : ViewStack
      {
         return this._1897885786reportInfoStack;
      }
      
      [Bindable(event="propertyChange")]
      public function get other() : Reports
      {
         return this._106069776other;
      }
      
      [Bindable(event="propertyChange")]
      public function get trade() : Reports
      {
         return this._110621028trade;
      }
      
      public function set army(param1:Reports) : void
      {
         var _loc2_:Object = this._3002781army;
         if(_loc2_ !== param1)
         {
            this._3002781army = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"army",_loc2_,param1));
         }
      }
      
      public function set scout(param1:Reports) : void
      {
         var _loc2_:Object = this._109264638scout;
         if(_loc2_ !== param1)
         {
            this._109264638scout = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scout",_loc2_,param1));
         }
      }
      
      public function set reportInfoTab(param1:TabBar) : void
      {
         var _loc2_:Object = this._1057242163reportInfoTab;
         if(_loc2_ !== param1)
         {
            this._1057242163reportInfoTab = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"reportInfoTab",_loc2_,param1));
         }
      }
   }
}

