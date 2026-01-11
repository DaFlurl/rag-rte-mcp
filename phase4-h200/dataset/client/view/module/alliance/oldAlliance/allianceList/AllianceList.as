// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceList.AllianceList

package view.module.alliance.oldAlliance.allianceList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.AllianceQueryBean;
    import mx.controls.DataGrid;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import mx.managers.PopUpManager;
    import com.evony.client.action.ActionFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.util.UIUtil;
    import mx.core.ClassFactory;
    import mx.events.FlexEvent;
    import view.ui.AlertWin;
    import com.evony.common.beans.RankAllianceBean;
    import flash.utils.getDefinitionByName;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.rank.RankAllianceResponse;
    import com.evony.Context;
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

    public class AllianceList extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceList_Label2:Label;
        public var _AllianceList_Label1:Label;
        private var _1032494288officalLevel:int = 0;
        private var _1616225942orderSearch:Button;
        private var pageSize:int = 10;
        private var _1488198711orderNumber:TextInput;
        private var _391766279orderName:TextInput;
        public var _AllianceList_Button5:Button;
        private var _762218477nameSearch:Button;
        public var _AllianceList_DataGridColumn1:DataGridColumn;
        public var _AllianceList_DataGridColumn2:DataGridColumn;
        public var _AllianceList_DataGridColumn3:DataGridColumn;
        public var _AllianceList_DataGridColumn4:DataGridColumn;
        public var _AllianceList_DataGridColumn5:DataGridColumn;
        public var _AllianceList_DataGridColumn6:DataGridColumn;
        public var _AllianceList_DataGridColumn7:DataGridColumn;
        private var rankType:int = 2;
        private var _1605786759allianceBean:AllianceQueryBean;
        private var _577409037totalPage:int = 0;
        private var _1320771561curPageNum:int = 1;
        public var _AllianceList_DataGrid1:DataGrid;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_AllianceList_DataGrid1",
                        "stylesFactory":function ():void
                        {
                            this.borderStyle = "solid";
                            this.left = "1";
                            this.right = "1";
                            this.top = "30";
                            this.bottom = "85";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "selectable":false,
                                "columns":[_AllianceList_DataGridColumn1_i(), _AllianceList_DataGridColumn2_i(), _AllianceList_DataGridColumn3_i(), _AllianceList_DataGridColumn4_i(), _AllianceList_DataGridColumn5_i(), _AllianceList_DataGridColumn6_i(), _AllianceList_DataGridColumn7_i()]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "25";
                            this.right = "5";
                            this.verticalAlign = "middle";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceList_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"previous"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_AllianceList_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"ftp14f"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___AllianceList_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"next"});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "1";
                            this.bottom = "25";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.verticalAlign = "middle";
                                        this.horizontalAlign = "left";
                                        this.right = "5";
                                        this.top = "5";
                                        this.bottom = "5";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_AllianceList_Label2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"PropertyName1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"orderNumber",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":80,
                                                        "styleName":"textInput",
                                                        "restrict":"0-9",
                                                        "maxChars":7
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"orderSearch",
                                                "events":{"click":"__orderSearch_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"orderName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "styleName":"textInput"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"nameSearch",
                                                "events":{"click":"__nameSearch_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b40"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceList_Button5",
                                                "events":{"click":"___AllianceList_Button5_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]});
                                    }
                                })]});
                        }
                    })]});
            }
        });
        private var _1760738206allianceArray:ArrayCollection = new ArrayCollection();
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceList()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___AllianceList_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceList._watcherSetupUtil = _arg_1;
        }


        public function ___AllianceList_Button5_click(_arg_1:MouseEvent):void
        {
            searchMineOrder();
        }

        private function _AllianceList_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (allianceArray);
            }, function (_arg_1:Object):void
            {
                _AllianceList_DataGrid1.dataProvider = _arg_1;
            }, "_AllianceList_DataGrid1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn1.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn1.headerText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn2.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟盟主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn3.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创始人");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn4.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn5.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn6.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查看");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_DataGridColumn7.headerText = _arg_1;
            }, "_AllianceList_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.curPageNum + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_Label1.text = _arg_1;
            }, "_AllianceList_Label1.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查询");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_Label2.text = _arg_1;
            }, "_AllianceList_Label2.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查询排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                orderSearch.label = _arg_1;
            }, "orderSearch.label");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查询名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                nameSearch.label = _arg_1;
            }, "nameSearch.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("本盟排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceList_Button5.label = _arg_1;
            }, "_AllianceList_Button5.label");
            result[12] = binding;
            return (result);
        }

        private function set allianceBean(_arg_1:AllianceQueryBean):void
        {
            var _local_2:Object = this._1605786759allianceBean;
            if (_local_2 !== _arg_1)
            {
                this._1605786759allianceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get curPageNum():int
        {
            return (this._1320771561curPageNum);
        }

        private function _AllianceList_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn3 = _local_1;
            _local_1.dataField = "playerName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn3", _AllianceList_DataGridColumn3);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get nameSearch():Button
        {
            return (this._762218477nameSearch);
        }

        public function destroy():void
        {
            if (AllianceInfo.instance)
            {
                PopUpManager.removePopUp(AllianceInfo.instance);
            };
        }

        private function searchOrderByNumber():void
        {
            var _local_1:int;
            if (orderNumber.text != "")
            {
                _local_1 = 0;
                if (orderNumber.length > 7)
                {
                    _local_1 = totalPage;
                }
                else
                {
                    _local_1 = int(Math.ceil((int(this.orderNumber.text) / pageSize)));
                };
                if (_local_1 >= totalPage)
                {
                    _local_1 = totalPage;
                };
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, _local_1, pageSize, rankType);
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.RANK_GET_ALLIANCE_RANK, onGetAllianceRank);
            if (this.initialized)
            {
                this.refresh();
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

        public function set curPageNum(_arg_1:int):void
        {
            var _local_2:Object = this._1320771561curPageNum;
            if (_local_2 !== _arg_1)
            {
                this._1320771561curPageNum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPageNum", _local_2, _arg_1));
            };
        }

        private function _AllianceList_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn6 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.labelFunction = UIUtil.myLabelFunction;
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn6", _AllianceList_DataGridColumn6);
            return (_local_1);
        }

        private function _AllianceList_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn2 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn2", _AllianceList_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get officalLevel():int
        {
            return (this._1032494288officalLevel);
        }

        private function _AllianceList_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = AllianceList_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function __nameSearch_click(_arg_1:MouseEvent):void
        {
            onRankBtnClick(_arg_1);
        }

        public function ___AllianceList_Button2_click(_arg_1:MouseEvent):void
        {
            turnPage("next");
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

        [Bindable(event="propertyChange")]
        public function get orderNumber():TextInput
        {
            return (this._1488198711orderNumber);
        }

        public function ___AllianceList_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function onRankBtnClick(_arg_1:MouseEvent):void
        {
            if (_arg_1.currentTarget == this.orderSearch)
            {
                if (((this.orderNumber.text == "") || (int(this.orderNumber.text) == 0)))
                {
                    AlertWin.show(Lang.msg("查询名次至少从1开始！"));
                }
                else
                {
                    searchOrderByNumber();
                };
            }
            else
            {
                if (_arg_1.currentTarget == this.nameSearch)
                {
                    if (this.orderName.text == "")
                    {
                        AlertWin.show(Lang.msg("查询名称不能为空！"));
                    }
                    else
                    {
                        searchOrderByName();
                    };
                };
            };
        }

        private function set officalLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1032494288officalLevel;
            if (_local_2 !== _arg_1)
            {
                this._1032494288officalLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officalLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get allianceArray():ArrayCollection
        {
            return (this._1760738206allianceArray);
        }

        private function _AllianceList_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn1 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn1", _AllianceList_DataGridColumn1);
            return (_local_1);
        }

        private function _AllianceList_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn5 = _local_1;
            _local_1.dataField = "member";
            _local_1.width = 80;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn5", _AllianceList_DataGridColumn5);
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
        private function get allianceBean():AllianceQueryBean
        {
            return (this._1605786759allianceBean);
        }

        private function _AllianceList_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = allianceArray;
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("名称");
            _local_1 = Lang.msg("联盟盟主");
            _local_1 = Lang.msg("创始人");
            _local_1 = Lang.msg("人数");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("查看");
            _local_1 = ((this.curPageNum + "/") + this.totalPage);
            _local_1 = Lang.msg("查询");
            _local_1 = Lang.msg("查询排名");
            _local_1 = Lang.msg("查询名称");
            _local_1 = Lang.msg("本盟排名");
        }

        public function showMembersMsg(_arg_1:Object):void
        {
            AllianceInfo.show(RankAllianceBean(_arg_1));
        }

        override public function initialize():void
        {
            var target:AllianceList;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceList_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceList_AllianceListWatcherSetupUtil");
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

        private function onGetAllianceRank(_arg_1:RankAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                allianceArray = _arg_1.beansArray;
                totalPage = _arg_1.totalPage;
                curPageNum = int(_arg_1.pageNo);
            };
        }

        [Bindable(event="propertyChange")]
        public function get orderSearch():Button
        {
            return (this._1616225942orderSearch);
        }

        private function searchOrderByName():void
        {
            if (orderName.text != "")
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(this.orderName.text, 1, 10, rankType);
            };
        }

        private function turnPage(_arg_1:String):void
        {
            if (((_arg_1 == "pre") && (curPageNum > 1)))
            {
                ActionFactory.getInstance().getRankCommands().getAllianceRank(null, int(--curPageNum), pageSize, rankType);
            }
            else
            {
                if (((_arg_1 == "next") && (curPageNum < totalPage)))
                {
                    ActionFactory.getInstance().getRankCommands().getAllianceRank(null, int(++curPageNum), pageSize, rankType);
                };
            };
        }

        private function _AllianceList_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn4 = _local_1;
            _local_1.dataField = "createrName";
            _local_1.width = 100;
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn4", _AllianceList_DataGridColumn4);
            return (_local_1);
        }

        public function __orderSearch_click(_arg_1:MouseEvent):void
        {
            onRankBtnClick(_arg_1);
        }

        private function set allianceArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1760738206allianceArray;
            if (_local_2 !== _arg_1)
            {
                this._1760738206allianceArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceArray", _local_2, _arg_1));
            };
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(null, curPageNum, pageSize, rankType);
            officalLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
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

        private function _AllianceList_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _AllianceList_DataGridColumn7 = _local_1;
            _local_1.dataField = "name";
            _local_1.width = 80;
            _local_1.itemRenderer = _AllianceList_ClassFactory1_c();
            BindingManager.executeBindings(this, "_AllianceList_DataGridColumn7", _AllianceList_DataGridColumn7);
            return (_local_1);
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

        private function searchMineOrder():void
        {
            ActionFactory.getInstance().getRankCommands().getAllianceRank(Context.getInstance().getPlayerBean().playerInfo.alliance, 1, 10, rankType);
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

        public function ___AllianceList_Button1_click(_arg_1:MouseEvent):void
        {
            turnPage("pre");
        }


    }
}//package view.module.alliance.oldAlliance.allianceList

