// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.quest.QuestAmryInfo

package view.module.quest
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.Text;
    import mx.controls.Button;
    import com.evony.common.beans.ArmyBean;
    import mx.containers.VBox;
    import mx.containers.ViewStack;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.commission.CommissionQuestArmyInfoRespone;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import mx.events.FlexEvent;
    import mx.core.ClassFactory;
    import com.evony.common.beans.TroopStrBean;
    import flash.utils.getDefinitionByName;
    import com.evony.client.action.ActionFactory;
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

    public class QuestAmryInfo extends Canvas implements IBindingClient 
    {

        public static var stance:QuestAmryInfo = new (QuestAmryInfo)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _QuestAmryInfo_DataGrid1:DataGrid;
        public var _QuestAmryInfo_DataGrid2:DataGrid;
        public var _QuestAmryInfo_Text1:Text;
        private var _1272775401DescshowId:int = 0;
        private var _66041Aph:Button;
        private var _1879273436playerId:int;
        private var _1415494931armyBean:ArmyBean;
        private var _1855404603ArmyDetails:VBox;
        private var _153085257myViewstack:ViewStack;
        public var _QuestAmryInfo_Button1:Button;
        public var _QuestAmryInfo_Button2:Button;
        private var questId:int;
        public var _QuestAmryInfo_DataGridColumn2:DataGridColumn;
        public var _QuestAmryInfo_DataGridColumn4:DataGridColumn;
        public var _QuestAmryInfo_DataGridColumn5:DataGridColumn;
        public var _QuestAmryInfo_Label1:Label;
        public var _QuestAmryInfo_Label3:Label;
        public var _QuestAmryInfo_Label5:Label;
        public var _QuestAmryInfo_Label7:Label;
        private var xP:String;
        public var _QuestAmryInfo_Label9:Label;
        private var yP:String;
        private var _467476047TotalArrayNum:VBox;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":400,
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
                            this.top = "9";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_QuestAmryInfo_Label1",
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
                        "type":ViewStack,
                        "id":"myViewstack",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.top = "32";
                            this.right = "20";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"TotalArrayNum",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "styleName":"textBackground",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_QuestAmryInfo_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "selectable":false,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_QuestAmryInfo_DataGrid1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "columns":[_QuestAmryInfo_DataGridColumn1_c(), _QuestAmryInfo_DataGridColumn2_i(), _QuestAmryInfo_DataGridColumn3_c()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_QuestAmryInfo_Button1",
                                                            "events":{"click":"___QuestAmryInfo_Button1_click"},
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.right = "20";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b95"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VBox,
                                    "id":"ArmyDetails",
                                    "stylesFactory":function ():void
                                    {
                                        this.paddingTop = 20;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "text":"Lord:",
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestAmryInfo_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "text":"Alliance:",
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestAmryInfo_Label5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "text":"Hero:",
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestAmryInfo_Label7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":80,
                                                                    "text":"Level:",
                                                                    "styleName":"PropertyName1"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_QuestAmryInfo_Label9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "styleName":"PropertyValue1"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_QuestAmryInfo_DataGrid2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "headerHeight":25,
                                                        "columns":[_QuestAmryInfo_DataGridColumn4_i(), _QuestAmryInfo_DataGridColumn5_i()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_QuestAmryInfo_Button2",
                                                            "events":{"click":"___QuestAmryInfo_Button2_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b95"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"Aph",
                                                            "events":{"click":"__Aph_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"b95"});
                                                            }
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
                        "events":{"click":"___QuestAmryInfo_Button4_click"},
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
        private var _880872206tasker:String = Lang.msg("查询排名");
        private var _56677412Description:String = Lang.msg("反殖民战争竞标说明");
        private var _127745936armyRankArray:ArrayCollection = new ArrayCollection();
        private var _1498862854myTroop:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function QuestAmryInfo()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 400;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___QuestAmryInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            QuestAmryInfo._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null, _arg_2:int=0, _arg_3:String="0", _arg_4:String="0"):void
        {
            stance.armyRankArray = (_arg_1 as ArrayCollection);
            stance.questId = _arg_2;
            stance.xP = _arg_3;
            stance.yP = _arg_4;
            PopUpManager.addPopUp(stance, MainFrame.instance, true);
            PopUpManager.centerPopUp(stance);
        }


        [Bindable(event="propertyChange")]
        private function get myTroop():ArrayCollection
        {
            return (this._1498862854myTroop);
        }

        private function set armyBean(_arg_1:ArmyBean):void
        {
            var _local_2:Object = this._1415494931armyBean;
            if (_local_2 !== _arg_1)
            {
                this._1415494931armyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyBean", _local_2, _arg_1));
            };
        }

        private function set myTroop(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1498862854myTroop;
            if (_local_2 !== _arg_1)
            {
                this._1498862854myTroop = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTroop", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyBean():ArmyBean
        {
            return (this._1415494931armyBean);
        }

        public function init():void
        {
            stance = this;
            this.playerId = Context.getInstance().getPlayerBean().playerInfo.id;
        }

        [Bindable(event="propertyChange")]
        public function get Aph():Button
        {
            return (this._66041Aph);
        }

        private function _QuestAmryInfo_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "view";
            _local_1.dataField = "playerId";
            _local_1.itemRenderer = _QuestAmryInfo_ClassFactory1_c();
            return (_local_1);
        }

        private function checkArmyResponse(_arg_1:CommissionQuestArmyInfoRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                myArmyBean = _arg_1.armyBean;
                armyBean = _arg_1.armyBean;
                tasker = "Army Details";
                DescshowId = 1;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___QuestAmryInfo_Button2_click(_arg_1:MouseEvent):void
        {
            addArmy();
        }

        private function _QuestAmryInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = tasker;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Label1.text = _arg_1;
            }, "_QuestAmryInfo_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():int
            {
                return (DescshowId);
            }, function (_arg_1:int):void
            {
                myViewstack.selectedIndex = _arg_1;
            }, "myViewstack.selectedIndex");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Description;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Text1.text = _arg_1;
            }, "_QuestAmryInfo_Text1.text");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (armyRankArray);
            }, function (_arg_1:Object):void
            {
                _QuestAmryInfo_DataGrid1.dataProvider = _arg_1;
            }, "_QuestAmryInfo_DataGrid1.dataProvider");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队总经验");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_DataGridColumn2.headerText = _arg_1;
            }, "_QuestAmryInfo_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("增加军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Button1.label = _arg_1;
            }, "_QuestAmryInfo_Button1.label");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.king == null) ? "--" : this.armyBean.king);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Label3.text = _arg_1;
            }, "_QuestAmryInfo_Label3.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.alliance == null) ? "--" : this.armyBean.alliance);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Label5.text = _arg_1;
            }, "_QuestAmryInfo_Label5.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.hero == null) ? "--" : this.armyBean.hero);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Label7.text = _arg_1;
            }, "_QuestAmryInfo_Label7.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.armyBean.heroLevel == 0) ? "--" : this.armyBean.heroLevel);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Label9.text = _arg_1;
            }, "_QuestAmryInfo_Label9.text");
            result[9] = binding;
            binding = new Binding(this, function ():Object
            {
                return (myTroop);
            }, function (_arg_1:Object):void
            {
                _QuestAmryInfo_DataGrid2.dataProvider = _arg_1;
            }, "_QuestAmryInfo_DataGrid2.dataProvider");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("兵种");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_DataGridColumn4.headerText = _arg_1;
            }, "_QuestAmryInfo_DataGridColumn4.headerText");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_DataGridColumn5.headerText = _arg_1;
            }, "_QuestAmryInfo_DataGridColumn5.headerText");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("增加军队");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _QuestAmryInfo_Button2.label = _arg_1;
            }, "_QuestAmryInfo_Button2.label");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("军队排行");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                Aph.label = _arg_1;
            }, "Aph.label");
            result[14] = binding;
            return (result);
        }

        private function _QuestAmryInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = tasker;
            _local_1 = DescshowId;
            _local_1 = Description;
            _local_1 = armyRankArray;
            _local_1 = Lang.msg("军队总经验");
            _local_1 = Lang.msg("增加军队");
            _local_1 = ((this.armyBean.king == null) ? "--" : this.armyBean.king);
            _local_1 = ((this.armyBean.alliance == null) ? "--" : this.armyBean.alliance);
            _local_1 = ((this.armyBean.hero == null) ? "--" : this.armyBean.hero);
            _local_1 = ((this.armyBean.heroLevel == 0) ? "--" : this.armyBean.heroLevel);
            _local_1 = myTroop;
            _local_1 = Lang.msg("兵种");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("增加军队");
            _local_1 = Lang.msg("军队排行");
        }

        private function onClose():void
        {
            if (this.parent != null)
            {
                PopUpManager.removePopUp(this);
            };
            ArmyRanking();
        }

        private function _QuestAmryInfo_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestAmryInfo_DataGridColumn2 = _local_1;
            _local_1.dataField = "experience";
            BindingManager.executeBindings(this, "_QuestAmryInfo_DataGridColumn2", _QuestAmryInfo_DataGridColumn2);
            return (_local_1);
        }

        public function ___QuestAmryInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set TotalArrayNum(_arg_1:VBox):void
        {
            var _local_2:Object = this._467476047TotalArrayNum;
            if (_local_2 !== _arg_1)
            {
                this._467476047TotalArrayNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "TotalArrayNum", _local_2, _arg_1));
            };
        }

        private function _QuestAmryInfo_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = QuestAmryInfo_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set myViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._153085257myViewstack;
            if (_local_2 !== _arg_1)
            {
                this._153085257myViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myViewstack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get armyRankArray():ArrayCollection
        {
            return (this._127745936armyRankArray);
        }

        public function set myArmyBean(_arg_1:ArmyBean):void
        {
            this.armyBean = _arg_1;
            var _local_2:TroopStrBean = this.armyBean.troop;
            this.myTroop.removeAll();
            if (_local_2.peasants != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("民夫"),
                    "num":_local_2.peasants
                });
            };
            if (_local_2.militia != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("义兵"),
                    "num":_local_2.militia
                });
            };
            if (_local_2.scouter != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("斥候"),
                    "num":_local_2.scouter
                });
            };
            if (_local_2.pikemen != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("枪兵"),
                    "num":_local_2.pikemen
                });
            };
            if (_local_2.swordsmen != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("刀盾兵"),
                    "num":_local_2.swordsmen
                });
            };
            if (_local_2.archer != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("弓箭手"),
                    "num":_local_2.archer
                });
            };
            if (_local_2.lightCavalry != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("轻骑兵"),
                    "num":_local_2.lightCavalry
                });
            };
            if (_local_2.heavyCavalry != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("铁骑兵"),
                    "num":_local_2.heavyCavalry
                });
            };
            if (_local_2.carriage != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("辎重车"),
                    "num":_local_2.carriage
                });
            };
            if (_local_2.ballista != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("车弩"),
                    "num":_local_2.ballista
                });
            };
            if (_local_2.batteringRam != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("冲车"),
                    "num":_local_2.batteringRam
                });
            };
            if (_local_2.catapult != "0")
            {
                myTroop.addItem({
                    "army":Lang.msg("投石车"),
                    "num":_local_2.catapult
                });
            };
        }

        public function set ArmyDetails(_arg_1:VBox):void
        {
            var _local_2:Object = this._1855404603ArmyDetails;
            if (_local_2 !== _arg_1)
            {
                this._1855404603ArmyDetails = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ArmyDetails", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:QuestAmryInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _QuestAmryInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_quest_QuestAmryInfoWatcherSetupUtil");
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

        public function CheckAmry():void
        {
            ActionFactory.getInstance().getCommissionQuestCommands().getCommissionQuestArmyInfo(this.questId, playerId, checkArmyResponse);
        }

        private function _QuestAmryInfo_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank";
            return (_local_1);
        }

        private function _QuestAmryInfo_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestAmryInfo_DataGridColumn5 = _local_1;
            _local_1.dataField = "num";
            BindingManager.executeBindings(this, "_QuestAmryInfo_DataGridColumn5", _QuestAmryInfo_DataGridColumn5);
            return (_local_1);
        }

        private function ArmyRanking():void
        {
            tasker = Lang.msg("查询排名");
            DescshowId = 0;
        }

        [Bindable(event="propertyChange")]
        public function get myViewstack():ViewStack
        {
            return (this._153085257myViewstack);
        }

        public function ___QuestAmryInfo_Button4_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        [Bindable(event="propertyChange")]
        public function get ArmyDetails():VBox
        {
            return (this._1855404603ArmyDetails);
        }

        public function set Description(_arg_1:String):void
        {
            var _local_2:Object = this._56677412Description;
            if (_local_2 !== _arg_1)
            {
                this._56677412Description = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Description", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get TotalArrayNum():VBox
        {
            return (this._467476047TotalArrayNum);
        }

        public function set DescshowId(_arg_1:int):void
        {
            var _local_2:Object = this._1272775401DescshowId;
            if (_local_2 !== _arg_1)
            {
                this._1272775401DescshowId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "DescshowId", _local_2, _arg_1));
            };
        }

        private function _QuestAmryInfo_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _QuestAmryInfo_DataGridColumn4 = _local_1;
            _local_1.dataField = "army";
            BindingManager.executeBindings(this, "_QuestAmryInfo_DataGridColumn4", _QuestAmryInfo_DataGridColumn4);
            return (_local_1);
        }

        public function __Aph_click(_arg_1:MouseEvent):void
        {
            ArmyRanking();
        }

        [Bindable(event="propertyChange")]
        public function get Description():String
        {
            return (this._56677412Description);
        }

        public function set tasker(_arg_1:String):void
        {
            var _local_2:Object = this._880872206tasker;
            if (_local_2 !== _arg_1)
            {
                this._880872206tasker = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tasker", _local_2, _arg_1));
            };
        }

        private function addArmy():void
        {
            onClose();
            trace("add Array !!!");
            AddArmyWin.show(this.questId, xP, yP, true);
        }

        private function set armyRankArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._127745936armyRankArray;
            if (_local_2 !== _arg_1)
            {
                this._127745936armyRankArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "armyRankArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get DescshowId():int
        {
            return (this._1272775401DescshowId);
        }

        [Bindable(event="propertyChange")]
        public function get playerId():int
        {
            return (this._1879273436playerId);
        }

        public function ___QuestAmryInfo_Button1_click(_arg_1:MouseEvent):void
        {
            addArmy();
        }

        public function set playerId(_arg_1:int):void
        {
            var _local_2:Object = this._1879273436playerId;
            if (_local_2 !== _arg_1)
            {
                this._1879273436playerId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerId", _local_2, _arg_1));
            };
        }

        public function set Aph(_arg_1:Button):void
        {
            var _local_2:Object = this._66041Aph;
            if (_local_2 !== _arg_1)
            {
                this._66041Aph = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Aph", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get tasker():String
        {
            return (this._880872206tasker);
        }


    }
}//package view.module.quest

