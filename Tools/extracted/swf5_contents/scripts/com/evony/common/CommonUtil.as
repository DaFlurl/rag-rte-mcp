package com.evony.common
{
   import mx.collections.ArrayCollection;
   
   public class CommonUtil
   {
      public function CommonUtil()
      {
         super();
      }
      
      public static function arrayCopy(param1:ArrayCollection, param2:ArrayCollection) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = new ArrayCollection();
         }
         else
         {
            param2.removeAll();
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            param2.addItem(param1[_loc3_]);
            _loc3_++;
         }
      }
   }
}

