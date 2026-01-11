// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.cj_inlineComponent1

package view.module.rank
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.containers.HBox;
    import com.evony.util.EvonyImage;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import flash.utils.ByteArray;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class cj_inlineComponent1 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1349156931curLev:String = "0";
        private var _616135290showBuffPic:Boolean = false;
        public var _cj_inlineComponent1_HBox1:HBox;
        private var _334905522toolTipStr:String;
        private var _678927291percent:Number;
        private var _1487025289percentBarW:int;
        public var _cj_inlineComponent1_EvonyImage1:EvonyImage;
        public var _cj_inlineComponent1_EvonyImage3:EvonyImage;
        public var _cj_inlineComponent1_EvonyImage4:EvonyImage;
        public var _cj_inlineComponent1_EvonyImage5:EvonyImage;
        public var _cj_inlineComponent1_EvonyImage6:EvonyImage;
        public var _cj_inlineComponent1_EvonyImage7:EvonyImage;
        public var _cj_inlineComponent1_Image1:Image;
        public var _cj_inlineComponent1_Image2:Image;
        private var _1753618744leftPicPath:String;
        public var _cj_inlineComponent1_Label1:Label;
        public var _cj_inlineComponent1_Label2:Label;
        public var _cj_inlineComponent1_Label3:Label;
        public var _cj_inlineComponent1_Label4:Label;
        public var _cj_inlineComponent1_Label5:Label;
        private var _88844982outerDocument:cj;
        private var _124664518hideCanvas:Canvas;
        private var _currStr:String = "images/dynamicImages/effort/effort";
        private var _1775068775noleftPicPath:String;
        private var _177689032smallPicPath:String;
        private var typeId:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"hideCanvas",
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.left = "10";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_cj_inlineComponent1_Image1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.left = "30";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "110";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@a_27_1.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_cj_inlineComponent1_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.left = "70";
                                        this.right = "50";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_cj_inlineComponent1_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "70";
                                        this.right = "50";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ParamgraphText1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage3",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.right = "10";
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_cj_inlineComponent1_Label3",
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
                                            "width":55,
                                            "styleName":"contentheader1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage4",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "110";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@a_29.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage5",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "114";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@a_17.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage6",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@a_21.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_cj_inlineComponent1_EvonyImage7",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "119";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@a_19.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_cj_inlineComponent1_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "110";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "width":295
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_cj_inlineComponent1_HBox1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "72";
                                        this.left = "140";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_cj_inlineComponent1_Label5",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_cj_inlineComponent1_Image2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":20,
                                                        "height":20
                                                    });
                                                }
                                            })]});
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var BuffxmlClass:Class = cj_inlineComponent1_BuffxmlClass;
        private var xml_ba:ByteArray = (new BuffxmlClass() as ByteArray);
        private var BuffxmlObj:XML = XML(xml_ba);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function cj_inlineComponent1()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            cj_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        private function set curLev(_arg_1:String):void
        {
            var _local_2:Object = this._1349156931curLev;
            if (_local_2 !== _arg_1)
            {
                this._1349156931curLev = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curLev", _local_2, _arg_1));
            };
        }

        private function set showBuffPic(_arg_1:Boolean):void
        {
            var _local_2:Object = this._616135290showBuffPic;
            if (_local_2 !== _arg_1)
            {
                this._616135290showBuffPic = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showBuffPic", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get percentBarW():int
        {
            return (this._1487025289percentBarW);
        }

        private function set percent(_arg_1:Number):void
        {
            var _local_2:Object = this._678927291percent;
            if (_local_2 !== _arg_1)
            {
                this._678927291percent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get leftPicPath():String
        {
            return (this._1753618744leftPicPath);
        }

        private function set percentBarW(_arg_1:int):void
        {
            var _local_2:Object = this._1487025289percentBarW;
            if (_local_2 !== _arg_1)
            {
                this._1487025289percentBarW = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percentBarW", _local_2, _arg_1));
            };
        }

        private function set toolTipStr(_arg_1:String):void
        {
            var _local_2:Object = this._334905522toolTipStr;
            if (_local_2 !== _arg_1)
            {
                this._334905522toolTipStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toolTipStr", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:cj_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _cj_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_cj_inlineComponent1WatcherSetupUtil");
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
        private function get smallPicPath():String
        {
            return (this._177689032smallPicPath);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():cj
        {
            return (this._88844982outerDocument);
        }

        private function set leftPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._1753618744leftPicPath;
            if (_local_2 !== _arg_1)
            {
                this._1753618744leftPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "leftPicPath", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get hideCanvas():Canvas
        {
            return (this._124664518hideCanvas);
        }

        [Bindable(event="propertyChange")]
        private function get percent():Number
        {
            return (this._678927291percent);
        }

        private function set smallPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._177689032smallPicPath;
            if (_local_2 !== _arg_1)
            {
                this._177689032smallPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "smallPicPath", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curLev():String
        {
            return (this._1349156931curLev);
        }

        private function setBuffImg(_arg_1:String):String
        {
            var _local_2:* = "";
            var _local_3:int = BuffxmlObj.children().length();
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                if (BuffxmlObj.child(_local_4).@id == _arg_1)
                {
                    _local_2 = BuffxmlObj.child(_local_4).@img;
                    toolTipStr = ((BuffxmlObj.child(_local_4).@desc + String((int(BuffxmlObj.child(_local_4).@per) * int(curLev)))) + "%");
                    break;
                };
                _local_4++;
            };
            return (_local_2);
        }

        private function set noleftPicPath(_arg_1:String):void
        {
            var _local_2:Object = this._1775068775noleftPicPath;
            if (_local_2 !== _arg_1)
            {
                this._1775068775noleftPicPath = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noleftPicPath", _local_2, _arg_1));
            };
        }

        private function parseDescription(_arg_1:String, _arg_2:String, _arg_3:int):String
        {
            var _local_5:int;
            var _local_6:int;
            var _local_4:* = "";
            if (_arg_1.search(":") != -1)
            {
                _local_5 = _arg_1.search(":");
                _local_6 = _arg_1.search("/");
                _local_4 = _arg_1.slice(0, _local_5);
                showBuffPic = true;
                typeId = _arg_1.slice((_local_5 + 1), _local_6);
                curLev = _arg_1.slice((_local_6 + 1));
                smallPicPath = ((setBuffImg(typeId) + curLev) + ".png");
            }
            else
            {
                showBuffPic = false;
                _local_4 = _arg_1;
            };
            leftPicPath = ((((_currStr + cj.instance.effortTypeId) + "_") + _local_4) + ".png");
            noleftPicPath = ((((_currStr + cj.instance.effortTypeId) + "_") + _local_4) + "_1.png");
            percent = (int(_arg_2.slice(0, _arg_2.search("/"))) / int(_arg_2.slice((_arg_2.search("/") + 1))));
            if (percent >= 1)
            {
                percent = 1;
            };
            percentBarW = Math.round((278 * percent));
            return (_local_4);
        }

        [Bindable(event="propertyChange")]
        private function get noleftPicPath():String
        {
            return (this._1775068775noleftPicPath);
        }

        [Bindable(event="propertyChange")]
        private function get toolTipStr():String
        {
            return (this._334905522toolTipStr);
        }

        public function set outerDocument(_arg_1:cj):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get showBuffPic():Boolean
        {
            return (this._616135290showBuffPic);
        }

        public function set hideCanvas(_arg_1:Canvas):void
        {
            var _local_2:Object = this._124664518hideCanvas;
            if (_local_2 !== _arg_1)
            {
                this._124664518hideCanvas = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideCanvas", _local_2, _arg_1));
            };
        }

        private function _cj_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return ((data.isFinish) ? "fla/dynamic/ui234.swf@bg_02.png" : "fla/dynamic/ui234.swf@bg_01.png");
            }, function (_arg_1:Object):void
            {
                _cj_inlineComponent1_EvonyImage1.source = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage1.source");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((data.isFinish) ? leftPicPath : noleftPicPath);
            }, function (_arg_1:Object):void
            {
                _cj_inlineComponent1_Image1.source = _arg_1;
            }, "_cj_inlineComponent1_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = parseDescription(data.description, data.name, data.questId);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label1.text = _arg_1;
            }, "_cj_inlineComponent1_Label1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 35 : 45);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label2.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_Label2.top");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.manual;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label2.text = _arg_1;
            }, "_cj_inlineComponent1_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((data.isFinish) ? "fla/dynamic/ui234.swf@a_09.png" : "fla/dynamic/ui234.swf@a_08.png");
            }, function (_arg_1:Object):void
            {
                _cj_inlineComponent1_EvonyImage3.source = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage3.source");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.award;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label3.text = _arg_1;
            }, "_cj_inlineComponent1_Label3.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 50 : 70);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_EvonyImage4.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_EvonyImage4.top");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((percentBarW > 0) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _cj_inlineComponent1_EvonyImage5.visible = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage5.visible");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 54 : 74);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_EvonyImage5.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_EvonyImage5.top");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((percentBarW > 0) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _cj_inlineComponent1_EvonyImage6.visible = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage6.visible");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 54 : 74);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_EvonyImage6.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_EvonyImage6.top");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (118 + percentBarW);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_EvonyImage6.setStyle("left", _arg_1);
            }, "_cj_inlineComponent1_EvonyImage6.left");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((percentBarW > 0) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _cj_inlineComponent1_EvonyImage7.visible = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage7.visible");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 54.5 : 74.5);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_EvonyImage7.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_EvonyImage7.top");
            result[14] = binding;
            binding = new Binding(this, function ():Number
            {
                return (percentBarW);
            }, function (_arg_1:Number):void
            {
                _cj_inlineComponent1_EvonyImage7.scaleX = _arg_1;
            }, "_cj_inlineComponent1_EvonyImage7.scaleX");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((showBuffPic) ? 52 : 72);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label4.setStyle("top", _arg_1);
            }, "_cj_inlineComponent1_Label4.top");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label4.text = _arg_1;
            }, "_cj_inlineComponent1_Label4.text");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (showBuffPic);
            }, function (_arg_1:Boolean):void
            {
                _cj_inlineComponent1_HBox1.visible = _arg_1;
            }, "_cj_inlineComponent1_HBox1.visible");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "Buff Obtained :  ";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Label5.text = _arg_1;
            }, "_cj_inlineComponent1_Label5.text");
            result[19] = binding;
            binding = new Binding(this, function ():Object
            {
                return (smallPicPath);
            }, function (_arg_1:Object):void
            {
                _cj_inlineComponent1_Image2.source = _arg_1;
            }, "_cj_inlineComponent1_Image2.source");
            result[20] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = toolTipStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _cj_inlineComponent1_Image2.toolTip = _arg_1;
            }, "_cj_inlineComponent1_Image2.toolTip");
            result[21] = binding;
            return (result);
        }

        private function _cj_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((data.isFinish) ? "fla/dynamic/ui234.swf@bg_02.png" : "fla/dynamic/ui234.swf@bg_01.png");
            _local_1 = ((data.isFinish) ? leftPicPath : noleftPicPath);
            _local_1 = parseDescription(data.description, data.name, data.questId);
            _local_1 = ((showBuffPic) ? 35 : 45);
            _local_1 = data.manual;
            _local_1 = ((data.isFinish) ? "fla/dynamic/ui234.swf@a_09.png" : "fla/dynamic/ui234.swf@a_08.png");
            _local_1 = data.award;
            _local_1 = ((showBuffPic) ? 50 : 70);
            _local_1 = ((percentBarW > 0) ? true : false);
            _local_1 = ((showBuffPic) ? 54 : 74);
            _local_1 = ((percentBarW > 0) ? true : false);
            _local_1 = ((showBuffPic) ? 54 : 74);
            _local_1 = (118 + percentBarW);
            _local_1 = ((percentBarW > 0) ? true : false);
            _local_1 = ((showBuffPic) ? 54.5 : 74.5);
            _local_1 = percentBarW;
            _local_1 = ((showBuffPic) ? 52 : 72);
            _local_1 = data.name;
            _local_1 = showBuffPic;
            _local_1 = "Buff Obtained :  ";
            _local_1 = smallPicPath;
            _local_1 = toolTipStr;
        }


    }
}//package view.module.rank

