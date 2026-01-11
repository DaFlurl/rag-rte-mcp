// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.FormatRanking_inlineComponent0

package autoevony.gui.info
{
    import mx.controls.Label;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import autoevony.common.Utils;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.mx_internal;
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

    public class FormatRanking_inlineComponent0 extends Label implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};


        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FormatRanking_inlineComponent0._watcherSetupUtil = _arg_1;
        }


        private function _FormatRanking_inlineComponent0_bindingExprs():void
        {
            var _local_1:*;
            this.text = (" " + Utils.formatInt(data.ranking));
        }

        override public function initialize():void
        {
            var target:FormatRanking_inlineComponent0;
            var watcherSetupUtilClass:Object;
            var bindings:Array = this._FormatRanking_inlineComponent0_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_FormatRanking_inlineComponent0WatcherSetupUtil");
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

        private function _FormatRanking_inlineComponent0_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():*
            {
                return (" " + Utils.formatInt(data.ranking));
            }, function (_arg_1:*):void
            {
                this.text = _arg_1;
            }, "this.text");
            result[0] = binding;
            return (result);
        }


    }
}//package autoevony.gui.info

