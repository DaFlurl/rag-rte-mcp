// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.FriendArmyInfoDataGrid

package view.module.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.ArmyBean;
    import view.module.info.infoWin.ArmyInfoWin;
    import mx.core.UIComponentDescriptor;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import mx.events.PropertyChangeEvent;
    import mx.managers.PopUpManager;
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

    public class FriendArmyInfoDataGrid extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _FriendArmyInfoDataGrid_DataGrid1:DataGrid;
        public var _FriendArmyInfoDataGrid_DataGridColumn1:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn2:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn3:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn4:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn5:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn6:DataGridColumn;
        public var _FriendArmyInfoDataGrid_DataGridColumn7:DataGridColumn;
        private var _1580403253armyInfoData:ArrayCollection;
        private var armyBean:ArmyBean;
        private var armyInfoWin:ArmyInfoWin;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_FriendArmyInfoDataGrid_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "percentWidth":100,
                                "percentHeight":100,
                                "editable":false,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "rowHeight":36.5,
                                "columns":[_FriendArmyInfoDataGrid_DataGridColumn1_i(), _FriendArmyInfoDataGrid_DataGridColumn2_i(), _FriendArmyInfoDataGrid_DataGridColumn3_i(), _FriendArmyInfoDataGrid_DataGridColumn4_i(), _FriendArmyInfoDataGrid_DataGridColumn5_i(), _FriendArmyInfoDataGrid_DataGridColumn6_i(), _FriendArmyInfoDataGrid_DataGridColumn7_i()]
                            });
                        }
                    })]});
            }
        });
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FriendArmyInfoDataGrid()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FriendArmyInfoDataGrid._watcherSetupUtil = _arg_1;
        }


        private function _FriendArmyInfoDataGrid_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn1 = _local_1;
            _local_1.width = 90;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory1_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn1", _FriendArmyInfoDataGrid_DataGridColumn1);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:FriendArmyInfoDataGrid;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FriendArmyInfoDataGrid_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_FriendArmyInfoDataGridWatcherSetupUtil");
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

        private function _FriendArmyInfoDataGrid_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn5 = _local_1;
            _local_1.width = 110;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory5_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn5", _FriendArmyInfoDataGrid_DataGridColumn5);
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn7 = _local_1;
            _local_1.dataField = "targetPosName";
            _local_1.width = 80;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory7_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn7", _FriendArmyInfoDataGrid_DataGridColumn7);
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.armyInfoData);
            }, function (_arg_1:Object):void
            {
                _FriendArmyInfoDataGrid_DataGrid1.dataProvider = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出征任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn1.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn2.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn3.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("目的地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn4.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("到达时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn5.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn6.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看T");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _FriendArmyInfoDataGrid_DataGridColumn7.headerText = _arg_1;
            }, "_FriendArmyInfoDataGrid_DataGridColumn7.headerText");
            result[7] = binding;
            return (result);
        }

        private function _FriendArmyInfoDataGrid_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn3 = _local_1;
            _local_1.width = 130;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory3_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn3", _FriendArmyInfoDataGrid_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get armyInfoData():ArrayCollection
        {
            return (this._1580403253armyInfoData);
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function _FriendArmyInfoDataGrid_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn2 = _local_1;
            _local_1.width = 80;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory2_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn2", _FriendArmyInfoDataGrid_DataGridColumn2);
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn4 = _local_1;
            _local_1.width = 130;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory4_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn4", _FriendArmyInfoDataGrid_DataGridColumn4);
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _FriendArmyInfoDataGrid_DataGridColumn6 = _local_1;
            _local_1.width = 120;
            _local_1.itemRenderer = _FriendArmyInfoDataGrid_ClassFactory6_c();
            BindingManager.executeBindings(this, "_FriendArmyInfoDataGrid_DataGridColumn6", _FriendArmyInfoDataGrid_DataGridColumn6);
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FriendArmyInfoDataGrid_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function armyView(_arg_1:Object):void
        {
            this.armyBean = (_arg_1 as ArmyBean);
            ArmyInfoWin.show(armyBean);
        }

        private function _FriendArmyInfoDataGrid_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.armyInfoData;
            _local_1 = Lang.msg("出征任务");
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("出发地");
            _local_1 = Lang.msg("目的地");
            _local_1 = Lang.msg("到达时间");
            _local_1 = Lang.msg("剩余时间");
            _local_1 = Lang.msg("查看T");
        }

        private function _FriendArmyInfoDataGrid_ClassFactory7_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FriendArmyInfoDataGrid_inlineComponent7;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set armyInfoData(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1580403253armyInfoData;
            if (_local_2 !== _arg_1)
            {
                this._1580403253armyInfoData = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyInfoData", _local_2, _arg_1));
            };
        }

        public function set lookUpStr(_arg_1:String):void
        {
            var _local_2:Object = this._1120764471lookUpStr;
            if (_local_2 !== _arg_1)
            {
                this._1120764471lookUpStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookUpStr", _local_2, _arg_1));
            };
        }

        public function destroy():void
        {
            if (ArmyInfoWin.instance)
            {
                PopUpManager.removePopUp(ArmyInfoWin.instance);
            };
        }

        public function set dataProvider(_arg_1:ArrayCollection):void
        {
            this.armyInfoData = _arg_1;
        }


    }
}//package view.module.info

