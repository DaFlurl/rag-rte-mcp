// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.newAlliance.BeginAlliance_inlineComponent1

package view.module.alliance.newAlliance
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.CheckOutButton;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
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

    public class BeginAlliance_inlineComponent1 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1482247960disageeBtn:CheckOutButton;
        private var _88844982outerDocument:BeginAlliance;
        private var _1832551440agreeBtn:CheckOutButton;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "id":"agreeBtn",
                        "events":{"click":"__agreeBtn_click"}
                    }), new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "id":"disageeBtn",
                        "events":{"click":"__disageeBtn_click"}
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function BeginAlliance_inlineComponent1()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalAlign = "center";
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            BeginAlliance_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        public function set outerDocument(_arg_1:BeginAlliance):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get agreeBtn():CheckOutButton
        {
            return (this._1832551440agreeBtn);
        }

        public function __disageeBtn_click(_arg_1:MouseEvent):void
        {
            outerDocument.isAgreeClick(data, false);
        }

        private function _BeginAlliance_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = outerDocument.acceptStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                agreeBtn.label = _arg_1;
            }, "agreeBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = outerDocument.rejectStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                disageeBtn.label = _arg_1;
            }, "disageeBtn.label");
            result[1] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:BeginAlliance_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _BeginAlliance_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_newAlliance_BeginAlliance_inlineComponent1WatcherSetupUtil");
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

        public function set agreeBtn(_arg_1:CheckOutButton):void
        {
            var _local_2:Object = this._1832551440agreeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1832551440agreeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "agreeBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get disageeBtn():CheckOutButton
        {
            return (this._1482247960disageeBtn);
        }

        public function set disageeBtn(_arg_1:CheckOutButton):void
        {
            var _local_2:Object = this._1482247960disageeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1482247960disageeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disageeBtn", _local_2, _arg_1));
            };
        }

        private function _BeginAlliance_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = outerDocument.acceptStr;
            _local_1 = outerDocument.rejectStr;
        }

        public function __agreeBtn_click(_arg_1:MouseEvent):void
        {
            outerDocument.isAgreeClick(data, true);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():BeginAlliance
        {
            return (this._88844982outerDocument);
        }


    }
}//package view.module.alliance.newAlliance

