// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.Events

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.formatters.DateFormatter;
    import mx.controls.TextInput;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import autoevony.common.Utils;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.events.FlexEvent;
    import autoevony.gui.MainScreen;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.common.beans.AllianceEvent;
    import com.evony.common.module.alliance.AllianceEventListResponse;
    import com.evony.client.action.ActionFactory;
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

    public class Events extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1765123250formatDateTime:DateFormatter;
        private var _995752784pageNo:int = 1;
        private var _577409037totalPage:int = 1;
        private var _1148866775jumpto:TextInput;
        private var _1955651121_AllianceEvents_DataGrid1:DataGrid;
        private var _838846263update:Button;
        private var _833068973_WarReportPageNo:Label;

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
                                                "events":{"click":"___Events_Button2_click"},
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
                                                "events":{"click":"___Events_Button3_click"},
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
                                    "type":DataGrid,
                                    "id":"_AllianceEvents_DataGrid1",
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
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "resizableColumns":true,
                                            "rowHeight":23,
                                            "selectable":false,
                                            "showHeaders":true,
                                            "sortableColumns":false,
                                            "variableRowHeight":true,
                                            "visible":true,
                                            "wordWrap":false,
                                            "columns":[_Events_DataGridColumn1_c(), _Events_DataGridColumn2_c()]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _976185536eventsArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Events()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this._Events_DateFormatter1_i();
            this.addEventListener("creationComplete", this.___Events_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Events._watcherSetupUtil = _arg_1;
        }


        public function set eventsArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._976185536eventsArray;
            if (_local_2 !== _arg_1)
            {
                this._976185536eventsArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "eventsArray", _local_2, _arg_1));
            };
        }

        internal function _iy128():void
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

        private function _Events_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Event";
            _local_1.dataField = "eventName";
            _local_1.width = 0.77;
            _local_1.showDataTips = true;
            return (_local_1);
        }

        internal function init():void
        {
            addEventListener(FlexEvent.SHOW, this.updateData);
        }

        internal function updateData(_arg_1:Object=null):void
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
                this.eventsArray.removeAll();
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

        override public function initialize():void
        {
            var target:Events;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._Events_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_EventsWatcherSetupUtil");
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

        private function _Events_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ("/" + this.totalPage);
            _local_1 = this.eventsArray;
        }

        public function ___Events_Button2_click(_arg_1:MouseEvent):void
        {
            this.previousPage();
        }

        internal function previousPage():void
        {
            if (this.pageNo <= 1)
            {
                return;
            };
            this.pageNo--;
            this.updateData();
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

        [Bindable(event="propertyChange")]
        public function get jumpto():TextInput
        {
            return (this._1148866775jumpto);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceEvents_DataGrid1():DataGrid
        {
            return (this._1955651121_AllianceEvents_DataGrid1);
        }

        [Bindable(event="propertyChange")]
        public function get formatDateTime():DateFormatter
        {
            return (this._1765123250formatDateTime);
        }

        [Bindable(event="propertyChange")]
        public function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        [Bindable(event="propertyChange")]
        public function get eventsArray():ArrayCollection
        {
            return (this._976185536eventsArray);
        }

        internal function nextPage():void
        {
            if (this.pageNo >= this.totalPage)
            {
                return;
            };
            this.pageNo++;
            this.updateData();
        }

        private function _Events_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Time";
            _local_1.dataField = "timeStr";
            _local_1.width = 0.23;
            return (_local_1);
        }

        private function _Events_DateFormatter1_i():DateFormatter
        {
            var _local_1:DateFormatter = new DateFormatter();
            this.formatDateTime = _local_1;
            _local_1.formatString = "MM/DD/YY JJ:NN:SS";
            return (_local_1);
        }

        public function toDebugString():String
        {
            return ("fields: eventsArray pageNo totalPage, method: fetchPage(int), columns: timeStr eventName rawData");
        }

        internal function _vm184(_arg_1:AllianceEventListResponse):void
        {
            var _local_3:AllianceEvent;
            this.eventsArray.removeAll();
            if (_arg_1.ok != 1)
            {
                return;
            };
            this.totalPage = _arg_1.totalPage;
            var _local_2:Object;
            for each (_local_3 in _arg_1.eventsArray)
            {
                _local_2 = _local_3.toObject();
                _local_2.rawData = _local_3;
                _local_2.timeStr = this.formatDateTime.format(new Date(_local_3.time).toString());
                this.eventsArray.addItem(_local_2);
            };
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

        public function set _WarReportPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._833068973_WarReportPageNo;
            if (_local_2 !== _arg_1)
            {
                this._833068973_WarReportPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_WarReportPageNo", _local_2, _arg_1));
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

        public function set _AllianceEvents_DataGrid1(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1955651121_AllianceEvents_DataGrid1;
            if (_local_2 !== _arg_1)
            {
                this._1955651121_AllianceEvents_DataGrid1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceEvents_DataGrid1", _local_2, _arg_1));
            };
        }

        public function ___Events_Button3_click(_arg_1:MouseEvent):void
        {
            this.nextPage();
        }

        public function set formatDateTime(_arg_1:DateFormatter):void
        {
            var _local_2:Object = this._1765123250formatDateTime;
            if (_local_2 !== _arg_1)
            {
                this._1765123250formatDateTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "formatDateTime", _local_2, _arg_1));
            };
        }

        public function ___Events_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
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

        private function _Events_bindingsSetup():Array
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
                return (eventsArray);
            }, function (_arg_1:Object):void
            {
                _AllianceEvents_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceEvents_DataGrid1.dataProvider");
            result[1] = binding;
            return (result);
        }

        public function fetchPage(_arg_1:int):void
        {
            ActionFactory.getInstance().getAllianceCommands().getAllianceEventList(_arg_1, this._vm184);
            this.pageNo = _arg_1;
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


    }
}//package autoevony.gui.info.Alliance

