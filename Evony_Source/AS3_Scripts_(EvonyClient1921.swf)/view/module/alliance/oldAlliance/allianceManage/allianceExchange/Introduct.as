// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceManage.allianceExchange.Introduct

package view.module.alliance.oldAlliance.allianceManage.allianceExchange
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import com.evony.common.beans.IndexAllianceInfoBean;
    import mx.controls.TextArea;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.common.module.CommandResponse;
    import com.evony.client.action.ActionFactory;
    import com.evony.MsgDispacther;
    import com.evony.events.WindowChangeEvent;
    import view.module.alliance.AllianceWin;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.alliance.HasAllianceResponse;
    import com.evony.Lang;
    import mx.events.FlexEvent;
    import com.evony.util.InputTextFilter;
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

    public class Introduct extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1981656776textInputName:TextInput;
        public var _Introduct_Label1:Label;
        public var _Introduct_Label2:Label;
        public var _Introduct_Label3:Label;
        public var _Introduct_Label5:Label;
        public var _Introduct_Label4:Label;
        private var _1515842358unionArray:IndexAllianceInfoBean;
        private var _1753466763allianceIntro:TextArea;
        private var _1606154441allianceNote:TextArea;
        public var _Introduct_Button1:Button;
        public var _Introduct_Button2:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"allianceIntro",
                        "stylesFactory":function ():void
                        {
                            this.top = "75";
                            this.left = "5";
                            this.right = "5";
                            this.textAlign = "left";
                            this.bottom = "260";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"inputArea",
                                "maxChars":200
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":TextArea,
                        "id":"allianceNote",
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.right = "5";
                            this.bottom = "36";
                            this.top = "230";
                            this.textAlign = "left";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"inputArea",
                                "maxChars":200
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Introduct_Button1",
                        "events":{"click":"___Introduct_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "7";
                            this.right = "135";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":95,
                                "styleName":"b95"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"_Introduct_Button2",
                        "events":{"click":"___Introduct_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "7";
                            this.right = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":95,
                                "styleName":"b95"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "5";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":245,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Introduct_Label1",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "5";
                                        this.textAlign = "right";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"textInputName",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "115";
                                        this.backgroundDisabledColor = 16708814;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textInput",
                                            "width":130,
                                            "enabled":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":310,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Introduct_Label2",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":110,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Introduct_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":194,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "5";
                            this.top = "195";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":275,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Introduct_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.left = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":130,
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_Introduct_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.right = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
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

        public function Introduct()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___Introduct_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            Introduct._watcherSetupUtil = _arg_1;
        }


        private function onSetAllInfoForAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance();
                MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___Introduct_Button1_click(_arg_1:MouseEvent):void
        {
            onSubmit();
        }

        public function set allianceNote(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1606154441allianceNote;
            if (_local_2 !== _arg_1)
            {
                this._1606154441allianceNote = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceNote", _local_2, _arg_1));
            };
        }

        private function set unionArray(_arg_1:IndexAllianceInfoBean):void
        {
            var _local_2:Object = this._1515842358unionArray;
            if (_local_2 !== _arg_1)
            {
                this._1515842358unionArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionArray", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:Introduct;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _Introduct_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceManage_allianceExchange_IntroductWatcherSetupUtil");
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

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALL_INFO_FOR_ALLIANCE, onSetAllInfoForAlliance);
            if (this.initialized)
            {
                this.refresh();
            };
        }

        private function onIsHasAlliance(_arg_1:HasAllianceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                unionArray = _arg_1.indexAllianceInfoBean;
            };
        }

        private function _Introduct_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = unionArray.allianceInfo;
            _local_1 = unionArray.allianceNote;
            _local_1 = Lang.msg("确定");
            _local_1 = Lang.msg("返回");
            _local_1 = (Lang.msg("联盟名称") + ": ");
            _local_1 = unionArray.allianceName;
            _local_1 = Lang.msg("联盟介绍");
            _local_1 = Lang.msg("联盟介绍最大长度");
            _local_1 = Lang.msg("联盟公告");
            _local_1 = Lang.msg("联盟公告最大长度");
        }

        public function ___Introduct_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        public function get textInputName():TextInput
        {
            return (this._1981656776textInputName);
        }

        [Bindable(event="propertyChange")]
        public function get allianceNote():TextArea
        {
            return (this._1606154441allianceNote);
        }

        [Bindable(event="propertyChange")]
        private function get unionArray():IndexAllianceInfoBean
        {
            return (this._1515842358unionArray);
        }

        public function set _unionArray(_arg_1:IndexAllianceInfoBean):void
        {
            unionArray = _arg_1;
        }

        public function set textInputName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1981656776textInputName;
            if (_local_2 !== _arg_1)
            {
                this._1981656776textInputName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textInputName", _local_2, _arg_1));
            };
        }

        private function onSubmit():void
        {
            if (InputTextFilter.specialCharFilter(textInputName.text))
            {
                AlertWin.show(Lang.msg("输入名字不合法"));
                return;
            };
            ActionFactory.getInstance().getAllianceManagementCommands().setAllInfoForAlliance(textInputName.text, allianceIntro.text, allianceNote.text);
        }

        public function ___Introduct_Button2_click(_arg_1:MouseEvent):void
        {
            MsgDispacther.getInstance().dispatchEvent(new WindowChangeEvent(AllianceWin.SUBWINDOW_CLOSE));
        }

        public function refresh():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().isHasAlliance(onIsHasAlliance);
            this.textInputName.setFocus();
        }

        private function _Introduct_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = unionArray.allianceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceIntro.text = _arg_1;
            }, "allianceIntro.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = unionArray.allianceNote;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceNote.text = _arg_1;
            }, "allianceNote.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确定");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Button1.label = _arg_1;
            }, "_Introduct_Button1.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("返回");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Button2.label = _arg_1;
            }, "_Introduct_Button2.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟名称") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Label1.text = _arg_1;
            }, "_Introduct_Label1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = unionArray.allianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                textInputName.text = _arg_1;
            }, "textInputName.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟介绍");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Label2.text = _arg_1;
            }, "_Introduct_Label2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟介绍最大长度");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Label3.text = _arg_1;
            }, "_Introduct_Label3.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟公告");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Label4.text = _arg_1;
            }, "_Introduct_Label4.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟公告最大长度");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _Introduct_Label5.text = _arg_1;
            }, "_Introduct_Label5.text");
            result[9] = binding;
            return (result);
        }

        public function set allianceIntro(_arg_1:TextArea):void
        {
            var _local_2:Object = this._1753466763allianceIntro;
            if (_local_2 !== _arg_1)
            {
                this._1753466763allianceIntro = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceIntro", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceIntro():TextArea
        {
            return (this._1753466763allianceIntro);
        }

        public function destroy():void
        {
        }


    }
}//package view.module.alliance.oldAlliance.allianceManage.allianceExchange

