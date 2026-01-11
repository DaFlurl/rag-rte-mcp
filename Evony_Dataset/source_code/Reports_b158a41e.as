// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Reports.Reports

package autoevony.gui.info.Reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.controls.TextInput;
    import mx.controls.TextArea;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.containers.VDividedBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import autoevony.common.ActionFactoryResponse;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.module.CommandResponse;
    import mx.events.FlexEvent;
    import com.evony.common.constants.ObjConstants;
    import flash.events.Event;
    import autoevony.gui.MainScreen;
    import mx.events.ListEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.events.TextEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.common.Utils;
    import autoevony.management.CityManager;
    import com.evony.common.module.report.ReportResponse;
    import flash.events.MouseEvent;
    import com.evony.common.beans.ReportBean;
    import com.evony.common.module.report.ReportListResponse;
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

    public class Reports extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private const PAGESIZE:int = 10;
        private var _995752784pageNo:int = 1;
        private var _926048954deleteselected:Button;
        private var _1931386510reportType:int;
        private var reportPending:int = -1;
        private var _3203dg:DataGrid;
        private var _577409037totalPage:int = 1;
        private var _1148866775jumpto:TextInput;
        private var _358707178deleteall:Button;
        private var _838846263update:Button;
        private var _1931047938reportInfo:TextArea;
        private var _250597072myReportPageNo:Label;

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
                                                    return ({"width":15});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Reports_Button2_click"},
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
                                                "id":"myReportPageNo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"REmainFormText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___Reports_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"nextBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"deleteselected",
                                                "events":{"click":"__deleteselected_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Delete"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"deleteall",
                                                "events":{"click":"__deleteall_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"REwinBtn",
                                                        "label":"Delete All"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":10});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VDividedBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
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
                                                        "minHeight":50,
                                                        "percentHeight":50,
                                                        "percentWidth":100,
                                                        "resizableColumns":true,
                                                        "rowHeight":23,
                                                        "selectable":true,
                                                        "showHeaders":true,
                                                        "sortableColumns":false,
                                                        "variableRowHeight":true,
                                                        "visible":true,
                                                        "wordWrap":false,
                                                        "columns":[_Reports_DataGridColumn1_c(), _Reports_DataGridColumn2_c(), _Reports_DataGridColumn3_c(), _Reports_DataGridColumn4_c(), _Reports_DataGridColumn5_c(), _Reports_DataGridColumn6_c()]
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
                                                        "percentHeight":50,
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
        private var _1472425946reportsArray:ArrayCollection = new ArrayCollection();
        private var reportCached:Object = new Object();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Reports()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___Reports_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Reports._watcherSetupUtil = _arg_1;
        }

        private static function format(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            if (_arg_3 == "")
            {
                return ("");
            };
            return ((((_arg_1 + " ") + _arg_2) + ": ") + _arg_3);
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

        private function deleteAll():void
        {
            ActionFactory.getInstance().getReportCommands().deleteAllReports(this.reportType, this.deleteResponse);
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

        public function fetchReport(_arg_1:int):ActionFactoryResponse
        {
            if (((_arg_1 < 0) || (_arg_1 > this.reportsArray.length)))
            {
                return (null);
            };
            if (this.reportCached[("xml" + this.reportsArray[_arg_1].id)] != undefined)
            {
                return (this.reportCached[("xml" + this.reportsArray[_arg_1].id)]);
            };
            ActionFactory.getInstance().getReportCommands().markAsRead(this.reportsArray[_arg_1].id, this._gc827);
            return (null);
        }

        private function _iy128():void
        {
            this.pageNo = ((this.jumpto.text.length > 0) ? int(this.jumpto.text) : 0);
            if (this.pageNo > this.totalPage)
            {
                this.pageNo = this.totalPage;
            };
            if (this.pageNo < 1)
            {
                this.pageNo = 1;
            };
            this.updateData();
        }

        private function _Reports_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Type";
            _local_1.dataField = "typeStr";
            _local_1.width = 0.075;
            return (_local_1);
        }

        private function deleteResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.updateData();
                this.reportInfo.htmlText = "";
            };
        }

        private function _Reports_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Time";
            _local_1.dataField = "timeStr";
            _local_1.width = 0.25;
            return (_local_1);
        }

        private function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
            if (this.reportType == ObjConstants.REPORT_TYPE_ARMY)
            {
                addEventListener(Event.RENDER, this._bc516);
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

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            if (_arg_1 != null)
            {
                this.pageNo = 1;
            };
            this.fetchPage(this.pageNo);
        }

        public function __dg_change(_arg_1:ListEvent):void
        {
            this._ro876();
        }

        public function set reportType(_arg_1:int):void
        {
            var _local_2:Object = this._1931386510reportType;
            if (_local_2 !== _arg_1)
            {
                this._1931386510reportType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportType", _local_2, _arg_1));
            };
        }

        private function _jp80(_arg_1:TextEvent):void
        {
            navigateToURL(new URLRequest(("http://" + _arg_1.text)), "_blank");
        }

        override public function initialize():void
        {
            var target:Reports;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Reports_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Reports_ReportsWatcherSetupUtil");
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

        private function _gc827(_arg_1:ReportResponse):void
        {
            var _local_6:String;
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                return;
            };
            this._bl149();
            var _local_2:String = ((_arg_1.report.attack) ? "ATT" : "DEF");
            var _local_3:XML = new XML(_arg_1.report.content);
            var _local_4:* = "";
            var _local_5:* = "";
            if (_arg_1.report.armyType == ObjConstants.ARMY_MISSION_SCOUT)
            {
                _local_4 = Utils.formatUrl(((((((((_local_2 + " ") + _arg_1.report.title) + " on ") + _arg_1.report.eventTime) + " from ") + _arg_1.report.startPos) + " to ") + _arg_1.report.targetPos), _local_3.@reportUrl);
                if (((_arg_1.report.attack) && (_local_3.scoutReport.@isSuccess == "true")))
                {
                    _local_5 = ("  " + CityManager._wd318(_local_3.scoutReport));
                };
            }
            else
            {
                if (((_arg_1.report.armyType == ObjConstants.ARMY_MISSION_COLONIZE) || (_arg_1.report.armyType == ObjConstants.ARMY_MISSION_OCCUPY)))
                {
                    _local_4 = Utils.formatUrl(((((((((_local_2 + " ") + _arg_1.report.title) + " on ") + _arg_1.report.eventTime) + " from ") + _arg_1.report.startPos) + " to ") + _arg_1.report.targetPos), _local_3.@reportUrl);
                    _local_5 = ("  " + Utils.armyReportToString(_local_3.battleReport));
                    _local_5 = (_local_5 + ((((((("\n " + format("", "Honor", _local_3.battleReport.@honor)) + format("", "round", _local_3.battleReport.@round)) + format(",", "prestige", _local_3.battleReport.@prestige)) + format(",", "hero exp", _local_3.battleReport.@heroExp)) + format(",", "healing", _local_3.battleReport.@injuredPer)) + format(",", "loyalty trend", _local_3.battleReport.@support)) + format(",", "outcome", _local_3.battleReport.@seizeProblem)));
                    if (_local_3.battleReport.lootResource.food.toString() != "")
                    {
                        _local_5 = (_local_5 + ((((((((("\n  Loot: g:" + _local_3.battleReport.lootResource.gold) + ",f:") + _local_3.battleReport.lootResource.food) + ",w:") + _local_3.battleReport.lootResource.wood) + ",s:") + _local_3.battleReport.lootResource.stone) + ",i:") + _local_3.battleReport.lootResource.iron));
                    };
                    if (_local_3.battleReport.autoHeal.troopUnit.toString() != "")
                    {
                        _local_5 = (_local_5 + ((("\n  Auto heal: " + CityManager._ix545(_local_3.battleReport.autoHeal.troopUnit)) + ", gold cost: ") + _local_3.battleReport.autoHeal.@gold));
                    };
                }
                else
                {
                    if (_arg_1.report.type == 2)
                    {
                        _local_6 = _local_3.policyReport.@detail;
                        if (_arg_1.report.content.indexOf("<") == -1)
                        {
                            _local_4 = ((((("@" + _arg_1.report.title) + " on ") + _arg_1.report.eventTime) + " ") + _arg_1.report.content);
                        }
                        else
                        {
                            if (_local_6 != "")
                            {
                                _local_4 = ((((("@" + _arg_1.report.title) + " on ") + _arg_1.report.eventTime) + " ") + _local_6);
                            }
                            else
                            {
                                _local_4 = ((("@" + _arg_1.report.title) + " on ") + _arg_1.report.eventTime);
                                _local_5 = _arg_1.report.content;
                                _local_5 = _local_5.split("<").join("[");
                                _local_5 = _local_5.split(">").join("]");
                            };
                        };
                    };
                };
            };
            this.reportCached[_arg_1.report.id] = Utils.getServerTime();
            this.reportCached[("xml" + _arg_1.report.id)] = new ActionFactoryResponse(_local_3);
            this.reportCached[("report" + _arg_1.report.id)] = ((((_local_4 + "\n") + _local_5) + "\n\n") + this.reportCached[("xml" + _arg_1.report.id)].toDebugString());
            if (((!(this.dg.selectedIndex == -1)) && (this.dg.selectedItem.id == _arg_1.report.id)))
            {
                this.reportsArray[this.dg.selectedIndex].isReadStr = "Y";
                this.dg.invalidateList();
                this.reportInfo.htmlText = this.reportCached[("report" + _arg_1.report.id)];
            };
        }

        public function ___Reports_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        [Bindable(event="propertyChange")]
        public function get reportType():int
        {
            return (this._1931386510reportType);
        }

        private function _Reports_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ("/" + this.totalPage);
            _local_1 = (this.dg.selectedIndex > -1);
            _local_1 = (this.reportsArray.length > 0);
            _local_1 = this.reportsArray;
        }

        private function nextPage():void
        {
            if (this.pageNo >= this.totalPage)
            {
                return;
            };
            this.pageNo++;
            this.updateData();
        }

        public function ___Reports_Button3_click(_arg_1:MouseEvent):void
        {
            this.nextPage();
        }

        public function __jumpto_enter(_arg_1:FlexEvent):void
        {
            this._iy128();
        }

        public function set reportsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1472425946reportsArray;
            if (_local_2 !== _arg_1)
            {
                this._1472425946reportsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportsArray", _local_2, _arg_1));
            };
        }

        private function _Reports_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "From";
            _local_1.dataField = "startPos";
            _local_1.width = 0.3;
            return (_local_1);
        }

        public function __reportInfo_link(_arg_1:TextEvent):void
        {
            this._jp80(_arg_1);
        }

        public function set deleteselected(_arg_1:Button):void
        {
            var _local_2:Object = this._926048954deleteselected;
            if (_local_2 !== _arg_1)
            {
                this._926048954deleteselected = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "deleteselected", _local_2, _arg_1));
            };
        }

        private function _bc516(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            removeEventListener(Event.RENDER, this._bc516);
            this.updateData();
        }

        private function _ro876():void
        {
            if (this.dg.selectedIndex == -1)
            {
                this.reportInfo.htmlText = "";
                return;
            };
            if (this.reportCached[("report" + this.dg.selectedItem.id)] != undefined)
            {
                this.reportInfo.htmlText = this.reportCached[("report" + this.dg.selectedItem.id)];
                return;
            };
            this.reportPending = this.dg.selectedItem.id;
            ActionFactory.getInstance().getReportCommands().markAsRead(this.dg.selectedItem.id, this._gc827);
        }

        public function __deleteselected_click(_arg_1:MouseEvent):void
        {
            this.deleteSelected();
        }

        public function __deleteall_click(_arg_1:MouseEvent):void
        {
            this.deleteAll();
        }

        [Bindable(event="propertyChange")]
        public function get jumpto():TextInput
        {
            return (this._1148866775jumpto);
        }

        public function set myReportPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._250597072myReportPageNo;
            if (_local_2 !== _arg_1)
            {
                this._250597072myReportPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myReportPageNo", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        [Bindable(event="propertyChange")]
        public function get deleteselected():Button
        {
            return (this._926048954deleteselected);
        }

        public function set deleteall(_arg_1:Button):void
        {
            var _local_2:Object = this._358707178deleteall;
            if (_local_2 !== _arg_1)
            {
                this._358707178deleteall = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "deleteall", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get deleteall():Button
        {
            return (this._358707178deleteall);
        }

        private function _Reports_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Subject";
            _local_1.dataField = "title";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _Reports_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "To";
            _local_1.dataField = "targetPos";
            _local_1.width = 0.3;
            return (_local_1);
        }

        private function _la1157(_arg_1:ReportListResponse):void
        {
            var _local_3:ReportBean;
            this.reportsArray.removeAll();
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                return;
            };
            this.totalPage = _arg_1.totalPage;
            var _local_2:Object;
            for each (_local_3 in _arg_1.reportsArray)
            {
                _local_2 = _local_3.toObject();
                _local_2.rawData = _local_3;
                _local_2.isReadStr = ((_local_3.isRead) ? "Y" : "N");
                _local_2.typeStr = ((_local_3.attack) ? "ATT" : "DEF");
                _local_2.timeStr = _local_3.eventTime;
                this.reportsArray.addItem(_local_2);
            };
        }

        private function _Reports_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Read";
            _local_1.dataField = "isReadStr";
            _local_1.width = 0.075;
            return (_local_1);
        }

        public function toDebugString():String
        {
            return ("field: reportsArray, method: fetchPage(int) fetchReport(int), columns: isReadStr typeStr title startPos targetPos timeStr rawData");
        }

        private function _ng881():void
        {
            if (this.dg.selectedIndex == -1)
            {
                return;
            };
            this.reportsArray.removeItemAt(this.dg.selectedIndex);
            ActionFactory.getInstance().getReportCommands().deleteReport(("" + this.dg.selectedItem.id));
        }

        private function _mg723():void
        {
            if (this.pageNo <= 1)
            {
                return;
            };
            this.pageNo--;
            this.updateData();
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

        public function set jumpto(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1148866775jumpto;
            if (_local_2 !== _arg_1)
            {
                this._1148866775jumpto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "jumpto", _local_2, _arg_1));
            };
        }

        private function deleteSelected():void
        {
            if (this.dg.selectedIndex != -1)
            {
                ActionFactory.getInstance().getReportCommands().deleteReport(this.dg.selectedItem.id, this.deleteResponse);
            };
        }

        [Bindable(event="propertyChange")]
        public function get myReportPageNo():Label
        {
            return (this._250597072myReportPageNo);
        }

        public function fetchPage(_arg_1:int):void
        {
            ActionFactory.getInstance().getReportCommands().receiveReportList(_arg_1, this.PAGESIZE, this.reportType, this._la1157);
            this.jumpto.text = ("" + _arg_1);
            this.pageNo = _arg_1;
        }

        public function ___Reports_Button2_click(_arg_1:MouseEvent):void
        {
            this._mg723();
        }

        [Bindable(event="propertyChange")]
        public function get update():Button
        {
            return (this._838846263update);
        }

        private function _bl149():void
        {
            var _local_2:String;
            var _local_1:Number = (Utils.getServerTime() - (3600 * 1000));
            for (_local_2 in this.reportCached)
            {
                if (String(_local_2).indexOf("report") != 0)
                {
                    if ((this.reportCached[_local_2] < _local_1))
                    {
                        delete this.reportCached[_local_2];
                        delete this.reportCached[("report" + _local_2)];
                        delete this.reportCached[("xml" + _local_2)];
                    };
                };
            };
        }

        private function _Reports_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ("/" + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                myReportPageNo.text = _arg_1;
            }, "myReportPageNo.text");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.dg.selectedIndex > -1);
            }, function (_arg_1:Boolean):void
            {
                deleteselected.enabled = _arg_1;
            }, "deleteselected.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.reportsArray.length > 0);
            }, function (_arg_1:Boolean):void
            {
                deleteall.enabled = _arg_1;
            }, "deleteall.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.reportsArray);
            }, function (_arg_1:Object):void
            {
                dg.dataProvider = _arg_1;
            }, "dg.dataProvider");
            result[3] = binding;
            return (result);
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

        public function __update_click(_arg_1:MouseEvent):void
        {
            this._iy128();
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get reportsArray():ArrayCollection
        {
            return (this._1472425946reportsArray);
        }


    }
}//package autoevony.gui.info.Reports

