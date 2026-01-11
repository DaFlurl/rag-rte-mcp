// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.friendList.UserInputUI

package view.module.friendList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import com.evony.common.module.friend.FriendResponse;
    import view.ui.AlertWin;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.PlayerInfoBean;
    import flash.events.MouseEvent;
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

    public class UserInputUI extends Canvas implements IBindingClient 
    {

        public static var instance:UserInputUI = new (UserInputUI)();
        public static const ADD_FRIEND:String = "add.friend";
        public static const ADD_BLACK:String = "add.black";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _110371416title:String;
        private var _100358090input:TextInput;
        public var _UserInputUI_Label1:Label;
        private var _348630820submitBtn:Button;
        public var _UserInputUI_Label2:Label;
        private var addType:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":180,
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
                            this.top = "6";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_UserInputUI_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":6,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_UserInputUI_Label2",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "66";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ParamgraphText1",
                                "width":177
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"input",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.bottom = "66";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":123,
                                "maxChars":16,
                                "x":205
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"submitBtn",
                        "events":{"mouseDown":"__submitBtn_mouseDown"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "64";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "width":75
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___UserInputUI_Button2_click"},
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

        public function UserInputUI()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 180;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UserInputUI._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:String, _arg_2:String):void
        {
            instance.addType = _arg_1;
            instance.title = _arg_2;
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                PopUpManager.centerPopUp(instance);
            };
            if (instance.input)
            {
                instance.input.text = "";
                instance.input.setFocus();
            };
        }


        private function _UserInputUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UserInputUI_Label1.text = _arg_1;
            }, "_UserInputUI_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("请输入玩家名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UserInputUI_Label2.text = _arg_1;
            }, "_UserInputUI_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("添加");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                submitBtn.label = _arg_1;
            }, "submitBtn.label");
            result[2] = binding;
            return (result);
        }

        private function _UserInputUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = title;
            _local_1 = Lang.msg("请输入玩家名称");
            _local_1 = Lang.msg("添加");
        }

        public function set submitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._348630820submitBtn;
            if (_local_2 !== _arg_1)
            {
                this._348630820submitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "submitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get input():TextInput
        {
            return (this._100358090input);
        }

        override public function initialize():void
        {
            var target:UserInputUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UserInputUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_friendList_UserInputUIWatcherSetupUtil");
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

        public function set input(_arg_1:TextInput):void
        {
            var _local_2:Object = this._100358090input;
            if (_local_2 !== _arg_1)
            {
                this._100358090input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "input", _local_2, _arg_1));
            };
        }

        private function onIsSure(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (addType == ADD_BLACK)
                {
                    ActionFactory.getInstance().getFriendCommands().deleteFriend(input.text, onDeleteFriend);
                }
                else
                {
                    if (addType == ADD_FRIEND)
                    {
                        ActionFactory.getInstance().getFriendCommands().deleteBlock(input.text, onDeleteFriend);
                    };
                };
                close();
            };
        }

        [Bindable(event="propertyChange")]
        public function get submitBtn():Button
        {
            return (this._348630820submitBtn);
        }

        private function onDeleteFriend(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (addType == ADD_BLACK)
                {
                    Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                    ActionFactory.getInstance().getFriendCommands().addBlock(input.text);
                }
                else
                {
                    if (addType == ADD_FRIEND)
                    {
                        Context.getInstance().getPlayerBean().blockBeansArray = _arg_1.blockArrArray;
                        ActionFactory.getInstance().getFriendCommands().addFriend(input.text);
                    };
                };
            };
        }

        private function addHandler():void
        {
            var _local_4:int;
            var _local_5:int;
            if (input.text == Context.getInstance().getPlayerBean().playerInfo.userName)
            {
                AlertWin.show(Lang.msg("不能添加自己"));
                return;
            };
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
            var _local_3:Boolean;
            if (addType == ADD_FRIEND)
            {
                _local_4 = 0;
                while (_local_4 < _local_2.length)
                {
                    if (PlayerInfoBean(_local_2[_local_4]).userName == input.text)
                    {
                        AlertWin.show(Lang.msg("从黑名单到好友"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                        return;
                    };
                    _local_4++;
                };
                ActionFactory.getInstance().getFriendCommands().addFriend(input.text);
                close();
            }
            else
            {
                if (addType == ADD_BLACK)
                {
                    _local_5 = 0;
                    while (_local_5 < _local_1.length)
                    {
                        if (PlayerInfoBean(_local_1[_local_5]).userName == input.text)
                        {
                            AlertWin.show(Lang.msg("从好友到黑名单"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                            return;
                        };
                        _local_5++;
                    };
                    ActionFactory.getInstance().getFriendCommands().addBlock(input.text);
                    close();
                };
            };
        }

        public function __submitBtn_mouseDown(_arg_1:MouseEvent):void
        {
            addHandler();
        }

        [Bindable(event="propertyChange")]
        private function get title():String
        {
            return (this._110371416title);
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

        private function close():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___UserInputUI_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }


    }
}//package view.module.friendList

