// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.office.ColonizeActionBtn

package view.module.office
{
    import mx.controls.Button;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.ColonyBean;
    import flash.utils.Timer;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.core.mx_internal;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import com.evony.common.constants.ColonyConstants;
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

    public class ColonizeActionBtn extends Button implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _678927291percent:Number = 0.001;
        private var _953891597spaceTime:Number;
        private var _493364297typeColor:Number = 0;
        private var _853101417typeStr:String = "";
        private var nowTime:Number;
        private var _2008969879_colonyBean:ColonyBean;
        private var _982634288tooltips:String;

        private var _676654381typeIcon:Object = {};
        private var _858803508typePb:Object = {};
        private var timeCount:Timer = new Timer(1000);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ColonizeActionBtn()
        {
            this.styleName = "y165";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ColonizeActionBtn._watcherSetupUtil = _arg_1;
        }


        private function secondToString(_arg_1:Number):String
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_2:* = "";
            if (_arg_1 >= 0)
            {
                _local_3 = int((_arg_1 / (60 * 60)));
                if (_local_3 > 0)
                {
                    _local_2 = (_local_2 + ((_local_3 + Lang.msg("时")) + " "));
                };
                _local_4 = int(((_arg_1 / 60) % 60));
                if (((_local_2.length > 0) || (_local_4 > 0)))
                {
                    _local_2 = (_local_2 + ((_local_4 + Lang.msg("分")) + " "));
                };
                if (_local_3 == 0)
                {
                    _local_5 = (_arg_1 % 60);
                    if (_local_5 < 10)
                    {
                        _local_2 = (_local_2 + "0");
                    };
                    _local_2 = (_local_2 + (_local_5 + Lang.msg("秒")));
                };
            };
            return (_local_2);
        }

        private function set percent(_arg_1:Number):void
        {
            var _local_2:Object = this._678927291percent;
            if (_local_2 !== _arg_1)
            {
                this._678927291percent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "percent", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ColonizeActionBtn;
            var watcherSetupUtilClass:Object;
            var bindings:Array = _ColonizeActionBtn_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_office_ColonizeActionBtnWatcherSetupUtil");
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

        private function set typeColor(_arg_1:Number):void
        {
            var _local_2:Object = this._493364297typeColor;
            if (_local_2 !== _arg_1)
            {
                this._493364297typeColor = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeColor", _local_2, _arg_1));
            };
        }

        private function set typePb(_arg_1:Object):void
        {
            var _local_2:Object = this._858803508typePb;
            if (_local_2 !== _arg_1)
            {
                this._858803508typePb = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typePb", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typeStr():String
        {
            return (this._853101417typeStr);
        }

        private function _ColonizeActionBtn_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.tooltips + secondToString((spaceTime / 1000)));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.toolTip = _arg_1;
            }, "this.toolTip");
            result[0] = binding;
            return (result);
        }

        private function onTimeCount(_arg_1:TimerEvent):void
        {
            nowTime = new Date().valueOf();
            spaceTime = ((_colonyBean.endTime + Context.getInstance().getTimeDiff()) - nowTime);
            if (_colonyBean)
            {
                percent = (((nowTime - Context.getInstance().getTimeDiff()) - _colonyBean.startTime) / (_colonyBean.endTime - _colonyBean.startTime));
            };
            if (percent >= 1)
            {
                timeCount.stop();
                percent = 1;
            };
        }

        private function set typeIcon(_arg_1:Object):void
        {
            var _local_2:Object = this._676654381typeIcon;
            if (_local_2 !== _arg_1)
            {
                this._676654381typeIcon = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeIcon", _local_2, _arg_1));
            };
        }

        private function set tooltips(_arg_1:String):void
        {
            var _local_2:Object = this._982634288tooltips;
            if (_local_2 !== _arg_1)
            {
                this._982634288tooltips = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tooltips", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            nowTime = new Date().valueOf();
            timeCount.addEventListener(TimerEvent.TIMER, onTimeCount);
            timeCount.start();
            percent = 0.001;
        }

        private function _ColonizeActionBtn_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (this.tooltips + secondToString((spaceTime / 1000)));
        }

        private function set typeStr(_arg_1:String):void
        {
            var _local_2:Object = this._853101417typeStr;
            if (_local_2 !== _arg_1)
            {
                this._853101417typeStr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeStr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get percent():Number
        {
            return (this._678927291percent);
        }

        [Bindable(event="propertyChange")]
        private function get typeColor():Number
        {
            return (this._493364297typeColor);
        }

        private function set _colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._2008969879_colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._2008969879_colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_colonyBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get typePb():Object
        {
            return (this._858803508typePb);
        }

        [Bindable(event="propertyChange")]
        private function get tooltips():String
        {
            return (this._982634288tooltips);
        }

        [Bindable(event="propertyChange")]
        private function get typeIcon():Object
        {
            return (this._676654381typeIcon);
        }

        private function set spaceTime(_arg_1:Number):void
        {
            var _local_2:Object = this._953891597spaceTime;
            if (_local_2 !== _arg_1)
            {
                this._953891597spaceTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "spaceTime", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _colonyBean():ColonyBean
        {
            return (this._2008969879_colonyBean);
        }

        public function set action(_arg_1:Object):void
        {
            if (!timeCount.running)
            {
                timeCount.start();
            };
            if (_arg_1)
            {
                _colonyBean = (_arg_1 as ColonyBean);
                if (_colonyBean.relation == ColonyConstants.COLONY_RELATION_COLONYING)
                {
                    this.label = Lang.msg("部署驻军");
                    if (((_colonyBean.status == ColonyConstants.COLONY_STATUS_ABANDON) || (_colonyBean.status == ColonyConstants.COLONY_STATUS_ATTACKING)))
                    {
                        this.enabled = false;
                    }
                    else
                    {
                        this.enabled = true;
                    };
                }
                else
                {
                    if (_colonyBean.relation == ColonyConstants.COLONY_RELATION_BEING_COLONIED)
                    {
                        this.label = Lang.msg("起义");
                        if (_colonyBean.status == ColonyConstants.COLONY_STATUS_OCCUPIED)
                        {
                            this.enabled = true;
                            this.tooltips = "";
                        }
                        else
                        {
                            init();
                            this.enabled = false;
                            this.tooltips = (("Your city is plotting for uprise , " + this._colonyBean.cityName) + "'s Army will fight the Suzerain’s Suppression Army in ");
                        };
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get spaceTime():Number
        {
            return (this._953891597spaceTime);
        }


    }
}//package view.module.office

