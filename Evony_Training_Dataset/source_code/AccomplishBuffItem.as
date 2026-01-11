// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AccomplishBuffItem

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import view.module.rank.cj;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.EvonyImage;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.display.Bitmap;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.filters.*;
    import flash.system.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AccomplishBuffItem extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var maxLev:String;
        public var per:String;
        private var _1106144556levStr:String;
        private var _982634288tooltips:String;
        public var _AccomplishBuffItem_Image1:Image;
        public var _AccomplishBuffItem_Image2:Image;
        public var _AccomplishBuffItem_Image3:Image;
        public var _AccomplishBuffItem_Image4:Image;
        public var _AccomplishBuffItem_Image5:Image;
        private var _1335972532finishPointValue:String = "0";
        private var _1349164622curDes:String;
        private var _99330dec:String;
        private var _106845584point:String;
        private var curLevValue:String = "0";
        private var _1522535891buffType:String;
        private var _3433509path:String;
        public var _AccomplishBuffItem_Label1:Label;
        public var _AccomplishBuffItem_Label2:Label;
        public var _AccomplishBuffItem_Label3:Label;
        public var _AccomplishBuffItem_Label4:Label;
        public var _AccomplishBuffItem_Label5:Label;
        public var _AccomplishBuffItem_Label6:Label;
        public var _AccomplishBuffItem_Label7:Label;
        public var _AccomplishBuffItem_Label8:Label;
        private var _parent:cj;
        private var _1521784482buffname:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":140,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "1";
                            this.left = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@bg_03.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "85";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_27_1.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label1",
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.left = "40";
                            this.right = "50";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"contentheader1"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label2",
                        "stylesFactory":function ():void
                        {
                            this.top = "45";
                            this.left = "40";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":340,
                                "styleName":"ParamgraphText1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.right = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_09.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label3",
                        "stylesFactory":function ():void
                        {
                            this.top = "25";
                            this.right = "12";
                            this.fontSize = 20;
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":50,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.bottom = "15";
                            this.horizontalGap = 10;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AccomplishBuffItem_Image1",
                                    "events":{
                                        "complete":"___AccomplishBuffItem_Image1_complete",
                                        "click":"___AccomplishBuffItem_Image1_click"
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AccomplishBuffItem_Image2",
                                    "events":{
                                        "complete":"___AccomplishBuffItem_Image2_complete",
                                        "click":"___AccomplishBuffItem_Image2_click"
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AccomplishBuffItem_Image3",
                                    "events":{
                                        "complete":"___AccomplishBuffItem_Image3_complete",
                                        "click":"___AccomplishBuffItem_Image3_click"
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AccomplishBuffItem_Image4",
                                    "events":{
                                        "complete":"___AccomplishBuffItem_Image4_complete",
                                        "click":"___AccomplishBuffItem_Image4_click"
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_AccomplishBuffItem_Image5",
                                    "events":{
                                        "complete":"___AccomplishBuffItem_Image5_complete",
                                        "click":"___AccomplishBuffItem_Image5_click"
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "83";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_12.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "145";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_12.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "210";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_12.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "272";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_12.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "stylesFactory":function ():void
                        {
                            this.left = "339";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"source":"fla/dynamic/ui234.swf@a_12.png"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label4",
                        "stylesFactory":function ():void
                        {
                            this.left = "81";
                            this.bottom = "14";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label5",
                        "stylesFactory":function ():void
                        {
                            this.left = "142";
                            this.bottom = "14";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label6",
                        "stylesFactory":function ():void
                        {
                            this.left = "208";
                            this.bottom = "14";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label7",
                        "stylesFactory":function ():void
                        {
                            this.left = "269";
                            this.bottom = "14";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AccomplishBuffItem_Label8",
                        "stylesFactory":function ():void
                        {
                            this.left = "337";
                            this.bottom = "14";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":30,
                                "styleName":"contentheader1"
                            });
                        }
                    })]
                });
            }
        });
        private var _104387img:ArrayCollection = new ArrayCollection();
        private var _466092721pointArr:Array = [];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AccomplishBuffItem()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.height = 140;
            this.addEventListener("creationComplete", ___AccomplishBuffItem_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AccomplishBuffItem._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get dec():String
        {
            return (this._99330dec);
        }

        public function set dec(_arg_1:String):void
        {
            var _local_2:Object = this._99330dec;
            if (_local_2 !== _arg_1)
            {
                this._99330dec = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dec", _local_2, _arg_1));
            };
        }

        public function ___AccomplishBuffItem_Image1_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        private function init():void
        {
            setImgPath();
        }

        public function ___AccomplishBuffItem_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set point(_arg_1:String):void
        {
            var _local_2:Object = this._106845584point;
            if (_local_2 !== _arg_1)
            {
                this._106845584point = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "point", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get path():String
        {
            return (this._3433509path);
        }

        public function ___AccomplishBuffItem_Image2_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get buffType():String
        {
            return (this._1522535891buffType);
        }

        public function ___AccomplishBuffItem_Image2_click(_arg_1:MouseEvent):void
        {
            clickHandler(1);
        }

        public function ___AccomplishBuffItem_Image3_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        public function set path(_arg_1:String):void
        {
            var _local_2:Object = this._3433509path;
            if (_local_2 !== _arg_1)
            {
                this._3433509path = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "path", _local_2, _arg_1));
            };
        }

        public function set buffType(_arg_1:String):void
        {
            var _local_2:Object = this._1522535891buffType;
            if (_local_2 !== _arg_1)
            {
                this._1522535891buffType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffType", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buffname():String
        {
            return (this._1521784482buffname);
        }

        private function set curDes(_arg_1:String):void
        {
            var _local_2:Object = this._1349164622curDes;
            if (_local_2 !== _arg_1)
            {
                this._1349164622curDes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curDes", _local_2, _arg_1));
            };
        }

        private function set pointArr(_arg_1:Array):void
        {
            var _local_2:Object = this._466092721pointArr;
            if (_local_2 !== _arg_1)
            {
                this._466092721pointArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pointArr", _local_2, _arg_1));
            };
        }

        public function ___AccomplishBuffItem_Image4_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        private function _AccomplishBuffItem_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.buffname;
            _local_1 = this.curDes;
            _local_1 = this.finishPointValue;
            _local_1 = this.tooltips;
            _local_1 = this.img.getItemAt(0).path;
            _local_1 = this.tooltips;
            _local_1 = this.img.getItemAt(1).path;
            _local_1 = this.tooltips;
            _local_1 = this.img.getItemAt(2).path;
            _local_1 = this.tooltips;
            _local_1 = this.img.getItemAt(3).path;
            _local_1 = this.tooltips;
            _local_1 = this.img.getItemAt(4).path;
            _local_1 = pointArr[0];
            _local_1 = pointArr[1];
            _local_1 = pointArr[2];
            _local_1 = pointArr[3];
            _local_1 = pointArr[4];
        }

        private function levPoint():void
        {
            pointArr = this.point.split(":");
            var _local_1:int = int(curLevValue);
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < _local_1)
            {
                _local_2 = (_local_2 + int(this.pointArr[_local_3]));
                _local_3++;
            };
            this.finishPointValue = String(_local_2);
            this.curDes = ((this.dec + String((int(this.per) * _local_1))) + "%");
        }

        private function set finishPointValue(_arg_1:String):void
        {
            var _local_2:Object = this._1335972532finishPointValue;
            if (_local_2 !== _arg_1)
            {
                this._1335972532finishPointValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "finishPointValue", _local_2, _arg_1));
            };
        }

        public function ___AccomplishBuffItem_Image3_click(_arg_1:MouseEvent):void
        {
            clickHandler(2);
        }

        public function set curLev(_arg_1:String):void
        {
            this.curLevValue = _arg_1;
            setImgPath();
            levPoint();
        }

        public function ___AccomplishBuffItem_Image5_complete(_arg_1:Event):void
        {
            onLoadComplete(_arg_1);
        }

        private function set img(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._104387img;
            if (_local_2 !== _arg_1)
            {
                this._104387img = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "img", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AccomplishBuffItem;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AccomplishBuffItem_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_AccomplishBuffItemWatcherSetupUtil");
                var _local_2:* = watcherSetupUtilClass;
                (_local_2["init"](null));
            };
            _watcherSetupUtil.setup(this, function (_arg_1:String):*
            {
                return (target[_arg_1]);
            }, bindings, watchers);
            var i:uint;
            while (i < bindings.length)
            {
                Binding(bindings[i]).execute();
                i++;
            };
            mx_internal::_bindings = mx_internal::_bindings.concat(bindings);
            mx_internal::_watchers = mx_internal::_watchers.concat(watchers);
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get point():String
        {
            return (this._106845584point);
        }

        public function set tooltips(_arg_1:String):void
        {
            var _local_2:Object = this._982634288tooltips;
            if (_local_2 !== _arg_1)
            {
                this._982634288tooltips = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tooltips", _local_2, _arg_1));
            };
        }

        private function clickHandler(_arg_1:int):void
        {
            var _local_2:String;
            this._parent.callTimes = 1;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = (((":" + buffType) + "/") + "1");
                    this._parent.BuffLinkToCj(_local_2);
                    return;
                case 1:
                    _local_2 = (((":" + buffType) + "/") + "2");
                    this._parent.BuffLinkToCj(_local_2);
                    return;
                case 2:
                    _local_2 = (((":" + buffType) + "/") + "3");
                    this._parent.BuffLinkToCj(_local_2);
                    return;
                case 3:
                    _local_2 = (((":" + buffType) + "/") + "4");
                    this._parent.BuffLinkToCj(_local_2);
                    return;
                case 4:
                    _local_2 = (((":" + buffType) + "/") + "5");
                    this._parent.BuffLinkToCj(_local_2);
                    return;
            };
        }

        private function set levStr(_arg_1:String):void
        {
            var _local_2:Object = this._1106144556levStr;
            if (_local_2 !== _arg_1)
            {
                this._1106144556levStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levStr", _local_2, _arg_1));
            };
        }

        public function setParent(_arg_1:cj):void
        {
            this._parent = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get finishPointValue():String
        {
            return (this._1335972532finishPointValue);
        }

        private function _AccomplishBuffItem_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buffname;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label1.text = _arg_1;
            }, "_AccomplishBuffItem_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curDes;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label2.text = _arg_1;
            }, "_AccomplishBuffItem_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.finishPointValue;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label3.text = _arg_1;
            }, "_AccomplishBuffItem_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Image1.toolTip = _arg_1;
            }, "_AccomplishBuffItem_Image1.toolTip");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.img.getItemAt(0).path);
            }, function (_arg_1:Object):void
            {
                _AccomplishBuffItem_Image1.source = _arg_1;
            }, "_AccomplishBuffItem_Image1.source");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Image2.toolTip = _arg_1;
            }, "_AccomplishBuffItem_Image2.toolTip");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.img.getItemAt(1).path);
            }, function (_arg_1:Object):void
            {
                _AccomplishBuffItem_Image2.source = _arg_1;
            }, "_AccomplishBuffItem_Image2.source");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Image3.toolTip = _arg_1;
            }, "_AccomplishBuffItem_Image3.toolTip");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.img.getItemAt(2).path);
            }, function (_arg_1:Object):void
            {
                _AccomplishBuffItem_Image3.source = _arg_1;
            }, "_AccomplishBuffItem_Image3.source");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Image4.toolTip = _arg_1;
            }, "_AccomplishBuffItem_Image4.toolTip");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.img.getItemAt(3).path);
            }, function (_arg_1:Object):void
            {
                _AccomplishBuffItem_Image4.source = _arg_1;
            }, "_AccomplishBuffItem_Image4.source");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.tooltips;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Image5.toolTip = _arg_1;
            }, "_AccomplishBuffItem_Image5.toolTip");
            result[11] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.img.getItemAt(4).path);
            }, function (_arg_1:Object):void
            {
                _AccomplishBuffItem_Image5.source = _arg_1;
            }, "_AccomplishBuffItem_Image5.source");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pointArr[0];
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label4.text = _arg_1;
            }, "_AccomplishBuffItem_Label4.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pointArr[1];
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label5.text = _arg_1;
            }, "_AccomplishBuffItem_Label5.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pointArr[2];
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label6.text = _arg_1;
            }, "_AccomplishBuffItem_Label6.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pointArr[3];
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label7.text = _arg_1;
            }, "_AccomplishBuffItem_Label7.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = pointArr[4];
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccomplishBuffItem_Label8.text = _arg_1;
            }, "_AccomplishBuffItem_Label8.text");
            result[17] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get curDes():String
        {
            return (this._1349164622curDes);
        }

        public function set buffname(_arg_1:String):void
        {
            var _local_2:Object = this._1521784482buffname;
            if (_local_2 !== _arg_1)
            {
                this._1521784482buffname = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buffname", _local_2, _arg_1));
            };
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        private function setImgPath():void
        {
            var _local_3:Object;
            var _local_1:int = int(curLevValue);
            var _local_2:int;
            while (_local_2 < 5)
            {
                _local_3 = new Object();
                if (_local_2 < _local_1)
                {
                    _local_3.path = ((path + String((_local_2 + 1))) + ".png");
                }
                else
                {
                    _local_3.path = (path + "0.png");
                };
                img.addItemAt(_local_3, _local_2);
                _local_2++;
            };
        }

        public function ___AccomplishBuffItem_Image4_click(_arg_1:MouseEvent):void
        {
            clickHandler(3);
        }

        [Bindable(event="propertyChange")]
        public function get tooltips():String
        {
            return (this._982634288tooltips);
        }

        [Bindable(event="propertyChange")]
        private function get img():ArrayCollection
        {
            return (this._104387img);
        }

        [Bindable(event="propertyChange")]
        private function get pointArr():Array
        {
            return (this._466092721pointArr);
        }

        [Bindable(event="propertyChange")]
        private function get levStr():String
        {
            return (this._1106144556levStr);
        }

        public function ___AccomplishBuffItem_Image1_click(_arg_1:MouseEvent):void
        {
            clickHandler(0);
        }

        public function ___AccomplishBuffItem_Image5_click(_arg_1:MouseEvent):void
        {
            clickHandler(4);
        }


    }
}//package view.ui

