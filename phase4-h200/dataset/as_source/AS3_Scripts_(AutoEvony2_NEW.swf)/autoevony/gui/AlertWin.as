// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.AlertWin

package autoevony.gui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Spacer;
    import mx.controls.Button;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.controls.Image;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.KeyboardEvent;
    import mx.events.PropertyChangeEvent;
    import flash.ui.Keyboard;
    import mx.events.FlexEvent;
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

    use namespace mx_internal;

    public class AlertWin extends Canvas implements IBindingClient 
    {

        private static const confirmIco:Class = AlertWin_confirmIco;
        private static const alertIco:Class = AlertWin_alertIco;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AlertWin_Spacer1:Spacer;
        private var _790628751alertYesBtn:Button;
        private var returnFunc:Function = null;
        private var _2025600524_baseWin:PopUpWinBase;
        private var _1904252127alertNoBtn:Button;
        private var returnArgs:Array = null;
        public var _AlertWin_Image1:Image;
        private var closeFunc:Function = null;
        private var _410103118alertMsgArea:TextArea;
        private var _1919213602showNoBtn:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":460,
                    "height":190,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "id":"_baseWin",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"System"});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                            this.bottom = "18";
                            this.right = "30";
                            this.horizontalAlign = "right";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"alertYesBtn",
                                    "events":{"click":"__alertYesBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"OK",
                                            "width":75,
                                            "styleName":"REwinOkayBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "id":"_AlertWin_Spacer1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"width":30});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"alertNoBtn",
                                    "events":{"click":"__alertNoBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Cancel",
                                            "width":75,
                                            "styleName":"REwinCancelBtn"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_AlertWin_Image1",
                        "stylesFactory":function ():void
                        {
                            this.left = "15";
                            this.top = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":50,
                                "height":50
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"alertMsgArea",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.left = "70";
                            this.right = "25";
                            this.top = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"",
                                "editable":false,
                                "height":85,
                                "styleName":"textBackground"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AlertWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"close",
                                "y":0,
                                "toolTip":"Click to close window without applying."
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

        public function AlertWin()
        {
            mx_internal::_document = this;
            this.width = 460;
            this.height = 190;
            this.addEventListener("creationComplete", this.___AlertWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AlertWin._watcherSetupUtil = _arg_1;
        }


        public function __alertNoBtn_click(_arg_1:MouseEvent):void
        {
            this.onClick(false);
        }

        [Bindable(event="propertyChange")]
        public function get _baseWin():PopUpWinBase
        {
            return (this._2025600524_baseWin);
        }

        override public function initialize():void
        {
            var target:AlertWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AlertWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_AlertWinWatcherSetupUtil");
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

        public function updateInfo(_arg_1:String, _arg_2:Function=null, _arg_3:String="Ok", _arg_4:String="Cancel", _arg_5:Array=null, _arg_6:String=null, _arg_7:Function=null):void
        {
            this.returnFunc = _arg_2;
            this.returnArgs = _arg_5;
            this.alertMsgArea.text = _arg_1;
            this.alertYesBtn.label = _arg_3;
            this.alertNoBtn.label = _arg_4;
            if (((!(_arg_4 == "Cancel")) && (!(_arg_4 == "No"))))
            {
                this.alertNoBtn.label = "Cancel";
            };
            this.showNoBtn = (!(_arg_2 == null));
            if (_arg_6 != null)
            {
                this._baseWin.windowTitle = _arg_6;
            };
            if (((_arg_6 == null) && (this.showNoBtn)))
            {
                this._baseWin.windowTitle = "Confirm?";
            };
            this.closeFunc = _arg_7;
        }

        private function init():void
        {
            this.addEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandle);
        }

        public function set _baseWin(_arg_1:PopUpWinBase):void
        {
            var _local_2:Object = this._2025600524_baseWin;
            if (_local_2 !== _arg_1)
            {
                this._2025600524_baseWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_baseWin", _local_2, _arg_1));
            };
        }

        private function keyDownHandle(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ENTER)
            {
                this.onClick(true);
            };
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                this.onClick(false);
            };
        }

        public function ___AlertWin_Button3_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function _AlertWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this.showNoBtn);
            }, function (_arg_1:Boolean):void
            {
                _AlertWin_Spacer1.visible = _arg_1;
            }, "_AlertWin_Spacer1.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showNoBtn);
            }, function (_arg_1:Boolean):void
            {
                _AlertWin_Spacer1.includeInLayout = _arg_1;
            }, "_AlertWin_Spacer1.includeInLayout");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showNoBtn);
            }, function (_arg_1:Boolean):void
            {
                alertNoBtn.visible = _arg_1;
            }, "alertNoBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.showNoBtn);
            }, function (_arg_1:Boolean):void
            {
                alertNoBtn.includeInLayout = _arg_1;
            }, "alertNoBtn.includeInLayout");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return ((this.showNoBtn) ? confirmIco : alertIco);
            }, function (_arg_1:Object):void
            {
                _AlertWin_Image1.source = _arg_1;
            }, "_AlertWin_Image1.source");
            result[4] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get alertMsgArea():TextArea
        {
            return (this._410103118alertMsgArea);
        }

        private function set showNoBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1919213602showNoBtn;
            if (_local_2 !== _arg_1)
            {
                this._1919213602showNoBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "showNoBtn", _local_2, _arg_1));
            };
        }

        public function set alertNoBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1904252127alertNoBtn;
            if (_local_2 !== _arg_1)
            {
                this._1904252127alertNoBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alertNoBtn", _local_2, _arg_1));
            };
        }

        public function ___AlertWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        private function get showNoBtn():Boolean
        {
            return (this._1919213602showNoBtn);
        }

        [Bindable(event="propertyChange")]
        public function get alertNoBtn():Button
        {
            return (this._1904252127alertNoBtn);
        }

        public function set alertMsgArea(_arg_1:TextArea):void
        {
            var _local_2:Object = this._410103118alertMsgArea;
            if (_local_2 !== _arg_1)
            {
                this._410103118alertMsgArea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alertMsgArea", _local_2, _arg_1));
            };
        }

        private function onClick(_arg_1:Boolean):void
        {
            if (((this.returnArgs == null) || (this.returnArgs.length == 0)))
            {
                this.returnArgs = new Array(_arg_1);
            }
            else
            {
                this.returnArgs.splice(0, 0, _arg_1);
            };
            if (this.returnFunc != null)
            {
                this.returnFunc.apply(null, this.returnArgs);
            };
            this.close();
        }

        [Bindable(event="propertyChange")]
        public function get alertYesBtn():Button
        {
            return (this._790628751alertYesBtn);
        }

        public function __alertYesBtn_click(_arg_1:MouseEvent):void
        {
            this.onClick(true);
        }

        private function close():void
        {
            this.removeEventListener(KeyboardEvent.KEY_DOWN, this.keyDownHandle);
            this.closeFunc.apply(null, [this]);
        }

        private function _AlertWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.showNoBtn;
            _local_1 = this.showNoBtn;
            _local_1 = this.showNoBtn;
            _local_1 = this.showNoBtn;
            _local_1 = ((this.showNoBtn) ? confirmIco : alertIco);
        }

        public function set alertYesBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._790628751alertYesBtn;
            if (_local_2 !== _arg_1)
            {
                this._790628751alertYesBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alertYesBtn", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui

