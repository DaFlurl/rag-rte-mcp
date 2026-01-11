// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.GameOptionsWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.TextArea;
    import mx.controls.CheckBox;
    import mx.controls.RadioButtonGroup;
    import mx.controls.Button;
    import mx.controls.RadioButton;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.containers.VBox;
    import mx.controls.Text;
    import mx.controls.VRule;
    import mx.core.mx_internal;
    import com.evony.util.MinePopupManager;
    import com.evony.util.UIUtil;
    import view.MainWin;
    import mx.events.PropertyChangeEvent;
    import flash.external.ExternalInterface;
    import com.evony.client.action.ActionFactory;
    import flash.net.SharedObject;
    import com.evony.Context;
    import flash.events.Event;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import view.AddEmail;
    import mx.binding.Binding;
    import flash.utils.getDefinitionByName;
    import com.evony.MsgDispacther;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.events.FlexEvent;
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

    public class GameOptionsWin extends Canvas implements IBindingClient 
    {

        public static const OPT_NO_ANIMATION:int = 0;
        public static const OPT_LESS_ANIMATION:int = 1;
        public static const OPT_MORE_ANIMATION:int = 2;
        public static const OPT_AUTOMATIC_BY_FPS:int = 3;
        public static var performanceOpt:int = OPT_AUTOMATIC_BY_FPS;//3
        public static var instance:GameOptionsWin = new (GameOptionsWin)();
        private static const FUNCTION_REFRESH:String = ((("document.insertScript = function ()" + "{ ") + "window.location.reload();") + "}");
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2070664618ietitleName1:TextArea;
        private var _1432416492changeIe:CheckBox;
        private var _1949225773updateBtn:Boolean = false;
        private var _106583293pfopt:RadioButtonGroup;
        private var _3532159skip:CheckBox;
        private var _1900602558modifyBtn:Button;
        private var _2072711836isIncomingAttackFlag:Boolean = false;
        private var _2070664619ietitleName2:TextArea;
        private var _2064345108AttackWarning:CheckBox;
        private var _1186094986ByFpsAni:RadioButton;
        private var _830019989hideFbBar:CheckBox;
        private var _1217486260hidelv:CheckBox;
        private var _167251936logoutGameBtn:Button;
        private var _1239845447moreAni:RadioButton;
        private var _104960091noAni:RadioButton;
        private var _67390851lessAni:RadioButton;
        private var _1092797764closeBtn:Button;

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
                            this.top = "8";
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
                                            "y":2,
                                            "text":"Game Options",
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
                            this.top = "60";
                            this.left = "40";
                            this.right = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":70,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "styleName":"buildingDescNewBox",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Text,
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                    this.left = "5";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "htmlText":"Here you can change some game options to fit your needs.",
                                                        "styleName":"ParamgraphText3",
                                                        "selectable":false,
                                                        "percentHeight":100,
                                                        "percentWidth":100
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
                        "stylesFactory":function ():void
                        {
                            this.top = "140";
                            this.left = "40";
                            this.right = "40";
                            this.bottom = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalAlign = "left";
                                        this.left = "20";
                                        this.top = "15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":135,
                                            "width":270,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"hidelv",
                                                "events":{"click":"__hidelv_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Hide Building Level"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"changeIe",
                                                "events":{"click":"__changeIe_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Edit Browser Headline"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"skip",
                                                "events":{"click":"__skip_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Skip Opening Animation"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"hideFbBar",
                                                "events":{"click":"__hideFbBar_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Completely hide Facebook Bar"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":CheckBox,
                                                "id":"AttackWarning",
                                                "events":{"click":"__AttackWarning_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"label":"Incoming Attack Warning Emails"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "20";
                                        this.top = "167";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"ietitleName1",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "2";
                                                    this.textAlign = "left";
                                                    this.backgroundColor = 0x999999;
                                                    this.color = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":300,
                                                        "editable":false,
                                                        "height":25,
                                                        "text":"You can input new browser Headline here."
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextArea,
                                                "id":"ietitleName2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "2";
                                                    this.textAlign = "left";
                                                    this.backgroundColor = 0xFFFFFF;
                                                    this.color = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":300,
                                                        "height":25
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"modifyBtn",
                                                "events":{"click":"__modifyBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "307";
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Update",
                                                        "styleName":"b75",
                                                        "width":75,
                                                        "height":25
                                                    });
                                                }
                                            })]});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"noAni",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":302,
                                            "y":26,
                                            "label":"No Animation",
                                            "groupName":"pfopt",
                                            "value":0
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"lessAni",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":302,
                                            "y":72,
                                            "label":"Less Animation",
                                            "groupName":"pfopt",
                                            "value":1
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"moreAni",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":302,
                                            "y":48,
                                            "label":"More Animation",
                                            "groupName":"pfopt",
                                            "value":2
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":RadioButton,
                                    "id":"ByFpsAni",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":302,
                                            "y":97,
                                            "label":"Automatic By FPS",
                                            "groupName":"pfopt",
                                            "value":3
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":VRule,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":292,
                                            "y":21
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":302,
                                            "y":10,
                                            "text":"Performance Settings"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "40";
                            this.bottom = "20";
                            this.horizontalGap = 2;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___GameOptionsWin_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Forum",
                                            "styleName":"b95"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"logoutGameBtn",
                                    "events":{"click":"__logoutGameBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.bottom = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Logout Game",
                                            "styleName":"b95",
                                            "height":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"closeBtn",
                                    "events":{"click":"__closeBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.bottom = "35";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Return Game",
                                            "styleName":"b95",
                                            "height":25
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___GameOptionsWin_Button5_click"},
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
                    })]
                });
            }
        });
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function GameOptionsWin()
        {
            mx_internal::_document = this;
            this.width = 600;
            this.height = 400;
            _GameOptionsWin_RadioButtonGroup1_i();
            this.addEventListener("creationComplete", ___GameOptionsWin_Canvas1_creationComplete);
        }

        public static function close():void
        {
            MinePopupManager.instance.removePopup();
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainWin.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            GameOptionsWin._watcherSetupUtil = _arg_1;
        }


        public function set lessAni(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._67390851lessAni;
            if (_local_2 !== _arg_1)
            {
                this._67390851lessAni = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lessAni", _local_2, _arg_1));
            };
        }

        private function modifyBtnHandle(_arg_1:String):void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("SetIeTitle", _arg_1);
            };
            ActionFactory.getInstance().getCommonCommands().changeHeadline(_arg_1);
        }

        private function init(_arg_1:Event):void
        {
            var _local_2:SharedObject;
            _local_2 = SharedObject.getLocal("performanceOpt", "/");
            if (_local_2.data.value != null)
            {
                GameOptionsWin.performanceOpt = int(_local_2.data.value);
                Context.getInstance().iAnimalPlayFlag = GameOptionsWin.performanceOpt;
            }
            else
            {
                _local_2.data.value = GameOptionsWin.performanceOpt;
                _local_2.flush();
            };
            switch (GameOptionsWin.performanceOpt)
            {
                case 0:
                    noAni.selected = true;
                    break;
                case 1:
                    lessAni.selected = true;
                    break;
                case 2:
                    moreAni.selected = true;
                    break;
                case 3:
                    ByFpsAni.selected = true;
                    break;
                default:
                    ByFpsAni.selected = true;
            };
            _local_2 = SharedObject.getLocal("skipAnimation", "/");
            if (_local_2.data.value != null)
            {
                skip.selected = _local_2.data.value;
            };
            isIncomingAttackFlag = Context.getInstance().getPlayerBean().isReceiveIncomingAttack;
        }

        private function refreshPage():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(FUNCTION_REFRESH);
            };
        }

        [Bindable(event="propertyChange")]
        public function get AttackWarning():CheckBox
        {
            return (this._2064345108AttackWarning);
        }

        private function goForum():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.help), "_blank");
        }

        public function set ByFpsAni(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._1186094986ByFpsAni;
            if (_local_2 !== _arg_1)
            {
                this._1186094986ByFpsAni = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ByFpsAni", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get logoutGameBtn():Button
        {
            return (this._167251936logoutGameBtn);
        }

        public function set AttackWarning(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._2064345108AttackWarning;
            if (_local_2 !== _arg_1)
            {
                this._2064345108AttackWarning = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "AttackWarning", _local_2, _arg_1));
            };
        }

        public function set hideFbBar(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._830019989hideFbBar;
            if (_local_2 !== _arg_1)
            {
                this._830019989hideFbBar = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideFbBar", _local_2, _arg_1));
            };
        }

        public function __pfopt_change(_arg_1:Event):void
        {
            onAnimationOptionChange(_arg_1);
        }

        public function set logoutGameBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._167251936logoutGameBtn;
            if (_local_2 !== _arg_1)
            {
                this._167251936logoutGameBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "logoutGameBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get closeBtn():Button
        {
            return (this._1092797764closeBtn);
        }

        [Bindable(event="propertyChange")]
        public function get moreAni():RadioButton
        {
            return (this._1239845447moreAni);
        }

        [Bindable(event="propertyChange")]
        public function get hidelv():CheckBox
        {
            return (this._1217486260hidelv);
        }

        [Bindable(event="propertyChange")]
        public function get modifyBtn():Button
        {
            return (this._1900602558modifyBtn);
        }

        private function updateEmail(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                ActionFactory.getInstance().getCommonCommands().setEovnyMember();
                ActionFactory.getInstance().getCommonCommands().setReceiveIncomingAttack(true, OnResponse);
            }
            else
            {
                AttackWarning.selected = false;
            };
        }

        public function set ietitleName1(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2070664618ietitleName1;
            if (_local_2 !== _arg_1)
            {
                this._2070664618ietitleName1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ietitleName1", _local_2, _arg_1));
            };
        }

        public function __changeIe_click(_arg_1:MouseEvent):void
        {
            modifyIeTitle();
        }

        public function set ietitleName2(_arg_1:TextArea):void
        {
            var _local_2:Object = this._2070664619ietitleName2;
            if (_local_2 !== _arg_1)
            {
                this._2070664619ietitleName2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ietitleName2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get noAni():RadioButton
        {
            return (this._104960091noAni);
        }

        private function OnResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AddEmail.show();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        private function get isIncomingAttackFlag():Boolean
        {
            return (this._2072711836isIncomingAttackFlag);
        }

        public function __modifyBtn_click(_arg_1:MouseEvent):void
        {
            modifyBtnHandle(ietitleName2.text);
        }

        private function OnAttackWarning():void
        {
            if (AttackWarning.selected)
            {
                if (Context.getInstance().getPlayerBean().isEvonyMember)
                {
                    ActionFactory.getInstance().getCommonCommands().setReceiveIncomingAttack(true, OnResponse);
                }
                else
                {
                    AlertWinEx.show("You need an Evony Member card to use this feature.  The Evony Member grants you Evony Membership for 30 days.  Evony members will receive Incoming Attack Warning Email immediately once per 4 hours when they are getting attacked.  Buy an Evony Member card?", updateEmail, "Yes", "No", null);
                };
            }
            else
            {
                ActionFactory.getInstance().getCommonCommands().setReceiveIncomingAttack(false);
            };
        }

        private function OnhideFbBar():void
        {
            var _local_1:SharedObject = SharedObject.getLocal("hideFbBar", "/");
            _local_1.data.value = hideFbBar.selected;
            _local_1.flush();
            if (hideFbBar.selected)
            {
                MainWin.instance.fbBar.visible = false;
            };
        }

        public function ___GameOptionsWin_Button5_click(_arg_1:MouseEvent):void
        {
            close();
        }

        public function __hideFbBar_click(_arg_1:MouseEvent):void
        {
            OnhideFbBar();
        }

        private function _GameOptionsWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (isIncomingAttackFlag);
            }, function (_arg_1:Boolean):void
            {
                AttackWarning.selected = _arg_1;
            }, "AttackWarning.selected");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (!(updateBtn));
            }, function (_arg_1:Boolean):void
            {
                ietitleName1.visible = _arg_1;
            }, "ietitleName1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (updateBtn);
            }, function (_arg_1:Boolean):void
            {
                ietitleName2.visible = _arg_1;
            }, "ietitleName2.visible");
            result[2] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (updateBtn);
            }, function (_arg_1:Boolean):void
            {
                modifyBtn.enabled = _arg_1;
            }, "modifyBtn.enabled");
            result[3] = binding;
            return (result);
        }

        private function modifyIeTitle():void
        {
            if (changeIe.selected == true)
            {
                updateBtn = true;
                ietitleName2.text = "";
            }
            else
            {
                updateBtn = false;
            };
        }

        [Bindable(event="propertyChange")]
        public function get lessAni():RadioButton
        {
            return (this._67390851lessAni);
        }

        public function set modifyBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1900602558modifyBtn;
            if (_local_2 !== _arg_1)
            {
                this._1900602558modifyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "modifyBtn", _local_2, _arg_1));
            };
        }

        public function set closeBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1092797764closeBtn;
            if (_local_2 !== _arg_1)
            {
                this._1092797764closeBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeBtn", _local_2, _arg_1));
            };
        }

        private function onAnimationOptionChange(_arg_1:Event):void
        {
            performanceOpt = int(pfopt.selectedValue);
            var _local_2:SharedObject = SharedObject.getLocal("performanceOpt", "/");
            _local_2.data.value = GameOptionsWin.performanceOpt;
            _local_2.flush();
        }

        public function set moreAni(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._1239845447moreAni;
            if (_local_2 !== _arg_1)
            {
                this._1239845447moreAni = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "moreAni", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:GameOptionsWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _GameOptionsWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_GameOptionsWinWatcherSetupUtil");
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
        public function get ByFpsAni():RadioButton
        {
            return (this._1186094986ByFpsAni);
        }

        [Bindable(event="propertyChange")]
        public function get hideFbBar():CheckBox
        {
            return (this._830019989hideFbBar);
        }

        private function modifyBuildingLevel():void
        {
            var _local_1:MsgDispacther = MsgDispacther.getInstance();
            _local_1.showBuildingLevel = (!(_local_1.showBuildingLevel));
        }

        public function set hidelv(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1217486260hidelv;
            if (_local_2 !== _arg_1)
            {
                this._1217486260hidelv = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hidelv", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get skip():CheckBox
        {
            return (this._3532159skip);
        }

        private function set updateBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1949225773updateBtn;
            if (_local_2 !== _arg_1)
            {
                this._1949225773updateBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "updateBtn", _local_2, _arg_1));
            };
        }

        public function __skip_click(_arg_1:MouseEvent):void
        {
            skipAnimation();
        }

        private function _GameOptionsWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = isIncomingAttackFlag;
            _local_1 = (!(updateBtn));
            _local_1 = updateBtn;
            _local_1 = updateBtn;
        }

        [Bindable(event="propertyChange")]
        public function get ietitleName1():TextArea
        {
            return (this._2070664618ietitleName1);
        }

        [Bindable(event="propertyChange")]
        public function get ietitleName2():TextArea
        {
            return (this._2070664619ietitleName2);
        }

        public function __closeBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        public function __hidelv_click(_arg_1:MouseEvent):void
        {
            modifyBuildingLevel();
        }

        public function ___GameOptionsWin_Button2_click(_arg_1:MouseEvent):void
        {
            goForum();
        }

        public function __AttackWarning_click(_arg_1:MouseEvent):void
        {
            OnAttackWarning();
        }

        private function skipAnimation():void
        {
            var _local_1:SharedObject = SharedObject.getLocal("skipAnimation", "/");
            _local_1.data.value = skip.selected;
            _local_1.flush();
        }

        private function set isIncomingAttackFlag(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2072711836isIncomingAttackFlag;
            if (_local_2 !== _arg_1)
            {
                this._2072711836isIncomingAttackFlag = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isIncomingAttackFlag", _local_2, _arg_1));
            };
        }

        public function __logoutGameBtn_click(_arg_1:MouseEvent):void
        {
            logoutGameHandle();
        }

        public function set noAni(_arg_1:RadioButton):void
        {
            var _local_2:Object = this._104960091noAni;
            if (_local_2 !== _arg_1)
            {
                this._104960091noAni = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "noAni", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get updateBtn():Boolean
        {
            return (this._1949225773updateBtn);
        }

        public function set changeIe(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._1432416492changeIe;
            if (_local_2 !== _arg_1)
            {
                this._1432416492changeIe = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "changeIe", _local_2, _arg_1));
            };
        }

        private function logoutGameHandle():void
        {
            var _local_2:PlayerInfoBean;
            var _local_3:Boolean;
            var _local_4:SharedObject;
            var _local_1:Boolean = EvonyClient.isTryUser;
            if (_local_1)
            {
                QuitGameWin.show();
            }
            else
            {
                _local_2 = Context.getInstance().getPlayerBean().playerInfo;
                _local_3 = false;
                _local_4 = SharedObject.getLocal("addFavorite");
                if (_local_4.data.accountName == _local_2.accountName)
                {
                    _local_3 = _local_4.data.isFavorite;
                };
                if (_local_3)
                {
                    trace("返回主页");
                    refreshPage();
                }
                else
                {
                    AddFavoriteWin.show();
                };
            };
        }

        public function ___GameOptionsWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get changeIe():CheckBox
        {
            return (this._1432416492changeIe);
        }

        private function _GameOptionsWin_RadioButtonGroup1_i():RadioButtonGroup
        {
            var _local_1:RadioButtonGroup = new RadioButtonGroup();
            pfopt = _local_1;
            _local_1.addEventListener("change", __pfopt_change);
            _local_1.initialized(this, "pfopt");
            return (_local_1);
        }

        public function set pfopt(_arg_1:RadioButtonGroup):void
        {
            var _local_2:Object = this._106583293pfopt;
            if (_local_2 !== _arg_1)
            {
                this._106583293pfopt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pfopt", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get pfopt():RadioButtonGroup
        {
            return (this._106583293pfopt);
        }

        public function set skip(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._3532159skip;
            if (_local_2 !== _arg_1)
            {
                this._3532159skip = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "skip", _local_2, _arg_1));
            };
        }


    }
}//package view.ui

