package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   import com.evony.common.beans.PlayerInfoBean;
   
   public class PlayerInfoUpdate extends BaseBean
   {
      
      public var playerInfo:PlayerInfoBean;
      
      public function PlayerInfoUpdate(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.playerInfo != null)
         {
            this.playerInfo = new PlayerInfoBean(param2.playerInfo);
         }
      }
      
      public function copyTo(param1:PlayerInfoUpdate) : void
      {
         if(this.playerInfo != null)
         {
            this.playerInfo.copyTo(param1.playerInfo);
         }
         else
         {
            param1.playerInfo = null;
         }
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- PlayerInfoUpdate ----\n" + (this.playerInfo != null ? this.playerInfo.toDebugString(param1 + "playerInfo.") : param1 + "playerInfo = null\n");
      }
      
      public function toObject() : Object
      {
         return {"playerInfo":this.playerInfo.toObject()};
      }
   }
}

