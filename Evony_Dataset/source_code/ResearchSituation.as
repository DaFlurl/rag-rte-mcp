// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.ResearchSituation

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.controls.Label;
    import flash.utils.Timer;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.display.Bitmap;
    import flash.events.Event;
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

    public class ResearchSituation extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var time:Number = 0;
        private var _1161124207doneTime:int;
        private var _1616474266techBean:AvailableResearchListBean;
        private var _155830162situationTxt:Label;
        public var callBack:Function;
        private var _615271122doneTimePer:int;
        private var myTimer:Timer;
        private var _1710738130techEndTime:Number;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Label,
                        "id":"situationTxt",
                        "stylesFactory":function ():void
                        {
                            this.right = "0";
                            this.top = "0";
                            this.textAlign = "right";
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ResearchSituation()
        {
            mx_internal::_document = this;
        }

        public static function secondToString(_arg_1:int):String
        {
            var _local_2:* = "";
            var _local_3:int = int((_arg_1 / ((24 * 60) * 60)));
            if (_local_3 > 0)
            {
                _local_2 = (_local_2 + (_local_3 + "D "));
            };
            var _local_4:int = int(((_arg_1 / (60 * 60)) % 24));
            if (((_local_2.length > 0) || (_local_4 > 0)))
            {
                _local_2 = (_local_2 + (_local_4 + "H "));
            };
            var _local_5:int = int(((_arg_1 / 60) % 60));
            if (((_local_2.length > 0) || (_local_5 > 0)))
            {
                _local_2 = (_local_2 + (_local_5 + "M "));
            };
            var _local_6:int = (_arg_1 % 60);
            if (_local_6 < 10)
            {
                _local_2 = (_local_2 + "0");
            };
            return (_local_2 + (_local_6 + "S"));
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ResearchSituation._watcherSetupUtil = _arg_1;
        }


        private function set doneTime(_arg_1:int):void
        {
            var _local_2:Object = this._1161124207doneTime;
            if (_local_2 !== _arg_1)
            {
                this._1161124207doneTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doneTime", _local_2, _arg_1));
            };
        }

        private function timerHandler(_arg_1:TimerEvent=null):Boolean
        {
            var _local_2:Number;
            var _local_3:int;
            var _local_4:int;
            if (techBean != null)
            {
                _local_2 = new Date().valueOf();
                _local_3 = Context.getInstance().getTimeDiff();
                _local_4 = int((((time + _local_3) - _local_2) / 1000));
                doneTime = _local_4;
                if (_local_4 > 0)
                {
                    doneTimePer = Math.round(((1 - ((_local_4 * 1000) / (techEndTime - this.techBean.startTime))) * 100));
                    return (true);
                };
                doneTimePer = 100;
                trace((((this.className + "remain=") + _local_4) + " timer stop."));
                if (((!(this.callBack == null)) && (this.myTimer.running)))
                {
                    this.callBack.apply(this);
                };
                this.myTimer.stop();
                return (false);
            };
            doneTimePer = 100;
            trace((((this.className + "remain=") + _local_4) + " timer stop."));
            this.situationTxt.text = "";
            if (((!(this.callBack == null)) && (this.myTimer.running)))
            {
                this.callBack.apply(this);
            };
            this.myTimer.stop();
            return (false);
        }

        private function set techEndTime(_arg_1:Number):void
        {
            var _local_2:Object = this._1710738130techEndTime;
            if (_local_2 !== _arg_1)
            {
                this._1710738130techEndTime = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techEndTime", _local_2, _arg_1));
            };
        }

        private function set doneTimePer(_arg_1:int):void
        {
            var _local_2:Object = this._615271122doneTimePer;
            if (_local_2 !== _arg_1)
            {
                this._615271122doneTimePer = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doneTimePer", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:ResearchSituation;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ResearchSituation_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_ResearchSituationWatcherSetupUtil");
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
        public function get situationTxt():Label
        {
            return (this._155830162situationTxt);
        }

        private function set techBean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._1616474266techBean;
            if (_local_2 !== _arg_1)
            {
                this._1616474266techBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techBean", _local_2, _arg_1));
            };
        }

        private function _ResearchSituation_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (this.doneTimePer + "%");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                situationTxt.text = _arg_1;
            }, "situationTxt.text");
            result[0] = binding;
            return (result);
        }

        private function remainTime(_arg_1:Number):void
        {
            this.time = _arg_1;
            if (((!(isNaN(_arg_1))) && (time > 0)))
            {
                if (myTimer == null)
                {
                    myTimer = new Timer(1000, 0);
                    myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
                };
                if (this.timerHandler())
                {
                    this.myTimer.start();
                };
            };
        }

        public function set myTechBean(_arg_1:AvailableResearchListBean):void
        {
            this.techBean = _arg_1;
            this.techEndTime = this.techBean.endTime;
            remainTime(this.techBean.endTime);
        }

        [Bindable(event="propertyChange")]
        private function get techBean():AvailableResearchListBean
        {
            return (this._1616474266techBean);
        }

        [Bindable(event="propertyChange")]
        private function get techEndTime():Number
        {
            return (this._1710738130techEndTime);
        }

        public function set situationTxt(_arg_1:Label):void
        {
            var _local_2:Object = this._155830162situationTxt;
            if (_local_2 !== _arg_1)
            {
                this._155830162situationTxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "situationTxt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get doneTime():int
        {
            return (this._1161124207doneTime);
        }

        private function _ResearchSituation_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (this.doneTimePer + "%");
        }

        [Bindable(event="propertyChange")]
        private function get doneTimePer():int
        {
            return (this._615271122doneTimePer);
        }

        private function onLoadComplete(_arg_1:Event):void
        {
            if (_arg_1.currentTarget.content != null)
            {
                Bitmap(_arg_1.currentTarget.content).smoothing = true;
            };
        }


    }
}//package view.castleList

