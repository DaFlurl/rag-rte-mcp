// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.AccountProtectionWin

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.TextInput;
    import mx.controls.Text;
    import mx.containers.ViewStack;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import view.castle.MainFrame;
    import mx.core.Application;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import mx.events.ListEvent;
    import com.evony.Context;
    import view.ui.AlertWin;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import com.evony.GameConfig;
    import flash.net.URLRequestMethod;
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

    public class AccountProtectionWin extends Canvas implements IBindingClient 
    {

        public static var instance:AccountProtectionWin = new (AccountProtectionWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _109757594suBtn:Button;
        private var _2560Q1:ComboBox;
        private var _2562Q3:ComboBox;
        private var _375617097Q2Input:TextInput;
        private var _404246248Q3Input:TextInput;
        private var _346987946Q1Input:TextInput;
        private var _328770477mailInput:TextInput;
        public var _AccountProtectionWin_Text1:Text;
        private var _2561Q2:ComboBox;
        private var _946505330viewstack1:ViewStack;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":600,
                    "height":400,
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
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
                                            "text":"Password Protection",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.top = "84";
                            this.right = "40";
                            this.bottom = "82";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.borderStyle = "solid";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"View 1",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"textBackGroundFillColor",
                                                        "x":0,
                                                        "y":0,
                                                        "percentWidth":100,
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                                this.fontSize = 14;
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"focusColor",
                                                                    "x":220,
                                                                    "text":"Fill the answers"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "149";
                                                    this.right = "40";
                                                    this.left = "20";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "height":25,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Question 1:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"Q1",
                                                            "events":{"change":"__Q1_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":360,
                                                                    "styleName":"ParamgraphText2"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "122";
                                                    this.right = "40";
                                                    this.left = "40";
                                                    this.horizontalGap = 8;
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Answer:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"Q1Input",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":360});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "92";
                                                    this.right = "40";
                                                    this.left = "20";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Question 2:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"Q2",
                                                            "events":{"change":"__Q2_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":360,
                                                                    "styleName":"ParamgraphText2"
                                                                });
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "65";
                                                    this.right = "40";
                                                    this.left = "40";
                                                    this.horizontalGap = 8;
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Answer:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"Q2Input",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":360});
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "37";
                                                    this.right = "40";
                                                    this.left = "20";
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Question 3:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":ComboBox,
                                                            "id":"Q3",
                                                            "events":{"change":"__Q3_change"},
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "width":360,
                                                                    "styleName":"ParamgraphText2"
                                                                });
                                                            }
                                                        })]});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.bottom = "11";
                                                    this.right = "40";
                                                    this.left = "40";
                                                    this.horizontalGap = 8;
                                                    this.verticalAlign = "middle";
                                                    this.horizontalAlign = "right";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "text":"Answer:"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":TextInput,
                                                            "id":"Q3Input",
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({"width":360});
                                                            }
                                                        })]});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"View 2",
                                            "percentWidth":100,
                                            "percentHeight":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Canvas,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"textBackGroundFillColor",
                                                        "x":0,
                                                        "y":0,
                                                        "percentWidth":100,
                                                        "height":30,
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "center";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "styleName":"PropertyName1",
                                                                    "x":145,
                                                                    "y":4,
                                                                    "text":"Your E-mail"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"PropertyName1",
                                                        "x":33,
                                                        "y":50,
                                                        "text":"E-mail:"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"mailInput",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":98,
                                                        "y":49,
                                                        "width":288
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_AccountProtectionWin_Text1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "x":33,
                                                        "y":113,
                                                        "height":96,
                                                        "width":350,
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"suBtn",
                        "events":{"click":"__suBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"b135",
                                "x":253,
                                "label":"Next",
                                "width":135
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AccountProtectionWin_Button2_click"},
                        "stylesFactory":function ():void
                        {
                            this.right = "41";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "y":0,
                                "styleName":"close"
                            });
                        }
                    })]
                });
            }
        });
        private var qs1:Object = {
            "label":"What is the name of your pet?",
            "data":0
        };
        private var qs2:Object = {
            "label":"What is your first name?",
            "data":1
        };
        private var qs3:Object = {
            "label":"What is your favorite hobby?",
            "data":2
        };
        private var qs4:Object = {
            "label":"Where is your birthplace?",
            "data":3
        };
        private var _76331073Q1Arr:Array = new Array(qs3, qs4);
        private var _76360864Q2Arr:Array = new Array(qs1, qs3, qs4);
        private var _76390655Q3Arr:Array = new Array(qs2, qs3, qs4);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AccountProtectionWin()
        {
            mx_internal::_document = this;
            this.width = 600;
            this.height = 400;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AccountProtectionWin._watcherSetupUtil = _arg_1;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                PopUpManager.addPopUp(instance, MainFrame.instance, true);
                if ((Application.application.width - instance.width) > 0)
                {
                    instance.x = (((Application.application.width - instance.width) / 2) - 150);
                    instance.y = (((Application.application.height - instance.height) / 2) - 30);
                    PopUpManager.bringToFront(instance);
                }
                else
                {
                    PopUpManager.centerPopUp(instance);
                };
            };
        }


        [Bindable(event="propertyChange")]
        public function get Q1():ComboBox
        {
            return (this._2560Q1);
        }

        [Bindable(event="propertyChange")]
        public function get Q2():ComboBox
        {
            return (this._2561Q2);
        }

        public function set Q2(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2561Q2;
            if (_local_2 !== _arg_1)
            {
                this._2561Q2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q2", _local_2, _arg_1));
            };
        }

        private function _AccountProtectionWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.Q1Arr;
            _local_1 = this.Q2Arr;
            _local_1 = this.Q3Arr;
            _local_1 = Lang.msg("确保邮箱正确");
        }

        public function set Q3(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2562Q3;
            if (_local_2 !== _arg_1)
            {
                this._2562Q3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q3", _local_2, _arg_1));
            };
        }

        public function set Q1(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._2560Q1;
            if (_local_2 !== _arg_1)
            {
                this._2560Q1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get Q3():ComboBox
        {
            return (this._2562Q3);
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        private function set Q1Arr(_arg_1:Array):void
        {
            var _local_2:Object = this._76331073Q1Arr;
            if (_local_2 !== _arg_1)
            {
                this._76331073Q1Arr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q1Arr", _local_2, _arg_1));
            };
        }

        public function set Q2Input(_arg_1:TextInput):void
        {
            var _local_2:Object = this._375617097Q2Input;
            if (_local_2 !== _arg_1)
            {
                this._375617097Q2Input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q2Input", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:AccountProtectionWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AccountProtectionWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_playerInfo_AccountProtectionWinWatcherSetupUtil");
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
        public function get suBtn():Button
        {
            return (this._109757594suBtn);
        }

        public function set viewstack1(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._946505330viewstack1;
            if (_local_2 !== _arg_1)
            {
                this._946505330viewstack1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewstack1", _local_2, _arg_1));
            };
        }

        public function ___AccountProtectionWin_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function __Q3_change(_arg_1:ListEvent):void
        {
            changSel(_arg_1);
        }

        [Bindable(event="propertyChange")]
        private function get Q2Arr():Array
        {
            return (this._76360864Q2Arr);
        }

        [Bindable(event="propertyChange")]
        public function get Q1Input():TextInput
        {
            return (this._346987946Q1Input);
        }

        public function set suBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._109757594suBtn;
            if (_local_2 !== _arg_1)
            {
                this._109757594suBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "suBtn", _local_2, _arg_1));
            };
        }

        public function set mailInput(_arg_1:TextInput):void
        {
            var _local_2:Object = this._328770477mailInput;
            if (_local_2 !== _arg_1)
            {
                this._328770477mailInput = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mailInput", _local_2, _arg_1));
            };
        }

        private function completeHandle(_arg_1:Event):void
        {
            if (_arg_1.target.data == "E01")
            {
                this.onClose();
                Context.getInstance().noAccountProtection = false;
                AlertWin.show(Lang.msg("密保资料保存成功"));
            }
            else
            {
                if (_arg_1.target.data == "E08")
                {
                    AlertWin.show(Lang.msg("邮箱格式不正确"));
                }
                else
                {
                    AlertWin.show(Lang.msg("密保资料保存失败"));
                };
            };
        }

        public function __suBtn_click(_arg_1:MouseEvent):void
        {
            clickHandle(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get Q2Input():TextInput
        {
            return (this._375617097Q2Input);
        }

        private function changSel(_arg_1:Event):void
        {
            var _local_2:Object;
            switch (_arg_1.target.name)
            {
                case "Q1":
                    if (this.Q1.selectedIndex == 1)
                    {
                        _local_2 = this.Q1Arr[0];
                        this.Q1Arr[0] = this.Q1Arr[1];
                        this.Q1Arr[1] = _local_2;
                    }
                    else
                    {
                        if (this.Q1.selectedIndex == 2)
                        {
                            _local_2 = this.Q1Arr[0];
                            this.Q1Arr[0] = this.Q1Arr[2];
                            this.Q1Arr[2] = _local_2;
                        };
                    };
                    this.Q2Arr[1] = this.Q1Arr[1];
                    this.Q2Arr[2] = this.Q1Arr[2];
                    this.Q3Arr[1] = this.Q1Arr[1];
                    this.Q3Arr[2] = this.Q1Arr[2];
                    break;
                case "Q2":
                    if (this.Q2.selectedIndex == 1)
                    {
                        _local_2 = this.Q2Arr[0];
                        this.Q2Arr[0] = this.Q2Arr[1];
                        this.Q2Arr[1] = _local_2;
                    }
                    else
                    {
                        if (this.Q2.selectedIndex == 2)
                        {
                            _local_2 = this.Q2Arr[0];
                            this.Q2Arr[0] = this.Q2Arr[2];
                            this.Q2Arr[2] = _local_2;
                        };
                    };
                    this.Q1Arr[1] = this.Q2Arr[1];
                    this.Q1Arr[2] = this.Q2Arr[2];
                    this.Q3Arr[1] = this.Q2Arr[1];
                    this.Q3Arr[2] = this.Q2Arr[2];
                    break;
                case "Q3":
                    if (this.Q3.selectedIndex == 1)
                    {
                        _local_2 = this.Q3Arr[0];
                        this.Q3Arr[0] = this.Q3Arr[1];
                        this.Q3Arr[1] = _local_2;
                    }
                    else
                    {
                        if (this.Q3.selectedIndex == 2)
                        {
                            _local_2 = this.Q3Arr[0];
                            this.Q3Arr[0] = this.Q3Arr[2];
                            this.Q3Arr[2] = _local_2;
                        };
                    };
                    this.Q1Arr[1] = this.Q3Arr[1];
                    this.Q1Arr[2] = this.Q3Arr[2];
                    this.Q2Arr[1] = this.Q3Arr[1];
                    this.Q2Arr[2] = this.Q3Arr[2];
                    break;
            };
            _arg_1.target.selectedIndex = 0;
        }

        public function __Q2_change(_arg_1:ListEvent):void
        {
            changSel(_arg_1);
        }

        private function errorHandle(_arg_1:IOErrorEvent):void
        {
            AlertWin.show(Lang.msg("密保资料保存失败网络原因"));
        }

        public function set Q1Input(_arg_1:TextInput):void
        {
            var _local_2:Object = this._346987946Q1Input;
            if (_local_2 !== _arg_1)
            {
                this._346987946Q1Input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q1Input", _local_2, _arg_1));
            };
        }

        private function refresh():void
        {
            this.viewstack1.selectedIndex = 0;
            this.Q1Input.text = "";
            this.Q2Input.text = "";
            this.Q3Input.text = "";
            this.suBtn.label = "Next";
        }

        private function clickHandle(_arg_1:MouseEvent):void
        {
            var _local_2:URLLoader;
            var _local_3:URLRequest;
            var _local_4:URLVariables;
            if (_arg_1.target.label == "Next")
            {
                if ((((!(this.Q1Input.text == "")) && (!(this.Q2Input.text == ""))) && (!(this.Q3Input.text == ""))))
                {
                    this.viewstack1.selectedIndex = 1;
                    this.suBtn.label = "Finish";
                }
                else
                {
                    AlertWin.show(Lang.msg("确保密保资料完整"));
                };
            }
            else
            {
                if (this.mailInput.text == "")
                {
                    AlertWin.show(Lang.msg("密保资料保存失败"));
                }
                else
                {
                    _local_2 = new URLLoader();
                    _local_3 = new URLRequest();
                    _local_4 = new URLVariables();
                    _local_2.addEventListener(Event.COMPLETE, completeHandle, false, 0, true);
                    _local_2.addEventListener(IOErrorEvent.IO_ERROR, errorHandle, false, 0, true);
                    _local_3.url = ((((((((((((((((((GameConfig.instance.accountProtectUrl + "PageModule=AccountProtection&u=") + Context.getInstance().userName) + "&p=") + Context.getInstance().password) + "&q1=") + this.Q1.selectedItem.data) + "&a1=") + this.Q1Input.text) + "&q2=") + this.Q2.selectedItem.data) + "&a2=") + this.Q2Input.text) + "&q3=") + this.Q3.selectedItem.data) + "&a3=") + this.Q3Input.text) + "&m=") + this.mailInput.text);
                    _local_3.method = URLRequestMethod.POST;
                    _local_2.load(_local_3);
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get mailInput():TextInput
        {
            return (this._328770477mailInput);
        }

        [Bindable(event="propertyChange")]
        private function get Q1Arr():Array
        {
            return (this._76331073Q1Arr);
        }

        private function _AccountProtectionWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.Q1Arr);
            }, function (_arg_1:Object):void
            {
                Q1.dataProvider = _arg_1;
            }, "Q1.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.Q2Arr);
            }, function (_arg_1:Object):void
            {
                Q2.dataProvider = _arg_1;
            }, "Q2.dataProvider");
            result[1] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.Q3Arr);
            }, function (_arg_1:Object):void
            {
                Q3.dataProvider = _arg_1;
            }, "Q3.dataProvider");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("确保邮箱正确");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AccountProtectionWin_Text1.text = _arg_1;
            }, "_AccountProtectionWin_Text1.text");
            result[3] = binding;
            return (result);
        }

        public function onClose():void
        {
            this.refresh();
            PopUpManager.removePopUp(this);
        }

        public function __Q1_change(_arg_1:ListEvent):void
        {
            changSel(_arg_1);
        }

        public function set Q3Input(_arg_1:TextInput):void
        {
            var _local_2:Object = this._404246248Q3Input;
            if (_local_2 !== _arg_1)
            {
                this._404246248Q3Input = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q3Input", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get Q3Input():TextInput
        {
            return (this._404246248Q3Input);
        }

        private function set Q2Arr(_arg_1:Array):void
        {
            var _local_2:Object = this._76360864Q2Arr;
            if (_local_2 !== _arg_1)
            {
                this._76360864Q2Arr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q2Arr", _local_2, _arg_1));
            };
        }

        private function set Q3Arr(_arg_1:Array):void
        {
            var _local_2:Object = this._76390655Q3Arr;
            if (_local_2 !== _arg_1)
            {
                this._76390655Q3Arr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "Q3Arr", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get Q3Arr():Array
        {
            return (this._76390655Q3Arr);
        }


    }
}//package view.module.playerInfo

