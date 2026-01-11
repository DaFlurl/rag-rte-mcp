// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.militarySituationList.MilitarySituationList_inlineComponent1

package view.module.alliance.oldAlliance.militarySituationList
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.CheckOutButton;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
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

    public class MilitarySituationList_inlineComponent1 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _88844982outerDocument:MilitarySituationList;
        public var _MilitarySituationList_inlineComponent1_CheckOutButton1:CheckOutButton;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "id":"_MilitarySituationList_inlineComponent1_CheckOutButton1",
                        "events":{"click":"___MilitarySituationList_inlineComponent1_CheckOutButton1_click"}
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MilitarySituationList_inlineComponent1()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.left = "1";
                this.right = "1";
                this.top = "4";
                this.bottom = "4";
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MilitarySituationList_inlineComponent1._watcherSetupUtil = _arg_1;
        }


        private function _MilitarySituationList_inlineComponent1_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = outerDocument.lookUpStr;
        }

        private function _MilitarySituationList_inlineComponent1_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = outerDocument.lookUpStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MilitarySituationList_inlineComponent1_CheckOutButton1.label = _arg_1;
            }, "_MilitarySituationList_inlineComponent1_CheckOutButton1.label");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():MilitarySituationList
        {
            return (this._88844982outerDocument);
        }

        override public function initialize():void
        {
            var target:MilitarySituationList_inlineComponent1;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MilitarySituationList_inlineComponent1_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_militarySituationList_MilitarySituationList_inlineComponent1WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:MilitarySituationList):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        public function ___MilitarySituationList_inlineComponent1_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            outerDocument.showWarDetail(data);
        }


    }
}//package view.module.alliance.oldAlliance.militarySituationList

