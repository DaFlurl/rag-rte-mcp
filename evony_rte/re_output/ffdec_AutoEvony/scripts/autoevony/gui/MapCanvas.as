package autoevony.gui
{
   import autoevony.common.Utils;
   import autoevony.player.Map;
   import com.evony.common.beans.MapCastleBean;
   import com.evony.common.constants.FieldConstants;
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
   import mx.containers.HBox;
   import mx.containers.VBox;
   import mx.controls.CheckBox;
   import mx.controls.Text;
   import mx.controls.TextInput;
   import mx.core.UIComponent;
   import mx.core.UIComponentDescriptor;
   import mx.core.mx_internal;
   import mx.events.FlexEvent;
   import mx.events.PropertyChangeEvent;
   import mx.styles.*;
   
   public class MapCanvas extends Canvas
   {
      
      private var lastMouseX:Number = -1;
      
      private var lastMouseY:Number = -1;
      
      private var _109250890scale:TextInput;
      
      private var ui:UIComponent = null;
      
      private var centerFieldId:int = 0;
      
      private var centerX:Number;
      
      private var IMGSIZE:int = 800;
      
      private var mapData:Array = null;
      
      private var pixelSize:Number = 32;
      
      private var centerY:Number = this.IMGSIZE * 3 / 2;
      
      private var _762041470xfield:TextInput;
      
      private var _619497271showValleys:CheckBox;
      
      private var _733412319yfield:TextInput;
      
      private var _1367706280canvas:Canvas;
      
      private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
         "type":Canvas,
         "propertiesFactory":function():Object
         {
            return {"childDescriptors":[new UIComponentDescriptor({
               "type":Canvas,
               "id":"canvas",
               "stylesFactory":function():void
               {
                  this.borderColor = 2237479;
                  this.borderThickness = 1;
                  this.borderStyle = "solid";
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "percentHeight":100,
                     "percentWidth":100,
                     "x":0,
                     "y":0
                  };
               }
            }),new UIComponentDescriptor({
               "type":VBox,
               "stylesFactory":function():void
               {
                  this.backgroundColor = 15591913;
                  this.right = "2";
                  this.top = "2";
               },
               "propertiesFactory":function():Object
               {
                  return {
                     "height":100,
                     "width":75,
                     "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":20,
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Text,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"text":"X:"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"xfield",
                                 "events":{"enter":"__xfield_enter"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "restrict":"0-9",
                                       "tabIndex":1,
                                       "width":49
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":20,
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Text,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"text":"Y:"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"yfield",
                                 "events":{"enter":"__yfield_enter"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "restrict":"0-9",
                                       "tabIndex":2,
                                       "width":49
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":HBox,
                        "propertiesFactory":function():Object
                        {
                           return {
                              "height":20,
                              "percentWidth":100,
                              "childDescriptors":[new UIComponentDescriptor({
                                 "type":Text,
                                 "propertiesFactory":function():Object
                                 {
                                    return {"text":"Scale:"};
                                 }
                              }),new UIComponentDescriptor({
                                 "type":TextInput,
                                 "id":"scale",
                                 "events":{"enter":"__scale_enter"},
                                 "propertiesFactory":function():Object
                                 {
                                    return {
                                       "restrict":"0-9",
                                       "tabIndex":3,
                                       "width":28
                                    };
                                 }
                              })]
                           };
                        }
                     }),new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"showValleys",
                        "events":{"change":"__showValleys_change"},
                        "propertiesFactory":function():Object
                        {
                           return {
                              "label":"Valleys",
                              "percentWidth":100,
                              "selected":true
                           };
                        }
                     })]
                  };
               }
            })]};
         }
      });
      
      public function MapCanvas()
      {
         this.centerX = this.IMGSIZE * 3 / 2;
         super();
         mx_internal::_document = this;
         this.percentHeight = 100;
         this.percentWidth = 100;
      }
      
      [Bindable(event="propertyChange")]
      public function get xfield() : TextInput
      {
         return this._762041470xfield;
      }
      
      public function set xfield(param1:TextInput) : void
      {
         var _loc2_:Object = this._762041470xfield;
         if(_loc2_ !== param1)
         {
            this._762041470xfield = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"xfield",_loc2_,param1));
         }
      }
      
      override public function initialize() : void
      {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
      }
      
      public function __showValleys_change(param1:Event) : void
      {
         this._jw1092();
      }
      
      private function init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:UIComponent = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:UIComponent = null;
         if(this.ui != null)
         {
            return;
         }
         this.mapData = Map.getMapData();
         if(this.mapData == null)
         {
            return;
         }
         this.IMGSIZE = this.mapData[0][0].width * this.mapData.length;
         this.ui = new UIComponent();
         this.ui.doubleClickEnabled = true;
         this.ui.addEventListener(MouseEvent.MOUSE_OVER,this._wo156);
         this.ui.addEventListener(MouseEvent.MOUSE_OUT,this._do379);
         this.ui.addEventListener(MouseEvent.MOUSE_DOWN,this._cl901);
         this.ui.addEventListener(MouseEvent.MOUSE_UP,this._ug647);
         this.ui.addEventListener(MouseEvent.MOUSE_WHEEL,this._nv1082);
         this.ui.addEventListener(MouseEvent.DOUBLE_CLICK,this._xf617);
         var _loc6_:int = 0;
         while(_loc6_ < 3)
         {
            _loc1_ = 0;
            while(_loc1_ < 3)
            {
               _loc2_ = new UIComponent();
               this.ui.addChild(_loc2_);
               _loc2_.x = _loc6_ * this.IMGSIZE;
               _loc2_.y = _loc1_ * this.IMGSIZE;
               _loc3_ = 0;
               while(_loc3_ < this.mapData.length)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this.mapData[_loc3_].length)
                  {
                     _loc5_ = new UIComponent();
                     _loc5_.addChild(new Bitmap(this.mapData[_loc3_][_loc4_]));
                     _loc2_.addChild(_loc5_);
                     _loc5_.x = _loc3_ * this.mapData[_loc3_][_loc4_].width;
                     _loc5_.y = _loc4_ * this.mapData[_loc3_][_loc4_].height;
                     _loc4_++;
                  }
                  _loc3_++;
               }
               _loc1_++;
            }
            _loc6_++;
         }
         this.canvas.addChild(this.ui);
         this._wd377();
         addEventListener(FlexEvent.SHOW,this._sb1115);
      }
      
      public function __yfield_enter(param1:FlexEvent) : void
      {
         this.update();
      }
      
      public function set scale(param1:TextInput) : void
      {
         var _loc2_:Object = this._109250890scale;
         if(_loc2_ !== param1)
         {
            this._109250890scale = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"scale",_loc2_,param1));
         }
      }
      
      private function _xf617(param1:MouseEvent) : void
      {
         var _loc2_:int = Map.getFieldId(this.ui.mouseX % this.IMGSIZE,this.ui.mouseY % this.IMGSIZE);
         Map.cacheMap(_loc2_,true);
         var _loc3_:MapCastleBean = Map.getDetail(_loc2_);
         if(_loc3_ != null && _loc3_.userName != null)
         {
            Map.reqPlayerInfo(_loc3_.userName,true);
         }
      }
      
      public function set canvas(param1:Canvas) : void
      {
         var _loc2_:Object = this._1367706280canvas;
         if(_loc2_ !== param1)
         {
            this._1367706280canvas = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"canvas",_loc2_,param1));
         }
      }
      
      private function _sb1115(param1:Object = null) : void
      {
         if(this.canvas.width == 0 && this.canvas.height == 0)
         {
            Utils.callLater(50,this._sb1115);
         }
         else
         {
            this._wd377();
         }
      }
      
      [Bindable(event="propertyChange")]
      public function get showValleys() : CheckBox
      {
         return this._619497271showValleys;
      }
      
      [Bindable(event="propertyChange")]
      public function get yfield() : TextInput
      {
         return this._733412319yfield;
      }
      
      private function _wo156(param1:MouseEvent) : void
      {
         if(!this.ui.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            this.ui.addEventListener(MouseEvent.MOUSE_MOVE,this._sy187);
         }
      }
      
      public function __xfield_enter(param1:FlexEvent) : void
      {
         this.update();
      }
      
      public function __scale_enter(param1:FlexEvent) : void
      {
         this.update();
      }
      
      public function _centerMapOn(param1:int, param2:Boolean = false) : void
      {
         if(param2 && this.xfield.text != "" && this.xfield.text != "")
         {
            if(this.centerFieldId != Map.getFieldId(Number(this.xfield.text),Number(this.yfield.text)))
            {
               this.update();
            }
         }
         else if(this.centerFieldId != param1)
         {
            this.centerFieldId = param1;
            this._kg699(Map.getX(param1),Map.getY(param1),this.pixelSize);
         }
      }
      
      private function update() : void
      {
         this.centerFieldId = Map.getFieldId(Number(this.xfield.text),Number(this.yfield.text));
         this._kg699(Number(this.xfield.text),Number(this.yfield.text),Number(this.scale.text));
      }
      
      [Bindable(event="propertyChange")]
      public function get scale() : TextInput
      {
         return this._109250890scale;
      }
      
      private function _sy187(param1:MouseEvent) : void
      {
         this.ui.toolTip = "";
         if(param1.buttonDown)
         {
            if(this.lastMouseX != -1 || this.lastMouseY != -1)
            {
               this._qn1060(this.ui.root.mouseX - this.lastMouseX,this.ui.root.mouseY - this.lastMouseY);
               this.lastMouseX = this.ui.root.mouseX;
               this.lastMouseY = this.ui.root.mouseY;
            }
         }
         else
         {
            this.ui.toolTip = Map.getToolTip(this.centerFieldId,param1.currentTarget.mouseX % this.IMGSIZE,this.ui.mouseY % this.IMGSIZE);
         }
      }
      
      public function set yfield(param1:TextInput) : void
      {
         var _loc2_:Object = this._733412319yfield;
         if(_loc2_ !== param1)
         {
            this._733412319yfield = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"yfield",_loc2_,param1));
         }
      }
      
      private function _nv1082(param1:MouseEvent) : void
      {
         var _loc2_:Number = Math.pow(2,0.25 * param1.delta);
         var _loc3_:Number = this.pixelSize;
         this.pixelSize *= _loc2_;
         if(this.pixelSize < 1)
         {
            this.pixelSize = 1;
         }
         if(this.pixelSize > 32)
         {
            this.pixelSize = 32;
         }
         this.pixelSize = Math.round(this.pixelSize);
         if(_loc3_ == this.pixelSize)
         {
            return;
         }
         _loc2_ = this.pixelSize / _loc3_;
         var _loc4_:Number = this.ui.mouseX % this.IMGSIZE - this.centerX % this.IMGSIZE;
         var _loc5_:Number = this.ui.mouseY % this.IMGSIZE - this.centerY % this.IMGSIZE;
         _loc4_ = (_loc4_ + this.IMGSIZE / 2) % this.IMGSIZE - this.IMGSIZE / 2;
         _loc5_ = (_loc5_ + this.IMGSIZE / 2) % this.IMGSIZE - this.IMGSIZE / 2;
         _loc4_ /= _loc2_;
         _loc5_ /= _loc2_;
         this.centerX = this.ui.mouseX % this.IMGSIZE - _loc4_;
         this.centerY = this.ui.mouseY % this.IMGSIZE - _loc5_;
         this._wd377();
      }
      
      private function _qn1060(param1:Number, param2:Number) : void
      {
         this.centerX -= param1 / this.pixelSize;
         this.centerY -= param2 / this.pixelSize;
         this._wd377();
      }
      
      private function _jw1092() : void
      {
         Map.refreshBitmap(this.showValleys.selected);
      }
      
      private function _ug647(param1:MouseEvent) : void
      {
         if(this.lastMouseX != -1 || this.lastMouseY != -1)
         {
            this._qn1060(this.ui.root.mouseX - this.lastMouseX,this.ui.root.mouseY - this.lastMouseY);
         }
         this.lastMouseX = -1;
         this.lastMouseY = -1;
      }
      
      private function _do379(param1:MouseEvent) : void
      {
         if(this.ui.hasEventListener(MouseEvent.MOUSE_MOVE))
         {
            this.ui.removeEventListener(MouseEvent.MOUSE_MOVE,this._sy187);
         }
      }
      
      private function _wd377() : void
      {
         if(this.ui == null)
         {
            return;
         }
         this.centerX = this.centerX % this.IMGSIZE + this.IMGSIZE;
         this.centerY = this.centerY % this.IMGSIZE + this.IMGSIZE;
         if(this.pixelSize < 1)
         {
            this.pixelSize = 1;
         }
         if(this.pixelSize > 32)
         {
            this.pixelSize = 32;
         }
         this.scale.text = String(int(this.pixelSize * 100) / 100);
         var _loc1_:Matrix = new Matrix();
         _loc1_.translate(-this.centerX,-this.centerY);
         _loc1_.scale(this.pixelSize,this.pixelSize);
         _loc1_.translate(this.canvas.width / 2,this.canvas.height / 2);
         this.ui.transform.matrix = _loc1_;
      }
      
      [Bindable(event="propertyChange")]
      public function get canvas() : Canvas
      {
         return this._1367706280canvas;
      }
      
      private function _cl901(param1:MouseEvent) : void
      {
         this.lastMouseX = this.ui.root.mouseX;
         this.lastMouseY = this.ui.root.mouseY;
         var _loc2_:int = Map.getFieldId(this.ui.mouseX % this.IMGSIZE,this.ui.mouseY % this.IMGSIZE);
         var _loc3_:int = Map.getType(_loc2_);
         if(_loc3_ != -1 && _loc3_ != FieldConstants.TYPE_NPC)
         {
            Map.cacheDetail(_loc2_,true);
         }
      }
      
      public function set showValleys(param1:CheckBox) : void
      {
         var _loc2_:Object = this._619497271showValleys;
         if(_loc2_ !== param1)
         {
            this._619497271showValleys = param1;
            this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"showValleys",_loc2_,param1));
         }
      }
      
      private function _kg699(param1:Number, param2:Number, param3:Number) : void
      {
         this.init();
         this.centerX = param1;
         this.centerY = param2;
         this.pixelSize = param3;
         this.xfield.text = String(Map.getX(this.centerFieldId));
         this.yfield.text = String(Map.getY(this.centerFieldId));
         Map.getType(this.centerFieldId,10 * 60);
         this._wd377();
      }
   }
}

