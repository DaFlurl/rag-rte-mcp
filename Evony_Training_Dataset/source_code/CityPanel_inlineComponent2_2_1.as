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
   
   public class CityPanel_inlineComponent2_2 extends HBox implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      private var lastTime:Number = 0;
      
      mx_internal var _bindingsBeginWithWord:Object;
      
      mx_internal var _bindingsByDestination:Object;
      
      private var _92211923_heroFireBtn:Button;
      
      mx_internal var _watchers:Array;
      
      mx_internal var _bindings:Array;
      
      private var _documentDescriptor_:UIComponentDescriptor;
      
      public function CityPanel_inlineComponent2_2()
      {
         this._documentDescriptor_ = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function():Object
            {
               return {"childDescriptors":[new UIComponentDescriptor({
                  "type":Button,
                  "id":"_heroFireBtn",
                  "events":{"click":"___heroFireBtn_click"},
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Fire",
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
         CityPanel_inlineComponent2_2._watcherSetupUtil = param1;
      }
      
      public function ___heroFireBtn_click(param1:MouseEvent) : void
      {
         this.btnClickFireHero(data.col9);
      }
      
      public function set _heroFireBtn(param1:Button) : void
      {
         var _loc2_:Object = this._92211923_heroFireBtn;
         if(_loc2_ !== param1)
         {
            this._92211923_heroFireBtn = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_heroFireBtn",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _heroFireBtn() : Button
      {
         return this._92211923_heroFireBtn;
      }
      
      override public function initialize() : void
      {
         var bindings:Array;
         var watchers:Array;
         var i:uint;
         var target:CityPanel_inlineComponent2_2 = null;
         var watcherSetupUtilClass:Object = null;
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         bindings = this._CityPanel_inlineComponent2_2_bindingsSetup();
         watchers = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanel_inlineComponent2_2WatcherSetupUtil");
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
      
      private function _CityPanel_inlineComponent2_2_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = data.col9 != -1;
      }
      
      private function btnClickFireHero(param1:int) : void
      {
         var _loc2_:Number = Number(new Date().getTime());
         if(_loc2_ < this.lastTime + 3000)
         {
            return;
         }
         this.lastTime = _loc2_;
         parentDocument._onFireHeroBtn(param1);
      }
      
      private function _CityPanel_inlineComponent2_2_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():Boolean
         {
            return data.col9 != -1;
         },function(param1:Boolean):void
         {
            _heroFireBtn.visible = param1;
         },"_heroFireBtn.visible");
         result[0] = binding;
         return result;
      }
   }
}

