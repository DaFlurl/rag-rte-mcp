// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel_inlineComponent0

package autoevony.gui
{
    import mx.containers.HBox;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class CityPanel_inlineComponent0 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1589444121_abandonValleyBtn:Button;
        private var lastTime:Number = 0;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_abandonValleyBtn",
                        "events":{"click":"___abandonValleyBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Abandon",
                                "styleName":"REwinBtn"
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CityPanel_inlineComponent0()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.horizontalGap = 0;
                this.verticalGap = 0;
                this.paddingLeft = 3;
                this.paddingRight = 0;
                this.paddingTop = 0;
                this.paddingBottom = 0;
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CityPanel_inlineComponent0._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get _abandonValleyBtn():Button
        {
            return (this._1589444121_abandonValleyBtn);
        }

        private function _CityPanel_inlineComponent0_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return ((data.col4 == "colony") && (data.col5 == ""));
            }, function (_arg_1:Boolean):void
            {
                _abandonValleyBtn.visible = _arg_1;
            }, "_abandonValleyBtn.visible");
            result[0] = binding;
            return (result);
        }

        private function btnClickAbandonColony(_arg_1:int):void
        {
            var _local_2:Number = new Date().getTime();
            if (_local_2 < (this.lastTime + 3000))
            {
                return;
            };
            this.lastTime = _local_2;
            parentDocument._onAbandonColonyBtn(_arg_1);
        }

        private function _CityPanel_inlineComponent0_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((data.col4 == "colony") && (data.col5 == ""));
        }

        override public function initialize():void
        {
            var target:CityPanel_inlineComponent0;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._CityPanel_inlineComponent0_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanel_inlineComponent0WatcherSetupUtil");
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

        public function set _abandonValleyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1589444121_abandonValleyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1589444121_abandonValleyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_abandonValleyBtn", _local_2, _arg_1));
            };
        }

        public function ___abandonValleyBtn_click(_arg_1:MouseEvent):void
        {
            this.btnClickAbandonColony(data.col6);
        }


    }
}//package autoevony.gui

