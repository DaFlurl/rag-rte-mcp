package autoevony.gui.heroview
{
   import autoevony.gui.controls.popup.PopUpWinBase;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.containers.Canvas;
   import mx.controls.Button;
   import mx.controls.TextArea;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class HistHeroDescWin extends Canvas
   {
      
      private var _90814320_desc:TextArea;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {
               "height":300,
               "width":400,
               "childDescriptors":[new UIComponentDescriptor({
                  "type":PopUpWinBase,
                  "stylesFactory":function():void
                  {
                     this.left = "0";
                     this.top = "0";
                     this.bottom = "0";
                     this.right = "0";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"windowTitle":"Hero Info"};
                  }
               }),new UIComponentDescriptor({
                  "type":Canvas,
                  "stylesFactory":function():void
                  {
                     this.left = "15";
                     this.top = "50";
                     this.bottom = "15";
                     this.right = "15";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {
                        "horizontalScrollPolicy":"off",
                        "verticalScrollPolicy":"off",
                        "styleName":"textBackground",
                        "childDescriptors":[new UIComponentDescriptor({
                           "type":TextArea,
                           "id":"_desc",
                           "stylesFactory":function():void
                           {
                              this.left = "5";
                              this.right = "5";
                              this.top = "5";
                              this.bottom = "5";
                              this.backgroundAlpha = 0;
                              this.borderStyle = "none";
                           },
                           "propertiesFactory":function():Object
                           {
                              return {
                                 "editable":false,
                                 "styleName":"ParamgraphText1"
                              };
                           }
                        })]
                     };
                  }
               }),new UIComponentDescriptor({
                  "type":Button,
                  "events":{"click":"___HistHeroDescWin_Button1_click"},
                  "stylesFactory":function():void
                  {
                     this.top = "7";
                     this.right = "2";
                  },
                  "propertiesFactory":function():Object
                  {
                     return {"styleName":"close"};
                  }
               })]
            };
         }
      });
      
      private var closeFunc:Function = null;
      
      public function HistHeroDescWin()
      {
         super();
         mx_internal::_document = this;
         this.height = 300;
         this.width = 400;
      }
      
      public function set _desc(param1:TextArea) : void
      {
         var _loc2_:Object = this._90814320_desc;
         if(_loc2_ !== param1)
         {
            this._90814320_desc = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_desc",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      [Bindable(event="propertyChange")]
      public function get _desc() : TextArea
      {
         return this._90814320_desc;
      }
      
      private function close() : void
      {
         this.closeFunc.apply(null,[this]);
      }
      
      public function ___HistHeroDescWin_Button1_click(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function updateInfo(param1:Object, param2:Function = null) : void
      {
         this.closeFunc = param2;
         this._desc.text = param1 as String;
      }
   }
}

