// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.TrainningField

package view.module.trainningField
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.CheckBox;
    import mx.core.ClassFactory;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.containers.Canvas;
    import mx.containers.Tile;
    import mx.collections.ArrayCollection;
    import com.evony.Context;
    import com.evony.common.beans.TroopBean;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.Event;
    import mx.binding.BindingManager;
    import view.AllWindows;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import com.evony.Lang;
    import com.evony.common.constants.TFConstants;
    import flash.display.Bitmap;
    import com.evony.common.beans.BuffBean;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
    import view.ui.UIEscapeCamp;
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

    public class TrainningField extends BaseBuildingWindow implements IBindingClient 
    {

        public static var instance:TrainningField;
        public static const EVENT_SHOW:String = "TrainningField.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1133395423tacticsBtn:CheckBox;
        private var _713762781ImgHead:ClassFactory;
        public var _TrainningField_DataGrid1:DataGrid;
        public var _TrainningField_TroopTypeUI2:TroopTypeUI;
        public var _TrainningField_TroopTypeUI3:TroopTypeUI;
        public var _TrainningField_TroopTypeUI4:TroopTypeUI;
        public var _TrainningField_TroopTypeUI5:TroopTypeUI;
        public var _TrainningField_TroopTypeUI6:TroopTypeUI;
        public var _TrainningField_TroopTypeUI7:TroopTypeUI;
        public var _TrainningField_TroopTypeUI8:TroopTypeUI;
        public var _TrainningField_TroopTypeUI9:TroopTypeUI;
        private var _1563726909maneuverBtn:Button;
        public var _TrainningField_TroopTypeUI1:TroopTypeUI;
        private var _1301402884wreckBarrackBtn:Button;
        private var _2059914812isGoOut:Boolean;
        public var _TrainningField_TroopTypeUI10:TroopTypeUI;
        public var _TrainningField_TroopTypeUI11:TroopTypeUI;
        public var _TrainningField_TroopTypeUI12:TroopTypeUI;
        public var _TrainningField_DataGridColumn1:DataGridColumn;
        private var _2083760940campaignBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_TrainningField_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "5";
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":220,
                                "rowCount":5,
                                "styleName":"style2",
                                "editable":false,
                                "resizableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "draggableColumns":false,
                                "columns":[_TrainningField_DataGridColumn1_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 5;
                            this.top = "5";
                            this.left = "225";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"campaignBtn",
                                    "events":{"click":"__campaignBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"maneuverBtn",
                                    "events":{"click":"__maneuverBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"wreckBarrackBtn",
                                    "events":{"click":"__wreckBarrackBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"tacticsBtn",
                        "events":{"click":"__tacticsBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "32";
                            this.left = "225";
                            this.color = 0xFFFFFF;
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "225";
                            this.top = "59";
                            this.right = "5";
                            this.bottom = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Tile,
                                    "stylesFactory":function ():void
                                    {
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                        this.top = "3";
                                        this.left = "4";
                                        this.right = "0";
                                        this.bottom = "0";
                                        this.verticalGap = 4;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "direction":"horizontal",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI1"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI2"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI3"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI4"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI5"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI6"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI7"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI8"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI9"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI10"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI11"
                                            }), new UIComponentDescriptor({
                                                "type":TroopTypeUI,
                                                "id":"_TrainningField_TroopTypeUI12"
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1472482044heroDataAry:ArrayCollection = Context.getInstance().getCurCastle().herosArray;
        private var _1458699609currentTroop:TroopBean = Context.getInstance().getCurCastle().troop;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TrainningField()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            _TrainningField_ClassFactory1_i();
            this.addEventListener("creationComplete", ___TrainningField_BaseBuildingWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___TrainningField_BaseBuildingWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TrainningField._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get wreckBarrackBtn():Button
        {
            return (this._1301402884wreckBarrackBtn);
        }

        private function set isGoOut(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2059914812isGoOut;
            if (_local_2 !== _arg_1)
            {
                this._2059914812isGoOut = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isGoOut", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get maneuverBtn():Button
        {
            return (this._1563726909maneuverBtn);
        }

        [Bindable(event="propertyChange")]
        private function get heroDataAry():ArrayCollection
        {
            return (this._1472482044heroDataAry);
        }

        public function set maneuverBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1563726909maneuverBtn;
            if (_local_2 !== _arg_1)
            {
                this._1563726909maneuverBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maneuverBtn", _local_2, _arg_1));
            };
        }

        public function set wreckBarrackBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1301402884wreckBarrackBtn;
            if (_local_2 !== _arg_1)
            {
                this._1301402884wreckBarrackBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "wreckBarrackBtn", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TrainningField;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TrainningField_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_TrainningFieldWatcherSetupUtil");
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

        private function init():void
        {
            instance = this;
        }

        public function ___TrainningField_BaseBuildingWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function _TrainningField_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TrainningField_DataGridColumn1 = _local_1;
            _local_1.itemRenderer = _TrainningField_ClassFactory2_c();
            BindingManager.executeBindings(this, "_TrainningField_DataGridColumn1", _TrainningField_DataGridColumn1);
            return (_local_1);
        }

        private function set heroDataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1472482044heroDataAry;
            if (_local_2 !== _arg_1)
            {
                this._1472482044heroDataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroDataAry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get tacticsBtn():CheckBox
        {
            return (this._1133395423tacticsBtn);
        }

        private function sendHandler(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.id)
            {
                case "campaignBtn":
                    AllWindows.switchToFuncWindow(NewArmyWin.EVENT_SHOW);
                    return;
                case "maneuverBtn":
                    AllWindows.switchToFuncWindow(Maneuver.EVENT_SHOW);
                    return;
                case "wreckBarrackBtn":
                    trace("wreckBarrackBtn");
                    HospitalWin.show();
                    return;
                case "tacticsBtn":
                    this.isGoOut = this.tacticsBtn.selected;
                    Context.getInstance().getCurCastle().goOutForBattle = this.isGoOut;
                    ActionFactory.getInstance().getArmyCommands().setArmyGoOut(Context.getInstance().getCurCastle().id, isGoOut);
                    trace("tacticsBtn");
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get ImgHead():ClassFactory
        {
            return (this._713762781ImgHead);
        }

        public function __maneuverBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        public function __wreckBarrackBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        private function _TrainningField_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            ImgHead = _local_1;
            _local_1.generator = TrainningField_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set currentTroop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._1458699609currentTroop;
            if (_local_2 !== _arg_1)
            {
                this._1458699609currentTroop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentTroop", _local_2, _arg_1));
            };
        }

        public function set ImgHead(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._713762781ImgHead;
            if (_local_2 !== _arg_1)
            {
                this._713762781ImgHead = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ImgHead", _local_2, _arg_1));
            };
        }

        public function set tacticsBtn(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1133395423tacticsBtn;
            if (_local_2 !== _arg_1)
            {
                this._1133395423tacticsBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tacticsBtn", _local_2, _arg_1));
            };
        }

        public function __tacticsBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get isGoOut():Boolean
        {
            return (this._2059914812isGoOut);
        }

        private function _TrainningField_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (heroDataAry);
            }, function (_arg_1:Object):void
            {
                _TrainningField_DataGrid1.dataProvider = _arg_1;
            }, "_TrainningField_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TrainningField_DataGridColumn1.headerText = _arg_1;
            }, "_TrainningField_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出征");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                campaignBtn.label = _arg_1;
            }, "campaignBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("演习");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                maneuverBtn.label = _arg_1;
            }, "maneuverBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("伤兵营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                wreckBarrackBtn.label = _arg_1;
            }, "wreckBarrackBtn.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("是否出城");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                tacticsBtn.label = _arg_1;
            }, "tacticsBtn.label");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isGoOut);
            }, function (_arg_1:Boolean):void
            {
                tacticsBtn.selected = _arg_1;
            }, "tacticsBtn.selected");
            result[6] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PEASANTS);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI1.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI1.imgSrc");
            result[7] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.peasants);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI1.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI1.amount");
            result[8] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_MILITIA);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI2.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI2.imgSrc");
            result[9] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.militia);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI2.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI2.amount");
            result[10] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SCOUTER);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI3.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI3.imgSrc");
            result[11] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.scouter);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI3.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI3.amount");
            result[12] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_PIKEMAN);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI4.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI4.imgSrc");
            result[13] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.pikemen);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI4.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI4.amount");
            result[14] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_SWORDSMEN);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI5.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI5.imgSrc");
            result[15] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.swordsmen);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI5.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI5.amount");
            result[16] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_ARCHER);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI6.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI6.imgSrc");
            result[17] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.archer);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI6.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI6.amount");
            result[18] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_LIGHTCAVALRY);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI7.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI7.imgSrc");
            result[19] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.lightCavalry);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI7.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI7.amount");
            result[20] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_HEAVYCAVALRY);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI8.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI8.imgSrc");
            result[21] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.heavyCavalry);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI8.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI8.amount");
            result[22] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CARRIAGE);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI9.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI9.imgSrc");
            result[23] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.carriage);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI9.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI9.amount");
            result[24] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BALLISTA);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI10.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI10.imgSrc");
            result[25] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.ballista);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI10.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI10.amount");
            result[26] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_BATTERINGRAM);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI11.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI11.imgSrc");
            result[27] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.batteringRam);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI11.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI11.amount");
            result[28] = binding;
            binding = new Binding(this, function ():int
            {
                return (TFConstants.T_CATAPULT);
            }, function (_arg_1:int):void
            {
                _TrainningField_TroopTypeUI12.imgSrc = _arg_1;
            }, "_TrainningField_TroopTypeUI12.imgSrc");
            result[29] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.currentTroop.catapult);
            }, function (_arg_1:*):void
            {
                _TrainningField_TroopTypeUI12.amount = _arg_1;
            }, "_TrainningField_TroopTypeUI12.amount");
            result[30] = binding;
            return (result);
        }

        private function _TrainningField_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = heroDataAry;
            _local_1 = Lang.msg("英雄");
            _local_1 = Lang.msg("出征");
            _local_1 = Lang.msg("演习");
            _local_1 = Lang.msg("伤兵营");
            _local_1 = Lang.msg("是否出城");
            _local_1 = this.isGoOut;
            _local_1 = TFConstants.T_PEASANTS;
            _local_1 = this.currentTroop.peasants;
            _local_1 = TFConstants.T_MILITIA;
            _local_1 = this.currentTroop.militia;
            _local_1 = TFConstants.T_SCOUTER;
            _local_1 = this.currentTroop.scouter;
            _local_1 = TFConstants.T_PIKEMAN;
            _local_1 = this.currentTroop.pikemen;
            _local_1 = TFConstants.T_SWORDSMEN;
            _local_1 = this.currentTroop.swordsmen;
            _local_1 = TFConstants.T_ARCHER;
            _local_1 = this.currentTroop.archer;
            _local_1 = TFConstants.T_LIGHTCAVALRY;
            _local_1 = this.currentTroop.lightCavalry;
            _local_1 = TFConstants.T_HEAVYCAVALRY;
            _local_1 = this.currentTroop.heavyCavalry;
            _local_1 = TFConstants.T_CARRIAGE;
            _local_1 = this.currentTroop.carriage;
            _local_1 = TFConstants.T_BALLISTA;
            _local_1 = this.currentTroop.ballista;
            _local_1 = TFConstants.T_BATTERINGRAM;
            _local_1 = this.currentTroop.batteringRam;
            _local_1 = TFConstants.T_CATAPULT;
            _local_1 = this.currentTroop.catapult;
        }

        public function __campaignBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            Bitmap(_arg_1.target.content).smoothing = true;
        }

        public function set campaignBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2083760940campaignBtn;
            if (_local_2 !== _arg_1)
            {
                this._2083760940campaignBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "campaignBtn", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            var _local_1:BuffBean;
            heroDataAry = Context.getInstance().getCurCastle().herosArray;
            currentTroop = Context.getInstance().getCurCastle().troop;
            this.isGoOut = Context.getInstance().getCurCastle().goOutForBattle;
            super.refresh();
            trace((this.className + " refresh()"));
            this.tacticsBtn.enabled = true;
            for each (_local_1 in Context.getInstance().getCurCastle().buffsArray)
            {
                if (_local_1.typeId.indexOf("ForceopenclosegateBuff") != -1)
                {
                    this.tacticsBtn.enabled = false;
                };
            };
        }

        private function _TrainningField_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TrainningField_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___TrainningField_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get campaignBtn():Button
        {
            return (this._2083760940campaignBtn);
        }

        [Bindable(event="propertyChange")]
        private function get currentTroop():TroopBean
        {
            return (this._1458699609currentTroop);
        }

        override public function destroy():void
        {
            if (HospitalWin.instancePopup)
            {
                PopUpManager.removePopUp(HospitalWin.instancePopup);
            };
        }

        internal function onBtnEscapeCamp():void
        {
            UIEscapeCamp.show();
        }


    }
}//package view.module.trainningField

