package com.evony.common
{
   import flash.ui.Mouse;
   import mx.managers.CursorManager;
   
   public class MouseManager
   {
      internal static var isBusy:Boolean = false;
      
      isBusy = false;
      isBusy = false;
      
      public function MouseManager()
      {
         super();
      }
      
      public static function setNormal() : void
      {
         if(isBusy)
         {
            try
            {
               isBusy = false;
               CursorManager.removeBusyCursor();
            }
            catch(e:Error)
            {
               Mouse.show();
            }
         }
      }
      
      public static function setBusy() : void
      {
         if(!isBusy)
         {
            try
            {
               isBusy = true;
               CursorManager.setBusyCursor();
            }
            catch(e:Error)
            {
               Mouse.show();
            }
         }
      }
   }
}

