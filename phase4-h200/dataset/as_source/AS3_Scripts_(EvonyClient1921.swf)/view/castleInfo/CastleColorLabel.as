// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleInfo.CastleColorLabel

package view.castleInfo
{
    import mx.controls.Label;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.formatters.NumberFormatter;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.mx_internal;
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

    public class CastleColorLabel extends Label implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1498008421myStyle:String;
        private var kind:int;

        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};


        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleColorLabel._watcherSetupUtil = _arg_1;
        }


        public function set myText(_arg_1:Number):void
        {
            _arg_1 = Math.floor(_arg_1);
            var _local_2:NumberFormatter = new NumberFormatter();
            _local_2.useThousandsSeparator = true;
            this.text = _local_2.format(_arg_1);
            if (_arg_1 > 0)
            {
                if (kind == 1)
                {
                    this.myStyle = "tabContent2";
                }
                else
                {
                    this.myStyle = "tabContent1";
                };
            }
            else
            {
                this.myStyle = "tabContent3";
            };
        }

        [Bindable(event="propertyChange")]
        private function get myStyle():String
        {
            return (this._1498008421myStyle);
        }

        override public function initialize():void
        {
            var target:CastleColorLabel;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _CastleColorLabel_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleInfo_CastleColorLabelWatcherSetupUtil");
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

        private function set myStyle(_arg_1:String):void
        {
            var _local_2:Object = this._1498008421myStyle;
            if (_local_2 !== _arg_1)
            {
                this._1498008421myStyle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myStyle", _local_2, _arg_1));
            };
        }

        public function set _type(_arg_1:int):void
        {
            this.kind = _arg_1;
        }

        private function _CastleColorLabel_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (myStyle);
            }, function (_arg_1:Object):void
            {
                this.styleName = _arg_1;
            }, "this.styleName");
            result[0] = binding;
            return (result);
        }

        private function _CastleColorLabel_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = myStyle;
        }


    }
}//package view.castleInfo

