// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.newAlliance.CreateWin

package view.module.alliance.newAlliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import view.ui.MyHRule;
    import mx.core.mx_internal;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import com.evony.util.MinePopupManager;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.common.beans.BuildingBean;
    import com.evony.Context;
    import com.evony.common.beans.CastleBean;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.util.InputTextFilter;
    import com.evony.Lang;
    import com.evony.client.action.ActionFactory;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
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

    public class CreateWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _CreateWin_Button1:Button;
        private var _96667352enter:TextInput;
        public var _CreateWin_Label2:Label;
        public var _CreateWin_Text1:Text;
        public var _CreateWin_Label1:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":222,
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
                        "type":Label,
                        "id":"_CreateWin_Label1",
                        "stylesFactory":function ():void
                        {
                            this.textAlign = "center";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":202,
                                "x":123,
                                "y":6,
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "42";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"_CreateWin_Text1",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "1";
                                        this.left = "1";
                                        this.right = "1";
                                        this.color = 0xFFFFFF;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"contentHeader1",
                                            "height":30
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"enter",
                                    "events":{"enter":"__enter_enter"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "37";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":65,
                                            "width":268,
                                            "styleName":"textInput",
                                            "height":25,
                                            "maxChars":8
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.top = "68";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":98});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_CreateWin_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.top = "73";
                                        this.left = "1";
                                        this.right = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "height":22
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":MyHRule,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.bottom = "1";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"percentWidth":98});
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_CreateWin_Button1",
                        "events":{"click":"___CreateWin_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "17";
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"b75"});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___CreateWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                            this.top = "0";
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

        public function CreateWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 222;
            this.addEventListener("creationComplete", ___CreateWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            CreateWin._watcherSetupUtil = _arg_1;
        }


        override public function initialize():void
        {
            var target:CreateWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _CreateWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_newAlliance_CreateWinWatcherSetupUtil");
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

        public function __enter_enter(_arg_1:FlexEvent):void
        {
            onCreateUnion();
        }

        private function onAllianceCreate(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.CALL_OTHER_VIEW, {"id":" "}));
                MinePopupManager.instance.removePopup();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function onCreateUnion():void
        {
            var _local_3:BuildingBean;
            var _local_1:Boolean;
            var _local_2:CastleBean = Context.getInstance().getCurCastle();
            for each (_local_3 in _local_2.buildingsArray)
            {
                if (((_local_3.typeId == BuildingConstants.TYPE_EMBASSY) && (_local_3.level >= 2)))
                {
                    _local_1 = true;
                    break;
                };
            };
            if (_local_1)
            {
                if (InputTextFilter.specialCharFilter(enter.text))
                {
                    AlertWin.show(Lang.msg("输入名字不合法"));
                    return;
                };
                ActionFactory.getInstance().getAllianceManagementCommands().createAlliance(Context.getInstance().getCurCastle().id, enter.text, onAllianceCreate);
            }
            else
            {
                AlertWin.show(Lang.msg("创建联盟,需要2级鸿胪寺"));
            };
        }

        private function init():void
        {
            MinePopupManager.instance.centerPopUp();
            this.enter.setFocus();
        }

        [Bindable(event="propertyChange")]
        public function get enter():TextInput
        {
            return (this._96667352enter);
        }

        public function ___CreateWin_Button1_click(_arg_1:MouseEvent):void
        {
            onCreateUnion();
        }

        public function ___CreateWin_Button2_click(_arg_1:MouseEvent):void
        {
            MinePopupManager.instance.removePopup();
        }

        public function set enter(_arg_1:TextInput):void
        {
            var _local_2:Object = this._96667352enter;
            if (_local_2 !== _arg_1)
            {
                this._96667352enter = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enter", _local_2, _arg_1));
            };
        }

        private function _CreateWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创建联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreateWin_Label1.text = _arg_1;
            }, "_CreateWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟名称");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreateWin_Text1.text = _arg_1;
            }, "_CreateWin_Text1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("创建联盟需要花费");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreateWin_Label2.text = _arg_1;
            }, "_CreateWin_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _CreateWin_Button1.label = _arg_1;
            }, "_CreateWin_Button1.label");
            result[3] = binding;
            return (result);
        }

        private function _CreateWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("创建联盟");
            _local_1 = Lang.msg("联盟名称");
            _local_1 = Lang.msg("创建联盟需要花费");
            _local_1 = Lang.msg("确定");
        }

        public function ___CreateWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.alliance.newAlliance

