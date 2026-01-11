package com.evony.useful
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   [SWF(width="800",height="600",backgroundColor="#FFFFFF",frameRate="30")]
   public class Main extends Sprite
   {
      private var _app:RoboEvonyMain;
      
      public function Main()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(e:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this._app = new RoboEvonyMain();
         addChild(this._app);
      }
   }
}

