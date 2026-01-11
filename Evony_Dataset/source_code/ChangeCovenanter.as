// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.ChangeCovenanter

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import flash.utils.getDefinitionByName;
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

    public class ChangeCovenanter extends Canvas implements IBindingClient 
    {

        public static var instance:ChangeCovenanter;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1361068424newNames:TextInput;
        public var _ChangeCovenanter_Text1:Text;
        public var _ChangeCovenanter_Button1:Button;
        public var _ChangeCovenanter_Label1:Label;
        private var _1315418018exitBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":170,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":MyWindow,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.horizontalCenter = "0";
                            this.top = "8";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_ChangeCovenanter_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":2,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "20";
                            this.right = "20";
                            this.top = "50";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_ChangeCovenanter_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                        this.top = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"newNames",
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":296,
                                            "y":33,
                                            "styleName":"textInput"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_ChangeCovenanter_Button1",
                        "events":{"click":"___ChangeCovenanter_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":303,
                                "styleName":"b95",
                                "width":95
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"exitBtn",
                        "events":{"click":"__exitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function ChangeCovenanter()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 170;
            this.addEventListener("creationComplete", ___ChangeCovenanter_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            ChangeCovenanter._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (instance == null)
            {
                instance = new (ChangeCovenanter)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
        }


        private function onResetTopPowerForAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("转让盟主成功"));
                ActionFactory.getInstance().getAllianceManagementCommands().getPowerFromAlliance();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __exitBtn_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        public function set newNames(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1361068424newNames;
            if (_local_2 !== _arg_1)
            {
                this._1361068424newNames = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newNames", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get newNames():TextInput
        {
            return (this._1361068424newNames);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_RESET_TOP_POWER_FOR_ALLIANCE, onResetTopPowerForAlliance);
        }

        public function ___ChangeCovenanter_Button1_click(_arg_1:MouseEvent):void
        {
            onChangeSubmit();
        }

        [Bindable(event="propertyChange")]
        public function get exitBtn():Button
        {
            return (this._1315418018exitBtn);
        }

        private function _ChangeCovenanter_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("转让");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChangeCovenanter_Label1.text = _arg_1;
            }, "_ChangeCovenanter_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("新盟主的名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChangeCovenanter_Text1.text = _arg_1;
            }, "_ChangeCovenanter_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("转让");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _ChangeCovenanter_Button1.label = _arg_1;
            }, "_ChangeCovenanter_Button1.label");
            result[2] = binding;
            return (result);
        }

        private function _ChangeCovenanter_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("转让");
            _local_1 = Lang.msg("新盟主的名称");
            _local_1 = Lang.msg("转让");
        }

        public function ___ChangeCovenanter_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function onChangeSubmit():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().resetTopPowerForAlliance(newNames.text);
        }

        override public function initialize():void
        {
            var target:ChangeCovenanter;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _ChangeCovenanter_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_ChangeCovenanterWatcherSetupUtil");
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

        public function set exitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1315418018exitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1315418018exitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "exitBtn", _local_2, _arg_1));
            };
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

