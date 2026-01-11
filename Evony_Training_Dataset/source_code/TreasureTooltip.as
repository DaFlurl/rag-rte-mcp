// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.TreasureTooltip

package view.module.shop
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.ItemEum;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
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

    public class TreasureTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:TreasureTooltip = new (TreasureTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _179437675_itemEum:ItemEum;
        private var _1003243718textarea:Text;
        private var _119856678treasureName:Label;
        private var _1456289265coinSystemStr:String;
        private var _586798082treasureValue:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.right = "5";
                            this.top = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.right = "5";
                                        this.top = "5";
                                        this.bottom = "5";
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"treasureName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "styleName":"contentheader1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"treasureValue",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"PropertyValue1"
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"textarea",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "percentWidth":100
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TreasureTooltip()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.styleName = "tooltips";
            this.percentHeight = 100;
            this.percentWidth = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TreasureTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():TreasureTooltip
        {
            return (instance);
        }


        [Bindable(event="propertyChange")]
        public function get textarea():Text
        {
            return (this._1003243718textarea);
        }

        public function set textarea(_arg_1:Text):void
        {
            var _local_2:Object = this._1003243718textarea;
            if (_local_2 !== _arg_1)
            {
                this._1003243718textarea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textarea", _local_2, _arg_1));
            };
        }

        public function set treasureValue(_arg_1:Label):void
        {
            var _local_2:Object = this._586798082treasureValue;
            if (_local_2 !== _arg_1)
            {
                this._586798082treasureValue = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureValue", _local_2, _arg_1));
            };
        }

        private function _TreasureTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                treasureName.text = _arg_1;
            }, "treasureName.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = coinSystemStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                treasureValue.text = _arg_1;
            }, "treasureValue.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._itemEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                textarea.text = _arg_1;
            }, "textarea.text");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get treasureValue():Label
        {
            return (this._586798082treasureValue);
        }

        public function init():void
        {
            this.mouseChildren = false;
        }

        public function set itemEum(_arg_1:ItemEum):void
        {
            this._itemEum = _arg_1;
            if (_arg_1.price != 0)
            {
                coinSystemStr = this.getCoinSystem(_arg_1.price);
            }
            else
            {
                coinSystemStr = "";
            };
        }

        private function getCoinSystem(_arg_1:int):String
        {
            var _local_2:String = new String();
            return ((_arg_1 + " ") + Lang.msg("铜"));
        }

        [Bindable(event="propertyChange")]
        public function get treasureName():Label
        {
            return (this._119856678treasureName);
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

        private function _TreasureTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._itemEum.name;
            _local_1 = coinSystemStr;
            _local_1 = this._itemEum.desc;
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

        public function set treasureName(_arg_1:Label):void
        {
            var _local_2:Object = this._119856678treasureName;
            if (_local_2 !== _arg_1)
            {
                this._119856678treasureName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureName", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TreasureTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TreasureTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_TreasureTooltipWatcherSetupUtil");
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

        public function get itemEum():ItemEum
        {
            return (this._itemEum);
        }

        [Bindable(event="propertyChange")]
        private function get _itemEum():ItemEum
        {
            return (this._179437675_itemEum);
        }

        [Bindable(event="propertyChange")]
        private function get coinSystemStr():String
        {
            return (this._1456289265coinSystemStr);
        }


    }
}//package view.module.shop

