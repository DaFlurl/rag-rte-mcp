// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.ApplySecurityCode

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.controls.Text;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import com.evony.Lang;
    import flash.events.Event;
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

    public class ApplySecurityCode extends Canvas implements IBindingClient 
    {

        public static var instance:ApplySecurityCode = new (ApplySecurityCode)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1039690024notice:Label;
        private var _2020316904flagSubmitBtn:Button;
        private var _3145580flag:int;
        public var _ApplySecurityCode_Button2:Button;
        private var _3433489pass:TextInput;
        private var _2095520559playerInfo:PlayerInfoBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":500,
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
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "text":"Security Code",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "60";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":80,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"buildingDescNewBox",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":400,
                                                        "htmlText":"If you forget your Security Code, you may cancel it.  72 hours after cancelling your Security Code, you may reset it to a new one.  During this time period, no protected actions may be initiated.",
                                                        "styleName":"ParamgraphText3",
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "150";
                            this.left = "40";
                            this.right = "40";
                            this.bottom = "90";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.top = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Enter Security Code",
                                                        "width":170,
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"pass",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "displayAsPassword":true,
                                                        "styleName":"textInput",
                                                        "height":22,
                                                        "maxChars":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                        this.textAlign = "center";
                                        this.bottom = "5";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"",
                                            "percentWidth":90,
                                            "styleName":"focusColor"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"flagSubmitBtn",
                        "events":{"click":"__flagSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.left = "70";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Remove Security Code",
                                "styleName":"Blue125",
                                "width":220,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_ApplySecurityCode_Button2",
                        "events":{"click":"___ApplySecurityCode_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.right = "70";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"Blue125",
                                "width":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ApplySecurityCode_Button3_click"},
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

        public function ApplySecurityCode()
        {
            mx_internal::_document = this;
            this.width = 500;
            this.height = 300;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ApplySecurityCode._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:int):void
        {
            if (Context.getInstance().bCancelSecurityCode)
            {
                CancelSecurityCode.show(0);
            }
            else
            {
                instance.flag = _arg_1;
                instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
                if (!instance.isPopUp)
                {
                    UIUtil.setPopopHelpWindowStye(instance);
                    MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                    MinePopupManager.instance.centerPopUp();
                };
                instance.reFresh();
            };
        }


        private function onResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().bLoginSecurityCode = true;
                if (flag == 0)
                {
                    SetSecurity.show();
                }
                else
                {
                    UnlockSecurityCode.show(flag);
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___ApplySecurityCode_Button2_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        public function ___ApplySecurityCode_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            removeHandle();
        }

        private function set flag(_arg_1:int):void
        {
            var _local_2:Object = this._3145580flag;
            if (_local_2 !== _arg_1)
            {
                this._3145580flag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flag", _local_2, _arg_1));
            };
        }

        private function removeHandle():void
        {
            AlertWin.show("It will have a 72 hours cool down, do you want to continue?", onClick, "Ok", "Cancel", null);
        }

        [Bindable(event="propertyChange")]
        private function get flag():int
        {
            return (this._3145580flag);
        }

        override public function initialize():void
        {
            var target:ApplySecurityCode;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ApplySecurityCode_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_ApplySecurityCodeWatcherSetupUtil");
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
        public function get notice():Label
        {
            return (this._1039690024notice);
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function set playerInfo(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._2095520559playerInfo;
            if (_local_2 !== _arg_1)
            {
                this._2095520559playerInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pass():TextInput
        {
            return (this._3433489pass);
        }

        public function set pass(_arg_1:TextInput):void
        {
            var _local_2:Object = this._3433489pass;
            if (_local_2 !== _arg_1)
            {
                this._3433489pass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pass", _local_2, _arg_1));
            };
        }

        private function btnHandle():void
        {
            ActionFactory.getInstance().getSecurityCommands().authSecurityCode(pass.text, onResponse);
        }

        [Bindable(event="propertyChange")]
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        private function onClick(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getSecurityCommands().removeSecurityCode(onRemoveResponse);
            };
        }

        private function onRemoveResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        public function set flagSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2020316904flagSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._2020316904flagSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagSubmitBtn", _local_2, _arg_1));
            };
        }

        private function _ApplySecurityCode_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ApplySecurityCode_Button2.label = _arg_1;
            }, "_ApplySecurityCode_Button2.label");
            result[0] = binding;
            return (result);
        }

        public function reFresh():void
        {
        }

        private function _ApplySecurityCode_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("确定");
        }

        private function textChange(_arg_1:Event):void
        {
        }

        public function set notice(_arg_1:Label):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }


    }
}//package view.module.playerInfo

