package com.evony.util
{
   import flash.display.Bitmap;
   import flash.events.Event;
   import mx.core.BitmapAsset;
   import mx.events.FlexEvent;
   
   public class ImageSmooth
   {
      public function ImageSmooth()
      {
         super();
      }
      
      public static function onLoadComplete(param1:Event) : void
      {
         if(param1.currentTarget.content != null)
         {
            if(param1.currentTarget.content is BitmapAsset)
            {
               BitmapAsset(param1.currentTarget.content).smoothing = true;
            }
            else
            {
               Bitmap(param1.currentTarget.content).smoothing = true;
            }
         }
      }
      
      public static function onCreationComplete(param1:FlexEvent) : void
      {
         if(param1.currentTarget.content != null)
         {
            if(param1.currentTarget.content is BitmapAsset)
            {
               BitmapAsset(param1.currentTarget.content).smoothing = true;
            }
            else if(param1.currentTarget.content is Bitmap)
            {
               Bitmap(param1.currentTarget.content).smoothing = true;
            }
         }
      }
   }
}

