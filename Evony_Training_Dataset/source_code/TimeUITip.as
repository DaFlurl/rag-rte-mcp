// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.TimeUITip

package view.ui
{
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import com.evony.util.UIUtil;
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

    public class TimeUITip extends BaseTooltip implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TimeUITip_Label1:Label;
        private var _91294636_time:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseTooltip,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"_TimeUITip_Label1",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"contentheader1",
                                "width":200
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function TimeUITip()
        {
            mx_internal::_document = this;
            this.styleName = "tooltips";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TimeUITip._watcherSetupUtil = _arg_1;
        }


        private function _TimeUITip_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((Lang.msg("剩余时间") + ": ") + this._time);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TimeUITip_Label1.text = _arg_1;
            }, "_TimeUITip_Label1.text");
            result[0] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        private function get _time():String
        {
            return (this._91294636_time);
        }

        override public function initialize():void
        {
            var target:TimeUITip;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TimeUITip_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_TimeUITipWatcherSetupUtil");
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

        public function set time(_arg_1:Number):void
        {
            this._time = UIUtil.timeToString(_arg_1);
        }

        private function _TimeUITip_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = ((Lang.msg("剩余时间") + ": ") + this._time);
        }

        private function set _time(_arg_1:String):void
        {
            var _local_2:Object = this._91294636_time;
            if (_local_2 !== _arg_1)
            {
                this._91294636_time = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_time", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

