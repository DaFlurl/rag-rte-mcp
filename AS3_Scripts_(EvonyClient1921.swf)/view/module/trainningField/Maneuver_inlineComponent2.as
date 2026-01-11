// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.trainningField.Maneuver_inlineComponent2

package view.module.trainningField
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.events.Event;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class Maneuver_inlineComponent2 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2141874742attachAmountText:TextInput;
        private var _88844982outerDocument:Maneuver;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":TextInput,
                        "id":"attachAmountText",
                        "events":{"change":"__attachAmountText_change"},
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.borderThickness = 0.5;
                            this.borderStyle = "solid";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":98,
                                "height":20,
                                "restrict":"0-9",
                                "maxChars":7
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function Maneuver_inlineComponent2()
        {
            mx_internal::_document = this;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Maneuver_inlineComponent2._watcherSetupUtil = _arg_1;
        }


        private function _Maneuver_inlineComponent2_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.fightAmount;
        }

        public function __attachAmountText_change(_arg_1:Event):void
        {
            data.fightAmount = attachAmountText.text;
        }

        public function set attachAmountText(_arg_1:TextInput):void
        {
            var _local_2:Object = this._2141874742attachAmountText;
            if (_local_2 !== _arg_1)
            {
                this._2141874742attachAmountText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attachAmountText", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():Maneuver
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:Maneuver_inlineComponent2;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Maneuver_inlineComponent2_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_trainningField_Maneuver_inlineComponent2WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:Maneuver):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _Maneuver_inlineComponent2_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.fightAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                attachAmountText.text = _arg_1;
            }, "attachAmountText.text");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get attachAmountText():TextInput
        {
            return (this._2141874742attachAmountText);
        }


    }
}//package view.module.trainningField

