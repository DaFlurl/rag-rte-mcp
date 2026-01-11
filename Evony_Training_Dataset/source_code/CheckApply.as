// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.CheckApply

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import com.evony.client.action.ActionFactory;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceUserAddResponse;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.PropertyChangeEvent;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import flash.events.MouseEvent;
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

    public class CheckApply extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CheckApply_DataGridColumn1:DataGridColumn;
        public var _CheckApply_DataGridColumn2:DataGridColumn;
        public var _CheckApply_DataGridColumn3:DataGridColumn;
        public var _CheckApply_DataGridColumn4:DataGridColumn;
        public var _CheckApply_DataGridColumn5:DataGridColumn;
        public var _CheckApply_DataGridColumn6:DataGridColumn;
        public var _CheckApply_DataGrid1:DataGrid;
        public var _CheckApply_Button1:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "7";
                            this.right = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_CheckApply_Button1",
                                    "events":{"click":"___CheckApply_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "7";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":250,
                                            "styleName":"b135",
                                            "width":135
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_CheckApply_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.borderStyle = "solid";
                            this.bottom = "36";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "percentWidth":100,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_CheckApply_DataGridColumn1_i(), _CheckApply_DataGridColumn2_i(), _CheckApply_DataGridColumn3_i(), _CheckApply_DataGridColumn4_i(), _CheckApply_DataGridColumn5_i(), _CheckApply_DataGridColumn6_i()]
                            });
                        }
                    })]});
            }
        });
        private var _1515842358unionArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CheckApply()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___CheckApply_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CheckApply._watcherSetupUtil = _arg_1;
        }


        private function _CheckApply_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn6 = _local_1;
            _local_1.dataField = "userName";
            _local_1.itemRenderer = _CheckApply_ClassFactory2_c();
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn6", _CheckApply_DataGridColumn6);
            return (_local_1);
        }

        public function showMembersMsg(_arg_1:Object, _arg_2:Boolean):void
        {
            if (_arg_2)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceByLeader(_arg_1.userName);
            }
            else
            {
                ActionFactory.getInstance().getAllianceManagementCommands().cancelagreeComeinAlliance(_arg_1.userName);
            };
        }

        private function _CheckApply_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = CheckApply_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:CheckApply;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CheckApply_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_CheckApplyWatcherSetupUtil");
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

        private function _CheckApply_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("返回");
            _local_1 = unionArray;
            _local_1 = Lang.msg("玩家");
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("城池数");
            _local_1 = Lang.msg("申请时间");
            _local_1 = Lang.msg("操作");
        }

        private function onCancelAgreeComeIn(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onAgreeComeInByLeader(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_LIST, onAgreeComeInAllianceList);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_AGREE_COMEIN_ALLIANCE_BY_LEADER, onAgreeComeInByLeader);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_CANCELAGREE_COMEIN_ALLIANCE, onCancelAgreeComeIn);
            if (this.initialized)
            {
                this.refresh();
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

        private function onGoBack():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        private function _CheckApply_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn1 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 120;
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn1", _CheckApply_DataGridColumn1);
            return (_local_1);
        }

        private function _CheckApply_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn3 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn3", _CheckApply_DataGridColumn3);
            return (_local_1);
        }

        private function _CheckApply_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn5 = _local_1;
            _local_1.dataField = "inviteTime";
            _local_1.width = 120;
            _local_1.itemRenderer = _CheckApply_ClassFactory1_c();
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn5", _CheckApply_DataGridColumn5);
            return (_local_1);
        }

        private function _CheckApply_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = CheckApply_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function onAgreeComeInAllianceList(_arg_1:AllianceUserAddResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _unionArray = _arg_1.allianceAddPlayerByUserInfoBeanListArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___CheckApply_Button1_click(_arg_1:MouseEvent):void
        {
            onGoBack();
        }

        public function set _unionArray(_arg_1:ArrayCollection):void
        {
            unionArray = _arg_1;
        }

        private function _CheckApply_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_Button1.label = _arg_1;
            }, "_CheckApply_Button1.label");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (unionArray);
            }, function (_arg_1:Object):void
            {
                _CheckApply_DataGrid1.dataProvider = _arg_1;
            }, "_CheckApply_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("玩家");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn1.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn2.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn3.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn4.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("申请时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn5.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("操作");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CheckApply_DataGridColumn6.headerText = _arg_1;
            }, "_CheckApply_DataGridColumn6.headerText");
            result[7] = binding;
            return (result);
        }

        public function ___CheckApply_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get unionArray():ArrayCollection
        {
            return (this._1515842358unionArray);
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().agreeComeinAllianceList();
        }

        public function destroy():void
        {
        }

        private function _CheckApply_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn2 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn2", _CheckApply_DataGridColumn2);
            return (_local_1);
        }

        private function _CheckApply_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CheckApply_DataGridColumn4 = _local_1;
            _local_1.dataField = "castleCount";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_CheckApply_DataGridColumn4", _CheckApply_DataGridColumn4);
            return (_local_1);
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

