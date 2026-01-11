// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.herosMansion.HeroChangeName

package view.module.herosMansion
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import com.evony.common.beans.HeroBean;
    import mx.controls.TextInput;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.events.Event;
    import com.evony.client.response.ResponseDispatcher;
    import mx.binding.Binding;
    import com.evony.Lang;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.util.InputTextFilter;
    import com.evony.client.action.ActionFactory;
    import com.evony.Context;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.events.FlexEvent;
    import com.evony.util.InputTextControl;
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

    public class HeroChangeName extends Canvas implements IBindingClient 
    {

        public static var instance:HeroChangeName;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _HeroChangeName_Label1:Label;
        public var _HeroChangeName_Label2:Label;
        public var _HeroChangeName_Label3:Label;
        private var _811312001heroMes:HeroBean;
        private var _1845020747newName:TextInput;
        private var _114190243castleName:Label;
        private var _1455232140changeBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":156,
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
                            this.top = "4";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_HeroChangeName_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":4,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"changeBtn",
                        "events":{"click":"__changeBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "20";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":116,
                                "width":80,
                                "height":25,
                                "styleName":"Blue75"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "33";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_HeroChangeName_Label2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"PropertyName2"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({"type":VRule}), new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":50,
                                                        "height":23,
                                                        "styleName":"textBackGroundFillColor",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "id":"_HeroChangeName_Label3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.horizontalCenter = "0";
                                                                this.verticalCenter = "0";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentWidth":100,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"castleName",
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.top = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":198,
                                            "x":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":TextInput,
                                    "id":"newName",
                                    "events":{"change":"__newName_change"},
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "center";
                                        this.top = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"",
                                            "width":195,
                                            "height":24,
                                            "x":201,
                                            "styleName":"textInput"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HeroChangeName_Button2_click"},
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

        public function HeroChangeName()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 156;
            this.addEventListener("creationComplete", ___HeroChangeName_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            HeroChangeName._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object=null):void
        {
            if (instance == null)
            {
                instance = new (HeroChangeName)();
            };
            PopUpManager.addPopUp(instance, MainFrame.instance, true);
            PopUpManager.centerPopUp(instance);
            instance.newName.text = "";
            instance.heroMes = HeroBean(_arg_1);
        }


        [Bindable(event="propertyChange")]
        private function get heroMes():HeroBean
        {
            return (this._811312001heroMes);
        }

        public function set newName(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1845020747newName;
            if (_local_2 !== _arg_1)
            {
                this._1845020747newName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newName", _local_2, _arg_1));
            };
        }

        public function __newName_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        public function set castleName(_arg_1:Label):void
        {
            var _local_2:Object = this._114190243castleName;
            if (_local_2 !== _arg_1)
            {
                this._114190243castleName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleName", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.HERO_CHANGE_NAME, onChangeName);
        }

        private function _HeroChangeName_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("英雄改名");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroChangeName_Label1.text = _arg_1;
            }, "_HeroChangeName_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("更改");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                changeBtn.label = _arg_1;
            }, "changeBtn.label");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("将领");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroChangeName_Label2.text = _arg_1;
            }, "_HeroChangeName_Label2.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("新名字");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _HeroChangeName_Label3.text = _arg_1;
            }, "_HeroChangeName_Label3.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = heroMes.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                castleName.text = _arg_1;
            }, "castleName.text");
            result[4] = binding;
            return (result);
        }

        private function onChangeName(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function changeName(_arg_1:MouseEvent):void
        {
            if (InputTextFilter.specialCharFilter(newName.text))
            {
                AlertWin.show(Lang.msg("名字不合法"));
                return;
            };
            ActionFactory.getInstance().getHeroCommand().changeName(Context.getInstance().getCurCastle().id, heroMes.id, newName.text);
            PopUpManager.removePopUp(this);
        }

        private function onExit():void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        public function get changeBtn():Button
        {
            return (this._1455232140changeBtn);
        }

        private function _HeroChangeName_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("英雄改名");
            _local_1 = Lang.msg("更改");
            _local_1 = Lang.msg("将领");
            _local_1 = Lang.msg("新名字");
            _local_1 = heroMes.name;
        }

        override public function initialize():void
        {
            var target:HeroChangeName;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _HeroChangeName_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_herosMansion_HeroChangeNameWatcherSetupUtil");
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
        public function get castleName():Label
        {
            return (this._114190243castleName);
        }

        public function ___HeroChangeName_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set heroMes(_arg_1:HeroBean):void
        {
            var _local_2:Object = this._811312001heroMes;
            if (_local_2 !== _arg_1)
            {
                this._811312001heroMes = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "heroMes", _local_2, _arg_1));
            };
        }

        public function __changeBtn_click(_arg_1:MouseEvent):void
        {
            changeName(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get newName():TextInput
        {
            return (this._1845020747newName);
        }

        private function checkString(_arg_1:String):Boolean
        {
            var _local_2:Boolean;
            var _local_3:* = "~!@#$% ^&*()|+?><\"';:/[]{}=/";
            var _local_4:Array = _arg_1.split("");
            var _local_5:int;
            while (_local_5 < _local_4.length)
            {
                if (_local_3.indexOf(_local_4[_local_5]) > -1)
                {
                    _local_2 = true;
                    break;
                };
                _local_5++;
            };
            return (_local_2);
        }

        public function set changeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1455232140changeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1455232140changeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeBtn", _local_2, _arg_1));
            };
        }

        private function textChange(_arg_1:Event):void
        {
            var _local_4:String;
            var _local_2:int;
            TextInput(_arg_1.currentTarget).maxChars = 20;
            InputTextControl.textChange(_arg_1);
            var _local_3:int;
            while (_local_3 < _arg_1.target.text.length)
            {
                _local_4 = _arg_1.target.text.substr(_local_3, 1);
                if (InputTextFilter.isChinese(_local_4))
                {
                    _local_2 = (_local_2 + 2);
                }
                else
                {
                    _local_2 = (_local_2 + 1);
                };
                if (((_arg_1.currentTarget == this.newName) && (_local_2 > 10)))
                {
                    this.newName.text = this.newName.text.substring(0, _local_3);
                    this.newName.maxChars = this.newName.length;
                    return;
                };
                _local_3++;
            };
        }

        public function ___HeroChangeName_Button2_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }


    }
}//package view.module.herosMansion

