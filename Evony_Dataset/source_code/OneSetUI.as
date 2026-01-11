// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.accouter.OneSetUI

package view.module.accouter
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import com.evony.common.module.CommandResponse;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.Event;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.constants.EquipmentTech;
    import com.evony.client.action.ActionFactory;
    import com.evony.Lang;
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

    public class OneSetUI extends Canvas implements IBindingClient 
    {

        public static var instance:OneSetUI = new (OneSetUI)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1740896083politiciansBtn:Button;
        private var _1175824254AttackersBtn:Button;
        private var heroId:int;
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
                                            "width":128,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
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
                                            "width":128,
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
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
                                            "width":128,
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

        public function OneSetUI()
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
            OneSetUI._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:int):void
        {
            instance.heroId = _arg_1;
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, false);
            };
            instance.x = (Application.application.mouseX + 5);
            instance.y = (Application.application.mouseY - 75);
        }


        [Bindable(event="propertyChange")]
        public function get WisemenBtn():Button
        {
            return (this._499518058WisemenBtn);
        }

        private function wearAllResponse(_arg_1:CommandResponse):void
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

        [Bindable(event="propertyChange")]
        public function get AttackersBtn():Button
        {
            return (this._1175824254AttackersBtn);
        }

        private function onChatBtnOut(_arg_1:MouseEvent):void
        {
            Button(_arg_1.currentTarget).alpha = 0;
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

        override public function initialize():void
        {
            var target:OneSetUI;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _OneSetUI_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_accouter_OneSetUIWatcherSetupUtil");
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

        public function __WisemenBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        public function __politiciansBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function __politiciansBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
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
            };
            ActionFactory.getInstance().getEquipmentCommands().WearAllEquipmenttech(heroId, _local_2, wearAllResponse);
            onClose();
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

        public function set WisemenBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._499518058WisemenBtn;
            if (_local_2 !== _arg_1)
            {
                this._499518058WisemenBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "WisemenBtn", _local_2, _arg_1));
            };
        }

        public function __politiciansBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        private function _OneSetUI_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("政治套装");
            _local_1 = Lang.msg("武力套装");
            _local_1 = Lang.msg("智力套装");
        }

        public function __AttackersBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
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

        public function __WisemenBtn_mouseOver(_arg_1:MouseEvent):void
        {
            onChatBtnOver(_arg_1);
        }

        public function __WisemenBtn_mouseOut(_arg_1:MouseEvent):void
        {
            onChatBtnOut(_arg_1);
        }

        private function _OneSetUI_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("政治套装");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                politiciansBtn.label = _arg_1;
            }, "politiciansBtn.label");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("武力套装");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                AttackersBtn.label = _arg_1;
            }, "AttackersBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("智力套装");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                WisemenBtn.label = _arg_1;
            }, "WisemenBtn.label");
            result[2] = binding;
            return (result);
        }


    }
}//package view.module.accouter

