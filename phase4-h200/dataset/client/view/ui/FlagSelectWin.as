// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FlagSelectWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.events.FlagChangeEvent;
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

    public class FlagSelectWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _243499118ptyShow:Boolean = false;
        private var _1453045857espShow:Boolean = false;
        private var _606177100frcShow:Boolean = false;
        private var _1800289753eglShow:Boolean = false;
        private var _1985817472dtsShow:Boolean = false;
        private var _1945909715otherShow:Boolean = false;
        public var _FlagSelectWin_Button1:Button;
        public var _FlagSelectWin_Button2:Button;
        public var _FlagSelectWin_Button3:Button;
        public var _FlagSelectWin_Button4:Button;
        public var _FlagSelectWin_Button5:Button;
        public var _FlagSelectWin_Button6:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":38,
                    "height":110,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":0,
                                "percentHeight":100,
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button1",
                                    "events":{"click":"___FlagSelectWin_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"En",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"English"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button2",
                                    "events":{"click":"___FlagSelectWin_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Es",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"Espanol"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button3",
                                    "events":{"click":"___FlagSelectWin_Button3_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Fr",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"French"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button4",
                                    "events":{"click":"___FlagSelectWin_Button4_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Pt",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"Portuguese"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button5",
                                    "events":{"click":"___FlagSelectWin_Button5_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"De",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"Deutsch"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_FlagSelectWin_Button6",
                                    "events":{"click":"___FlagSelectWin_Button6_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingLeft = 9;
                                        this.cornerRadius = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"...",
                                            "height":22,
                                            "styleName":"chatPopupBtn",
                                            "toolTip":"Others"
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

        public function FlagSelectWin()
        {
            mx_internal::_document = this;
            this.styleName = "whiteBackGroundWithBode";
            this.width = 38;
            this.height = 110;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FlagSelectWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get dtsShow():Boolean
        {
            return (this._1985817472dtsShow);
        }

        private function _FlagSelectWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = eglShow;
            _local_1 = eglShow;
            _local_1 = espShow;
            _local_1 = espShow;
            _local_1 = frcShow;
            _local_1 = frcShow;
            _local_1 = ptyShow;
            _local_1 = ptyShow;
            _local_1 = dtsShow;
            _local_1 = dtsShow;
            _local_1 = otherShow;
            _local_1 = otherShow;
        }

        public function set dtsShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1985817472dtsShow;
            if (_local_2 !== _arg_1)
            {
                this._1985817472dtsShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dtsShow", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ptyShow():Boolean
        {
            return (this._243499118ptyShow);
        }

        override public function initialize():void
        {
            var target:FlagSelectWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FlagSelectWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_FlagSelectWinWatcherSetupUtil");
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

        public function ___FlagSelectWin_Button1_click(_arg_1:MouseEvent):void
        {
            selectLan("en");
        }

        [Bindable(event="propertyChange")]
        public function get espShow():Boolean
        {
            return (this._1453045857espShow);
        }

        public function ___FlagSelectWin_Button3_click(_arg_1:MouseEvent):void
        {
            selectLan("fr");
        }

        public function ___FlagSelectWin_Button5_click(_arg_1:MouseEvent):void
        {
            selectLan("de");
        }

        public function set ptyShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._243499118ptyShow;
            if (_local_2 !== _arg_1)
            {
                this._243499118ptyShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ptyShow", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get eglShow():Boolean
        {
            return (this._1800289753eglShow);
        }

        [Bindable(event="propertyChange")]
        public function get otherShow():Boolean
        {
            return (this._1945909715otherShow);
        }

        [Bindable(event="propertyChange")]
        public function get frcShow():Boolean
        {
            return (this._606177100frcShow);
        }

        public function set espShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1453045857espShow;
            if (_local_2 !== _arg_1)
            {
                this._1453045857espShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "espShow", _local_2, _arg_1));
            };
        }

        public function set eglShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1800289753eglShow;
            if (_local_2 !== _arg_1)
            {
                this._1800289753eglShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eglShow", _local_2, _arg_1));
            };
        }

        public function ___FlagSelectWin_Button4_click(_arg_1:MouseEvent):void
        {
            selectLan("pt");
        }

        public function ___FlagSelectWin_Button6_click(_arg_1:MouseEvent):void
        {
            selectLan("other");
        }

        private function _FlagSelectWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (eglShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button1.visible = _arg_1;
            }, "_FlagSelectWin_Button1.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (eglShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button1.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button1.includeInLayout");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (espShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button2.visible = _arg_1;
            }, "_FlagSelectWin_Button2.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (espShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button2.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button2.includeInLayout");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (frcShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button3.visible = _arg_1;
            }, "_FlagSelectWin_Button3.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (frcShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button3.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button3.includeInLayout");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (ptyShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button4.visible = _arg_1;
            }, "_FlagSelectWin_Button4.visible");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (ptyShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button4.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button4.includeInLayout");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (dtsShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button5.visible = _arg_1;
            }, "_FlagSelectWin_Button5.visible");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (dtsShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button5.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button5.includeInLayout");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (otherShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button6.visible = _arg_1;
            }, "_FlagSelectWin_Button6.visible");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (otherShow);
            }, function (_arg_1:Boolean):void
            {
                _FlagSelectWin_Button6.includeInLayout = _arg_1;
            }, "_FlagSelectWin_Button6.includeInLayout");
            result[11] = binding;
            return (result);
        }

        public function ___FlagSelectWin_Button2_click(_arg_1:MouseEvent):void
        {
            selectLan("es");
        }

        public function set frcShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._606177100frcShow;
            if (_local_2 !== _arg_1)
            {
                this._606177100frcShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "frcShow", _local_2, _arg_1));
            };
        }

        public function set otherShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1945909715otherShow;
            if (_local_2 !== _arg_1)
            {
                this._1945909715otherShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "otherShow", _local_2, _arg_1));
            };
        }

        private function selectLan(_arg_1:String):void
        {
            this.dispatchEvent(new FlagChangeEvent(_arg_1));
        }


    }
}//package view.ui

