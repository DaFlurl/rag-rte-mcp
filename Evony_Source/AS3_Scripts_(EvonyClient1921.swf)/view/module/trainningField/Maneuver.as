// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.Maneuver

package view.module.trainningField
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.TextArea;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.TroopBean;
    import com.evony.common.constants.TFConstants;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.ClassFactory;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.Event;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import view.AllWindows;
    import flash.events.MouseEvent;
    import com.evony.common.module.army.ArmyPracticeResponse;
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

    public class Maneuver extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Maneuver.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _Maneuver_Label1:Label;
        private var _647757241defendDG:DataGrid;
        private var _926713076returnBtn:Button;
        private var _538739915attackDG:DataGrid;
        public var _Maneuver_TextArea1:TextArea;
        public var _Maneuver_DataGridColumn1:DataGridColumn;
        public var _Maneuver_DataGridColumn2:DataGridColumn;
        public var _Maneuver_DataGridColumn3:DataGridColumn;
        public var _Maneuver_DataGridColumn4:DataGridColumn;
        public var _Maneuver_DataGridColumn5:DataGridColumn;
        public var _Maneuver_DataGridColumn6:DataGridColumn;
        private var _1382351924definiteBtn:Button;
        private var _1543441387exerciseResult:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_Maneuver_Label1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"winTitleFont",
                                "y":5
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_Maneuver_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.top = "388";
                            this.left = "35";
                            this.textAlign = "left";
                            this.right = "35";
                            this.bottom = "43";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"labelWithBackGround",
                                "editable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "35";
                            this.horizontalAlign = "right";
                            this.bottom = "17";
                            this.horizontalGap = 6;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"definiteBtn",
                                    "events":{"click":"__definiteBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"returnBtn",
                                    "events":{"click":"__returnBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b75"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "55";
                            this.left = "34";
                            this.right = "34";
                            this.horizontalGap = 5;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":390,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"attackDG",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "styleName":"style2",
                                            "rowHeight":30,
                                            "resizableColumns":false,
                                            "sortableColumns":false,
                                            "selectable":false,
                                            "editable":false,
                                            "percentHeight":100,
                                            "draggableColumns":false,
                                            "columns":[_Maneuver_DataGridColumn1_i(), _Maneuver_DataGridColumn2_i(), _Maneuver_DataGridColumn3_i()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"defendDG",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.textAlign = "center";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "rowCount":12,
                                            "rowHeight":30,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "sortableColumns":false,
                                            "percentWidth":50,
                                            "selectable":false,
                                            "editable":false,
                                            "percentHeight":100,
                                            "draggableColumns":false,
                                            "columns":[_Maneuver_DataGridColumn4_i(), _Maneuver_DataGridColumn5_i(), _Maneuver_DataGridColumn6_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1584104182attackDataAry:ArrayCollection = new ArrayCollection();
        private var _352817464defendDataAry:ArrayCollection = new ArrayCollection();
        private var attackTroop:TroopBean = new TroopBean();
        private var defendTroop:TroopBean = new TroopBean();
        private var constantsAry:Array = new Array(TFConstants.T_PEASANTS, TFConstants.T_MILITIA, TFConstants.T_SCOUTER, TFConstants.T_PIKEMAN, TFConstants.T_SWORDSMEN, TFConstants.T_ARCHER, TFConstants.T_LIGHTCAVALRY, TFConstants.T_HEAVYCAVALRY, TFConstants.T_CARRIAGE, TFConstants.T_BALLISTA, TFConstants.T_BATTERINGRAM, TFConstants.T_CATAPULT);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Maneuver()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___Maneuver_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___Maneuver_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Maneuver._watcherSetupUtil = _arg_1;
        }


        private function setTroopAmount(_arg_1:TroopTypeObj, _arg_2:TroopBean):void
        {
            switch (_arg_1.id)
            {
                case TFConstants.T_ARCHER:
                    _arg_2.archer = _arg_1.fightAmount;
                    return;
                case TFConstants.T_BALLISTA:
                    _arg_2.ballista = _arg_1.fightAmount;
                    return;
                case TFConstants.T_BATTERINGRAM:
                    _arg_2.batteringRam = _arg_1.fightAmount;
                    return;
                case TFConstants.T_CARRIAGE:
                    _arg_2.carriage = _arg_1.fightAmount;
                    return;
                case TFConstants.T_CATAPULT:
                    _arg_2.catapult = _arg_1.fightAmount;
                    return;
                case TFConstants.T_HEAVYCAVALRY:
                    _arg_2.heavyCavalry = _arg_1.fightAmount;
                    return;
                case TFConstants.T_LIGHTCAVALRY:
                    _arg_2.lightCavalry = _arg_1.fightAmount;
                    return;
                case TFConstants.T_MILITIA:
                    _arg_2.militia = _arg_1.fightAmount;
                    return;
                case TFConstants.T_PEASANTS:
                    _arg_2.peasants = _arg_1.fightAmount;
                    return;
                case TFConstants.T_PIKEMAN:
                    _arg_2.pikemen = _arg_1.fightAmount;
                    return;
                case TFConstants.T_SCOUTER:
                    _arg_2.scouter = _arg_1.fightAmount;
                    return;
                case TFConstants.T_SWORDSMEN:
                    _arg_2.swordsmen = _arg_1.fightAmount;
                    return;
            };
        }

        private function _Maneuver_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn2 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _Maneuver_ClassFactory2_c();
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn2", _Maneuver_DataGridColumn2);
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:Maneuver;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Maneuver_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_ManeuverWatcherSetupUtil");
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

        private function _Maneuver_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn4 = _local_1;
            _local_1.dataField = "name";
            _local_1.editable = false;
            _local_1.itemRenderer = _Maneuver_ClassFactory3_c();
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn4", _Maneuver_DataGridColumn4);
            return (_local_1);
        }

        private function _Maneuver_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn6 = _local_1;
            _local_1.dataField = "loseAmount";
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn6", _Maneuver_DataGridColumn6);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get exerciseResult():String
        {
            return (this._1543441387exerciseResult);
        }

        [Bindable(event="propertyChange")]
        public function get returnBtn():Button
        {
            return (this._926713076returnBtn);
        }

        private function _Maneuver_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Maneuver_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set attackDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._538739915attackDG;
            if (_local_2 !== _arg_1)
            {
                this._538739915attackDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attackDG", _local_2, _arg_1));
            };
        }

        private function _Maneuver_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Maneuver_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_EXERCISE_ARMY, exercisResult);
        }

        public function ___Maneuver_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function _Maneuver_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("演习");
            _local_1 = this.exerciseResult;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("返回");
            _local_1 = attackDataAry;
            _local_1 = Lang.msg("进攻方");
            _local_1 = Lang.msg("出战人数");
            _local_1 = Lang.msg("战斗损失");
            _local_1 = defendDataAry;
            _local_1 = Lang.msg("防守方");
            _local_1 = Lang.msg("出战人数");
            _local_1 = Lang.msg("战斗损失");
        }

        private function set defendDataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._352817464defendDataAry;
            if (_local_2 !== _arg_1)
            {
                this._352817464defendDataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defendDataAry", _local_2, _arg_1));
            };
        }

        private function clickHandler(_arg_1:MouseEvent):void
        {
            var _local_2:TroopTypeObj;
            var _local_3:TroopTypeObj;
            if (_arg_1.target.id == "definiteBtn")
            {
                trace("definiteBtn");
                for each (_local_2 in this.attackDG.dataProvider)
                {
                    setTroopAmount(TroopTypeObj(_local_2), attackTroop);
                };
                for each (_local_3 in this.defendDG.dataProvider)
                {
                    setTroopAmount(TroopTypeObj(_local_3), defendTroop);
                };
                trace(((attackTroop.archer + "---") + defendTroop.archer));
                ActionFactory.getInstance().getArmyCommands().exerciseArmy(Context.getInstance().getCurCastle().id, attackTroop, defendTroop);
            }
            else
            {
                if (_arg_1.target.id == "returnBtn")
                {
                    AllWindows.switchToBuildingWindow(TrainningField.EVENT_SHOW, TrainningField.instance.getBuildingBean());
                    trace("definiteBtn");
                };
            };
        }

        private function exercisResult(_arg_1:ArmyPracticeResponse):void
        {
            var _local_2:Array;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:Object;
            var _local_6:Object;
            if (_arg_1.ok)
            {
                _local_2 = new Array();
                _local_3 = new Array();
                getTroopBeanValue(_arg_1.attackLostTroop, _local_2);
                getTroopBeanValue(_arg_1.defendLostTroop, _local_3);
                _local_4 = 0;
                while (_local_4 < _local_2.length)
                {
                    _local_5 = attackDataAry.getItemAt(_local_4);
                    _local_5.loseAmount = _local_2[_local_4];
                    _local_6 = defendDataAry.getItemAt(_local_4);
                    _local_6.loseAmount = _local_3[_local_4];
                    _local_4++;
                };
                if (_arg_1.result == ArmyPracticeResponse.ARMY_PRACTICE_RESULT_ATTACK_WIN)
                {
                    this.exerciseResult = ((Lang.msg("进攻方赢") + ", ") + Lang.msg("演习持续{0}回合", _arg_1.round));
                }
                else
                {
                    this.exerciseResult = ((Lang.msg("防守方赢") + ", ") + Lang.msg("演习持续{0}回合", _arg_1.round));
                };
            };
        }

        private function set exerciseResult(_arg_1:String):void
        {
            var _local_2:Object = this._1543441387exerciseResult;
            if (_local_2 !== _arg_1)
            {
                this._1543441387exerciseResult = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exerciseResult", _local_2, _arg_1));
            };
        }

        public function __returnBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get defendDG():DataGrid
        {
            return (this._647757241defendDG);
        }

        public function set definiteBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1382351924definiteBtn;
            if (_local_2 !== _arg_1)
            {
                this._1382351924definiteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "definiteBtn", _local_2, _arg_1));
            };
        }

        public function set returnBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._926713076returnBtn;
            if (_local_2 !== _arg_1)
            {
                this._926713076returnBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "returnBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get attackDG():DataGrid
        {
            return (this._538739915attackDG);
        }

        private function _Maneuver_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn1 = _local_1;
            _local_1.itemRenderer = _Maneuver_ClassFactory1_c();
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn1", _Maneuver_DataGridColumn1);
            return (_local_1);
        }

        override public function refresh():void
        {
            var _local_1:int;
            var _local_2:int;
            var _local_3:TroopTypeObj;
            var _local_4:TroopTypeObj;
            this.attackDataAry.removeAll();
            this.defendDataAry.removeAll();
            for each (_local_1 in constantsAry)
            {
                _local_3 = new TroopTypeObj();
                _local_3.typeId = _local_1;
                _local_3.fightAmount = 0;
                _local_3.loseAmount = 0;
                this.attackDataAry.addItem(_local_3);
            };
            for each (_local_2 in constantsAry)
            {
                _local_4 = new TroopTypeObj();
                _local_4.typeId = _local_2;
                _local_4.fightAmount = 0;
                _local_4.loseAmount = 0;
                this.defendDataAry.addItem(_local_4);
            };
            this.exerciseResult = "";
        }

        private function _Maneuver_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Maneuver_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _Maneuver_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn3 = _local_1;
            _local_1.dataField = "loseAmount";
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn3", _Maneuver_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get defendDataAry():ArrayCollection
        {
            return (this._352817464defendDataAry);
        }

        private function _Maneuver_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Maneuver_DataGridColumn5 = _local_1;
            _local_1.width = 100;
            _local_1.itemRenderer = _Maneuver_ClassFactory4_c();
            BindingManager.executeBindings(this, "_Maneuver_DataGridColumn5", _Maneuver_DataGridColumn5);
            return (_local_1);
        }

        public function ___Maneuver_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _Maneuver_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Maneuver_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _Maneuver_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("演习");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_Label1.text = _arg_1;
            }, "_Maneuver_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.exerciseResult;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_TextArea1.text = _arg_1;
            }, "_Maneuver_TextArea1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                definiteBtn.label = _arg_1;
            }, "definiteBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                returnBtn.label = _arg_1;
            }, "returnBtn.label");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (attackDataAry);
            }, function (_arg_1:Object):void
            {
                attackDG.dataProvider = _arg_1;
            }, "attackDG.dataProvider");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("进攻方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn1.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn1.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出战人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn2.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn2.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("战斗损失");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn3.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn3.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (defendDataAry);
            }, function (_arg_1:Object):void
            {
                defendDG.dataProvider = _arg_1;
            }, "defendDG.dataProvider");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("防守方");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn4.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn4.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出战人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn5.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn5.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("战斗损失");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Maneuver_DataGridColumn6.headerText = _arg_1;
            }, "_Maneuver_DataGridColumn6.headerText");
            result[11] = binding;
            return (result);
        }

        public function set defendDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._647757241defendDG;
            if (_local_2 !== _arg_1)
            {
                this._647757241defendDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "defendDG", _local_2, _arg_1));
            };
        }

        private function getTroopBeanValue(_arg_1:TroopBean, _arg_2:Array):void
        {
            _arg_2.push(_arg_1.peasants);
            _arg_2.push(_arg_1.militia);
            _arg_2.push(_arg_1.scouter);
            _arg_2.push(_arg_1.pikemen);
            _arg_2.push(_arg_1.swordsmen);
            _arg_2.push(_arg_1.archer);
            _arg_2.push(_arg_1.lightCavalry);
            _arg_2.push(_arg_1.heavyCavalry);
            _arg_2.push(_arg_1.carriage);
            _arg_2.push(_arg_1.ballista);
            _arg_2.push(_arg_1.batteringRam);
            _arg_2.push(_arg_1.catapult);
        }

        public function __definiteBtn_click(_arg_1:MouseEvent):void
        {
            clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get definiteBtn():Button
        {
            return (this._1382351924definiteBtn);
        }

        override public function destroy():void
        {
        }

        private function set attackDataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1584104182attackDataAry;
            if (_local_2 !== _arg_1)
            {
                this._1584104182attackDataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attackDataAry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get attackDataAry():ArrayCollection
        {
            return (this._1584104182attackDataAry);
        }


    }
}//package view.module.trainningField

