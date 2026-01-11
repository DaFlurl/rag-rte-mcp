// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.market.SpeedUpBtn

package view.module.market
{
    import mx.controls.Button;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.events.PropertyChangeEvent;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import mx.core.mx_internal;
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

    public class SpeedUpBtn extends Button implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1805312139styleType:String = "quickenUp";

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};


        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SpeedUpBtn._watcherSetupUtil = _arg_1;
        }


        private function set styleType(_arg_1:String):void
        {
            var _local_2:Object = this._1805312139styleType;
            if (_local_2 !== _arg_1)
            {
                this._1805312139styleType = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "styleType", _local_2, _arg_1));
            };
        }

        private function _SpeedUpBtn_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.styleType);
            }, function (_arg_1:Object):void
            {
                this.styleName = _arg_1;
            }, "this.styleName");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get styleType():String
        {
            return (this._1805312139styleType);
        }

        override public function initialize():void
        {
            var target:SpeedUpBtn;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _SpeedUpBtn_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_market_SpeedUpBtnWatcherSetupUtil");
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

        private function _SpeedUpBtn_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.styleType;
        }


    }
}//package view.module.market

