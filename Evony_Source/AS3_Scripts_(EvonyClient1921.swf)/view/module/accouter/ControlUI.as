// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.accouter.ControlUI

package view.module.accouter
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.ui.MyHRule;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.module.CommandResponse;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.Event;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.common.constants.EquipmentTech;
    import com.evony.client.action.ActionFactory;
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

    public class ControlUI extends Canvas implements IBindingClient 
    {

        public static const EQUIPMENTUPDATE_EVENT:String = "ControlUI.EquipmentUpdate";
        public static var instance:ControlUI = new (ControlUI)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1321911051takeOffEnable:Boolean;
        public var _ControlUI_MyHRule1:MyHRule;
        public var _ControlUI_MyHRule2:MyHRule;
        public var _ControlUI_MyHRule3:MyHRule;
        public var _ControlUI_MyHRule4:MyHRule;
        private var _1484050358takeOnBtn:Button;
        private var _1175824254AttackersBtn:Button;
        private var heroId:int;
        private var _1147165637attriEnable:Boolean;
        private var _2011996739accoutSellBtn:Button;
        private var _106854031posId:int = 0;
        private var _1740896083politiciansBtn:Button;
        private var _499518058WisemenBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "3";
                            this.top = "5";
                            this.right = "3";
                            this.bottom = "5";
                            this.horizontalAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"politiciansBtn",
                                    "events":{
                                        "click":"__politiciansBtn_click",
                                        "mouseOver":"__politiciansBtn_mouseOver",
                                        "mouseOut":"__politiciansBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"listBtn",
                                            "alpha":0,
                                            "width":143,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ControlUI_MyHRule1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"AttackersBtn",
                                    "events":{
                                        "click":"__AttackersBtn_click",
                                        "mouseOver":"__AttackersBtn_mouseOver",
                                        "mouseOut":"__AttackersBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"listBtn",
                                            "alpha":0,
                                            "width":143,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ControlUI_MyHRule2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"WisemenBtn",
                                    "events":{
                                        "click":"__WisemenBtn_click",
                                        "mouseOver":"__WisemenBtn_mouseOver",
                                        "mouseOut":"__WisemenBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"listBtn",
                                            "alpha":0,
                                            "width":143,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ControlUI_MyHRule3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"takeOnBtn",
                                    "events":{
                                        "click":"__takeOnBtn_click",
                                        "mouseOver":"__takeOnBtn_mouseOver",
                                        "mouseOut":"__takeOnBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"listBtn",
                                            "alpha":0,
                                            "width":143,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "id":"_ControlUI_MyHRule4",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"lineHrule",
                                            "percentWidth":98
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"accoutSellBtn",
                                    "events":{
                                        "click":"__accoutSellBtn_click",
                                        "mouseOver":"__accoutSellBtn_mouseOver",
                                        "mouseOut":"__accoutSellBtn_mouseOut"
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"listBtn",
                                            "alpha":0,
                                            "width":143,
                                            "height":22
                                        });
                                    }
                                })]});
                        }
                    })]});
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ControlUI()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.kerning = true;
            };
            this.styleName = "doubleLineBlue";
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ControlUI._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:int, _arg_2:int, _arg_3:Boolean, _arg_4:Boolean):void
        {
            instance.attriEnable = _arg_3;
            instance.takeOffEnable = _arg_4;
            instance.heroId = _arg_1;
            instance.posId = _arg_2;
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, false);
            };
            instance.x = (Application.application.mouseX + 10);
            instance.y = (Application.application.mouseY + 15);
        }


        public function set accoutSellBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2011996739accoutSellBtn;
            if (_local_2 !== _arg_1)
            {
                this._2011996739accoutSellBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "accoutSellBtn", _local_2, _arg_1));
            };
        }

        public function set AttackersBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1175824254AttackersBtn;
            if (_local_2 !== _arg_1)
            {
                this._1175824254AttackersBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AttackersBtn", _local_2, _arg_1));
            };
        }

        private function onChatBtnOut(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 0;
        }

        public function __accoutSellBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function set attriEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1147165637attriEnable;
            if (_local_2 !== _arg_1)
            {
                this._1147165637attriEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "attriEnable", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get posId():int
        {
            return (this._106854031posId);
        }

        override public function initialize():void
        {
            var target:ControlUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ControlUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_accouter_ControlUIWatcherSetupUtil");
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
        private function get takeOffEnable():Boolean
        {
            return (this._1321911051takeOffEnable);
        }

        private function wearTechResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ResponseDispatcher.getInstance().dispatchEvent(new Event(ControlUI.EQUIPMENTUPDATE_EVENT));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function _ControlUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("政治科技");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                politiciansBtn.label = _arg_1;
            }, "politiciansBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (attriEnable);
            }, function (_arg_1:Boolean):void
            {
                politiciansBtn.enabled = _arg_1;
            }, "politiciansBtn.enabled");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                politiciansBtn.includeInLayout = _arg_1;
            }, "politiciansBtn.includeInLayout");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                politiciansBtn.visible = _arg_1;
            }, "politiciansBtn.visible");
            result[3] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule1.includeInLayout = _arg_1;
            }, "_ControlUI_MyHRule1.includeInLayout");
            result[4] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule1.visible = _arg_1;
            }, "_ControlUI_MyHRule1.visible");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("武力科技");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                AttackersBtn.label = _arg_1;
            }, "AttackersBtn.label");
            result[6] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (attriEnable);
            }, function (_arg_1:Boolean):void
            {
                AttackersBtn.enabled = _arg_1;
            }, "AttackersBtn.enabled");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                AttackersBtn.includeInLayout = _arg_1;
            }, "AttackersBtn.includeInLayout");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                AttackersBtn.visible = _arg_1;
            }, "AttackersBtn.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule2.includeInLayout = _arg_1;
            }, "_ControlUI_MyHRule2.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule2.visible = _arg_1;
            }, "_ControlUI_MyHRule2.visible");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智力科技");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                WisemenBtn.label = _arg_1;
            }, "WisemenBtn.label");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (attriEnable);
            }, function (_arg_1:Boolean):void
            {
                WisemenBtn.enabled = _arg_1;
            }, "WisemenBtn.enabled");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                WisemenBtn.includeInLayout = _arg_1;
            }, "WisemenBtn.includeInLayout");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                WisemenBtn.visible = _arg_1;
            }, "WisemenBtn.visible");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule3.includeInLayout = _arg_1;
            }, "_ControlUI_MyHRule3.includeInLayout");
            result[16] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule3.visible = _arg_1;
            }, "_ControlUI_MyHRule3.visible");
            result[17] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("佩戴");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                takeOnBtn.label = _arg_1;
            }, "takeOnBtn.label");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((attriEnable) && (!(takeOffEnable)));
            }, function (_arg_1:Boolean):void
            {
                takeOnBtn.enabled = _arg_1;
            }, "takeOnBtn.enabled");
            result[19] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:Boolean):void
            {
                takeOnBtn.includeInLayout = _arg_1;
            }, "takeOnBtn.includeInLayout");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:Boolean):void
            {
                takeOnBtn.visible = _arg_1;
            }, "takeOnBtn.visible");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule4.includeInLayout = _arg_1;
            }, "_ControlUI_MyHRule4.includeInLayout");
            result[22] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            }, function (_arg_1:Boolean):void
            {
                _ControlUI_MyHRule4.visible = _arg_1;
            }, "_ControlUI_MyHRule4.visible");
            result[23] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("卸下");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                accoutSellBtn.label = _arg_1;
            }, "accoutSellBtn.label");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (takeOffEnable);
            }, function (_arg_1:Boolean):void
            {
                accoutSellBtn.enabled = _arg_1;
            }, "accoutSellBtn.enabled");
            result[25] = binding;
            return (result);
        }

        private function set takeOffEnable(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1321911051takeOffEnable;
            if (_local_2 !== _arg_1)
            {
                this._1321911051takeOffEnable = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "takeOffEnable", _local_2, _arg_1));
            };
        }

        public function __AttackersBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get politiciansBtn():Button
        {
            return (this._1740896083politiciansBtn);
        }

        [Bindable(event="propertyChange")]
        public function get takeOnBtn():Button
        {
            return (this._1484050358takeOnBtn);
        }

        public function __accoutSellBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function downBack(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("卸下成功"));
                ResponseDispatcher.getInstance().dispatchEvent(new Event(ControlUI.EQUIPMENTUPDATE_EVENT));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __takeOnBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get attriEnable():Boolean
        {
            return (this._1147165637attriEnable);
        }

        [Bindable(event="propertyChange")]
        public function get accoutSellBtn():Button
        {
            return (this._2011996739accoutSellBtn);
        }

        public function __accoutSellBtn_click(_arg_1:MouseEvent):void
        {
            accoutDown();
        }

        public function __WisemenBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function set posId(_arg_1:int):void
        {
            var _local_2:Object = this._106854031posId;
            if (_local_2 !== _arg_1)
            {
                this._106854031posId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "posId", _local_2, _arg_1));
            };
        }

        public function __WisemenBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        public function set WisemenBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._499518058WisemenBtn;
            if (_local_2 !== _arg_1)
            {
                this._499518058WisemenBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "WisemenBtn", _local_2, _arg_1));
            };
        }

        public function __politiciansBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        private function clickHandle(_arg_1:Event):void
        {
            var _local_2:int;
            switch (_arg_1.target.id)
            {
                case "politiciansBtn":
                    _local_2 = EquipmentTech.POLITICS;
                    break;
                case "AttackersBtn":
                    _local_2 = EquipmentTech.ATTACK;
                    break;
                case "WisemenBtn":
                    _local_2 = EquipmentTech.INTELLIGENCE;
                    break;
                default:
                    _local_2 = 1;
            };
            var _local_3:int = heroId;
            ActionFactory.getInstance().getEquipmentCommands().WearEquipmenttech(heroId, "0", _local_2, posId, wearTechResponse);
            onClose();
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function __politiciansBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        public function __takeOnBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        public function __politiciansBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function set politiciansBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1740896083politiciansBtn;
            if (_local_2 !== _arg_1)
            {
                this._1740896083politiciansBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "politiciansBtn", _local_2, _arg_1));
            };
        }

        public function __AttackersBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        private function accoutDown():void
        {
            ActionFactory.getInstance().getEquipmentCommands().TakeOffEquipmenttech(heroId, "0", posId, downBack);
            onClose();
        }

        public function __takeOnBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get WisemenBtn():Button
        {
            return (this._499518058WisemenBtn);
        }

        public function __AttackersBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function onChatBtnOver(_arg_1:MouseEvent):void
        {
            if (Button(_arg_1.currentTarget).enabled)
            {
                Button(_arg_1.currentTarget).alpha = 1;
            };
        }

        private function _ControlUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("政治科技");
            _local_1 = attriEnable;
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = Lang.msg("武力科技");
            _local_1 = attriEnable;
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = Lang.msg("智力科技");
            _local_1 = attriEnable;
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = (!(posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L));
            _local_1 = Lang.msg("佩戴");
            _local_1 = ((attriEnable) && (!(takeOffEnable)));
            _local_1 = (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            _local_1 = (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            _local_1 = (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            _local_1 = (posId == EquipmentTech.EQUIPMENT_SLOT_MOUNT_L);
            _local_1 = Lang.msg("卸下");
            _local_1 = takeOffEnable;
        }

        public function set takeOnBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1484050358takeOnBtn;
            if (_local_2 !== _arg_1)
            {
                this._1484050358takeOnBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "takeOnBtn", _local_2, _arg_1));
            };
        }

        public function __WisemenBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get AttackersBtn():Button
        {
            return (this._1175824254AttackersBtn);
        }


    }
}//package view.module.accouter

