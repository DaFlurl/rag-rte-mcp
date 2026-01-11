// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.TradeReportDetail

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    public class TradeReportDetail extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TradeReportDetail_Text1:Text;
        public var _TradeReportDetail_Text2:Text;
        private var _109815obj:ObjectProxy;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Text,
                        "id":"_TradeReportDetail_Text1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":10,
                                "selectable":false
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Text,
                        "id":"_TradeReportDetail_Text2",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":10,
                                "y":52,
                                "height":65,
                                "width":550
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TradeReportDetail()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TradeReportDetail._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get obj():ObjectProxy
        {
            return (this._109815obj);
        }

        public function set xmlObj(_arg_1:ObjectProxy):void
        {
            this.obj = _arg_1;
        }

        private function _TradeReportDetail_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (((((((((((((Lang.msg("交易完成") + ": ") + obj.tradeType) + " ") + obj.dealedAmount) + " ") + obj.resName) + ", ") + Lang.msg("总成交价")) + ": ") + Lang.msg("黄金")) + " ") + obj.gold) + ".");
            _local_1 = Lang.msg("交易成功的资源还需要经过30分钟的运输时间后才能获得。具体请在市场中进行查看。");
        }

        private function set obj(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._109815obj;
            if (_local_2 !== _arg_1)
            {
                this._109815obj = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "obj", _local_2, _arg_1));
            };
        }

        private function _TradeReportDetail_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (((((((((((((Lang.msg("交易完成") + ": ") + obj.tradeType) + " ") + obj.dealedAmount) + " ") + obj.resName) + ", ") + Lang.msg("总成交价")) + ": ") + Lang.msg("黄金")) + " ") + obj.gold) + ".");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TradeReportDetail_Text1.text = _arg_1;
            }, "_TradeReportDetail_Text1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("交易成功的资源还需要经过30分钟的运输时间后才能获得。具体请在市场中进行查看。");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TradeReportDetail_Text2.text = _arg_1;
            }, "_TradeReportDetail_Text2.text");
            result[1] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:TradeReportDetail;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TradeReportDetail_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_TradeReportDetailWatcherSetupUtil");
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


    }
}//package view.module.info.reports

