// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.AddEmail

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Context;
    import mx.managers.PopUpManager;
    import com.evony.common.module.CommandResponse;
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

    public class AddEmail extends Canvas implements IBindingClient 
    {

        public static var instance:AddEmail = new (AddEmail)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1039690024notice:Text;
        public var _AddEmail_Label2:Label;
        private var _954925063message:TextInput;
        public var _AddEmail_Button2:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":540,
                    "height":200,
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
                                            "text":"System",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"notice",
                        "stylesFactory":function ():void
                        {
                            this.left = "70";
                            this.textAlign = "left";
                            this.top = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Update the Email address you would like to receive  our warning emails below.",
                                "percentWidth":70,
                                "styleName":"ParamgraphText1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_AddEmail_Label2",
                        "stylesFactory":function ():void
                        {
                            this.left = "70";
                            this.top = "90";
                        }
                    }), new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"message",
                        "stylesFactory":function ():void
                        {
                            this.left = "70";
                            this.top = "114";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":300,
                                "styleName":"inputArea",
                                "maxChars":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AddEmail_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Update",
                                            "styleName":"subTitleButton"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AddEmail_Button2",
                                    "events":{"click":"___AddEmail_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"subTitleButton"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AddEmail_Button3_click"},
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

        public function AddEmail()
        {
            mx_internal::_document = this;
            this.width = 540;
            this.height = 200;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AddEmail._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        public function ___AddEmail_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function ___AddEmail_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get message():TextInput
        {
            return (this._954925063message);
        }

        private function update(_arg_1:String):void
        {
            if (((_arg_1 == "") || (!(validateEmail(_arg_1)))))
            {
                AlertWin.show(Lang.msg("邮箱格式不正确"), null);
                return;
            };
            ActionFactory.getInstance().getCommonCommands().setEvonyMemberEMail(_arg_1, OnResponse);
            onClose();
        }

        public function ___AddEmail_Button1_click(_arg_1:MouseEvent):void
        {
            update(message.text);
        }

        public function set message(_arg_1:TextInput):void
        {
            var _local_2:Object = this._954925063message;
            if (_local_2 !== _arg_1)
            {
                this._954925063message = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "message", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AddEmail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AddEmail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_AddEmailWatcherSetupUtil");
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

        private function _AddEmail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Context.getInstance().getPlayerBean().emailAddress;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddEmail_Label2.text = _arg_1;
            }, "_AddEmail_Label2.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AddEmail_Button2.label = _arg_1;
            }, "_AddEmail_Button2.label");
            result[1] = binding;
            return (result);
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        private function OnResponse(_arg_1:CommandResponse):void
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

        private function validateEmail(_arg_1:String):Boolean
        {
            var _local_2:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
            var _local_3:Object = _local_2.exec(_arg_1);
            if (_local_3 == null)
            {
                return (false);
            };
            return (true);
        }

        public function set notice(_arg_1:Text):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }

        private function _AddEmail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Context.getInstance().getPlayerBean().emailAddress;
            _local_1 = Lang.msg("取消");
        }


    }
}//package view

