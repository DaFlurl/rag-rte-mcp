package autoevony.gui.info.Alliance
{
   import autoevony.gui.MainScreen;
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
   import mx.controls.Spacer;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CancelDiploBtn_inlineComponent0 extends HBox implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public var _CancelDiploBtn_inlineComponent0_Button1:Button;
      
      mx_internal var _bindingsByDestination:Object;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _watchers:Array;
      
      public function CancelDiploBtn_inlineComponent0()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Spacer,
                  "propertiesFactory":function():Object
                  {
                     return {"width":3};
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"_CancelDiploBtn_inlineComponent0_Button1",
                  "events":{"click":"___CancelDiploBtn_inlineComponent0_Button1_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Cancel",
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
         };
         this.horizontalScrollPolicy = "off";
         this.verticalScrollPolicy = "off";
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CancelDiploBtn_inlineComponent0._watcherSetupUtil = param1;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CancelDiploBtn_inlineComponent0 = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CancelDiploBtn_inlineComponent0_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CancelDiploBtn_inlineComponent0WatcherSetupUtil");
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
      
      private function _CancelDiploBtn_inlineComponent0_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = data.showCancelBtn;
      }
      
      private function _CancelDiploBtn_inlineComponent0_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return data.showCancelBtn;
         },function(param1:Boolean):void
         {
            _CancelDiploBtn_inlineComponent0_Button1.visible = param1;
         },"_CancelDiploBtn_inlineComponent0_Button1.visible");
         result[0] = binding;
         return result;
      }
      
      public function ___CancelDiploBtn_inlineComponent0_Button1_click(param1:MouseEvent) : void
      {
         MainScreen.getInstance()._accountInfo.allianceInfo.allianceDiplo.cancelRelation(data);
      }
   }
}

