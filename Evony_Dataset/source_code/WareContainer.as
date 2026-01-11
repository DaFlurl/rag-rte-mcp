// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.WareContainer

package view.module.shop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ItemBean;
    import mx.controls.Label;
    import mx.controls.Image;
    import com.evony.eum.ItemEum;
    import mx.controls.Button;
    import com.evony.util.EvonyImage;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import view.ui.DescribeTooltip;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.managers.PopUpManager;
    import mx.collections.ArrayCollection;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import mx.events.FlexEvent;
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

    public class WareContainer extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1268448930_itembean:ItemBean;
        private var _1012971055onSell:Boolean = false;
        private var _785720823specialWindow:Boolean = false;
        private var _1456289265coinSystemStr:String;
        private var _488962728wareName:Label;
        private var _398564268samllIconFile:Image;
        private var _2116180394itemEum:ItemEum;
        private var _1255721767normalSell:Boolean = false;
        private var _1098639679hotSell:Boolean = false;
        private var _1377735653butBtn:Button;
        private var _196065820sellStatus:Class;
        private var _1124152265wareNum:Label;
        private var _738344555iconFile:Image;
        public var _WareContainer_EvonyImage1:EvonyImage;
        public var _WareContainer_Label2:Label;
        public var _WareContainer_Label4:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":238,
                    "height":101,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "29";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":66,
                                "height":66,
                                "styleName":"treasureContainerBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"iconFile",
                                    "events":{
                                        "complete":"__iconFile_complete",
                                        "mouseOver":"__iconFile_mouseOver",
                                        "mouseOut":"__iconFile_mouseOut",
                                        "mouseMove":"__iconFile_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":63,
                                            "height":63
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"samllIconFile",
                                    "events":{
                                        "complete":"__samllIconFile_complete",
                                        "mouseOver":"__samllIconFile_mouseOver",
                                        "mouseOut":"__samllIconFile_mouseOut",
                                        "mouseMove":"__samllIconFile_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":63,
                                            "height":63
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"butBtn",
                        "events":{
                            "click":"__butBtn_click",
                            "mouseOut":"__butBtn_mouseOut",
                            "mouseOver":"__butBtn_mouseOver",
                            "mouseMove":"__butBtn_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.bottom = "5";
                            this.right = "18";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b95"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"wareName",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "1";
                            this.right = "5";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":23,
                                "styleName":"fontTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "29";
                            this.left = "76";
                            this.right = "5";
                            this.horizontalAlign = "left";
                            this.horizontalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareContainer_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"SpecialText",
                                            "width":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"wareNum",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"SpecialText"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "right";
                            this.right = "5";
                            this.top = "50";
                            this.horizontalAlign = "right";
                            this.left = "76";
                            this.horizontalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":20,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareContainer_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp510"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"_WareContainer_EvonyImage1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"fla/dynamic/ui234.swf@copper.png"});
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var buyWin:BuyWin = BuyWin.getInstance();
        private var goodToolTip:TreasureTooltip = TreasureTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function WareContainer()
        {
            mx_internal::_document = this;
            this.width = 238;
            this.height = 101;
            this.styleName = "textBackgroundShopTiles";
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___WareContainer_Canvas1_creationComplete);
            this.addEventListener("click", ___WareContainer_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WareContainer._watcherSetupUtil = _arg_1;
        }


        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(this.itemEum.name, this.itemEum.itemDesc, _arg_1);
        }

        public function ___WareContainer_Canvas1_click(_arg_1:MouseEvent):void
        {
            buyWare();
        }

        [Bindable(event="propertyChange")]
        public function get specialWindow():Boolean
        {
            return (this._785720823specialWindow);
        }

        public function __samllIconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function __samllIconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function set specialWindow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._785720823specialWindow;
            if (_local_2 !== _arg_1)
            {
                this._785720823specialWindow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "specialWindow", _local_2, _arg_1));
            };
        }

        private function getCoinSystem(_arg_1:int):String
        {
            var _local_2:String = new String();
            return (_arg_1 + Lang.msg("铜币"));
        }

        public function init():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get butBtn():Button
        {
            return (this._1377735653butBtn);
        }

        private function outHandler():void
        {
            PopUpManager.removePopUp(this.goodToolTip);
        }

        public function setItemVisible(_arg_1:String, _arg_2:ArrayCollection, _arg_3:int, _arg_4:String):void
        {
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            this.visible = false;
            this.includeInLayout = false;
            switch (_arg_1)
            {
                case "hotSell":
                    if (((specialWindow == true) && (hotSell == true)))
                    {
                        _local_5 = ((_arg_3 - 1) * 9);
                        while (_local_5 < (((_arg_3 * 9) < _arg_2.length) ? (_arg_3 * 9) : _arg_2.length))
                        {
                            if (((!(this.itemEum == null)) && (this.itemEum.id == _arg_2[_local_5])))
                            {
                                this.visible = true;
                                this.includeInLayout = true;
                                break;
                            };
                            _local_5++;
                        };
                    };
                    return;
                case "onSell":
                    if (((specialWindow == true) && (onSell == true)))
                    {
                        _local_6 = ((_arg_3 - 1) * 9);
                        while (_local_6 < (((_arg_3 * 9) < _arg_2.length) ? (_arg_3 * 9) : _arg_2.length))
                        {
                            if (this.itemEum.id == _arg_2[_local_6])
                            {
                                this.visible = true;
                                this.includeInLayout = true;
                                break;
                            };
                            _local_6++;
                        };
                    };
                    return;
                case "normalSell":
                    if ((((!(this.itemEum == null)) && (this.itemEum.itemType == _arg_4)) && (specialWindow == false)))
                    {
                        _local_7 = ((_arg_3 - 1) * 9);
                        while (_local_7 < (((_arg_3 * 9) < _arg_2.length) ? (_arg_3 * 9) : _arg_2.length))
                        {
                            if (this.itemEum.id == _arg_2[_local_7])
                            {
                                this.visible = true;
                                this.includeInLayout = true;
                                break;
                            };
                            _local_7++;
                        };
                    };
                    return;
            };
        }

        private function buyWare():void
        {
            BuyWin.show(this.itemEum);
        }

        public function set iconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        public function __butBtn_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        private function _WareContainer_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (itemEum.iconUrl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (sellStatus);
            }, function (_arg_1:Object):void
            {
                samllIconFile.source = _arg_1;
            }, "samllIconFile.source");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("购买");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                butBtn.label = _arg_1;
            }, "butBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                wareName.text = _arg_1;
            }, "wareName.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("当前数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareContainer_Label2.text = _arg_1;
            }, "_WareContainer_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this._itembean != null) ? this._itembean.count : "0");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                wareNum.text = _arg_1;
            }, "wareNum.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = int(itemEum.price);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareContainer_Label4.text = _arg_1;
            }, "_WareContainer_Label4.text");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(itemEum.price) > 0);
            }, function (_arg_1:Boolean):void
            {
                _WareContainer_Label4.visible = _arg_1;
            }, "_WareContainer_Label4.visible");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(itemEum.price) > 0);
            }, function (_arg_1:Boolean):void
            {
                _WareContainer_Label4.includeInLayout = _arg_1;
            }, "_WareContainer_Label4.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("铜币");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareContainer_EvonyImage1.toolTip = _arg_1;
            }, "_WareContainer_EvonyImage1.toolTip");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(itemEum.price) > 0);
            }, function (_arg_1:Boolean):void
            {
                _WareContainer_EvonyImage1.visible = _arg_1;
            }, "_WareContainer_EvonyImage1.visible");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (int(itemEum.price) > 0);
            }, function (_arg_1:Boolean):void
            {
                _WareContainer_EvonyImage1.includeInLayout = _arg_1;
            }, "_WareContainer_EvonyImage1.includeInLayout");
            result[11] = binding;
            return (result);
        }

        public function set butBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1377735653butBtn;
            if (_local_2 !== _arg_1)
            {
                this._1377735653butBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "butBtn", _local_2, _arg_1));
            };
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            this.goodToolTip.moveToMouse(_arg_1);
        }

        private function _WareContainer_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemEum.iconUrl;
            _local_1 = sellStatus;
            _local_1 = Lang.msg("购买");
            _local_1 = itemEum.name;
            _local_1 = (Lang.msg("当前数量") + ": ");
            _local_1 = ((this._itembean != null) ? this._itembean.count : "0");
            _local_1 = int(itemEum.price);
            _local_1 = (int(itemEum.price) > 0);
            _local_1 = (int(itemEum.price) > 0);
            _local_1 = Lang.msg("铜币");
            _local_1 = (int(itemEum.price) > 0);
            _local_1 = (int(itemEum.price) > 0);
        }

        [Bindable(event="propertyChange")]
        public function get hotSell():Boolean
        {
            return (this._1098639679hotSell);
        }

        public function __butBtn_click(_arg_1:MouseEvent):void
        {
            buyWare();
        }

        private function set _itembean(_arg_1:ItemBean):void
        {
            var _local_2:Object = this._1268448930_itembean;
            if (_local_2 !== _arg_1)
            {
                this._1268448930_itembean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itembean", _local_2, _arg_1));
            };
        }

        public function set wareName(_arg_1:Label):void
        {
            var _local_2:Object = this._488962728wareName;
            if (_local_2 !== _arg_1)
            {
                this._488962728wareName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wareName", _local_2, _arg_1));
            };
        }

        public function set itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._2116180394itemEum;
            if (_local_2 !== _arg_1)
            {
                this._2116180394itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemEum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get samllIconFile():Image
        {
            return (this._398564268samllIconFile);
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        public function set hotSell(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1098639679hotSell;
            if (_local_2 !== _arg_1)
            {
                this._1098639679hotSell = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hotSell", _local_2, _arg_1));
            };
        }

        public function set wareNum(_arg_1:Label):void
        {
            var _local_2:Object = this._1124152265wareNum;
            if (_local_2 !== _arg_1)
            {
                this._1124152265wareNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wareNum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        override public function initialize():void
        {
            var target:WareContainer;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WareContainer_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_WareContainerWatcherSetupUtil");
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
        private function get _itembean():ItemBean
        {
            return (this._1268448930_itembean);
        }

        public function __samllIconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set samllIconFile(_arg_1:Image):void
        {
            var _local_2:Object = this._398564268samllIconFile;
            if (_local_2 !== _arg_1)
            {
                this._398564268samllIconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "samllIconFile", _local_2, _arg_1));
            };
        }

        public function set onSell(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1012971055onSell;
            if (_local_2 !== _arg_1)
            {
                this._1012971055onSell = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "onSell", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get itemEum():ItemEum
        {
            return (this._2116180394itemEum);
        }

        public function set itemSellStatus(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "hotSell":
                    hotSell = true;
                    sellStatus = ShopWin.instance.hotSellPath;
                    return;
                case "onSell":
                    onSell = true;
                    sellStatus = ShopWin.instance.onSellPath;
                    return;
                case "normalSell":
                    normalSell = true;
                    sellStatus = null;
                    return;
                default:
                    normalSell = true;
                    sellStatus = null;
            };
        }

        [Bindable(event="propertyChange")]
        public function get wareName():Label
        {
            return (this._488962728wareName);
        }

        public function set normalSell(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1255721767normalSell;
            if (_local_2 !== _arg_1)
            {
                this._1255721767normalSell = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "normalSell", _local_2, _arg_1));
            };
        }

        public function ___WareContainer_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function set sellStatus(_arg_1:Class):void
        {
            var _local_2:Object = this._196065820sellStatus;
            if (_local_2 !== _arg_1)
            {
                this._196065820sellStatus = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sellStatus", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get wareNum():Label
        {
            return (this._1124152265wareNum);
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get onSell():Boolean
        {
            return (this._1012971055onSell);
        }

        public function __butBtn_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function __samllIconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        public function __butBtn_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.goodToolTip.itemEum = this.itemEum;
            this.goodToolTip.moveToMouse(_arg_1);
            PopUpManager.addPopUp(this.goodToolTip, this);
        }

        [Bindable(event="propertyChange")]
        public function get normalSell():Boolean
        {
            return (this._1255721767normalSell);
        }

        private function set coinSystemStr(_arg_1:String):void
        {
            var _local_2:Object = this._1456289265coinSystemStr;
            if (_local_2 !== _arg_1)
            {
                this._1456289265coinSystemStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "coinSystemStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get sellStatus():Class
        {
            return (this._196065820sellStatus);
        }

        public function setItemBean(_arg_1:ItemBean):void
        {
            this._itembean = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get coinSystemStr():String
        {
            return (this._1456289265coinSystemStr);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }


    }
}//package view.module.shop

