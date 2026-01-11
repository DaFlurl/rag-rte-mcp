// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.barrack.SWTypeUI

package view.module.barrack
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import com.evony.eum.TroopEum;
    import mx.controls.Button;
    import mx.controls.Image;
    import com.evony.common.beans.TroopProduceListBean;
    import mx.controls.Label;
    import view.ui.ConditionTooltip;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import com.evony.common.beans.CastleResourceBean;
    import com.evony.Context;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import flash.events.TimerEvent;
    import view.castle.MainFrame;
    import com.evony.common.beans.TroopBean;
    import mx.binding.utils.BindingUtils;
    import com.evony.common.constants.TFConstants;
    import com.evony.eum.TroopEumDefine;
    import com.evony.factory.ImageManager;
    import com.evony.util.UIUtil;
    import com.evony.factory.UIFactory;
    import mx.managers.PopUpManager;
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

    public class SWTypeUI extends Canvas implements IBindingClient 
    {

        public static var instance:SWTypeUI;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _737800520curAmount:int;
        private var troopEum:TroopEum;
        private var _758237287disbandBtn:Button;
        public var bakTypeId:int;
        public var _SWTypeUI_Image1:Image;
        private var _bean:TroopProduceListBean;
        private var _1185090783imgSrc:Object;
        public var _SWTypeUI_Label1:Label;
        private var _186800895btnEnable:Boolean = false;
        private var tips:ConditionTooltip;
        public var _SWTypeUI_Label2:Label;
        private var _617946365troopName:String;
        private var changeWatcher:ChangeWatcher;
        private var _748239893enlistBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":201,
                    "height":99,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_SWTypeUI_Image1",
                        "events":{
                            "updateComplete":"___SWTypeUI_Image1_updateComplete",
                            "creationComplete":"___SWTypeUI_Image1_creationComplete",
                            "mouseOut":"___SWTypeUI_Image1_mouseOut",
                            "mouseMove":"___SWTypeUI_Image1_mouseMove",
                            "mouseOver":"___SWTypeUI_Image1_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.top = "30";
                            this.left = "10";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":62,
                                "height":62
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"enlistBtn",
                        "events":{
                            "click":"__enlistBtn_click",
                            "mouseOut":"__enlistBtn_mouseOut",
                            "mouseMove":"__enlistBtn_mouseMove",
                            "mouseOver":"__enlistBtn_mouseOver"
                        },
                        "stylesFactory":function ():void
                        {
                            this.bottom = "10";
                            this.right = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b75",
                                "width":75,
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_SWTypeUI_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                            this.top = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"fontTitle",
                                "percentWidth":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"disbandBtn",
                        "events":{"click":"__disbandBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.left = "48";
                            this.top = "66";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":22,
                                "height":22,
                                "styleName":"delete"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_SWTypeUI_Label2",
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.textAlign = "right";
                            this.bottom = "33";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"ftp510"});
                        }
                    })]
                });
            }
        });
        private var _250546835_resource:CastleResourceBean = Context.getInstance().getCurCastle().resource;
        private var conditionTimer:Timer = new Timer(1000, 0);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SWTypeUI()
        {
            mx_internal::_document = this;
            this.width = 201;
            this.height = 99;
            this.styleName = "textBackgroundShopTiles";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___SWTypeUI_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SWTypeUI._watcherSetupUtil = _arg_1;
        }


        private function hideArmyTooltip():void
        {
            ArmyInfoTooltip.hide();
        }

        public function __enlistBtn_click(_arg_1:MouseEvent):void
        {
            onProduceBtnClick();
        }

        private function _SWTypeUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _SWTypeUI_Image1.source = _arg_1;
            }, "_SWTypeUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("招募");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                enlistBtn.label = _arg_1;
            }, "enlistBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnable);
            }, function (_arg_1:Boolean):void
            {
                enlistBtn.enabled = _arg_1;
            }, "enlistBtn.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.troopName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWTypeUI_Label1.text = _arg_1;
            }, "_SWTypeUI_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("解散");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                disbandBtn.label = _arg_1;
            }, "disbandBtn.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SWTypeUI_Label2.text = _arg_1;
            }, "_SWTypeUI_Label2.text");
            result[5] = binding;
            return (result);
        }

        public function destroy():void
        {
            this.conditionTimer.stop();
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
        }

        public function __enlistBtn_mouseMove(_arg_1:MouseEvent):void
        {
            onMouseMove(_arg_1);
        }

        public function set btnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._186800895btnEnable;
            if (_local_2 !== _arg_1)
            {
                this._186800895btnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEnable", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:SWTypeUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SWTypeUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_barrack_SWTypeUIWatcherSetupUtil");
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

        public function ___SWTypeUI_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get enlistBtn():Button
        {
            return (this._748239893enlistBtn);
        }

        [Bindable(event="propertyChange")]
        public function get disbandBtn():Button
        {
            return (this._758237287disbandBtn);
        }

        public function ___SWTypeUI_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onArmyMouseMove(_arg_1);
        }

        private function set troopName(_arg_1:String):void
        {
            var _local_2:Object = this._617946365troopName;
            if (_local_2 !== _arg_1)
            {
                this._617946365troopName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "troopName", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            instance = this;
            this.conditionTimer.addEventListener(TimerEvent.TIMER, onConditionTime);
        }

        public function set curAmount(_arg_1:int):void
        {
            var _local_2:Object = this._737800520curAmount;
            if (_local_2 !== _arg_1)
            {
                this._737800520curAmount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curAmount", _local_2, _arg_1));
            };
        }

        public function set enlistBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._748239893enlistBtn;
            if (_local_2 !== _arg_1)
            {
                this._748239893enlistBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enlistBtn", _local_2, _arg_1));
            };
        }

        public function ___SWTypeUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onProduceBtnClick():void
        {
            SWEnlist.show(MainFrame.instance, this._bean);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        public function __enlistBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onMouseOver(_arg_1);
        }

        public function onDisbandBtnClick():void
        {
            SWDisband.show(MainFrame.instance, this._bean);
        }

        public function ___SWTypeUI_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            showArmyTooltip(_arg_1);
        }

        public function set disbandBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._758237287disbandBtn;
            if (_local_2 !== _arg_1)
            {
                this._758237287disbandBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "disbandBtn", _local_2, _arg_1));
            };
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:TroopBean = Context.getInstance().getCurCastle().troop;
            switch (this._bean.typeId)
            {
                case TFConstants.T_ARCHER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "archer");
                    return;
                case TFConstants.T_BALLISTA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "ballista");
                    return;
                case TFConstants.T_BATTERINGRAM:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "batteringRam");
                    return;
                case TFConstants.T_CARRIAGE:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "carriage");
                    return;
                case TFConstants.T_CATAPULT:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "catapult");
                    return;
                case TFConstants.T_HEAVYCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "heavyCavalry");
                    return;
                case TFConstants.T_LIGHTCAVALRY:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "lightCavalry");
                    return;
                case TFConstants.T_MILITIA:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "militia");
                    return;
                case TFConstants.T_PEASANTS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "peasants");
                    return;
                case TFConstants.T_PIKEMAN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "pikemen");
                    return;
                case TFConstants.T_SCOUTER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "scouter");
                    return;
                case TFConstants.T_SWORDSMEN:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "swordsmen");
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        public function ___SWTypeUI_Image1_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        public function ___SWTypeUI_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            hideArmyTooltip();
        }

        public function __disbandBtn_click(_arg_1:MouseEvent):void
        {
            onDisbandBtnClick();
        }

        public function __enlistBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onMouseOut();
        }

        private function onArmyMouseMove(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.move2Mouse(_arg_1);
        }

        public function set bean(_arg_1:TroopProduceListBean):void
        {
            this._bean = _arg_1;
            this.troopEum = TroopEumDefine.getTroopEumByType(_bean.typeId);
            this.troopName = this.troopEum.name;
            this.btnEnable = false;
            this.conditionTimer.start();
            this.onConditionTime(null);
            this.imgSrc = ImageManager.getTroopLargeLogo(_bean.typeId);
            this.bind();
        }

        private function set imgSrc(_arg_1:Object):void
        {
            var _local_2:Object = this._1185090783imgSrc;
            if (_local_2 !== _arg_1)
            {
                this._1185090783imgSrc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgSrc", _local_2, _arg_1));
            };
        }

        private function _SWTypeUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSrc;
            _local_1 = Lang.msg("招募");
            _local_1 = this.btnEnable;
            _local_1 = this.troopName;
            _local_1 = Lang.msg("解散");
            _local_1 = this.curAmount;
        }

        private function onMouseOut():void
        {
            if (tips != null)
            {
                tips.destroy();
            };
        }

        private function showArmyTooltip(_arg_1:MouseEvent):void
        {
            ArmyInfoTooltip.show(this.bakTypeId, _arg_1);
        }

        private function onConditionTime(_arg_1:TimerEvent):void
        {
            var _local_2:Boolean = UIUtil.isConditionMatch(this._bean.conditionBean);
            var _local_3:Boolean = UIUtil.isResourceConditionMatch(this._bean.conditionBean);
            if (_local_3)
            {
                this.conditionTimer.stop();
            };
            if (((_local_2) && (_local_3)))
            {
                this.btnEnable = true;
            };
            if (((!(UIUtil.isUIComponentVisible(this))) && (this.conditionTimer.currentCount > 10)))
            {
                this.conditionTimer.stop();
                trace((this.className + " 被隐藏了. timer stop"));
                return;
            };
        }

        private function set _resource(_arg_1:CastleResourceBean):void
        {
            var _local_2:Object = this._250546835_resource;
            if (_local_2 !== _arg_1)
            {
                this._250546835_resource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_resource", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get _resource():CastleResourceBean
        {
            return (this._250546835_resource);
        }

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            if (this._bean == null)
            {
                return;
            };
            tips = UIFactory.getInstance().getConditionTooltip();
            tips.setTroopType(Lang.msg("招募"), this._bean.typeId);
            tips.setBean(this._bean.conditionBean);
            tips.moveToMouse(_arg_1);
            PopUpManager.addPopUp(tips, this);
        }

        [Bindable(event="propertyChange")]
        private function get troopName():String
        {
            return (this._617946365troopName);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.moveToMouse(_arg_1);
            };
        }

        [Bindable(event="propertyChange")]
        public function get btnEnable():Boolean
        {
            return (this._186800895btnEnable);
        }


    }
}//package view.module.barrack

