// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.ConditionTooltip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.BuildingLevelData;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import mx.containers.ViewStack;
    import mx.controls.Text;
    import mx.controls.DataGrid;
    import mx.controls.Label;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import com.evony.eum.TroopEumDefine;
    import com.evony.eum.BuildingEumDefine;
    import mx.events.FlexEvent;
    import com.evony.common.beans.ConditionDependBuildingBean;
    import com.evony.common.beans.ConditionDependItemBean;
    import com.evony.common.beans.ConditionDependTechBean;
    import com.evony.util.UIUtil;
    import com.evony.util.ConditionItem;
    import com.evony.common.beans.ConditionBean;
    import com.evony.eum.FortificationEumDefine;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.eum.TechEumDefine;
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

    public class ConditionTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var buildingLevelData:BuildingLevelData;
        public var _ConditionTooltip_DataGridColumn1:DataGridColumn;
        public var _ConditionTooltip_DataGridColumn4:DataGridColumn;
        private var _95356390dataP:ArrayCollection;
        public var _ConditionTooltip_DataGridColumn2:DataGridColumn;
        private var _1006539975conditionContain:ViewStack;
        private var _895975549destructTime:int;
        public var _ConditionTooltip_Text1:Text;
        public var _ConditionTooltip_DataGrid2:DataGrid;
        public var _ConditionTooltip_Label1:Label;
        public var _ConditionTooltip_Label3:Label;
        public var _ConditionTooltip_Label2:Label;
        private var _432490745updateBuilding_view:Canvas;
        private var _982425695buildingTime:String;
        public var _ConditionTooltip_HBox1:HBox;
        private var _3079825desc:String;
        private var _1954391778recoverDataP:ArrayCollection;
        public var _ConditionTooltip_DataGridColumn5:DataGridColumn;
        public var _ConditionTooltip_DataGridColumn6:DataGridColumn;
        private var _1642768921desctructBuilding_view:Canvas;
        private var _110371416title:String;
        public var _ConditionTooltip_DataGridColumn3:DataGridColumn;
        private var _1745048608updateBuildingDG:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "5";
                            this.left = "5";
                            this.right = "5";
                            this.verticalGap = 6;
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ConditionTooltip_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ConditionTooltip_Text1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":354,
                                            "styleName":"ParamgraphText1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"conditionContain",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "resizeToContent":true,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"updateBuilding_view",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"updateBuildingDG",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"work",
                                                                    "rowHeight":28,
                                                                    "columns":[_ConditionTooltip_DataGridColumn1_i(), _ConditionTooltip_DataGridColumn2_i(), _ConditionTooltip_DataGridColumn3_i()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "id":"desctructBuilding_view",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_ConditionTooltip_DataGrid2",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"work",
                                                                    "rowHeight":28,
                                                                    "columns":[_ConditionTooltip_DataGridColumn4_i(), _ConditionTooltip_DataGridColumn5_i(), _ConditionTooltip_DataGridColumn6_i()]
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
                                    "id":"_ConditionTooltip_HBox1",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":30,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ConditionTooltip_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "width":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_ConditionTooltip_Label3",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyValue1"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ConditionTooltip()
        {
            mx_internal::_document = this;
            this.width = 400;
            this.styleName = "tooltips";
            this.addEventListener("creationComplete", ___ConditionTooltip_BaseTooltip1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ConditionTooltip._watcherSetupUtil = _arg_1;
        }


        private function _ConditionTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.title;
            _local_1 = this.desc;
            _local_1 = this.dataP;
            _local_1 = ((28 * dataP.length) + 35);
            _local_1 = Lang.msg("建造条件");
            _local_1 = Lang.msg("需要条件");
            _local_1 = Lang.msg("当前条件");
            _local_1 = this.recoverDataP;
            _local_1 = ((28 * recoverDataP.length) + 35);
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("获得资源");
            _local_1 = Lang.msg("当前数量");
            _local_1 = (!(this.buildingTime == null));
            _local_1 = (Lang.msg("需要时间") + ": ");
            _local_1 = this.buildingTime;
        }

        [Bindable(event="propertyChange")]
        public function get updateBuilding_view():Canvas
        {
            return (this._432490745updateBuilding_view);
        }

        public function set conditionContain(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._1006539975conditionContain;
            if (_local_2 !== _arg_1)
            {
                this._1006539975conditionContain = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "conditionContain", _local_2, _arg_1));
            };
        }

        private function set destructTime(_arg_1:int):void
        {
            var _local_2:Object = this._895975549destructTime;
            if (_local_2 !== _arg_1)
            {
                this._895975549destructTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "destructTime", _local_2, _arg_1));
            };
        }

        private function _ConditionTooltip_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = ConditionTooltip_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:ConditionTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ConditionTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_ConditionTooltipWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        private function get title():String
        {
            return (this._110371416title);
        }

        [Bindable(event="propertyChange")]
        private function get destructTime():int
        {
            return (this._895975549destructTime);
        }

        private function _ConditionTooltip_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn1 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 95;
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn1", _ConditionTooltip_DataGridColumn1);
            return (_local_1);
        }

        private function init():void
        {
            this.conditionContain.selectedChild = this.updateBuilding_view;
        }

        private function _ConditionTooltip_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn5 = _local_1;
            _local_1.width = 150;
            _local_1.itemRenderer = _ConditionTooltip_ClassFactory2_c();
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn5", _ConditionTooltip_DataGridColumn5);
            return (_local_1);
        }

        private function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        public function setTroopType(_arg_1:String, _arg_2:int):void
        {
            this.title = ((_arg_1 + ":") + TroopEumDefine.getTroopEumByType(_arg_2).name);
            this.desc = TroopEumDefine.getTroopEumByType(_arg_2).desc;
        }

        private function _ConditionTooltip_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn3 = _local_1;
            _local_1.dataField = "current";
            _local_1.width = 105;
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn3", _ConditionTooltip_DataGridColumn3);
            return (_local_1);
        }

        public function setBuildingType(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            if (_arg_3 == -1)
            {
                this.title = Lang.msg("{0}{1}tolv{2}", _arg_1, BuildingEumDefine.getName(_arg_2), 1);
                this.desc = BuildingEumDefine.getBuildingEumByType(_arg_2).getUpLevelDesc(0).upLevelDesc;
                buildingLevelData = BuildingEumDefine.getBuildingEumByType(_arg_2).getLevelData(0);
                return;
            };
            if (_arg_3 == 0)
            {
                this.title = Lang.msg("desctruct{0}{1}", _arg_1, BuildingEumDefine.getName(_arg_2), _arg_3);
            };
            if (((_arg_3 > 0) && (_arg_1 == Lang.msg("升级"))))
            {
                this.title = Lang.msg("{0}{1}tolv{2}", _arg_1, BuildingEumDefine.getName(_arg_2), (_arg_3 + 1));
            }
            else
            {
                if (((_arg_3 > 0) && (_arg_1 == Lang.msg("拆除"))))
                {
                    this.title = Lang.msg("{0}{1}tolv{2}", _arg_1, BuildingEumDefine.getName(_arg_2), _arg_3);
                };
            };
            this.desc = BuildingEumDefine.getBuildingEumByType(_arg_2).getUpLevelDesc(_arg_3).upLevelDesc;
            buildingLevelData = BuildingEumDefine.getBuildingEumByType(_arg_2).getLevelData(_arg_3);
        }

        [Bindable(event="propertyChange")]
        private function get desc():String
        {
            return (this._3079825desc);
        }

        private function _ConditionTooltip_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = ConditionTooltip_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___ConditionTooltip_BaseTooltip1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function set updateBuilding_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._432490745updateBuilding_view;
            if (_local_2 !== _arg_1)
            {
                this._432490745updateBuilding_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBuilding_view", _local_2, _arg_1));
            };
        }

        public function setBean(_arg_1:ConditionBean):void
        {
            var _local_2:ConditionDependBuildingBean;
            var _local_3:ConditionDependItemBean;
            var _local_4:ConditionDependTechBean;
            dataP = new ArrayCollection();
            if (_arg_1 != null)
            {
                this.buildingTime = UIUtil.timeToString(_arg_1.time);
                if (_arg_1.buildingsArray != null)
                {
                    for each (_local_2 in _arg_1.buildingsArray)
                    {
                        dataP.addItem(ConditionItem.building(_local_2));
                    };
                };
                if (_arg_1.itemsArray != null)
                {
                    for each (_local_3 in _arg_1.itemsArray)
                    {
                        dataP.addItem(ConditionItem.item(_local_3));
                    };
                };
                if (_arg_1.techsArray != null)
                {
                    for each (_local_4 in _arg_1.techsArray)
                    {
                        dataP.addItem(ConditionItem.tech(_local_4));
                    };
                };
                if (_arg_1.food > 0)
                {
                    dataP.addItem(ConditionItem.food(_arg_1.food));
                };
                if (_arg_1.wood > 0)
                {
                    dataP.addItem(ConditionItem.wood(_arg_1.wood));
                };
                if (_arg_1.stone > 0)
                {
                    dataP.addItem(ConditionItem.stone(_arg_1.stone));
                };
                if (_arg_1.iron > 0)
                {
                    dataP.addItem(ConditionItem.iron(_arg_1.iron));
                };
                if (_arg_1.gold > 0)
                {
                    dataP.addItem(ConditionItem.gold(_arg_1.gold));
                };
            }
            else
            {
                this.buildingTime = null;
            };
            if (((!(this.conditionContain == null)) && (!(this.updateBuilding_view == null))))
            {
                this.conditionContain.selectedChild = this.updateBuilding_view;
            };
        }

        private function _ConditionTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_Label1.text = _arg_1;
            }, "_ConditionTooltip_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_Text1.text = _arg_1;
            }, "_ConditionTooltip_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.dataP);
            }, function (_arg_1:Object):void
            {
                updateBuildingDG.dataProvider = _arg_1;
            }, "updateBuildingDG.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((28 * dataP.length) + 35);
            }, function (_arg_1:Number):void
            {
                updateBuildingDG.height = _arg_1;
            }, "updateBuildingDG.height");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn1.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn1.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("需要条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn2.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn2.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前条件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn3.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn3.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.recoverDataP);
            }, function (_arg_1:Object):void
            {
                _ConditionTooltip_DataGrid2.dataProvider = _arg_1;
            }, "_ConditionTooltip_DataGrid2.dataProvider");
            result[7] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((28 * recoverDataP.length) + 35);
            }, function (_arg_1:Number):void
            {
                _ConditionTooltip_DataGrid2.height = _arg_1;
            }, "_ConditionTooltip_DataGrid2.height");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn4.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn4.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("获得资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn5.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn5.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("当前数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_DataGridColumn6.headerText = _arg_1;
            }, "_ConditionTooltip_DataGridColumn6.headerText");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(this.buildingTime == null));
            }, function (_arg_1:Boolean):void
            {
                _ConditionTooltip_HBox1.visible = _arg_1;
            }, "_ConditionTooltip_HBox1.visible");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("需要时间") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_Label2.text = _arg_1;
            }, "_ConditionTooltip_Label2.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.buildingTime;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ConditionTooltip_Label3.text = _arg_1;
            }, "_ConditionTooltip_Label3.text");
            result[14] = binding;
            return (result);
        }

        private function set title(_arg_1:String):void
        {
            var _local_2:Object = this._110371416title;
            if (_local_2 !== _arg_1)
            {
                this._110371416title = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "title", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get conditionContain():ViewStack
        {
            return (this._1006539975conditionContain);
        }

        public function set desctructBuilding_view(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1642768921desctructBuilding_view;
            if (_local_2 !== _arg_1)
            {
                this._1642768921desctructBuilding_view = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desctructBuilding_view", _local_2, _arg_1));
            };
        }

        public function setBuildingDoType(_arg_1:String, _arg_2:int):void
        {
            if (_arg_1 == "desctructBuilding")
            {
                this.destructTime = _arg_2;
                this.conditionContain.selectedChild = this.desctructBuilding_view;
                this.desc = Lang.msg("拆除文字提示");
            }
            else
            {
                this.conditionContain.selectedChild = this.updateBuilding_view;
            };
        }

        [Bindable(event="propertyChange")]
        private function get buildingTime():String
        {
            return (this._982425695buildingTime);
        }

        public function set updateBuildingDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1745048608updateBuildingDG;
            if (_local_2 !== _arg_1)
            {
                this._1745048608updateBuildingDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBuildingDG", _local_2, _arg_1));
            };
        }

        private function set buildingTime(_arg_1:String):void
        {
            var _local_2:Object = this._982425695buildingTime;
            if (_local_2 !== _arg_1)
            {
                this._982425695buildingTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buildingTime", _local_2, _arg_1));
            };
        }

        private function set recoverDataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1954391778recoverDataP;
            if (_local_2 !== _arg_1)
            {
                this._1954391778recoverDataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "recoverDataP", _local_2, _arg_1));
            };
        }

        public function setCastleProtectType(_arg_1:String, _arg_2:int):void
        {
            this.title = ((_arg_1 + ":") + FortificationEumDefine.getFortificationEumByType(_arg_2).name);
            this.desc = FortificationEumDefine.getFortificationEumByType(_arg_2).desc;
        }

        public function setBeanRecover(_arg_1:ConditionBean):void
        {
            recoverDataP = new ArrayCollection();
            if (_arg_1.food > 0)
            {
                recoverDataP.addItem(ConditionItem.food(((_arg_1.food * BuildingConstants.DESTRUCT_RESOURSE_RECYCLE_RATE) / 100)));
            };
            if (_arg_1.wood > 0)
            {
                recoverDataP.addItem(ConditionItem.wood(((_arg_1.wood * BuildingConstants.DESTRUCT_RESOURSE_RECYCLE_RATE) / 100)));
            };
            if (_arg_1.stone > 0)
            {
                recoverDataP.addItem(ConditionItem.stone(((_arg_1.stone * BuildingConstants.DESTRUCT_RESOURSE_RECYCLE_RATE) / 100)));
            };
            if (_arg_1.iron > 0)
            {
                recoverDataP.addItem(ConditionItem.iron(((_arg_1.iron * BuildingConstants.DESTRUCT_RESOURSE_RECYCLE_RATE) / 100)));
            };
            this.buildingTime = UIUtil.timeToString(this.destructTime);
        }

        private function set dataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._95356390dataP;
            if (_local_2 !== _arg_1)
            {
                this._95356390dataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataP", _local_2, _arg_1));
            };
        }

        private function _ConditionTooltip_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn2 = _local_1;
            _local_1.itemRenderer = _ConditionTooltip_ClassFactory1_c();
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn2", _ConditionTooltip_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get desctructBuilding_view():Canvas
        {
            return (this._1642768921desctructBuilding_view);
        }

        private function _ConditionTooltip_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn6 = _local_1;
            _local_1.dataField = "current";
            _local_1.width = 110;
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn6", _ConditionTooltip_DataGridColumn6);
            return (_local_1);
        }

        private function _ConditionTooltip_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _ConditionTooltip_DataGridColumn4 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_ConditionTooltip_DataGridColumn4", _ConditionTooltip_DataGridColumn4);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get recoverDataP():ArrayCollection
        {
            return (this._1954391778recoverDataP);
        }

        [Bindable(event="propertyChange")]
        public function get updateBuildingDG():DataGrid
        {
            return (this._1745048608updateBuildingDG);
        }

        public function setTechType(_arg_1:String, _arg_2:int, _arg_3:int):void
        {
            if (_arg_3 < 10)
            {
                this.title = ((((_arg_1 + " ") + TechEumDefine.getTechEumByType(_arg_2).name) + " ") + Lang.msg("到等级{0}", _arg_3));
            }
            else
            {
                this.title = ((TechEumDefine.getTechEumByType(_arg_2).name + " ") + Lang.msg("到等级10（最高）"));
            };
            this.desc = TechEumDefine.getTechEumByType(_arg_2).desc;
        }

        [Bindable(event="propertyChange")]
        private function get dataP():ArrayCollection
        {
            return (this._95356390dataP);
        }


    }
}//package view.ui

