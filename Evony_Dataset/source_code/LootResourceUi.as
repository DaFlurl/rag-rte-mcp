// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.info.reports.ReportUi.LootResourceUi

package view.module.info.reports.ReportUi
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.utils.ObjectProxy;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
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

    public class LootResourceUi extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _341064690resource:ObjectProxy;
        public var _LootResourceUi_DifferentTypeUi1:DifferentTypeUi;
        public var _LootResourceUi_DifferentTypeUi2:DifferentTypeUi;
        public var _LootResourceUi_DifferentTypeUi3:DifferentTypeUi;
        public var _LootResourceUi_DifferentTypeUi4:DifferentTypeUi;
        public var _LootResourceUi_DifferentTypeUi5:DifferentTypeUi;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalGap = 3;
                            this.verticalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":DifferentTypeUi,
                                    "id":"_LootResourceUi_DifferentTypeUi1"
                                }), new UIComponentDescriptor({
                                    "type":DifferentTypeUi,
                                    "id":"_LootResourceUi_DifferentTypeUi2"
                                }), new UIComponentDescriptor({
                                    "type":DifferentTypeUi,
                                    "id":"_LootResourceUi_DifferentTypeUi3"
                                }), new UIComponentDescriptor({
                                    "type":DifferentTypeUi,
                                    "id":"_LootResourceUi_DifferentTypeUi4"
                                }), new UIComponentDescriptor({
                                    "type":DifferentTypeUi,
                                    "id":"_LootResourceUi_DifferentTypeUi5"
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function LootResourceUi()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            LootResourceUi._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        private function get resource():ObjectProxy
        {
            return (this._341064690resource);
        }

        private function _LootResourceUi_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = "food";
            _local_1 = this.resource.food;
            _local_1 = "wood";
            _local_1 = this.resource.wood;
            _local_1 = "stone";
            _local_1 = this.resource.stone;
            _local_1 = "iron";
            _local_1 = this.resource.iron;
            _local_1 = "gold";
            _local_1 = this.resource.gold;
        }

        override public function initialize():void
        {
            var target:LootResourceUi;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _LootResourceUi_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_info_reports_ReportUi_LootResourceUiWatcherSetupUtil");
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

        public function set resourceObj(_arg_1:ObjectProxy):void
        {
            this.resource = _arg_1;
        }

        private function _LootResourceUi_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "food";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LootResourceUi_DifferentTypeUi1.resourceSrc = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi1.resourceSrc");
            result[0] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.resource.food);
            }, function (_arg_1:*):void
            {
                _LootResourceUi_DifferentTypeUi1.num = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi1.num");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "wood";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LootResourceUi_DifferentTypeUi2.resourceSrc = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi2.resourceSrc");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.resource.wood);
            }, function (_arg_1:*):void
            {
                _LootResourceUi_DifferentTypeUi2.num = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi2.num");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "stone";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LootResourceUi_DifferentTypeUi3.resourceSrc = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi3.resourceSrc");
            result[4] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.resource.stone);
            }, function (_arg_1:*):void
            {
                _LootResourceUi_DifferentTypeUi3.num = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi3.num");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "iron";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LootResourceUi_DifferentTypeUi4.resourceSrc = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi4.resourceSrc");
            result[6] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.resource.iron);
            }, function (_arg_1:*):void
            {
                _LootResourceUi_DifferentTypeUi4.num = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi4.num");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = "gold";
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _LootResourceUi_DifferentTypeUi5.resourceSrc = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi5.resourceSrc");
            result[8] = binding;
            binding = new Binding(this, function ():*
            {
                return (this.resource.gold);
            }, function (_arg_1:*):void
            {
                _LootResourceUi_DifferentTypeUi5.num = _arg_1;
            }, "_LootResourceUi_DifferentTypeUi5.num");
            result[9] = binding;
            return (result);
        }

        private function set resource(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._341064690resource;
            if (_local_2 !== _arg_1)
            {
                this._341064690resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resource", _local_2, _arg_1));
            };
        }


    }
}//package view.module.info.reports.ReportUi

