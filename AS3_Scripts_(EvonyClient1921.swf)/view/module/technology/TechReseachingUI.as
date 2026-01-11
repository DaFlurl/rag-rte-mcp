// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.technology.TechReseachingUI

package view.module.technology
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import view.ui.RemainTimeLabel;
    import mx.controls.Label;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.beans.AvailableResearchListBean;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.Context;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import view.ui.CancelToolTip;
    import flash.events.MouseEvent;
    import view.ui.AlertWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.constants.CommonConstants;
    import com.evony.eum.ItemEum;
    import view.ui.SpeedUpCheckOut;
    import view.ui.SpeedupItemSelector;
    import com.evony.factory.ItemManager;
    import com.evony.eum.TechEumDefine;
    import com.evony.factory.ImageManager;
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

    public class TechReseachingUI extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _TechReseachingUI_Image1:Image;
        public var _TechReseachingUI_RemainTimeLabel1:RemainTimeLabel;
        public var _TechReseachingUI_Label2:Label;
        private var _2124133034imageSource:Object;
        private var _676324473typeText:Label;
        private var _teachTypeId:int;
        private var _1404527039_buildBean:BuildingBean;
        private var _1616120255techName:String;
        private var _90754191_bean:AvailableResearchListBean;
        private var _476548482cancelBtn:Button;
        private var _173173659callBack:Function;
        private var _84932619quickenUpBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":280,
                    "height":45,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Button,
                        "id":"cancelBtn",
                        "events":{
                            "click":"__cancelBtn_click",
                            "mouseOver":"__cancelBtn_mouseOver",
                            "mouseOut":"__cancelBtn_mouseOut",
                            "mouseMove":"__cancelBtn_mouseMove"
                        },
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.bottom = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":20,
                                "height":20,
                                "styleName":"interruption"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"_TechReseachingUI_Image1",
                        "events":{"complete":"___TechReseachingUI_Image1_complete"},
                        "stylesFactory":function ():void
                        {
                            this.verticalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":6,
                                "width":34,
                                "height":34
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"quickenUpBtn",
                        "events":{"click":"__quickenUpBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "5";
                            this.top = "3";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"quickenUp"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"typeText",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":48,
                                "y":3
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"_TechReseachingUI_Label2",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":48,
                                "y":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":RemainTimeLabel,
                        "id":"_TechReseachingUI_RemainTimeLabel1",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":104,
                                "y":22
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

        public function TechReseachingUI()
        {
            mx_internal::_document = this;
            this.width = 280;
            this.height = 45;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            TechReseachingUI._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get cancelBtn():Button
        {
            return (this._476548482cancelBtn);
        }

        public function set cancelBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._476548482cancelBtn;
            if (_local_2 !== _arg_1)
            {
                this._476548482cancelBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cancelBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get typeText():Label
        {
            return (this._676324473typeText);
        }

        private function set techName(_arg_1:String):void
        {
            var _local_2:Object = this._1616120255techName;
            if (_local_2 !== _arg_1)
            {
                this._1616120255techName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "techName", _local_2, _arg_1));
            };
        }

        public function ___TechReseachingUI_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        private function _TechReseachingUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = (this._bean.castleId == Context.getInstance().getCurCastle().id);
            _local_1 = this.imageSource;
            _local_1 = (this._bean.castleId == Context.getInstance().getCurCastle().id);
            _local_1 = techName;
            _local_1 = (Lang.msg("耗时") + ":");
            _local_1 = this._bean.endTime;
            _local_1 = callBack;
        }

        [Bindable(event="propertyChange")]
        private function get _bean():AvailableResearchListBean
        {
            return (this._90754191_bean);
        }

        public function set teachTypeId(_arg_1:int):void
        {
            this._teachTypeId = _arg_1;
        }

        public function set typeText(_arg_1:Label):void
        {
            var _local_2:Object = this._676324473typeText;
            if (_local_2 !== _arg_1)
            {
                this._676324473typeText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "typeText", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:TechReseachingUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _TechReseachingUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_technology_TechReseachingUIWatcherSetupUtil");
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

        private function set _bean(_arg_1:AvailableResearchListBean):void
        {
            var _local_2:Object = this._90754191_bean;
            if (_local_2 !== _arg_1)
            {
                this._90754191_bean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_bean", _local_2, _arg_1));
            };
        }

        private function onCancelRollOut():void
        {
            CancelToolTip.hide();
        }

        [Bindable(event="propertyChange")]
        public function get quickenUpBtn():Button
        {
            return (this._84932619quickenUpBtn);
        }

        private function onCancelMove(_arg_1:MouseEvent):void
        {
            CancelToolTip.move2Mouse(_arg_1);
        }

        public function __cancelBtn_click(_arg_1:MouseEvent):void
        {
            onCancel();
        }

        public function __quickenUpBtn_click(_arg_1:MouseEvent):void
        {
            onSpeedUp();
        }

        private function onCancel():void
        {
            AlertWin.show(Lang.msg("确定取消"), onCancleOk);
        }

        private function _TechReseachingUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this._bean.castleId == Context.getInstance().getCurCastle().id);
            }, function (_arg_1:Boolean):void
            {
                cancelBtn.visible = _arg_1;
            }, "cancelBtn.visible");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.imageSource);
            }, function (_arg_1:Object):void
            {
                _TechReseachingUI_Image1.source = _arg_1;
            }, "_TechReseachingUI_Image1.source");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this._bean.castleId == Context.getInstance().getCurCastle().id);
            }, function (_arg_1:Boolean):void
            {
                quickenUpBtn.visible = _arg_1;
            }, "quickenUpBtn.visible");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = techName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                typeText.text = _arg_1;
            }, "typeText.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("耗时") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _TechReseachingUI_Label2.text = _arg_1;
            }, "_TechReseachingUI_Label2.text");
            result[4] = binding;
            binding = new Binding(this, function ():Number
            {
                return (this._bean.endTime);
            }, function (_arg_1:Number):void
            {
                _TechReseachingUI_RemainTimeLabel1.remainTime = _arg_1;
            }, "_TechReseachingUI_RemainTimeLabel1.remainTime");
            result[5] = binding;
            binding = new Binding(this, function ():Function
            {
                return (callBack);
            }, function (_arg_1:Function):void
            {
                _TechReseachingUI_RemainTimeLabel1.callBack = _arg_1;
            }, "_TechReseachingUI_RemainTimeLabel1.callBack");
            result[6] = binding;
            return (result);
        }

        private function freeSpeed(_arg_1:Boolean):void
        {
            var _local_2:int;
            if (_arg_1)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getTechCommand().speedUpResearch(_local_2, CommonConstants.FREE_SPEED_ITEM_ID);
            };
        }

        public function __cancelBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onCancelRollOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get _buildBean():BuildingBean
        {
            return (this._1404527039_buildBean);
        }

        [Bindable(event="propertyChange")]
        private function get techName():String
        {
            return (this._1616120255techName);
        }

        public function set quickenUpBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._84932619quickenUpBtn;
            if (_local_2 !== _arg_1)
            {
                this._84932619quickenUpBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "quickenUpBtn", _local_2, _arg_1));
            };
        }

        private function onCancleOk(_arg_1:Boolean):void
        {
            trace((((this.className + ".onCancleOk(") + _arg_1) + ")"));
            if (_arg_1)
            {
                ActionFactory.getInstance().getTechCommand().cancelResearch(Context.getInstance().getCurCastle().id);
            };
        }

        public function __cancelBtn_mouseMove(_arg_1:MouseEvent):void
        {
            onCancelMove(_arg_1);
        }

        private function onCancelRollOver(_arg_1:MouseEvent):void
        {
            CancelToolTip.show("Academy", _arg_1);
        }

        private function set imageSource(_arg_1:Object):void
        {
            var _local_2:Object = this._2124133034imageSource;
            if (_local_2 !== _arg_1)
            {
                this._2124133034imageSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imageSource", _local_2, _arg_1));
            };
        }

        private function onSpeedUpItemSelected(_arg_1:ItemEum):void
        {
            var _local_2:int;
            trace((((this.className + ".onSpeedUpItemSelected(") + _arg_1.name) + ")"));
            if (_arg_1 != null)
            {
                _local_2 = Context.getInstance().getCurCastle().id;
                ActionFactory.getInstance().getTechCommand().speedUpResearch(_local_2, _arg_1.id);
            };
        }

        [Bindable(event="propertyChange")]
        private function get imageSource():Object
        {
            return (this._2124133034imageSource);
        }

        public function set callBack(_arg_1:Function):void
        {
            var _local_2:Object = this._173173659callBack;
            if (_local_2 !== _arg_1)
            {
                this._173173659callBack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "callBack", _local_2, _arg_1));
            };
        }

        private function onSpeedUp():void
        {
            var _local_1:String;
            if (SpeedUpCheckOut.checkOutTech(this._bean))
            {
                SpeedupItemSelector.getInstance().bean = this._buildBean;
                SpeedupItemSelector.getInstance().teachbean = this._bean;
                SpeedupItemSelector.getInstance().speedType = SpeedupItemSelector.ON_COIN_TECH_SPEED;
                SpeedupItemSelector.show(ItemManager.speedItemArray, onSpeedUpItemSelected);
                if (Context.getInstance().isBuildHelp)
                {
                    Context.getInstance().isSpeedType = 1;
                    _local_1 = TechEumDefine.getTechEumByType(this._teachTypeId).name;
                    Context.getInstance().buidwithhelpName = _local_1;
                    Context.getInstance().buidwithhelpLevel = String((this._bean.level + 1));
                };
            }
            else
            {
                AlertWin.show(Lang.msg("生产时间低于5分钟免费加速"), freeSpeed);
            };
        }

        [Bindable(event="propertyChange")]
        public function get callBack():Function
        {
            return (this._173173659callBack);
        }

        public function __cancelBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onCancelRollOut();
        }

        public function set bean(_arg_1:AvailableResearchListBean):void
        {
            _bean = _arg_1;
            techName = TechEumDefine.getTechEumByType(_arg_1.typeId).name;
            this.imageSource = ImageManager.getTechLogo(_arg_1.typeId);
        }

        public function set buildBean(_arg_1:BuildingBean):void
        {
            this._buildBean = _arg_1;
        }

        private function set _buildBean(_arg_1:BuildingBean):void
        {
            var _local_2:Object = this._1404527039_buildBean;
            if (_local_2 !== _arg_1)
            {
                this._1404527039_buildBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_buildBean", _local_2, _arg_1));
            };
        }


    }
}//package view.module.technology

