// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AlertWinEx

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import flash.display.DisplayObject;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import flash.events.KeyboardEvent;
    import flash.events.TextEvent;
    import flash.ui.Keyboard;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
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

    public class AlertWinEx extends Canvas implements IBindingClient 
    {

        private static var instance:AlertWinEx = new (AlertWinEx)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AlertWinEx_Label1:Label;
        private var _124953185hasNoBtn:Boolean = false;
        public var _AlertWinEx_Button1:Button;
        public var _AlertWinEx_Button2:Button;
        private var returnFunc:Function;
        public var _AlertWinEx_TextArea1:TextArea;
        private var _110371416title:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":520,
                    "height":300,
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
                        "type":Label,
                        "id":"_AlertWinEx_Label1",
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.left = "30";
                            this.right = "30";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":27,
                                "styleName":"winTitleFont"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":468,
                                "height":254,
                                "styleName":"msgboxbg",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.bottom = "50";
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AlertWinEx_Button1",
                                                "events":{"click":"___AlertWinEx_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"y125"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AlertWinEx_Button2",
                                                "events":{"click":"___AlertWinEx_Button2_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"y125"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"_AlertWinEx_TextArea1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.top = "80";
                                        this.color = 5312268;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":320,
                                            "editable":false,
                                            "height":80,
                                            "styleName":"shuangbian"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AlertWinEx_Button3_click"},
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
        private var _734053879yesTxt:String = Lang.msg("确定");
        private var _104978671noTxt:String = Lang.msg("取消");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AlertWinEx()
        {
            mx_internal::_document = this;
            this.width = 520;
            this.height = 300;
            this.addEventListener("creationComplete", ___AlertWinEx_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AlertWinEx._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            MinePopupManager.instance.removePopup();
        }

        public static function show(_arg_1:String, _arg_2:Function=null, _arg_3:String="Ok", _arg_4:String="Cancel", _arg_5:DisplayObject=null):void
        {
            if (_arg_5 == null)
            {
                _arg_5 = MainFrame.instance;
                if (_arg_5 == null)
                {
                    _arg_5 = (Application.application as DisplayObject);
                };
            };
            instance.returnFunc = _arg_2;
            instance.title = _arg_1;
            if (_arg_3 != "Ok")
            {
                instance.yesTxt = Lang.msg("确定");
            };
            if (_arg_4 != "Cancel")
            {
                instance.noTxt = Lang.msg("取消");
            };
            instance.hasNoBtn = ((!(_arg_2 == null)) && (!(_arg_4 == null)));
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, _arg_5, true);
                MinePopupManager.instance.centerPopUp();
            }
            else
            {
                PopUpManager.bringToFront(instance);
            };
            instance.setFocus();
        }


        public function ___AlertWinEx_Button1_click(_arg_1:MouseEvent):void
        {
            onClick(true);
        }

        public function ___AlertWinEx_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function set hasNoBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._124953185hasNoBtn;
            if (_local_2 !== _arg_1)
            {
                this._124953185hasNoBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasNoBtn", _local_2, _arg_1));
            };
        }

        private function _AlertWinEx_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("系统提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AlertWinEx_Label1.text = _arg_1;
            }, "_AlertWinEx_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = yesTxt;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AlertWinEx_Button1.label = _arg_1;
            }, "_AlertWinEx_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = noTxt;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AlertWinEx_Button2.label = _arg_1;
            }, "_AlertWinEx_Button2.label");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.hasNoBtn);
            }, function (_arg_1:Boolean):void
            {
                _AlertWinEx_Button2.visible = _arg_1;
            }, "_AlertWinEx_Button2.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.hasNoBtn);
            }, function (_arg_1:Boolean):void
            {
                _AlertWinEx_Button2.includeInLayout = _arg_1;
            }, "_AlertWinEx_Button2.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AlertWinEx_TextArea1.htmlText = _arg_1;
            }, "_AlertWinEx_TextArea1.htmlText");
            result[5] = binding;
            return (result);
        }

        public function ___AlertWinEx_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _AlertWinEx_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("系统提示");
            _local_1 = yesTxt;
            _local_1 = noTxt;
            _local_1 = this.hasNoBtn;
            _local_1 = this.hasNoBtn;
            _local_1 = title;
        }

        override public function initialize():void
        {
            var target:AlertWinEx;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AlertWinEx_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_AlertWinExWatcherSetupUtil");
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

        private function set yesTxt(_arg_1:String):void
        {
            var _local_2:Object = this._734053879yesTxt;
            if (_local_2 !== _arg_1)
            {
                this._734053879yesTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yesTxt", _local_2, _arg_1));
            };
        }

        private function set noTxt(_arg_1:String):void
        {
            var _local_2:Object = this._104978671noTxt;
            if (_local_2 !== _arg_1)
            {
                this._104978671noTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noTxt", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            PopUpManager.centerPopUp(this);
            this.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandle);
            this.addEventListener(TextEvent.LINK, linkHandler);
        }

        [Bindable(event="propertyChange")]
        private function get yesTxt():String
        {
            return (this._734053879yesTxt);
        }

        private function keyDownHandle(_arg_1:KeyboardEvent):void
        {
            if (_arg_1.keyCode == Keyboard.ENTER)
            {
                onClick(true);
            };
            if (_arg_1.keyCode == Keyboard.ESCAPE)
            {
                onClick(false);
            };
        }

        [Bindable(event="propertyChange")]
        private function get noTxt():String
        {
            return (this._104978671noTxt);
        }

        private function linkHandler(_arg_1:TextEvent):void
        {
            trace(_arg_1.text);
            navigateToURL(new URLRequest("http://m.evony.com"), "_blank");
        }

        [Bindable(event="propertyChange")]
        private function get hasNoBtn():Boolean
        {
            return (this._124953185hasNoBtn);
        }

        private function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        private function onClick(_arg_1:Boolean):void
        {
            close();
            if (this.returnFunc != null)
            {
                this.returnFunc.apply(this, [_arg_1]);
            };
        }

        [Bindable(event="propertyChange")]
        private function get title():String
        {
            return (this._110371416title);
        }

        public function ___AlertWinEx_Button2_click(_arg_1:MouseEvent):void
        {
            onClick(false);
        }


    }
}//package view.ui

