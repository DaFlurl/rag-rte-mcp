package autoevony.gui.info.Alliance
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.AccountInfo;
   import autoevony.gui.controls.popup.PopUpWinBase;
   import com.evony.client.action.ActionFactory;
   import com.evony.client.response.ResponseDispatcher;
   import com.evony.common.beans.PlayerInfoBean;
   import com.evony.common.constants.AllianceConstants;
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
   import mx.collections.ArrayCollection;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.Label;
   import mx.controls.TextInput;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class ExpelMemberWin extends Canvas
   {
      private var membersArray:ArrayCollection = new ArrayCollection();
      
      private var _1693934272retireMemberName:TextInput;
      
      private var closeFunc:Function = null;
      
      private var _775009873_AllianceRetire_Button1:Button;
      
      private var _677560724_AllianceRetire_Label2:Label;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":200,
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
                     return {"windowTitle":"Expel Member"};
                  }
               }),new UIComponentDescriptor({
                  "type":Label,
                  "id":"_AllianceRetire_Label2",
                  "stylesFactory":function():void
                  {
                     this.top = "70";
                     this.left = "25";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "text":"Enter the member name to expel",
                        "selectable":false,
                        "styleName":"PropertyName1",
                        "width":285
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":TextInput,
                  "id":"retireMemberName",
                  "stylesFactory":function():void
                  {
                     this.bottom = "70";
                     this.left = "25";
                     this.right = "25";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"textInput"};
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "id":"_AllianceRetire_Button1",
                  "events":{"click":"___AllianceRetire_Button1_click"},
                  "stylesFactory":function():void
                  {
                     this.bottom = "30";
                     this.right = "25";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "label":"OK",
                        "styleName":"REwinOkayBtn",
                        "width":75
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___ExpelMemberWin_Button2_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "7";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "styleName":"close",
                        "y":0
                     };
                  }
               })]
            };
         }
      });
      
      public function ExpelMemberWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 200;
         this.width = 440;
         this.addEventListener("creationComplete",this.___ExpelMemberWin_Canvas1_creationComplete);
      }
      
      [Bindable(event="propertyChange")]
      public function get retireMemberName() : TextInput
      {
         return this._1693934272retireMemberName;
      }
      
      public function ___ExpelMemberWin_Button2_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function init() : void
      {
         ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE,this.onKickOutMemberFromAlliance);
         this.retireMemberName.setFocus();
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceRetire_Button1() : Button
      {
         return this._775009873_AllianceRetire_Button1;
      }
      
      private function submitRetire() : void
      {
         if(this.retireMemberName.text == null || this.retireMemberName.text == "")
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"You must enter a valid player name."));
            return;
         }
         var _loc1_:PlayerInfoBean = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.membersArray.length)
         {
            _loc1_ = this.membersArray[_loc2_] as PlayerInfoBean;
            if(_loc1_.userName == this.retireMemberName.text)
            {
               if(_loc1_.levelId == AllianceConstants.LAST_POWER_FOR_ALLIANCE)
               {
                  ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.retireMemberName.text);
               }
               else
               {
                  dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Are you sure you want to expel this Officer from the alliance?",this.onClickOk,"Yes"));
               }
               break;
            }
            if(_loc2_ >= this.membersArray.length - 1)
            {
               dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"This player is not in your alliance."));
            }
            _loc2_++;
         }
      }
      
      public function set retireMemberName(param1:TextInput) : void
      {
         var _loc2_:Object = this._1693934272retireMemberName;
         if(_loc2_ !== param1)
         {
            this._1693934272retireMemberName = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"retireMemberName",_loc2_,param1));
         }
      }
      
      public function updateInfo(param1:ArrayCollection, param2:Function = null) : void
      {
         this.membersArray = param1;
         this.closeFunc = param2;
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      private function onKickOutMemberFromAlliance(param1:AllianceManagementResponse) : void
      {
         if(param1.ok != CommandResponse.OK_DEFAULT)
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,param1.errorMsg));
         }
         else
         {
            dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN,"Expelled member successfully."));
            AccountInfo.getInstance().allianceInfo.members.fetchPage();
            this.close();
         }
      }
      
      private function onClickOk(param1:Boolean) : void
      {
         if(param1)
         {
            ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.retireMemberName.text);
         }
      }
      
      public function ___ExpelMemberWin_Canvas1_creationComplete(param1:FlexEvent) : void
      {
         this.init();
      }
      
      public function set _AllianceRetire_Button1(param1:Button) : void
      {
         var _loc2_:Object = this._775009873_AllianceRetire_Button1;
         if(_loc2_ !== param1)
         {
            this._775009873_AllianceRetire_Button1 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceRetire_Button1",_loc2_,param1));
         }
      }
      
      public function set _AllianceRetire_Label2(param1:Label) : void
      {
         var _loc2_:Object = this._677560724_AllianceRetire_Label2;
         if(_loc2_ !== param1)
         {
            this._677560724_AllianceRetire_Label2 = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_AllianceRetire_Label2",_loc2_,param1));
         }
      }
      
      public function close() : void
      {
         ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE,this.onKickOutMemberFromAlliance);
         this.closeFunc.apply(null,[this]);
      }
      
      public function ___AllianceRetire_Button1_click(param1:MouseEvent) : void
      {
         this.submitRetire();
      }
      
      [Bindable(event="propertyChange")]
      public function get _AllianceRetire_Label2() : Label
      {
         return this._677560724_AllianceRetire_Label2;
      }
   }
}

