// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.help_inlineComponent1

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
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

    public class help_inlineComponent1 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _help_inlineComponent1_Label1:Label;
        private var _88844982outerDocument:help;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_help_inlineComponent1_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function help_inlineComponent1()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            help_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        private function _help_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.label;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _help_inlineComponent1_Label1.text = _arg_1;
            }, "_help_inlineComponent1_Label1.text");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():help
        {
            return (this._88844982outerDocument);
        }

        private function _help_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.label;
        }

        public function set outerDocument(_arg_1:help):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:help_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _help_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_help_inlineComponent1WatcherSetupUtil");
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
}//package view.ui

