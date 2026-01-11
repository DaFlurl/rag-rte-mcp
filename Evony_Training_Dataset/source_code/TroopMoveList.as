// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.TroopMoveList

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import view.module.info.infoWin.ArmyDetailsWin;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import mx.utils.ObjectProxy;
    import mx.core.ClassFactory;
    import mx.managers.PopUpManager;
    import com.evony.Lang;
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

    public class TroopMoveList extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TroopMoveList_DataGridColumn6:DataGridColumn;
        private var _1975970448troopMoves:ArrayCollection;
        private var _1036304098detailText:String;
        public var _TroopMoveList_DataGrid1:DataGrid;
        public var _TroopMoveList_Label1:Label;
        public var _TroopMoveList_Label2:Label;
        private var idNum:int = 0;
        public var _TroopMoveList_DataGridColumn2:DataGridColumn;
        public var _TroopMoveList_DataGridColumn3:DataGridColumn;
        public var _TroopMoveList_DataGridColumn5:DataGridColumn;
        public var _TroopMoveList_DataGridColumn4:DataGridColumn;
        private var _815590653targetPos:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_TroopMoveList_Label1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":9,
                                "y":2
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_TroopMoveList_Label2",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":17
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_TroopMoveList_DataGrid1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":37,
                                "percentWidth":100,
                                "percentHeight":100,
                                "styleName":"style2",
                                "editable":false,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_TroopMoveList_DataGridColumn1_c(), _TroopMoveList_DataGridColumn2_i(), _TroopMoveList_DataGridColumn3_i(), _TroopMoveList_DataGridColumn4_i(), _TroopMoveList_DataGridColumn5_i(), _TroopMoveList_DataGridColumn6_i()]
                            });
                        }
                    })]});
            }
        });
        private var armyDetailsWin:ArmyDetailsWin = new ArmyDetailsWin();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TroopMoveList()
        {
            mx_internal::_document = this;
            this.addEventListener("creationComplete", ___TroopMoveList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TroopMoveList._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get targetPos():String
        {
            return (this._815590653targetPos);
        }

        private function set targetPos(_arg_1:String):void
        {
            var _local_2:Object = this._815590653targetPos;
            if (_local_2 !== _arg_1)
            {
                this._815590653targetPos = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPos", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TroopMoveList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TroopMoveList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_TroopMoveListWatcherSetupUtil");
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

        private function _TroopMoveList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TroopMoveList_DataGridColumn2 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _TroopMoveList_ClassFactory2_c();
            BindingManager.executeBindings(this, "_TroopMoveList_DataGridColumn2", _TroopMoveList_DataGridColumn2);
            return (_local_1);
        }

        private function _TroopMoveList_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TroopMoveList_DataGridColumn4 = _local_1;
            _local_1.dataField = "Dest";
            BindingManager.executeBindings(this, "_TroopMoveList_DataGridColumn4", _TroopMoveList_DataGridColumn4);
            return (_local_1);
        }

        private function _TroopMoveList_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TroopMoveList_DataGridColumn6 = _local_1;
            _local_1.dataField = "title";
            _local_1.width = 80;
            _local_1.itemRenderer = _TroopMoveList_ClassFactory3_c();
            BindingManager.executeBindings(this, "_TroopMoveList_DataGridColumn6", _TroopMoveList_DataGridColumn6);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get detailText():String
        {
            return (this._1036304098detailText);
        }

        private function init():void
        {
            this.refresh();
        }

        private function set troopMoves(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1975970448troopMoves;
            if (_local_2 !== _arg_1)
            {
                this._1975970448troopMoves = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopMoves", _local_2, _arg_1));
            };
        }

        public function setId(_arg_1:ObjectProxy):int
        {
            var _local_2:int;
            while (_local_2 < troopMoves.length)
            {
                if (_arg_1 == this.troopMoves[_local_2])
                {
                    this.idNum = _local_2;
                    break;
                };
                _local_2++;
            };
            return (idNum + 1);
        }

        private function _TroopMoveList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TroopMoveList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _TroopMoveList_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TroopMoveList_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function showDetail(_arg_1:ObjectProxy):void
        {
            this.armyDetailsWin.myArmyBean = _arg_1;
            PopUpManager.addPopUp(this.armyDetailsWin, this.parent, true);
            PopUpManager.centerPopUp(this.armyDetailsWin);
        }

        [Bindable(event="propertyChange")]
        private function get troopMoves():ArrayCollection
        {
            return (this._1975970448troopMoves);
        }

        private function set detailText(_arg_1:String):void
        {
            var _local_2:Object = this._1036304098detailText;
            if (_local_2 !== _arg_1)
            {
                this._1036304098detailText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "detailText", _local_2, _arg_1));
            };
        }

        private function _TroopMoveList_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.width = 60;
            _local_1.itemRenderer = _TroopMoveList_ClassFactory1_c();
            return (_local_1);
        }

        private function _TroopMoveList_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TroopMoveList_DataGridColumn3 = _local_1;
            _local_1.dataField = "Start";
            BindingManager.executeBindings(this, "_TroopMoveList_DataGridColumn3", _TroopMoveList_DataGridColumn3);
            return (_local_1);
        }

        private function refresh():void
        {
            idNum = 0;
        }

        private function _TroopMoveList_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TroopMoveList_DataGridColumn5 = _local_1;
            _local_1.dataField = "ArriveTime";
            BindingManager.executeBindings(this, "_TroopMoveList_DataGridColumn5", _TroopMoveList_DataGridColumn5);
            return (_local_1);
        }

        private function _TroopMoveList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("成功使用蛛丝马迹");
            _local_1 = Lang.msg("蛛丝马迹详情", targetPos);
            _local_1 = this.troopMoves;
            _local_1 = Lang.msg("类型");
            _local_1 = Lang.msg("出发地");
            _local_1 = Lang.msg("目的地");
            _local_1 = Lang.msg("到达时间");
            _local_1 = Lang.msg("查看");
        }

        public function ___TroopMoveList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _TroopMoveList_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TroopMoveList_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _TroopMoveList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("成功使用蛛丝马迹");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_Label1.text = _arg_1;
            }, "_TroopMoveList_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("蛛丝马迹详情", targetPos);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_Label2.text = _arg_1;
            }, "_TroopMoveList_Label2.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.troopMoves);
            }, function (_arg_1:Object):void
            {
                _TroopMoveList_DataGrid1.dataProvider = _arg_1;
            }, "_TroopMoveList_DataGrid1.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("类型");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_DataGridColumn2.headerText = _arg_1;
            }, "_TroopMoveList_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_DataGridColumn3.headerText = _arg_1;
            }, "_TroopMoveList_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("目的地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_DataGridColumn4.headerText = _arg_1;
            }, "_TroopMoveList_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("到达时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_DataGridColumn5.headerText = _arg_1;
            }, "_TroopMoveList_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TroopMoveList_DataGridColumn6.headerText = _arg_1;
            }, "_TroopMoveList_DataGridColumn6.headerText");
            result[7] = binding;
            return (result);
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String):void
        {
            var _local_3:ArrayCollection = new ArrayCollection();
            idNum = 0;
            targetPos = _arg_2;
            troopMoves = null;
            if (_arg_1 != null)
            {
                if ((_arg_1.TroopMove is ArrayCollection))
                {
                    _local_3 = (_arg_1.TroopMove as ArrayCollection);
                }
                else
                {
                    _local_3.addItem(_arg_1.TroopMove);
                };
                troopMoves = _local_3;
            };
        }


    }
}//package view.module.info.reports

