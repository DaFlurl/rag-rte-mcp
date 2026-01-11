// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.militarySituationList.MilitarySituationList

package view.module.alliance.oldAlliance.militarySituationList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.info.PublicReportDetail;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.DataGrid;
    import mx.containers.ViewStack;
    import com.evony.common.beans.MilitarySituation;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.binding.BindingManager;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import mx.core.ClassFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.MilitarySituationListResponse;
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

    public class MilitarySituationList extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _796560649reportDetailWin:PublicReportDetail;
        private var _1343253965viewstackSelectIndex:int = 0;
        public var _MilitarySituationList_DataGridColumn1:DataGridColumn;
        public var _MilitarySituationList_DataGridColumn2:DataGridColumn;
        public var _MilitarySituationList_DataGridColumn3:DataGridColumn;
        public var _MilitarySituationList_DataGridColumn4:DataGridColumn;
        public var _MilitarySituationList_DataGridColumn5:DataGridColumn;
        private var _1941741961inboxDG:DataGrid;
        private var _577409037totalPage:int = 0;
        private var _1125923055curPage:int = 1;
        public var _MilitarySituationList_ViewStack1:ViewStack;
        private var _258469375curRepoet:MilitarySituation;
        public var _MilitarySituationList_Button3:Button;
        public var _MilitarySituationList_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"_MilitarySituationList_ViewStack1",
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
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"inboxDG",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "30";
                                                    this.bottom = "36";
                                                    this.left = "0";
                                                    this.right = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "enabled":false,
                                                        "styleName":"style2",
                                                        "resizableColumns":false,
                                                        "draggableColumns":false,
                                                        "sortableColumns":false,
                                                        "selectable":false,
                                                        "columns":[_MilitarySituationList_DataGridColumn1_i(), _MilitarySituationList_DataGridColumn2_i(), _MilitarySituationList_DataGridColumn3_i(), _MilitarySituationList_DataGridColumn4_i(), _MilitarySituationList_DataGridColumn5_i()]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.bottom = "5";
                                                    this.right = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":150,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "events":{"click":"___MilitarySituationList_Button1_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"previous"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_MilitarySituationList_Label1",
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
                                                            "events":{"click":"___MilitarySituationList_Button2_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"next"});
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":PublicReportDetail,
                                                "id":"reportDetailWin",
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "18";
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
                                                    this.bottom = "5";
                                                    this.horizontalAlign = "right";
                                                    this.verticalAlign = "middle";
                                                    this.right = "10";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":208,
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Button,
                                                            "id":"_MilitarySituationList_Button3",
                                                            "events":{"click":"___MilitarySituationList_Button3_click"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"b75",
                                                                    "width":69
                                                                });
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
        private var _459070430warDataP:ArrayCollection = new ArrayCollection();
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MilitarySituationList()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___MilitarySituationList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MilitarySituationList._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get curRepoet():MilitarySituation
        {
            return (this._258469375curRepoet);
        }

        private function _MilitarySituationList_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MilitarySituationList_DataGridColumn1 = _local_1;
            _local_1.dataField = "type";
            _local_1.labelFunction = setType;
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_MilitarySituationList_DataGridColumn1", _MilitarySituationList_DataGridColumn1);
            return (_local_1);
        }

        private function _MilitarySituationList_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MilitarySituationList_DataGridColumn3 = _local_1;
            _local_1.dataField = "otherAllianceName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_MilitarySituationList_DataGridColumn3", _MilitarySituationList_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get inboxDG():DataGrid
        {
            return (this._1941741961inboxDG);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        private function _MilitarySituationList_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MilitarySituationList_DataGridColumn5 = _local_1;
            _local_1.dataField = "type";
            _local_1.width = 80;
            _local_1.itemRenderer = _MilitarySituationList_ClassFactory1_c();
            BindingManager.executeBindings(this, "_MilitarySituationList_DataGridColumn5", _MilitarySituationList_DataGridColumn5);
            return (_local_1);
        }

        public function set inboxDG(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._1941741961inboxDG;
            if (_local_2 !== _arg_1)
            {
                this._1941741961inboxDG = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inboxDG", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MilitarySituationList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MilitarySituationList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationListWatcherSetupUtil");
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

        public function ___MilitarySituationList_Button2_click(_arg_1:MouseEvent):void
        {
            showPage(1);
        }

        private function set curRepoet(_arg_1:MilitarySituation):void
        {
            var _local_2:Object = this._258469375curRepoet;
            if (_local_2 !== _arg_1)
            {
                this._258469375curRepoet = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curRepoet", _local_2, _arg_1));
            };
        }

        private function _MilitarySituationList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.viewstackSelectIndex);
            }, function (_arg_1:int):void
            {
                _MilitarySituationList_ViewStack1.selectedIndex = _arg_1;
            }, "_MilitarySituationList_ViewStack1.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (warDataP);
            }, function (_arg_1:Object):void
            {
                inboxDG.dataProvider = _arg_1;
            }, "inboxDG.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("类型");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_DataGridColumn1.headerText = _arg_1;
            }, "_MilitarySituationList_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("事件");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_DataGridColumn2.headerText = _arg_1;
            }, "_MilitarySituationList_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("对方联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_DataGridColumn3.headerText = _arg_1;
            }, "_MilitarySituationList_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_DataGridColumn4.headerText = _arg_1;
            }, "_MilitarySituationList_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_DataGridColumn5.headerText = _arg_1;
            }, "_MilitarySituationList_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPage + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_Label1.text = _arg_1;
            }, "_MilitarySituationList_Label1.text");
            result[7] = binding;
            binding = new Binding(this, function ():MilitarySituation
            {
                return (this.curRepoet);
            }, function (_arg_1:MilitarySituation):void
            {
                reportDetailWin.militaryS = _arg_1;
            }, "reportDetailWin.militaryS");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_Button3.label = _arg_1;
            }, "_MilitarySituationList_Button3.label");
            result[9] = binding;
            return (result);
        }

        private function init():void
        {
            this.refresh();
        }

        private function showPage(_arg_1:int):void
        {
            var _local_2:int = curPage;
            this.curPage = (this.curPage + _arg_1);
            if (((this.curPage >= 1) && (this.curPage <= this.totalPage)))
            {
                this.refresh();
            }
            else
            {
                this.curPage = _local_2;
            };
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function setType(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            var _local_3:* = "";
            if (_arg_1.attack != null)
            {
                switch ((_arg_1.attack as Boolean))
                {
                    case true:
                        _local_3 = Lang.msg("攻击");
                        break;
                    case false:
                        _local_3 = Lang.msg("防御");
                        break;
                };
                if (((!(_arg_1.eventName.indexOf("colonization") == -1)) || (!(_arg_1.eventName.indexOf("Suppression") == -1))))
                {
                    _local_3 = Lang.msg("殖民");
                };
                return (_local_3);
            };
            return (" ");
        }

        [Bindable(event="propertyChange")]
        private function get viewstackSelectIndex():int
        {
            return (this._1343253965viewstackSelectIndex);
        }

        private function _MilitarySituationList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MilitarySituationList_DataGridColumn2 = _local_1;
            _local_1.dataField = "eventName";
            _local_1.width = 200;
            BindingManager.executeBindings(this, "_MilitarySituationList_DataGridColumn2", _MilitarySituationList_DataGridColumn2);
            return (_local_1);
        }

        private function _MilitarySituationList_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MilitarySituationList_DataGridColumn4 = _local_1;
            _local_1.dataField = "time";
            _local_1.width = 130;
            BindingManager.executeBindings(this, "_MilitarySituationList_DataGridColumn4", _MilitarySituationList_DataGridColumn4);
            return (_local_1);
        }

        private function set warDataP(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._459070430warDataP;
            if (_local_2 !== _arg_1)
            {
                this._459070430warDataP = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "warDataP", _local_2, _arg_1));
            };
        }

        private function _MilitarySituationList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MilitarySituationList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___MilitarySituationList_Button1_click(_arg_1:MouseEvent):void
        {
            showPage(-1);
        }

        public function refresh():void
        {
            this.viewstackSelectIndex = 0;
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_GET_MILITARY_SITUATION_LIST, onGetMilitarySituationList, false, 0, true);
            ActionFactory.getInstance().getAllianceCommands().getMilitarySituationList(this.curPage, 10);
        }

        public function showWarDetail(_arg_1:Object):void
        {
            this.viewstackSelectIndex = 1;
            this.curRepoet = (_arg_1 as MilitarySituation);
        }

        [Bindable(event="propertyChange")]
        private function get warDataP():ArrayCollection
        {
            return (this._459070430warDataP);
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

        private function set viewstackSelectIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1343253965viewstackSelectIndex;
            if (_local_2 !== _arg_1)
            {
                this._1343253965viewstackSelectIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstackSelectIndex", _local_2, _arg_1));
            };
        }

        private function _MilitarySituationList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.viewstackSelectIndex;
            _local_1 = warDataP;
            _local_1 = Lang.msg("类型");
            _local_1 = Lang.msg("事件");
            _local_1 = Lang.msg("对方联盟");
            _local_1 = Lang.msg("时间");
            _local_1 = Lang.msg("查看");
            _local_1 = ((this.curPage + "/") + this.totalPage);
            _local_1 = this.curRepoet;
            _local_1 = Lang.msg("返回");
        }

        public function ___MilitarySituationList_Button3_click(_arg_1:MouseEvent):void
        {
            this.viewstackSelectIndex = 0;
        }

        public function ___MilitarySituationList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
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

        public function set lookUpStr(_arg_1:String):void
        {
            var _local_2:Object = this._1120764471lookUpStr;
            if (_local_2 !== _arg_1)
            {
                this._1120764471lookUpStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lookUpStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get reportDetailWin():PublicReportDetail
        {
            return (this._796560649reportDetailWin);
        }

        private function onGetMilitarySituationList(_arg_1:MilitarySituationListResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.totalPage = _arg_1.totalPage;
                warDataP = _arg_1.situationsArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function destroy():void
        {
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


    }
}//package view.module.alliance.oldAlliance.militarySituationList

