// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.MyTransingTradeComp

package view.module.market
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.DataGrid;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import mx.binding.BindingManager;
    import com.evony.Context;
    import com.evony.client.action.ActionFactory;
    import com.evony.eum.ItemEum;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import com.evony.common.beans.TransingTradeBean;
    import mx.core.ClassFactory;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import mx.managers.PopUpManager;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
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

    public class MyTransingTradeComp extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2012933935transingTradeArray:ArrayCollection;
        public var _MyTransingTradeComp_DataGrid1:DataGrid;
        public var _MyTransingTradeComp_DataGridColumn1:DataGridColumn;
        public var _MyTransingTradeComp_DataGridColumn2:DataGridColumn;
        public var _MyTransingTradeComp_DataGridColumn3:DataGridColumn;
        public var _MyTransingTradeComp_DataGridColumn4:DataGridColumn;
        public var _MyTransingTradeComp_DataGridColumn5:DataGridColumn;
        public var _MyTransingTradeComp_DataGridColumn6:DataGridColumn;
        public var _MyTransingTradeComp_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":452,
                    "height":140,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_MyTransingTradeComp_Label1",
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":20,
                                "y":10,
                                "x":1
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":DataGrid,
                        "id":"_MyTransingTradeComp_DataGrid1",
                        "events":{
                            "mouseOut":"___MyTransingTradeComp_DataGrid1_mouseOut",
                            "mouseOver":"___MyTransingTradeComp_DataGrid1_mouseOver",
                            "mouseMove":"___MyTransingTradeComp_DataGrid1_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":1,
                                "y":30,
                                "percentWidth":100,
                                "height":109,
                                "styleName":"style2",
                                "resizableColumns":false,
                                "draggableColumns":false,
                                "sortableColumns":false,
                                "columns":[_MyTransingTradeComp_DataGridColumn1_i(), _MyTransingTradeComp_DataGridColumn2_i(), _MyTransingTradeComp_DataGridColumn3_i(), _MyTransingTradeComp_DataGridColumn4_i(), _MyTransingTradeComp_DataGridColumn5_i(), _MyTransingTradeComp_DataGridColumn6_i()]
                            });
                        }
                    })]
                });
            }
        });
        private var myPresentationTooltip:PresentationTooltip = PresentationTooltip.getInstance();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MyTransingTradeComp()
        {
            mx_internal::_document = this;
            this.width = 452;
            this.height = 140;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MyTransingTradeComp._watcherSetupUtil = _arg_1;
        }


        public function set transingTradeArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2012933935transingTradeArray;
            if (_local_2 !== _arg_1)
            {
                this._2012933935transingTradeArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "transingTradeArray", _local_2, _arg_1));
            };
        }

        private function _MyTransingTradeComp_DataGridColumn2_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn2 = _local_1;
            _local_1.width = 65;
            _local_1.dataField = "amount";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn2", _MyTransingTradeComp_DataGridColumn2);
            return (_local_1);
        }

        private function _MyTransingTradeComp_DataGridColumn4_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn4 = _local_1;
            _local_1.width = 85;
            _local_1.dataField = "total";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn4", _MyTransingTradeComp_DataGridColumn4);
            return (_local_1);
        }

        private function _MyTransingTradeComp_DataGridColumn6_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn6 = _local_1;
            _local_1.dataField = "total";
            _local_1.width = 75;
            _local_1.itemRenderer = _MyTransingTradeComp_ClassFactory2_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn6", _MyTransingTradeComp_DataGridColumn6);
            return (_local_1);
        }

        public function onSpeedUpBtnClick(bean:TransingTradeBean):void
        {
            var onSpeedUpItemSelected:Function;
            onSpeedUpItemSelected = function (_arg_1:ItemEum):void
            {
                var _local_2:int = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getTradeCommands().speedUpTrans(_local_2, bean.id, _arg_1.id, onCommandResponse);
            };
            trace(((this.className + " onSpeedUpBtnClick(),tradeId=") + bean.id));
            SpeedupItemSelector.show(ItemManager.speedDealArray, onSpeedUpItemSelected);
        }

        private function _MyTransingTradeComp_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MyTransingTradeComp_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:MyTransingTradeComp;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MyTransingTradeComp_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_MyTransingTradeCompWatcherSetupUtil");
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

        public function ___MyTransingTradeComp_DataGrid1_mouseOut(_arg_1:MouseEvent):void
        {
            outHandler();
        }

        private function outHandler():void
        {
            PopUpManager.removePopUp(this.myPresentationTooltip);
        }

        [Bindable(event="propertyChange")]
        public function get transingTradeArray():ArrayCollection
        {
            return (this._2012933935transingTradeArray);
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
        }

        private function _MyTransingTradeComp_DataGridColumn1_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn1 = _local_1;
            _local_1.width = 75;
            _local_1.dataField = "resourceName";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn1", _MyTransingTradeComp_DataGridColumn1);
            return (_local_1);
        }

        private function _MyTransingTradeComp_DataGridColumn3_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn3 = _local_1;
            _local_1.width = 75;
            _local_1.dataField = "price";
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn3", _MyTransingTradeComp_DataGridColumn3);
            return (_local_1);
        }

        public function ___MyTransingTradeComp_DataGrid1_mouseMove(_arg_1:MouseEvent):void
        {
            moveHandler(_arg_1);
        }

        private function _MyTransingTradeComp_DataGridColumn5_i():DataGridColumn
        {
            var _local_1:DataGridColumn = new DataGridColumn();
            _MyTransingTradeComp_DataGridColumn5 = _local_1;
            _local_1.width = 70;
            _local_1.itemRenderer = _MyTransingTradeComp_ClassFactory1_c();
            _local_1.setStyle("textAlign", "center");
            BindingManager.executeBindings(this, "_MyTransingTradeComp_DataGridColumn5", _MyTransingTradeComp_DataGridColumn5);
            return (_local_1);
        }

        public function ___MyTransingTradeComp_DataGrid1_mouseOver(_arg_1:MouseEvent):void
        {
            overHandler(_arg_1);
            this.myPresentationTooltip.presentation = Lang.msg("你在市场中已经购买成功并正在运输的资源信息");
        }

        private function onCommandResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _MyTransingTradeComp_ClassFactory2_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = MyTransingTradeComp_inlineComponent2;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.myPresentationTooltip.moveToMouse(_arg_1);
            if (!this.myPresentationTooltip.isPopUp)
            {
                PopUpManager.addPopUp(this.myPresentationTooltip, this);
            };
        }

        private function _MyTransingTradeComp_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("交易情况");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_Label1.text = _arg_1;
            }, "_MyTransingTradeComp_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.transingTradeArray);
            }, function (_arg_1:Object):void
            {
                _MyTransingTradeComp_DataGrid1.dataProvider = _arg_1;
            }, "_MyTransingTradeComp_DataGrid1.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("资源");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn1.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn1.headerText");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("数量");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn2.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn2.headerText");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("单价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn3.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn3.headerText");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("总价");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn4.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn4.headerText");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("运输时间");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn5.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn5.headerText");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("功能加速");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MyTransingTradeComp_DataGridColumn6.headerText = _arg_1;
            }, "_MyTransingTradeComp_DataGridColumn6.headerText");
            result[7] = binding;
            return (result);
        }

        private function _MyTransingTradeComp_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("交易情况");
            _local_1 = this.transingTradeArray;
            _local_1 = Lang.msg("资源");
            _local_1 = Lang.msg("数量");
            _local_1 = Lang.msg("单价");
            _local_1 = Lang.msg("总价");
            _local_1 = Lang.msg("运输时间");
            _local_1 = Lang.msg("功能加速");
        }


    }
}//package view.module.market

