// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.PresentationTooltip

package view.module.market
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Image;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import flash.display.Bitmap;
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

    public class PresentationTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:PresentationTooltip = new (PresentationTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _PresentationTooltip_Text1:Text;
        private var _447954662myPresentation:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.top = "10";
                            this.right = "20";
                            this.bottom = "5";
                            this.left = "5";
                            this.kerning = true;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 20;
                                        this.verticalAlign = "middle";
                                        this.kerning = true;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "events":{"complete":"___PresentationTooltip_Image1_complete"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/icon/tooltip/helpIcon.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_PresentationTooltip_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.kerning = true;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"fontp",
                                                        "maxWidth":250,
                                                        "percentWidth":70,
                                                        "minWidth":250
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PresentationTooltip()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.styleName = "triangleTooltip";
            this.percentHeight = 100;
            this.percentWidth = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PresentationTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():PresentationTooltip
        {
            return (instance);
        }


        [Bindable(event="propertyChange")]
        private function get myPresentation():String
        {
            return (this._447954662myPresentation);
        }

        public function ___PresentationTooltip_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function _PresentationTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.myPresentation;
        }

        override public function initialize():void
        {
            var target:PresentationTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PresentationTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_PresentationTooltipWatcherSetupUtil");
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

        public function set presentation(_arg_1:String):void
        {
            this.myPresentation = _arg_1;
        }

        private function set myPresentation(_arg_1:String):void
        {
            var _local_2:Object = this._447954662myPresentation;
            if (_local_2 !== _arg_1)
            {
                this._447954662myPresentation = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPresentation", _local_2, _arg_1));
            };
        }

        private function _PresentationTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.myPresentation;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PresentationTooltip_Text1.text = _arg_1;
            }, "_PresentationTooltip_Text1.text");
            result[0] = binding;
            return (result);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                Bitmap(_arg_1.currentTarget.content).smoothing = true;
            };
        }


    }
}//package view.module.market

