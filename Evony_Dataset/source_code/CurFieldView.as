// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.CurFieldView

package view.module.office
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.castle.world.ButtonWithIcon;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.Coordinate;
    import com.evony.common.beans.FieldBean;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.common.beans.BuildingBean;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.Context;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.constants.BuildingConstants;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import mx.core.ClassFactory;
    import com.evony.data.NewArmyEventData;
    import com.evony.common.constants.ObjConstants;
    import view.AllWindows;
    import view.module.trainningField.NewArmyWin;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.beans.ArmyBean;
    import com.evony.common.constants.FieldConstants;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
    import com.evony.client.response.ResponseDispatcher;
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

    public class CurFieldView extends Canvas implements IBindingClient 
    {

        private static var instancePopup:CurFieldView;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1980362660sentBtn:ButtonWithIcon;
        private var _2055500644isBuild:Boolean;
        private var _1409292576armyDG:DataGrid;
        private var _30039314isCanSend:Boolean = true;
        private var _2133411019isCanCallBack:Boolean = false;
        private var _236641304yieldpercent:String;
        private var _1724546052description:Label;
        public var _CurFieldView_DataGridColumn1:DataGridColumn;
        public var _CurFieldView_DataGridColumn2:DataGridColumn;
        public var _CurFieldView_DataGridColumn3:DataGridColumn;
        public var _CurFieldView_DataGridColumn4:DataGridColumn;
        private var coo:Coordinate;
        private var _1264655306fieldBean:FieldBean;
        private var _845629382hasTrainingField:Boolean;
        private var _102865796level:Label;
        private var _2036861603hasTrainingFieldTooltip:String;
        private var _1446942000giveUpBtn:Button;
        private var _1616502844collectTimes:Number;
        public var _CurFieldView_Label1:Label;
        public var _CurFieldView_Label3:Label;
        private var _1274708334fieldL:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":315,
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
                                    "id":"_CurFieldView_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"armyDG",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.left = "20";
                            this.right = "20";
                            this.top = "73";
                            this.bottom = "46";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "rowHeight":32.1,
                                "columns":[_CurFieldView_DataGridColumn1_i(), _CurFieldView_DataGridColumn2_i(), _CurFieldView_DataGridColumn3_i(), _CurFieldView_DataGridColumn4_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"giveUpBtn",
                        "events":{"click":"__giveUpBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.bottom = "17";
                            this.left = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":35,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"description",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"x":203});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.left = "10";
                                        this.verticalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_CurFieldView_Label3"
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"level"
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                            this.bottom = "17";
                            this.horizontalAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":292,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ButtonWithIcon,
                                    "id":"sentBtn",
                                    "events":{"click":"__sentBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "17";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "MyIcon":"images/EmbedImages/common/button/viewField/gotosend.png",
                                            "height":23
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CurFieldView_Button2_click"},
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
        private var _11631042goBackStr:String = Lang.msg("召回");
        private var _738398332armyArr:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CurFieldView()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 315;
            this.addEventListener("creationComplete", ___CurFieldView_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CurFieldView._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:FieldBean, _arg_2:Coordinate, _arg_3:String):void
        {
            var _local_5:BuildingBean;
            if (instancePopup == null)
            {
                instancePopup = new (CurFieldView)();
            };
            UIUtil.setPopopHelpWindowStye(instancePopup);
            MinePopupManager.instance.addPopup(instancePopup, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instancePopup.bean = _arg_1;
            instancePopup.coord = _arg_2;
            instancePopup.coordinate = _arg_3;
            instancePopup.hasTrainingField = false;
            var _local_4:CastleBean = Context.getInstance().getCurCastle();
            for each (_local_5 in _local_4.buildingsArray)
            {
                if (_local_5.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
                {
                    instancePopup.hasTrainingField = true;
                    break;
                };
            };
            if (instancePopup.hasTrainingField)
            {
                instancePopup.hasTrainingFieldTooltip = null;
            }
            else
            {
                instancePopup.hasTrainingFieldTooltip = Lang.msg("请先建造校场");
            };
        }


        public function set level(_arg_1:Label):void
        {
            var _local_2:Object = this._102865796level;
            if (_local_2 !== _arg_1)
            {
                this._102865796level = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "level", _local_2, _arg_1));
            };
        }

        public function init():void
        {
        }

        private function _CurFieldView_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CurFieldView_DataGridColumn4 = _local_1;
            _local_1.dataField = "armyId";
            _local_1.itemRenderer = _CurFieldView_ClassFactory1_c();
            BindingManager.executeBindings(this, "_CurFieldView_DataGridColumn4", _CurFieldView_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get yieldpercent():String
        {
            return (this._236641304yieldpercent);
        }

        private function _CurFieldView_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = CurFieldView_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set fieldL(_arg_1:String):void
        {
            var _local_2:Object = this._1274708334fieldL;
            if (_local_2 !== _arg_1)
            {
                this._1274708334fieldL = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldL", _local_2, _arg_1));
            };
        }

        private function set armyArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._738398332armyArr;
            if (_local_2 !== _arg_1)
            {
                this._738398332armyArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyArr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get giveUpBtn():Button
        {
            return (this._1446942000giveUpBtn);
        }

        private function missionSend():void
        {
            trace("开始派遣");
            var _local_1:NewArmyEventData = new NewArmyEventData();
            _local_1.x = this.coo.x;
            _local_1.y = this.coo.y;
            _local_1.missionType = ObjConstants.ARMY_MISSION_SEND;
            AllWindows.switchToFuncWindow(NewArmyWin.EVENT_SHOW, _local_1);
            closeOwner();
        }

        private function set yieldpercent(_arg_1:String):void
        {
            var _local_2:Object = this._236641304yieldpercent;
            if (_local_2 !== _arg_1)
            {
                this._236641304yieldpercent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yieldpercent", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get collectTimes():Number
        {
            return (this._1616502844collectTimes);
        }

        public function set sentBtn(_arg_1:ButtonWithIcon):void
        {
            var _local_2:Object = this._1980362660sentBtn;
            if (_local_2 !== _arg_1)
            {
                this._1980362660sentBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sentBtn", _local_2, _arg_1));
            };
        }

        public function __sentBtn_click(_arg_1:MouseEvent):void
        {
            missionSend();
        }

        private function _CurFieldView_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CurFieldView_DataGridColumn3 = _local_1;
            _local_1.dataField = "startPosName";
            _local_1.width = 130;
            BindingManager.executeBindings(this, "_CurFieldView_DataGridColumn3", _CurFieldView_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get hasTrainingFieldTooltip():String
        {
            return (this._2036861603hasTrainingFieldTooltip);
        }

        public function set giveUpBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1446942000giveUpBtn;
            if (_local_2 !== _arg_1)
            {
                this._1446942000giveUpBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "giveUpBtn", _local_2, _arg_1));
            };
        }

        private function onCityConstructCastle(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set bean(_arg_1:FieldBean):void
        {
            var _local_2:ArmyBean;
            armyArr.removeAll();
            this.fieldBean = _arg_1;
            if (((this.fieldBean.type == FieldConstants.TYPE_FLAT) && (this.fieldBean.armysArray.length > 0)))
            {
                isBuild = true;
            }
            else
            {
                isBuild = false;
            };
            if (this.fieldBean.armysArray != null)
            {
                for each (_local_2 in this.fieldBean.armysArray)
                {
                    armyArr.addItem(_local_2);
                };
            };
            isCanSend = true;
        }

        private function callBackArmyHandle(_arg_1:CommandResponse):void
        {
            var _local_2:ArmyBean;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("军队成功召回"));
                armyArr.removeAll();
                if (this.fieldBean.type == FieldConstants.TYPE_FLAT)
                {
                    isBuild = true;
                }
                else
                {
                    isBuild = false;
                };
                if (this.fieldBean.armysArray != null)
                {
                    for each (_local_2 in this.fieldBean.armysArray)
                    {
                        armyArr.addItem(_local_2);
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get isBuild():Boolean
        {
            return (this._2055500644isBuild);
        }

        private function set collectTimes(_arg_1:Number):void
        {
            var _local_2:Object = this._1616502844collectTimes;
            if (_local_2 !== _arg_1)
            {
                this._1616502844collectTimes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "collectTimes", _local_2, _arg_1));
            };
        }

        private function _CurFieldView_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.fieldBean.name + " ") + this.fieldL);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_Label1.text = _arg_1;
            }, "_CurFieldView_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (armyArr);
            }, function (_arg_1:Object):void
            {
                armyDG.dataProvider = _arg_1;
            }, "armyDG.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_DataGridColumn1.headerText = _arg_1;
            }, "_CurFieldView_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("君主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_DataGridColumn2.headerText = _arg_1;
            }, "_CurFieldView_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_DataGridColumn3.headerText = _arg_1;
            }, "_CurFieldView_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("操作");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_DataGridColumn4.headerText = _arg_1;
            }, "_CurFieldView_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("放弃");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                giveUpBtn.label = _arg_1;
            }, "giveUpBtn.label");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CurFieldView_Label3.text = _arg_1;
            }, "_CurFieldView_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fieldBean.level;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                level.text = _arg_1;
            }, "level.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("派遣");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sentBtn.myLabel = _arg_1;
            }, "sentBtn.myLabel");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isCanSend);
            }, function (_arg_1:Boolean):void
            {
                sentBtn.visible = _arg_1;
            }, "sentBtn.visible");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (hasTrainingField);
            }, function (_arg_1:Boolean):void
            {
                sentBtn.enabled = _arg_1;
            }, "sentBtn.enabled");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.hasTrainingFieldTooltip;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                sentBtn.toolTip = _arg_1;
            }, "sentBtn.toolTip");
            result[12] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get armyArr():ArrayCollection
        {
            return (this._738398332armyArr);
        }

        [Bindable(event="propertyChange")]
        public function get level():Label
        {
            return (this._102865796level);
        }

        override public function initialize():void
        {
            var target:CurFieldView;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CurFieldView_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_CurFieldViewWatcherSetupUtil");
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

        public function set goBackStr(_arg_1:String):void
        {
            var _local_2:Object = this._11631042goBackStr;
            if (_local_2 !== _arg_1)
            {
                this._11631042goBackStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "goBackStr", _local_2, _arg_1));
            };
        }

        private function _CurFieldView_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CurFieldView_DataGridColumn2 = _local_1;
            _local_1.dataField = "king";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_CurFieldView_DataGridColumn2", _CurFieldView_DataGridColumn2);
            return (_local_1);
        }

        private function closeOwner():void
        {
            if (this.parent != null)
            {
                MinePopupManager.instance.removePopup();
            };
        }

        private function set isCanCallBack(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2133411019isCanCallBack;
            if (_local_2 !== _arg_1)
            {
                this._2133411019isCanCallBack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanCallBack", _local_2, _arg_1));
            };
        }

        public function recallHandle(_arg_1:MouseEvent):void
        {
            ActionFactory.getInstance().getArmyCommands().callBackArmy(Context.getInstance().getCurCastle().id, _arg_1.target.armyTypeId, callBackArmyHandle);
        }

        [Bindable(event="propertyChange")]
        private function get fieldL():String
        {
            return (this._1274708334fieldL);
        }

        private function sendHandler(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.id)
            {
                case "giveUpBtn":
                    ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.FIELD_GIVE_UP_FIELD, giveUpResponse);
                    ActionFactory.getInstance().getFieldCommand().giveUpField(this.fieldBean.id);
                    return;
                case "harvestBtn":
                    return;
            };
        }

        private function set fieldBean(_arg_1:FieldBean):void
        {
            var _local_2:Object = this._1264655306fieldBean;
            if (_local_2 !== _arg_1)
            {
                this._1264655306fieldBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldBean", _local_2, _arg_1));
            };
        }

        public function ___CurFieldView_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___CurFieldView_Button2_click(_arg_1:MouseEvent):void
        {
            closeOwner();
        }

        [Bindable(event="propertyChange")]
        public function get sentBtn():ButtonWithIcon
        {
            return (this._1980362660sentBtn);
        }

        private function set hasTrainingField(_arg_1:Boolean):void
        {
            var _local_2:Object = this._845629382hasTrainingField;
            if (_local_2 !== _arg_1)
            {
                this._845629382hasTrainingField = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTrainingField", _local_2, _arg_1));
            };
        }

        private function set hasTrainingFieldTooltip(_arg_1:String):void
        {
            var _local_2:Object = this._2036861603hasTrainingFieldTooltip;
            if (_local_2 !== _arg_1)
            {
                this._2036861603hasTrainingFieldTooltip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasTrainingFieldTooltip", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get goBackStr():String
        {
            return (this._11631042goBackStr);
        }

        public function set armyDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1409292576armyDG;
            if (_local_2 !== _arg_1)
            {
                this._1409292576armyDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyDG", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get fieldBean():FieldBean
        {
            return (this._1264655306fieldBean);
        }

        [Bindable(event="propertyChange")]
        private function get isCanCallBack():Boolean
        {
            return (this._2133411019isCanCallBack);
        }

        [Bindable(event="propertyChange")]
        private function get hasTrainingField():Boolean
        {
            return (this._845629382hasTrainingField);
        }

        private function set isBuild(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2055500644isBuild;
            if (_local_2 !== _arg_1)
            {
                this._2055500644isBuild = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isBuild", _local_2, _arg_1));
            };
        }

        public function __giveUpBtn_click(_arg_1:MouseEvent):void
        {
            sendHandler(_arg_1);
        }

        private function _CurFieldView_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _CurFieldView_DataGridColumn1 = _local_1;
            _local_1.dataField = "hero";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_CurFieldView_DataGridColumn1", _CurFieldView_DataGridColumn1);
            return (_local_1);
        }

        private function set isCanSend(_arg_1:Boolean):void
        {
            var _local_2:Object = this._30039314isCanSend;
            if (_local_2 !== _arg_1)
            {
                this._30039314isCanSend = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanSend", _local_2, _arg_1));
            };
        }

        private function _CurFieldView_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.fieldBean.name + " ") + this.fieldL);
            _local_1 = armyArr;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("君主");
            _local_1 = Lang.msg("出发地");
            _local_1 = Lang.msg("操作");
            _local_1 = Lang.msg("放弃");
            _local_1 = Lang.msg("等级");
            _local_1 = this.fieldBean.level;
            _local_1 = Lang.msg("派遣");
            _local_1 = isCanSend;
            _local_1 = hasTrainingField;
            _local_1 = this.hasTrainingFieldTooltip;
        }

        public function set _isCanSend(_arg_1:Boolean):void
        {
            isCanSend = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public function get armyDG():DataGrid
        {
            return (this._1409292576armyDG);
        }

        public function set coord(_arg_1:Coordinate):void
        {
            this.coo = _arg_1;
        }

        [Bindable(event="propertyChange")]
        private function get isCanSend():Boolean
        {
            return (this._30039314isCanSend);
        }

        public function set coordinate(_arg_1:String):void
        {
            this.fieldL = _arg_1;
        }

        private function giveUpResponse(_arg_1:CommandResponse):void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.FIELD_GIVE_UP_FIELD, giveUpResponse);
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("成功放弃野地"));
                closeOwner();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set description(_arg_1:Label):void
        {
            var _local_2:Object = this._1724546052description;
            if (_local_2 !== _arg_1)
            {
                this._1724546052description = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "description", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get description():Label
        {
            return (this._1724546052description);
        }


    }
}//package view.module.office

