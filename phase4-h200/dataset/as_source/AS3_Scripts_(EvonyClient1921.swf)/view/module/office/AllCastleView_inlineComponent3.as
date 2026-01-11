// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.AllCastleView_inlineComponent3

package view.module.office
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
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

    public class AllCastleView_inlineComponent3 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllCastleView_inlineComponent3_CheckOutButton1:CheckOutButton;
        private var _88844982outerDocument:AllCastleView;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":100,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "id":"_AllCastleView_inlineComponent3_CheckOutButton1",
                        "events":{"click":"___AllCastleView_inlineComponent3_CheckOutButton1_click"}
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllCastleView_inlineComponent3()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.top = "1";
                this.bottom = "1";
                this.horizontalAlign = "center";
            };
            this.width = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllCastleView_inlineComponent3._watcherSetupUtil = _arg_1;
        }


        private function _AllCastleView_inlineComponent3_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = parentDocument.trashStr;
            _local_1 = data;
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():AllCastleView
        {
            return (this._88844982outerDocument);
        }

        public function set outerDocument(_arg_1:AllCastleView):void
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
            var target:AllCastleView_inlineComponent3;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllCastleView_inlineComponent3_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_AllCastleView_inlineComponent3WatcherSetupUtil");
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

        public function ___AllCastleView_inlineComponent3_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            parentDocument.castleView(_arg_1);
        }

        private function _AllCastleView_inlineComponent3_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = parentDocument.trashStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllCastleView_inlineComponent3_CheckOutButton1.label = _arg_1;
            }, "_AllCastleView_inlineComponent3_CheckOutButton1.label");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (data);
            }, function (_arg_1:Object):void
            {
                _AllCastleView_inlineComponent3_CheckOutButton1.data = _arg_1;
            }, "_AllCastleView_inlineComponent3_CheckOutButton1.data");
            result[1] = binding;
            return (result);
        }


    }
}//package view.module.office

