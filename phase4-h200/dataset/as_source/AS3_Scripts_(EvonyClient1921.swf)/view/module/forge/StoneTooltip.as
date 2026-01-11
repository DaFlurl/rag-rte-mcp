// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.forge.StoneTooltip

package view.module.forge
{
    import view.ui.BaseTooltip;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Label;
    import com.evony.eum.ItemEum;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
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

    public class StoneTooltip extends BaseTooltip implements IBindingClient 
    {

        private static var instance:StoneTooltip = new (StoneTooltip)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1003243718textarea:Text;
        private var _119856678treasureName:Label;
        private var _179437675_itemEum:ItemEum;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.right = "5";
                            this.top = "5";
                            this.bottom = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"treasureName",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":50,
                                            "styleName":"contentheader1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"textarea",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "percentWidth":100
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

        public function StoneTooltip()
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
            this.styleName = "tooltips";
            this.percentHeight = 100;
            this.minWidth = 200;
            this.percentWidth = 100;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            StoneTooltip._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():StoneTooltip
        {
            return (instance);
        }


        public function set treasureName(_arg_1:Label):void
        {
            var _local_2:Object = this._119856678treasureName;
            if (_local_2 !== _arg_1)
            {
                this._119856678treasureName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "treasureName", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:StoneTooltip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _StoneTooltip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_forge_StoneTooltipWatcherSetupUtil");
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

        [Bindable(event="propertyChange")]
        public function get treasureName():Label
        {
            return (this._119856678treasureName);
        }

        public function set itemEum(_arg_1:ItemEum):void
        {
            this._itemEum = _arg_1;
        }

        private function set _itemEum(_arg_1:ItemEum):void
        {
            var _local_2:Object = this._179437675_itemEum;
            if (_local_2 !== _arg_1)
            {
                this._179437675_itemEum = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_itemEum", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _itemEum():ItemEum
        {
            return (this._179437675_itemEum);
        }

        private function _StoneTooltip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._itemEum.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                treasureName.text = _arg_1;
            }, "treasureName.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this._itemEum.desc;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                textarea.text = _arg_1;
            }, "textarea.text");
            result[1] = binding;
            return (result);
        }

        public function set textarea(_arg_1:Text):void
        {
            var _local_2:Object = this._1003243718textarea;
            if (_local_2 !== _arg_1)
            {
                this._1003243718textarea = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textarea", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get textarea():Text
        {
            return (this._1003243718textarea);
        }

        private function _StoneTooltip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this._itemEum.name;
            _local_1 = this._itemEum.desc;
        }


    }
}//package view.module.forge

