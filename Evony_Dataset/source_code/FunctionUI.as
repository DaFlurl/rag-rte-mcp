// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.friendList.FunctionUI

package view.module.friendList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import view.castle.MainFrame;
    import com.evony.util.MinePopupManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import view.module.rank.PlayerInfo;
    import com.evony.common.beans.PlayerInfoBean;
    import view.ChatFrame;
    import flash.system.System;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import com.evony.Context;
    import com.evony.common.module.friend.FriendResponse;
    import mx.managers.PopUpManager;
    import view.ui.AlertWin;
    import mx.collections.ArrayCollection;
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

    public class FunctionUI extends Canvas implements IBindingClient 
    {

        public static var instance:FunctionUI = new (FunctionUI)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var beanType:String;
        private var _93818879black:Button;
        private var bean:Object;
        private var _2090283592viewCharacterBtn:Button;
        private var _203759525myBlockBtn:Button;
        private var _308570246whisperBtn:Button;
        private var _953493159copyBtn:Button;
        private var userName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":125,
                    "height":126,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "1";
                            this.top = "1";
                            this.right = "1";
                            this.bottom = "1";
                            this.verticalGap = 1;
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"whisperBtn",
                                    "events":{
                                        "click":"__whisperBtn_click",
                                        "mouseOver":"__whisperBtn_mouseOver",
                                        "mouseOut":"__whisperBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"viewCharacterBtn",
                                    "events":{
                                        "click":"__viewCharacterBtn_click",
                                        "mouseOver":"__viewCharacterBtn_mouseOver",
                                        "mouseOut":"__viewCharacterBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"myBlockBtn",
                                    "events":{
                                        "click":"__myBlockBtn_click",
                                        "mouseOver":"__myBlockBtn_mouseOver",
                                        "mouseOut":"__myBlockBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":28,
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"copyBtn",
                                    "events":{
                                        "click":"__copyBtn_click",
                                        "mouseOver":"__copyBtn_mouseOver",
                                        "mouseOut":"__copyBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"black",
                                    "events":{
                                        "click":"__black_click",
                                        "mouseOver":"__black_mouseOver",
                                        "mouseOut":"__black_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":28,
                                            "styleName":"chatPopupBtn",
                                            "alpha":0,
                                            "width":119,
                                            "height":22
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FunctionUI()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.styleName = "doubleLineBlue";
            this.width = 125;
            this.height = 126;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FunctionUI._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object):void
        {
            instance.userName = _arg_1.userName;
            instance.bean = _arg_1;
            instance.x = (MainFrame.instance.mouseX + 40);
            instance.y = (MainFrame.instance.mouseY + 55);
            if (!instance.isPopUp)
            {
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, false);
            };
        }


        private function onChatBtnOver(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 1;
        }

        public function set whisperBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._308570246whisperBtn;
            if (_local_2 !== _arg_1)
            {
                this._308570246whisperBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "whisperBtn", _local_2, _arg_1));
            };
        }

        public function __myBlockBtn_click(_arg_1:MouseEvent):void
        {
            deleteHandler();
        }

        private function onChatBtnOut(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 0;
        }

        override public function initialize():void
        {
            var target:FunctionUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FunctionUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_friendList_FunctionUIWatcherSetupUtil");
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

        public function __myBlockBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function __copyBtn_click(_arg_1:MouseEvent):void
        {
            onCopyName();
        }

        public function __black_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onIsSure(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getFriendCommands().deleteFriend(userName, onDeleteFriend);
                onClose();
            };
        }

        private function deleteHandler():void
        {
            FriendList.instance.deleteHandler(userName);
            onClose();
        }

        public function __viewCharacterBtn_click(_arg_1:MouseEvent):void
        {
            checkHandler();
        }

        private function checkHandler():void
        {
            if (bean != null)
            {
                PlayerInfo.show(PlayerInfoBean(bean));
            };
            onClose();
        }

        private function onWhisper():void
        {
            ChatFrame.instance.sayTo(userName);
            onClose();
        }

        private function onCopyName():void
        {
            System.setClipboard(userName);
            onClose();
        }

        public function __copyBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function _FunctionUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("密语");
            _local_1 = Lang.msg("查看");
            _local_1 = Lang.msg("删除");
            _local_1 = Lang.msg("复制名称");
            _local_1 = Lang.msg("黑名单");
        }

        public function __whisperBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function onDeleteFriend(_arg_1:FriendResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().getPlayerBean().friendBeansArray = _arg_1.friendArrArray;
                ActionFactory.getInstance().getFriendCommands().addBlock(userName);
            };
        }

        public function __viewCharacterBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get copyBtn():Button
        {
            return (this._953493159copyBtn);
        }

        public function __viewCharacterBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get viewCharacterBtn():Button
        {
            return (this._2090283592viewCharacterBtn);
        }

        public function set myBlockBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._203759525myBlockBtn;
            if (_local_2 !== _arg_1)
            {
                this._203759525myBlockBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myBlockBtn", _local_2, _arg_1));
            };
        }

        public function set copyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._953493159copyBtn;
            if (_local_2 !== _arg_1)
            {
                this._953493159copyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "copyBtn", _local_2, _arg_1));
            };
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get myBlockBtn():Button
        {
            return (this._203759525myBlockBtn);
        }

        private function addBlack():void
        {
            if (userName == Context.getInstance().getPlayerBean().playerInfo.userName)
            {
                AlertWin.show(Lang.msg("不能添加自己"));
                return;
            };
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().blockBeansArray;
            var _local_2:int;
            while (_local_2 < _local_1.length)
            {
                if (PlayerInfoBean(_local_1[_local_2]).userName == userName)
                {
                    AlertWin.show(Lang.msg("玩家已经在列表中"));
                    return;
                };
                _local_2++;
            };
            var _local_3:ArrayCollection = Context.getInstance().getPlayerBean().friendBeansArray;
            var _local_4:int;
            while (_local_4 < _local_3.length)
            {
                if (PlayerInfoBean(_local_3[_local_4]).userName == userName)
                {
                    AlertWin.show(Lang.msg("从好友到黑名单"), onIsSure, Lang.msg("确定"), Lang.msg("取消"));
                    return;
                };
                if (_local_4 >= (_local_3.length - 1))
                {
                    ActionFactory.getInstance().getFriendCommands().addBlock(userName);
                    onClose();
                };
                _local_4++;
            };
        }

        public function __whisperBtn_click(_arg_1:MouseEvent):void
        {
            onWhisper();
        }

        public function __black_click(_arg_1:MouseEvent):void
        {
            addBlack();
        }

        public function __copyBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function __whisperBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function set viewCharacterBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2090283592viewCharacterBtn;
            if (_local_2 !== _arg_1)
            {
                this._2090283592viewCharacterBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewCharacterBtn", _local_2, _arg_1));
            };
        }

        public function __black_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get whisperBtn():Button
        {
            return (this._308570246whisperBtn);
        }

        private function _FunctionUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("密语");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                whisperBtn.label = _arg_1;
            }, "whisperBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                viewCharacterBtn.label = _arg_1;
            }, "viewCharacterBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("删除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myBlockBtn.label = _arg_1;
            }, "myBlockBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("复制名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                copyBtn.label = _arg_1;
            }, "copyBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("黑名单");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                black.label = _arg_1;
            }, "black.label");
            result[4] = binding;
            return (result);
        }

        public function __myBlockBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function set black(_arg_1:Button):void
        {
            var _local_2:Object = this._93818879black;
            if (_local_2 !== _arg_1)
            {
                this._93818879black = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "black", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get black():Button
        {
            return (this._93818879black);
        }


    }
}//package view.module.friendList

