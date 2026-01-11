package autoevony.gui.controls.popup
{
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
   import mx.containers.VBox;
   import mx.controls.Label;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class PopUpWinBase extends Canvas implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      private var _1904299080windowTitle:String = "";
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindings:Array = [];
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":VBox,
               "stylesFactory":function():void
               {
                  this.left = "0";
                  this.right = "0";
                  this.top = "5";
                  this.bottom = "0";
               },
               "propertiesFactory":function():Object
               {
                  return {"styleName":"REpopupWinBase"};
               }
            }),new UIComponentDescriptor({
               "type":VBox,
               "stylesFactory":function():void
               {
                  this.horizontalCenter = "0";
                  this.top = "0";
                  this.horizontalAlign = "center";
                  this.horizontalGap = 0;
                  this.verticalGap = 0;
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "width":220,
                     "height":40,
                     "horizontalScrollPolicy":"off",
                     "verticalScrollPolicy":"off",
                     "styleName":"REmainScreenTopNamePopupTitleContainer"
                  };
               }
            }),new UIComponentDescriptor({
               "type":Label,
               "id":"_PopUpWinBase_Label1",
               "stylesFactory":function():void
               {
                  this.horizontalCenter = "0";
                  this.textAlign = "center";
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "height":27,
                     "styleName":"REpopupWinTitleText"
                  };
               }
            }),new UIComponentDescriptor({
               "type":VBox,
               "events":{
                  "mouseDown":"___PopUpWinBase_VBox3_mouseDown",
                  "mouseUp":"___PopUpWinBase_VBox3_mouseUp"
               },
               "stylesFactory":function():void
               {
                  this.horizontalCenter = "0";
                  this.top = "0";
                  this.horizontalAlign = "center";
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "width":220,
                     "height":40,
                     "horizontalScrollPolicy":"off",
                     "verticalScrollPolicy":"off"
                  };
               }
            })]};
         }
      });
      
      public var _PopUpWinBase_Label1:Label;
      
      mx_internal var _watchers:Array = [];
      
      public function PopUpWinBase()
      {
         super();
         mx_internal::_document = this;
         this.percentWidth = 100;
         this.percentHeight = 100;
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         PopUpWinBase._watcherSetupUtil = param1;
      }
      
      public function ___PopUpWinBase_VBox3_mouseUp(param1:MouseEvent) : void
      {
         parentDocument.stopDrag();
      }
      
      [Bindable(event="propertyChange")]
      public function get windowTitle() : String
      {
         return this._1904299080windowTitle;
      }
      
      public function ___PopUpWinBase_VBox3_mouseDown(param1:MouseEvent) : void
      {
         parentDocument.startDrag();
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:PopUpWinBase = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._PopUpWinBase_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_controls_popup_PopUpWinBaseWatcherSetupUtil");
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
      
      public function set windowTitle(param1:String) : void
      {
         var _loc2_:Object = this._1904299080windowTitle;
         if(_loc2_ !== param1)
         {
            this._1904299080windowTitle = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"windowTitle",_loc2_,param1));
         }
      }
      
      private function _PopUpWinBase_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = this.windowTitle;
      }
      
      private function _PopUpWinBase_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():String
         {
            var _loc1_:* = this.windowTitle;
            return _loc1_ == undefined ? null : String(_loc1_);
         },function(param1:String):void
         {
            _PopUpWinBase_Label1.text = param1;
         },"_PopUpWinBase_Label1.text");
         result[0] = binding;
         return result;
      }
   }
}

