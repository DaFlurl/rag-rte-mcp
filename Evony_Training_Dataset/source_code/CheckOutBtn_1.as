package autoevony.gui.info.Alliance
{
   import autoevony.gui.MainScreen;
   import com.evony.common.constants.ColonyConstants;
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
   import mx.controls.Button;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   use namespace mx_internal;
   
   public class CheckOutBtn extends Button implements IBindingClient
   {
      private static var _watcherSetupUtil:IWatcherSetupUtil;
      
      public var armyTypeId:int;
      
      public var heroStasus:int;
      
      mx_internal var _bindingsBeginWithWord:Object = {};
      
      mx_internal var _bindingsByDestination:Object = {};
      
      mx_internal var _watchers:Array = [];
      
      mx_internal var _bindings:Array = [];
      
      private var _985752863player:String = MainScreen.getPlayer().playerInfo.userName;
      
      private var _1805312139styleType:String = "REwinBtn";
      
      public function CheckOutBtn()
      {
         super();
      }
      
      public static function set watcherSetupUtil(param1:IWatcherSetupUtil) : void
      {
         CheckOutBtn._watcherSetupUtil = param1;
      }
      
      private function set player(param1:String) : void
      {
         var _loc2_:Object = this._985752863player;
         if(_loc2_ !== param1)
         {
            this._985752863player = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"player",_loc2_,param1));
         }
      }
      
      private function _CheckOutBtn_bindingsSetup() : Array
      {
         var binding:Binding = null;
         var result:Array = [];
         binding = new Binding(this,function():*
         {
            return this.styleType;
         },function(param1:*):void
         {
            this.styleName = param1;
         },"this.styleName");
         result[0] = binding;
         return result;
      }
      
      public function set colonyBtnEnable(param1:int) : void
      {
         if(param1 != ColonyConstants.COLONY_STATUS_ABANDON)
         {
            this.enabled = true;
         }
         else
         {
            this.enabled = false;
         }
      }
      
      override public function initialize() : void
      {
         var i:uint;
         var target:CheckOutBtn = null;
         var watcherSetupUtilClass:Object = null;
         var bindings:Array = this._CheckOutBtn_bindingsSetup();
         var watchers:Array = [];
         target = this;
         if(_watcherSetupUtil == null)
         {
            watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_CheckOutBtnWatcherSetupUtil");
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
      private function get styleType() : String
      {
         return this._1805312139styleType;
      }
      
      public function set btnLable(param1:String) : void
      {
         this.label = param1;
      }
      
      private function _CheckOutBtn_bindingExprs() : void
      {
         var _loc1_:* = undefined;
         this.styleName = this.styleType;
      }
      
      private function set styleType(param1:String) : void
      {
         var _loc2_:Object = this._1805312139styleType;
         if(_loc2_ !== param1)
         {
            this._1805312139styleType = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"styleType",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      private function get player() : String
      {
         return this._985752863player;
      }
      
      public function set btnEnable(param1:String) : void
      {
         if(param1 != this.player)
         {
            this.enabled = false;
         }
         else
         {
            this.enabled = true;
         }
      }
   }
}

