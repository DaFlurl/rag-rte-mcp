// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.FillGift

package view.module.shop
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
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

    public class FillGift extends Canvas implements IBindingClient 
    {

        public static var instance:FillGift = new (FillGift)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _891535336submit:Button;
        private var _23497881giftNumber:TextInput;
        public var _FillGift_Label1:Label;
        public var _FillGift_Label2:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":135,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_FillGift_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"submit",
                        "events":{"click":"__submit_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b95"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "33";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":1,
                                            "percentWidth":100,
                                            "height":23,
                                            "x":1,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"textBackGroundFillColor",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FillGift_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"giftNumber",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":5,
                                            "y":27,
                                            "width":388,
                                            "styleName":"textInput",
                                            "height":24
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___FillGift_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
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

        public function FillGift()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 1;
            };
            this.width = 440;
            this.height = 135;
            this.addEventListener("creationComplete", ___FillGift_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FillGift._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
            };
            instance.reFresh();
        }


        public function __submit_click(_arg_1:MouseEvent):void
        {
            submitHandel();
        }

        private function submitHandel():void
        {
            PopUpManager.removePopUp(this);
        }

        public function init():void
        {
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___FillGift_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        override public function initialize():void
        {
            var target:FillGift;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FillGift_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_FillGiftWatcherSetupUtil");
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
        public function get giftNumber():TextInput
        {
            return (this._23497881giftNumber);
        }

        private function _FillGift_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兑换礼券");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FillGift_Label1.text = _arg_1;
            }, "_FillGift_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submit.label = _arg_1;
            }, "submit.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("礼券码");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FillGift_Label2.text = _arg_1;
            }, "_FillGift_Label2.text");
            result[2] = binding;
            return (result);
        }

        private function _FillGift_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("兑换礼券");
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("礼券码");
        }

        private function cancelHandel():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___FillGift_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set giftNumber(_arg_1:TextInput):void
        {
            var _local_2:Object = this._23497881giftNumber;
            if (_local_2 !== _arg_1)
            {
                this._23497881giftNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giftNumber", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get submit():Button
        {
            return (this._891535336submit);
        }

        private function reFresh():void
        {
            this.giftNumber.text = "";
        }

        public function set submit(_arg_1:Button):void
        {
            var _local_2:Object = this._891535336submit;
            if (_local_2 !== _arg_1)
            {
                this._891535336submit = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submit", _local_2, _arg_1));
            };
        }


    }
}//package view.module.shop

