package autoevony.event
{
   import flash.events.Event;
   import mx.collections.ArrayCollection;
   
   public class popUpWinShowEvent extends Event
   {
      public static const POP_UP_WIN_SHOW:String = "popUpWin.show";
      
      public static const ALERT_WIN:int = 0;
      
      public static const ARMY_DETAILS_WIN:int = 1;
      
      public static const TRAINING_FIELD_WIN:int = 2;
      
      public static const HERO_MANAGEMENT_WIN:int = 10;
      
      public static const HERO_DESC_WIN:int = 11;
      
      public static const HERO_APPLY_ITEM_WIN:int = 12;
      
      public static const ALLIANCE_INFO_WIN:int = 20;
      
      public static const ALLIANCE_MEMBER_INFO:int = 21;
      
      public static const ALLIANCE_CHANGE_HOST:int = 22;
      
      public static const ALLIANCE_EXPEL_MEMBER:int = 23;
      
      public static const ALLIANCE_INVITE_MEMBER:int = 24;
      
      public static const ALLIANCE_PENDING_APPLICATIONS:int = 25;
      
      public static const ALLIANCE_EDIT_INTRO:int = 26;
      
      public static const VIEW_ITEM_INFO_WIN:int = 30;
      
      public static const BUY_ITEM_WIN:int = 31;
      
      public var yesBtnName:String = null;
      
      public var msg:String = null;
      
      public var callBack:Function = null;
      
      public var popUpType:int;
      
      public var noBtnName:String = null;
      
      public var membersArray:ArrayCollection = null;
      
      public var parentObj:* = null;
      
      public var objParam:Object = null;
      
      public var winTitle:String = null;
      
      public var args:Array = null;
      
      public function popUpWinShowEvent(param1:int = 0, param2:String = "", param3:Function = null, param4:String = "OK", param5:String = "Cancel", param6:Array = null, param7:String = null)
      {
         super(POP_UP_WIN_SHOW,true);
         this.popUpType = param1;
         this.winTitle = param7;
         this.msg = param2;
         this.yesBtnName = param4;
         this.noBtnName = param5;
         this.callBack = param3;
         this.args = param6;
      }
   }
}

