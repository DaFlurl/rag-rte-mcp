// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ItemUI

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import view.module.market.Wallet;
    import mx.controls.Text;
    import mx.controls.Image;
    import mx.containers.HBox;
    import com.evony.common.beans.ItemBean;
    import com.evony.eum.ItemEum;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.events.ItemSelectEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.display.Bitmap;
    import com.evony.util.InputTextFilter;
    import mx.events.FlexEvent;
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

    public class ItemUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var isTreasureDesctShowAll:Boolean = false;
        public var _ItemUI_Button1:Button;
        public var _ItemUI_Label1:Label;
        public var _ItemUI_Label2:Label;
        public var _ItemUI_Wallet1:Wallet;
        public var _ItemUI_Text1:Text;
        private var _738344555iconFile:Image;
        public var _ItemUI_HBox1:HBox;
        private var _1389349165treasureDec:String;
        private var _3019696bean:ItemBean;
        private var _1921954855descriptText:Text;
        private var _179437675_itemEum:ItemEum;
        private var _410956671container:Canvas;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":530,
                    "height":60,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"container",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.right = "0";
                            this.top = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
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
                                        this.verticalCenter = "0";
                                        this.left = "3";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "height":50
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ItemUI_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "0";
                                        this.left = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"contentheader2",
                                            "width":290
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"descriptText",
                                    "events":{
                                        "mouseOver":"__descriptText_mouseOver",
                                        "mouseOut":"__descriptText_mouseOut",
                                        "mouseMove":"__descriptText_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "60";
                                        this.right = "20";
                                        this.top = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseChildren":false,
                                            "styleName":"ParamgraphText2",
                                            "height":45,
                                            "width":450
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ItemUI_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "x":3,
                                            "styleName":"simpleStyle"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_ItemUI_HBox1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "0";
                                        this.right = "70";
                                        this.horizontalGap = 0;
                                        this.verticalAlign = "middle";
                                        this.left = "360";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ItemUI_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":20,
                                                        "styleName":"contentheader2",
                                                        "width":45
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Wallet,
                                                "id":"_ItemUI_Wallet1"
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_ItemUI_Button1",
                                    "events":{"click":"___ItemUI_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.top = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":65,
                                            "styleName":"b75",
                                            "height":22
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ItemUI()
        {
            mx_internal::_document = this;
            this.width = 530;
            this.height = 60;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___ItemUI_Canvas1_creationComplete);
            this.addEventListener("click", ___ItemUI_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ItemUI._watcherSetupUtil = _arg_1;
        }


        private function onTreasureDescTxtMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get container():Canvas
        {
            return (this._410956671container);
        }

        private function onItemSelectedOk(_arg_1:Boolean):void
        {
            trace((((className + ".onItemSelectedOk(") + _arg_1) + ")"));
            if (_arg_1)
            {
                this.dispatchEvent(new ItemSelectEvent(_itemEum));
            };
        }

        private function init():void
        {
            this.enabled = true;
        }

        public function set container(_arg_1:Canvas):void
        {
            var _local_2:Object = this._410956671container;
            if (_local_2 !== _arg_1)
            {
                this._410956671container = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "container", _local_2, _arg_1));
            };
        }

        private function _ItemUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = _itemEum.iconUrl;
            _local_1 = _itemEum.name;
            _local_1 = treasureDec;
            _local_1 = ((this.bean == null) ? 0 : this.bean.count);
            _local_1 = ((this._itemEum.price) ? true : false);
            _local_1 = (Lang.msg("物品价格") + ": ");
            _local_1 = this._itemEum.price;
            _local_1 = Lang.msg("使用物品");
        }

        public function __descriptText_mouseOver(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtRollOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():Image
        {
            return (this._738344555iconFile);
        }

        override public function initialize():void
        {
            var target:ItemUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ItemUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ItemUIWatcherSetupUtil");
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

        private function onTreasureDescTxtRollOver(_arg_1:MouseEvent):void
        {
            if (isTreasureDesctShowAll)
            {
                DescribeTooltip.show(this._itemEum.name, this._itemEum.desc, _arg_1);
            };
        }

        public function __descriptText_mouseMove(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtMove(_arg_1);
        }

        private function set treasureDec(_arg_1:String):void
        {
            var _local_2:Object = this._1389349165treasureDec;
            if (_local_2 !== _arg_1)
            {
                this._1389349165treasureDec = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureDec", _local_2, _arg_1));
            };
        }

        public function __descriptText_mouseOut(_arg_1:MouseEvent):void
        {
            onTreasureDescTxtRollOut();
        }

        [Bindable(event="propertyChange")]
        public function get bean():ItemBean
        {
            return (this._3019696bean);
        }

        public function get itemEum():ItemEum
        {
            return (this._itemEum);
        }

        public function ___ItemUI_Button1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function set descriptText(_arg_1:Text):void
        {
            var _local_2:Object = this._1921954855descriptText;
            if (_local_2 !== _arg_1)
            {
                this._1921954855descriptText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "descriptText", _local_2, _arg_1));
            };
        }

        private function _ItemUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (_itemEum.iconUrl);
            }, function (_arg_1:Object):void
            {
                iconFile.source = _arg_1;
            }, "iconFile.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = _itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemUI_Text1.text = _arg_1;
            }, "_ItemUI_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = treasureDec;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                descriptText.htmlText = _arg_1;
            }, "descriptText.htmlText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.bean == null) ? 0 : this.bean.count);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemUI_Label1.text = _arg_1;
            }, "_ItemUI_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this._itemEum.price) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _ItemUI_HBox1.visible = _arg_1;
            }, "_ItemUI_HBox1.visible");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("物品价格") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemUI_Label2.text = _arg_1;
            }, "_ItemUI_Label2.text");
            result[5] = binding;
            binding = new Binding(this, function ():int
            {
                return (this._itemEum.price);
            }, function (_arg_1:int):void
            {
                _ItemUI_Wallet1.medal = _arg_1;
            }, "_ItemUI_Wallet1.medal");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用物品");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ItemUI_Button1.label = _arg_1;
            }, "_ItemUI_Button1.label");
            result[7] = binding;
            return (result);
        }

        private function onTreasureDescTxtRollOut():void
        {
            DescribeTooltip.hide();
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

        public function __iconFile_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___ItemUI_Canvas1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function set itemEum(_arg_1:ItemEum):void
        {
            this._itemEum = _arg_1;
            if (this._itemEum == null)
            {
                return;
            };
            if (((this._itemEum.desc.length > 148) && (!(InputTextFilter.isChinese(this._itemEum.desc)))))
            {
                this.treasureDec = ((this._itemEum.desc.substr(0, 116) + "(...") + "<font color='#ff0000'> more</u></font>)");
                isTreasureDesctShowAll = true;
            }
            else
            {
                this.treasureDec = this._itemEum.desc;
                isTreasureDesctShowAll = false;
            };
            trace(this._itemEum.desc);
        }

        public function ___ItemUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function get uiHeight():int
        {
            return (this.height);
        }

        private function set _itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._179437675_itemEum;
            if (_local_2 !== _arg_1)
            {
                this._179437675_itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemEum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get treasureDec():String
        {
            return (this._1389349165treasureDec);
        }

        public function set bean(_arg_1:ItemBean):void
        {
            var _local_2:Object = this._3019696bean;
            if (_local_2 !== _arg_1)
            {
                this._3019696bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bean", _local_2, _arg_1));
            };
        }

        private function onClick():void
        {
            if (((!(bean == null)) && (bean.count > 0)))
            {
                AlertWin.show(Lang.msg("使用{0}", _itemEum.name), onItemSelectedOk, "Ok", "Cancel");
            }
            else
            {
                AlertWin.show(Lang.msg("买并使用{0}", _itemEum.name), onItemSelectedOk, "Ok", "Cancel");
            };
        }

        [Bindable(event="propertyChange")]
        private function get _itemEum():ItemEum
        {
            return (this._179437675_itemEum);
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        [Bindable(event="propertyChange")]
        public function get descriptText():Text
        {
            return (this._1921954855descriptText);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(_itemEum.name, _itemEum.itemDesc, _arg_1);
        }


    }
}//package view.ui

