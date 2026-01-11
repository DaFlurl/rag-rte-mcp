// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HerosMansion_inlineComponent8

package view.module.herosMansion
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.office.CheckOutButton;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.common.constants.HeroConstants;
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

    public class HerosMansion_inlineComponent8 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _HerosMansion_inlineComponent8_CheckOutButton1:CheckOutButton;
        private var _88844982outerDocument:HerosMansion;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":CheckOutButton,
                        "id":"_HerosMansion_inlineComponent8_CheckOutButton1",
                        "events":{"click":"___HerosMansion_inlineComponent8_CheckOutButton1_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
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

        public function HerosMansion_inlineComponent8()
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
                this.top = "1";
                this.bottom = "1";
                this.horizontalAlign = "center";
                this.verticalAlign = "middle";
            };
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HerosMansion_inlineComponent8._watcherSetupUtil = _arg_1;
        }


        public function ___HerosMansion_inlineComponent8_CheckOutButton1_click(_arg_1:MouseEvent):void
        {
            parentDocument.heroCallBack(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get outerDocument():HerosMansion
        {
            return (this._88844982outerDocument);
        }

        private function _HerosMansion_inlineComponent8_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = parentDocument.backStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_inlineComponent8_CheckOutButton1.label = _arg_1;
            }, "_HerosMansion_inlineComponent8_CheckOutButton1.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((data.status == HeroConstants.HERO_SEND_STATU) ? true : (((false) || (data.status == HeroConstants.HERO_GUARD_STATU)) ? true : false));
            }, function (_arg_1:Boolean):void
            {
                _HerosMansion_inlineComponent8_CheckOutButton1.enabled = _arg_1;
            }, "_HerosMansion_inlineComponent8_CheckOutButton1.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (data);
            }, function (_arg_1:Object):void
            {
                _HerosMansion_inlineComponent8_CheckOutButton1.data = _arg_1;
            }, "_HerosMansion_inlineComponent8_CheckOutButton1.data");
            result[2] = binding;
            return (result);
        }

        public function set outerDocument(_arg_1:HerosMansion):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _HerosMansion_inlineComponent8_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = parentDocument.backStr;
            _local_1 = ((data.status == HeroConstants.HERO_SEND_STATU) ? true : (((false) || (data.status == HeroConstants.HERO_GUARD_STATU)) ? true : false));
            _local_1 = data;
        }

        override public function initialize():void
        {
            var target:HerosMansion_inlineComponent8;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HerosMansion_inlineComponent8_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_HerosMansion_inlineComponent8WatcherSetupUtil");
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
}//package view.module.herosMansion

