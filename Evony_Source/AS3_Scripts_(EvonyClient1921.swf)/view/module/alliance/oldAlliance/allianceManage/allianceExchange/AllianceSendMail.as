// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.AllianceSendMail

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.CheckBox;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class AllianceSendMail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceSendMail_Button1:Button;
        public var _AllianceSendMail_Button2:Button;
        private var _1400106095isSendAll:CheckBox;
        public var _AllianceSendMail_Label1:Label;
        public var _AllianceSendMail_Label3:Label;
        public var _AllianceSendMail_Label2:Label;
        private var _2103625714receiveName:String = "";
        private var _951530617content:TextArea;
        private var _808719889receiver:TextInput;
        private var _110371416title:TextInput;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceSendMail_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "20";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":25,
                                            "width":80,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"receiver",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textInput",
                                            "maxChars":10,
                                            "x":105,
                                            "width":130
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceSendMail_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "50";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":25,
                                            "width":80,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"title",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "50";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textInput",
                                            "maxChars":20,
                                            "x":105
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"isSendAll",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "19";
                                        this.left = "237";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":336,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceSendMail_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "265.5";
                                        this.top = "53";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "width":283
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextArea,
                                    "id":"content",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "80";
                                        this.bottom = "36";
                                        this.left = "0";
                                        this.right = "0";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"inputArea",
                                            "maxChars":500
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "5";
                                        this.right = "0";
                                        this.horizontalGap = 5;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceSendMail_Button1",
                                                "events":{"click":"___AllianceSendMail_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":95,
                                                        "styleName":"b95"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceSendMail_Button2",
                                                "events":{"click":"___AllianceSendMail_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":95,
                                                        "styleName":"b95"
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceSendMail()
        {
            mx_internal::_document = this;
            this.percentHeight = 100;
            this.percentWidth = 100;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllianceSendMail_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceSendMail._watcherSetupUtil = _arg_1;
        }


        private function _AllianceSendMail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("收信人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceSendMail_Label1.text = _arg_1;
            }, "_AllianceSendMail_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = receiveName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                receiver.text = _arg_1;
            }, "receiver.text");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(isSendAll.selected));
            }, function (_arg_1:Boolean):void
            {
                receiver.enabled = _arg_1;
            }, "receiver.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("主题") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceSendMail_Label2.text = _arg_1;
            }, "_AllianceSendMail_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟群发消耗2个传音符");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                isSendAll.label = _arg_1;
            }, "isSendAll.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("信件内容最大长度");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceSendMail_Label3.text = _arg_1;
            }, "_AllianceSendMail_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发送");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceSendMail_Button1.label = _arg_1;
            }, "_AllianceSendMail_Button1.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceSendMail_Button2.label = _arg_1;
            }, "_AllianceSendMail_Button2.label");
            result[7] = binding;
            return (result);
        }

        private function onSend():void
        {
            if (isSendAll.selected == true)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().messagesForAllianceMember(title.text, content.text, AllianceConstants.ALLIANCE_GROUP_MAIL);
            }
            else
            {
                ActionFactory.getInstance().getMailCommands().sendMail(receiver.text, title.text, content.text, onSendMailPersional);
            };
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        override public function initialize():void
        {
            var target:AllianceSendMail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceSendMail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_AllianceSendMailWatcherSetupUtil");
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

        private function set receiveName(_arg_1:String):void
        {
            var _local_2:Object = this._2103625714receiveName;
            if (_local_2 !== _arg_1)
            {
                this._2103625714receiveName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiveName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get receiveName():String
        {
            return (this._2103625714receiveName);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_MESSAGES_FOR_ALLIANCE_MEMBER, onSendMailAllMember);
            this.refresh();
        }

        public function ___AllianceSendMail_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___AllianceSendMail_Button2_click(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        private function onSendMailPersional(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("个人发送信件成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set title(_arg_1:TextInput):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        public function set beanObj(_arg_1:String):void
        {
            receiveName = _arg_1;
        }

        public function refresh():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWIN_GET_DATA, {"id":"allianceMail"}));
        }

        private function onSendMailAllMember(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("发送成功"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set receiver(_arg_1:TextInput):void
        {
            var _local_2:Object = this._808719889receiver;
            if (_local_2 !== _arg_1)
            {
                this._808719889receiver = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "receiver", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get title():TextInput
        {
            return (this._110371416title);
        }

        private function _AllianceSendMail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (Lang.msg("收信人") + ": ");
            _local_1 = receiveName;
            _local_1 = (!(isSendAll.selected));
            _local_1 = (Lang.msg("主题") + ": ");
            _local_1 = Lang.msg("联盟群发消耗2个传音符");
            _local_1 = Lang.msg("信件内容最大长度");
            _local_1 = Lang.msg("发送");
            _local_1 = Lang.msg("返回");
        }

        public function set isSendAll(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1400106095isSendAll;
            if (_local_2 !== _arg_1)
            {
                this._1400106095isSendAll = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isSendAll", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isSendAll():CheckBox
        {
            return (this._1400106095isSendAll);
        }

        public function set content(_arg_1:TextArea):void
        {
            var _local_2:Object = this._951530617content;
            if (_local_2 !== _arg_1)
            {
                this._951530617content = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "content", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get receiver():TextInput
        {
            return (this._808719889receiver);
        }

        [Bindable(event="propertyChange")]
        public function get content():TextArea
        {
            return (this._951530617content);
        }

        public function destroy():void
        {
        }

        public function ___AllianceSendMail_Button1_click(_arg_1:MouseEvent):void
        {
            onSend();
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

