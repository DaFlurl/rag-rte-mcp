// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.Office

package view.module.office
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.dataGridClasses.DataGridColumn;
    import view.module.guide.GuideArrow;
    import mx.controls.ToggleButtonBar;
    import flash.utils.Timer;
    import com.evony.common.beans.PlayerBean;
    import mx.controls.Button;
    import mx.containers.Canvas;
    import com.evony.client.response.ResponseDispatcher;
    import mx.controls.DataGrid;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.common.beans.CastleBean;
    import com.evony.Context;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import mx.events.PropertyChangeEvent;
    import mx.events.ListEvent;
    import mx.events.ItemClickEvent;
    import com.evony.common.server.events.BuildComplate;
    import flash.events.MouseEvent;
    import view.castle.MainFrame;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import com.evony.util.UIUtil;
    import mx.binding.Binding;
    import com.evony.Lang;
    import view.module.guide.GuideStep;
    import com.evony.common.beans.BuildingBean;
    import com.evony.events.EnterCastleEvent;
    import view.castle.building.BuildingSpace;
    import flash.utils.getDefinitionByName;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.eum.BuildingEumDefine;
    import mx.events.FlexEvent;
    import mx.managers.PopUpManager;
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

    public class Office extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "of.onOfficeClickEvent";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _Office_DataGridColumn1:DataGridColumn;
        public var _Office_DataGridColumn2:DataGridColumn;
        public var _Office_DataGridColumn3:DataGridColumn;
        public var _Office_DataGridColumn4:DataGridColumn;
        public var _Office_DataGridColumn5:DataGridColumn;
        public var _Office_DataGridColumn6:DataGridColumn;
        private var _957472654resourceGuide:GuideArrow;
        private var _11548545buttonBar:ToggleButtonBar;
        private var myTimer:Timer;
        private var _985752863player:PlayerBean;
        private var _1603629793modifyCastleNameBtn:Button;
        private var _323573698allCastleView:AllCastleView;
        private var _1002918982allBuildingView:AllConstruction;
        private var _1305874666constructionView:Canvas;
        private var _636105611modifyTaxRateBtn:Button;
        private var _1935462882allFieldView:AllFieldView;
        private var instance:ResponseDispatcher;
        private var _461357513buildingDG:DataGrid;
        public var _Office_Array2:Array;
        private var _1784033326taxationBtn:Button;
        private var _885463975officeViewstack:ViewStack;
        private var _431136579pacifyPeopleBtn:Button;
        private var _595032759resourceProduceView:ResourceProduce;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":820,
                    "creationPolicy":"all",
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"officeViewstack",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                            this.top = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "x":0,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":AllConstruction,
                                    "id":"allBuildingView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentHeight":100,
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ResourceProduce,
                                    "id":"resourceProduceView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllCastleView,
                                    "id":"allCastleView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllFieldView,
                                    "id":"allFieldView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"constructionView",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"constructionView",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"buildingDG",
                                                "events":{"itemClick":"__buildingDG_itemClick"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "center";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "styleName":"style2",
                                                        "columns":[_Office_DataGridColumn1_i(), _Office_DataGridColumn2_i(), _Office_DataGridColumn3_i(), _Office_DataGridColumn4_i(), _Office_DataGridColumn5_i(), _Office_DataGridColumn6_i()]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "events":{"creationComplete":"___Office_HBox1_creationComplete"},
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 1;
                            this.horizontalAlign = "left";
                            this.verticalAlign = "bottom";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":50,
                                "y":0,
                                "x":0,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ToggleButtonBar,
                                    "id":"buttonBar",
                                    "events":{"itemClick":"__buttonBar_itemClick"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":29,
                                            "width":340,
                                            "dataProvider":_Office_Array2_i()
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 2;
                            this.horizontalAlign = "right";
                            this.verticalAlign = "top";
                            this.right = "1";
                            this.top = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"modifyTaxRateBtn",
                                    "events":{"click":"__modifyTaxRateBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"pacifyPeopleBtn",
                                    "events":{"click":"__pacifyPeopleBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"taxationBtn",
                                    "events":{"click":"__taxationBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"modifyCastleNameBtn",
                                    "events":{"click":"__modifyCastleNameBtn_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"b95"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":GuideArrow,
                        "id":"resourceGuide",
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.left = "126";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"type":"tabGuide"});
                        }
                    })]
                });
            }
        });
        private var _1417182451buildingArr:ArrayCollection = new ArrayCollection();
        private var _691506344curCastle:CastleBean = Context.getInstance().getCurCastle();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Office()
        {
            mx_internal::_document = this;
            this.width = 820;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.creationPolicy = "all";
            this.addEventListener("creationComplete", ___Office_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Office._watcherSetupUtil = _arg_1;
        }


        private function _Office_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn2 = _local_1;
            _local_1.dataField = "action";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_Office_DataGridColumn2", _Office_DataGridColumn2);
            return (_local_1);
        }

        public function set buttonBar(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._11548545buttonBar;
            if (_local_2 !== _arg_1)
            {
                this._11548545buttonBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonBar", _local_2, _arg_1));
            };
        }

        public function __buildingDG_itemClick(_arg_1:ListEvent):void
        {
            buildingView(_arg_1);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        private function set buildingArr(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1417182451buildingArr;
            if (_local_2 !== _arg_1)
            {
                this._1417182451buildingArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingArr", _local_2, _arg_1));
            };
        }

        private function onBuildingComplete(_arg_1:BuildComplate):void
        {
            trace((this.className + ".onBuildingComplete()"));
            this.setBuildingArr();
        }

        public function set resourceGuide(_arg_1:GuideArrow):void
        {
            var _local_2:Object = this._957472654resourceGuide;
            if (_local_2 !== _arg_1)
            {
                this._957472654resourceGuide = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceGuide", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get constructionView():Canvas
        {
            return (this._1305874666constructionView);
        }

        [Bindable(event="propertyChange")]
        public function get allFieldView():AllFieldView
        {
            return (this._1935462882allFieldView);
        }

        private function reBackBtnHandle(_arg_1:MouseEvent):void
        {
        }

        public function init():void
        {
            this.officeViewstack.selectedChild = this.allBuildingView;
            this.player = Context.getInstance().getPlayerBean();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_BUILD_COMPLATE, onBuildingComplete);
            this.setBuildingArr();
            this.buttonBar.selectedIndex = 0;
            if (MainFrame.instance.currentView != null)
            {
                MainFrame.instance.currentView.stopDrag();
            };
        }

        [Bindable(event="propertyChange")]
        public function get modifyCastleNameBtn():Button
        {
            return (this._1603629793modifyCastleNameBtn);
        }

        [Bindable(event="propertyChange")]
        private function get buildingArr():ArrayCollection
        {
            return (this._1417182451buildingArr);
        }

        private function _Office_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn1 = _local_1;
            _local_1.dataField = "building";
            BindingManager.executeBindings(this, "_Office_DataGridColumn1", _Office_DataGridColumn1);
            return (_local_1);
        }

        private function onBtnBarCreated(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:Button;
            while (_local_2 < buttonBar.numChildren)
            {
                _local_3 = (buttonBar.getChildAt(_local_2) as Button);
                switch (_local_2)
                {
                    case 0:
                        _local_3.width = 80;
                        break;
                    case 1:
                        _local_3.width = 110;
                        break;
                    case 2:
                        _local_3.width = 80;
                        break;
                    case 3:
                        _local_3.width = 70;
                        break;
                };
                _local_2++;
            };
        }

        private function _Office_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn5 = _local_1;
            _local_1.dataField = "remainTime";
            _local_1.width = 180;
            BindingManager.executeBindings(this, "_Office_DataGridColumn5", _Office_DataGridColumn5);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get buildingDG():DataGrid
        {
            return (this._461357513buildingDG);
        }

        public function set modifyTaxRateBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._636105611modifyTaxRateBtn;
            if (_local_2 !== _arg_1)
            {
                this._636105611modifyTaxRateBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "modifyTaxRateBtn", _local_2, _arg_1));
            };
        }

        public function set constructionView(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1305874666constructionView;
            if (_local_2 !== _arg_1)
            {
                this._1305874666constructionView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "constructionView", _local_2, _arg_1));
            };
        }

        public function set allFieldView(_arg_1:AllFieldView):void
        {
            var _local_2:Object = this._1935462882allFieldView;
            if (_local_2 !== _arg_1)
            {
                this._1935462882allFieldView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allFieldView", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allCastleView():AllCastleView
        {
            return (this._323573698allCastleView);
        }

        [Bindable(event="propertyChange")]
        public function get pacifyPeopleBtn():Button
        {
            return (this._431136579pacifyPeopleBtn);
        }

        private function setBuildingArr():void
        {
            if (myTimer == null)
            {
                myTimer = new Timer(1000, 0);
                myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                myTimer.start();
            }
            else
            {
                myTimer.start();
            };
            changeBuildiingArr();
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            if (!UIUtil.isUIComponentVisible(this))
            {
                this.myTimer.stop();
                trace((this.className + " 被隐藏了. timer stop"));
                return;
            };
            changeBuildiingArr();
            if (this.buildingArr.length <= 0)
            {
                myTimer.stop();
            };
        }

        public function set modifyCastleNameBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1603629793modifyCastleNameBtn;
            if (_local_2 !== _arg_1)
            {
                this._1603629793modifyCastleNameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "modifyCastleNameBtn", _local_2, _arg_1));
            };
        }

        public function set officeViewstack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._885463975officeViewstack;
            if (_local_2 !== _arg_1)
            {
                this._885463975officeViewstack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officeViewstack", _local_2, _arg_1));
            };
        }

        private function _Office_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():PlayerBean
            {
                return (this.player);
            }, function (_arg_1:PlayerBean):void
            {
                allCastleView.playerBean = _arg_1;
            }, "allCastleView.playerBean");
            result[0] = binding;
            binding = new Binding(this, function ():CastleBean
            {
                return (this.curCastle);
            }, function (_arg_1:CastleBean):void
            {
                allCastleView.castleBean = _arg_1;
            }, "allCastleView.castleBean");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (buildingArr);
            }, function (_arg_1:Object):void
            {
                buildingDG.dataProvider = _arg_1;
            }, "buildingDG.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("正在建造");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn1.headerText = _arg_1;
            }, "_Office_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("任务");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn2.headerText = _arg_1;
            }, "_Office_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn3.headerText = _arg_1;
            }, "_Office_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("目标等级");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn4.headerText = _arg_1;
            }, "_Office_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("剩余时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn5.headerText = _arg_1;
            }, "_Office_DataGridColumn5.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("完成时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Office_DataGridColumn6.headerText = _arg_1;
            }, "_Office_DataGridColumn6.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("建筑总览"));
            }, function (_arg_1:*):void
            {
                _Office_Array2[0] = _arg_1;
            }, "_Office_Array2[0]");
            result[9] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("资源生产"));
            }, function (_arg_1:*):void
            {
                _Office_Array2[1] = _arg_1;
            }, "_Office_Array2[1]");
            result[10] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("附属野地"));
            }, function (_arg_1:*):void
            {
                _Office_Array2[2] = _arg_1;
            }, "_Office_Array2[2]");
            result[11] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("所有城池"));
            }, function (_arg_1:*):void
            {
                _Office_Array2[3] = _arg_1;
            }, "_Office_Array2[3]");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("调整税率");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                modifyTaxRateBtn.label = _arg_1;
            }, "modifyTaxRateBtn.label");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("安抚百姓");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                pacifyPeopleBtn.label = _arg_1;
            }, "pacifyPeopleBtn.label");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("征收物资");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                taxationBtn.label = _arg_1;
            }, "taxationBtn.label");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池改名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                modifyCastleNameBtn.label = _arg_1;
            }, "modifyCastleNameBtn.label");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.curCastle.powerlevel >= 4);
            }, function (_arg_1:Boolean):void
            {
                modifyCastleNameBtn.visible = _arg_1;
            }, "modifyCastleNameBtn.visible");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 15);
            }, function (_arg_1:Boolean):void
            {
                resourceGuide.includeInLayout = _arg_1;
            }, "resourceGuide.includeInLayout");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (GuideStep.getInstance().currentStep == 15);
            }, function (_arg_1:Boolean):void
            {
                resourceGuide.visible = _arg_1;
            }, "resourceGuide.visible");
            result[19] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get curCastle():CastleBean
        {
            return (this._691506344curCastle);
        }

        private function _Office_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.player;
            _local_1 = this.curCastle;
            _local_1 = buildingArr;
            _local_1 = Lang.msg("正在建造");
            _local_1 = Lang.msg("任务");
            _local_1 = Lang.msg("当前等级");
            _local_1 = Lang.msg("目标等级");
            _local_1 = Lang.msg("剩余时间");
            _local_1 = Lang.msg("完成时间");
            _local_1 = Lang.msg("建筑总览");
            _local_1 = Lang.msg("资源生产");
            _local_1 = Lang.msg("附属野地");
            _local_1 = Lang.msg("所有城池");
            _local_1 = Lang.msg("调整税率");
            _local_1 = Lang.msg("安抚百姓");
            _local_1 = Lang.msg("征收物资");
            _local_1 = Lang.msg("城池改名");
            _local_1 = (this.curCastle.powerlevel >= 4);
            _local_1 = (GuideStep.getInstance().currentStep == 15);
            _local_1 = (GuideStep.getInstance().currentStep == 15);
        }

        private function changeBuildiingArr():void
        {
            var _local_2:BuildingBean;
            this.buildingArr.removeAll();
            var _local_1:int;
            while (_local_1 < this.curCastle.buildingsArray.length)
            {
                _local_2 = this.curCastle.getBuildings(_local_1);
                if (this.getBuildingArrItem(_local_2) != null)
                {
                    this.buildingArr.addItem(this.getBuildingArrItem(_local_2));
                };
                _local_1++;
            };
        }

        public function set buildingDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._461357513buildingDG;
            if (_local_2 !== _arg_1)
            {
                this._461357513buildingDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingDG", _local_2, _arg_1));
            };
        }

        public function set allBuildingView(_arg_1:AllConstruction):void
        {
            var _local_2:Object = this._1002918982allBuildingView;
            if (_local_2 !== _arg_1)
            {
                this._1002918982allBuildingView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allBuildingView", _local_2, _arg_1));
            };
        }

        public function set resourceProduceView(_arg_1:ResourceProduce):void
        {
            var _local_2:Object = this._595032759resourceProduceView;
            if (_local_2 !== _arg_1)
            {
                this._595032759resourceProduceView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resourceProduceView", _local_2, _arg_1));
            };
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
                    };
                };
            };
        }

        private function _Office_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn4 = _local_1;
            _local_1.dataField = "targetLevel";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Office_DataGridColumn4", _Office_DataGridColumn4);
            return (_local_1);
        }

        public function set allCastleView(_arg_1:AllCastleView):void
        {
            var _local_2:Object = this._323573698allCastleView;
            if (_local_2 !== _arg_1)
            {
                this._323573698allCastleView = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allCastleView", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        public function set pacifyPeopleBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._431136579pacifyPeopleBtn;
            if (_local_2 !== _arg_1)
            {
                this._431136579pacifyPeopleBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pacifyPeopleBtn", _local_2, _arg_1));
            };
        }

        private function _Office_Array2_i():Array
        {
            var _local_1:Array = [null, null, null, null];
            _Office_Array2 = _local_1;
            BindingManager.executeBindings(this, "_Office_Array2", _Office_Array2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get modifyTaxRateBtn():Button
        {
            return (this._636105611modifyTaxRateBtn);
        }

        public function __modifyCastleNameBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        override public function initialize():void
        {
            var target:Office;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Office_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_OfficeWatcherSetupUtil");
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

        private function getBuildingArrItem(_arg_1:BuildingBean):Object
        {
            var _local_2:Object = new Object();
            _local_2["id"] = _arg_1.positionId;
            if (_arg_1.status != BuildingConstants.STATUS_NORMAL)
            {
                if (_arg_1.status == BuildingConstants.STATUS_DESTRUCTING)
                {
                    _local_2["action"] = Lang.msg("拆除");
                    _local_2["targetLevel"] = (_arg_1.level - 1);
                }
                else
                {
                    _local_2["action"] = Lang.msg("升级");
                    _local_2["targetLevel"] = (_arg_1.level + 1);
                };
                _local_2["curLevel"] = _arg_1.level;
                _local_2["building"] = BuildingEumDefine.getName(_arg_1.typeId);
                _local_2["remainTime"] = UIUtil.getRemainTime(_arg_1.endTime);
                _local_2["endTime"] = UIUtil.getFinishDate(_arg_1.endTime);
                _local_2["myBuilding"] = _arg_1;
            }
            else
            {
                _local_2 = null;
            };
            return (_local_2);
        }

        [Bindable(event="propertyChange")]
        public function get resourceGuide():GuideArrow
        {
            return (this._957472654resourceGuide);
        }

        private function btnHandle(_arg_1:MouseEvent):void
        {
            switch (_arg_1.target.id)
            {
                case "modifyTaxRateBtn":
                    AdjustmentCess.show(this.curCastle);
                    return;
                case "pacifyPeopleBtn":
                    PacifyPeopleView.show(this.curCastle);
                    return;
                case "taxationBtn":
                    CollectionMaterialsView.show(this.curCastle);
                    return;
                case "modifyCastleNameBtn":
                    ModifyCastleNameView.show(this.curCastle);
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get officeViewstack():ViewStack
        {
            return (this._885463975officeViewstack);
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    this.officeViewstack.selectedChild = this.allBuildingView;
                    return;
                case 1:
                    this.officeViewstack.selectedChild = this.resourceProduceView;
                    this.resourceProduceView.init();
                    if (resourceGuide.visible)
                    {
                        resourceGuide.visible = false;
                        resourceGuide.includeInLayout = false;
                    };
                    return;
                case 2:
                    this.officeViewstack.selectedChild = this.allFieldView;
                    this.allFieldView.reFresh();
                    return;
                case 3:
                    this.officeViewstack.selectedChild = this.allCastleView;
                    this.allCastleView.init();
                    return;
            };
        }

        public function set taxationBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1784033326taxationBtn;
            if (_local_2 !== _arg_1)
            {
                this._1784033326taxationBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "taxationBtn", _local_2, _arg_1));
            };
        }

        public function __pacifyPeopleBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
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

        private function _Office_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn3 = _local_1;
            _local_1.dataField = "curLevel";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_Office_DataGridColumn3", _Office_DataGridColumn3);
            return (_local_1);
        }

        public function __modifyTaxRateBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get resourceProduceView():ResourceProduce
        {
            return (this._595032759resourceProduceView);
        }

        private function set player(_arg_1:PlayerBean):void
        {
            var _local_2:Object = this._985752863player;
            if (_local_2 !== _arg_1)
            {
                this._985752863player = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "player", _local_2, _arg_1));
            };
        }

        public function ___Office_HBox1_creationComplete(_arg_1:FlexEvent):void
        {
            onBtnBarCreated(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get allBuildingView():AllConstruction
        {
            return (this._1002918982allBuildingView);
        }

        [Bindable(event="propertyChange")]
        public function get taxationBtn():Button
        {
            return (this._1784033326taxationBtn);
        }

        override public function refresh():void
        {
            super.refresh();
            this.player = Context.getInstance().getPlayerBean();
            this.curCastle = Context.getInstance().getCurCastle();
            this.setBuildingArr();
            this.allBuildingView.refresh();
            this.allCastleView.refresh();
            this.officeViewstack.selectedChild = this.allBuildingView;
            this.buttonBar.selectedIndex = 0;
            trace((this.className + " refresh()"));
        }

        [Bindable(event="propertyChange")]
        private function get player():PlayerBean
        {
            return (this._985752863player);
        }

        override public function destroy():void
        {
            if (AdjustmentCess.instancePopup)
            {
                PopUpManager.removePopUp(AdjustmentCess.instancePopup);
            }
            else
            {
                if (PacifyPeopleView.instancePopup)
                {
                    PopUpManager.removePopUp(PacifyPeopleView.instancePopup);
                }
                else
                {
                    if (CollectionMaterialsView.instancePopup)
                    {
                        PopUpManager.removePopUp(CollectionMaterialsView.instancePopup);
                    }
                    else
                    {
                        if (ModifyCastleNameView.instancePopup)
                        {
                            PopUpManager.removePopUp(ModifyCastleNameView.instancePopup);
                        };
                    };
                };
            };
        }

        public function __taxationBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle(_arg_1);
        }

        private function _Office_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Office_DataGridColumn6 = _local_1;
            _local_1.dataField = "endTime";
            _local_1.width = 150;
            BindingManager.executeBindings(this, "_Office_DataGridColumn6", _Office_DataGridColumn6);
            return (_local_1);
        }

        public function ___Office_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.office

