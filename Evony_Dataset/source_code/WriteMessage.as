// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.WriteMessage

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import com.evony.data.FbData;
    import com.evony.Context;
    import com.adobe.crypto.MD5;
    import com.evony.GameConfig;
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

    public class WriteMessage extends Canvas implements IBindingClient 
    {

        public static var instance:WriteMessage = new (WriteMessage)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1039690024notice:Text;
        public var _WriteMessage_Button1:Button;
        private var _954925063message:TextArea;

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
                                            "text":"Neighbor Info",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_WriteMessage_Button1",
                        "events":{"click":"___WriteMessage_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "250";
                            this.bottom = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"subTitleButton"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"notice",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.textAlign = "left";
                            this.top = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Leave your neighbor a message(less than 100 characters):",
                                "styleName":"ParamgraphText1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"message",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.right = "50";
                            this.bottom = "60";
                            this.top = "80";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"inputArea",
                                "maxChars":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___WriteMessage_Button2_click"},
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

        public function WriteMessage()
        {
            mx_internal::_document = this;
            this.width = 540;
            this.height = 200;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WriteMessage._watcherSetupUtil = _arg_1;
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


        private function send(_arg_1:String):void
        {
            if (_arg_1 == "")
            {
                AlertWin.show(Lang.msg("输入名字不合法"), null);
                return;
            };
            ActionFactory.getInstance().getVisitCommands().visitorComment(_arg_1, visitorCommentResponse);
            onClose();
        }

        override public function initialize():void
        {
            var target:WriteMessage;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WriteMessage_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_WriteMessageWatcherSetupUtil");
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

        public function set message(_arg_1:TextArea):void
        {
            var _local_2:Object = this._954925063message;
            if (_local_2 !== _arg_1)
            {
                this._954925063message = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "message", _local_2, _arg_1));
            };
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get message():TextArea
        {
            return (this._954925063message);
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        public function ___WriteMessage_Button1_click(_arg_1:MouseEvent):void
        {
            send(message.text);
        }

        public function ___WriteMessage_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function visitorCommentResponse(_arg_1:CommandResponse):void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = "";
                if (ExternalInterface.available)
                {
                    _local_2 = ExternalInterface.call("facebook.fb_getUserName");
                };
                _local_3 = FbData.getInstance().getValue(10005);
                _local_4 = (Context.getInstance().bVisitHostName + " just got a new message in EVONY");
                _local_5 = (((_local_2 + " just visited ") + Context.getInstance().bVisitHostName) + "'s empire and left him a message.");
                _local_6 = (((((('{"name":"' + _local_4) + '","href":"http://www.evony.com/","description":"') + _local_5) + '","media":[{"type":"image","src":"') + _local_3.img) + '","href":"http://www.evony.com/"}]}');
                _local_7 = Context.getInstance().GetGuidStr();
                _local_8 = MD5.hash((((("PlayEvony" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                _local_9 = (((((((((((((((("{'text':'Play Evony with " + _local_2) + "!', 'href':'") + GameConfig.instance.FbActionUrl) + "?T=PlayEvony&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=") + _local_3.id) + "&GUID=") + _local_7) + "&sign=") + _local_8) + "'}");
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("facebook.fb_streamPublish", "", _local_6, _local_9, "", "", GameConfig.instance.serverID, 10005);
                    onClose();
                };
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _WriteMessage_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发送");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WriteMessage_Button1.label = _arg_1;
            }, "_WriteMessage_Button1.label");
            result[0] = binding;
            return (result);
        }

        private function _WriteMessage_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("发送");
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


    }
}//package view

