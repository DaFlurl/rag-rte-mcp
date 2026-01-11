// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceMember.AllianceRetire

package view.module.alliance.oldAlliance.allianceMember
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.common.constants.AllianceConstants;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
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

    public class AllianceRetire extends Canvas implements IBindingClient 
    {

        public static var instance:AllianceRetire;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceRetire_Label2:Label;
        private var _1693934272retireMemberName:TextInput;
        public var _AllianceRetire_Button1:Button;
        public var _AllianceRetire_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
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
                                    "id":"_AllianceRetire_Label1",
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
                        "type":Label,
                        "id":"_AllianceRetire_Label2",
                        "stylesFactory":function ():void
                        {
                            this.top = "70";
                            this.left = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":285,
                                "selectable":false,
                                "styleName":"PropertyName1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"retireMemberName",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "60";
                            this.left = "25";
                            this.right = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"textInput"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_AllianceRetire_Button1",
                        "events":{"click":"___AllianceRetire_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "20";
                            this.right = "25";
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
                        "events":{"click":"___AllianceRetire_Button2_click"},
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
        private var membersArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceRetire()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 200;
            this.addEventListener("creationComplete", ___AllianceRetire_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceRetire._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:ArrayCollection):void
        {
            if (instance == null)
            {
                instance = new (AllianceRetire)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.membersArray = _arg_1;
        }


        private function _AllianceRetire_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开除成员");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceRetire_Label1.text = _arg_1;
            }, "_AllianceRetire_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("输入要开除的成员名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceRetire_Label2.text = _arg_1;
            }, "_AllianceRetire_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceRetire_Button1.label = _arg_1;
            }, "_AllianceRetire_Button1.label");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get retireMemberName():TextInput
        {
            return (this._1693934272retireMemberName);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_KICK_OUT_MEMBERFROM_ALLIANCE, onKickOutMemberFromAlliance);
        }

        private function submitRetire():void
        {
            var _local_2:PlayerInfoBean;
            var _local_1:int;
            while (_local_1 < membersArray.length)
            {
                _local_2 = (membersArray[_local_1] as PlayerInfoBean);
                if (_local_2.userName == retireMemberName.text)
                {
                    if (_local_2.levelId != AllianceConstants.LAST_POWER_FOR_ALLIANCE)
                    {
                        AlertWin.show(Lang.msg("玩家是有职位的确定删除"), onClickOk);
                    }
                    else
                    {
                        ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(retireMemberName.text);
                    };
                    return;
                };
                if (_local_1 >= (membersArray.length - 1))
                {
                    AlertWin.show(Lang.msg("联盟中没有该成员"));
                };
                _local_1++;
            };
        }

        override public function initialize():void
        {
            var target:AllianceRetire;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceRetire_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceMember_AllianceRetireWatcherSetupUtil");
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

        public function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function onKickOutMemberFromAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("开除成员成功"));
                MinePopupManager.instance.removePopup();
                ActionFactory.getInstance().getAllianceCommands().getAllianceMembers();
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
                ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(retireMemberName.text);
            };
        }

        private function _AllianceRetire_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("开除成员");
            _local_1 = Lang.msg("输入要开除的成员名称");
            _local_1 = Lang.msg("确定");
        }

        public function ___AllianceRetire_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set retireMemberName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1693934272retireMemberName;
            if (_local_2 !== _arg_1)
            {
                this._1693934272retireMemberName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "retireMemberName", _local_2, _arg_1));
            };
        }

        public function ___AllianceRetire_Button1_click(_arg_1:MouseEvent):void
        {
            submitRetire();
        }

        public function ___AllianceRetire_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }


    }
}//package view.module.alliance.oldAlliance.allianceMember

