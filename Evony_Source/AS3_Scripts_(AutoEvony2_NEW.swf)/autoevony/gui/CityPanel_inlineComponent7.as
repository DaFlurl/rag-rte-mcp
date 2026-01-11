// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.CityPanel_inlineComponent7

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
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.events.PropertyChangeEvent;
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

    public class CityPanel_inlineComponent7 extends HBox implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var lastTime:Number = 0;
        private var _910869441_upgradeBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":HBox,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"_upgradeBtn",
                        "events":{"click":"___upgradeBtn_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Upgrade",
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

        public function CityPanel_inlineComponent7()
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
            CityPanel_inlineComponent7._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get _upgradeBtn():Button
        {
            return (this._910869441_upgradeBtn);
        }

        private function _CityPanel_inlineComponent7_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = data.col7;
            _local_1 = data.col8;
            _local_1 = data.col9;
        }

        private function _CityPanel_inlineComponent7_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (data.col7);
            }, function (_arg_1:Boolean):void
            {
                _upgradeBtn.visible = _arg_1;
            }, "_upgradeBtn.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (data.col8);
            }, function (_arg_1:Boolean):void
            {
                _upgradeBtn.enabled = _arg_1;
            }, "_upgradeBtn.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = data.col9;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _upgradeBtn.toolTip = _arg_1;
            }, "_upgradeBtn.toolTip");
            result[2] = binding;
            return (result);
        }

        private function btnClickUpgradeGear(_arg_1:int):void
        {
            var _local_2:Number = new Date().getTime();
            if (_local_2 < (this.lastTime + 3000))
            {
                return;
            };
            this.lastTime = _local_2;
            parentDocument._onGearUpgradeBtn(_arg_1);
        }

        public function ___upgradeBtn_click(_arg_1:MouseEvent):void
        {
            this.btnClickUpgradeGear(data.col6);
        }

        override public function initialize():void
        {
            var target:CityPanel_inlineComponent7;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._CityPanel_inlineComponent7_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_CityPanel_inlineComponent7WatcherSetupUtil");
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

        public function set _upgradeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._910869441_upgradeBtn;
            if (_local_2 !== _arg_1)
            {
                this._910869441_upgradeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_upgradeBtn", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui

