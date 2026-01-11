// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.MapCanvas

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.controls.TextInput;
    import mx.core.UIComponent;
    import mx.controls.CheckBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Text;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import autoevony.player.Map;
    import flash.events.MouseEvent;
    import flash.display.Bitmap;
    import mx.events.FlexEvent;
    import com.evony.common.beans.MapCastleBean;
    import autoevony.common.Utils;
    import flash.geom.Matrix;
    import com.evony.common.constants.FieldConstants;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    public class MapCanvas extends Canvas 
    {

        private var lastMouseX:Number = -1;
        private var lastMouseY:Number = -1;
        private var _109250890scale:TextInput;
        private var ui:UIComponent = null;
        private var centerFieldId:int = 0;
        private var IMGSIZE:int = 800;
        private var mapData:Array = null;
        private var pixelSize:Number = 32;
        private var _762041470xfield:TextInput;
        private var _619497271showValleys:CheckBox;
        private var _733412319yfield:TextInput;
        private var _1367706280canvas:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"canvas",
                        "stylesFactory":function ():void
                        {
                            this.borderColor = 2237479;
                            this.borderThickness = 1;
                            this.borderStyle = "solid";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "percentWidth":100,
                                "x":0,
                                "y":0
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.backgroundColor = 15591913;
                            this.right = "2";
                            this.top = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":100,
                                "width":75,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":"X:"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"xfield",
                                                "events":{"enter":"__xfield_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "tabIndex":1,
                                                        "width":49
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":"Y:"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"yfield",
                                                "events":{"enter":"__yfield_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "tabIndex":2,
                                                        "width":49
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"text":"Scale:"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"scale",
                                                "events":{"enter":"__scale_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "tabIndex":3,
                                                        "width":28
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"showValleys",
                                    "events":{"change":"__showValleys_change"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Valleys",
                                            "percentWidth":100,
                                            "selected":true
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var centerX:Number = ((IMGSIZE * 3) / 2);
        private var centerY:Number = ((IMGSIZE * 3) / 2);

        public function MapCanvas()
        {
            mx_internal::_document = this;
            this.percentHeight = 100;
            this.percentWidth = 100;
        }

        [Bindable(event="propertyChange")]
        public function get xfield():TextInput
        {
            return (this._762041470xfield);
        }

        public function set xfield(_arg_1:TextInput):void
        {
            var _local_2:Object = this._762041470xfield;
            if (_local_2 !== _arg_1)
            {
                this._762041470xfield = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xfield", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            super.initialize();
        }

        public function __showValleys_change(_arg_1:Event):void
        {
            this._jw1092();
        }

        private function init():void
        {
            var _local_1:int;
            var _local_2:UIComponent;
            var _local_3:int;
            var _local_4:int;
            var _local_5:UIComponent;
            if (this.ui != null)
            {
                return;
            };
            this.mapData = Map.getMapData();
            if (this.mapData == null)
            {
                return;
            };
            this.IMGSIZE = (this.mapData[0][0].width * this.mapData.length);
            this.ui = new UIComponent();
            this.ui.doubleClickEnabled = true;
            this.ui.addEventListener(MouseEvent.MOUSE_OVER, this._wo156);
            this.ui.addEventListener(MouseEvent.MOUSE_OUT, this._do379);
            this.ui.addEventListener(MouseEvent.MOUSE_DOWN, this._cl901);
            this.ui.addEventListener(MouseEvent.MOUSE_UP, this._ug647);
            this.ui.addEventListener(MouseEvent.MOUSE_WHEEL, this._nv1082);
            this.ui.addEventListener(MouseEvent.DOUBLE_CLICK, this._xf617);
            var _local_6:int;
            while (_local_6 < 3)
            {
                _local_1 = 0;
                while (_local_1 < 3)
                {
                    _local_2 = new UIComponent();
                    this.ui.addChild(_local_2);
                    _local_2.x = (_local_6 * this.IMGSIZE);
                    _local_2.y = (_local_1 * this.IMGSIZE);
                    _local_3 = 0;
                    while (_local_3 < this.mapData.length)
                    {
                        _local_4 = 0;
                        while (_local_4 < this.mapData[_local_3].length)
                        {
                            _local_5 = new UIComponent();
                            _local_5.addChild(new Bitmap(this.mapData[_local_3][_local_4]));
                            _local_2.addChild(_local_5);
                            _local_5.x = (_local_3 * this.mapData[_local_3][_local_4].width);
                            _local_5.y = (_local_4 * this.mapData[_local_3][_local_4].height);
                            _local_4++;
                        };
                        _local_3++;
                    };
                    _local_1++;
                };
                _local_6++;
            };
            this.canvas.addChild(this.ui);
            this._wd377();
            addEventListener(FlexEvent.SHOW, this._sb1115);
        }

        public function __yfield_enter(_arg_1:FlexEvent):void
        {
            this.update();
        }

        public function set scale(_arg_1:TextInput):void
        {
            var _local_2:Object = this._109250890scale;
            if (_local_2 !== _arg_1)
            {
                this._109250890scale = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scale", _local_2, _arg_1));
            };
        }

        private function _xf617(_arg_1:MouseEvent):void
        {
            var _local_2:int = Map.getFieldId((this.ui.mouseX % this.IMGSIZE), (this.ui.mouseY % this.IMGSIZE));
            Map.cacheMap(_local_2, true);
            var _local_3:MapCastleBean = Map.getDetail(_local_2);
            if (((!(_local_3 == null)) && (!(_local_3.userName == null))))
            {
                Map.reqPlayerInfo(_local_3.userName, true);
            };
        }

        public function set canvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1367706280canvas;
            if (_local_2 !== _arg_1)
            {
                this._1367706280canvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canvas", _local_2, _arg_1));
            };
        }

        private function _sb1115(_arg_1:Object=null):void
        {
            if (((this.canvas.width == 0) && (this.canvas.height == 0)))
            {
                Utils.callLater(50, this._sb1115);
            }
            else
            {
                this._wd377();
            };
        }

        [Bindable(event="propertyChange")]
        public function get showValleys():CheckBox
        {
            return (this._619497271showValleys);
        }

        [Bindable(event="propertyChange")]
        public function get yfield():TextInput
        {
            return (this._733412319yfield);
        }

        private function _wo156(_arg_1:MouseEvent):void
        {
            if (!this.ui.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
                this.ui.addEventListener(MouseEvent.MOUSE_MOVE, this._sy187);
            };
        }

        public function __xfield_enter(_arg_1:FlexEvent):void
        {
            this.update();
        }

        public function __scale_enter(_arg_1:FlexEvent):void
        {
            this.update();
        }

        public function _centerMapOn(_arg_1:int, _arg_2:Boolean=false):void
        {
            if ((((_arg_2) && (!(this.xfield.text == ""))) && (!(this.xfield.text == ""))))
            {
                if (this.centerFieldId != Map.getFieldId(Number(this.xfield.text), Number(this.yfield.text)))
                {
                    this.update();
                };
            }
            else
            {
                if (this.centerFieldId != _arg_1)
                {
                    this.centerFieldId = _arg_1;
                    this._kg699(Map.getX(_arg_1), Map.getY(_arg_1), this.pixelSize);
                };
            };
        }

        private function update():void
        {
            this.centerFieldId = Map.getFieldId(Number(this.xfield.text), Number(this.yfield.text));
            this._kg699(Number(this.xfield.text), Number(this.yfield.text), Number(this.scale.text));
        }

        [Bindable(event="propertyChange")]
        public function get scale():TextInput
        {
            return (this._109250890scale);
        }

        private function _sy187(_arg_1:MouseEvent):void
        {
            this.ui.toolTip = "";
            if (_arg_1.buttonDown)
            {
                if (((!(this.lastMouseX == -1)) || (!(this.lastMouseY == -1))))
                {
                    this._qn1060((this.ui.root.mouseX - this.lastMouseX), (this.ui.root.mouseY - this.lastMouseY));
                    this.lastMouseX = this.ui.root.mouseX;
                    this.lastMouseY = this.ui.root.mouseY;
                };
            }
            else
            {
                this.ui.toolTip = Map.getToolTip(this.centerFieldId, (_arg_1.currentTarget.mouseX % this.IMGSIZE), (this.ui.mouseY % this.IMGSIZE));
            };
        }

        public function set yfield(_arg_1:TextInput):void
        {
            var _local_2:Object = this._733412319yfield;
            if (_local_2 !== _arg_1)
            {
                this._733412319yfield = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yfield", _local_2, _arg_1));
            };
        }

        private function _nv1082(_arg_1:MouseEvent):void
        {
            var _local_2:Number = Math.pow(2, (0.25 * _arg_1.delta));
            var _local_3:Number = this.pixelSize;
            this.pixelSize = (this.pixelSize * _local_2);
            if (this.pixelSize < 1)
            {
                this.pixelSize = 1;
            };
            if (this.pixelSize > 32)
            {
                this.pixelSize = 32;
            };
            this.pixelSize = Math.round(this.pixelSize);
            if (_local_3 == this.pixelSize)
            {
                return;
            };
            _local_2 = (this.pixelSize / _local_3);
            var _local_4:Number = ((this.ui.mouseX % this.IMGSIZE) - (this.centerX % this.IMGSIZE));
            var _local_5:Number = ((this.ui.mouseY % this.IMGSIZE) - (this.centerY % this.IMGSIZE));
            _local_4 = (((_local_4 + (this.IMGSIZE / 2)) % this.IMGSIZE) - (this.IMGSIZE / 2));
            _local_5 = (((_local_5 + (this.IMGSIZE / 2)) % this.IMGSIZE) - (this.IMGSIZE / 2));
            _local_4 = (_local_4 / _local_2);
            _local_5 = (_local_5 / _local_2);
            this.centerX = ((this.ui.mouseX % this.IMGSIZE) - _local_4);
            this.centerY = ((this.ui.mouseY % this.IMGSIZE) - _local_5);
            this._wd377();
        }

        private function _qn1060(_arg_1:Number, _arg_2:Number):void
        {
            this.centerX = (this.centerX - (_arg_1 / this.pixelSize));
            this.centerY = (this.centerY - (_arg_2 / this.pixelSize));
            this._wd377();
        }

        private function _jw1092():void
        {
            Map.refreshBitmap(this.showValleys.selected);
        }

        private function _ug647(_arg_1:MouseEvent):void
        {
            if (((!(this.lastMouseX == -1)) || (!(this.lastMouseY == -1))))
            {
                this._qn1060((this.ui.root.mouseX - this.lastMouseX), (this.ui.root.mouseY - this.lastMouseY));
            };
            this.lastMouseX = -1;
            this.lastMouseY = -1;
        }

        private function _do379(_arg_1:MouseEvent):void
        {
            if (this.ui.hasEventListener(MouseEvent.MOUSE_MOVE))
            {
                this.ui.removeEventListener(MouseEvent.MOUSE_MOVE, this._sy187);
            };
        }

        private function _wd377():void
        {
            if (this.ui == null)
            {
                return;
            };
            this.centerX = ((this.centerX % this.IMGSIZE) + this.IMGSIZE);
            this.centerY = ((this.centerY % this.IMGSIZE) + this.IMGSIZE);
            if (this.pixelSize < 1)
            {
                this.pixelSize = 1;
            };
            if (this.pixelSize > 32)
            {
                this.pixelSize = 32;
            };
            this.scale.text = String((int((this.pixelSize * 100)) / 100));
            var _local_1:Matrix = new Matrix();
            _local_1.translate(-(this.centerX), -(this.centerY));
            _local_1.scale(this.pixelSize, this.pixelSize);
            _local_1.translate((this.canvas.width / 2), (this.canvas.height / 2));
            this.ui.transform.matrix = _local_1;
        }

        [Bindable(event="propertyChange")]
        public function get canvas():Canvas
        {
            return (this._1367706280canvas);
        }

        private function _cl901(_arg_1:MouseEvent):void
        {
            this.lastMouseX = this.ui.root.mouseX;
            this.lastMouseY = this.ui.root.mouseY;
            var _local_2:int = Map.getFieldId((this.ui.mouseX % this.IMGSIZE), (this.ui.mouseY % this.IMGSIZE));
            var _local_3:int = Map.getType(_local_2);
            if (((!(_local_3 == -1)) && (!(_local_3 == FieldConstants.TYPE_NPC))))
            {
                Map.cacheDetail(_local_2, true);
            };
        }

        public function set showValleys(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._619497271showValleys;
            if (_local_2 !== _arg_1)
            {
                this._619497271showValleys = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showValleys", _local_2, _arg_1));
            };
        }

        private function _kg699(_arg_1:Number, _arg_2:Number, _arg_3:Number):void
        {
            this.init();
            this.centerX = _arg_1;
            this.centerY = _arg_2;
            this.pixelSize = _arg_3;
            this.xfield.text = String(Map.getX(this.centerFieldId));
            this.yfield.text = String(Map.getY(this.centerFieldId));
            Map.getType(this.centerFieldId, (10 * 60));
            this._wd377();
        }


    }
}//package autoevony.gui

