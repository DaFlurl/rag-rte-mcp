// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Mail.MailsView

package autoevony.gui.info.Mail
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TabBar;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.MailConstants;
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

    public class MailsView extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _3526552sent:MailBox;
        private var _100344454inbox:MailBox;
        private var _887328209system:MailBox;
        private var _113399775write:Compose;
        private var _241329461mailsInfoTab:TabBar;
        private var _10266686mailsInfoStack:ViewStack;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "0";
                            this.right = "0";
                            this.top = "3";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "bottom";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":22,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TabBar,
                                                "id":"mailsInfoTab",
                                                "stylesFactory":function ():void
                                                {
                                                    this.tabStyleName = "REtabBarTab";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "dataProvider":"mailsInfoStack",
                                                        "styleName":"REtabBar"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"mailsInfoStack",
                                    "stylesFactory":function ():void
                                    {
                                        this.borderColor = 0x222222;
                                        this.borderThickness = 1;
                                        this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "creationPolicy":"all",
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":MailBox,
                                                "id":"inbox",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Inbox"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MailBox,
                                                "id":"system",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"System"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MailBox,
                                                "id":"sent",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Sent"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Compose,
                                                "id":"write",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Write",
                                                        "styleName":"REmailComposeView"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MailsView()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MailsView._watcherSetupUtil = _arg_1;
        }


        public function set mailsInfoStack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._10266686mailsInfoStack;
            if (_local_2 !== _arg_1)
            {
                this._10266686mailsInfoStack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailsInfoStack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get inbox():MailBox
        {
            return (this._100344454inbox);
        }

        public function toDebugString():String
        {
            return ("fields: inbox system sent");
        }

        [Bindable(event="propertyChange")]
        public function get mailsInfoTab():TabBar
        {
            return (this._241329461mailsInfoTab);
        }

        [Bindable(event="propertyChange")]
        public function get mailsInfoStack():ViewStack
        {
            return (this._10266686mailsInfoStack);
        }

        override public function initialize():void
        {
            var target:MailsView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._MailsView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Mail_MailsViewWatcherSetupUtil");
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

        private function _MailsView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (MailConstants.MAIL_RECEIVE);
            }, function (_arg_1:int):void
            {
                inbox.mailType = _arg_1;
            }, "inbox.mailType");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (MailConstants.MAIL_SYSTEM);
            }, function (_arg_1:int):void
            {
                system.mailType = _arg_1;
            }, "system.mailType");
            result[1] = binding;
            binding = new Binding(this, function ():int
            {
                return (MailConstants.MAIL_SEND);
            }, function (_arg_1:int):void
            {
                sent.mailType = _arg_1;
            }, "sent.mailType");
            result[2] = binding;
            return (result);
        }

        public function set inbox(_arg_1:MailBox):void
        {
            var _local_2:Object = this._100344454inbox;
            if (_local_2 !== _arg_1)
            {
                this._100344454inbox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inbox", _local_2, _arg_1));
            };
        }

        public function set mailsInfoTab(_arg_1:TabBar):void
        {
            var _local_2:Object = this._241329461mailsInfoTab;
            if (_local_2 !== _arg_1)
            {
                this._241329461mailsInfoTab = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailsInfoTab", _local_2, _arg_1));
            };
        }

        public function set system(_arg_1:MailBox):void
        {
            var _local_2:Object = this._887328209system;
            if (_local_2 !== _arg_1)
            {
                this._887328209system = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "system", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get write():Compose
        {
            return (this._113399775write);
        }

        [Bindable(event="propertyChange")]
        public function get sent():MailBox
        {
            return (this._3526552sent);
        }

        public function set write(_arg_1:Compose):void
        {
            var _local_2:Object = this._113399775write;
            if (_local_2 !== _arg_1)
            {
                this._113399775write = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "write", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get system():MailBox
        {
            return (this._887328209system);
        }

        public function set sent(_arg_1:MailBox):void
        {
            var _local_2:Object = this._3526552sent;
            if (_local_2 !== _arg_1)
            {
                this._3526552sent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sent", _local_2, _arg_1));
            };
        }

        private function _MailsView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = MailConstants.MAIL_RECEIVE;
            _local_1 = MailConstants.MAIL_SYSTEM;
            _local_1 = MailConstants.MAIL_SEND;
        }


    }
}//package autoevony.gui.info.Mail

