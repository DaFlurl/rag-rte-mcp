// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.PublicReportCanvas

package view.module.info
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.containers.ViewStack;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.collections.ArrayCollection;
    import mx.controls.CheckBox;
    import com.evony.common.beans.ReportBean;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import com.evony.Context;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import flash.events.Event;
    import mx.binding.BindingManager;
    import mx.core.ClassFactory;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.report.ReportResponse;
    import flash.external.ExternalInterface;
    import com.evony.data.FbData;
    import com.adobe.crypto.MD5;
    import com.evony.GameConfig;
    import com.evony.common.module.report.ShareReportResponse;
    import com.evony.common.constants.MailConstants;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.report.ReportListResponse;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.constants.ObjConstants;
    import view.MainWin;
    import view.AllWindows;
    import view.castle.MainFrame;
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

    public class PublicReportCanvas extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _PublicReportCanvas_Label1:Label;
        private var _1788676624dataGrid:DataGrid;
        private var pageSize:int = 10;
        private var _741835769markAsReadBtn:Button;
        public var _PublicReportCanvas_Button6:Button;
        public var _PublicReportCanvas_Button7:Button;
        public var _PublicReportCanvas_Button8:Button;
        public var _PublicReportCanvas_Button9:Button;
        public var _PublicReportCanvas_ViewStack1:ViewStack;
        public var _PublicReportCanvas_DataGridColumn1:DataGridColumn;
        public var _PublicReportCanvas_DataGridColumn2:DataGridColumn;
        public var _PublicReportCanvas_DataGridColumn3:DataGridColumn;
        public var _PublicReportCanvas_DataGridColumn4:DataGridColumn;
        public var _PublicReportCanvas_DataGridColumn5:DataGridColumn;
        public var _PublicReportCanvas_DataGridColumn6:DataGridColumn;
        private var _1002218112startPosVisible:Boolean = false;
        private var _358736719deleteBtn:Button;
        private var _796560649reportDetailWin:PublicReportDetail;
        private var _1343253965viewstackSelectIndex:int = 0;
        private var _823877195reportBeanArray:ArrayCollection;
        private var _1517916439selectAllBtn:Button;
        public var _PublicReportCanvas_CheckBox1:CheckBox;
        private var _577409037totalPage:int = 0;
        private var _1125923055curPage:int = 1;
        private var reoprtType:int;
        private var _258469375curRepoet:ReportBean;
        private var isSelectAll:Boolean = false;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"_PublicReportCanvas_ViewStack1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "percentHeight":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.right = "0";
                                                    this.verticalAlign = "middle";
                                                    this.top = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":174,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PublicReportCanvas_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"previous"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_PublicReportCanvas_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"ftp14f"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___PublicReportCanvas_Button2_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"next"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"dataGrid",
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "33";
                                                    this.top = "30";
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":753,
                                                        "styleName":"style2",
                                                        "editable":false,
                                                        "allowMultipleSelection":false,
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "rowHeight":34.5,
                                                        "verticalScrollPolicy":"off",
                                                        "columns":[_PublicReportCanvas_DataGridColumn1_i(), _PublicReportCanvas_DataGridColumn2_i(), _PublicReportCanvas_DataGridColumn3_i(), _PublicReportCanvas_DataGridColumn4_i(), _PublicReportCanvas_DataGridColumn5_i(), _PublicReportCanvas_DataGridColumn6_i()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "0";
                                                    this.right = "10";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                    this.horizontalGap = 2;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"markAsReadBtn",
                                                            "events":{"click":"__markAsReadBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"selectAllBtn",
                                                            "events":{"click":"__selectAllBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"deleteBtn",
                                                            "events":{"click":"__deleteBtn_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"y125",
                                                                    "enabled":true
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_PublicReportCanvas_Button6",
                                                            "events":{"click":"___PublicReportCanvas_Button6_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"y125",
                                                                    "enabled":true
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"_PublicReportCanvas_CheckBox1",
                                                "events":{"change":"___PublicReportCanvas_CheckBox1_change"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFFFFFF;
                                                    this.left = "10";
                                                    this.bottom = "0";
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":PublicReportDetail,
                                                "id":"reportDetailWin",
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "38";
                                                    this.top = "25";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "10";
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.right = "10";
                                                    this.horizontalGap = 2;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":270,
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_PublicReportCanvas_Button7",
                                                            "events":{"click":"___PublicReportCanvas_Button7_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "label":"Share Report",
                                                                    "styleName":"y125"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_PublicReportCanvas_Button8",
                                                            "events":{"click":"___PublicReportCanvas_Button8_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_PublicReportCanvas_Button9",
                                                            "events":{"click":"___PublicReportCanvas_Button9_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"y125"});
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
                    })]});
            }
        });
        private var _1911605294targetPosName:String = Lang.msg("目的地");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PublicReportCanvas()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PublicReportCanvas._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get curRepoet():ReportBean
        {
            return (this._258469375curRepoet);
        }

        [Bindable(event="propertyChange")]
        public function get markAsReadBtn():Button
        {
            return (this._741835769markAsReadBtn);
        }

        private function set curRepoet(_arg_1:ReportBean):void
        {
            var _local_2:Object = this._258469375curRepoet;
            if (_local_2 !== _arg_1)
            {
                this._258469375curRepoet = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curRepoet", _local_2, _arg_1));
            };
        }

        private function _PublicReportCanvas_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.viewstackSelectIndex);
            }, function (_arg_1:int):void
            {
                _PublicReportCanvas_ViewStack1.selectedIndex = _arg_1;
            }, "_PublicReportCanvas_ViewStack1.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_Label1.text = _arg_1;
            }, "_PublicReportCanvas_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.reportBeanArray);
            }, function (_arg_1:Object):void
            {
                dataGrid.dataProvider = _arg_1;
            }, "dataGrid.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn1.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("主题");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn2.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("出发地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn3.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.startPosVisible);
            }, function (_arg_1:Boolean):void
            {
                _PublicReportCanvas_DataGridColumn3.visible = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn3.visible");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.targetPosName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn4.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn4.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn5.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn5.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看T");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_DataGridColumn6.headerText = _arg_1;
            }, "_PublicReportCanvas_DataGridColumn6.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("标记为已读");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                markAsReadBtn.label = _arg_1;
            }, "markAsReadBtn.label");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("全部选择");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                selectAllBtn.label = _arg_1;
            }, "selectAllBtn.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("删除选定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                deleteBtn.label = _arg_1;
            }, "deleteBtn.label");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("删除所有");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_Button6.label = _arg_1;
            }, "_PublicReportCanvas_Button6.label");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().getPlayerBean().returnReport);
            }, function (_arg_1:Boolean):void
            {
                _PublicReportCanvas_CheckBox1.selected = _arg_1;
            }, "_PublicReportCanvas_CheckBox1.selected");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("不接受返回报告");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_CheckBox1.label = _arg_1;
            }, "_PublicReportCanvas_CheckBox1.label");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("没返回报告提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_CheckBox1.toolTip = _arg_1;
            }, "_PublicReportCanvas_CheckBox1.toolTip");
            result[16] = binding;
            binding = new Binding(this, function ():ReportBean
            {
                return (this.curRepoet);
            }, function (_arg_1:ReportBean):void
            {
                reportDetailWin.reportBean = _arg_1;
            }, "reportDetailWin.reportBean");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (Context.getInstance().facebookUser);
            }, function (_arg_1:Boolean):void
            {
                _PublicReportCanvas_Button7.visible = _arg_1;
            }, "_PublicReportCanvas_Button7.visible");
            result[18] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看发生地");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_Button8.label = _arg_1;
            }, "_PublicReportCanvas_Button8.label");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PublicReportCanvas_Button9.label = _arg_1;
            }, "_PublicReportCanvas_Button9.label");
            result[20] = binding;
            return (result);
        }

        public function ___PublicReportCanvas_Button9_click(_arg_1:MouseEvent):void
        {
            this.viewstackSelectIndex = 0;
            this.getReportListFromServer();
        }

        private function setReturnReport(_arg_1:Event):void
        {
            ActionFactory.getInstance().getCommonCommands().setReturnReport(_arg_1.target.selected, setReturnReportResponse);
        }

        public function set markAsReadBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._741835769markAsReadBtn;
            if (_local_2 !== _arg_1)
            {
                this._741835769markAsReadBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "markAsReadBtn", _local_2, _arg_1));
            };
        }

        private function onMarkAsReadSelected():void
        {
            var _local_1:String;
            var _local_2:ReportBean;
            if (this.reportBeanArray != null)
            {
                _local_1 = "";
                for each (_local_2 in this.reportBeanArray)
                {
                    if (_local_2.selected)
                    {
                        if (_local_1.length > 0)
                        {
                            _local_1 = (_local_1 + ",");
                        };
                        _local_1 = (_local_1 + _local_2.id);
                    };
                };
            };
            if (_local_1.length > 0)
            {
                ActionFactory.getInstance().getReportCommands().readOverReport(_local_1, onMarkSelectedResponse);
            };
        }

        [Bindable(event="propertyChange")]
        public function get dataGrid():DataGrid
        {
            return (this._1788676624dataGrid);
        }

        [Bindable(event="propertyChange")]
        public function get selectAllBtn():Button
        {
            return (this._1517916439selectAllBtn);
        }

        public function set dataGrid(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1788676624dataGrid;
            if (_local_2 !== _arg_1)
            {
                this._1788676624dataGrid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataGrid", _local_2, _arg_1));
            };
        }

        private function set startPosVisible(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1002218112startPosVisible;
            if (_local_2 !== _arg_1)
            {
                this._1002218112startPosVisible = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "startPosVisible", _local_2, _arg_1));
            };
        }

        private function onDelectSelected():void
        {
            var _local_1:String;
            var _local_2:ReportBean;
            if (this.reportBeanArray != null)
            {
                _local_1 = "";
                for each (_local_2 in this.reportBeanArray)
                {
                    if (_local_2.selected)
                    {
                        if (_local_1.length > 0)
                        {
                            _local_1 = (_local_1 + ",");
                        };
                        _local_1 = (_local_1 + _local_2.id);
                    };
                };
            };
            if (_local_1.length > 0)
            {
                ActionFactory.getInstance().getReportCommands().deleteReport(_local_1, onDelectInfoResponse);
            };
        }

        private function _PublicReportCanvas_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn2 = _local_1;
            _local_1.dataField = "title";
            _local_1.width = 150;
            _local_1.itemRenderer = _PublicReportCanvas_ClassFactory2_c();
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn2", _PublicReportCanvas_DataGridColumn2);
            return (_local_1);
        }

        public function set selectAllBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1517916439selectAllBtn;
            if (_local_2 !== _arg_1)
            {
                this._1517916439selectAllBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectAllBtn", _local_2, _arg_1));
            };
        }

        private function _PublicReportCanvas_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn6 = _local_1;
            _local_1.dataField = "title";
            _local_1.width = 80;
            _local_1.itemRenderer = _PublicReportCanvas_ClassFactory5_c();
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn6", _PublicReportCanvas_DataGridColumn6);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get targetPosName():String
        {
            return (this._1911605294targetPosName);
        }

        private function _PublicReportCanvas_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PublicReportCanvas_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get viewstackSelectIndex():int
        {
            return (this._1343253965viewstackSelectIndex);
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.getReportListFromServer();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        private function _PublicReportCanvas_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PublicReportCanvas_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___PublicReportCanvas_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        public function __selectAllBtn_click(_arg_1:MouseEvent):void
        {
            onSelectAll();
        }

        public function ___PublicReportCanvas_Button6_click(_arg_1:MouseEvent):void
        {
            onDelectAll();
        }

        private function onMarkAsRead(_arg_1:ReportResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.curRepoet = _arg_1.report;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set deleteBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._358736719deleteBtn;
            if (_local_2 !== _arg_1)
            {
                this._358736719deleteBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "deleteBtn", _local_2, _arg_1));
            };
        }

        private function onReportResponse(_arg_1:ShareReportResponse):void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            if (ExternalInterface.available)
            {
                _local_2 = ExternalInterface.call("facebook.fb_getUserName");
                _local_3 = FbData.getInstance().getValue(10002);
                _local_4 = (_local_2 + " got an interesting report during playing Evony! Click to check it out!");
                _local_5 = "";
                _local_6 = (((((((('{"name":"' + _local_4) + '","href":"') + _arg_1.reportUrl) + '","description":"') + _local_5) + '","media":[{"type":"image","src":"') + _local_3.img) + '"}]}');
                _local_7 = "";
                _local_8 = "";
                _local_9 = Context.getInstance().GetGuidStr();
                _local_8 = MD5.hash((((("PlayEvony" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                _local_7 = (((((((((((((("{'text':'Play Evony with " + _local_2) + " Now!', 'href':'") + GameConfig.instance.FbActionUrl) + "?T=PlayEvony&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=10002&GUID=") + _local_9) + "&sign=") + _local_8) + "'}");
                ExternalInterface.call("facebook.fb_streamPublish", "", _local_6, _local_7, "", "", GameConfig.instance.serverID, 10002, _local_9);
            };
        }

        private function set viewstackSelectIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1343253965viewstackSelectIndex;
            if (_local_2 !== _arg_1)
            {
                this._1343253965viewstackSelectIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstackSelectIndex", _local_2, _arg_1));
            };
        }

        private function setReturnReportResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().getPlayerBean().returnReport = (!(Context.getInstance().getPlayerBean().returnReport));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onMarkSelectedResponse(_arg_1:ReportResponse):void
        {
            var _local_2:ReportBean;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                for each (_local_2 in this.reportBeanArray)
                {
                    if (_local_2.selected)
                    {
                        _local_2.selected = false;
                        _local_2.isRead = MailConstants.IS_READ;
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _PublicReportCanvas_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn1 = _local_1;
            _local_1.width = 80;
            _local_1.itemRenderer = _PublicReportCanvas_ClassFactory1_c();
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn1", _PublicReportCanvas_DataGridColumn1);
            return (_local_1);
        }

        private function set targetPosName(_arg_1:String):void
        {
            var _local_2:Object = this._1911605294targetPosName;
            if (_local_2 !== _arg_1)
            {
                this._1911605294targetPosName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "targetPosName", _local_2, _arg_1));
            };
        }

        private function _PublicReportCanvas_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn5 = _local_1;
            _local_1.dataField = "eventTime";
            _local_1.width = 130;
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn5", _PublicReportCanvas_DataGridColumn5);
            return (_local_1);
        }

        public function __markAsReadBtn_click(_arg_1:MouseEvent):void
        {
            onMarkAsReadSelected();
        }

        private function _PublicReportCanvas_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PublicReportCanvas_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___PublicReportCanvas_Button7_click(_arg_1:MouseEvent):void
        {
            ShareReport();
        }

        private function _PublicReportCanvas_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.viewstackSelectIndex;
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = this.reportBeanArray;
            _local_1 = Lang.msg("选择");
            _local_1 = Lang.msg("主题");
            _local_1 = Lang.msg("出发地");
            _local_1 = this.startPosVisible;
            _local_1 = this.targetPosName;
            _local_1 = Lang.msg("时间");
            _local_1 = Lang.msg("查看T");
            _local_1 = Lang.msg("标记为已读");
            _local_1 = Lang.msg("全部选择");
            _local_1 = Lang.msg("删除选定");
            _local_1 = Lang.msg("删除所有");
            _local_1 = Context.getInstance().getPlayerBean().returnReport;
            _local_1 = Lang.msg("不接受返回报告");
            _local_1 = Lang.msg("没返回报告提示");
            _local_1 = this.curRepoet;
            _local_1 = Context.getInstance().facebookUser;
            _local_1 = Lang.msg("查看发生地");
            _local_1 = Lang.msg("返回");
        }

        [Bindable(event="propertyChange")]
        private function get startPosVisible():Boolean
        {
            return (this._1002218112startPosVisible);
        }

        override public function initialize():void
        {
            var target:PublicReportCanvas;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PublicReportCanvas_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_PublicReportCanvasWatcherSetupUtil");
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

        public function ___PublicReportCanvas_CheckBox1_change(_arg_1:Event):void
        {
            setReturnReport(_arg_1);
        }

        private function onGetPublicReport(_arg_1:ReportListResponse):void
        {
            if (this.reportBeanArray != null)
            {
                this.reportBeanArray.removeAll();
            };
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.changeAllCheckBox(false);
                this.curPage = _arg_1.pageNo;
                this.totalPage = _arg_1.totalPage;
                this.reportBeanArray = _arg_1.reportsArray;
            };
        }

        private function onDelectInfoResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.changeAllCheckBox(false);
                this.curPage = 1;
                this.getReportListFromServer();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __deleteBtn_click(_arg_1:MouseEvent):void
        {
            onDelectSelected();
        }

        private function getReportListFromServer():void
        {
            ActionFactory.getInstance().getReportCommands().receiveReportList(this.curPage, this.pageSize, this.reoprtType, onGetPublicReport);
        }

        private function delAll(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getReportCommands().deleteAllReports(reoprtType, delAllResponse);
            };
        }

        private function changeAllCheckBox(_arg_1:Boolean):void
        {
            var _local_2:ReportBean;
            if (this.reportBeanArray != null)
            {
                for each (_local_2 in this.reportBeanArray)
                {
                    _local_2.selected = _arg_1;
                };
            };
            this.isSelectAll = _arg_1;
        }

        private function _PublicReportCanvas_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn4 = _local_1;
            _local_1.dataField = "targetPos";
            _local_1.width = 155;
            _local_1.itemRenderer = _PublicReportCanvas_ClassFactory4_c();
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn4", _PublicReportCanvas_DataGridColumn4);
            return (_local_1);
        }

        private function set reportBeanArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._823877195reportBeanArray;
            if (_local_2 !== _arg_1)
            {
                this._823877195reportBeanArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportBeanArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get deleteBtn():Button
        {
            return (this._358736719deleteBtn);
        }

        private function _PublicReportCanvas_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PublicReportCanvas_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function showDetail(_arg_1:ReportBean):void
        {
            this.viewstackSelectIndex = 1;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.REPORT_MARK_AS_READ, onMarkAsRead, false, 0, true);
            ActionFactory.getInstance().getReportCommands().markAsRead(_arg_1.id);
        }

        public function ___PublicReportCanvas_Button8_click(_arg_1:MouseEvent):void
        {
            gotoPoint();
        }

        [Bindable(event="propertyChange")]
        private function get reportBeanArray():ArrayCollection
        {
            return (this._823877195reportBeanArray);
        }

        private function ShareReport():void
        {
            ActionFactory.getInstance().getReportCommands().shareReport(this.curRepoet.id, onReportResponse);
        }

        public function refresh(_arg_1:int):void
        {
            this.reportBeanArray = null;
            this.reoprtType = _arg_1;
            this.curPage = 0;
            this.getReportListFromServer();
            this.viewstackSelectIndex = 0;
            if (((_arg_1 == ObjConstants.REPORT_TYPE_ARMY) || (_arg_1 == ObjConstants.REPORT_TYPE_SCOUT)))
            {
                this.startPosVisible = true;
                this.targetPosName = Lang.msg("目的地");
            }
            else
            {
                this.targetPosName = Lang.msg("发生地");
                this.startPosVisible = false;
            };
        }

        private function onDelectAll():void
        {
            AlertWin.show(Lang.msg("删除所有确认"), delAll);
        }

        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        private function getArrSelected():ArrayCollection
        {
            var _local_3:ReportBean;
            var _local_1:ArrayCollection = new ArrayCollection();
            var _local_2:int;
            while (_local_2 < this.reportBeanArray.length)
            {
                if (this.dataGrid.indexToItemRenderer(_local_2).document.chkBox.selected)
                {
                    _local_3 = (this.reportBeanArray[_local_2] as ReportBean);
                    _local_1.addItem(_local_3.id);
                };
                _local_2++;
            };
            return (_local_1);
        }

        private function _PublicReportCanvas_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _PublicReportCanvas_DataGridColumn3 = _local_1;
            _local_1.dataField = "startPos";
            _local_1.width = 155;
            _local_1.itemRenderer = _PublicReportCanvas_ClassFactory3_c();
            BindingManager.executeBindings(this, "_PublicReportCanvas_DataGridColumn3", _PublicReportCanvas_DataGridColumn3);
            return (_local_1);
        }

        private function onSelectAll():void
        {
            this.changeAllCheckBox((!(isSelectAll)));
        }

        public function set reportDetailWin(_arg_1:PublicReportDetail):void
        {
            var _local_2:Object = this._796560649reportDetailWin;
            if (_local_2 !== _arg_1)
            {
                this._796560649reportDetailWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "reportDetailWin", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        private function gotoPoint():void
        {
            MainWin.instance.cityInBtn.selected = false;
            MainWin.instance.cityOutBtn.selected = false;
            MainWin.instance.mapBtn.selected = true;
            AllWindows.closeAll();
            MainFrame.instance.switchToWorldMap();
            var _local_1:String = curRepoet.targetPos;
            _local_1 = _local_1.substring((_local_1.indexOf("(") + 1), _local_1.indexOf(")"));
            var _local_2:Array = _local_1.split(",");
            MainFrame.instance.setMapYet(_local_2[0], _local_2[1]);
        }

        private function set totalPage(_arg_1:int):void
        {
            var _local_2:Object = this._577409037totalPage;
            if (_local_2 !== _arg_1)
            {
                this._577409037totalPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "totalPage", _local_2, _arg_1));
            };
        }

        private function delAllResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.changeAllCheckBox(false);
                this.curPage = 1;
                this.getReportListFromServer();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _PublicReportCanvas_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = PublicReportCanvas_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function ___PublicReportCanvas_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        [Bindable(event="propertyChange")]
        public function get reportDetailWin():PublicReportDetail
        {
            return (this._796560649reportDetailWin);
        }


    }
}//package view.module.info

