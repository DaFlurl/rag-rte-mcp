// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.SpaceTooltip

package view.castle.building
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.Lang;
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

    public class SpaceTooltip extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _SpaceTooltip_Label1:Label;
        private var _2061761356isInner:Boolean = true;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":32,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.paddingTop = 5;
                            this.paddingBottom = 5;
                            this.paddingLeft = 8;
                            this.paddingRight = 8;
                            this.verticalAlign = "middle";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_SpaceTooltip_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.right = "10";
                                        this.textAlign = "center";
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "0";
                                        this.kerning = true;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"contentheader1"});
                                    }
                                })]});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SpaceTooltip()
        {
            mx_internal::_document = this;
            this.height = 32;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SpaceTooltip._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get isInner():Boolean
        {
            return (this._2061761356isInner);
        }

        private function _SpaceTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((isInner) ? Lang.msg("建筑工地") : Lang.msg("资源田"));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SpaceTooltip_Label1.text = _arg_1;
            }, "_SpaceTooltip_Label1.text");
            result[0] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:SpaceTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SpaceTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_building_SpaceTooltipWatcherSetupUtil");
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

        private function _SpaceTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((isInner) ? Lang.msg("建筑工地") : Lang.msg("资源田"));
        }

        public function set isInner(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2061761356isInner;
            if (_local_2 !== _arg_1)
            {
                this._2061761356isInner = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isInner", _local_2, _arg_1));
            };
        }


    }
}//package view.castle.building

