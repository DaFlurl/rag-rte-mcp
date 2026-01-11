// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.barrack.SWDisband

package view.module.barrack
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import com.evony.common.beans.TroopProduceListBean;
    import com.evony.util.ProduceBuildingResourceData;
    import com.evony.eum.TroopEum;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import view.ui.NumberRegulate;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import flash.display.DisplayObject;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.events.CommonProduceEvent;
    import com.evony.Context;
    import view.module.playerInfo.UnlockSecurityCode;
    import view.module.playerInfo.ApplySecurityCode;
    import view.ui.AlertWin;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import com.evony.Lang;
    import flash.events.MouseEvent;
    import com.evony.eum.TroopEumDefine;
    import mx.binding.BindingManager;
    import com.evony.common.beans.TroopBean;
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
    import view.module.playerInfo.*;
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

    public class SWDisband extends Canvas implements IBindingClient 
    {

        public static var instance:SWDisband;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _737800520curAmount:int;
        public var _SWDisband_Button1:Button;
        private var troopBean:TroopProduceListBean;
        private var produceBuildingResourceData:ProduceBuildingResourceData;
        private var _1682493707troopEum:TroopEum;
        public var _SWDisband_Label1:Label;
        public var _SWDisband_Label3:Label;
        public var _SWDisband_Label4:Label;
        public var _SWDisband_DataGrid1:DataGrid;
        private var _3525ns:NumberRegulate;
        public var _SWDisband_DataGridColumn1:DataGridColumn;
        public var _SWDisband_DataGridColumn2:DataGridColumn;
        public var _SWDisband_DataGridColumn3:DataGridColumn;
        public var _SWDisband_Label2:Label;
        private var _1443166814dataAry:ArrayCollection;
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
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SWDisband_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_SWDisband_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "33";
                            this.left = "20";
                            this.right = "20";
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
                                "columns":[_SWDisband_DataGridColumn1_i(), _SWDisband_DataGridColumn2_i(), _SWDisband_DataGridColumn3_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_SWDisband_Button1",
                        "events":{"click":"___SWDisband_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.bottom = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
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
                                        this.horizontalGap = 3;
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_SWDisband_Label2",
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
                                                            "id":"_SWDisband_Label3",
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
                                                            "id":"_SWDisband_Label4",
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
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SWDisband_Button2_click"},
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
        private var produceAry:Array = new Array();
        private var _objData:Object = new Object();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SWDisband()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 297;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SWDisband._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:DisplayObject, _arg_2:TroopProduceListBean):void
        {
            if (instance == null)
            {
                instance = new (SWDisband)();
            };
            PopUpManager.addPopUp(instance, _arg_1, true);
            PopUpManager.centerPopUp(instance);
            instance.setBean(_arg_2);
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
            var target:SWDisband;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SWDisband_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_barrack_SWDisbandWatcherSetupUtil");
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

        public function troopDisband():void
        {
            var onDesbandResponse:Function;
            var cid:int;
            onDesbandResponse = function (_arg_1:CommandResponse):void
            {
                closeOwner();
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    CommonProduceEvent.refresh(Barrack.EVENT_REFRESH);
                }
                else
                {
                    if (_arg_1.ok == -200)
                    {
                        if (Context.getInstance().bLoginSecurityCode)
                        {
                            UnlockSecurityCode.show(4);
                        }
                        else
                        {
                            ApplySecurityCode.show(4);
                        };
                    }
                    else
                    {
                        AlertWin.show(_arg_1.errorMsg);
                    };
                };
            };
            if (((this.ns.currentValue > 0) && (this.ns.currentValue <= this.curAmount)))
            {
                cid = Context.getInstance().getCurCastle().id;
                ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TROOP_DISBAND_TROOP, onDesbandResponse, false, 0, true);
                ActionFactory.getInstance().getTroopCommands().disbandTroop(cid, this.troopBean.typeId, this.ns.currentValue);
            }
            else
            {
                AlertWin.show(Lang.msg("数值不正确"));
            };
        }

        private function closeOwner():void
        {
            PopUpManager.removePopUp(this);
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
        }

        private function set troopEum(_arg_1:TroopEum):void
        {
            var _local_2:Object = this._1682493707troopEum;
            if (_local_2 !== _arg_1)
            {
                this._1682493707troopEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopEum", _local_2, _arg_1));
            };
        }

        public function ___SWDisband_Button1_click(_arg_1:MouseEvent):void
        {
            troopDisband();
        }

        [Bindable(event="propertyChange")]
        private function get troopEum():TroopEum
        {
            return (this._1682493707troopEum);
        }

        public function setBean(_arg_1:TroopProduceListBean):void
        {
            this.troopBean = _arg_1;
            this.troopEum = TroopEumDefine.getTroopEumByType(this.troopBean.typeId);
            this.produceBuildingResourceData = new ProduceBuildingResourceData(_arg_1.conditionBean);
            this.dataAry = this.produceBuildingResourceData.dataArray;
            this.bind();
            if (this.initialized)
            {
                this.ns.refresh();
            };
            this.produceNum = instance.ns.currentValue;
            this.produceBuildingResourceData.reCalcDataArrayForDisband(this.produceNum);
        }

        private function _SWDisband_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWDisband_DataGridColumn1 = _local_1;
            _local_1.dataField = "typeName";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_SWDisband_DataGridColumn1", _SWDisband_DataGridColumn1);
            return (_local_1);
        }

        private function _SWDisband_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWDisband_DataGridColumn3 = _local_1;
            _local_1.dataField = "currentAmount";
            BindingManager.executeBindings(this, "_SWDisband_DataGridColumn3", _SWDisband_DataGridColumn3);
            return (_local_1);
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:TroopBean = Context.getInstance().getCurCastle().troop;
            switch (this.troopBean.typeId)
            {
                case TFConstants.T_ARCHER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "archer");
                    return;
                case TFConstants.T_BALLISTA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "ballista");
                    return;
                case TFConstants.T_BATTERINGRAM:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "batteringRam");
                    return;
                case TFConstants.T_CARRIAGE:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "carriage");
                    return;
                case TFConstants.T_CATAPULT:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "catapult");
                    return;
                case TFConstants.T_HEAVYCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "heavyCavalry");
                    return;
                case TFConstants.T_LIGHTCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "lightCavalry");
                    return;
                case TFConstants.T_MILITIA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "militia");
                    return;
                case TFConstants.T_PEASANTS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "peasants");
                    return;
                case TFConstants.T_PIKEMAN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "pikemen");
                    return;
                case TFConstants.T_SCOUTER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "scouter");
                    return;
                case TFConstants.T_SWORDSMEN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "swordsmen");
                    return;
            };
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

        [Bindable(event="propertyChange")]
        public function get ns():NumberRegulate
        {
            return (this._3525ns);
        }

        private function _SWDisband_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("解散");
            _local_1 = this.dataAry;
            _local_1 = Lang.msg("获得资源");
            _local_1 = Lang.msg("获得数量");
            _local_1 = Lang.msg("当前数量");
            _local_1 = Lang.msg("确定");
            _local_1 = (Lang.msg("现有数量") + ":");
            _local_1 = (Lang.msg("遣散数量") + ":");
            _local_1 = this.curAmount;
            _local_1 = onChange;
            _local_1 = this.curAmount;
        }

        public function ___SWDisband_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        private function _SWDisband_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解散");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_Label1.text = _arg_1;
            }, "_SWDisband_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.dataAry);
            }, function (_arg_1:Object):void
            {
                _SWDisband_DataGrid1.dataProvider = _arg_1;
            }, "_SWDisband_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_DataGridColumn1.headerText = _arg_1;
            }, "_SWDisband_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_DataGridColumn2.headerText = _arg_1;
            }, "_SWDisband_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_DataGridColumn3.headerText = _arg_1;
            }, "_SWDisband_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_Button1.label = _arg_1;
            }, "_SWDisband_Button1.label");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("现有数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_Label2.text = _arg_1;
            }, "_SWDisband_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("遣散数量") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_Label3.text = _arg_1;
            }, "_SWDisband_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWDisband_Label4.text = _arg_1;
            }, "_SWDisband_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():Function
            {
                return (onChange);
            }, function (_arg_1:Function):void
            {
                ns.onDataChange = _arg_1;
            }, "ns.onDataChange");
            result[9] = binding;
            binding = new Binding(this, function ():int
            {
                return (this.curAmount);
            }, function (_arg_1:int):void
            {
                ns.valueMax = _arg_1;
            }, "ns.valueMax");
            result[10] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        private function onChange(_arg_1:int):void
        {
            this.produceNum = _arg_1;
            this.produceBuildingResourceData.reCalcDataArrayForDisband(this.produceNum);
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
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        private function _SWDisband_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _SWDisband_DataGridColumn2 = _local_1;
            _local_1.dataField = "needAmount";
            BindingManager.executeBindings(this, "_SWDisband_DataGridColumn2", _SWDisband_DataGridColumn2);
            return (_local_1);
        }


    }
}//package view.module.barrack

