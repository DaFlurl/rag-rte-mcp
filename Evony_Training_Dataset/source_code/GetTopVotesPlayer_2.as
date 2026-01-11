package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class GetTopVotesPlayer extends BaseBean
   {
      public var getvotes:Number;
      
      public function GetTopVotesPlayer(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.getvotes != null)
         {
            this.getvotes = param2.getvotes;
         }
      }
      
      public function copyTo(param1:GetTopVotesPlayer) : void
      {
         param1.getvotes = this.getvotes;
      }
      
      public function toObject() : Object
      {
         return {"getvotes":this.getvotes};
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- GetTopVotesPlayer ----\n" + (param1 + "getvotes = " + this.getvotes + "\n");
      }
   }
}

