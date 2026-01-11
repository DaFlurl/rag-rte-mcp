// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.Market

package view.module.market
{
    import view.ui.BaseBuildingWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.containers.ViewStack;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import mx.containers.Canvas;
    import mx.containers.VBox;
    import mx.controls.ToggleButtonBar;
    import view.ui.MyHRule;
    import mx.controls.Spacer;
    import mx.containers.HBox;
    import com.evony.Lang;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.core.ClassFactory;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import mx.managers.PopUpManager;
    import mx.binding.BindingManager;
    import mx.events.ItemClickEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import mx.collections.SortField;
    import mx.collections.Sort;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.beans.MarketTradeBean;
    import com.evony.MsgDispacther;
    import com.evony.events.AutomaticTradeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.CommonUtil;
    import com.evony.common.module.trade.SearchTradesResponse;
    import com.evony.Context;
    import com.evony.common.beans.CastleBean;
    import com.evony.util.UIUtil;
    import mx.core.UIComponent;
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

    public class Market extends BaseBuildingWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "Market.show";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var resType:int = 0;
        private var _1389294561bidBtn:Button;
        private var _2141096377myTradeComp:MyTradeComp;
        private var _1767004776newTradeWin:NewTradeWin;
        public var _Market_DataGrid2:DataGrid;
        public var _Market_DataGrid1:DataGrid;
        public var _Market_Button1:Button;
        public var _Market_Array1:Array;
        private var _946505330viewstack1:ViewStack;
        public var _Market_DataGridColumn1:DataGridColumn;
        public var _Market_DataGridColumn2:DataGridColumn;
        public var _Market_DataGridColumn3:DataGridColumn;
        public var _Market_DataGridColumn5:DataGridColumn;
        public var _Market_DataGridColumn6:DataGridColumn;
        private var _768573856offerBtn:Button;
        private var _1284112595myTransingTradeComp:MyTransingTradeComp;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseBuildingWindow,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":820,
                    "height":313,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "width":453,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":MyTradeComp,
                                                "id":"myTradeComp",
                                                "stylesFactory":function ():void
                                                {
                                                    this.right = "0";
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":MyTransingTradeComp,
                                                "id":"myTransingTradeComp",
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "49";
                                                    this.right = "0";
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":NewTradeWin,
                                    "id":"newTradeWin"
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentHeight":100,
                                "width":302,
                                "x":0,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":ToggleButtonBar,
                                    "events":{"itemClick":"___Market_ToggleButtonBar1_itemClick"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textIndent = 0;
                                        this.letterSpacing = 0;
                                        this.fontSize = 11;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":302,
                                            "height":24,
                                            "dataProvider":_Market_Array1_i()
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_Market_DataGrid1",
                                    "events":{
                                        "mouseOut":"___Market_DataGrid1_mouseOut",
                                        "mouseOver":"___Market_DataGrid1_mouseOver",
                                        "mouseMove":"___Market_DataGrid1_mouseMove"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":150,
                                            "percentWidth":100,
                                            "styleName":"style2",
                                            "selectable":false,
                                            "rowHeight":25,
                                            "editable":false,
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "columns":[_Market_DataGridColumn1_i(), _Market_DataGridColumn2_i(), _Market_DataGridColumn3_i()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.strokeWidth = 1;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":95,
                                            "height":3
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":DataGrid,
                                    "id":"_Market_DataGrid2",
                                    "events":{
                                        "mouseOut":"___Market_DataGrid2_mouseOut",
                                        "mouseOver":"___Market_DataGrid2_mouseOver",
                                        "mouseMove":"___Market_DataGrid2_mouseMove"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":125,
                                            "percentWidth":100,
                                            "styleName":"style2",
                                            "rowHeight":25,
                                            "showHeaders":false,
                                            "editable":false,
                                            "resizableColumns":false,
                                            "draggableColumns":false,
                                            "sortableColumns":false,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "selectable":false,
                                            "columns":[_Market_DataGridColumn4_c(), _Market_DataGridColumn5_i(), _Market_DataGridColumn6_i()]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Spacer,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"height":2});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":98,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_Market_Button1",
                                                "events":{
                                                    "click":"___Market_Button1_click",
                                                    "mouseOut":"___Market_Button1_mouseOut",
                                                    "mouseOver":"___Market_Button1_mouseOver",
                                                    "mouseMove":"___Market_Button1_mouseMove"
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"bidBtn",
                        "events":{"click":"__bidBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "150";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":240,
                                "styleName":"b40",
                                "height":20
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"offerBtn",
                        "events":{"click":"__offerBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "181";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b40",
                                "height":20,
                                "x":240
                            });
                        }
                    })]
                });
            }
        });
        private var resName:String = Lang.msg("粮食");
        private var _1547012569sellArray:ArrayCollection = new ArrayCollection();
        private var _1011865741buyArray:ArrayCollection = new ArrayCollection();
        private var _1377570357buyStr:String = Lang.msg("买");
        private var _1978293631sellStr:String = Lang.msg("卖");
        private var myPresentationTooltip:PresentationTooltip = PresentationTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Market()
        {
            mx_internal::_document = this;
            this.width = 820;
            this.height = 313;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___Market_BaseBuildingWindow1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Market._watcherSetupUtil = _arg_1;
        }


        private function _Market_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _Market_ClassFactory6_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent6;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function set sellStr(_arg_1:String):void
        {
            var _local_2:Object = this._1978293631sellStr;
            if (_local_2 !== _arg_1)
            {
                this._1978293631sellStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sellStr", _local_2, _arg_1));
            };
        }

        public function ___Market_DataGrid1_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        private function init():void
        {
            var onNewTradeEvent:Function;
            onNewTradeEvent = function (_arg_1:Event):void
            {
                onNewTradeClick();
            };
            this.newTradeWin.addEventListener(NewTradeWin.EVENT_BACK, onNewTradeWinBack);
            this.newTradeWin.addEventListener(NewTradeWin.EVENT_TRADE_COMPLETE, onNewTradeComplete);
            this.myTradeComp.addEventListener(MyTradeComp.EVENT_NEW_TRADE, onNewTradeEvent);
            this.newTradeWin.createComponentsFromDescriptors();
        }

        private function outHandler():void
        {
            PopUpManager.removePopUp(this.myPresentationTooltip);
        }

        [Bindable(event="propertyChange")]
        public function get bidBtn():Button
        {
            return (this._1389294561bidBtn);
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

        [Bindable(event="propertyChange")]
        private function get sellArray():ArrayCollection
        {
            return (this._1547012569sellArray);
        }

        public function ___Market_DataGrid2_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        [Bindable(event="propertyChange")]
        public function get myTransingTradeComp():MyTransingTradeComp
        {
            return (this._1284112595myTransingTradeComp);
        }

        public function set newTradeWin(_arg_1:NewTradeWin):void
        {
            var _local_2:Object = this._1767004776newTradeWin;
            if (_local_2 !== _arg_1)
            {
                this._1767004776newTradeWin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newTradeWin", _local_2, _arg_1));
            };
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
        }

        private function _Market_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Market_DataGridColumn3 = _local_1;
            _local_1.width = 120;
            _local_1.itemRenderer = _Market_ClassFactory3_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_Market_DataGridColumn3", _Market_DataGridColumn3);
            return (_local_1);
        }

        private function _Market_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _Market_ClassFactory5_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent5;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___Market_ToggleButtonBar1_itemClick(_arg_1:ItemClickEvent):void
        {
            this.clickHandler(_arg_1);
        }

        private function _Market_Array1_i():Array
        {
            var _local_1:Array = [null, null, null, null];
            _Market_Array1 = _local_1;
            BindingManager.executeBindings(this, "_Market_Array1", _Market_Array1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get myTradeComp():MyTradeComp
        {
            return (this._2141096377myTradeComp);
        }

        public function __bidBtn_click(_arg_1:MouseEvent):void
        {
            tradeResource(_arg_1);
        }

        public function set bidBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1389294561bidBtn;
            if (_local_2 !== _arg_1)
            {
                this._1389294561bidBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bidBtn", _local_2, _arg_1));
            };
        }

        private function set sellArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1547012569sellArray;
            if (_local_2 !== _arg_1)
            {
                this._1547012569sellArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sellArray", _local_2, _arg_1));
            };
        }

        public function ___Market_Button1_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        public function ___Market_Button1_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("请随时对当前的市场交易信息进行跟踪刷新,以保障显示内容的准确性");
        }

        private function searchTrades():void
        {
            this.newTradeWin.refresh(this.resType, this.resName);
            this.sellArray.removeAll();
            this.buyArray.removeAll();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TRADE_SEARCH_TRADES, onSearchTrades, false, 0, true);
            ActionFactory.getInstance().getTradeCommands().searchTrades(this.resType);
        }

        public function set myTransingTradeComp(_arg_1:MyTransingTradeComp):void
        {
            var _local_2:Object = this._1284112595myTransingTradeComp;
            if (_local_2 !== _arg_1)
            {
                this._1284112595myTransingTradeComp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTransingTradeComp", _local_2, _arg_1));
            };
        }

        private function mineSortArray(_arg_1:ArrayCollection, _arg_2:String, _arg_3:Boolean=false):void
        {
            var _local_4:SortField = new SortField();
            _local_4.name = _arg_2;
            _local_4.descending = _arg_3;
            _local_4.numeric = true;
            var _local_5:Sort = new Sort();
            _local_5.fields = [_local_4];
            _arg_1.sort = _local_5;
            _arg_1.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get offerBtn():Button
        {
            return (this._768573856offerBtn);
        }

        private function _Market_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Market_DataGridColumn2 = _local_1;
            _local_1.width = 110;
            _local_1.itemRenderer = _Market_ClassFactory2_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_Market_DataGridColumn2", _Market_DataGridColumn2);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        private function get buyArray():ArrayCollection
        {
            return (this._1011865741buyArray);
        }

        public function ___Market_DataGrid2_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function _Market_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Market_DataGridColumn6 = _local_1;
            _local_1.width = 120;
            _local_1.itemRenderer = _Market_ClassFactory6_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_Market_DataGridColumn6", _Market_DataGridColumn6);
            return (_local_1);
        }

        public function ___Market_DataGrid2_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("当前市场中购买价格最高的五个交易挂单");
        }

        public function ___Market_BaseBuildingWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _Market_ClassFactory4_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent4;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get sellStr():String
        {
            return (this._1978293631sellStr);
        }

        public function set myTradeComp(_arg_1:MyTradeComp):void
        {
            var _local_2:Object = this._2141096377myTradeComp;
            if (_local_2 !== _arg_1)
            {
                this._2141096377myTradeComp = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myTradeComp", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:Market;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Market_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_MarketWatcherSetupUtil");
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

        public function tradeResource(_arg_1:MouseEvent):void
        {
            this.viewstack1.selectedIndex = 1;
            var _local_2:Number = 0;
            var _local_3:* = "";
            if (_arg_1.currentTarget == this.bidBtn)
            {
                _local_2 = ((sellArray.length > 0) ? MarketTradeBean(sellArray[(sellArray.length - 1)]).price : 0);
                _local_3 = "sell";
            }
            else
            {
                if (_arg_1.currentTarget == this.offerBtn)
                {
                    _local_2 = ((buyArray.length > 0) ? MarketTradeBean(buyArray[0]).price : 0);
                    _local_3 = "buy";
                };
            };
            MsgDispacther.getInstance().dispatchEvent(new AutomaticTradeEvent(AutomaticTradeEvent.EVENT_NAME, _local_3, String(_local_2)));
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        [Bindable(event="propertyChange")]
        public function get newTradeWin():NewTradeWin
        {
            return (this._1767004776newTradeWin);
        }

        private function clickHandler(_arg_1:ItemClickEvent):void
        {
            this.resType = _arg_1.index;
            this.resName = (_arg_1.item as String);
            this.searchTrades();
        }

        private function onNewTradeClick():void
        {
            this.viewstack1.selectedIndex = 1;
        }

        public function ___Market_Button1_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        public function set buyStr(_arg_1:String):void
        {
            var _local_2:Object = this._1377570357buyStr;
            if (_local_2 !== _arg_1)
            {
                this._1377570357buyStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyStr", _local_2, _arg_1));
            };
        }

        private function _Market_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Market_DataGridColumn1 = _local_1;
            _local_1.width = 60;
            _local_1.itemRenderer = _Market_ClassFactory1_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_Market_DataGridColumn1", _Market_DataGridColumn1);
            return (_local_1);
        }

        public function ___Market_DataGrid1_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function _Market_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _Market_DataGridColumn5 = _local_1;
            _local_1.width = 110;
            _local_1.itemRenderer = _Market_ClassFactory5_c();
            _local_1.setStyle("textAlign", "left");
            BindingManager.executeBindings(this, "_Market_DataGridColumn5", _Market_DataGridColumn5);
            return (_local_1);
        }

        public function ___Market_DataGrid1_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("当前市场中贩卖价格最低的五个交易挂单");
        }

        private function _Market_ClassFactory3_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = Market_inlineComponent3;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___Market_Button1_click(_arg_1:MouseEvent):void
        {
            searchTrades();
        }

        private function onNewTradeWinBack(_arg_1:Event):void
        {
            this.viewstack1.selectedIndex = 0;
        }

        public function __offerBtn_click(_arg_1:MouseEvent):void
        {
            tradeResource(_arg_1);
        }

        private function _Market_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("粮食"));
            }, function (_arg_1:*):void
            {
                _Market_Array1[0] = _arg_1;
            }, "_Market_Array1[0]");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("木材"));
            }, function (_arg_1:*):void
            {
                _Market_Array1[1] = _arg_1;
            }, "_Market_Array1[1]");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("石料"));
            }, function (_arg_1:*):void
            {
                _Market_Array1[2] = _arg_1;
            }, "_Market_Array1[2]");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("铁矿"));
            }, function (_arg_1:*):void
            {
                _Market_Array1[3] = _arg_1;
            }, "_Market_Array1[3]");
            result[3] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.sellArray);
            }, function (_arg_1:Object):void
            {
                _Market_DataGrid1.dataProvider = _arg_1;
            }, "_Market_DataGrid1.dataProvider");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("状态");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_DataGridColumn1.headerText = _arg_1;
            }, "_Market_DataGridColumn1.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_DataGridColumn2.headerText = _arg_1;
            }, "_Market_DataGridColumn2.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("单价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_DataGridColumn3.headerText = _arg_1;
            }, "_Market_DataGridColumn3.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.buyArray);
            }, function (_arg_1:Object):void
            {
                _Market_DataGrid2.dataProvider = _arg_1;
            }, "_Market_DataGrid2.dataProvider");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_DataGridColumn5.headerText = _arg_1;
            }, "_Market_DataGridColumn5.headerText");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("单价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_DataGridColumn6.headerText = _arg_1;
            }, "_Market_DataGridColumn6.headerText");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("刷新");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Market_Button1.label = _arg_1;
            }, "_Market_Button1.label");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("买资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                bidBtn.label = _arg_1;
            }, "bidBtn.label");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("卖资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                offerBtn.label = _arg_1;
            }, "offerBtn.label");
            result[13] = binding;
            return (result);
        }

        private function onCommandResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onSearchTrades(_arg_1:SearchTradesResponse):void
        {
            mineSortArray(_arg_1.sellersArray, "price", true);
            mineSortArray(_arg_1.buyersArray, "price", true);
            CommonUtil.arrayCopy(_arg_1.sellersArray, this.sellArray);
            CommonUtil.arrayCopy(_arg_1.buyersArray, this.buyArray);
        }

        public function set offerBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._768573856offerBtn;
            if (_local_2 !== _arg_1)
            {
                this._768573856offerBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "offerBtn", _local_2, _arg_1));
            };
        }

        override public function refresh():void
        {
            trace((this.className + " refresh()"));
            var _local_1:CastleBean = Context.getInstance().getCurCastle();
            this.myTransingTradeComp.transingTradeArray = _local_1.transingTradesArray;
            this.myTradeComp.tradesArray = _local_1.tradesArray;
            this.searchTrades();
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
            UIUtil.setPopopHelpWindowStye(this.myPresentationTooltip);
            if (!UIComponent(this.myPresentationTooltip).isPopUp)
            {
                PopUpManager.addPopUp(this.myPresentationTooltip, this);
            }
            else
            {
                PopUpManager.bringToFront(this.myPresentationTooltip);
            };
        }

        [Bindable(event="propertyChange")]
        public function get buyStr():String
        {
            return (this._1377570357buyStr);
        }

        private function _Market_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("粮食");
            _local_1 = Lang.msg("木材");
            _local_1 = Lang.msg("石料");
            _local_1 = Lang.msg("铁矿");
            _local_1 = this.sellArray;
            _local_1 = Lang.msg("状态");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("单价");
            _local_1 = this.buyArray;
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("单价");
            _local_1 = Lang.msg("刷新");
            _local_1 = Lang.msg("买资源");
            _local_1 = Lang.msg("卖资源");
        }

        private function _Market_DataGridColumn4_c():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _local_1.headerText = "";
            _local_1.width = 60;
            _local_1.itemRenderer = _Market_ClassFactory4_c();
            _local_1.setStyle("textAlign", "center");
            return (_local_1);
        }

        private function onNewTradeComplete(_arg_1:Event):void
        {
            this.searchTrades();
            this.viewstack1.selectedIndex = 0;
        }

        private function set buyArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1011865741buyArray;
            if (_local_2 !== _arg_1)
            {
                this._1011865741buyArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buyArray", _local_2, _arg_1));
            };
        }


    }
}//package view.module.market

