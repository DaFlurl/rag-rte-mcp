// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.MainFramePlayerBuff

package view.castle
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.BuffBean;
    import flash.utils.Timer;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.events.TimerEvent;
    import com.evony.events.ChangeSizeEvent;
    import com.evony.Context;
    import mx.collections.ArrayCollection;
    import view.ui.AmountInputUI;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.util.UIUtil;
    import flash.events.MouseEvent;
    import mx.events.FlexEvent;
    import view.module.playerInfo.StageChangeWin;
    import view.module.rank.cj;
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

    public class MainFramePlayerBuff extends Canvas implements IBindingClient 
    {

        public static var instance:MainFramePlayerBuff;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _693640971isPlayerNew:Boolean;
        private var _97299bar:PLayerBuffBar;
        private var _1293938601truceBean:BuffBean;
        private var myTimer_peace:Timer;
        private var _496366315peacebeans:BuffBean;
        private var isCallBack:Boolean = false;
        private var _93610691beans:BuffBean;
        public var _MainFramePlayerBuff_PlayerBuffUI1:PlayerBuffUI;
        public var _MainFramePlayerBuff_PlayerBuffUI2:PlayerBuffUI;
        private var _102420391btnBottom:int = 32;
        private var cityX:int;
        private var cityY:int;
        private var _387552126dblBuilding:Image;
        private var myTimer:Timer;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 1;
                                        this.horizontalAlign = "right";
                                        this.verticalAlign = "middle";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":PLayerBuffBar,
                                                "id":"bar",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":390,
                                                        "height":30
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":PlayerBuffUI,
                                                "id":"_MainFramePlayerBuff_PlayerBuffUI1",
                                                "events":{"click":"___MainFramePlayerBuff_PlayerBuffUI1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"height":30});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":PlayerBuffUI,
                                                "id":"_MainFramePlayerBuff_PlayerBuffUI2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"height":30});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___MainFramePlayerBuff_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "6";
                                                    this.paddingTop = 6;
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"buff",
                                                        "toolTip":"Achievement Buffs"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"dblBuilding",
                                                "events":{
                                                    "complete":"__dblBuilding_complete",
                                                    "updateComplete":"__dblBuilding_updateComplete"
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "source":"images/icon/doubleBuilding.png",
                                                        "visible":false,
                                                        "width":0,
                                                        "height":24,
                                                        "toolTip":"Can build two buildings at one time."
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MainFramePlayerBuff()
        {
            mx_internal::_document = this;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___MainFramePlayerBuff_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MainFramePlayerBuff._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get dblBuilding():Image
        {
            return (this._387552126dblBuilding);
        }

        public function set dblBuilding(_arg_1:Image):void
        {
            var _local_2:Object = this._387552126dblBuilding;
            if (_local_2 !== _arg_1)
            {
                this._387552126dblBuilding = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dblBuilding", _local_2, _arg_1));
            };
        }

        private function set beans(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._93610691beans;
            if (_local_2 !== _arg_1)
            {
                this._93610691beans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "beans", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:MainFramePlayerBuff;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MainFramePlayerBuff_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castle_MainFramePlayerBuffWatcherSetupUtil");
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
        public function get bar():PLayerBuffBar
        {
            return (this._97299bar);
        }

        private function getBuffpeaceBean():BuffBean
        {
            var _local_1:BuffBean = new BuffBean();
            _local_1.descName = Lang.msg("可以免战");
            _local_1.endTime = 0;
            _local_1.typeId = PLayerBuffConstants.PLAYERNOPEACE_BUFF;
            return (_local_1);
        }

        private function getBuffBean():BuffBean
        {
            var _local_1:BuffBean = new BuffBean();
            _local_1.descName = Lang.msg("新手提示");
            _local_1.endTime = 0;
            _local_1.typeId = "playerNewBuff";
            return (_local_1);
        }

        private function init():void
        {
            trace((this.className + ".init()"));
            instance = this;
            addBuffBean();
            myTimer = new Timer(1000, 0);
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            myTimer.start();
            addpeaceBuffBean();
            myTimer_peace = new Timer(1000, 0);
            myTimer_peace.addEventListener(TimerEvent.TIMER, timerHandler_peace);
            myTimer_peace.start();
        }

        private function _MainFramePlayerBuff_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (peacebeans);
            }, function (_arg_1:Object):void
            {
                _MainFramePlayerBuff_PlayerBuffUI1.buffBean = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI1.buffBean");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((peacebeans.typeId == PLayerBuffConstants.PLAYERNOPEACE_BUFF) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainFramePlayerBuff_PlayerBuffUI1.visible = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((peacebeans.typeId == PLayerBuffConstants.PLAYERNOPEACE_BUFF) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainFramePlayerBuff_PlayerBuffUI1.includeInLayout = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI1.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Object
            {
                return (beans);
            }, function (_arg_1:Object):void
            {
                _MainFramePlayerBuff_PlayerBuffUI2.buffBean = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI2.buffBean");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((beans != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainFramePlayerBuff_PlayerBuffUI2.visible = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI2.visible");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((beans != null) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MainFramePlayerBuff_PlayerBuffUI2.includeInLayout = _arg_1;
            }, "_MainFramePlayerBuff_PlayerBuffUI2.includeInLayout");
            result[5] = binding;
            return (result);
        }

        public function lateCallFunction(_arg_1:int, _arg_2:int):void
        {
            this.isCallBack = true;
            this.cityX = _arg_1;
            this.cityY = _arg_2;
        }

        private function onSetSize(_arg_1:ChangeSizeEvent):void
        {
            btnBottom = (_arg_1.sizeNum + 32);
        }

        public function set bar(_arg_1:PLayerBuffBar):void
        {
            var _local_2:Object = this._97299bar;
            if (_local_2 !== _arg_1)
            {
                this._97299bar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bar", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get btnBottom():int
        {
            return (this._102420391btnBottom);
        }

        [Bindable(event="propertyChange")]
        private function get truceBean():BuffBean
        {
            return (this._1293938601truceBean);
        }

        private function set peacebeans(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._496366315peacebeans;
            if (_local_2 !== _arg_1)
            {
                this._496366315peacebeans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peacebeans", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get peacebeans():BuffBean
        {
            return (this._496366315peacebeans);
        }

        private function addpeaceBuffBean():void
        {
            var _local_3:BuffBean;
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().buffsArray;
            var _local_2:Boolean;
            for each (_local_3 in _local_1)
            {
                if (((((_local_3.typeId == PLayerBuffConstants.PLAYERPEACE_BUFF) || (_local_3.typeId == PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF)) || (_local_3.typeId == "PlayerPeaceUniteServerBuff")) || (_local_3.typeId == "TruceAgreementBuff")))
                {
                    _local_2 = true;
                };
            };
            if (!_local_2)
            {
                peacebeans = getBuffpeaceBean();
            };
        }

        private function onShowNoticeList():void
        {
            AmountInputUI.show();
        }

        public function __dblBuilding_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get beans():BuffBean
        {
            return (this._93610691beans);
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            if (UIUtil.checkOffice())
            {
                this.beans = null;
                myTimer.stop();
            };
        }

        private function _MainFramePlayerBuff_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = peacebeans;
            _local_1 = ((peacebeans.typeId == PLayerBuffConstants.PLAYERNOPEACE_BUFF) ? true : false);
            _local_1 = ((peacebeans.typeId == PLayerBuffConstants.PLAYERNOPEACE_BUFF) ? true : false);
            _local_1 = beans;
            _local_1 = ((beans != null) ? true : false);
            _local_1 = ((beans != null) ? true : false);
        }

        public function ___MainFramePlayerBuff_Button1_click(_arg_1:MouseEvent):void
        {
            onBuffBtnClick();
        }

        public function ___MainFramePlayerBuff_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set btnBottom(_arg_1:int):void
        {
            var _local_2:Object = this._102420391btnBottom;
            if (_local_2 !== _arg_1)
            {
                this._102420391btnBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnBottom", _local_2, _arg_1));
            };
        }

        private function set truceBean(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._1293938601truceBean;
            if (_local_2 !== _arg_1)
            {
                this._1293938601truceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "truceBean", _local_2, _arg_1));
            };
        }

        public function ___MainFramePlayerBuff_PlayerBuffUI1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        public function __dblBuilding_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function addBuffBean():void
        {
            if (!UIUtil.checkOffice())
            {
                beans = getBuffBean();
            };
        }

        private function onClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            StageChangeWin.show("Normal");
        }

        private function set isPlayerNew(_arg_1:Boolean):void
        {
            var _local_2:Object = this._693640971isPlayerNew;
            if (_local_2 !== _arg_1)
            {
                this._693640971isPlayerNew = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isPlayerNew", _local_2, _arg_1));
            };
        }

        private function timerHandler_peace(_arg_1:TimerEvent):void
        {
            var _local_4:BuffBean;
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().buffsArray;
            var _local_3:Boolean;
            for each (_local_4 in _local_2)
            {
                if (((((_local_4.typeId == PLayerBuffConstants.PLAYERPEACE_BUFF) || (_local_4.typeId == PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF)) || (_local_4.typeId == "PlayerPeaceUniteServerBuff")) || (_local_4.typeId == "TruceAgreementBuff")))
                {
                    _local_3 = true;
                    peacebeans = _local_4;
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get isPlayerNew():Boolean
        {
            return (this._693640971isPlayerNew);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
        }

        private function onBuffBtnClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            cj.show();
        }


    }
}//package view.castle

