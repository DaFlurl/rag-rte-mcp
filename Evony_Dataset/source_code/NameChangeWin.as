// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.NameChangeWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.controls.Label;
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
    import flash.events.MouseEvent;
    import com.evony.util.InputTextControl;
    import com.evony.util.InputTextFilter;
    import flash.events.Event;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import view.ui.AddFundWin;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.BadWordCollection;
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

    public class NameChangeWin extends Canvas implements IBindingClient 
    {

        public static var instance:NameChangeWin = new (NameChangeWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1213385727nameInput:TextInput;
        private var _2020316904flagSubmitBtn:Button;
        public var _NameChangeWin_Label1:Label;
        public var _NameChangeWin_Label2:Label;
        public var _NameChangeWin_Label4:Label;
        public var _NameChangeWin_Label3:Label;
        private var _2095520559playerInfo:PlayerInfoBean;

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
                                    "id":"_NameChangeWin_Label1",
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
                                                            "id":"_NameChangeWin_Label2",
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
                                                            "id":"_NameChangeWin_Label3",
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
                                    "id":"nameInput",
                                    "events":{"change":"__nameInput_change"},
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
                                            "maxChars":10
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NameChangeWin_Label4",
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
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.right = "20";
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
                        "events":{"click":"___NameChangeWin_Button2_click"},
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

        public function NameChangeWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 203;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NameChangeWin._watcherSetupUtil = _arg_1;
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


        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        private function textChange(_arg_1:Event):void
        {
            var _local_5:String;
            var _local_2:int;
            TextInput(_arg_1.currentTarget).maxChars = 20;
            var _local_3:String = nameInput.text;
            InputTextControl.textChange(_arg_1);
            var _local_4:int;
            while (_local_4 < nameInput.text.length)
            {
                _local_5 = nameInput.text.substr(_local_4, 1);
                if (InputTextFilter.isChinese(_local_5))
                {
                    _local_2 = (_local_2 + 2);
                }
                else
                {
                    _local_2 = (_local_2 + 1);
                };
                if (((_arg_1.currentTarget == this.nameInput) && (_local_2 > 10)))
                {
                    this.nameInput.text = this.nameInput.text.substring(0, _local_4);
                    this.nameInput.maxChars = this.nameInput.length;
                    return;
                };
                _local_4++;
            };
        }

        [Bindable(event="propertyChange")]
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        private function modifyNameResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功更改君主名"));
                this.onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___NameChangeWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function useGoods(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (UIUtil.checkItem("player.name.1.a", 1))
                {
                    ActionFactory.getInstance().getCityCommands().modifyUserName(this.nameInput.text, "player.name.1.a", modifyNameResponse);
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        private function _NameChangeWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("更改君主名");
            _local_1 = Lang.msg("原君主名");
            _local_1 = Lang.msg("新君主名");
            _local_1 = this.playerInfo.userName;
            _local_1 = Lang.msg("更改");
        }

        override public function initialize():void
        {
            var target:NameChangeWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NameChangeWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_NameChangeWinWatcherSetupUtil");
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

        public function __nameInput_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        private function btnHandle():void
        {
            if (((InputTextFilter.specialCharFilter(nameInput.text)) || (BadWordCollection.instance.isBadWord(nameInput.text))))
            {
                AlertWin.show(Lang.msg("输入名字不合法"));
                return;
            };
            ActionFactory.getInstance().getCityCommands().modifyUserName(this.nameInput.text, "player.name.1.a", modifyNameResponse);
        }

        [Bindable(event="propertyChange")]
        private function get playerInfo():PlayerInfoBean
        {
            return (this._2095520559playerInfo);
        }

        private function _NameChangeWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改君主名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NameChangeWin_Label1.text = _arg_1;
            }, "_NameChangeWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("原君主名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NameChangeWin_Label2.text = _arg_1;
            }, "_NameChangeWin_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("新君主名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NameChangeWin_Label3.text = _arg_1;
            }, "_NameChangeWin_Label3.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.playerInfo.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NameChangeWin_Label4.text = _arg_1;
            }, "_NameChangeWin_Label4.text");
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

        public function set flagSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2020316904flagSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._2020316904flagSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagSubmitBtn", _local_2, _arg_1));
            };
        }

        public function reFresh():void
        {
            this.nameInput.text = "";
        }

        public function set nameInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1213385727nameInput;
            if (_local_2 !== _arg_1)
            {
                this._1213385727nameInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nameInput", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get nameInput():TextInput
        {
            return (this._1213385727nameInput);
        }


    }
}//package view.module.playerInfo

