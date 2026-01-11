// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.FlagChangeWin

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
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import com.evony.Context;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import view.ui.AddFundWin;
    import flash.utils.getDefinitionByName;
    import com.evony.util.InputTextFilter;
    import com.evony.BadWordCollection;
    import view.ui.AlertWin;
    import com.evony.common.module.CommandResponse;
    import com.evony.util.InputTextControl;
    import flash.events.Event;
    import com.evony.common.beans.ItemBean;
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

    public class FlagChangeWin extends Canvas implements IBindingClient 
    {

        public static var instance:FlagChangeWin = new (FlagChangeWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _FlagChangeWin_Label1:Label;
        public var _FlagChangeWin_Label3:Label;
        private var _2020316904flagSubmitBtn:Button;
        private var _1518654530flagInput:TextInput;
        private var _2095520559playerInfo:PlayerInfoBean;
        public var _FlagChangeWin_Label2:Label;
        public var _FlagChangeWin_Label4:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":203,
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
                                    "id":"_FlagChangeWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
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
                            this.top = "63";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "80";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FlagChangeWin_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
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
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_FlagChangeWin_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
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
                                    "id":"flagInput",
                                    "events":{"change":"__flagInput_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":203,
                                            "y":26,
                                            "width":190,
                                            "displayAsPassword":false,
                                            "styleName":"textInput",
                                            "height":22,
                                            "maxChars":4
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_FlagChangeWin_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":198.41666,
                                            "x":0,
                                            "y":28,
                                            "height":20,
                                            "styleName":"tableContent1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"flagSubmitBtn",
                        "events":{"click":"__flagSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "35";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"Blue75",
                                "width":80,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___FlagChangeWin_Button2_click"},
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

        public function FlagChangeWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 203;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FlagChangeWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            instance.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        private function _FlagChangeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改旗号");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FlagChangeWin_Label1.text = _arg_1;
            }, "_FlagChangeWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前旗号");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FlagChangeWin_Label2.text = _arg_1;
            }, "_FlagChangeWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("输入旗号");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FlagChangeWin_Label3.text = _arg_1;
            }, "_FlagChangeWin_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfo.flag;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FlagChangeWin_Label4.text = _arg_1;
            }, "_FlagChangeWin_Label4.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                flagSubmitBtn.label = _arg_1;
            }, "flagSubmitBtn.label");
            result[4] = binding;
            return (result);
        }

        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        [Bindable(event="propertyChange")]
        public function get flagInput():TextInput
        {
            return (this._1518654530flagInput);
        }

        public function set flagInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1518654530flagInput;
            if (_local_2 !== _arg_1)
            {
                this._1518654530flagInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagInput", _local_2, _arg_1));
            };
        }

        private function useGoods(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (UIUtil.checkItem("consume.changeflag.1", 1))
                {
                    ActionFactory.getInstance().getCityCommands().modifyFlag(this.flagInput.text, modifyFlagResponse);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        override public function initialize():void
        {
            var target:FlagChangeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FlagChangeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_FlagChangeWinWatcherSetupUtil");
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
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function btnHandle():void
        {
            if (canUseGood("consume.changeflag.1"))
            {
                if (((BadWordCollection.instance.isBadWord(flagInput.text)) || (InputTextFilter.specialCharFilter(flagInput.text))))
                {
                    AlertWin.show(Lang.msg("输入名字不合法"), null);
                }
                else
                {
                    ActionFactory.getInstance().getCityCommands().modifyFlag(this.flagInput.text, modifyFlagResponse);
                };
            }
            else
            {
                AlertWin.show(Lang.msg("物品不足确定购买"), useGoods);
            };
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

        private function modifyFlagResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功更改旗号"), null);
                Context.getInstance().getPlayerBean().playerInfo.flag = this.flagInput.text;
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___FlagChangeWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        public function __flagInput_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        private function canUseGood(_arg_1:String):Boolean
        {
            var _local_4:ItemBean;
            var _local_2:Boolean;
            var _local_3:int;
            while (_local_3 < Context.getInstance().getPlayerBean().itemsArray.length)
            {
                _local_4 = Context.getInstance().getPlayerBean().getItems(_local_3);
                if (((_local_4.id == _arg_1) && (_local_4.count >= 1)))
                {
                    _local_2 = true;
                    break;
                };
                _local_3++;
            };
            return (_local_2);
        }

        private function _FlagChangeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("更改旗号");
            _local_1 = Lang.msg("当前旗号");
            _local_1 = Lang.msg("输入旗号");
            _local_1 = this.playerInfo.flag;
            _local_1 = Lang.msg("更改");
        }

        private function reFresh():void
        {
            this.flagInput.text = "";
            this.playerInfo = Context.getInstance().getPlayerBean().playerInfo;
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


    }
}//package view.module.playerInfo

