// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.AllianceManageView

package view.module.alliance.oldAlliance.allianceManage
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import com.evony.Context;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.ChangeCovenanter;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.AllianceConstants;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
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

    public class AllianceManageView extends Canvas implements IBindingClient 
    {

        public static var instance:AllianceManageView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceManageView_Label1:Label;
        private var _567464061sendMailBtn:Button;
        private var _1901031789inviteBtn:Button;
        private var _1032494288officalLevel:int = 0;
        private var _1547312449allianceManageView:Canvas;
        private var _700357322checkApplyBtn:Button;
        private var _1139991068diplomacyBtn:Button;
        private var _884533955changeLeaderBtn:Button;
        private var _1973350055exitAllianceBtn:Button;
        private var _1539110077introduceBtn:Button;
        private var _682088584officalResignBtn:Button;
        private var _1007194459memberLimitBtn:Button;
        private var _1900512503exitBackBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "height":280,
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
                        "type":Canvas,
                        "id":"allianceManageView",
                        "stylesFactory":function ():void
                        {
                            this.top = "80";
                            this.left = "40";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"inviteBtn",
                                                            "events":{"click":"__inviteBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"memberLimitBtn",
                                                            "events":{"click":"__memberLimitBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"diplomacyBtn",
                                                            "events":{"click":"__diplomacyBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"changeLeaderBtn",
                                                            "events":{"click":"__changeLeaderBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"exitAllianceBtn",
                                                            "events":{"click":"__exitAllianceBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 10;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"checkApplyBtn",
                                                            "events":{"click":"__checkApplyBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"introduceBtn",
                                                            "events":{"click":"__introduceBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"sendMailBtn",
                                                            "events":{"click":"__sendMailBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"officalResignBtn",
                                                            "events":{"click":"__officalResignBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b135"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
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
                                    "id":"_AllianceManageView_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"exitBackBtn",
                        "events":{"click":"__exitBackBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceManageView()
        {
            mx_internal::_document = this;
            this.width = 400;
            this.height = 280;
            this.addEventListener("creationComplete", ___AllianceManageView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceManageView._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (instance == null)
            {
                instance = new (AllianceManageView)();
            };
            PopUpManager.addPopUp(instance, MainFrame.instance, true);
            if ((Application.application.width - instance.width) > 0)
            {
                instance.x = (((Application.application.width - instance.width) / 2) - 150);
                instance.y = (((Application.application.height - instance.height) / 2) - 30);
                PopUpManager.bringToFront(instance);
            }
            else
            {
                PopUpManager.centerPopUp(instance);
            };
            instance.officalLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
        }


        public function set introduceBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1539110077introduceBtn;
            if (_local_2 !== _arg_1)
            {
                this._1539110077introduceBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "introduceBtn", _local_2, _arg_1));
            };
        }

        public function set allianceManageView(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1547312449allianceManageView;
            if (_local_2 !== _arg_1)
            {
                this._1547312449allianceManageView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceManageView", _local_2, _arg_1));
            };
        }

        public function __memberLimitBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        public function set changeLeaderBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._884533955changeLeaderBtn;
            if (_local_2 !== _arg_1)
            {
                this._884533955changeLeaderBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeLeaderBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get officalResignBtn():Button
        {
            return (this._682088584officalResignBtn);
        }

        public function set sendMailBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._567464061sendMailBtn;
            if (_local_2 !== _arg_1)
            {
                this._567464061sendMailBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sendMailBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get sendMailBtn():Button
        {
            return (this._567464061sendMailBtn);
        }

        public function __exitAllianceBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        private function manageBtnClick(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target)
            {
                case inviteBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"inviteMember"}));
                    break;
                case checkApplyBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"checkApply"}));
                    break;
                case memberLimitBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceMemberList"}));
                    break;
                case introduceBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceIntro"}));
                    break;
                case diplomacyBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceDiplomacy"}));
                    break;
                case sendMailBtn:
                    MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":"allianceMail"}));
                    break;
                case changeLeaderBtn:
                    ChangeCovenanter.show();
                    break;
                case officalResignBtn:
                    ActionFactory.getInstance().getAllianceManagementCommands().resignForAlliance();
                    break;
                case exitAllianceBtn:
                    if (officalLevel != AllianceConstants.TOP_POWER_FOR_ALLIANCE)
                    {
                        AlertWin.show(Lang.msg("退出联盟的提示"), onClickOk, Lang.msg("确定"), Lang.msg("取消"));
                    }
                    else
                    {
                        ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance();
                    };
                    break;
            };
            if (((!(_arg_1.target == officalResignBtn)) || (!(_arg_1.target == exitAllianceBtn))))
            {
                PopUpManager.removePopUp(this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get inviteBtn():Button
        {
            return (this._1901031789inviteBtn);
        }

        override public function initialize():void
        {
            var target:AllianceManageView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceManageView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_AllianceManageViewWatcherSetupUtil");
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

        private function _AllianceManageView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("邀请加入");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                inviteBtn.label = _arg_1;
            }, "inviteBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                inviteBtn.enabled = _arg_1;
            }, "inviteBtn.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成员权限");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                memberLimitBtn.label = _arg_1;
            }, "memberLimitBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                memberLimitBtn.enabled = _arg_1;
            }, "memberLimitBtn.enabled");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟外交");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                diplomacyBtn.label = _arg_1;
            }, "diplomacyBtn.label");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                diplomacyBtn.enabled = _arg_1;
            }, "diplomacyBtn.enabled");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("转让盟主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                changeLeaderBtn.label = _arg_1;
            }, "changeLeaderBtn.label");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE);
            }, function (_arg_1:Boolean):void
            {
                changeLeaderBtn.enabled = _arg_1;
            }, "changeLeaderBtn.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("退出联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                exitAllianceBtn.label = _arg_1;
            }, "exitAllianceBtn.label");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                exitAllianceBtn.enabled = _arg_1;
            }, "exitAllianceBtn.enabled");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("审核申请");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                checkApplyBtn.label = _arg_1;
            }, "checkApplyBtn.label");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                checkApplyBtn.enabled = _arg_1;
            }, "checkApplyBtn.enabled");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟介绍");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                introduceBtn.label = _arg_1;
            }, "introduceBtn.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                introduceBtn.enabled = _arg_1;
            }, "introduceBtn.enabled");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟群发");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sendMailBtn.label = _arg_1;
            }, "sendMailBtn.label");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                sendMailBtn.enabled = _arg_1;
            }, "sendMailBtn.enabled");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("官员辞职");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                officalResignBtn.label = _arg_1;
            }, "officalResignBtn.label");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            }, function (_arg_1:Boolean):void
            {
                officalResignBtn.enabled = _arg_1;
            }, "officalResignBtn.enabled");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟管理");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceManageView_Label1.text = _arg_1;
            }, "_AllianceManageView_Label1.text");
            result[18] = binding;
            return (result);
        }

        private function onSayByetoAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onClickOk(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().sayByetoAlliance();
            };
        }

        public function set inviteBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1901031789inviteBtn;
            if (_local_2 !== _arg_1)
            {
                this._1901031789inviteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get exitAllianceBtn():Button
        {
            return (this._1973350055exitAllianceBtn);
        }

        public function __changeLeaderBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get introduceBtn():Button
        {
            return (this._1539110077introduceBtn);
        }

        [Bindable(event="propertyChange")]
        private function get officalLevel():int
        {
            return (this._1032494288officalLevel);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SAY_BYETO_ALLIANCE, onSayByetoAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_RESIGN_FOR_ALLIANCE, onResignForAlliance);
        }

        [Bindable(event="propertyChange")]
        public function get allianceManageView():Canvas
        {
            return (this._1547312449allianceManageView);
        }

        [Bindable(event="propertyChange")]
        public function get changeLeaderBtn():Button
        {
            return (this._884533955changeLeaderBtn);
        }

        [Bindable(event="propertyChange")]
        public function get checkApplyBtn():Button
        {
            return (this._700357322checkApplyBtn);
        }

        public function set diplomacyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1139991068diplomacyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1139991068diplomacyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "diplomacyBtn", _local_2, _arg_1));
            };
        }

        public function __diplomacyBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        public function set exitAllianceBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1973350055exitAllianceBtn;
            if (_local_2 !== _arg_1)
            {
                this._1973350055exitAllianceBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exitAllianceBtn", _local_2, _arg_1));
            };
        }

        public function ___AllianceManageView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get memberLimitBtn():Button
        {
            return (this._1007194459memberLimitBtn);
        }

        public function __checkApplyBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        public function __exitBackBtn_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        public function __officalResignBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        public function set memberLimitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1007194459memberLimitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1007194459memberLimitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLimitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get diplomacyBtn():Button
        {
            return (this._1139991068diplomacyBtn);
        }

        public function __introduceBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        private function set officalLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1032494288officalLevel;
            if (_local_2 !== _arg_1)
            {
                this._1032494288officalLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officalLevel", _local_2, _arg_1));
            };
        }

        public function set officalResignBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._682088584officalResignBtn;
            if (_local_2 !== _arg_1)
            {
                this._682088584officalResignBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officalResignBtn", _local_2, _arg_1));
            };
        }

        private function onResignForAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("官员辞职成功"));
                ActionFactory.getInstance().getAllianceManagementCommands().getPowerFromAlliance();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __sendMailBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get exitBackBtn():Button
        {
            return (this._1900512503exitBackBtn);
        }

        public function destroy():void
        {
            if (ChangeCovenanter.instance)
            {
                PopUpManager.removePopUp(ChangeCovenanter.instance);
            };
            PopUpManager.removePopUp(this);
        }

        public function set checkApplyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._700357322checkApplyBtn;
            if (_local_2 !== _arg_1)
            {
                this._700357322checkApplyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "checkApplyBtn", _local_2, _arg_1));
            };
        }

        public function __inviteBtn_click(_arg_1:MouseEvent):void
        {
            manageBtnClick(_arg_1);
        }

        public function set exitBackBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1900512503exitBackBtn;
            if (_local_2 !== _arg_1)
            {
                this._1900512503exitBackBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exitBackBtn", _local_2, _arg_1));
            };
        }

        private function _AllianceManageView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("邀请加入");
            _local_1 = ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("成员权限");
            _local_1 = (((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("联盟外交");
            _local_1 = ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("转让盟主");
            _local_1 = (officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE);
            _local_1 = Lang.msg("退出联盟");
            _local_1 = (((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.LAST_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("审核申请");
            _local_1 = ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("联盟介绍");
            _local_1 = ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("联盟群发");
            _local_1 = ((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("官员辞职");
            _local_1 = ((((officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)) || (officalLevel == AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE));
            _local_1 = Lang.msg("联盟管理");
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage

