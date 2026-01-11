// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.OffSale

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.net.SharedObject;
    import com.evony.Context;
    import view.ui.AlertWinEx;
    import mx.managers.PopUpManager;
    import flash.utils.setTimeout;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
    import view.ui.AddFundWin;
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

    public class OffSale extends Canvas implements IBindingClient 
    {

        public static var instance:OffSale = new (OffSale)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1271618531YesSubmitBtn:Button;
        private var _109757064stack:ViewStack;
        private var _708816317NoSubmitBtn:Button;
        private var _110843960type2:Canvas;
        private var _1290918176evtImg:Image;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":650,
                    "height":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "89";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"randeventTextbg",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"evtImg",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/icon/shop/xmas-popup_20191218_2.png"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"stack",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "19";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":640,
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"type2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"YesSubmitBtn",
                                                "events":{"click":"__YesSubmitBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Buy coins",
                                                        "styleName":"randEventGreen",
                                                        "x":50
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"NoSubmitBtn",
                                                "events":{"click":"__NoSubmitBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"randEventGrey",
                                                        "x":339
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___OffSale_Button3_click"},
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

        public function OffSale()
        {
            mx_internal::_document = this;
            this.width = 650;
            this.height = 500;
            this.styleName = "MyWindow";
        }

        public static function delayshow():void
        {
            var _local_1:SharedObject;
            var _local_2:*;
            if (Context.getInstance().serverYear >= 2021)
            {
                MainWin.instance.addMoneyPic.visible = false;
                return;
            };
            _local_1 = SharedObject.getLocal("offSale20191218", "/");
            if (_local_1.data.value == null)
            {
                _local_1.data.value = true;
            }
            else
            {
                _local_2 = new Date().day.toString();
                _local_1 = SharedObject.getLocal((_local_2 + "d3"), "/");
                if (_local_1.data.value == null)
                {
                    _local_1.data.value = true;
                }
                else
                {
                    return;
                };
                AlertWinEx.show('   Hello Evonians,we’re excited to share that after months of testing, Evony is coming to mobile! Come join us in the highly anticipated Evony: The King’s Return. <a href="event:here"><font color="#ff0000">CLICK HERE</font></a> m.evony.com!', null);
                return;
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            OffSale._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show():void
        {
            setTimeout(delayshow, 1000);
        }


        public function set evtImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1290918176evtImg;
            if (_local_2 !== _arg_1)
            {
                this._1290918176evtImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "evtImg", _local_2, _arg_1));
            };
        }

        public function ___OffSale_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        private function _OffSale_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("No Thanks");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                NoSubmitBtn.label = _arg_1;
            }, "NoSubmitBtn.label");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get stack():ViewStack
        {
            return (this._109757064stack);
        }

        private function btnHandle2():void
        {
            navigateToURL(new URLRequest("http://evonygame.com/?p=1071"), "_blank");
            close();
        }

        override public function initialize():void
        {
            var target:OffSale;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _OffSale_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_OffSaleWatcherSetupUtil");
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

        public function set NoSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._708816317NoSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._708816317NoSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "NoSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get evtImg():Image
        {
            return (this._1290918176evtImg);
        }

        private function _OffSale_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("No Thanks");
        }

        private function btnHandle():void
        {
            AddFundWin.gotoPurchasePage();
        }

        public function set stack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._109757064stack;
            if (_local_2 !== _arg_1)
            {
                this._109757064stack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }

        public function set type2(_arg_1:Canvas):void
        {
            var _local_2:Object = this._110843960type2;
            if (_local_2 !== _arg_1)
            {
                this._110843960type2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type2", _local_2, _arg_1));
            };
        }

        private function onComplete():void
        {
        }

        public function set YesSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1271618531YesSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1271618531YesSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "YesSubmitBtn", _local_2, _arg_1));
            };
        }

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get type2():Canvas
        {
            return (this._110843960type2);
        }


    }
}//package view

