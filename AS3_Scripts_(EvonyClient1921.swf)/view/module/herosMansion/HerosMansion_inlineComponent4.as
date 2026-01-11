// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HerosMansion_inlineComponent4

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
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

    public class HerosMansion_inlineComponent4 extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _HerosMansion_inlineComponent4_Label1:Label;
        private var _88844982outerDocument:HerosMansion;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_HerosMansion_inlineComponent4_Label1",
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tableContent2",
                                "percentWidth":100
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function HerosMansion_inlineComponent4()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HerosMansion_inlineComponent4._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get outerDocument():HerosMansion
        {
            return (this._88844982outerDocument);
        }

        private function _HerosMansion_inlineComponent4_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():uint
            {
                return ((data.isHero >= parentDocument.isKingOrQueen) ? 0xFDF000 : 0xFFFFFF);
            }, function (_arg_1:uint):void
            {
                this.setStyle("backgroundColor", _arg_1);
            }, "this.backgroundColor");
            result[0] = binding;
            binding = new Binding(this, function ():Number
            {
                return ((data.isHero == parentDocument.isKingOrQueen) ? 1 : 0);
            }, function (_arg_1:Number):void
            {
                this.setStyle("backgroundAlpha", _arg_1);
            }, "this.backgroundAlpha");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((data.powerBuffAdded == 0) ? String((data.power + data.attack)) : String((((data.power + data.attack) + ((data.powerBuffAdded > 0) ? "+" : "")) + Math.round(((data.power * data.powerBuffAdded) / 100)))));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HerosMansion_inlineComponent4_Label1.text = _arg_1;
            }, "_HerosMansion_inlineComponent4_Label1.text");
            result[2] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:HerosMansion_inlineComponent4;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HerosMansion_inlineComponent4_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_HerosMansion_inlineComponent4WatcherSetupUtil");
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

        public function set outerDocument(_arg_1:HerosMansion):void
        {
            var _local_2:Object = this._88844982outerDocument;
            if (_local_2 !== _arg_1)
            {
                this._88844982outerDocument = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outerDocument", _local_2, _arg_1));
            };
        }

        private function _HerosMansion_inlineComponent4_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((data.isHero >= parentDocument.isKingOrQueen) ? 0xFDF000 : 0xFFFFFF);
            _local_1 = ((data.isHero == parentDocument.isKingOrQueen) ? 1 : 0);
            _local_1 = ((data.powerBuffAdded == 0) ? String((data.power + data.attack)) : String((((data.power + data.attack) + ((data.powerBuffAdded > 0) ? "+" : "")) + Math.round(((data.power * data.powerBuffAdded) / 100)))));
        }


    }
}//package view.module.herosMansion

