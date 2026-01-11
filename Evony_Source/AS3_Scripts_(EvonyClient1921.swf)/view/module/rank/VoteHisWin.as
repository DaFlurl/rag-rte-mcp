// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.VoteHisWin

package view.module.rank
{
    import view.ui.BaseFunctionWindowEx;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import mx.containers.HBox;
    import mx.controls.ToggleButtonBar;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.containers.ViewStack;
    import view.module.office.CheckOutButton;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.controls.Spacer;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.MouseEvent;
    import mx.events.ItemClickEvent;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import com.evony.util.InputTextControl;
    import flash.events.Event;
    import mx.controls.ComboBox;
    import mx.core.ClassFactory;
    import view.AllWindows;
    import view.ui.AlertWin;
    import com.evony.Context;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.UIUtil;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.rank.TopVotesPlayersResponse;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import com.evony.common.beans.RankAllianceBean;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
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

    public class VoteHisWin extends BaseFunctionWindowEx implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "VoteHisWin.open";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _VoteHisWin_DataGrid1:DataGrid;
        private var _962565910allianceRankArray:ArrayCollection;
        public var _VoteHisWin_HBox3:HBox;
        private var _11548545buttonBar:ToggleButtonBar;
        private var votestoal:int = 0;
        private var pageSize:int = 10;
        public var _VoteHisWin_DataGridColumn2:DataGridColumn;
        public var _VoteHisWin_DataGridColumn3:DataGridColumn;
        public var _VoteHisWin_DataGridColumn4:DataGridColumn;
        public var _VoteHisWin_DataGridColumn5:DataGridColumn;
        public var _VoteHisWin_DataGridColumn6:DataGridColumn;
        public var _VoteHisWin_DataGridColumn7:DataGridColumn;
        public var _VoteHisWin_DataGridColumn8:DataGridColumn;
        private var _2000581493castleRankArray:ArrayCollection;
        private var _1923490732playerRankArray:ArrayCollection;
        private var _946505330viewstack1:ViewStack;
        private var _762218477nameSearch:CheckOutButton;
        public var _VoteHisWin_Label1:Label;
        public var _VoteHisWin_Label2:Label;
        private var searchStr:String = "";
        private var _1607799334toLeftBtn:Button;
        private var _287147332normalColor:int = 0;
        private var _1554685304isExactMatchTpye:String = "";
        private var _1067568789focusColor:int = 17129;
        private var _1456175557toRightBtn:Button;
        private var _1436069623selectedIndex:int = 0;
        private var _30367024isExactMatch:Boolean = false;
        private var _2005637811heroRankArray:ArrayCollection;
        private var _202468994textInputKey:TextInput;
        private var _1115303139mySearchStr:String = "";
        private var _995752784pageNo:int = 1;
        private var _577409037totalPage:int = 0;
        private var _1443166814dataAry:ArrayCollection;
        private var typeId:int = 0;
        private var voteendtime:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindowEx,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"View 1",
                                "width":790,
                                "percentHeight":100,
                                "y":39,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 1;
                                        this.horizontalAlign = "left";
                                        this.verticalAlign = "bottom";
                                        this.left = "5";
                                        this.top = "25";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":ToggleButtonBar,
                                                "id":"buttonBar",
                                                "events":{"itemClick":"__buttonBar_itemClick"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "25";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":29,
                                                        "width":200,
                                                        "dataProvider":["player", "history"]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":ViewStack,
                                    "id":"viewstack1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "95";
                                        this.top = "55";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"playerVs",
                                                        "percentWidth":100,
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":DataGrid,
                                                            "id":"_VoteHisWin_DataGrid1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.borderStyle = "solid";
                                                                this.borderThickness = 1;
                                                                this.left = "0";
                                                                this.top = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "rowHeight":34,
                                                                    "styleName":"style2",
                                                                    "rowCount":10,
                                                                    "verticalScrollPolicy":"off",
                                                                    "percentHeight":100,
                                                                    "resizableColumns":false,
                                                                    "draggableColumns":false,
                                                                    "sortableColumns":false,
                                                                    "selectable":false,
                                                                    "columns":[_VoteHisWin_DataGridColumn1_c(), _VoteHisWin_DataGridColumn2_i(), _VoteHisWin_DataGridColumn3_i(), _VoteHisWin_DataGridColumn4_i(), _VoteHisWin_DataGridColumn5_i(), _VoteHisWin_DataGridColumn6_i(), _VoteHisWin_DataGridColumn7_i(), _VoteHisWin_DataGridColumn8_i(), _VoteHisWin_DataGridColumn9_c()]
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "39";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":32,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "center";
                                                    this.verticalCenter = "0";
                                                    this.left = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentHeight":100,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_VoteHisWin_Label1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"styleName":"contentheader1"});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":10});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"textInputKey",
                                                            "events":{"change":"__textInputKey_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":100,
                                                                    "styleName":"textInput"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Spacer,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":10});
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":CheckOutButton,
                                                            "id":"nameSearch",
                                                            "events":{"click":"__nameSearch_click"}
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "id":"_VoteHisWin_HBox3",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "20";
                                        this.right = "5";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"toLeftBtn",
                                                "events":{"click":"__toLeftBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"previous"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_VoteHisWin_Label2",
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
                                                "id":"toRightBtn",
                                                "events":{"click":"__toRightBtn_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"next"});
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        private var _1120764471lookUpStr:String = Lang.msg("查看");
        private var playerPropAry:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("爵位"),
            "data":"1"
        }, {
            "label":Lang.msg("声望"),
            "data":"2"
        }, {
            "label":Lang.msg("荣誉"),
            "data":"3"
        }, {
            "label":Lang.msg("城池数"),
            "data":"4"
        }, {
            "label":Lang.msg("人口"),
            "data":"5"
        }]);
        private var alliancePropAry:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("人数"),
            "data":"1"
        }, {
            "label":Lang.msg("声望"),
            "data":"2"
        }, {
            "label":Lang.msg("荣誉"),
            "data":"3"
        }]);
        private var heroPropAry:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("等级"),
            "data":"1"
        }, {
            "label":Lang.msg("内政"),
            "data":"2"
        }, {
            "label":Lang.msg("勇武"),
            "data":"3"
        }, {
            "label":Lang.msg("智谋"),
            "data":"4"
        }]);
        private var castlePropAry:ArrayCollection = new ArrayCollection([{
            "label":Lang.msg("人口"),
            "data":"1"
        }, {
            "label":Lang.msg("等级"),
            "data":"2"
        }]);
        private var playerInfo:PlayerInfo = new PlayerInfo();
        private var allianceInfo:AllianceInfo = new AllianceInfo();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function VoteHisWin()
        {
            mx_internal::_document = this;
            this.title = "Previous Polls";
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___VoteHisWin_BaseFunctionWindowEx1_creationComplete);
            this.addEventListener("removedFromStage", ___VoteHisWin_BaseFunctionWindowEx1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            VoteHisWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get focusColor():int
        {
            return (this._1067568789focusColor);
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

        [Bindable(event="propertyChange")]
        private function get selectedIndex():int
        {
            return (this._1436069623selectedIndex);
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

        private function _VoteHisWin_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn3 = _local_1;
            _local_1.dataField = "alliance";
            _local_1.width = 90;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory3_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn3", _VoteHisWin_DataGridColumn3);
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.RANK_GET_TOP_VOTES_PLAYER, onGetPlayerRankResponse);
        }

        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(-1);
        }

        [Bindable(event="propertyChange")]
        public function get nameSearch():CheckOutButton
        {
            return (this._762218477nameSearch);
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        public function __buttonBar_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get allianceRankArray():ArrayCollection
        {
            return (this._962565910allianceRankArray);
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function showcj():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            cj.show();
        }

        private function _VoteHisWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.selectedIndex;
            _local_1 = this.playerRankArray;
            _local_1 = Lang.msg("君主");
            _local_1 = Lang.msg("联盟");
            _local_1 = Lang.msg("爵位");
            _local_1 = Lang.msg("荣誉");
            _local_1 = Lang.msg("声望");
            _local_1 = Lang.msg("城池数");
            _local_1 = Lang.msg("人口");
            _local_1 = Lang.msg("查询");
            _local_1 = Lang.msg("查询名称");
            _local_1 = (!(totalPage == 0));
            _local_1 = ((this.pageNo + "/") + this.totalPage);
        }

        public function __textInputKey_change(_arg_1:Event):void
        {
            InputTextControl.textChange(_arg_1);
        }

        private function _VoteHisWin_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn6 = _local_1;
            _local_1.dataField = "prestige";
            _local_1.width = 100;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory6_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn6", _VoteHisWin_DataGridColumn6);
            return (_local_1);
        }

        private function _VoteHisWin_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn2 = _local_1;
            _local_1.dataField = "userName";
            _local_1.width = 100;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory2_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn2", _VoteHisWin_DataGridColumn2);
            return (_local_1);
        }

        public function set nameSearch(_arg_1:CheckOutButton):void
        {
            var _local_2:Object = this._762218477nameSearch;
            if (_local_2 !== _arg_1)
            {
                this._762218477nameSearch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nameSearch", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get lookUpStr():String
        {
            return (this._1120764471lookUpStr);
        }

        private function closeHandler(_arg_1:Event):void
        {
            typeId = ComboBox(_arg_1.target).selectedItem.data;
            pageNo = 1;
            searchStr = "";
            readFromServer(null, -1, typeId);
        }

        private function _VoteHisWin_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function __nameSearch_click(_arg_1:MouseEvent):void
        {
            onRankBtnClick(_arg_1);
        }

        public function set textInputKey(_arg_1:TextInput):void
        {
            var _local_2:Object = this._202468994textInputKey;
            if (_local_2 !== _arg_1)
            {
                this._202468994textInputKey = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textInputKey", _local_2, _arg_1));
            };
        }

        private function showPlayer():void
        {
            AllWindows.switchToFuncWindow(VotePreWin.EVENT_SHOW);
        }

        [Bindable(event="propertyChange")]
        private function get mySearchStr():String
        {
            return (this._1115303139mySearchStr);
        }

        private function set mySearchStr(_arg_1:String):void
        {
            var _local_2:Object = this._1115303139mySearchStr;
            if (_local_2 !== _arg_1)
            {
                this._1115303139mySearchStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mySearchStr", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_ClassFactory8_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent8;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set allianceRankArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._962565910allianceRankArray;
            if (_local_2 !== _arg_1)
            {
                this._962565910allianceRankArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceRankArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
        }

        private function onRankBtnClick(_arg_1:MouseEvent):void
        {
            this.isExactMatch = true;
            if (this.textInputKey.text == "")
            {
                AlertWin.show(Lang.msg("查询名称不能为空！"));
            }
            else
            {
                if (this.textInputKey.text.length > 30)
                {
                    AlertWin.show(Lang.msg("该玩家名称无效!"));
                }
                else
                {
                    this.isExactMatchTpye = "name";
                    readFromServer(this.textInputKey.text, -1, typeId);
                };
            };
        }

        private function searchOwer():void
        {
            this.isExactMatch = true;
            this.isExactMatchTpye = "mySearch";
            this.pageNo = 1;
            var _local_1:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            if (this.selectedIndex == 0)
            {
                this.mySearchStr = _local_1.userName;
                ActionFactory.getInstance().getRankCommands().getPlayerRank(_local_1.userName, this.pageNo, pageSize, this.typeId);
            }
            else
            {
                if (this.selectedIndex == 1)
                {
                    if (_local_1.alliance != null)
                    {
                        this.mySearchStr = _local_1.alliance;
                        ActionFactory.getInstance().getRankCommands().getAllianceRank(_local_1.alliance, this.pageNo, pageSize, this.typeId);
                    }
                    else
                    {
                        AlertWin.show(Lang.msg("你还没有加入联盟"));
                    };
                };
            };
        }

        private function set playerRankArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1923490732playerRankArray;
            if (_local_2 !== _arg_1)
            {
                this._1923490732playerRankArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerRankArray", _local_2, _arg_1));
            };
        }

        private function FormatData(_arg_1:int):String
        {
            return (UIUtil.FormatInt(_arg_1));
        }

        private function _VoteHisWin_DataGridColumn1_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Term";
            _local_1.dataField = "term";
            _local_1.width = 100;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory1_c();
            return (_local_1);
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(1);
        }

        private function set heroRankArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2005637811heroRankArray;
            if (_local_2 !== _arg_1)
            {
                this._2005637811heroRankArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroRankArray", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_DataGridColumn9_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "Votes";
            _local_1.dataField = "topvotes";
            _local_1.width = 70;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory9_c();
            return (_local_1);
        }

        private function onGetPlayerRankResponse(_arg_1:TopVotesPlayersResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.playerRankArray = _arg_1.beansArray;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _VoteHisWin_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn5 = _local_1;
            _local_1.dataField = "honor";
            _local_1.width = 100;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory5_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn5", _VoteHisWin_DataGridColumn5);
            return (_local_1);
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

        public function showHallofFame():void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(WindowChangeEvent.ID_CLOSE));
            PrestigeRank.show();
        }

        [Bindable(event="propertyChange")]
        private function get castleRankArray():ArrayCollection
        {
            return (this._2000581493castleRankArray);
        }

        public function set toRightBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1456175557toRightBtn;
            if (_local_2 !== _arg_1)
            {
                this._1456175557toRightBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toRightBtn", _local_2, _arg_1));
            };
        }

        public function seeAllianceInfo(_arg_1:RankAllianceBean):void
        {
            if (!allianceInfo.isPopUp)
            {
                PopUpManager.addPopUp(allianceInfo, MainFrame.instance, true);
            };
            allianceInfo.setAllianceName(_arg_1.name);
            allianceInfo.setcurRank(_arg_1.rank);
        }

        private function _VoteHisWin_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___VoteHisWin_BaseFunctionWindowEx1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function _VoteHisWin_ClassFactory7_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent7;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get isExactMatchTpye():String
        {
            return (this._1554685304isExactMatchTpye);
        }

        [Bindable(event="propertyChange")]
        public function get buttonBar():ToggleButtonBar
        {
            return (this._11548545buttonBar);
        }

        private function _VoteHisWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():int
            {
                return (this.selectedIndex);
            }, function (_arg_1:int):void
            {
                viewstack1.selectedIndex = _arg_1;
            }, "viewstack1.selectedIndex");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.playerRankArray);
            }, function (_arg_1:Object):void
            {
                _VoteHisWin_DataGrid1.dataProvider = _arg_1;
            }, "_VoteHisWin_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("君主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn2.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn2.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn3.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn3.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("爵位");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn4.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn4.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("荣誉");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn5.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn5.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("声望");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn6.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn6.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("城池数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn7.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn7.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("人口");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_DataGridColumn8.headerText = _arg_1;
            }, "_VoteHisWin_DataGridColumn8.headerText");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查询");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_Label1.text = _arg_1;
            }, "_VoteHisWin_Label1.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("查询名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                nameSearch.label = _arg_1;
            }, "nameSearch.label");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(totalPage == 0));
            }, function (_arg_1:Boolean):void
            {
                _VoteHisWin_HBox3.visible = _arg_1;
            }, "_VoteHisWin_HBox3.visible");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.pageNo + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _VoteHisWin_Label2.text = _arg_1;
            }, "_VoteHisWin_Label2.text");
            result[12] = binding;
            return (result);
        }

        private function changePageNo(_arg_1:int):void
        {
            var _local_2:int = (this.pageNo + _arg_1);
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.pageNo = _local_2;
                if (searchStr == "")
                {
                    readFromServer();
                }
                else
                {
                    if (searchStr != "")
                    {
                        readFromServer(searchStr, _local_2, typeId);
                    };
                };
            };
        }

        override public function initialize():void
        {
            var target:VoteHisWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _VoteHisWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_rank_VoteHisWinWatcherSetupUtil");
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

        private function setStyleDgItem(_arg_1:DataGrid):void
        {
        }

        [Bindable(event="propertyChange")]
        public function get textInputKey():TextInput
        {
            return (this._202468994textInputKey);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        public function myStyleName(_arg_1:Boolean, _arg_2:String, _arg_3:int):Boolean
        {
            var _local_4:Boolean;
            if (_arg_1)
            {
                if (((this.isExactMatchTpye == "name") && (_arg_2 == this.textInputKey.text)))
                {
                    _local_4 = true;
                };
                if (((this.isExactMatchTpye == "mySearch") && (_arg_2 == this.mySearchStr)))
                {
                    _local_4 = true;
                };
            };
            return (_local_4);
        }

        public function set isExactMatch(_arg_1:Boolean):void
        {
            var _local_2:Object = this._30367024isExactMatch;
            if (_local_2 !== _arg_1)
            {
                this._30367024isExactMatch = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isExactMatch", _local_2, _arg_1));
            };
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            if (_arg_1.index == 0)
            {
                showPlayer();
            }
            else
            {
                if (_arg_1.index == 1)
                {
                    showHistory();
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataAry():ArrayCollection
        {
            return (this._1443166814dataAry);
        }

        private function set pageNo(_arg_1:int):void
        {
            var _local_2:Object = this._995752784pageNo;
            if (_local_2 !== _arg_1)
            {
                this._995752784pageNo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pageNo", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn4 = _local_1;
            _local_1.dataField = "titleId";
            _local_1.width = 80;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory4_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn4", _VoteHisWin_DataGridColumn4);
            return (_local_1);
        }

        public function set normalColor(_arg_1:int):void
        {
            var _local_2:Object = this._287147332normalColor;
            if (_local_2 !== _arg_1)
            {
                this._287147332normalColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "normalColor", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerRankArray():ArrayCollection
        {
            return (this._1923490732playerRankArray);
        }

        public function set toLeftBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1607799334toLeftBtn;
            if (_local_2 !== _arg_1)
            {
                this._1607799334toLeftBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "toLeftBtn", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_DataGridColumn8_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn8 = _local_1;
            _local_1.dataField = "population";
            _local_1.width = 100;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory8_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn8", _VoteHisWin_DataGridColumn8);
            return (_local_1);
        }

        private function _VoteHisWin_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get heroRankArray():ArrayCollection
        {
            return (this._2005637811heroRankArray);
        }

        private function _VoteHisWin_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___VoteHisWin_BaseFunctionWindowEx1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        private function readFromServer(_arg_1:String=null, _arg_2:int=-1, _arg_3:int=0):void
        {
            if (_arg_1 != null)
            {
                this.searchStr = _arg_1;
            }
            else
            {
                if (_arg_2 > 0)
                {
                    this.pageNo = int(Math.ceil((_arg_2 / 10)));
                }
                else
                {
                    if (_arg_2 == 0)
                    {
                        AlertWin.show(Lang.msg("查询名次至少从1开始！"));
                    };
                };
            };
            switch (this.selectedIndex)
            {
                case 0:
                    ActionFactory.getInstance().getRankCommands().getTopVotesPlayer();
                    return;
            };
        }

        private function set dataAry(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443166814dataAry;
            if (_local_2 !== _arg_1)
            {
                this._1443166814dataAry = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataAry", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get isExactMatch():Boolean
        {
            return (this._30367024isExactMatch);
        }

        public function set focusColor(_arg_1:int):void
        {
            var _local_2:Object = this._1067568789focusColor;
            if (_local_2 !== _arg_1)
            {
                this._1067568789focusColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "focusColor", _local_2, _arg_1));
            };
        }

        private function showHistory():void
        {
            AllWindows.switchToFuncWindow(VoteHisWin.EVENT_SHOW);
        }

        override public function refresh():void
        {
            trace((this.className + " refresh()"));
            this.searchStr = "";
            this.addObjAry();
            this.readFromServer();
            this.isExactMatch = false;
            this.isExactMatchTpye = "";
        }

        [Bindable(event="propertyChange")]
        public function get normalColor():int
        {
            return (this._287147332normalColor);
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        private function set selectedIndex(_arg_1:int):void
        {
            var _local_2:Object = this._1436069623selectedIndex;
            if (_local_2 !== _arg_1)
            {
                this._1436069623selectedIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "selectedIndex", _local_2, _arg_1));
            };
        }

        private function _VoteHisWin_DataGridColumn7_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _VoteHisWin_DataGridColumn7 = _local_1;
            _local_1.dataField = "castleCount";
            _local_1.width = 60;
            _local_1.itemRenderer = _VoteHisWin_ClassFactory7_c();
            BindingManager.executeBindings(this, "_VoteHisWin_DataGridColumn7", _VoteHisWin_DataGridColumn7);
            return (_local_1);
        }

        public function set isExactMatchTpye(_arg_1:String):void
        {
            var _local_2:Object = this._1554685304isExactMatchTpye;
            if (_local_2 !== _arg_1)
            {
                this._1554685304isExactMatchTpye = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isExactMatchTpye", _local_2, _arg_1));
            };
        }

        private function addObjAry():void
        {
            switch (this.selectedIndex)
            {
                case 0:
                    dataAry = playerPropAry;
                    return;
                case 1:
                    dataAry = alliancePropAry;
                    return;
                case 2:
                    dataAry = heroPropAry;
                    return;
                case 3:
                    dataAry = castlePropAry;
                    return;
            };
        }

        private function _VoteHisWin_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function set castleRankArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2000581493castleRankArray;
            if (_local_2 !== _arg_1)
            {
                this._2000581493castleRankArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleRankArray", _local_2, _arg_1));
            };
        }

        override public function destroy():void
        {
            if (playerInfo)
            {
                PopUpManager.removePopUp(playerInfo);
            }
            else
            {
                if (allianceInfo)
                {
                    PopUpManager.removePopUp(allianceInfo);
                };
            };
        }

        private function _VoteHisWin_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _VoteHisWin_ClassFactory9_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = VoteHisWin_inlineComponent9;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }


    }
}//package view.module.rank

