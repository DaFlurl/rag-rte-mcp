// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.MyTradeComp

package view.module.market
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.core.UIComponentDescriptor;
    import com.evony.Lang;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import mx.binding.BindingManager;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import mx.core.ClassFactory;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import view.ui.AlertWin;
    import com.evony.common.beans.TradeBean;
    import com.evony.common.module.CommandResponse;
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

    public class MyTradeComp extends Canvas implements IBindingClient 
    {

        public static const EVENT_NEW_TRADE:String = "MyTradeComp.newTrade";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _MyTradeComp_Label1:Label;
        private var _1458231286tradesArray:ArrayCollection;
        public var _MyTradeComp_Button1:Button;
        public var _MyTradeComp_DataGrid1:DataGrid;
        public var _MyTradeComp_DataGridColumn1:DataGridColumn;
        public var _MyTradeComp_DataGridColumn2:DataGridColumn;
        public var _MyTradeComp_DataGridColumn3:DataGridColumn;
        public var _MyTradeComp_DataGridColumn4:DataGridColumn;
        public var _MyTradeComp_DataGridColumn6:DataGridColumn;
        public var _MyTradeComp_DataGridColumn5:DataGridColumn;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":452,
                    "height":164,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_MyTradeComp_Label1",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":20,
                                "x":1
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_MyTradeComp_Button1",
                        "events":{
                            "mouseOut":"___MyTradeComp_Button1_mouseOut",
                            "mouseOver":"___MyTradeComp_Button1_mouseOver",
                            "mouseMove":"___MyTradeComp_Button1_mouseMove",
                            "click":"___MyTradeComp_Button1_click"
                        },
                        "stylesFactory":function ():void
                        {
                            this.right = "3";
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"Blue75",
                                "height":23
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_MyTradeComp_DataGrid1",
                        "events":{
                            "mouseOut":"___MyTradeComp_DataGrid1_mouseOut",
                            "mouseOver":"___MyTradeComp_DataGrid1_mouseOver",
                            "mouseMove":"___MyTradeComp_DataGrid1_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":1,
                                "y":24,
                                "styleName":"style2",
                                "height":130,
                                "selectable":false,
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "percentWidth":100,
                                "columns":[_MyTradeComp_DataGridColumn1_i(), _MyTradeComp_DataGridColumn2_i(), _MyTradeComp_DataGridColumn3_i(), _MyTradeComp_DataGridColumn4_i(), _MyTradeComp_DataGridColumn5_i(), _MyTradeComp_DataGridColumn6_i()]
                            });
                        }
                    })]
                });
            }
        });
        private var _476564823cancelStr:String = Lang.msg("撤单");
        private var myPresentationTooltip:PresentationTooltip = PresentationTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MyTradeComp()
        {
            mx_internal::_document = this;
            this.width = 452;
            this.height = 164;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MyTradeComp._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get tradesArray():ArrayCollection
        {
            return (this._1458231286tradesArray);
        }

        private function _MyTradeComp_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("挂单查询");
            _local_1 = Lang.msg("发布交易");
            _local_1 = this.tradesArray;
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("单价");
            _local_1 = Lang.msg("已成交");
            _local_1 = Lang.msg("交易方式名");
            _local_1 = Lang.msg("功能取消");
        }

        private function outHandler():void
        {
            PopUpManager.removePopUp(this.myPresentationTooltip);
        }

        override public function initialize():void
        {
            var target:MyTradeComp;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MyTradeComp_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_MyTradeCompWatcherSetupUtil");
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

        public function ___MyTradeComp_Button1_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        private function _MyTradeComp_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn4 = _local_1;
            _local_1.width = 85;
            _local_1.dataField = "dealedAmount";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn4", _MyTradeComp_DataGridColumn4);
            return (_local_1);
        }

        private function _MyTradeComp_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn6 = _local_1;
            _local_1.dataField = "id";
            _local_1.width = 65;
            _local_1.itemRenderer = _MyTradeComp_ClassFactory1_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn6", _MyTradeComp_DataGridColumn6);
            return (_local_1);
        }

        private function onNewTradeClick():void
        {
            this.dispatchEvent(new Event(EVENT_NEW_TRADE));
        }

        private function _MyTradeComp_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn2 = _local_1;
            _local_1.width = 82;
            _local_1.dataField = "amount";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn2", _MyTradeComp_DataGridColumn2);
            return (_local_1);
        }

        public function set cancelStr(_arg_1:String):void
        {
            var _local_2:Object = this._476564823cancelStr;
            if (_local_2 !== _arg_1)
            {
                this._476564823cancelStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelStr", _local_2, _arg_1));
            };
        }

        public function ___MyTradeComp_Button1_click(_arg_1:MouseEvent):void
        {
            onNewTradeClick();
        }

        public function set tradesArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1458231286tradesArray;
            if (_local_2 !== _arg_1)
            {
                this._1458231286tradesArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tradesArray", _local_2, _arg_1));
            };
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
        }

        private function _MyTradeComp_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MyTradeComp_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        public function ___MyTradeComp_DataGrid1_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        public function ___MyTradeComp_Button1_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        public function ___MyTradeComp_Button1_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("在这里进行交易的挂单内容填写");
        }

        public function onCancleClick(bean:TradeBean):void
        {
            var onCancelOk:Function;
            onCancelOk = function (_arg_1:Boolean):void
            {
                var _local_2:int;
                if (_arg_1)
                {
                    _local_2 = Context.getInstance().getCurCastle().id;
                    ActionFactory.getInstance().getTradeCommands().cancelTrade(_local_2, bean.id, onCommandResponse);
                };
            };
            trace(((this.className + " onCancleClick(),tradeId=") + bean.id));
            AlertWin.show(Lang.msg("确定撤单提示"), onCancelOk, "Ok", "Cancel");
        }

        private function onCommandResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
            if (!myPresentationTooltip.isPopUp)
            {
                PopUpManager.addPopUp(this.myPresentationTooltip, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get cancelStr():String
        {
            return (this._476564823cancelStr);
        }

        private function _MyTradeComp_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn1 = _local_1;
            _local_1.width = 75;
            _local_1.dataField = "resourceName";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn1", _MyTradeComp_DataGridColumn1);
            return (_local_1);
        }

        private function _MyTradeComp_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn3 = _local_1;
            _local_1.width = 75;
            _local_1.dataField = "price";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn3", _MyTradeComp_DataGridColumn3);
            return (_local_1);
        }

        public function ___MyTradeComp_DataGrid1_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function _MyTradeComp_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTradeComp_DataGridColumn5 = _local_1;
            _local_1.width = 70;
            _local_1.dataField = "tradeTypeName";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTradeComp_DataGridColumn5", _MyTradeComp_DataGridColumn5);
            return (_local_1);
        }

        public function ___MyTradeComp_DataGrid1_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("你在市场中正在进行交易挂单的资源信息");
        }

        private function _MyTradeComp_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("挂单查询");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_Label1.text = _arg_1;
            }, "_MyTradeComp_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("发布交易");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_Button1.label = _arg_1;
            }, "_MyTradeComp_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.tradesArray);
            }, function (_arg_1:Object):void
            {
                _MyTradeComp_DataGrid1.dataProvider = _arg_1;
            }, "_MyTradeComp_DataGrid1.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn1.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn1.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn2.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn2.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("单价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn3.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn3.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("已成交");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn4.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn4.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("交易方式名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn5.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn5.headerText");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("功能取消");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTradeComp_DataGridColumn6.headerText = _arg_1;
            }, "_MyTradeComp_DataGridColumn6.headerText");
            result[8] = binding;
            return (result);
        }


    }
}//package view.module.market

