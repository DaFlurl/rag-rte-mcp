// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.wall.CastleDefDemolition

package view.module.wall
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import com.evony.common.beans.FortProduceListBean;
    import com.evony.util.ProduceBuildingResourceData;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.eum.FortificationEum;
    import view.ui.NumberRegulate;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.binding.BindingManager;
    import com.evony.common.module.CommandResponse;
    import com.evony.events.CommonProduceEvent;
    import view.ui.AlertWin;
    import com.evony.Context;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import com.evony.eum.FortificationEumDefine;
    import flash.events.MouseEvent;
    import com.evony.common.beans.FortificationsBean;
    import mx.binding.utils.BindingUtils;
    import com.evony.common.constants.TFConstants;
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

    public class CastleDefDemolition extends Canvas implements IBindingClient 
    {

        private static var instance:CastleDefDemolition;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _737800520curAmount:int;
        public var _CastleDefDemolition_Button1:Button;
        private var _1482921390condiction_DG:DataGrid;
        private var conditionTime:Number;
        public var _CastleDefDemolition_Label1:Label;
        public var _CastleDefDemolition_Label2:Label;
        public var _CastleDefDemolition_Label3:Label;
        public var _CastleDefDemolition_Label4:Label;
        private var fortBean:FortProduceListBean;
        private var produceBuildingResourceData:ProduceBuildingResourceData;
        public var _CastleDefDemolition_DataGridColumn1:DataGridColumn;
        public var _CastleDefDemolition_DataGridColumn2:DataGridColumn;
        public var _CastleDefDemolition_DataGridColumn3:DataGridColumn;
        private var _677262094fortEum:FortificationEum;
        private var _3525ns:NumberRegulate;
        private var _1752545926produceNum:int = 1;
        private var changeWatcher:ChangeWatcher;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":297,
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
                        "type":DataGrid,
                        "id":"condiction_DG",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "33";
                            this.right = "20";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "verticalScrollPolicy":"off",
                                "styleName":"style2",
                                "horizontalScrollPolicy":"off",
                                "rowCount":4,
                                "rowHeight":30,
                                "height":147,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_CastleDefDemolition_DataGridColumn1_i(), _CastleDefDemolition_DataGridColumn2_i(), _CastleDefDemolition_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_CastleDefDemolition_Button1",
                        "events":{"click":"___CastleDefDemolition_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.bottom = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"y125",
                                "width":125
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "185";
                            this.left = "20";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":65,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.top = "5";
                                        this.bottom = "5";
                                        this.right = "5";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CastleDefDemolition_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CastleDefDemolition_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"percentWidth":100});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_CastleDefDemolition_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":160});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":NumberRegulate,
                                                            "id":"ns"
                                                        })]
                                                    });
                                                }
                                            })]});
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
                                    "id":"_CastleDefDemolition_Label4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CastleDefDemolition_Button2_click"},
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
        private var _1443166814dataAry:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleDefDemolition()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 297;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleDefDemolition._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:FortProduceListBean):void
        {
            if (instance == null)
            {
                instance = new (CastleDefDemolition)();
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
            instance.setBean(_arg_1);
            instance.produceNum = 1;
        }


        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        [Bindable(event="propertyChange")]
        private function get produceNum():int
        {
            return (this._1752545926produceNum);
        }

        public function set ns(_arg_1:NumberRegulate):void
        {
            var _local_2:Object = this._3525ns;
            if (_local_2 !== _arg_1)
            {
                this._3525ns = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ns", _local_2, _arg_1));
            };
        }

        private function set produceNum(_arg_1:int):void
        {
            var _local_2:Object = this._1752545926produceNum;
            if (_local_2 !== _arg_1)
            {
                this._1752545926produceNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceNum", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:CastleDefDemolition;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleDefDemolition_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_wall_CastleDefDemolitionWatcherSetupUtil");
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

        private function _CastleDefDemolition_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.dataAry;
            _local_1 = Lang.msg("获得资源");
            _local_1 = Lang.msg("获得数量");
            _local_1 = Lang.msg("当前数量");
            _local_1 = Lang.msg("确定");
            _local_1 = (Lang.msg("现有数量") + ":");
            _local_1 = (Lang.msg("拆除数量") + ":");
            _local_1 = this.curAmount;
            _local_1 = onChange;
            _local_1 = this.curAmount;
            _local_1 = Lang.msg("拆除");
        }

        private function _CastleDefDemolition_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefDemolition_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_CastleDefDemolition_DataGridColumn1", _CastleDefDemolition_DataGridColumn1);
            return (_local_1);
        }

        private function castleDefDemolition():void
        {
            var onDisbandResponse:Function;
            var cid:int;
            onDisbandResponse = function (_arg_1:CommandResponse):void
            {
                closeOwner();
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    CommonProduceEvent.refresh(Wall.EVENT_REFRESH);
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
            };
            if (((this.ns.currentValue > 0) && (this.ns.currentValue <= this.curAmount)))
            {
                cid = Context.getInstance().getCurCastle().id;
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FORTIFICATIONS_DESTRUCT_WALL_PROTECT, onDisbandResponse, false, 0, true);
                ActionFactory.getInstance().getFortificationsCommands().destructWallProtect(cid, this.fortBean.typeId, this.ns.currentValue);
            }
            else
            {
                AlertWin.show(Lang.msg("数值不正确"));
            };
        }

        private function _CastleDefDemolition_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefDemolition_DataGridColumn3 = _local_1;
            _local_1.dataField = "currentAmount";
            BindingManager.executeBindings(this, "_CastleDefDemolition_DataGridColumn3", _CastleDefDemolition_DataGridColumn3);
            return (_local_1);
        }

        public function set condiction_DG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1482921390condiction_DG;
            if (_local_2 !== _arg_1)
            {
                this._1482921390condiction_DG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "condiction_DG", _local_2, _arg_1));
            };
        }

        private function closeOwner():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            PopUpManager.removePopUp(this);
        }

        private function setBean(_arg_1:FortProduceListBean):void
        {
            this.fortBean = _arg_1;
            this.fortEum = FortificationEumDefine.getFortificationEumByType(this.fortBean.typeId);
            this.conditionTime = _arg_1.conditionBean.time;
            this.produceBuildingResourceData = new ProduceBuildingResourceData(_arg_1.conditionBean);
            this.dataAry = this.produceBuildingResourceData.dataArray;
            this.bind();
            this.ns.refresh();
            this.produceNum = instance.ns.currentValue;
            this.produceBuildingResourceData.reCalcDataArrayForDisband(this.produceNum);
        }

        public function ___CastleDefDemolition_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        private function _CastleDefDemolition_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.dataAry);
            }, function (_arg_1:Object):void
            {
                condiction_DG.dataProvider = _arg_1;
            }, "condiction_DG.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_DataGridColumn1.headerText = _arg_1;
            }, "_CastleDefDemolition_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_DataGridColumn2.headerText = _arg_1;
            }, "_CastleDefDemolition_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_DataGridColumn3.headerText = _arg_1;
            }, "_CastleDefDemolition_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_Button1.label = _arg_1;
            }, "_CastleDefDemolition_Button1.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("现有数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_Label1.text = _arg_1;
            }, "_CastleDefDemolition_Label1.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("拆除数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_Label2.text = _arg_1;
            }, "_CastleDefDemolition_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_Label3.text = _arg_1;
            }, "_CastleDefDemolition_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                ns.onDataChange = _arg_1;
            }, "ns.onDataChange");
            result[8] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.curAmount);
            }, function (_arg_1:int):void
            {
                ns.valueMax = _arg_1;
            }, "ns.valueMax");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("拆除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefDemolition_Label4.text = _arg_1;
            }, "_CastleDefDemolition_Label4.text");
            result[10] = binding;
            return (result);
        }

        private function set dataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443166814dataAry;
            if (_local_2 !== _arg_1)
            {
                this._1443166814dataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataAry", _local_2, _arg_1));
            };
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:FortificationsBean = Context.getInstance().getCurCastle().fortification;
            switch (this.fortBean.typeId)
            {
                case TFConstants.F_ABATIS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "abatis");
                    return;
                case TFConstants.F_ARROWTOWER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "arrowTower");
                    return;
                case TFConstants.F_ROCKFALL:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rockfall");
                    return;
                case TFConstants.F_ROLLINGLOGS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rollingLogs");
                    return;
                case TFConstants.F_TRAP:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "trap");
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        [Bindable(event="propertyChange")]
        public function get condiction_DG():DataGrid
        {
            return (this._1482921390condiction_DG);
        }

        [Bindable(event="propertyChange")]
        public function get ns():NumberRegulate
        {
            return (this._3525ns);
        }

        private function _CastleDefDemolition_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CastleDefDemolition_DataGridColumn2 = _local_1;
            _local_1.dataField = "needAmount";
            BindingManager.executeBindings(this, "_CastleDefDemolition_DataGridColumn2", _CastleDefDemolition_DataGridColumn2);
            return (_local_1);
        }

        private function set fortEum(_arg_1:FortificationEum):void
        {
            var _local_2:Object = this._677262094fortEum;
            if (_local_2 !== _arg_1)
            {
                this._677262094fortEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fortEum", _local_2, _arg_1));
            };
        }

        public function ___CastleDefDemolition_Button1_click(_arg_1:MouseEvent):void
        {
            castleDefDemolition();
        }

        public function set curAmount(_arg_1:int):void
        {
            var _local_2:Object = this._737800520curAmount;
            if (_local_2 !== _arg_1)
            {
                this._737800520curAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curAmount", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get fortEum():FortificationEum
        {
            return (this._677262094fortEum);
        }

        private function onChange(_arg_1:int):void
        {
            this.produceNum = _arg_1;
            this.produceBuildingResourceData.reCalcDataArrayForDisband(this.produceNum);
        }


    }
}//package view.module.wall

