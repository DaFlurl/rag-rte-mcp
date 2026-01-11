package autoevony.gui.info.Alliance
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
   import mx.controls.Label;
   import mx.core.mx_internal;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class Info_inlineComponent1 extends Label implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindings:Array = [];
      
      mx_internal var _watchers:Array = [];
      
      public function Info_inlineComponent1()
      {
         super();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         Info_inlineComponent1._watcherSetupUtil = param1;
      }
      
      private function _Info_inlineComponent1_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return " " + data.memberCount + "/" + data.memberLimit;
         },function(param1:*):void
         {
            this.text = param1;
         },"this.text");
         result[0] = binding;
         return result;
      }
      
      override public function initialize() : void
      {
         var i:uint;
         var target:Info_inlineComponent1 = null;
         var watcherSetupUtilClass:Object = null;
         var bindings:Array = this._Info_inlineComponent1_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_Info_inlineComponent1WatcherSetupUtil");
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
      
      private function _Info_inlineComponent1_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         this.text = " " + data.memberCount + "/" + data.memberLimit;
      }
   }
}

