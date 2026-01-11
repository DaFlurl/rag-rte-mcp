package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class GetPlayerVoteInfro extends BaseBean
   {
      
      public var curdayvotes:Number;
      
      public function GetPlayerVoteInfro(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         if(param2.curdayvotes != null)
         {
            this.curdayvotes = param2.curdayvotes;
         }
      }
      
      public function copyTo(param1:GetPlayerVoteInfro) : void
      {
         param1.curdayvotes = this.curdayvotes;
      }
      
      public function toObject() : Object
      {
         return {"curdayvotes":this.curdayvotes};
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- GetPlayerVoteInfro ----\n" + (param1 + "curdayvotes = " + this.curdayvotes + "\n");
      }
   }
}

