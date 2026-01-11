// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.embassy.Embassy

package view.module.embassy
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.CheckBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import com.evony.Lang;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import view.AllWindows;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.common.server.events.BuildComplate;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import com.evony.client.action.ActionFactory;
    import view.ui.AlertWin;
    import mx.binding.BindingManager;
    import view.module.alliance.AllianceWin;
    import mx.core.ClassFactory;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import com.evony.common.module.army.StayAllianceReponse;
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

    public class Embassy extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Embassy.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _Embassy_DataGridColumn2:DataGridColumn;
        public var _Embassy_DataGridColumn3:DataGridColumn;
        public var _Embassy_DataGridColumn5:DataGridColumn;
        public var _Embassy_DataGridColumn4:DataGridColumn;
        public var _Embassy_DataGridColumn6:DataGridColumn;
        private var _1550422840isAllowStay:Boolean;
        private var _397924048buildingLevel:int;
        public var _Embassy_Label1:Label;
        public var _Embassy_Label2:Label;
        public var _Embassy_Label3:Label;
        public var _Embassy_DataGrid1:DataGrid;
        public var _Embassy_Text1:Text;
        public var _Embassy_Text2:Text;
        public var _Embassy_Button1:Button;
        private var _1710339150canGarrisonCB:CheckBox;
        public var _Embassy_DataGridColumn1:DataGridColumn;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "2";
                                        this.horizontalGap = 0;
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Embassy_Label1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":180
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_Embassy_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":200});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_Embassy_Button1",
                                                "events":{"click":"___Embassy_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b95"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "32";
                                        this.horizontalGap = 0;
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Embassy_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":180
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_Embassy_Text2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyValue1",
                                                        "width":100,
                                                        "height":22
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"canGarrisonCB",
                                                "events":{"click":"__canGarrisonCB_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":23});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_Embassy_Label3",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"ParamgraphText1",
                                                        "width":400
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_Embassy_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.verticalAlign = "middle";
                            this.top = "60";
                            this.bottom = "1";
                            this.right = "1";
                            this.left = "1";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_Embassy_DataGridColumn1_i(), _Embassy_DataGridColumn2_i(), _Embassy_DataGridColumn3_i(), _Embassy_DataGridColumn4_i(), _Embassy_DataGridColumn5_i(), _Embassy_DataGridColumn6_i()]
                            });
                        }
                    })]});
            }
        });
        private var _11631042goBackStr:String = Lang.msg("遣返");
        private var _1852931706allianceStr:String = Context.getInstance().getPlayerBean().playerInfo.alliance;
        private var _311824617stayArmysDP:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Embassy()
        {
            mx_internal::_document = this;
            this.percentHeight = 100;
            this.percentWidth = 100;
            this.addEventListener("creationComplete", ___Embassy_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Embassy._watcherSetupUtil = _arg_1;
        }


        private function onBuildingComplete(_arg_1:BuildComplate):void
        {
            if (((((_arg_1.castleId == Context.getInstance().getCurCastle().id) && (_arg_1.buildingBean.typeId == BuildingConstants.TYPE_EMBASSY)) && (AllWindows.instance.visible == true)) && (AllWindows.instance.buildingInfoVs.embassyVs.visible == true)))
            {
                checkLevel();
            };
            trace((this.className + ".onBuildingComplete()"));
        }

        override public function initialize():void
        {
            var target:Embassy;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Embassy_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_embassy_EmbassyWatcherSetupUtil");
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

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ARMY_GET_STAY_ALLIANCE_ARMYS, onGetStayAllianceArmys);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onBuildingComplete);
        }

        private function onCallBackArmy(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                trace(((this.name + " onCallBackArmy ") + " success"));
                ActionFactory.getInstance().getArmyCommands().getStayAllianceArmys(Context.getInstance().getCurCastle().id);
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get stayArmysDP():ArrayCollection
        {
            return (this._311824617stayArmysDP);
        }

        private function _Embassy_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn5 = _local_1;
            _local_1.dataField = "reachTime";
            _local_1.itemRenderer = _Embassy_ClassFactory2_c();
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn5", _Embassy_DataGridColumn5);
            return (_local_1);
        }

        private function enterAlliance():void
        {
            AllWindows.switchToFuncWindow(AllianceWin.EVENT_SHOW);
        }

        private function _Embassy_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn1 = _local_1;
            _local_1.dataField = "hero";
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn1", _Embassy_DataGridColumn1);
            return (_local_1);
        }

        private function _Embassy_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn3 = _local_1;
            _local_1.dataField = "startPosName";
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn3", _Embassy_DataGridColumn3);
            return (_local_1);
        }

        private function _Embassy_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Embassy_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get buildingLevel():int
        {
            return (this._397924048buildingLevel);
        }

        private function _Embassy_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Embassy_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get canGarrisonCB():CheckBox
        {
            return (this._1710339150canGarrisonCB);
        }

        [Bindable(event="propertyChange")]
        public function get goBackStr():String
        {
            return (this._11631042goBackStr);
        }

        private function _Embassy_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("所属联盟") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Label1.text = _arg_1;
            }, "_Embassy_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Text1.text = _arg_1;
            }, "_Embassy_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("进入联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Button1.label = _arg_1;
            }, "_Embassy_Button1.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("盟友进驻军队数量") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Label2.text = _arg_1;
            }, "_Embassy_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((stayArmysDP.length + "/") + this.buildingLevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Text2.text = _arg_1;
            }, "_Embassy_Text2.text");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (isAllowStay);
            }, function (_arg_1:Boolean):void
            {
                canGarrisonCB.selected = _arg_1;
            }, "canGarrisonCB.selected");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("允许盟友驻军");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_Label3.text = _arg_1;
            }, "_Embassy_Label3.text");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (stayArmysDP);
            }, function (_arg_1:Object):void
            {
                _Embassy_DataGrid1.dataProvider = _arg_1;
            }, "_Embassy_DataGrid1.dataProvider");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn1.headerText = _arg_1;
            }, "_Embassy_DataGridColumn1.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("君主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn2.headerText = _arg_1;
            }, "_Embassy_DataGridColumn2.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn3.headerText = _arg_1;
            }, "_Embassy_DataGridColumn3.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("到达时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn4.headerText = _arg_1;
            }, "_Embassy_DataGridColumn4.headerText");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("停留时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn5.headerText = _arg_1;
            }, "_Embassy_DataGridColumn5.headerText");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("命令");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Embassy_DataGridColumn6.headerText = _arg_1;
            }, "_Embassy_DataGridColumn6.headerText");
            result[13] = binding;
            return (result);
        }

        public function ___Embassy_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get isAllowStay():Boolean
        {
            return (this._1550422840isAllowStay);
        }

        private function onIsAllowStay(_arg_1:MouseEvent):void
        {
            this.isAllowStay = CheckBox(_arg_1.target).selected;
            Context.getInstance().getCurCastle().allowAlliance = this.isAllowStay;
            ActionFactory.getInstance().getArmyCommands().setAllowAllianceArmy(Context.getInstance().getCurCastle().id, isAllowStay);
        }

        private function checkLevel():void
        {
            this.buildingLevel = this.getBuildingBean().level;
        }

        private function set buildingLevel(_arg_1:int):void
        {
            var _local_2:Object = this._397924048buildingLevel;
            if (_local_2 !== _arg_1)
            {
                this._397924048buildingLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingLevel", _local_2, _arg_1));
            };
        }

        private function set stayArmysDP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._311824617stayArmysDP;
            if (_local_2 !== _arg_1)
            {
                this._311824617stayArmysDP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stayArmysDP", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            trace((this.className + " refresh()"));
            allianceStr = Context.getInstance().getPlayerBean().playerInfo.alliance;
            isAllowStay = Context.getInstance().getCurCastle().allowAlliance;
            checkLevel();
            ActionFactory.getInstance().getArmyCommands().getStayAllianceArmys(Context.getInstance().getCurCastle().id);
            super.refresh();
        }

        public function onCallBack(_arg_1:Object):void
        {
            ActionFactory.getInstance().getArmyCommands().callBackArmy(Context.getInstance().getCurCastle().id, _arg_1.armyId, onCallBackArmy);
        }

        private function _Embassy_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (Lang.msg("所属联盟") + ": ");
            _local_1 = allianceStr;
            _local_1 = Lang.msg("进入联盟");
            _local_1 = (Lang.msg("盟友进驻军队数量") + ": ");
            _local_1 = ((stayArmysDP.length + "/") + this.buildingLevel);
            _local_1 = isAllowStay;
            _local_1 = Lang.msg("允许盟友驻军");
            _local_1 = stayArmysDP;
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("君主");
            _local_1 = Lang.msg("出发");
            _local_1 = Lang.msg("到达时间");
            _local_1 = Lang.msg("停留时间");
            _local_1 = Lang.msg("命令");
        }

        public function set canGarrisonCB(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1710339150canGarrisonCB;
            if (_local_2 !== _arg_1)
            {
                this._1710339150canGarrisonCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canGarrisonCB", _local_2, _arg_1));
            };
        }

        private function _Embassy_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn6 = _local_1;
            _local_1.dataField = "hero";
            _local_1.width = 100;
            _local_1.itemRenderer = _Embassy_ClassFactory3_c();
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn6", _Embassy_DataGridColumn6);
            return (_local_1);
        }

        private function onGetStayAllianceArmys(_arg_1:StayAllianceReponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.stayArmysDP = _arg_1.allianceArmysArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __canGarrisonCB_click(_arg_1:MouseEvent):void
        {
            onIsAllowStay(_arg_1);
        }

        private function set allianceStr(_arg_1:String):void
        {
            var _local_2:Object = this._1852931706allianceStr;
            if (_local_2 !== _arg_1)
            {
                this._1852931706allianceStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceStr", _local_2, _arg_1));
            };
        }

        private function set isAllowStay(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1550422840isAllowStay;
            if (_local_2 !== _arg_1)
            {
                this._1550422840isAllowStay = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isAllowStay", _local_2, _arg_1));
            };
        }

        private function _Embassy_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Embassy_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _Embassy_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn2 = _local_1;
            _local_1.dataField = "king";
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn2", _Embassy_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get allianceStr():String
        {
            return (this._1852931706allianceStr);
        }

        private function _Embassy_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Embassy_DataGridColumn4 = _local_1;
            _local_1.dataField = "reachTime";
            _local_1.itemRenderer = _Embassy_ClassFactory1_c();
            BindingManager.executeBindings(this, "_Embassy_DataGridColumn4", _Embassy_DataGridColumn4);
            return (_local_1);
        }

        public function ___Embassy_Button1_click(_arg_1:MouseEvent):void
        {
            enterAlliance();
        }


    }
}//package view.module.embassy

