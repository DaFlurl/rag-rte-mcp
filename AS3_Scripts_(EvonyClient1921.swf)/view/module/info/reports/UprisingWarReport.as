// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.UprisingWarReport

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import mx.utils.ObjectProxy;
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

    public class UprisingWarReport extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1596093966uprisingTime:String;
        private var _1335224239detail:String;
        public var _UprisingWarReport_TextArea1:TextArea;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_UprisingWarReport_TextArea1",
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.textAlign = "left";
                            this.borderStyle = "none";
                            this.backgroundColor = 0xFFFFFF;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":33,
                                "editable":false,
                                "percentWidth":100,
                                "percentHeight":100
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function UprisingWarReport()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            UprisingWarReport._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get uprisingTime():String
        {
            return (this._1596093966uprisingTime);
        }

        override public function initialize():void
        {
            var target:UprisingWarReport;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _UprisingWarReport_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_UprisingWarReportWatcherSetupUtil");
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
        private function get detail():String
        {
            return (this._1335224239detail);
        }

        private function _UprisingWarReport_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = detail;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _UprisingWarReport_TextArea1.text = _arg_1;
            }, "_UprisingWarReport_TextArea1.text");
            result[0] = binding;
            return (result);
        }

        private function set uprisingTime(_arg_1:String):void
        {
            var _local_2:Object = this._1596093966uprisingTime;
            if (_local_2 !== _arg_1)
            {
                this._1596093966uprisingTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uprisingTime", _local_2, _arg_1));
            };
        }

        public function setXmlObj(_arg_1:ObjectProxy, _arg_2:String, _arg_3:String):void
        {
            uprisingTime = Lang.msg("起义战争时间", _arg_1.startTime, _arg_1.endTime);
            if (_arg_1.isColony)
            {
                detail = Lang.msg("附属起义报告描述", _arg_2, _arg_3, uprisingTime);
            }
            else
            {
                detail = Lang.msg("宗主起义报告描述", _arg_2, uprisingTime);
            };
        }

        private function set detail(_arg_1:String):void
        {
            var _local_2:Object = this._1335224239detail;
            if (_local_2 !== _arg_1)
            {
                this._1335224239detail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "detail", _local_2, _arg_1));
            };
        }

        private function _UprisingWarReport_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = detail;
        }


    }
}//package view.module.info.reports

