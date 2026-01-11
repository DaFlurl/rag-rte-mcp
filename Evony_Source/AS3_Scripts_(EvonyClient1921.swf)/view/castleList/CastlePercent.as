// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.CastlePercent

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.Label;
    import view.ui.TimeUITip;
    import flash.display.Sprite;
    import flash.utils.Timer;
    import com.evony.common.beans.ArmyBean;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.factory.UIFactory;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import mx.core.UIComponent;
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

    public class CastlePercent extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var needTime:Number;
        private var _1421682026cityName:Button;
        private var _1237451866cityPercent:Label;
        private var timeUiTip:TimeUITip;
        private var square:Sprite;
        private var _991730002perent:String;
        private var cTimer:Timer;
        private var buildTime:Number;
        private var _armBean:ArmyBean;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":61,
                    "height":36,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"cityName",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":0,
                                "width":61,
                                "height":36,
                                "styleName":"castleBtn"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"cityPercent",
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.verticalCenter = "0";
                            this.fontWeight = "bold";
                            this.color = 0xFFFFFF;
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"width":70});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastlePercent()
        {
            mx_internal::_document = this;
            this.width = 61;
            this.height = 36;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___CastlePercent_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastlePercent._watcherSetupUtil = _arg_1;
        }


        public function set cityName(_arg_1:Button):void
        {
            var _local_2:Object = this._1421682026cityName;
            if (_local_2 !== _arg_1)
            {
                this._1421682026cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityName", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get cityPercent():Label
        {
            return (this._1237451866cityPercent);
        }

        public function set cityPercent(_arg_1:Label):void
        {
            var _local_2:Object = this._1237451866cityPercent;
            if (_local_2 !== _arg_1)
            {
                this._1237451866cityPercent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityPercent", _local_2, _arg_1));
            };
        }

        private function timerHandler(_arg_1:TimerEvent=null):void
        {
            var _local_2:Number = new Date().valueOf();
            this.buildTime = (((this._armBean.reachTime + Context.getInstance().getTimeDiff()) - _local_2) / 1000);
            this.perent = (String(Math.round((((this.needTime - this.buildTime) / this.needTime) * 100))) + "%");
            this.square.height = ((this.buildTime / this.needTime) * 36);
            this.square.y = (36 - this.square.height);
            if (this.buildTime <= 0)
            {
                this.visible = false;
                this.timerStop();
            };
            if (this.timeUiTip != null)
            {
                this.timeUiTip.time = this.buildTime;
            };
        }

        override public function initialize():void
        {
            var target:CastlePercent;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastlePercent_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_CastlePercentWatcherSetupUtil");
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

        private function overHandler(_arg_1:MouseEvent):void
        {
            this.timeUiTip = UIFactory.getInstance().getTimeUITip();
            this.timeUiTip.moveToMouse(_arg_1);
            if (!this.timeUiTip.isPopUp)
            {
                PopUpManager.addPopUp(this.timeUiTip, this);
            }
            else
            {
                PopUpManager.bringToFront(this.timeUiTip);
            };
        }

        private function refresh():void
        {
            if (this.cTimer == null)
            {
                this.cTimer = new Timer(1000, 0);
                this.cTimer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
            }
            else
            {
                if (this.cTimer.running)
                {
                    this.cTimer.stop();
                };
            };
            this.cTimer.start();
        }

        private function init():void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, overHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, outHnadler);
            this.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
            this.addChild(this.getSprite());
            this.setChildIndex(this.cityPercent, 2);
            this.refresh();
        }

        public function set bean(_arg_1:ArmyBean):void
        {
            this._armBean = _arg_1;
            var _local_2:Number = new Date().valueOf();
            var _local_3:Number = Context.getInstance().getTimeDiff();
            this.buildTime = (((this._armBean.reachTime - this._armBean.startTime) - ((_local_2 - this._armBean.startTime) - _local_3)) / 1000);
            this.needTime = ((this._armBean.reachTime - this._armBean.startTime) / 1000);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function set perent(_arg_1:String):void
        {
            var _local_2:Object = this._991730002perent;
            if (_local_2 !== _arg_1)
            {
                this._991730002perent = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "perent", _local_2, _arg_1));
            };
        }

        private function _CastlePercent_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.perent;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityPercent.text = _arg_1;
            }, "cityPercent.text");
            result[0] = binding;
            return (result);
        }

        public function timerStop():void
        {
            if (this.cTimer != null)
            {
                this.cTimer.stop();
                this.cTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
            };
        }

        private function outHnadler(_arg_1:MouseEvent):void
        {
            if (this.timeUiTip != null)
            {
                PopUpManager.removePopUp(this.timeUiTip);
            };
        }

        public function ___CastlePercent_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function _CastlePercent_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.perent;
        }

        [Bindable(event="propertyChange")]
        private function get perent():String
        {
            return (this._991730002perent);
        }

        [Bindable(event="propertyChange")]
        public function get cityName():Button
        {
            return (this._1421682026cityName);
        }

        private function moveHandler(_arg_1:MouseEvent):void
        {
            if (this.timeUiTip != null)
            {
                this.timeUiTip.moveToMouse(_arg_1);
            };
        }

        private function getSprite():UIComponent
        {
            var _local_1:UIComponent = new UIComponent();
            var _local_2:Sprite = new Sprite();
            _local_2.graphics.beginFill(0);
            _local_2.graphics.drawRect(3, 3, 61, 36);
            _local_2.alpha = 0.6;
            this.square = _local_2;
            _local_1.addChild(_local_2);
            return (_local_1);
        }


    }
}//package view.castleList

