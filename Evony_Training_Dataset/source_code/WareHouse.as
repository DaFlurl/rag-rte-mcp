// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.warehouse.WareHouse

package view.module.warehouse
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.NumericStepper;
    import com.evony.common.beans.CastleBean;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import com.evony.common.beans.StoreBean;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import view.AllWindows;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.server.events.BuildComplate;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.BindingManager;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import mx.events.NumericStepperEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.city.StoreListResponse;
    import mx.events.FlexEvent;
    import com.evony.Context;
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

    public class WareHouse extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "WareHouse.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _WareHouse_DataGridColumn1:DataGridColumn;
        public var _WareHouse_DataGridColumn2:DataGridColumn;
        public var _WareHouse_DataGridColumn3:DataGridColumn;
        public var _WareHouse_DataGridColumn4:DataGridColumn;
        public var _WareHouse_DataGridColumn5:DataGridColumn;
        public var _WareHouse_DataGridColumn6:DataGridColumn;
        public var _WareHouse_DataGridColumn7:DataGridColumn;
        private var _1884390166stoneNS:NumericStepper;
        private var _691506344curCastle:CastleBean;
        private var _1715963282idleSpace:int;
        private var _782182094woodNS:NumericStepper;
        private var _1180210035ironNS:NumericStepper;
        public var _WareHouse_Label1:Label;
        public var _WareHouse_Label2:Label;
        public var _WareHouse_Label3:Label;
        public var _WareHouse_Label4:Label;
        public var _WareHouse_Label5:Label;
        public var _WareHouse_Label6:Label;
        private var _1900602558modifyBtn:Button;
        private var _994230755wareHouseNum:int;
        private var _1884274053storage:int;
        private var _1268877661foodNS:NumericStepper;
        private var _861252867fieldDG:DataGrid;
        private var maxNumber:int = 100;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"fieldDG",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.verticalAlign = "middle";
                            this.left = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "rowHeight":33,
                                "y":0,
                                "enabled":false,
                                "resizableColumns":false,
                                "verticalScrollPolicy":"off",
                                "columns":[_WareHouse_DataGridColumn1_i(), _WareHouse_DataGridColumn2_i(), _WareHouse_DataGridColumn3_i(), _WareHouse_DataGridColumn4_i(), _WareHouse_DataGridColumn5_i(), _WareHouse_DataGridColumn6_i(), _WareHouse_DataGridColumn7_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"modifyBtn",
                        "events":{"click":"__modifyBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.bottom = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"y125"});
                        }
                    }), new UIComponentDescriptor({
                        "type":NumericStepper,
                        "id":"foodNS",
                        "events":{"change":"__foodNS_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "436";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":29,
                                "width":108,
                                "styleName":"normal",
                                "maximum":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":NumericStepper,
                        "id":"woodNS",
                        "events":{"change":"__woodNS_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "436";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":62,
                                "width":108,
                                "styleName":"normal",
                                "maximum":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":NumericStepper,
                        "id":"stoneNS",
                        "events":{"change":"__stoneNS_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "436";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":95,
                                "width":108,
                                "styleName":"normal",
                                "maximum":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":NumericStepper,
                        "id":"ironNS",
                        "events":{"change":"__ironNS_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "436";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":128,
                                "width":108,
                                "styleName":"normal",
                                "maximum":100,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "center";
                            this.verticalAlign = "middle";
                            this.bottom = "58";
                            this.borderStyle = "solid";
                            this.horizontalGap = 0;
                            this.backgroundColor = 11590641;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":753,
                                "height":35,
                                "x":0,
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.color = 270910;
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.color = 0x129A00;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"commonGoodColor"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.color = 270910;
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.color = 0x129A00;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"commonGoodColor",
                                            "width":78
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "right";
                                        this.color = 270910;
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_WareHouse_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.color = 0x129A00;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"commonGoodColor"});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _378942766foodBean:WareHouseBean = new WareHouseBean();
        private var foodStoreBean:StoreBean = new StoreBean();
        private var _58052611woodBean:WareHouseBean = new WareHouseBean();
        private var woodStoreBean:StoreBean = new StoreBean();
        private var _1576912309stoneBean:WareHouseBean = new WareHouseBean();
        private var stoneStoreBean:StoreBean = new StoreBean();
        private var _310814568ironBean:WareHouseBean = new WareHouseBean();
        private var ironStoreBean:StoreBean = new StoreBean();
        private var _1443166807dataArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function WareHouse()
        {
            mx_internal::_document = this;
            this.percentHeight = 100;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___WareHouse_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WareHouse._watcherSetupUtil = _arg_1;
        }


        public function set fieldDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._861252867fieldDG;
            if (_local_2 !== _arg_1)
            {
                this._861252867fieldDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldDG", _local_2, _arg_1));
            };
        }

        private function onBuildingComplete(_arg_1:BuildComplate):void
        {
            if (((_arg_1.buildingBean.typeId == BuildingConstants.TYPE_WAREHOUSE) && (AllWindows.instance.visible == true)))
            {
                ActionFactory.getInstance().getCityCommands().getStoreList(this.curCastle.id);
            };
        }

        private function set storage(_arg_1:int):void
        {
            var _local_2:Object = this._1884274053storage;
            if (_local_2 !== _arg_1)
            {
                this._1884274053storage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "storage", _local_2, _arg_1));
            };
        }

        public function set ironNS(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._1180210035ironNS;
            if (_local_2 !== _arg_1)
            {
                this._1180210035ironNS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironNS", _local_2, _arg_1));
            };
        }

        private function set woodBean(_arg_1:WareHouseBean):void
        {
            var _local_2:Object = this._58052611woodBean;
            if (_local_2 !== _arg_1)
            {
                this._58052611woodBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodBean", _local_2, _arg_1));
            };
        }

        public function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CITY_GET_STORE_LIST, getStoreListResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CITY_MODIFY_STORE_PERCENT, modifyStorePercentResponse);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onBuildingComplete);
        }

        private function set idleSpace(_arg_1:int):void
        {
            var _local_2:Object = this._1715963282idleSpace;
            if (_local_2 !== _arg_1)
            {
                this._1715963282idleSpace = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "idleSpace", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get foodBean():WareHouseBean
        {
            return (this._378942766foodBean);
        }

        private function set ironBean(_arg_1:WareHouseBean):void
        {
            var _local_2:Object = this._310814568ironBean;
            if (_local_2 !== _arg_1)
            {
                this._310814568ironBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ironBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get woodNS():NumericStepper
        {
            return (this._782182094woodNS);
        }

        [Bindable(event="propertyChange")]
        public function get fieldDG():DataGrid
        {
            return (this._861252867fieldDG);
        }

        private function _WareHouse_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn4 = _local_1;
            _local_1.dataField = "storage";
            _local_1.width = 120;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn4", _WareHouse_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get woodBean():WareHouseBean
        {
            return (this._58052611woodBean);
        }

        public function set foodNS(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._1268877661foodNS;
            if (_local_2 !== _arg_1)
            {
                this._1268877661foodNS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodNS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataArr():ArrayCollection
        {
            return (this._1443166807dataArr);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        private function getWareHouseNum():int
        {
            var _local_3:BuildingBean;
            var _local_1:int;
            var _local_2:int;
            while (_local_2 < this.curCastle.buildingsArray.length)
            {
                _local_3 = this.curCastle.getBuildings(_local_2);
                if (_local_3.typeId == BuildingConstants.TYPE_WAREHOUSE)
                {
                    _local_1++;
                };
                _local_2++;
            };
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get modifyBtn():Button
        {
            return (this._1900602558modifyBtn);
        }

        private function set foodBean(_arg_1:WareHouseBean):void
        {
            var _local_2:Object = this._378942766foodBean;
            if (_local_2 !== _arg_1)
            {
                this._378942766foodBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "foodBean", _local_2, _arg_1));
            };
        }

        private function modifyStorePercentResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功修改仓库存储容量"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function set stoneBean(_arg_1:WareHouseBean):void
        {
            var _local_2:Object = this._1576912309stoneBean;
            if (_local_2 !== _arg_1)
            {
                this._1576912309stoneBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneBean", _local_2, _arg_1));
            };
        }

        public function __modifyBtn_click(_arg_1:MouseEvent):void
        {
            modifyHandle(_arg_1);
        }

        private function addDataArr():void
        {
            this.dataArr.removeAll();
            this.dataArr.addItem(this.foodBean);
            this.dataArr.addItem(this.woodBean);
            this.dataArr.addItem(this.stoneBean);
            this.dataArr.addItem(this.ironBean);
            this.idleSpace = ((((this.storage - this.foodBean.storage) - this.woodBean.storage) - this.stoneBean.storage) - this.ironBean.storage);
            this.maxNumber = ((((100 - this.foodBean.storePercent) - this.woodBean.storePercent) - this.stoneBean.storePercent) - this.ironBean.storePercent);
        }

        private function _WareHouse_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn7 = _local_1;
            _local_1.dataField = "unStock";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn7", _WareHouse_DataGridColumn7);
            return (_local_1);
        }

        private function modifyHandle(_arg_1:MouseEvent):void
        {
            ActionFactory.getInstance().getCityCommands().modifyStorePercent(this.curCastle.id, this.foodNS.value, this.woodNS.value, this.stoneNS.value, this.ironNS.value);
        }

        private function _WareHouse_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn3 = _local_1;
            _local_1.dataField = "resLimt";
            _local_1.width = 120;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn3", _WareHouse_DataGridColumn3);
            return (_local_1);
        }

        public function __woodNS_change(_arg_1:NumericStepperEvent):void
        {
            eventChange(_arg_1);
        }

        public function __stoneNS_change(_arg_1:NumericStepperEvent):void
        {
            eventChange(_arg_1);
        }

        public function set woodNS(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._782182094woodNS;
            if (_local_2 !== _arg_1)
            {
                this._782182094woodNS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "woodNS", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get ironNS():NumericStepper
        {
            return (this._1180210035ironNS);
        }

        override public function initialize():void
        {
            var target:WareHouse;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _WareHouse_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_warehouse_WareHouseWatcherSetupUtil");
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

        public function set modifyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1900602558modifyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1900602558modifyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "modifyBtn", _local_2, _arg_1));
            };
        }

        private function _WareHouse_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.dataArr);
            }, function (_arg_1:Object):void
            {
                fieldDG.dataProvider = _arg_1;
            }, "fieldDG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn1.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn2.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源上限");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn3.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("仓库容量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn4.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("存放比例");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn5.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("入库");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn6.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("未入库");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_DataGridColumn7.headerText = _arg_1;
            }, "_WareHouse_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("修改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                modifyBtn.label = _arg_1;
            }, "modifyBtn.label");
            result[8] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.foodBean.storePercent);
            }, function (_arg_1:Number):void
            {
                foodNS.value = _arg_1;
            }, "foodNS.value");
            result[9] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.woodBean.storePercent);
            }, function (_arg_1:Number):void
            {
                woodNS.value = _arg_1;
            }, "woodNS.value");
            result[10] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.stoneBean.storePercent);
            }, function (_arg_1:Number):void
            {
                stoneNS.value = _arg_1;
            }, "stoneNS.value");
            result[11] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this.ironBean.storePercent);
            }, function (_arg_1:Number):void
            {
                ironNS.value = _arg_1;
            }, "ironNS.value");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("共有仓库") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label1.text = _arg_1;
            }, "_WareHouse_Label1.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = wareHouseNum;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label2.text = _arg_1;
            }, "_WareHouse_Label2.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("总容量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label3.text = _arg_1;
            }, "_WareHouse_Label3.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = storage;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label4.text = _arg_1;
            }, "_WareHouse_Label4.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("闲置空间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label5.text = _arg_1;
            }, "_WareHouse_Label5.text");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((idleSpace >= 0) ? idleSpace : 0);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WareHouse_Label6.text = _arg_1;
            }, "_WareHouse_Label6.text");
            result[18] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get idleSpace():int
        {
            return (this._1715963282idleSpace);
        }

        [Bindable(event="propertyChange")]
        private function get storage():int
        {
            return (this._1884274053storage);
        }

        [Bindable(event="propertyChange")]
        public function get foodNS():NumericStepper
        {
            return (this._1268877661foodNS);
        }

        private function set dataArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443166807dataArr;
            if (_local_2 !== _arg_1)
            {
                this._1443166807dataArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataArr", _local_2, _arg_1));
            };
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

        [Bindable(event="propertyChange")]
        private function get stoneBean():WareHouseBean
        {
            return (this._1576912309stoneBean);
        }

        private function _WareHouse_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn2 = _local_1;
            _local_1.dataField = "amount";
            _local_1.width = 110;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn2", _WareHouse_DataGridColumn2);
            return (_local_1);
        }

        public function __ironNS_change(_arg_1:NumericStepperEvent):void
        {
            eventChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get ironBean():WareHouseBean
        {
            return (this._310814568ironBean);
        }

        private function _WareHouse_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn6 = _local_1;
            _local_1.dataField = "stock";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn6", _WareHouse_DataGridColumn6);
            return (_local_1);
        }

        private function getStoreListResponse(_arg_1:StoreListResponse):void
        {
            var _local_3:StoreBean;
            this.storage = _arg_1.totalCap;
            var _local_2:int;
            while (_local_2 < _arg_1.storeBeansArray.length)
            {
                _local_3 = _arg_1.getStoreBeans(_local_2);
                switch (_local_3.storeTypeId)
                {
                    case 1:
                        this.foodStoreBean = _local_3;
                        this.foodBean.typeId = 1;
                        this.foodBean.typeName = Lang.msg("粮食");
                        this.foodBean.amount = this.curCastle.resource.food.amount;
                        this.foodBean.storePercent = _local_3.storePercent;
                        this.foodBean.storage = Math.ceil(((this.storage * this.foodBean.storePercent) / 100));
                        this.foodBean.resLimt = _local_3.resLimt;
                        this.foodBean.stock = ((this.foodBean.amount > this.foodBean.storage) ? this.foodBean.storage : this.foodBean.amount);
                        this.foodBean.unStock = (this.foodBean.amount - this.foodBean.stock);
                        break;
                    case 2:
                        this.woodStoreBean = _local_3;
                        this.woodBean.typeId = 1;
                        this.woodBean.typeName = Lang.msg("木材");
                        this.woodBean.amount = this.curCastle.resource.wood.amount;
                        this.woodBean.storePercent = _local_3.storePercent;
                        this.woodBean.storage = Math.ceil(((this.storage * this.woodBean.storePercent) / 100));
                        this.woodBean.resLimt = _local_3.resLimt;
                        this.woodBean.stock = ((this.woodBean.amount > this.woodBean.storage) ? this.woodBean.storage : this.woodBean.amount);
                        this.woodBean.unStock = (this.woodBean.amount - this.woodBean.stock);
                        break;
                    case 3:
                        this.stoneStoreBean = _local_3;
                        this.stoneBean.typeId = 1;
                        this.stoneBean.typeName = Lang.msg("石料");
                        this.stoneBean.amount = this.curCastle.resource.stone.amount;
                        this.stoneBean.storePercent = _local_3.storePercent;
                        this.stoneBean.storage = Math.ceil(((this.storage * this.stoneBean.storePercent) / 100));
                        this.stoneBean.resLimt = _local_3.resLimt;
                        this.stoneBean.stock = ((this.stoneBean.amount > this.stoneBean.storage) ? this.stoneBean.storage : this.stoneBean.amount);
                        this.stoneBean.unStock = (this.stoneBean.amount - this.stoneBean.stock);
                        break;
                    case 4:
                        this.ironStoreBean = _local_3;
                        this.ironBean.typeId = 1;
                        this.ironBean.typeName = Lang.msg("铁矿");
                        this.ironBean.amount = this.curCastle.resource.iron.amount;
                        this.ironBean.storePercent = _local_3.storePercent;
                        this.ironBean.storage = Math.ceil(((this.storage * this.ironBean.storePercent) / 100));
                        this.ironBean.resLimt = _local_3.resLimt;
                        this.ironBean.stock = ((this.ironBean.amount > this.ironBean.storage) ? this.ironBean.storage : this.ironBean.amount);
                        this.ironBean.unStock = (this.ironBean.amount - this.ironBean.stock);
                        break;
                };
                _local_2++;
            };
            this.maxNumber = ((((100 - this.foodBean.storePercent) - this.woodBean.storePercent) - this.stoneBean.storePercent) - this.ironBean.storePercent);
            addDataArr();
        }

        public function set stoneNS(_arg_1:NumericStepper):void
        {
            var _local_2:Object = this._1884390166stoneNS;
            if (_local_2 !== _arg_1)
            {
                this._1884390166stoneNS = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stoneNS", _local_2, _arg_1));
            };
        }

        private function set wareHouseNum(_arg_1:int):void
        {
            var _local_2:Object = this._994230755wareHouseNum;
            if (_local_2 !== _arg_1)
            {
                this._994230755wareHouseNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wareHouseNum", _local_2, _arg_1));
            };
        }

        public function ___WareHouse_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function refresh():void
        {
            super.refresh();
            trace((this.className + " refresh()"));
            this.curCastle = Context.getInstance().getCurCastle();
            this.wareHouseNum = getWareHouseNum();
            ActionFactory.getInstance().getCityCommands().getStoreList(this.curCastle.id);
        }

        [Bindable(event="propertyChange")]
        private function get wareHouseNum():int
        {
            return (this._994230755wareHouseNum);
        }

        public function eventChange(_arg_1:*):void
        {
            this.foodNS.maximum = 100;
            this.woodNS.maximum = 100;
            this.stoneNS.maximum = 100;
            this.ironNS.maximum = 100;
            switch (_arg_1.target.id)
            {
                case "foodNS":
                    this.foodNS.maximum = (((100 - this.woodNS.value) - this.stoneNS.value) - this.ironNS.value);
                    if ((((_arg_1.target.value + this.woodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) <= 100)
                    {
                        this.foodBean.storePercent = (((((_arg_1.target.value + this.woodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) > 100) ? (((100 - this.woodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) : _arg_1.target.value);
                        this.foodBean.storage = Math.ceil(((this.storage * this.foodBean.storePercent) / 100));
                        this.foodBean.resLimt = (this.foodStoreBean.resLimt + this.foodBean.storage);
                        this.foodBean.stock = ((this.foodBean.amount > this.foodBean.storage) ? this.foodBean.storage : this.foodBean.amount);
                        this.foodBean.unStock = (this.foodBean.amount - this.foodBean.stock);
                    };
                    break;
                case "woodNS":
                    this.woodNS.maximum = (((100 - this.foodNS.value) - this.stoneNS.value) - this.ironNS.value);
                    if ((((_arg_1.target.value + this.foodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) <= 100)
                    {
                        this.woodBean.storePercent = (((((_arg_1.target.value + this.foodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) > 100) ? (((100 - this.foodBean.storePercent) + this.stoneBean.storePercent) + this.ironBean.storePercent) : _arg_1.target.value);
                        this.woodBean.storage = Math.ceil(((this.storage * this.woodBean.storePercent) / 100));
                        this.woodBean.resLimt = this.woodStoreBean.resLimt;
                        this.woodBean.stock = ((this.woodBean.amount > this.woodBean.storage) ? this.woodBean.storage : this.woodBean.amount);
                        this.woodBean.unStock = (this.woodBean.amount - this.woodBean.stock);
                    };
                    break;
                case "stoneNS":
                    this.stoneNS.maximum = (((100 - this.woodNS.value) - this.foodNS.value) - this.ironNS.value);
                    if ((((_arg_1.target.value + this.woodBean.storePercent) + this.foodBean.storePercent) + this.ironBean.storePercent) <= 100)
                    {
                        this.stoneBean.storePercent = (((((_arg_1.target.value + this.woodBean.storePercent) + this.foodBean.storePercent) + this.ironBean.storePercent) > 100) ? (((100 - this.woodBean.storePercent) + this.foodBean.storePercent) + this.ironBean.storePercent) : _arg_1.target.value);
                        this.stoneBean.storage = Math.ceil(((this.storage * this.stoneBean.storePercent) / 100));
                        this.stoneBean.resLimt = this.stoneStoreBean.resLimt;
                        this.stoneBean.stock = ((this.stoneBean.amount > this.stoneBean.storage) ? this.stoneBean.storage : this.stoneBean.amount);
                        this.stoneBean.unStock = (this.stoneBean.amount - this.stoneBean.stock);
                    };
                    break;
                case "ironNS":
                    this.ironNS.maximum = (((100 - this.woodNS.value) - this.stoneNS.value) - this.foodNS.value);
                    if ((((_arg_1.target.value + this.woodBean.storePercent) + this.stoneBean.storePercent) + this.foodBean.storePercent) <= 100)
                    {
                        this.ironBean.storePercent = (((((_arg_1.target.value + this.woodBean.storePercent) + this.stoneBean.storePercent) + this.foodBean.storePercent) > 100) ? (((100 - this.woodBean.storePercent) + this.stoneBean.storePercent) + this.foodBean.storePercent) : _arg_1.target.value);
                        this.ironBean.storage = Math.ceil(((this.storage * this.ironBean.storePercent) / 100));
                        this.ironBean.resLimt = this.ironStoreBean.resLimt;
                        this.ironBean.stock = ((this.ironBean.amount > this.ironBean.storage) ? this.ironBean.storage : this.ironBean.amount);
                        this.ironBean.unStock = (this.ironBean.amount - this.ironBean.stock);
                    };
                    break;
            };
            addDataArr();
        }

        public function __foodNS_change(_arg_1:NumericStepperEvent):void
        {
            eventChange(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get stoneNS():NumericStepper
        {
            return (this._1884390166stoneNS);
        }

        private function _WareHouse_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.dataArr;
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("资源上限");
            _local_1 = Lang.msg("仓库容量");
            _local_1 = Lang.msg("存放比例");
            _local_1 = Lang.msg("入库");
            _local_1 = Lang.msg("未入库");
            _local_1 = Lang.msg("修改");
            _local_1 = this.foodBean.storePercent;
            _local_1 = this.woodBean.storePercent;
            _local_1 = this.stoneBean.storePercent;
            _local_1 = this.ironBean.storePercent;
            _local_1 = (Lang.msg("共有仓库") + ": ");
            _local_1 = wareHouseNum;
            _local_1 = (Lang.msg("总容量") + ": ");
            _local_1 = storage;
            _local_1 = (Lang.msg("闲置空间") + ": ");
            _local_1 = ((idleSpace >= 0) ? idleSpace : 0);
        }

        private function _WareHouse_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn1", _WareHouse_DataGridColumn1);
            return (_local_1);
        }

        private function _WareHouse_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _WareHouse_DataGridColumn5 = _local_1;
            _local_1.dataField = "storePercent";
            _local_1.width = 140;
            BindingManager.executeBindings(this, "_WareHouse_DataGridColumn5", _WareHouse_DataGridColumn5);
            return (_local_1);
        }


    }
}//package view.module.warehouse

