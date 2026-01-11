// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AllConstruction

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.common.server.events.BuildComplate;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import com.evony.common.beans.BuildingBean;
    import com.evony.util.UIUtil;
    import com.evony.eum.BuildingEumDefine;
    import mx.binding.BindingManager;
    import mx.core.ClassFactory;
    import mx.events.ListEvent;
    import com.evony.Context;
    import flash.events.MouseEvent;
    import com.evony.events.EnterCastleEvent;
    import view.castle.building.BuildingSpace;
    import com.evony.common.constants.BuildingConstants;
    import view.castle.TownView;
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
    import view.module.tavern.*;
    import view.module.trainningField.*;
    import flash.xml.*;
    import view.module.barrack.*;
    import view.module.embassy.*;
    import view.module.herosMansion.*;
    import view.module.technology.*;
    import view.module.wall.*;
    import flash.ui.*;
    import flash.net.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AllConstruction extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1386533882builtInDG:DataGrid;
        private var _27081613builtOutDG:DataGrid;
        public var _AllConstruction_DataGridColumn1:DataGridColumn;
        public var _AllConstruction_DataGridColumn2:DataGridColumn;
        public var _AllConstruction_DataGridColumn3:DataGridColumn;
        public var _AllConstruction_DataGridColumn4:DataGridColumn;
        public var _AllConstruction_DataGridColumn5:DataGridColumn;
        public var _AllConstruction_DataGridColumn6:DataGridColumn;
        private var _691506344curCastle:CastleBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                            this.left = "0";
                            this.top = "0";
                            this.right = "0";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"builtOutDG",
                                    "events":{"itemClick":"__builtOutDG_itemClick"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "percentHeight":100,
                                            "rowHeight":28.1,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "columns":[_AllConstruction_DataGridColumn1_i(), _AllConstruction_DataGridColumn2_i(), _AllConstruction_DataGridColumn3_i()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"builtInDG",
                                    "events":{"itemClick":"__builtInDG_itemClick"},
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "percentHeight":100,
                                            "rowHeight":28.1,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "columns":[_AllConstruction_DataGridColumn4_i(), _AllConstruction_DataGridColumn5_i(), _AllConstruction_DataGridColumn6_i()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _649826311buildingOutArr:ArrayCollection = new ArrayCollection();
        private var _400477016buildingInArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllConstruction()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 1;
            };
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.styleName = "baseBackGround";
            this.addEventListener("creationComplete", ___AllConstruction_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllConstruction._watcherSetupUtil = _arg_1;
        }


        private function _AllConstruction_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (buildingOutArr);
            }, function (_arg_1:Object):void
            {
                builtOutDG.dataProvider = _arg_1;
            }, "builtOutDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城外建筑");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn1.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn2.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn3.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (buildingInArr);
            }, function (_arg_1:Object):void
            {
                builtInDG.dataProvider = _arg_1;
            }, "builtInDG.dataProvider");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城内建筑");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn4.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn5.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllConstruction_DataGridColumn6.headerText = _arg_1;
            }, "_AllConstruction_DataGridColumn6.headerText");
            result[7] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get buildingOutArr():ArrayCollection
        {
            return (this._649826311buildingOutArr);
        }

        private function onBuildingComplete(_arg_1:BuildComplate):void
        {
            trace((this.className + ".onBuildingComplete()"));
            this.setArr();
        }

        [Bindable(event="propertyChange")]
        public function get builtInDG():DataGrid
        {
            return (this._1386533882builtInDG);
        }

        private function set buildingOutArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._649826311buildingOutArr;
            if (_local_2 !== _arg_1)
            {
                this._649826311buildingOutArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingOutArr", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AllConstruction;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllConstruction_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AllConstructionWatcherSetupUtil");
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

        public function set builtInDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1386533882builtInDG;
            if (_local_2 !== _arg_1)
            {
                this._1386533882builtInDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "builtInDG", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            trace((this.className + ".init()"));
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onBuildingComplete);
        }

        private function _AllConstruction_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = buildingOutArr;
            _local_1 = Lang.msg("城外建筑");
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("等级");
            _local_1 = buildingInArr;
            _local_1 = Lang.msg("城内建筑");
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("等级");
        }

        [Bindable(event="propertyChange")]
        private function get buildingInArr():ArrayCollection
        {
            return (this._400477016buildingInArr);
        }

        public function ___AllConstruction_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function setArr():void
        {
            var _local_4:BuildingBean;
            buildingOutArr.removeAll();
            buildingInArr.removeAll();
            trace(("长度：" + this.curCastle.buildingsArray.length));
            var _local_1:int;
            var _local_2:int;
            var _local_3:int;
            while (_local_3 < this.curCastle.buildingsArray.length)
            {
                _local_4 = this.curCastle.getBuildings(_local_3);
                if (UIUtil.isInnerBuilding(_local_4.positionId))
                {
                    _local_1++;
                    buildingInArr.addItem({
                        "id":_local_4.positionId,
                        "typeName":BuildingEumDefine.getName(_local_4.typeId),
                        "state":stateTpye(_local_4.status),
                        "level":_local_4.level,
                        "myBuilding":_local_4
                    });
                }
                else
                {
                    _local_2++;
                    buildingOutArr.addItem({
                        "id":_local_4.positionId,
                        "typeName":BuildingEumDefine.getName(_local_4.typeId),
                        "state":stateTpye(_local_4.status),
                        "level":_local_4.level,
                        "myBuilding":_local_4
                    });
                };
                _local_3++;
            };
            builtInDG.rowCount = _local_1;
            builtOutDG.rowCount = _local_2;
        }

        private function set curCastle(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._691506344curCastle;
            if (_local_2 !== _arg_1)
            {
                this._691506344curCastle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curCastle", _local_2, _arg_1));
            };
        }

        private function _AllConstruction_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn2 = _local_1;
            _local_1.dataField = "state";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn2", _AllConstruction_DataGridColumn2);
            return (_local_1);
        }

        private function _AllConstruction_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn6 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 50;
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn6", _AllConstruction_DataGridColumn6);
            return (_local_1);
        }

        private function _AllConstruction_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllConstruction_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function stateTpye(_arg_1:int):String
        {
            var _local_2:String;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = Lang.msg("正常");
                    break;
                case 1:
                    _local_2 = Lang.msg("升级中");
                    break;
                case 2:
                    _local_2 = Lang.msg("拆除中");
                    break;
            };
            return (_local_2);
        }

        private function _AllConstruction_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn4 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.itemRenderer = _AllConstruction_ClassFactory2_c();
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn4", _AllConstruction_DataGridColumn4);
            return (_local_1);
        }

        public function __builtOutDG_itemClick(_arg_1:ListEvent):void
        {
            buildingView(_arg_1);
        }

        private function set buildingInArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._400477016buildingInArr;
            if (_local_2 !== _arg_1)
            {
                this._400477016buildingInArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingInArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        public function refresh():void
        {
            trace((this.className + ".refresh()"));
            this.curCastle = Context.getInstance().getCurCastle();
            this.setArr();
        }

        public function __builtInDG_itemClick(_arg_1:ListEvent):void
        {
            buildingView(_arg_1);
        }

        private function rebackHandle(_arg_1:MouseEvent):void
        {
            if (this.parent != null)
            {
                this.parentDocument.officeViewstack.selectedChild = this.parentDocument.constructionView;
            };
        }

        public function set builtOutDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._27081613builtOutDG;
            if (_local_2 !== _arg_1)
            {
                this._27081613builtOutDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "builtOutDG", _local_2, _arg_1));
            };
        }

        private function _AllConstruction_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.itemRenderer = _AllConstruction_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn1", _AllConstruction_DataGridColumn1);
            return (_local_1);
        }

        private function _AllConstruction_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn3 = _local_1;
            _local_1.dataField = "level";
            _local_1.width = 50;
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn3", _AllConstruction_DataGridColumn3);
            return (_local_1);
        }

        private function _AllConstruction_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllConstruction_DataGridColumn5 = _local_1;
            _local_1.dataField = "state";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_AllConstruction_DataGridColumn5", _AllConstruction_DataGridColumn5);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get builtOutDG():DataGrid
        {
            return (this._27081613builtOutDG);
        }

        private function _AllConstruction_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllConstruction_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function buildingView(_arg_1:ListEvent):void
        {
            var _local_2:BuildingBean;
            var _local_3:BuildingBean;
            var _local_4:BuildingBean;
            if (_arg_1.itemRenderer.data.myBuilding)
            {
                _local_2 = _arg_1.itemRenderer.data.myBuilding;
                if (!UIUtil.isInnerBuilding(_local_2.positionId))
                {
                    EnterCastleEvent.enterCastle(false);
                    _local_3 = Context.getInstance().getBuildingObjByPosision(_local_2.positionId);
                    if (_local_3 != null)
                    {
                        BuildingSpace.showBuildingWindows(_local_3);
                    };
                }
                else
                {
                    _local_4 = Context.getInstance().getBuildingObjByPosision(_local_2.positionId);
                    if (_local_4 != null)
                    {
                        BuildingSpace.showBuildingWindows(_local_4);
                    }
                    else
                    {
                        if (_local_2.typeId != BuildingConstants.TYPE_TOWN_HALL)
                        {
                            if (_local_2.typeId == BuildingConstants.TYPE_WALL)
                            {
                                if (TownView.singleton() != null)
                                {
                                    BuildingSpace.showBuildingWindows(_local_4);
                                };
                            };
                        };
                    };
                };
            };
        }


    }
}//package view.module.office

