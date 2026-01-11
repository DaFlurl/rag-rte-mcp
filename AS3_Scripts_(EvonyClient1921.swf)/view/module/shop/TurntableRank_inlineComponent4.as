// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.shop.TurntableRank_inlineComponent4

package view.module.shop
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
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

    public class TurntableRank_inlineComponent4 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TurntableRank_inlineComponent4_Image1:Image;
        private var _88844982outerDocument:TurntableRank;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_TurntableRank_inlineComponent4_Image1",
                        "events":{"creationComplete":"___TurntableRank_inlineComponent4_Image1_creationComplete"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":16,
                                "height":16
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TurntableRank_inlineComponent4()
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
                this.left = "5";
            };
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TurntableRank_inlineComponent4._watcherSetupUtil = _arg_1;
        }


        private function _TurntableRank_inlineComponent4_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (outerDocument.getIcon1(data.itemsBeansArray[0].id));
            }, function (_arg_1:Object):void
            {
                _TurntableRank_inlineComponent4_Image1.source = _arg_1;
            }, "_TurntableRank_inlineComponent4_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = outerDocument.getDesc(data.itemsBeansArray[0].id);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TurntableRank_inlineComponent4_Image1.toolTip = _arg_1;
            }, "_TurntableRank_inlineComponent4_Image1.toolTip");
            result[1] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():TurntableRank
        {
            return (this._88844982outerDocument);
        }

        private function _TurntableRank_inlineComponent4_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = outerDocument.getIcon1(data.itemsBeansArray[0].id);
            _local_1 = outerDocument.getDesc(data.itemsBeansArray[0].id);
        }

        override public function initialize():void
        {
            var target:TurntableRank_inlineComponent4;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TurntableRank_inlineComponent4_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_shop_TurntableRank_inlineComponent4WatcherSetupUtil");
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

        public function ___TurntableRank_inlineComponent4_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            outerDocument.onCreationComplete(_arg_1);
        }

        public function set outerDocument(_arg_1:TurntableRank):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }


    }
}//package view.module.shop

