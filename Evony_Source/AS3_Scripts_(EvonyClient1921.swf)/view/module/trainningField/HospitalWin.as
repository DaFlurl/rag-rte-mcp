// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.HospitalWin

package view.module.trainningField
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.controls.Text;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.CheckBox;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import com.evony.common.beans.TroopBean;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.util.UIUtil;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.common.server.events.InjuredTroopUpdate;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import mx.binding.BindingManager;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import flash.events.Event;
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

    public class HospitalWin extends Canvas implements IBindingClient 
    {

        public static var instancePopup:HospitalWin;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2036223254goldNeed:int;
        private var _1126519287cureBtn:Button;
        public var _HospitalWin_DataGrid1:DataGrid;
        public var _HospitalWin_Text1:Text;
        public var _HospitalWin_Label1:Label;
        private var _857007869demobBtn:Button;
        private var _1495860549btnEnabled:Boolean = false;
        public var _HospitalWin_DataGridColumn1:DataGridColumn;
        public var _HospitalWin_DataGridColumn2:DataGridColumn;
        private var _1536861091checkBox:CheckBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":540,
                    "height":545,
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
                        "type":Text,
                        "id":"_HospitalWin_Text1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                            this.left = "40";
                            this.right = "40";
                            this.top = "64";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":90,
                                "styleName":"ParamgraphText1",
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_HospitalWin_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "159";
                            this.bottom = "66";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_HospitalWin_DataGridColumn1_i(), _HospitalWin_DataGridColumn2_i()]
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
                                    "id":"_HospitalWin_Label1",
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
                        "id":"cureBtn",
                        "events":{"click":"__cureBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.disabledColor = 0xE7E7E7;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "x":130,
                                "y":485
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"demobBtn",
                        "events":{"click":"__demobBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.disabledColor = 0xE7E7E7;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "x":45,
                                "y":485
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":CheckBox,
                        "id":"checkBox",
                        "events":{"click":"__checkBox_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":485,
                                "styleName":"contentheader1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HospitalWin_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var typeAry:Array = new Array("archer", "carriage", "swordsmen", "catapult", "scouter", "militia", "pikemen", "ballista", "heavyCavalry", "lightCavalry", "batteringRam", "peasants");
        private var _110634834troop:TroopBean = new TroopBean();
        private var _1443166814dataAry:ArrayCollection = new ArrayCollection();
        private var currentCastle:CastleBean = Context.getInstance().getCurCastle();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HospitalWin()
        {
            mx_internal::_document = this;
            this.width = 540;
            this.height = 545;
            this.addEventListener("creationComplete", ___HospitalWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HospitalWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (instancePopup == null)
            {
                instancePopup = new (HospitalWin)();
            };
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_INJURED_TROOP_UPDATE, instancePopup.updateTroop);
            if (!instancePopup.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instancePopup);
                PopUpManager.addPopUp(instancePopup, MainFrame.instance, true);
                if ((Application.application.width - instancePopup.width) > 0)
                {
                    instancePopup.x = (((Application.application.width - instancePopup.width) / 2) - 150);
                    instancePopup.y = (((Application.application.height - instancePopup.height) / 2) - 30);
                    PopUpManager.bringToFront(instancePopup);
                }
                else
                {
                    PopUpManager.centerPopUp(instancePopup);
                };
            };
            instancePopup.refresh();
        }


        public function set demobBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._857007869demobBtn;
            if (_local_2 !== _arg_1)
            {
                this._857007869demobBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "demobBtn", _local_2, _arg_1));
            };
        }

        private function _HospitalWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("伤兵在校场的伤兵营中等待治疗");
            _local_1 = dataAry;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("伤兵营");
            _local_1 = Lang.msg("治疗");
            _local_1 = this.btnEnabled;
            _local_1 = Lang.msg("遣散");
            _local_1 = this.btnEnabled;
            _local_1 = Lang.msg("自动治疗");
        }

        private function updateTroop(_arg_1:InjuredTroopUpdate):void
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_4:Object;
            if (_arg_1.castleId == this.currentCastle.id)
            {
                this.goldNeed = _arg_1.goldNeed;
                dataAry.removeAll();
                _local_2 = _arg_1.troop.toObject();
                _local_3 = 0;
                while (_local_3 < typeAry.length)
                {
                    _local_4 = new Object();
                    _local_4["type"] = typeAry[_local_3];
                    _local_4["amount"] = _local_2[typeAry[_local_3]];
                    if (int(_local_2[typeAry[_local_3]]) > 0)
                    {
                        dataAry.addItem(_local_4);
                    };
                    _local_3++;
                };
            };
            if (dataAry.length > 0)
            {
                this.btnEnabled = true;
            };
        }

        private function set btnEnabled(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1495860549btnEnabled;
            if (_local_2 !== _arg_1)
            {
                this._1495860549btnEnabled = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEnabled", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get demobBtn():Button
        {
            return (this._857007869demobBtn);
        }

        override public function initialize():void
        {
            var target:HospitalWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HospitalWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_HospitalWinWatcherSetupUtil");
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

        private function autoHealResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _HospitalWin_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HospitalWin_DataGridColumn1 = _local_1;
            _local_1.dataField = "type";
            _local_1.labelFunction = checkTypeId;
            BindingManager.executeBindings(this, "_HospitalWin_DataGridColumn1", _HospitalWin_DataGridColumn1);
            return (_local_1);
        }

        private function checkTypeId(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            switch (_arg_1.type)
            {
                case "archer":
                    return (Lang.msg("弓箭手"));
                case "ballista":
                    return (Lang.msg("车弩"));
                case "batteringRam":
                    return (Lang.msg("冲车"));
                case "carriage":
                    return (Lang.msg("辎重车"));
                case "catapult":
                    return (Lang.msg("投石车"));
                case "heavyCavalry":
                    return (Lang.msg("铁骑兵"));
                case "lightCavalry":
                    return (Lang.msg("轻骑兵"));
                case "militia":
                    return (Lang.msg("义兵"));
                case "peasants":
                    return (Lang.msg("民夫"));
                case "pikemen":
                    return (Lang.msg("枪兵"));
                case "scouter":
                    return (Lang.msg("斥候"));
                case "swordsmen":
                    return (Lang.msg("刀盾兵"));
                default:
                    return ("");
            };
        }

        private function init():void
        {
            PopUpManager.centerPopUp(this);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_DISBAND_INJURED_TROOP, disbandTroop);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_CURE_INJURED_TROOP, cureTroop);
            checkBox.selected = Context.getInstance().getPlayerBean().autoHeal;
        }

        [Bindable(event="propertyChange")]
        public function get checkBox():CheckBox
        {
            return (this._1536861091checkBox);
        }

        private function set troop(_arg_1:TroopBean):void
        {
            var _local_2:Object = this._110634834troop;
            if (_local_2 !== _arg_1)
            {
                this._110634834troop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troop", _local_2, _arg_1));
            };
        }

        public function __demobBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        private function sendHandler(_arg_1:MouseEvent):void
        {
            if (_arg_1.target.id == "demobBtn")
            {
                ActionFactory.getInstance().getArmyCommands().disbandInjuredTroop(this.currentCastle.id);
                this.btnEnabled = false;
            }
            else
            {
                if (_arg_1.target.id == "cureBtn")
                {
                    AlertWin.show(((((((Lang.msg("治疗这些伤兵需要") + " ") + this.goldNeed) + " ") + Lang.msg("黄金")) + ", ") + Lang.msg("你确定要治疗吗")), cureStart);
                };
            };
        }

        private function cureTroop(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                trace("治疗伤兵成功");
            }
            else
            {
                this.btnEnabled = true;
            };
        }

        [Bindable(event="propertyChange")]
        private function get goldNeed():int
        {
            return (this._2036223254goldNeed);
        }

        private function _HospitalWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("伤兵在校场的伤兵营中等待治疗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HospitalWin_Text1.text = _arg_1;
            }, "_HospitalWin_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (dataAry);
            }, function (_arg_1:Object):void
            {
                _HospitalWin_DataGrid1.dataProvider = _arg_1;
            }, "_HospitalWin_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兵种");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HospitalWin_DataGridColumn1.headerText = _arg_1;
            }, "_HospitalWin_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HospitalWin_DataGridColumn2.headerText = _arg_1;
            }, "_HospitalWin_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("伤兵营");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HospitalWin_Label1.text = _arg_1;
            }, "_HospitalWin_Label1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("治疗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cureBtn.label = _arg_1;
            }, "cureBtn.label");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnabled);
            }, function (_arg_1:Boolean):void
            {
                cureBtn.enabled = _arg_1;
            }, "cureBtn.enabled");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("遣散");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                demobBtn.label = _arg_1;
            }, "demobBtn.label");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnabled);
            }, function (_arg_1:Boolean):void
            {
                demobBtn.enabled = _arg_1;
            }, "demobBtn.enabled");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("自动治疗");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                checkBox.label = _arg_1;
            }, "checkBox.label");
            result[9] = binding;
            return (result);
        }

        private function set goldNeed(_arg_1:int):void
        {
            var _local_2:Object = this._2036223254goldNeed;
            if (_local_2 !== _arg_1)
            {
                this._2036223254goldNeed = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goldNeed", _local_2, _arg_1));
            };
        }

        private function cureStart(_arg_1:Boolean):void
        {
            if (this.goldNeed <= Context.getInstance().getCurCastle().resource.gold)
            {
                if (_arg_1)
                {
                    ActionFactory.getInstance().getArmyCommands().cureInjuredTroop(this.currentCastle.id);
                    this.btnEnabled = false;
                };
            }
            else
            {
                AlertWin.show(Lang.msg("当前黄金不够治疗伤兵"));
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
        private function get btnEnabled():Boolean
        {
            return (this._1495860549btnEnabled);
        }

        public function set checkBox(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1536861091checkBox;
            if (_local_2 !== _arg_1)
            {
                this._1536861091checkBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "checkBox", _local_2, _arg_1));
            };
        }

        public function __checkBox_click(_arg_1:MouseEvent):void
        {
            changSet(_arg_1);
        }

        private function changSet(_arg_1:Event):void
        {
            ActionFactory.getInstance().getCommonCommands().setAutoHeal(CheckBox(_arg_1.target).selected, autoHealResponse);
        }

        private function disbandTroop(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                trace("遣散伤兵成功");
            }
            else
            {
                this.btnEnabled = true;
            };
        }

        [Bindable(event="propertyChange")]
        private function get troop():TroopBean
        {
            return (this._110634834troop);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function _HospitalWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _HospitalWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "amount";
            BindingManager.executeBindings(this, "_HospitalWin_DataGridColumn2", _HospitalWin_DataGridColumn2);
            return (_local_1);
        }

        private function refresh():void
        {
            currentCastle = Context.getInstance().getCurCastle();
            ActionFactory.getInstance().getArmyCommands().getInjuredTroop(this.currentCastle.id, getInjuredTroop);
        }

        public function __cureBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        private function getInjuredTroop(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                trace("获取伤兵成功");
            };
        }

        public function ___HospitalWin_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get cureBtn():Button
        {
            return (this._1126519287cureBtn);
        }

        public function ___HospitalWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set cureBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1126519287cureBtn;
            if (_local_2 !== _arg_1)
            {
                this._1126519287cureBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cureBtn", _local_2, _arg_1));
            };
        }


    }
}//package view.module.trainningField

