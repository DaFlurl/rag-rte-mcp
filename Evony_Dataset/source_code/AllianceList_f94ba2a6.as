// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.AllianceList

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.DataGrid;
    import mx.controls.Button;
    import mx.core.ClassFactory;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Spacer;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import autoevony.gui.info.FormatPrestige_inlineComponent0;
    import com.evony.client.action.ActionFactory;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import flash.events.Event;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.rank.RankAllianceResponse;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.events.PropertyChangeEvent;
    import autoevony.gui.MainScreen;
    import mx.binding.BindingManager;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.beans.RankAllianceBean;
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

    public class AllianceList extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var rankType:int = 2;
        private var _855813086currentAllianceListPageNo:Label;
        private var _630897339_allianceList_DataGrid:DataGrid;
        private var _1424234899allianceListPageFwdBtn:Button;
        private var _956867668_AllianceList_ClassFactory1:ClassFactory;
        private var _1616225942orderSearch:Button;
        private var pageSize:int = 10;
        private var _956867667_AllianceList_ClassFactory0:ClassFactory;
        private var _1557013386allianceListPageBckBtn:Button;
        private var _577409037totalPage:int = 0;
        private var _1488198711orderNumber:TextInput;
        private var _391766279orderName:TextInput;
        private var _1320771561curPageNum:int = 1;
        private var _762218477nameSearch:Button;

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
                                                "type":TextInput,
                                                "id":"orderNumber",
                                                "events":{"enter":"__orderNumber_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":60,
                                                        "maxChars":6,
                                                        "restrict":"0-9"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"orderSearch",
                                                "events":{"click":"__orderSearch_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Ranking",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"orderName",
                                                "events":{"enter":"__orderName_enter"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":80,
                                                        "maxChars":8
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"nameSearch",
                                                "events":{"click":"__nameSearch_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Name",
                                                        "styleName":"REwinBtn"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"width":5});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Spacer,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"percentWidth":100});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"allianceListPageBckBtn",
                                                "events":{"click":"__allianceListPageBckBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previousBtn"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"currentAllianceListPageNo",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"REmainFormText"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"allianceListPageFwdBtn",
                                                "events":{"click":"__allianceListPageFwdBtn_click"},
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
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalGap = 0;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentHeight":100,
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":DataGrid,
                                                "id":"_allianceList_DataGrid",
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
                                                        "columns":[_AllianceList_DataGridColumn1_c(), _AllianceList_DataGridColumn2_c(), _AllianceList_DataGridColumn3_c(), _AllianceList_DataGridColumn4_c(), _AllianceList_DataGridColumn5_c(), _AllianceList_DataGridColumn6_c(), _AllianceList_DataGridColumn7_c()]
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
        private var _1760738206allianceArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceList()
        {
            mx_internal::_document = this;
            this.label = "Alliance List";
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", this.___AllianceList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceList._watcherSetupUtil = _arg_1;
        }


        private function _AllianceList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPageNum + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                currentAllianceListPageNo.text = _arg_1;
            }, "currentAllianceListPageNo.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.allianceArray);
            }, function (_arg_1:Object):void
            {
                _allianceList_DataGrid.dataProvider = _arg_1;
            }, "_allianceList_DataGrid.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Class
            {
                return (FormatPrestige_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceList_ClassFactory0.generator = _arg_1;
            }, "_AllianceList_ClassFactory0.generator");
            result[2] = binding;
            binding = new Binding(this, function ():Class
            {
                return (ViewBtn_inlineComponent0);
            }, function (_arg_1:Class):void
            {
                _AllianceList_ClassFactory1.generator = _arg_1;
            }, "_AllianceList_ClassFactory1.generator");
            result[3] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get allianceListPageBckBtn():Button
        {
            return (this._1557013386allianceListPageBckBtn);
        }

        private function _AllianceList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((this.curPageNum + "/") + this.totalPage);
            _local_1 = this.allianceArray;
            _local_1 = FormatPrestige_inlineComponent0;
            _local_1 = ViewBtn_inlineComponent0;
        }

        private function populateAllianceList(_arg_1:Object=null):void
        {
            if (((this.allianceArray == null) || (this.allianceArray.length == 0)))
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, this.curPageNum, this.pageSize, this.rankType, this.onGetAllianceRank);
            };
        }

        override public function initialize():void
        {
            var target:AllianceList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AllianceList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceListWatcherSetupUtil");
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

        public function __allianceListPageFwdBtn_click(_arg_1:MouseEvent):void
        {
            this.turnPage("next");
        }

        [Bindable(event="propertyChange")]
        public function get curPageNum():int
        {
            return (this._1320771561curPageNum);
        }

        private function init():void
        {
            this.addEventListener(FlexEvent.SHOW, this.updateData);
            this.addEventListener(Event.RENDER, this.onRender);
        }

        private function onGetAllianceRank(_arg_1:RankAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.allianceArray = _arg_1.beansArray;
                this.totalPage = _arg_1.totalPage;
                this.curPageNum = int(_arg_1.pageNo);
            };
        }

        private function _AllianceList_DataGridColumn2_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Alliance";
            _local_1.dataField = "name";
            _local_1.width = 0.15;
            return (_local_1);
        }

        private function searchOrderByNumber():void
        {
            var _local_1:int;
            if (this.orderNumber.text != "")
            {
                _local_1 = 0;
                if (this.orderNumber.length > 7)
                {
                    _local_1 = this.totalPage;
                }
                else
                {
                    _local_1 = int(Math.ceil((int(this.orderNumber.text) / this.pageSize)));
                };
                if (_local_1 >= this.totalPage)
                {
                    _local_1 = this.totalPage;
                };
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, _local_1, this.pageSize, this.rankType, this.onGetAllianceRank);
            };
        }

        private function _AllianceList_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Founder";
            _local_1.dataField = "createrName";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function searchOrderByName():void
        {
            if (this.orderName.text != "")
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(this.orderName.text, 1, this.pageSize, this.rankType, this.onGetAllianceRank);
            }
            else
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, 1, this.pageSize, this.rankType, this.onGetAllianceRank);
            };
        }

        private function _AllianceList_DataGridColumn6_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Prestige";
            _local_1.dataField = "prestige";
            _local_1.width = 0.2;
            _local_1.itemRenderer = this._AllianceList_ClassFactory1_i();
            return (_local_1);
        }

        private function turnPage(_arg_1:String):void
        {
            if (((_arg_1 == "pre") && (this.curPageNum > 1)))
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, int(--this.curPageNum), this.pageSize, this.rankType, this.onGetAllianceRank);
            }
            else
            {
                if (((_arg_1 == "next") && (this.curPageNum < this.totalPage)))
                {
                    ActionFactory.getInstance().getRankCommands().getAllianceRank(null, int(++this.curPageNum), this.pageSize, this.rankType, this.onGetAllianceRank);
                };
            };
        }

        public function set _AllianceList_ClassFactory0(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._956867667_AllianceList_ClassFactory0;
            if (_local_2 !== _arg_1)
            {
                this._956867667_AllianceList_ClassFactory0 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceList_ClassFactory0", _local_2, _arg_1));
            };
        }

        public function set _AllianceList_ClassFactory1(_arg_1:ClassFactory):void
        {
            var _local_2:Object = this._956867668_AllianceList_ClassFactory1;
            if (_local_2 !== _arg_1)
            {
                this._956867668_AllianceList_ClassFactory1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceList_ClassFactory1", _local_2, _arg_1));
            };
        }

        public function __orderName_enter(_arg_1:FlexEvent):void
        {
            this.onRankBtnClick(_arg_1);
        }

        private function updateData(_arg_1:Object=null):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            this.populateAllianceList();
        }

        [Bindable(event="propertyChange")]
        public function get orderNumber():TextInput
        {
            return (this._1488198711orderNumber);
        }

        private function _AllianceList_ClassFactory2_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceList_ClassFactory1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceList_ClassFactory1", this._AllianceList_ClassFactory1);
            return (_local_1);
        }

        public function __nameSearch_click(_arg_1:MouseEvent):void
        {
            this.onRankBtnClick(_arg_1);
        }

        public function set curPageNum(_arg_1:int):void
        {
            var _local_2:Object = this._1320771561curPageNum;
            if (_local_2 !== _arg_1)
            {
                this._1320771561curPageNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPageNum", _local_2, _arg_1));
            };
        }

        private function _AllianceList_ClassFactory1_i():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            this._AllianceList_ClassFactory0 = _local_1;
            BindingManager.executeBindings(this, "_AllianceList_ClassFactory0", this._AllianceList_ClassFactory0);
            return (_local_1);
        }

        public function __orderSearch_click(_arg_1:MouseEvent):void
        {
            this.onRankBtnClick(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get nameSearch():Button
        {
            return (this._762218477nameSearch);
        }

        [Bindable(event="propertyChange")]
        public function get _allianceList_DataGrid():DataGrid
        {
            return (this._630897339_allianceList_DataGrid);
        }

        public function set currentAllianceListPageNo(_arg_1:Label):void
        {
            var _local_2:Object = this._855813086currentAllianceListPageNo;
            if (_local_2 !== _arg_1)
            {
                this._855813086currentAllianceListPageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentAllianceListPageNo", _local_2, _arg_1));
            };
        }

        public function set nameSearch(_arg_1:Button):void
        {
            var _local_2:Object = this._762218477nameSearch;
            if (_local_2 !== _arg_1)
            {
                this._762218477nameSearch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nameSearch", _local_2, _arg_1));
            };
        }

        public function ___AllianceList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        public function set allianceArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1760738206allianceArray;
            if (_local_2 !== _arg_1)
            {
                this._1760738206allianceArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get orderSearch():Button
        {
            return (this._1616225942orderSearch);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceList_ClassFactory0():ClassFactory
        {
            return (this._956867667_AllianceList_ClassFactory0);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceList_ClassFactory1():ClassFactory
        {
            return (this._956867668_AllianceList_ClassFactory1);
        }

        private function onRankBtnClick(_arg_1:Object):void
        {
            if (((!(_arg_1.currentTarget == this.orderSearch)) && (!(_arg_1.currentTarget == this.orderNumber))))
            {
                if (((_arg_1.currentTarget == this.nameSearch) || (_arg_1.currentTarget == this.orderName)))
                {
                    this.searchOrderByName();
                };
            }
            else
            {
                if (((this.orderNumber.text == "") || (int(this.orderNumber.text) == 0)))
                {
                    return;
                };
                this.searchOrderByNumber();
            };
        }

        [Bindable(event="propertyChange")]
        public function get currentAllianceListPageNo():Label
        {
            return (this._855813086currentAllianceListPageNo);
        }

        public function __allianceListPageBckBtn_click(_arg_1:MouseEvent):void
        {
            this.turnPage("pre");
        }

        public function set allianceListPageFwdBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1424234899allianceListPageFwdBtn;
            if (_local_2 !== _arg_1)
            {
                this._1424234899allianceListPageFwdBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceListPageFwdBtn", _local_2, _arg_1));
            };
        }

        private function onRender(_arg_1:Object):void
        {
            if (MainScreen.getPlayer() == null)
            {
                return;
            };
            this.removeEventListener(Event.RENDER, this.onRender);
            this.updateData();
        }

        public function set orderSearch(_arg_1:Button):void
        {
            var _local_2:Object = this._1616225942orderSearch;
            if (_local_2 !== _arg_1)
            {
                this._1616225942orderSearch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "orderSearch", _local_2, _arg_1));
            };
        }

        private function _AllianceList_DataGridColumn3_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Host";
            _local_1.dataField = "playerName";
            _local_1.width = 0.2;
            return (_local_1);
        }

        private function _AllianceList_DataGridColumn5_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Members";
            _local_1.dataField = "member";
            _local_1.width = 0.1;
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get allianceArray():ArrayCollection
        {
            return (this._1760738206allianceArray);
        }

        private function _AllianceList_DataGridColumn7_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "View";
            _local_1.dataField = "name";
            _local_1.width = 0.12;
            _local_1.itemRenderer = this._AllianceList_ClassFactory2_i();
            return (_local_1);
        }

        private function _AllianceList_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Ranking";
            _local_1.dataField = "rank";
            _local_1.width = 0.1;
            return (_local_1);
        }

        public function set orderNumber(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1488198711orderNumber;
            if (_local_2 !== _arg_1)
            {
                this._1488198711orderNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "orderNumber", _local_2, _arg_1));
            };
        }

        public function __orderNumber_enter(_arg_1:FlexEvent):void
        {
            this.onRankBtnClick(_arg_1);
        }

        public function set orderName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._391766279orderName;
            if (_local_2 !== _arg_1)
            {
                this._391766279orderName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "orderName", _local_2, _arg_1));
            };
        }

        public function set allianceListPageBckBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1557013386allianceListPageBckBtn;
            if (_local_2 !== _arg_1)
            {
                this._1557013386allianceListPageBckBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceListPageBckBtn", _local_2, _arg_1));
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

        [Bindable(event="propertyChange")]
        public function get orderName():TextInput
        {
            return (this._391766279orderName);
        }

        [Bindable(event="propertyChange")]
        public function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        [Bindable(event="propertyChange")]
        public function get allianceListPageFwdBtn():Button
        {
            return (this._1424234899allianceListPageFwdBtn);
        }

        public function set _allianceList_DataGrid(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._630897339_allianceList_DataGrid;
            if (_local_2 !== _arg_1)
            {
                this._630897339_allianceList_DataGrid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_allianceList_DataGrid", _local_2, _arg_1));
            };
        }

        public function showAllianceInfoMsg(_arg_1:Object):void
        {
            var _local_2:popUpWinShowEvent = new popUpWinShowEvent(popUpWinShowEvent.ALLIANCE_INFO_WIN);
            _local_2.objParam = RankAllianceBean(_arg_1).toObject();
            dispatchEvent(_local_2);
        }


    }
}//package autoevony.gui.info.Alliance

