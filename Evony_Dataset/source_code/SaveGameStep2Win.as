// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.SaveGameStep2Win

package view.module.guide
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.RadioButton;
    import mx.controls.TextInput;
    import mx.controls.RadioButtonGroup;
    import mx.controls.Image;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Button;
    import mx.containers.VBox;
    import mx.controls.Label;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.client.action.ActionFactory;
    import mx.events.ItemClickEvent;
    import com.evony.Context;
    import com.evony.eum.LogoEumDefine;
    import flash.events.MouseEvent;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
    import com.evony.Lang;
    import com.evony.util.InputTextControl;
    import com.evony.util.InputTextFilter;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.util.UIUtil;
    import view.MainWin;
    import view.doubleBuilding;
    import com.evony.common.module.common.ChangeUserFaceResponse;
    import com.evony.util.MinePopupManager;
    import flash.external.ExternalInterface;
    import mx.events.FlexEvent;
    import view.castle.MainFrame;
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

    public class SaveGameStep2Win extends Canvas implements IBindingClient 
    {

        private static var instance:SaveGameStep2Win;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _SaveGameStep2Win_RadioButton3:RadioButton;
        public var _SaveGameStep2Win_RadioButton4:RadioButton;
        public var _SaveGameStep2Win_RadioButton5:RadioButton;
        public var _SaveGameStep2Win_RadioButton2:RadioButton;
        public var _SaveGameStep2Win_RadioButton6:RadioButton;
        private var _1213385727nameInput:TextInput;
        private var _642046766SexFlag:Boolean = true;
        private var password:String;
        private var _966124317cp_name:RadioButtonGroup;
        private var _1354303084cp_sex:RadioButtonGroup;
        public var _SaveGameStep2Win_Image1:Image;
        public var _SaveGameStep2Win_Canvas3:Canvas;
        private var username:String;
        private var sex:int = 0;
        private var _1141382678preSetName:String;
        private var _571486424faceSource:String;
        private var _1121153358userNameError:Text;
        private var faceIndex:int = 0;
        private var _1195985039needSelName:Boolean;
        public var _SaveGameStep2Win_RadioButton1:RadioButton;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":420,
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
                        "type":Button,
                        "events":{"click":"___SaveGameStep2Win_Button1_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "39";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.verticalGap = 0;
                            this.left = "40";
                            this.right = "40";
                            this.top = "60";
                            this.bottom = "32";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"doubleLineBlue",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":61,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "25";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "y":10,
                                                        "text":"What would you like to be known as in Evony?"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"nameInput",
                                                "events":{"change":"__nameInput_change"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":40,
                                                        "y":34,
                                                        "maxChars":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"_SaveGameStep2Win_Canvas3",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":150,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"userNameError",
                                                "stylesFactory":function ():void
                                                {
                                                    this.color = 0xFF0000;
                                                    this.left = "25";
                                                    this.right = "25";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "y":2,
                                                        "height":44
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":43,
                                                        "y":35,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_name"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_name"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_name"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_name"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":175,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "25";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "y":11,
                                                        "text":"Select your sex and portrait:"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.horizontalCenter = "-60";
                                                    this.horizontalAlign = "center";
                                                    this.top = "150";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 10;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___SaveGameStep2Win_Button2_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"previous"});
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Button,
                                                                        "events":{"click":"___SaveGameStep2Win_Button3_click"},
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({"styleName":"next"});
                                                                        }
                                                                    })]});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_SaveGameStep2Win_Image1",
                                                "events":{"complete":"___SaveGameStep2Win_Image1_complete"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "36";
                                                    this.horizontalCenter = "-60";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "height":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalGap = 0;
                                                    this.horizontalAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":180,
                                                        "y":66,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_sex"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":RadioButton,
                                                            "id":"_SaveGameStep2Win_RadioButton6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.color = 5312268;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"registerText",
                                                                    "groupName":"cp_sex"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":40,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___SaveGameStep2Win_Button4_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "y":8,
                                                        "label":"set",
                                                        "styleName":"b75"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    })]
                });
            }
        });
        private var faceArray:ArrayCollection = new ArrayCollection();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SaveGameStep2Win()
        {
            mx_internal::_document = this;
            this.width = 420;
            _SaveGameStep2Win_RadioButtonGroup1_i();
            _SaveGameStep2Win_RadioButtonGroup2_i();
            this.addEventListener("creationComplete", ___SaveGameStep2Win_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SaveGameStep2Win._watcherSetupUtil = _arg_1;
        }

        public static function getInstance():SaveGameStep2Win
        {
            if (instance == null)
            {
                instance = new (SaveGameStep2Win)();
            };
            return (instance);
        }


        private function onSet():void
        {
            modifyName();
        }

        public function set nameInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._1213385727nameInput;
            if (_local_2 !== _arg_1)
            {
                this._1213385727nameInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nameInput", _local_2, _arg_1));
            };
        }

        private function _SaveGameStep2Win_RadioButtonGroup1_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            cp_name = _local_1;
            _local_1.addEventListener("itemClick", __cp_name_itemClick);
            _local_1.initialized(this, "cp_name");
            return (_local_1);
        }

        override public function initialize():void
        {
            var target:SaveGameStep2Win;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SaveGameStep2Win_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_guide_SaveGameStep2WinWatcherSetupUtil");
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

        private function submitFace():void
        {
            ActionFactory.getInstance().getCommonCommands().changeUserFace(this.faceSource, this.sex, onChangeResponse);
        }

        private function handleSex(_arg_1:ItemClickEvent):void
        {
            this.sex = _arg_1.index;
            if (sex == 0)
            {
                this.SexFlag = true;
            }
            else
            {
                this.SexFlag = false;
            };
            this.resetFaceArray();
        }

        private function init():void
        {
            this.sex = Context.getInstance().getPlayerBean().playerInfo.sex;
            if (Context.getInstance().getPlayerBean().playerInfo.sex == 0)
            {
                SexFlag = true;
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                SexFlag = false;
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            var _local_1:int;
            while (_local_1 < this.faceArray.length)
            {
                if (this.faceArray[_local_1].toString() == Context.getInstance().getPlayerBean().playerInfo.faceUrl)
                {
                    this.faceIndex = _local_1;
                    break;
                };
                _local_1++;
            };
            this.faceSource = this.faceArray[faceIndex];
        }

        [Bindable(event="propertyChange")]
        public function get nameInput():TextInput
        {
            return (this._1213385727nameInput);
        }

        [Bindable(event="propertyChange")]
        public function get cp_sex():RadioButtonGroup
        {
            return (this._1354303084cp_sex);
        }

        [Bindable(event="propertyChange")]
        public function get cp_name():RadioButtonGroup
        {
            return (this._966124317cp_name);
        }

        private function set needSelName(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1195985039needSelName;
            if (_local_2 !== _arg_1)
            {
                this._1195985039needSelName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "needSelName", _local_2, _arg_1));
            };
        }

        public function ___SaveGameStep2Win_Button2_click(_arg_1:MouseEvent):void
        {
            changeFace(-1);
        }

        public function ___SaveGameStep2Win_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function ___SaveGameStep2Win_Button4_click(_arg_1:MouseEvent):void
        {
            onSet();
        }

        private function set SexFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._642046766SexFlag;
            if (_local_2 !== _arg_1)
            {
                this._642046766SexFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "SexFlag", _local_2, _arg_1));
            };
        }

        private function changeFace(_arg_1:int):void
        {
            this.faceIndex = (this.faceIndex + _arg_1);
            if (this.faceIndex < 0)
            {
                this.faceIndex = (this.faceArray.length - 1);
            }
            else
            {
                if (this.faceIndex >= this.faceArray.length)
                {
                    this.faceIndex = 0;
                };
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }

        public function set cp_sex(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._1354303084cp_sex;
            if (_local_2 !== _arg_1)
            {
                this._1354303084cp_sex = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_sex", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get userNameError():Text
        {
            return (this._1121153358userNameError);
        }

        private function _SaveGameStep2Win_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = needSelName;
            _local_1 = needSelName;
            _local_1 = (preSetName + "cool");
            _local_1 = (preSetName + "good");
            _local_1 = (preSetName + "great");
            _local_1 = (preSetName + "best");
            _local_1 = this.faceSource;
            _local_1 = Lang.msg("男");
            _local_1 = ((SexFlag) ? true : false);
            _local_1 = Lang.msg("女");
            _local_1 = ((SexFlag) ? false : true);
        }

        private function set faceSource(_arg_1:String):void
        {
            var _local_2:Object = this._571486424faceSource;
            if (_local_2 !== _arg_1)
            {
                this._571486424faceSource = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "faceSource", _local_2, _arg_1));
            };
        }

        public function __cp_sex_itemClick(_arg_1:ItemClickEvent):void
        {
            handleSex(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get needSelName():Boolean
        {
            return (this._1195985039needSelName);
        }

        private function textChange(_arg_1:Event):void
        {
            var _local_5:String;
            var _local_2:int;
            TextInput(_arg_1.currentTarget).maxChars = 20;
            var _local_3:String = nameInput.text;
            InputTextControl.textChange(_arg_1);
            var _local_4:int;
            while (_local_4 < nameInput.text.length)
            {
                _local_5 = nameInput.text.substr(_local_4, 1);
                if (InputTextFilter.isChinese(_local_5))
                {
                    _local_2 = (_local_2 + 2);
                }
                else
                {
                    _local_2 = (_local_2 + 1);
                };
                if (((_arg_1.currentTarget == this.nameInput) && (_local_2 > 10)))
                {
                    this.nameInput.text = this.nameInput.text.substring(0, _local_4);
                    this.nameInput.maxChars = this.nameInput.length;
                    return;
                };
                _local_4++;
            };
        }

        public function set cp_name(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._966124317cp_name;
            if (_local_2 !== _arg_1)
            {
                this._966124317cp_name = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cp_name", _local_2, _arg_1));
            };
        }

        public function __cp_name_itemClick(_arg_1:ItemClickEvent):void
        {
            handleName(_arg_1);
        }

        private function modifyNameResponse(_arg_1:CommandResponse):void
        {
            if (((!(_arg_1.errorMsg == null)) && (!(_arg_1.errorMsg.indexOf("That lord name already exists") == -1))))
            {
                userNameError.text = "The user name has been registered. Below are some recommended user names.";
                needSelName = true;
                return;
            };
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                submitFace();
            }
            else
            {
                userNameError.text = _arg_1.errorMsg;
            };
        }

        public function ___SaveGameStep2Win_Button1_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function _SaveGameStep2Win_RadioButtonGroup2_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            cp_sex = _local_1;
            _local_1.addEventListener("itemClick", __cp_sex_itemClick);
            _local_1.initialized(this, "cp_sex");
            return (_local_1);
        }

        private function onChangeResponse(_arg_1:ChangeUserFaceResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                Context.getInstance().getPlayerBean().playerInfo.faceUrl = this.faceSource;
                onClose();
                AlertWin.show("Save game successfully.");
                Context.getInstance().bSaveGame = true;
                if (UIUtil.judgeTime() < 3)
                {
                    if (((MainWin) && (MainWin.instance)))
                    {
                        doubleBuilding.show();
                        MainWin.instance.buff.bar.refreshBuff();
                    };
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get SexFlag():Boolean
        {
            return (this._642046766SexFlag);
        }

        private function handleName(_arg_1:ItemClickEvent):void
        {
            nameInput.text = _arg_1.target.selectedValue;
        }

        public function __nameInput_change(_arg_1:Event):void
        {
            textChange(_arg_1);
        }

        private function onClose():void
        {
            showSocialBar();
            trace("show social bar");
            MinePopupManager.instance.removePopup();
        }

        private function _SaveGameStep2Win_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (needSelName);
            }, function (_arg_1:Boolean):void
            {
                _SaveGameStep2Win_Canvas3.includeInLayout = _arg_1;
            }, "_SaveGameStep2Win_Canvas3.includeInLayout");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (needSelName);
            }, function (_arg_1:Boolean):void
            {
                _SaveGameStep2Win_Canvas3.visible = _arg_1;
            }, "_SaveGameStep2Win_Canvas3.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (preSetName + "cool");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton1.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton1.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (preSetName + "good");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton2.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton2.label");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (preSetName + "great");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton3.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton3.label");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (preSetName + "best");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton4.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton4.label");
            result[5] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.faceSource);
            }, function (_arg_1:Object):void
            {
                _SaveGameStep2Win_Image1.source = _arg_1;
            }, "_SaveGameStep2Win_Image1.source");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("男");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton5.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton5.label");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((SexFlag) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _SaveGameStep2Win_RadioButton5.selected = _arg_1;
            }, "_SaveGameStep2Win_RadioButton5.selected");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("女");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _SaveGameStep2Win_RadioButton6.label = _arg_1;
            }, "_SaveGameStep2Win_RadioButton6.label");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((SexFlag) ? false : true);
            }, function (_arg_1:Boolean):void
            {
                _SaveGameStep2Win_RadioButton6.selected = _arg_1;
            }, "_SaveGameStep2Win_RadioButton6.selected");
            result[10] = binding;
            return (result);
        }

        public function ___SaveGameStep2Win_Button3_click(_arg_1:MouseEvent):void
        {
            changeFace(1);
        }

        [Bindable(event="propertyChange")]
        private function get faceSource():String
        {
            return (this._571486424faceSource);
        }

        private function set preSetName(_arg_1:String):void
        {
            var _local_2:Object = this._1141382678preSetName;
            if (_local_2 !== _arg_1)
            {
                this._1141382678preSetName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "preSetName", _local_2, _arg_1));
            };
        }

        private function modifyName():void
        {
            if (cp_name.selectedValue == null)
            {
                preSetName = nameInput.text;
            };
            ActionFactory.getInstance().getCityCommands().modifyUserName(this.nameInput.text, "player.name.1.a", modifyNameResponse);
        }

        private function showSocialBar():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("socialBar.showSocialBar");
            };
        }

        public function set userNameError(_arg_1:Text):void
        {
            var _local_2:Object = this._1121153358userNameError;
            if (_local_2 !== _arg_1)
            {
                this._1121153358userNameError = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "userNameError", _local_2, _arg_1));
            };
        }

        private function resetFaceArray():void
        {
            this.faceIndex = 0;
            if (this.sex == 0)
            {
                this.faceArray = LogoEumDefine.getMalePlayerLogoArray();
            }
            else
            {
                this.faceArray = LogoEumDefine.getFemalePlayerLogoArray();
            };
            this.faceSource = this.faceArray[this.faceIndex];
        }

        [Bindable(event="propertyChange")]
        private function get preSetName():String
        {
            return (this._1141382678preSetName);
        }

        public function ___SaveGameStep2Win_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


    }
}//package view.module.guide

