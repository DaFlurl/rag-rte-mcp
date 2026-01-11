// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.EnemyInfoDataGrid

package view.module.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.containers.HBox;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import com.evony.common.beans.ArmyBean;
    import mx.core.UIComponentDescriptor;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.core.ClassFactory;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import flash.events.MouseEvent;
    import view.module.info.infoWin.ArmyInfoWin;
    import com.evony.MsgDispacther;
    import flash.events.Event;
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

    public class EnemyInfoDataGrid extends Canvas implements IBindingClient 
    {

        public static var ignoreList:Array = [];
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _EnemyInfoDataGrid_DataGridColumn4:DataGridColumn;
        public var _EnemyInfoDataGrid_DataGridColumn1:DataGridColumn;
        private var _1655129717selectpage:HBox;
        private var _1788676624dataGrid:DataGrid;
        private var pageSize:int = 10;
        public var _EnemyInfoDataGrid_Label1:Label;
        private var _577409037totalPage:int = 0;
        private var _1125923055curPage:int = 1;
        private var armyBean:ArmyBean;
        public var _EnemyInfoDataGrid_DataGridColumn2:DataGridColumn;
        public var _EnemyInfoDataGrid_DataGridColumn3:DataGridColumn;
        public var _EnemyInfoDataGrid_DataGridColumn6:DataGridColumn;
        public var _EnemyInfoDataGrid_DataGridColumn7:DataGridColumn;
        public var _EnemyInfoDataGrid_DataGridColumn5:DataGridColumn;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"selectpage",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "right";
                                        this.right = "0";
                                        this.verticalAlign = "middle";
                                        this.top = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":174,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___EnemyInfoDataGrid_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_EnemyInfoDataGrid_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"ftp14f"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___EnemyInfoDataGrid_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"dataGrid",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.bottom = "0";
                                        this.top = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "styleName":"style2",
                                            "editable":false,
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "selectable":false,
                                            "rowHeight":36.5,
                                            "columns":[_EnemyInfoDataGrid_DataGridColumn1_i(), _EnemyInfoDataGrid_DataGridColumn2_i(), _EnemyInfoDataGrid_DataGridColumn3_i(), _EnemyInfoDataGrid_DataGridColumn4_i(), _EnemyInfoDataGrid_DataGridColumn5_i(), _EnemyInfoDataGrid_DataGridColumn6_i(), _EnemyInfoDataGrid_DataGridColumn7_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1580403253armyInfoData:ArrayCollection = new ArrayCollection();
        private var TotalPageList:ArrayCollection = new ArrayCollection();
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function EnemyInfoDataGrid()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            EnemyInfoDataGrid._watcherSetupUtil = _arg_1;
        }


        private function _EnemyInfoDataGrid_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (!(this.totalPage == 0));
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = this.armyInfoData;
            _local_1 = Lang.msg("忽略");
            _local_1 = Lang.msg("君主");
            _local_1 = Lang.msg("出发地");
            _local_1 = Lang.msg("目的地");
            _local_1 = Lang.msg("到达时间");
            _local_1 = Lang.msg("剩余时间");
            _local_1 = Lang.msg("查看T");
        }

        private function _EnemyInfoDataGrid_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get selectpage():HBox
        {
            return (this._1655129717selectpage);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        override public function initialize():void
        {
            var target:EnemyInfoDataGrid;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _EnemyInfoDataGrid_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_EnemyInfoDataGridWatcherSetupUtil");
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

        private function _EnemyInfoDataGrid_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn1 = _local_1;
            _local_1.width = 60;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory1_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn1", _EnemyInfoDataGrid_DataGridColumn1);
            return (_local_1);
        }

        private function _EnemyInfoDataGrid_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn3 = _local_1;
            _local_1.width = 130;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory3_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn3", _EnemyInfoDataGrid_DataGridColumn3);
            return (_local_1);
        }

        public function set dataGrid(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1788676624dataGrid;
            if (_local_2 !== _arg_1)
            {
                this._1788676624dataGrid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataGrid", _local_2, _arg_1));
            };
        }

        private function _EnemyInfoDataGrid_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn5 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory5_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn5", _EnemyInfoDataGrid_DataGridColumn5);
            return (_local_1);
        }

        private function _EnemyInfoDataGrid_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn7 = _local_1;
            _local_1.dataField = "targetPosName";
            _local_1.width = 80;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory7_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn7", _EnemyInfoDataGrid_DataGridColumn7);
            return (_local_1);
        }

        public function set selectpage(_arg_1:HBox):void
        {
            var _local_2:Object = this._1655129717selectpage;
            if (_local_2 !== _arg_1)
            {
                this._1655129717selectpage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectpage", _local_2, _arg_1));
            };
        }

        private function _EnemyInfoDataGrid_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.getnewPage();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        private function _EnemyInfoDataGrid_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _EnemyInfoDataGrid_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___EnemyInfoDataGrid_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        [Bindable(event="propertyChange")]
        public function get dataGrid():DataGrid
        {
            return (this._1788676624dataGrid);
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

        private function _EnemyInfoDataGrid_ClassFactory7_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent7;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function getnewPage():void
        {
            var _local_3:ArmyBean;
            var _local_4:int;
            this.armyInfoData.removeAll();
            var _local_1:int = ((this.curPage - 1) * this.pageSize);
            while (_local_1 < (this.curPage * this.pageSize))
            {
                if (_local_1 < this.TotalPageList.length)
                {
                    _local_3 = (this.TotalPageList[_local_1] as ArmyBean);
                    if (_local_3 != null)
                    {
                        this.armyInfoData.addItem(this.TotalPageList[_local_1]);
                    };
                };
                _local_1++;
            };
            var _local_2:int;
            while (_local_2 < armyInfoData.length)
            {
                _local_4 = 0;
                while (_local_4 < EnemyInfoDataGrid.ignoreList.length)
                {
                    if (armyInfoData[_local_2].armyId == EnemyInfoDataGrid.ignoreList[_local_4])
                    {
                        armyInfoData[_local_2].selected = true;
                    };
                    _local_4++;
                };
                _local_2++;
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyInfoData():ArrayCollection
        {
            return (this._1580403253armyInfoData);
        }

        private function _EnemyInfoDataGrid_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.totalPage == 0));
            }, function (_arg_1:Boolean):void
            {
                selectpage.visible = _arg_1;
            }, "selectpage.visible");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_Label1.text = _arg_1;
            }, "_EnemyInfoDataGrid_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.armyInfoData);
            }, function (_arg_1:Object):void
            {
                dataGrid.dataProvider = _arg_1;
            }, "dataGrid.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("忽略");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn1.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("君主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn2.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn3.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("目的地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn4.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("到达时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn5.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn5.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn6.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn6.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看T");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _EnemyInfoDataGrid_DataGridColumn7.headerText = _arg_1;
            }, "_EnemyInfoDataGrid_DataGridColumn7.headerText");
            result[9] = binding;
            return (result);
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

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function _EnemyInfoDataGrid_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn2 = _local_1;
            _local_1.width = 80;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory2_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn2", _EnemyInfoDataGrid_DataGridColumn2);
            return (_local_1);
        }

        public function armyView(_arg_1:Object):void
        {
            this.armyBean = (_arg_1 as ArmyBean);
            ArmyInfoWin.show(armyBean);
        }

        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        public function changeIgnoreList(_arg_1:Object):void
        {
            var _local_2:ArmyBean = (_arg_1 as ArmyBean);
            _local_2.selected = (!(_local_2.selected));
            MsgDispacther.getInstance().dispatchEvent(new Event("CheckEnemy"));
        }

        private function _EnemyInfoDataGrid_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn6 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory6_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn6", _EnemyInfoDataGrid_DataGridColumn6);
            return (_local_1);
        }

        private function _EnemyInfoDataGrid_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _EnemyInfoDataGrid_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _EnemyInfoDataGrid_DataGridColumn4 = _local_1;
            _local_1.width = 130;
            _local_1.itemRenderer = _EnemyInfoDataGrid_ClassFactory4_c();
            BindingManager.executeBindings(this, "_EnemyInfoDataGrid_DataGridColumn4", _EnemyInfoDataGrid_DataGridColumn4);
            return (_local_1);
        }

        public function ___EnemyInfoDataGrid_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        public function set dataProvider(_arg_1:ArrayCollection):void
        {
            var _local_3:int;
            var _local_4:int;
            this.TotalPageList.removeAll();
            this.TotalPageList = _arg_1;
            if (this.TotalPageList.length <= this.pageSize)
            {
                armyInfoData = this.TotalPageList;
            }
            else
            {
                _local_3 = 0;
                while (_local_3 < this.pageSize)
                {
                    armyInfoData.addItem(this.TotalPageList[_local_3]);
                    _local_3++;
                };
            };
            this.totalPage = Math.ceil((this.TotalPageList.length / this.pageSize));
            if (this.totalPage == 0)
            {
                selectpage.visible = false;
            }
            else
            {
                selectpage.visible = true;
            };
            var _local_2:int;
            while (_local_2 < armyInfoData.length)
            {
                _local_4 = 0;
                while (_local_4 < EnemyInfoDataGrid.ignoreList.length)
                {
                    if (armyInfoData[_local_2].armyId == EnemyInfoDataGrid.ignoreList[_local_4])
                    {
                        armyInfoData[_local_2].selected = true;
                    };
                    _local_4++;
                };
                _local_2++;
            };
        }

        public function destroy():void
        {
            if (ArmyInfoWin.instance)
            {
                PopUpManager.removePopUp(ArmyInfoWin.instance);
            };
        }

        private function _EnemyInfoDataGrid_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = EnemyInfoDataGrid_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }


    }
}//package view.module.info

