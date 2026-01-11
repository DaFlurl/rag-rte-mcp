package autoevony.gui
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
   import mx.containers.HBox;
   import mx.controls.Button;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CityPanel_inlineComponent0 extends HBox implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      private var _1589444121_abandonValleyBtn:Button;
      
      private var lastTime:Number = 0;
      
      mx_internal var _bindings:Array;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _watchers:Array;
      
      public function CityPanel_inlineComponent0()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"_abandonValleyBtn",
                  "events":{"click":"___abandonValleyBtn_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Abandon",
                        "styleName":"REwinBtn"
                     };
                  }
               })]};
            }
         });
         this.mx_internal::_bindings = [];
         this.mx_internal::_watchers = [];
         this.mx_internal::_bindingsByDestination = {};
         this.mx_internal::_bindingsBeginWithWord = {};
         super();
         mx_internal::_document = this;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration = new CSSStyleDeclaration();
         }
         this.styleDeclaration.defaultFactory = function():void
         {
            this.horizontalGap = 0;
            this.verticalGap = 0;
            this.paddingLeft = 3;
            this.paddingRight = 0;
            this.paddingTop = 0;
            this.paddingBottom = 0;
         };
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CityPanel_inlineComponent0._watcherSetupUtil = param1;
      }
      
      [Bindable(event="propertyChange")]
      public function get _abandonValleyBtn() : Button
      {
         return this._1589444121_abandonValleyBtn;
      }
      
      private function _CityPanel_inlineComponent0_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return data.col4 == "colony" && data.col5 == "";
         },function(param1:Boolean):void
         {
            _abandonValleyBtn.visible = param1;
         },"_abandonValleyBtn.visible");
         result[0] = binding;
         return result;
      }
      
      private function btnClickAbandonColony(param1:int) : void
      {
         var _loc2_:Number = Number(new Date().getTime());
         if(_loc2_ < this.lastTime + 3000)
         {
            return;
         }
         this.lastTime = _loc2_;
         parentDocument._onAbandonColonyBtn(param1);
      }
      
      private function _CityPanel_inlineComponent0_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = data.col4 == "colony" && data.col5 == "";
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CityPanel_inlineComponent0 = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CityPanel_inlineComponent0_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanel_inlineComponent0WatcherSetupUtil");
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
      
      public function set _abandonValleyBtn(param1:Button) : void
      {
         var _loc2_:Object = this._1589444121_abandonValleyBtn;
         if(_loc2_ !== param1)
         {
            this._1589444121_abandonValleyBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_abandonValleyBtn",_loc2_,param1));
         }
      }
      
      public function ___abandonValleyBtn_click(param1:MouseEvent) : void
      {
         this.btnClickAbandonColony(data.col6);
      }
   }
}

