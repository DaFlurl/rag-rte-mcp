package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.AccountInfo;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.module.CommandResponse;
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
   import mx.controls.Button;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ChangeCovenanterWin extends Canvas
   {
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":190,
               "width":440,
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
                     return {"windowTitle":"Transfer Host"};
                  }
               }),new UIComponentDescriptor({
                  "type":Text,
                  "id":"_ChangeCovenanter_Text1",
                  "stylesFactory":function():void
                  {
                     this.left = "25";
                     this.top = "70";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"New Host\'s name",
                        "styleName":"PropertyName1"
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"_newHost",
                  "stylesFactory":function():void
                  {
                     this.left = "25";
                     this.right = "25";
                     this.bottom = "60";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"textInput"};
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"_ChangeCovenanter_Button1",
                  "events":{"click":"___ChangeCovenanter_Button1_click"},
                  "stylesFactory":function():void
                  {
                     this.bottom = "20";
                     this.right = "25";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"Transfer",
                        "styleName":"REwinBtn",
                        "width":75
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___ChangeCovenanterWin_Button2_click"},
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
      
      private var _786267861_ChangeCovenanter_Text1:Text;
      
      private var _1348408624_ChangeCovenanter_Button1:Button;
      
      private var closeFunc:Function = null;
      
      private var _91887063_newHost:TextInput;
      
      public function ChangeCovenanterWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 190;
         this.width = 440;
         this.addEventListener("creationComplete",this.___ChangeCovenanterWin_Canvas1_creationComplete);
      }
      
      private function onResetTopPowerForAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            ActionFactory.getInstance().getAllianceManagementCommands().getPowerFromAlliance(AccountInfo.getInstance().allianceInfo.members.fetchPage);
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Bestowed Host successfully."));
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE,this.onResetTopPowerForAlliance);
            this.close();
         }
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE,this.onResetTopPowerForAlliance);
         this._newHost.setFocus();
      }
      
      public function ___ChangeCovenanterWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set _newHost(param1:TextInput) : void
      {
         var _loc2_:Object = this._91887063_newHost;
         if(_loc2_ !== param1)
         {
            this._91887063_newHost = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_newHost",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ChangeCovenanter_Text1() : Text
      {
         return this._786267861_ChangeCovenanter_Text1;
      }
      
      public function updateInfo(param1:Function = null) : void
      {
         this.closeFunc = param1;
      }
      
      public function ___ChangeCovenanter_Button1_click(param1:MouseEvent) : void
      {
         this.onChangeSubmit();
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function set _ChangeCovenanter_Button1(param1:Button) : void
      {
         var _loc2_:Object = this._1348408624_ChangeCovenanter_Button1;
         if(_loc2_ !== param1)
         {
            this._1348408624_ChangeCovenanter_Button1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ChangeCovenanter_Button1",_loc2_,param1));
         }
      }
      
      private function onChangeSubmit() : void
      {
         ActionFactory.getInstance().getAllianceManagementCommands().resetTopPowerForAlliance(this._newHost.text);
      }
      
      [Bindable(event="propertyChange")]
      public function get _newHost() : TextInput
      {
         return this._91887063_newHost;
      }
      
      public function set _ChangeCovenanter_Text1(param1:Text) : void
      {
         var _loc2_:Object = this._786267861_ChangeCovenanter_Text1;
         if(_loc2_ !== param1)
         {
            this._786267861_ChangeCovenanter_Text1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_ChangeCovenanter_Text1",_loc2_,param1));
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get _ChangeCovenanter_Button1() : Button
      {
         return this._1348408624_ChangeCovenanter_Button1;
      }
      
      public function ___ChangeCovenanterWin_Button2_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE,this.onResetTopPowerForAlliance);
         this.closeFunc.apply(null,[this]);
      }
   }
}

