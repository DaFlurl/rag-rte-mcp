// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.WarReport

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.containers.VDividedBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.FlexEvent;
    import mx.events.PropertyChangeEvent;
    import mx.controls.dataGridClasses.DataGridColumn;
    import autoevony.common.Utils;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.gui.MainScreen;
    import mx.events.ListEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.events.TextEvent;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.MilitarySituation;
    import autoevony.common.ActionFactoryResponse;
    import autoevony.management.CityManager;
    import com.evony.common.module.alliance.MilitarySituationListResponse;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class WarReport extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const PAGESIZE:int = 10;
        private var _995752784pageNo:int = 1;
        private var _3203dg:DataGrid;
        private var _577409037totalPage:int = 1;
        private var _1148866775jumpto:TextInput;
        private var _838846263update:Button;
        private var _833068973_WarReportPageNo:Label;
        private var _1931047938reportInfo:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 0;
                            this.verticalGap = 0;
                            this.left = "3";
                            this.right = "3";
                            this.top = "0";
                            this.bottom = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.verticalGap = 0;
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":32,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"update",
                                                "events":{"click":"__update_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"refreshBtn",
                                                        "toolTip":"Refresh"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___WarReport_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previousBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"jumpto",
                                                "events":{"enter":"__jumpto_enter"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "restrict":"0-9",
                                                        "maxChars":5,
                                                        "width":48,
                                                        "toolTip":"Enter page number to jump to that page."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_WarReportPageNo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"REmainFormText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___WarReport_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"nextBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VDividedBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"dg",
                                                "events":{"change":"__dg_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.headerStyleName = "columnHeaderSyle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REdataGrid",
                                                        "allowDragSelection":false,
                                                        "allowMultipleSelection":false,
                                                        "doubleClickEnabled":false,
                                                        "dragEnabled":false,
                                                        "draggableColumns":false,
                                                        "editable":false,
                                                        "enabled":true,
                                                        "horizontalScrollPolicy":"off",
                                                        "minHeight":30,
                                                        "percentHeight":55,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":23,
                                                        "selectable":true,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "variableRowHeight":true,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "columns":[_WarReport_DataGridColumn1_c(), _WarReport_DataGridColumn2_c(), _WarReport_DataGridColumn3_c(), _WarReport_DataGridColumn4_c()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"reportInfo",
                                                "events":{"link":"__reportInfo_link"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "editable":false,
                                                        "enabled":true,
                                                        "styleName":"RElogBox",
                                                        "percentHeight":45,
                                                        "percentWidth":100,
                                                        "wordWrap":true
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _313472292situationsArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function WarReport()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___WarReport_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            WarReport._watcherSetupUtil = _arg_1;
        }

        private static function format(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            if (_arg_3 == "")
            {
                return ("");
            };
            return ((((_arg_1 + " ") + _arg_2) + ": ") + _arg_3);
        }


        public function ___WarReport_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get reportInfo():TextArea
        {
            return (this._1931047938reportInfo);
        }

        [Bindable(event="propertyChange")]
        public function get dg():DataGrid
        {
            return (this._3203dg);
        }

        public function set reportInfo(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1931047938reportInfo;
            if (_local_2 !== _arg_1)
            {
                this._1931047938reportInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportInfo", _local_2, _arg_1));
            };
        }

        public function set dg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._3203dg;
            if (_local_2 !== _arg_1)
            {
                this._3203dg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dg", _local_2, _arg_1));
            };
        }

        private function _WarReport_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Subject";
            _local_1.dataField = "eventName";
            _local_1.width = 0.63;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        private function _iy128():void
        {
            this.pageNo = ((Utils.hasValue(this.jumpto.text)) ? int(this.jumpto.text) : 0);
            if (this.pageNo >= this.totalPage)
            {
                this.pageNo = this.totalPage;
            };
            if (this.pageNo <= 1)
            {
                this.pageNo = 1;
            };
            this.updateData();
        }

        override public function initialize():void
        {
            var target:WarReport;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._WarReport_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_WarReportWatcherSetupUtil");
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

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (MainScreen.getPlayer().playerInfo.alliance != null)
            {
                if (_arg_1 != null)
                {
                    this.pageNo = 1;
                };
                this.fetchPage(this.pageNo);
            }
            else
            {
                this.situationsArray.removeAll();
            };
        }

        public function set update(_arg_1:Button):void
        {
            var _local_2:Object = this._838846263update;
            if (_local_2 !== _arg_1)
            {
                this._838846263update = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "update", _local_2, _arg_1));
            };
        }

        public function __dg_change(_arg_1:ListEvent):void
        {
            this._ro876();
        }

        private function _jp80(_arg_1:TextEvent):void
        {
            navigateToURL(new URLRequest(("http://" + _arg_1.text)), "_blank");
        }

        private function nextPage():void
        {
            if (this.pageNo >= this.totalPage)
            {
                return;
            };
            this.pageNo = (this.pageNo + 1);
            this.updateData();
        }

        [Bindable(event="propertyChange")]
        public function get situationsArray():ArrayCollection
        {
            return (this._313472292situationsArray);
        }

        private function previousPage():void
        {
            if (this.pageNo <= 1)
            {
                return;
            };
            this.pageNo--;
            this.updateData();
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
        }

        public function __jumpto_enter(_arg_1:FlexEvent):void
        {
            this._iy128();
        }

        [Bindable(event="propertyChange")]
        public function get _WarReportPageNo():Label
        {
            return (this._833068973_WarReportPageNo);
        }

        public function ___WarReport_Button3_click(_arg_1:MouseEvent):void
        {
            this.nextPage();
        }

        [Bindable(event="propertyChange")]
        public function get jumpto():TextInput
        {
            return (this._1148866775jumpto);
        }

        public function __reportInfo_link(_arg_1:TextEvent):void
        {
            this._jp80(_arg_1);
        }

        private function _ro876():void
        {
            if (this.dg.selectedIndex == -1)
            {
                this.reportInfo.htmlText = "";
                return;
            };
            this.reportInfo.htmlText = ((this.dg.selectedItem.info + "\n\n\n") + this.dg.selectedItem.xml.toDebugString());
        }

        private function _WarReport_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Time";
            _local_1.dataField = "timeStr";
            _local_1.width = 0.3;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        public function set situationsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._313472292situationsArray;
            if (_local_2 !== _arg_1)
            {
                this._313472292situationsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "situationsArray", _local_2, _arg_1));
            };
        }

        private function _WarReport_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Type";
            _local_1.dataField = "typeStr";
            _local_1.width = 0.12;
            return (_local_1);
        }

        private function _WarReport_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Other alliances";
            _local_1.dataField = "otherAllianceName";
            _local_1.width = 0.2;
            return (_local_1);
        }

        public function toDebugString():String
        {
            return ("fields: situationsArray pageNo totalPage, method: fetchPage(int), columns: typeStr eventName otherAllianceName xml rawData");
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        public function set jumpto(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1148866775jumpto;
            if (_local_2 !== _arg_1)
            {
                this._1148866775jumpto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jumpto", _local_2, _arg_1));
            };
        }

        public function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        public function set _WarReportPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._833068973_WarReportPageNo;
            if (_local_2 !== _arg_1)
            {
                this._833068973_WarReportPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_WarReportPageNo", _local_2, _arg_1));
            };
        }

        public function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        public function ___WarReport_Button2_click(_arg_1:MouseEvent):void
        {
            this.previousPage();
        }

        private function _WarReport_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("/" + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _WarReportPageNo.text = _arg_1;
            }, "_WarReportPageNo.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.situationsArray);
            }, function (_arg_1:Object):void
            {
                dg.dataProvider = _arg_1;
            }, "dg.dataProvider");
            result[1] = binding;
            return (result);
        }

        public function fetchPage(_arg_1:int):void
        {
            this.pageNo = _arg_1;
            ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(this.pageNo, this.PAGESIZE, this._ma393);
            this.jumpto.text = ("" + this.pageNo);
        }

        public function __update_click(_arg_1:MouseEvent):void
        {
            this._iy128();
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        private function _ma393(_arg_1:MilitarySituationListResponse):void
        {
            var _local_5:MilitarySituation;
            this.situationsArray.removeAll();
            if (_arg_1.ok != 1)
            {
                return;
            };
            var _local_2:Object;
            var _local_3:XML;
            var _local_4:String;
            this.totalPage = _arg_1.totalPage;
            for each (_local_5 in _arg_1.situationsArray)
            {
                _local_2 = _local_5.toObject();
                _local_2.rawData = _local_5;
                _local_3 = new XML(_local_5.xml_data);
                _local_2.xml = new ActionFactoryResponse(_local_3);
                _local_2.typeStr = ((_local_5.attack) ? "ATT" : "DEF");
                if (_local_5.startPos.length > 0)
                {
                    _local_2.eventName = ((_local_5.startPos + " ") + _local_5.eventName);
                };
                _local_2.timeStr = _local_5.time;
                _local_4 = Utils.armyReportToString(_local_3.battleReport, true);
                _local_4 = (_local_4 + ((((((("\n\n " + format("", "Honor", _local_3.battleReport.@honor)) + format("", "round", _local_3.battleReport.@round)) + format(",", "prestige", _local_3.battleReport.@prestige)) + format(",", "hero exp", _local_3.battleReport.@heroExp)) + format(",", "healing", _local_3.battleReport.@injuredPer)) + format(",", "loyalty trend", _local_3.battleReport.@support)) + format(",", "outcome", _local_3.battleReport.@seizeProblem)));
                if (_local_3.battleReport.lootResource.food.toString() != "")
                {
                    _local_4 = (_local_4 + ((((((((("\n  Loot: g:" + _local_3.battleReport.lootResource.gold) + ",f:") + _local_3.battleReport.lootResource.food) + ",w:") + _local_3.battleReport.lootResource.wood) + ",s:") + _local_3.battleReport.lootResource.stone) + ",i:") + _local_3.battleReport.lootResource.iron));
                };
                if (_local_3.battleReport.autoHeal.troopUnit.toString() != "")
                {
                    _local_4 = (_local_4 + ((("\n  Auto heal: " + CityManager._ix545(_local_3.battleReport.autoHeal.troopUnit)) + ", gold cost: ") + _local_3.battleReport.autoHeal.@gold));
                };
                _local_2.info = ((Utils.formatUrl(((((((((((((((_local_2.typeStr + " ") + _local_5.otherAllianceName) + " ") + _local_5.eventName) + " on ") + _local_5.time) + "  from ") + _local_5.startPos) + " ") + _local_3.battleReport.attackTroop.@king) + " to ") + _local_5.targetPos) + " ") + _local_3.battleReport.defendTroop.@king), _local_3.@reportUrl) + "<br><br>") + _local_4);
                this.situationsArray.addItem(_local_2);
            };
        }

        private function _WarReport_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ("/" + this.totalPage);
            _local_1 = this.situationsArray;
        }


    }
}//package autoevony.gui.info.Alliance

