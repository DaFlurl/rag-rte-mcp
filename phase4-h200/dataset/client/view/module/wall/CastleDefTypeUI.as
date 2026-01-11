// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.wall.CastleDefTypeUI

package view.module.wall
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import view.ui.ConditionTooltip;
    import mx.controls.Image;
    import mx.controls.Label;
    import com.evony.common.beans.FortProduceListBean;
    import mx.binding.utils.ChangeWatcher;
    import mx.core.UIComponentDescriptor;
    import com.evony.eum.FortificationEum;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.factory.UIFactory;
    import com.evony.Lang;
    import mx.managers.PopUpManager;
    import flash.events.TimerEvent;
    import view.ui.DescribeTooltip;
    import com.evony.eum.FortificationEumDefine;
    import com.evony.Context;
    import com.evony.common.beans.FortificationsBean;
    import mx.binding.utils.BindingUtils;
    import com.evony.common.constants.TFConstants;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import com.evony.factory.ImageManager;
    import com.evony.util.UIUtil;
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

    public class CastleDefTypeUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _737800520curAmount:int;
        public var _CastleDefTypeUI_Button2:Button;
        private var _1185090783imgSrc:Object;
        private var tips:ConditionTooltip;
        public var _CastleDefTypeUI_Image1:Image;
        public var _CastleDefTypeUI_Label1:Label;
        public var _CastleDefTypeUI_Label2:Label;
        public var castleDefTypeId:int;
        private var _90754191_bean:FortProduceListBean;
        private var _186800895btnEnable:Boolean = false;
        private var _1752534364produceBtn:Button;
        private var changeWatcher:ChangeWatcher;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":201,
                    "height":99,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"_CastleDefTypeUI_Image1",
                        "events":{
                            "updateComplete":"___CastleDefTypeUI_Image1_updateComplete",
                            "mouseMove":"___CastleDefTypeUI_Image1_mouseMove",
                            "mouseOver":"___CastleDefTypeUI_Image1_mouseOver",
                            "mouseOut":"___CastleDefTypeUI_Image1_mouseOut"
                        },
                        "stylesFactory":function ():void
                        {
                            this.left = "10";
                            this.top = "30";
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
                        "id":"produceBtn",
                        "events":{"click":"__produceBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "10";
                            this.right = "10";
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
                        "id":"_CastleDefTypeUI_Label1",
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
                        "id":"_CastleDefTypeUI_Button2",
                        "events":{"click":"___CastleDefTypeUI_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.left = "48";
                            this.top = "66";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"delete",
                                "width":20,
                                "height":20
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_CastleDefTypeUI_Label2",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "33";
                            this.right = "5";
                            this.textAlign = "right";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"ftp14s"});
                        }
                    })]
                });
            }
        });
        private var _101192fce:FortificationEum = new FortificationEum();
        private var conditionTimer:Timer = new Timer(1000, 0);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function CastleDefTypeUI()
        {
            mx_internal::_document = this;
            this.width = 201;
            this.height = 99;
            this.styleName = "textBackgroundShopTiles";
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___CastleDefTypeUI_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CastleDefTypeUI._watcherSetupUtil = _arg_1;
        }


        private function onProduceClick():void
        {
            CastleDefProduce.show(this._bean);
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

        public function ___CastleDefTypeUI_Image1_mouseOut(_arg_1:MouseEvent):void
        {
            onPicMouseOut();
        }

        override public function initialize():void
        {
            var target:CastleDefTypeUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CastleDefTypeUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_wall_CastleDefTypeUIWatcherSetupUtil");
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

        private function onMouseOver(_arg_1:MouseEvent):void
        {
            tips = UIFactory.getInstance().getConditionTooltip();
            tips.setCastleProtectType(Lang.msg("建造"), this._bean.typeId);
            tips.setBean(this._bean.conditionBean);
            tips.moveToMouse(_arg_1);
            PopUpManager.addPopUp(tips, this);
        }

        [Bindable(event="propertyChange")]
        private function get _bean():FortProduceListBean
        {
            return (this._90754191_bean);
        }

        private function init():void
        {
            this.produceBtn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
            this.produceBtn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            this.produceBtn.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            this.conditionTimer.addEventListener(TimerEvent.TIMER, onConditionTime);
        }

        [Bindable(event="propertyChange")]
        private function get imgSrc():Object
        {
            return (this._1185090783imgSrc);
        }

        private function set _bean(_arg_1:FortProduceListBean):void
        {
            var _local_2:Object = this._90754191_bean;
            if (_local_2 !== _arg_1)
            {
                this._90754191_bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_bean", _local_2, _arg_1));
            };
        }

        private function onPicMouseMove(_arg_1:MouseEvent):void
        {
            DescribeTooltip.move2Mouse(_arg_1);
        }

        private function onPicMouseOver(_arg_1:MouseEvent):void
        {
            var _local_2:FortificationEum = FortificationEumDefine.getFortificationEumByType(_bean.typeId);
            DescribeTooltip.show(_local_2.name, _local_2.wikiDesc, _arg_1);
        }

        public function ___CastleDefTypeUI_Image1_mouseMove(_arg_1:MouseEvent):void
        {
            onPicMouseMove(_arg_1);
        }

        public function ___CastleDefTypeUI_Image1_mouseOver(_arg_1:MouseEvent):void
        {
            onPicMouseOver(_arg_1);
        }

        private function onPicMouseOut():void
        {
            DescribeTooltip.hide();
        }

        private function _CastleDefTypeUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.imgSrc;
            _local_1 = Lang.msg("建造");
            _local_1 = this.btnEnable;
            _local_1 = this.fce.name;
            _local_1 = Lang.msg("拆除");
            _local_1 = this.curAmount;
        }

        private function bind():void
        {
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
            var _local_1:FortificationsBean = Context.getInstance().getCurCastle().fortification;
            switch (this._bean.typeId)
            {
                case TFConstants.F_ABATIS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "abatis");
                    return;
                case TFConstants.F_ARROWTOWER:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "arrowTower");
                    return;
                case TFConstants.F_ROCKFALL:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rockfall");
                    return;
                case TFConstants.F_ROLLINGLOGS:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "rollingLogs");
                    return;
                case TFConstants.F_TRAP:
                    this.changeWatcher = BindingUtils.bindProperty(this, "curAmount", _local_1, "trap");
                    return;
            };
        }

        public function set produceBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1752534364produceBtn;
            if (_local_2 !== _arg_1)
            {
                this._1752534364produceBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "produceBtn", _local_2, _arg_1));
            };
        }

        public function __produceBtn_click(_arg_1:MouseEvent):void
        {
            onProduceClick();
        }

        [Bindable(event="propertyChange")]
        public function get curAmount():int
        {
            return (this._737800520curAmount);
        }

        public function ___CastleDefTypeUI_Image1_updateComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set fce(_arg_1:FortificationEum):void
        {
            var _local_2:Object = this._101192fce;
            if (_local_2 !== _arg_1)
            {
                this._101192fce = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fce", _local_2, _arg_1));
            };
        }

        private function _CastleDefTypeUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.imgSrc);
            }, function (_arg_1:Object):void
            {
                _CastleDefTypeUI_Image1.source = _arg_1;
            }, "_CastleDefTypeUI_Image1.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("建造");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                produceBtn.label = _arg_1;
            }, "produceBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.btnEnable);
            }, function (_arg_1:Boolean):void
            {
                produceBtn.enabled = _arg_1;
            }, "produceBtn.enabled");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.fce.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefTypeUI_Label1.text = _arg_1;
            }, "_CastleDefTypeUI_Label1.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("拆除");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefTypeUI_Button2.label = _arg_1;
            }, "_CastleDefTypeUI_Button2.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curAmount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CastleDefTypeUI_Label2.text = _arg_1;
            }, "_CastleDefTypeUI_Label2.text");
            result[5] = binding;
            return (result);
        }

        public function ___CastleDefTypeUI_Button2_click(_arg_1:MouseEvent):void
        {
            onDestructClick();
        }

        [Bindable(event="propertyChange")]
        private function get fce():FortificationEum
        {
            return (this._101192fce);
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

        [Bindable(event="propertyChange")]
        public function get produceBtn():Button
        {
            return (this._1752534364produceBtn);
        }

        public function set bean(_arg_1:FortProduceListBean):void
        {
            this._bean = _arg_1;
            this.fce = FortificationEumDefine.getFortificationEumByType(this._bean.typeId);
            this.btnEnable = false;
            this.conditionTimer.start();
            this.onConditionTime(null);
            this.imgSrc = ImageManager.getFortBigLogo(this._bean.typeId);
            this.bind();
        }

        public function ___CastleDefTypeUI_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onMouseOut(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.destroy();
            };
        }

        private function onConditionTime(_arg_1:TimerEvent):void
        {
            if (!UIUtil.isUIComponentVisible(this))
            {
                this.conditionTimer.stop();
                trace((this.className + " 被隐藏了. timer stop"));
                return;
            };
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
        }

        private function onDestructClick():void
        {
            CastleDefDemolition.show(this._bean);
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (tips != null)
            {
                tips.moveToMouse(_arg_1);
            };
        }

        public function destroy():void
        {
            this.conditionTimer.stop();
            if (this.changeWatcher != null)
            {
                this.changeWatcher.unwatch();
            };
        }

        private function set btnEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._186800895btnEnable;
            if (_local_2 !== _arg_1)
            {
                this._186800895btnEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnEnable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get btnEnable():Boolean
        {
            return (this._186800895btnEnable);
        }


    }
}//package view.module.wall

