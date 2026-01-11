// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Mail.Compose

package autoevony.gui.info.Mail
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.CheckBox;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Form;
    import mx.containers.FormItem;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import autoevony.common.Utils;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.AllianceConstants;
    import mx.binding.Binding;
    import com.evony.common.constants.MailConstants;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.module.alliance.AllianceMembersResponse;
    import autoevony.gui.MainScreen;
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

    public class Compose extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _490339309_subject:TextInput;
        private var _1897462166_alliance:CheckBox;
        public var _Compose_Label2:Label;
        private var _1815989521_status:Label;
        private var _981817656_message:TextArea;
        private var _789426459_receivers:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Form,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Alliance:",
                                            "percentWidth":100,
                                            "styleName":"REmainFormText",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":CheckBox,
                                                            "id":"_alliance",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"REcheckBox"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"(2 speakers needed)",
                                                                    "styleName":"REmainFormText"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___Compose_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"REwinBtn",
                                                                    "label":"Fetch Members"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Receivers:",
                                            "percentWidth":100,
                                            "percentHeight":10,
                                            "styleName":"REmainFormText",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_receivers",
                                                "events":{"change":"___receivers_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "inset";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"RElogBox"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":23,
                                            "label":"Subject:",
                                            "styleName":"REmainFormText",
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"_subject",
                                                "events":{"change":"___subject_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "normal";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"textInput"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":FormItem,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Message:",
                                            "percentHeight":80,
                                            "percentWidth":100,
                                            "styleName":"REmainFormText",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Compose_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.fontSize = 12;
                                                    this.fontFamily = "DejaVu Sans";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "height":20
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"_message",
                                                "events":{"change":"___message_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.borderStyle = "inset";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"RElogBox"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":85});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Compose_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Send"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Compose_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Reset"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":20});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_status",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFFFFFF;
                                        this.fontSize = 12;
                                        this.fontFamily = "DejaVu Sans";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":20,
                                            "text":""
                                        });
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

        public function Compose()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Compose._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get _subject():TextInput
        {
            return (this._490339309_subject);
        }

        public function ___Compose_Button1_click(_arg_1:MouseEvent):void
        {
            this.fetchMembers();
        }

        public function set _alliance(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1897462166_alliance;
            if (_local_2 !== _arg_1)
            {
                this._1897462166_alliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_alliance", _local_2, _arg_1));
            };
        }

        public function ___Compose_Button3_click(_arg_1:MouseEvent):void
        {
            this._clearAll();
        }

        [Bindable(event="propertyChange")]
        public function get _receivers():TextArea
        {
            return (this._789426459_receivers);
        }

        private function send():void
        {
            var _local_4:String;
            this._receivers.text = Utils.trim(this._receivers.text);
            this._message.text = Utils.trim(this._message.text);
            this._subject.text = Utils.trim(this._subject.text);
            if (((this._subject.text == "") && (this._message.text == "")))
            {
                this._status.text = "Error: Cannot send empty message";
                return;
            };
            var _local_1:Array = this._receivers.text.split(",");
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                _local_1[_local_2] = Utils.trim(_local_1[_local_2]);
                if (_local_1[_local_2] == "")
                {
                    _local_1.splice(_local_2--, 1);
                };
                _local_2++;
            };
            if (this._alliance.selected)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().messagesForAllianceMember(this._subject.text, this._message.text, AllianceConstants.ALLIANCE_GROUP_MAIL, this._wv832);
                this._clearAll();
                this._status.text = "Alliance mail(s) sent, please verify sending status in Sent box.";
                return;
            };
            if (_local_1.length == 0)
            {
                this._status.text = "Error: No receiver(s)";
                return;
            };
            if (_local_1.length > 20)
            {
                this._status.text = "Error: Too many receivers, server does not let you send 20+ mails each hour";
                return;
            };
            if (((this._subject.text == "") && (this._message.text == "")))
            {
                this._status.text = "Error: Cannot send empty message";
                return;
            };
            var _local_3:Function = ((_local_1.length != 1) ? null : this._wv832);
            for each (_local_4 in _local_1)
            {
                ActionFactory.getInstance().getMailCommands().sendMail(_local_4, this._subject.text, this._message.text, _local_3);
            };
            this._clearAll();
            this._status.text = "Mail(s) sent, please verify sending status in Sent box.";
        }

        private function _Compose_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (!(_alliance.selected));
            }, function (_arg_1:Boolean):void
            {
                _receivers.enabled = _arg_1;
            }, "_receivers.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (MailConstants.TITLE_LIMIT);
            }, function (_arg_1:int):void
            {
                _subject.maxChars = _arg_1;
            }, "_subject.maxChars");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (MailConstants.CONTENT_LIMIT + " characters max");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Compose_Label2.text = _arg_1;
            }, "_Compose_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():int
            {
                return (MailConstants.CONTENT_LIMIT);
            }, function (_arg_1:int):void
            {
                _message.maxChars = _arg_1;
            }, "_message.maxChars");
            result[3] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:Compose;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Compose_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_ComposeWatcherSetupUtil");
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
        public function get _status():Label
        {
            return (this._1815989521_status);
        }

        private function _wv832(_arg_1:Object):void
        {
            if (_arg_1.ok != 1)
            {
                this._status.text = ("Error: " + _arg_1.msg);
            }
            else
            {
                this._status.text = "Message has been sent";
            };
        }

        [Bindable(event="propertyChange")]
        public function get _alliance():CheckBox
        {
            return (this._1897462166_alliance);
        }

        public function set _receivers(_arg_1:TextArea):void
        {
            var _local_2:Object = this._789426459_receivers;
            if (_local_2 !== _arg_1)
            {
                this._789426459_receivers = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_receivers", _local_2, _arg_1));
            };
        }

        public function set _message(_arg_1:TextArea):void
        {
            var _local_2:Object = this._981817656_message;
            if (_local_2 !== _arg_1)
            {
                this._981817656_message = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_message", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _message():TextArea
        {
            return (this._981817656_message);
        }

        private function _Compose_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (!(this._alliance.selected));
            _local_1 = MailConstants.TITLE_LIMIT;
            _local_1 = (MailConstants.CONTENT_LIMIT + " characters max");
            _local_1 = MailConstants.CONTENT_LIMIT;
        }

        public function set _status(_arg_1:Label):void
        {
            var _local_2:Object = this._1815989521_status;
            if (_local_2 !== _arg_1)
            {
                this._1815989521_status = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_status", _local_2, _arg_1));
            };
        }

        public function ___message_change(_arg_1:Event):void
        {
            this._status.text = "";
        }

        public function ___subject_change(_arg_1:Event):void
        {
            this._status.text = "";
        }

        private function _wn1051(_arg_1:AllianceMembersResponse):void
        {
            var _local_3:PlayerInfoBean;
            if (_arg_1.ok != 1)
            {
                return;
            };
            var _local_2:* = "";
            for each (_local_3 in _arg_1.membersArray)
            {
                if (_local_2.length > 0)
                {
                    _local_2 = (_local_2 + ", ");
                };
                _local_2 = (_local_2 + _local_3.userName);
            };
            this._receivers.text = _local_2;
        }

        public function set _subject(_arg_1:TextInput):void
        {
            var _local_2:Object = this._490339309_subject;
            if (_local_2 !== _arg_1)
            {
                this._490339309_subject = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_subject", _local_2, _arg_1));
            };
        }

        public function _clearAll():void
        {
            this._receivers.text = "";
            this._subject.text = "";
            this._message.text = "";
            this._status.text = "";
            this._alliance.selected = false;
            this._receivers.enabled = true;
        }

        public function ___receivers_change(_arg_1:Event):void
        {
            this._status.text = "";
        }

        public function ___Compose_Button2_click(_arg_1:MouseEvent):void
        {
            this.send();
        }

        private function fetchMembers():void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (MainScreen.getPlayer().playerInfo.alliance == null)
            {
                this._status.text = "Error: You are not in any alliance";
                return;
            };
            ActionFactory.getInstance().getAllianceCommands().getAllianceMembers(this._wn1051);
        }


    }
}//package autoevony.gui.info.Mail

