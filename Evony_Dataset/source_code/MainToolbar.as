package com.evony.useful.ui.components
{
   import com.evony.useful.ui.chat.UnifiedChatInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MainToolbar extends Sprite
   {
      private var _chatInterface:UnifiedChatInterface;
      
      private var _buttons:Array = [];
      
      public function MainToolbar()
      {
         super();
         this.createToolbar();
      }
      
      private function createToolbar() : void
      {
         this.addButton("Save File",this.onSaveFile);
         this.addButton("Load File",this.onLoadFile);
         this.addButton("Run",this.onRun);
         this.addButton("Clear",this.onClear);
         this.addButton("Event",this.onEvent);
         this.addButton("Save All",this.onSaveAll);
         this.addButton("Toggle Chat",this.onToggleChat);
      }
      
      private function addButton(label:String, clickHandler:Function) : void
      {
         var button:Sprite = this.createButton(label);
         button.x = this._buttons.length * (button.width + 5);
         button.y = 0;
         button.addEventListener(MouseEvent.CLICK,clickHandler);
         addChild(button);
         this._buttons.push(button);
      }
      
      private function createButton(label:String) : Sprite
      {
         var button:Sprite = new Sprite();
         button.graphics.beginFill(6710886);
         button.graphics.drawRoundRect(0,0,80,25,5,5);
         button.graphics.endFill();
         var tf:TextField = new TextField();
         var format:TextFormat = new TextFormat();
         format.color = 16777215;
         format.size = 12;
         format.align = "center";
         tf.defaultTextFormat = format;
         tf.text = label;
         tf.width = 80;
         tf.height = 25;
         tf.selectable = false;
         tf.mouseEnabled = false;
         button.addChild(tf);
         button.buttonMode = true;
         button.useHandCursor = true;
         return button;
      }
      
      private function onSaveFile(e:MouseEvent) : void
      {
      }
      
      private function onLoadFile(e:MouseEvent) : void
      {
      }
      
      private function onRun(e:MouseEvent) : void
      {
      }
      
      private function onClear(e:MouseEvent) : void
      {
      }
      
      private function onEvent(e:MouseEvent) : void
      {
      }
      
      private function onSaveAll(e:MouseEvent) : void
      {
      }
      
      private function onToggleChat(e:MouseEvent) : void
      {
         if(!this._chatInterface)
         {
            this._chatInterface = new UnifiedChatInterface();
            this._chatInterface.x = 10;
            this._chatInterface.y = -200;
            addChild(this._chatInterface);
         }
         this._chatInterface.visible = !this._chatInterface.visible;
      }
   }
}

