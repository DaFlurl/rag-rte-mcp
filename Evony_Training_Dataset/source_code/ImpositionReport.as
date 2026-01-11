// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ImpositionReport

package view.module.info.reports
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import mx.utils.ObjectProxy;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class ImpositionReport extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _ImpositionReport_TextArea1:TextArea;
        private var _1335224239detail:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"_ImpositionReport_TextArea1",
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

        public function ImpositionReport()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ImpositionReport._watcherSetupUtil = _arg_1;
        }


        public function setXmlObj(_arg_1:ObjectProxy):void
        {
            if (_arg_1.isColony)
            {
                detail = Lang.msg("征收资源报告附属城", _arg_1.suzerain, _arg_1.colony, _arg_1.food, _arg_1.lumber, _arg_1.stone, _arg_1.iron, _arg_1.gold);
            }
            else
            {
                detail = Lang.msg("征收资源报告宗主城", _arg_1.colony, _arg_1.food, _arg_1.lumber, _arg_1.stone, _arg_1.iron, _arg_1.gold);
            };
        }

        private function _ImpositionReport_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = detail;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ImpositionReport_TextArea1.text = _arg_1;
            }, "_ImpositionReport_TextArea1.text");
            result[0] = binding;
            return (result);
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

        override public function initialize():void
        {
            var target:ImpositionReport;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ImpositionReport_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ImpositionReportWatcherSetupUtil");
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

        private function _ImpositionReport_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = detail;
        }


    }
}//package view.module.info.reports

