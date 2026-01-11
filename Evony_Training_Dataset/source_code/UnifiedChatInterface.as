package com.evony.useful.ui.chat
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class UnifiedChatInterface extends Sprite
   {
      private var _background:Sprite;
      
      private var _chatArea:TextField;
      
      private var _inputArea:TextField;
      
      private var _sendButton:Sprite;
      
      public function UnifiedChatInterface()
      {
         super();
         this.createBackground();
         this.createChatArea();
         this.createInputArea();
         this.createSendButton();
         this._chatArea.x = 10;
         this._chatArea.y = 10;
         this._inputArea.x = 10;
         this._inputArea.y = this._chatArea.y + this._chatArea.height + 5;
         this._sendButton.x = this._inputArea.x + this._inputArea.width + 5;
         this._sendButton.y = this._inputArea.y;
      }
      
      private function createBackground() : void
      {
         this._background = new Sprite();
         this._background.graphics.beginFill(15658734);
         this._background.graphics.drawRoundRect(0,0,300,200,10,10);
         this._background.graphics.endFill();
         addChild(this._background);
      }
      
      private function createChatArea() : void
      {
         this._chatArea = new TextField();
         this._chatArea.width = 280;
         this._chatArea.height = 140;
         this._chatArea.background = true;
         this._chatArea.backgroundColor = 16777215;
         this._chatArea.border = true;
         this._chatArea.borderColor = 13421772;
         this._chatArea.multiline = true;
         this._chatArea.wordWrap = true;
         this._chatArea.text = "Chat messages will appear here...";
         addChild(this._chatArea);
      }
      
      private function createInputArea() : void
      {
         this._inputArea = new TextField();
         this._inputArea.width = 220;
         this._inputArea.height = 25;
         this._inputArea.type = TextFieldType.INPUT;
         this._inputArea.background = true;
         this._inputArea.backgroundColor = 16777215;
         this._inputArea.border = true;
         this._inputArea.borderColor = 13421772;
         addChild(this._inputArea);
      }
      
      private function createSendButton() : void
      {
         this._sendButton = new Sprite();
         this._sendButton.graphics.beginFill(6710886);
         this._sendButton.graphics.drawRoundRect(0,0,50,25,5,5);
         this._sendButton.graphics.endFill();
         var label:TextField = new TextField();
         var format:TextFormat = new TextFormat();
         format.color = 16777215;
         format.size = 12;
         format.align = "center";
         label.defaultTextFormat = format;
         label.text = "Send";
         label.width = 50;
         label.height = 25;
         label.selectable = false;
         label.mouseEnabled = false;
         this._sendButton.addChild(label);
         this._sendButton.buttonMode = true;
         this._sendButton.useHandCursor = true;
         this._sendButton.addEventListener(MouseEvent.CLICK,this.onSendClick);
         addChild(this._sendButton);
      }
      
      private function onSendClick(e:MouseEvent) : void
      {
         if(this._inputArea.text.length > 0)
         {
            this._chatArea.appendText("\nYou: " + this._inputArea.text);
            this._inputArea.text = "";
         }
      }
   }
}

