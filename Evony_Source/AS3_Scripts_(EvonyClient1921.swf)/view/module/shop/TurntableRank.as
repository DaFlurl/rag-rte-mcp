// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.TurntableRank

package view.module.shop
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.ToggleButtonBar;
    import mx.controls.Label;
    import mx.controls.dataGridClasses.DataGridColumn;
    import com.evony.common.beans.ItemBean;
    import mx.controls.DataGrid;
    import mx.collections.ArrayCollection;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import com.evony.eum.ItemEumDefine;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.binding.BindingManager;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.gamblingranking.GamblingRankingRewardRespone;
    import mx.events.FlexEvent;
    import mx.core.ClassFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.gamblingranking.GamblingRankingRespone;
    import view.ui.DescribeTooltip;
    import mx.events.ItemClickEvent;
    import mx.core.BitmapAsset;
    import com.evony.eum.ItemEum;
    import flash.events.Event;
    import flash.display.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.text.*;
    import flash.events.*;
    import mx.styles.*;
    import com.evony.common.beans.*;
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

    public class TurntableRank extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "TurntableRank.open";
        public static var instance:TurntableRank = new (TurntableRank)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TurntableRank_Button4:Button;
        private var _1456175557toRightBtn:Button;
        private var _1341206824questTypeTBB:ToggleButtonBar;
        public var _TurntableRank_Label1:Label;
        private var _995752784pageNo:int = 1;
        public var _TurntableRank_DataGridColumn1:DataGridColumn;
        public var _TurntableRank_DataGridColumn3:DataGridColumn;
        public var _TurntableRank_DataGridColumn4:DataGridColumn;
        public var _TurntableRank_DataGridColumn2:DataGridColumn;
        private var pageSize:int = 100;
        private var bean:ItemBean;
        private var _577409037totalPage:int = 0;
        private var _655126789questDg:DataGrid;
        private var _425636739questTypeArray:ArrayCollection;
        public var _TurntableRank_Array2:Array;
        private var _1607799334toLeftBtn:Button;
        private var _776676342curSelectRankIndex:int = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "85";
                            this.bottom = "50";
                            this.right = "34";
                            this.left = "35";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"questDg",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "styleName":"style2",
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "selectable":false,
                                            "sortableColumns":false,
                                            "columns":[_TurntableRank_DataGridColumn1_i(), _TurntableRank_DataGridColumn2_i(), _TurntableRank_DataGridColumn3_i(), _TurntableRank_DataGridColumn4_i()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.right = "30";
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
                                    "id":"_TurntableRank_Label1",
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
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___TurntableRank_Button3_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "19";
                            this.left = "120";
                            this.fontSize = 12;
                            this.paddingBottom = 0;
                            this.paddingTop = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Rewarding Rules",
                                "styleName":"b135",
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_TurntableRank_Button4",
                        "events":{"click":"___TurntableRank_Button4_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "19";
                            this.right = "30";
                            this.fontSize = 12;
                            this.paddingBottom = 0;
                            this.paddingTop = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b95",
                                "width":95,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ToggleButtonBar,
                        "id":"questTypeTBB",
                        "events":{"itemClick":"__questTypeTBB_itemClick"},
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.left = "34";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"questToggleButtonBar",
                                "width":635,
                                "dataProvider":_TurntableRank_Array2_i()
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TurntableRank()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.addEventListener("creationComplete", ___TurntableRank_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___TurntableRank_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TurntableRank._watcherSetupUtil = _arg_1;
        }


        private function changePageNo(_arg_1:int):void
        {
            var _local_2:int = (this.pageNo + _arg_1);
            if (((_local_2 > 0) && (_local_2 <= this.totalPage)))
            {
                this.pageNo = _local_2;
                if (curSelectRankIndex == 0)
                {
                    ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingToday(this.pageNo, pageSize);
                }
                else
                {
                    ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingYesterday(this.pageNo, pageSize);
                };
            };
        }

        public function __toLeftBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(-1);
        }

        [Bindable(event="propertyChange")]
        private function get questTypeArray():ArrayCollection
        {
            return (this._425636739questTypeArray);
        }

        [Bindable(event="propertyChange")]
        public function get questDg():DataGrid
        {
            return (this._655126789questDg);
        }

        public function getDesc(_arg_1:String):String
        {
            return (ItemEumDefine.getItemEum(_arg_1).itemDesc);
        }

        private function set questTypeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._425636739questTypeArray;
            if (_local_2 !== _arg_1)
            {
                this._425636739questTypeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeArray", _local_2, _arg_1));
            };
        }

        public function set questDg(_arg_1:DataGrid):void
        {
            var _local_2:Object = this._655126789questDg;
            if (_local_2 !== _arg_1)
            {
                this._655126789questDg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questDg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get totalPage():int
        {
            return (this._577409037totalPage);
        }

        override public function initialize():void
        {
            var target:TurntableRank;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TurntableRank_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_TurntableRankWatcherSetupUtil");
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
        private function get curSelectRankIndex():int
        {
            return (this._776676342curSelectRankIndex);
        }

        private function _TurntableRank_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TurntableRank_DataGridColumn1 = _local_1;
            _local_1.dataField = "rank";
            _local_1.width = 60;
            _local_1.itemRenderer = _TurntableRank_ClassFactory1_c();
            BindingManager.executeBindings(this, "_TurntableRank_DataGridColumn1", _TurntableRank_DataGridColumn1);
            return (_local_1);
        }

        private function _TurntableRank_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("开箱子排行榜");
            _local_1 = this.questTypeArray;
            _local_1 = Lang.msg("排名");
            _local_1 = Lang.msg("君主");
            _local_1 = Lang.msg("开箱次数");
            _local_1 = Lang.msg("奖励");
            _local_1 = ((this.pageNo + "/") + this.totalPage);
            _local_1 = Lang.msg("领取奖励");
            _local_1 = ((curSelectRankIndex == 1) ? true : false);
            _local_1 = Lang.msg("今日开箱排行榜");
            _local_1 = Lang.msg("昨日开箱排行榜");
        }

        private function setAward(_arg_1:Object, _arg_2:DataGridColumn):String
        {
            var _local_3:* = "";
            return (this.bean.id);
        }

        private function _TurntableRank_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TurntableRank_DataGridColumn3 = _local_1;
            _local_1.dataField = "count";
            _local_1.width = 80;
            _local_1.itemRenderer = _TurntableRank_ClassFactory3_c();
            BindingManager.executeBindings(this, "_TurntableRank_DataGridColumn3", _TurntableRank_DataGridColumn3);
            return (_local_1);
        }

        private function onAwardResponse(_arg_1:GamblingRankingRewardRespone):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("奖励已领取"));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___TurntableRank_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function getIcon1(_arg_1:String):String
        {
            return (ItemEumDefine.getItemEum(_arg_1).iconUrl);
        }

        private function _TurntableRank_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TurntableRank_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.GAMBLINGRANKING_GET_GAMBLING_RANKING_TODAY, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.GAMBLINGRANKING_GET_GAMBLING_RANKING_YESTERDAY, onRank);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.GAMBLINGRANKING_GET_GAMBLING_RANKING_REWARD, onAwardResponse);
            this.refresh();
        }

        private function onRank(_arg_1:GamblingRankingRespone):void
        {
            this.questTypeArray = _arg_1.gamblingRankingBeansArray;
            this.pageNo = _arg_1.pageNo;
            this.totalPage = _arg_1.totalPage;
        }

        private function _TurntableRank_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开箱子排行榜");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.questTypeArray);
            }, function (_arg_1:Object):void
            {
                questDg.dataProvider = _arg_1;
            }, "questDg.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("排名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_DataGridColumn1.headerText = _arg_1;
            }, "_TurntableRank_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("君主");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_DataGridColumn2.headerText = _arg_1;
            }, "_TurntableRank_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("开箱次数");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_DataGridColumn3.headerText = _arg_1;
            }, "_TurntableRank_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_DataGridColumn4.headerText = _arg_1;
            }, "_TurntableRank_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((this.pageNo + "/") + this.totalPage);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_Label1.text = _arg_1;
            }, "_TurntableRank_Label1.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("领取奖励");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_Button4.label = _arg_1;
            }, "_TurntableRank_Button4.label");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((curSelectRankIndex == 1) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _TurntableRank_Button4.visible = _arg_1;
            }, "_TurntableRank_Button4.visible");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("今日开箱排行榜"));
            }, function (_arg_1:*):void
            {
                _TurntableRank_Array2[0] = _arg_1;
            }, "_TurntableRank_Array2[0]");
            result[9] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("昨日开箱排行榜"));
            }, function (_arg_1:*):void
            {
                _TurntableRank_Array2[1] = _arg_1;
            }, "_TurntableRank_Array2[1]");
            result[10] = binding;
            return (result);
        }

        public function ___TurntableRank_Button4_click(_arg_1:MouseEvent):void
        {
            award();
        }

        public function MMoverHandler(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onChangeRank(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingToday(1, pageSize);
                    curSelectRankIndex = 0;
                    return;
                case 1:
                    ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingYesterday(1, pageSize);
                    curSelectRankIndex = 1;
                    return;
            };
        }

        private function _TurntableRank_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TurntableRank_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function onCreationComplete(_arg_1:FlexEvent):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                BitmapAsset(_arg_1.currentTarget.content).smoothing = true;
            };
        }

        [Bindable(event="propertyChange")]
        public function get toRightBtn():Button
        {
            return (this._1456175557toRightBtn);
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

        private function _TurntableRank_Array2_i():Array
        {
            var _local_1:Array = [null, null];
            _TurntableRank_Array2 = _local_1;
            BindingManager.executeBindings(this, "_TurntableRank_Array2", _TurntableRank_Array2);
            return (_local_1);
        }

        public function getColor(_arg_1:int):int
        {
            var _local_2:* = 0x652D00;
            if (_arg_1 == 1)
            {
                _local_2 = 0xFF;
            }
            else
            {
                if (_arg_1 == 5)
                {
                    _local_2 = 0xFE00D7;
                }
                else
                {
                    if (_arg_1 == 10)
                    {
                        _local_2 = 0xFE00D7;
                    };
                };
            };
            return (_local_2);
        }

        public function set questTypeTBB(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._1341206824questTypeTBB;
            if (_local_2 !== _arg_1)
            {
                this._1341206824questTypeTBB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "questTypeTBB", _local_2, _arg_1));
            };
        }

        public function MOverHandler(_arg_1:MouseEvent, _arg_2:String):void
        {
            var _local_3:ItemEum = ItemEumDefine.getItemEum(_arg_2);
            DescribeTooltip.show(_local_3.name, _local_3.itemDesc, _arg_1);
        }

        public function MOutHandler():void
        {
            DescribeTooltip.hide();
        }

        [Bindable(event="propertyChange")]
        private function get pageNo():int
        {
            return (this._995752784pageNo);
        }

        private function _TurntableRank_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TurntableRank_DataGridColumn2 = _local_1;
            _local_1.dataField = "playerName";
            _local_1.width = 80;
            _local_1.itemRenderer = _TurntableRank_ClassFactory2_c();
            BindingManager.executeBindings(this, "_TurntableRank_DataGridColumn2", _TurntableRank_DataGridColumn2);
            return (_local_1);
        }

        private function _TurntableRank_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _TurntableRank_DataGridColumn4 = _local_1;
            _local_1.dataField = "itemsBeansArray";
            _local_1.width = 100;
            _local_1.itemRenderer = _TurntableRank_ClassFactory4_c();
            BindingManager.executeBindings(this, "_TurntableRank_DataGridColumn4", _TurntableRank_DataGridColumn4);
            return (_local_1);
        }

        override public function refresh():void
        {
            questTypeTBB.selectedIndex = 0;
            ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingToday(1, 10);
        }

        public function ___TurntableRank_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        private function award():void
        {
            ActionFactory.getInstance().getGamblingRankingCommands().getGamblingRankingReward();
        }

        [Bindable(event="propertyChange")]
        public function get toLeftBtn():Button
        {
            return (this._1607799334toLeftBtn);
        }

        [Bindable(event="propertyChange")]
        public function get questTypeTBB():ToggleButtonBar
        {
            return (this._1341206824questTypeTBB);
        }

        private function _TurntableRank_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TurntableRank_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
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

        private function set curSelectRankIndex(_arg_1:int):void
        {
            var _local_2:Object = this._776676342curSelectRankIndex;
            if (_local_2 !== _arg_1)
            {
                this._776676342curSelectRankIndex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curSelectRankIndex", _local_2, _arg_1));
            };
        }

        public function ___TurntableRank_Button3_click(_arg_1:MouseEvent):void
        {
            seeRules();
        }

        public function seeRules():void
        {
            Rules.show();
        }

        public function __questTypeTBB_itemClick(_arg_1:ItemClickEvent):void
        {
            onChangeRank(_arg_1);
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

        private function _TurntableRank_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = TurntableRank_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function getCount1(_arg_1:Object):int
        {
            this.bean = (_arg_1 as ItemBean);
            return (this.bean.count);
        }

        override public function destroy():void
        {
        }

        public function __toRightBtn_click(_arg_1:MouseEvent):void
        {
            this.changePageNo(1);
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


    }
}//package view.module.shop

