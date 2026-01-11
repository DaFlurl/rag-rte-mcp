package com.evony.common.server.events
{
   import com.evony.common.BaseBean;
   
   public class StrategyBuff extends BaseBean
   {
      
      public function StrategyBuff(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
      }
      
      public function copyTo(param1:StrategyBuff) : void
      {
      }
      
      override public function toDebugString(param1:String = "") : String
      {
         return "---- StrategyBuff ----\n";
      }
      
      public function toObject() : Object
      {
         return {};
      }
   }
}

