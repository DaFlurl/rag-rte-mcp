// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.InviteMember

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import com.evony.client.action.ActionFactory;
    import mx.core.ClassFactory;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceInviteBeanResponse;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class InviteMember extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1519929921inviteNames:TextInput;
        public var _InviteMember_DataGrid1:DataGrid;
        public var _InviteMember_DataGridColumn1:DataGridColumn;
        public var _InviteMember_DataGridColumn2:DataGridColumn;
        public var _InviteMember_DataGridColumn3:DataGridColumn;
        public var _InviteMember_DataGridColumn4:DataGridColumn;
        public var _InviteMember_DataGridColumn5:DataGridColumn;
        public var _InviteMember_DataGridColumn6:DataGridColumn;
        public var _InviteMember_DataGridColumn7:DataGridColumn;
        public var _InviteMember_Label1:Label;
        public var _InviteMember_Button1:Button;
        public var _InviteMember_Button2:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_InviteMember_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.bottom = "36";
                            this.left = "1";
                            this.right = "1";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_InviteMember_DataGridColumn1_i(), _InviteMember_DataGridColumn2_i(), _InviteMember_DataGridColumn3_i(), _InviteMember_DataGridColumn4_i(), _InviteMember_DataGridColumn5_i(), _InviteMember_DataGridColumn6_i(), _InviteMember_DataGridColumn7_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_InviteMember_Button1",
                        "events":{"click":"___InviteMember_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":616.5,
                                "styleName":"b95",
                                "width":95
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "5";
                            this.verticalAlign = "top";
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_InviteMember_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"inviteNames",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"textInput"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_InviteMember_Button2",
                                    "events":{"click":"___InviteMember_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
        private var _476564823cancelStr:String = Lang.msg("取消");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function InviteMember()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___InviteMember_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            InviteMember._watcherSetupUtil = _arg_1;
        }


        private function _InviteMember_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn3 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn3", _InviteMember_DataGridColumn3);
            return (_local_1);
        }

        public function showMembersMsg(_arg_1:Object):void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().canceladdUsertoAlliance(_arg_1.userName);
        }

        private function _InviteMember_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = InviteMember_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___InviteMember_Button1_click(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        public function set inviteNames(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1519929921inviteNames;
            if (_local_2 !== _arg_1)
            {
                this._1519929921inviteNames = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteNames", _local_2, _arg_1));
            };
        }

        private function inviteIn():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAlliance(inviteNames.text);
        }

        override public function initialize():void
        {
            var target:InviteMember;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _InviteMember_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_InviteMemberWatcherSetupUtil");
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

        private function _InviteMember_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (unionArray);
            }, function (_arg_1:Object):void
            {
                _InviteMember_DataGrid1.dataProvider = _arg_1;
            }, "_InviteMember_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn1.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn2.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn3.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("动态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn4.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("邀请人");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn5.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("邀请时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn6.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_DataGridColumn7.headerText = _arg_1;
            }, "_InviteMember_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_Button1.label = _arg_1;
            }, "_InviteMember_Button1.label");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("输入玩家");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_Label1.text = _arg_1;
            }, "_InviteMember_Label1.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("邀请加入");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _InviteMember_Button2.label = _arg_1;
            }, "_InviteMember_Button2.label");
            result[10] = binding;
            return (result);
        }

        private function onAddUserToAllianceList(_arg_1:AllianceInviteBeanResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                unionArray = _arg_1.allianceAddPlayerInfoBeanListArray;
            }
            else
            {
                AlertWin.show(((_arg_1.errorMsg + "\n") + Lang.msg("玩家列表没有再更新")));
            };
        }

        private function set unionArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1515842358unionArray;
            if (_local_2 !== _arg_1)
            {
                this._1515842358unionArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionArray", _local_2, _arg_1));
            };
        }

        public function set cancelStr(_arg_1:String):void
        {
            var _local_2:Object = this._476564823cancelStr;
            if (_local_2 !== _arg_1)
            {
                this._476564823cancelStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelStr", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELADD_USERTO_ALLIANCE, onCancleAddUserToAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_ADD_USERTO_ALLIANCE, onAddUserToAlliance);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function onCancleAddUserToAlliance(_arg_1:AllianceInviteBeanResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(onAddUserToAllianceList);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _InviteMember_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = unionArray;
            _local_1 = Lang.msg("玩家");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("动态");
            _local_1 = Lang.msg("邀请人");
            _local_1 = Lang.msg("邀请时间");
            _local_1 = Lang.msg("取消");
            _local_1 = Lang.msg("返回");
            _local_1 = Lang.msg("输入玩家");
            _local_1 = Lang.msg("邀请加入");
        }

        private function _InviteMember_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn2 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn2", _InviteMember_DataGridColumn2);
            return (_local_1);
        }

        private function _InviteMember_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn4 = _local_1;
            _local_1.width = 120;
            _local_1.itemRenderer = _InviteMember_ClassFactory1_c();
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn4", _InviteMember_DataGridColumn4);
            return (_local_1);
        }

        private function _InviteMember_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn6 = _local_1;
            _local_1.dataField = "inviteTime";
            _local_1.itemRenderer = _InviteMember_ClassFactory2_c();
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn6", _InviteMember_DataGridColumn6);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get inviteNames():TextInput
        {
            return (this._1519929921inviteNames);
        }

        private function _InviteMember_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = InviteMember_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___InviteMember_Button2_click(_arg_1:MouseEvent):void
        {
            inviteIn();
        }

        private function _InviteMember_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = InviteMember_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get unionArray():ArrayCollection
        {
            return (this._1515842358unionArray);
        }

        [Bindable(event="propertyChange")]
        public function get cancelStr():String
        {
            return (this._476564823cancelStr);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(onAddUserToAllianceList);
        }

        private function onAddUserToAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().addUsertoAllianceList(onAddUserToAllianceList);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function destroy():void
        {
        }

        public function ___InviteMember_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _InviteMember_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn5 = _local_1;
            _local_1.dataField = "invitePerson";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn5", _InviteMember_DataGridColumn5);
            return (_local_1);
        }

        private function _InviteMember_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn7 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 80;
            _local_1.itemRenderer = _InviteMember_ClassFactory3_c();
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn7", _InviteMember_DataGridColumn7);
            return (_local_1);
        }

        private function _InviteMember_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _InviteMember_DataGridColumn1 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_InviteMember_DataGridColumn1", _InviteMember_DataGridColumn1);
            return (_local_1);
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

