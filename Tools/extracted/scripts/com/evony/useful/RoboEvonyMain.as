package com.evony.useful
{
   import com.evony.useful.ui.components.MainToolbar;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class RoboEvonyMain extends Sprite
   {
      private var _toolbar:MainToolbar;
      
      public function RoboEvonyMain()
      {
         super();
         if(Boolean(stage))
         {
            this.init();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.init);
         }
      }
      
      private function init(e:Event = null) : void
      {
         if(hasEventListener(Event.ADDED_TO_STAGE))
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.init);
         }
         this._toolbar = new MainToolbar();
         this._toolbar.x = 10;
         this._toolbar.y = stage.stageHeight - this._toolbar.height - 10;
         addChild(this._toolbar);
         stage.addEventListener(Event.RESIZE,this.onStageResize);
      }
      
      private function onStageResize(e:Event) : void
      {
         this._toolbar.y = stage.stageHeight - this._toolbar.height - 10;
      }
   }
}

