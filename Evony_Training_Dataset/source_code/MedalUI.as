// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.MedalUI

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.common.beans.BuildingBean;
    import mx.controls.Label;
    import mx.controls.Button;
    import com.evony.common.beans.BuildingQueueBean;
    import com.evony.util.EvonyImage;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.Lang;
    import com.evony.client.response.ResponseDispatcher;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import com.evony.events.WindowChangeEvent;
    import flash.external.ExternalInterface;
    import com.evony.common.constants.CommonConstants;
    import flash.events.MouseEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.castle.CoinsNeedResponse;
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

    public class MedalUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var needMedal:int;
        private var _bean:BuildingBean;
        public var _MedalUI_Label2:Label;
        public var _MedalUI_Label1:Label;
        private var _836075691useBtn:Button;
        private var _buildQueueBean:BuildingQueueBean;
        private var _738344555iconFile:EvonyImage;
        public var coinSpeed:String;
        public var _MedalUI_Text1:Text;
        private var _744008145medalAmount:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":530,
                    "height":60,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":0,
                                "y":0,
                                "percentWidth":100,
                                "percentHeight":100,
                                "styleName":"canvasGroupBackGround",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":EvonyImage,
                                    "id":"iconFile",
                                    "events":{
                                        "mouseOver":"__iconFile_mouseOver",
                                        "mouseOut":"__iconFile_mouseOut",
                                        "mouseMove":"__iconFile_mouseMove"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "3";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "height":50,
                                            "source":"fla/dynamic/ui234.swf@Medal.png"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MedalUI_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.top = "2";
                                        this.left = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":20,
                                            "styleName":"contentheader2",
                                            "width":140
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_MedalUI_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                        this.left = "60";
                                        this.kerning = true;
                                        this.right = "70";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "mouseEnabled":false,
                                            "mouseChildren":false,
                                            "width":450,
                                            "styleName":"ParamgraphText2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_MedalUI_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "2";
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":50,
                                            "x":3,
                                            "styleName":"PropertyValue2"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"useBtn",
                                    "events":{"click":"__useBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.right = "10";
                                        this.top = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":65,
                                            "enabled":false,
                                            "styleName":"b40",
                                            "height":22
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MedalUI()
        {
            mx_internal::_document = this;
            this.width = 530;
            this.height = 60;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___MedalUI_Canvas1_creationComplete);
            this.addEventListener("click", ___MedalUI_Canvas1_click);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MedalUI._watcherSetupUtil = _arg_1;
        }


        public function set beans(_arg_1:BuildingBean):void
        {
            this._bean = _arg_1;
            if (((!(this._bean == null)) && (this._bean.positionId == 32)))
            {
                this._bean.positionId = -1;
            };
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function _MedalUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("立即完成");
            _local_1 = Lang.msg("使用金币立即完成提示");
            _local_1 = this.medalAmount;
            _local_1 = Lang.msg("使用物品");
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_GET_COINS_NEED, onNeedMedal);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.TECH_GET_COINS_NEED, onNeedMedal);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.EQUIPMENTTECH_GET_COINS_NEED, onNeedMedal);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.CASTLE_GET_BUILDING_QUEUE_COINS_NEED, onNeedMedal);
            this.enabled = true;
            this.refresh();
        }

        [Bindable(event="propertyChange")]
        public function get iconFile():EvonyImage
        {
            return (this._738344555iconFile);
        }

        public function ___MedalUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        override public function initialize():void
        {
            var target:MedalUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _MedalUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_MedalUIWatcherSetupUtil");
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

        public function set buildQueueBean(_arg_1:BuildingQueueBean):void
        {
            this._buildQueueBean = _arg_1;
            if (this.initialized)
            {
                this.refresh();
            };
        }

        public function set iconFile(_arg_1:EvonyImage):void
        {
            var _local_2:Object = this._738344555iconFile;
            if (_local_2 !== _arg_1)
            {
                this._738344555iconFile = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iconFile", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get medalAmount():int
        {
            return (this._744008145medalAmount);
        }

        public function set useBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._836075691useBtn;
            if (_local_2 !== _arg_1)
            {
                this._836075691useBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "useBtn", _local_2, _arg_1));
            };
        }

        private function onCoinSelected(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                if (Context.getInstance().getPlayerBean().playerInfo.medal >= this.needMedal)
                {
                    this.dispatchEvent(new WindowChangeEvent("medal"));
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameBuy", "1", this.needMedal, CommonConstants.COINS_SPEED_ITEM_ID, "Instant Finish", "coin", this.needMedal, 1);
                    };
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("callByIngameUse", CommonConstants.COINS_SPEED_ITEM_ID, "Instant Finish", "coin", this.needMedal);
                    };
                }
                else
                {
                    AddFundWin.show();
                };
            };
        }

        public function __iconFile_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function ___MedalUI_Canvas1_click(_arg_1:MouseEvent):void
        {
            onClick();
        }

        [Bindable(event="propertyChange")]
        public function get useBtn():Button
        {
            return (this._836075691useBtn);
        }

        public function __iconFile_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        private function refresh():void
        {
            if (((!(this._bean == null)) && (this._bean.positionId == 32)))
            {
                this._bean.positionId = -1;
            };
            var _local_1:int = Context.getInstance().getCurCastle().id;
            if (this.coinSpeed == SpeedupItemSelector.ON_COIN_TECH_SPEED)
            {
                ActionFactory.getInstance().getTechCommand().getCoinsNeed(_local_1);
            }
            else
            {
                if (this.coinSpeed == SpeedupItemSelector.ON_COIN_BUILD_SPEED)
                {
                    ActionFactory.getInstance().getCastleCommands().getCoinsNeed(_local_1, this._bean.positionId);
                }
                else
                {
                    if (this.coinSpeed == SpeedupItemSelector.ON_COIN_EQUIP_SPEED)
                    {
                        ActionFactory.getInstance().getEquipmenttechCommands().getCoinsNeed(_local_1);
                    }
                    else
                    {
                        if (this.coinSpeed == SpeedupItemSelector.ON_COIN_BUILD_QUEUE_SPEED)
                        {
                            ActionFactory.getInstance().getCastleCommands().getBuildingQueueCoinsNeed(_local_1, this._buildQueueBean.id);
                        };
                    };
                };
            };
        }

        public function set medalAmount(_arg_1:int):void
        {
            var _local_2:Object = this._744008145medalAmount;
            if (_local_2 !== _arg_1)
            {
                this._744008145medalAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "medalAmount", _local_2, _arg_1));
            };
        }

        private function onNeedMedal(_arg_1:CoinsNeedResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.needMedal = _arg_1.coinsNeed;
                trace((this.needMedal + "-----medal.cost----------"));
                this.useBtn.enabled = true;
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onMouseOut():void
        {
            DescribeTooltip.hide();
        }

        private function onClick():void
        {
            AlertWin.show(Lang.msg("花费{0}立即完成确认", this.needMedal), onCoinSelected);
        }

        public function __iconFile_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            DescribeTooltip.show(Lang.msg("立即完成"), Lang.msg("使用金币立即完成提示"), _arg_1);
        }

        private function _MedalUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("立即完成");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MedalUI_Label1.text = _arg_1;
            }, "_MedalUI_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用金币立即完成提示");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MedalUI_Text1.htmlText = _arg_1;
            }, "_MedalUI_Text1.htmlText");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.medalAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MedalUI_Label2.text = _arg_1;
            }, "_MedalUI_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("使用物品");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                useBtn.label = _arg_1;
            }, "useBtn.label");
            result[3] = binding;
            return (result);
        }

        public function __useBtn_click(_arg_1:MouseEvent):void
        {
            onClick();
        }


    }
}//package view.ui

