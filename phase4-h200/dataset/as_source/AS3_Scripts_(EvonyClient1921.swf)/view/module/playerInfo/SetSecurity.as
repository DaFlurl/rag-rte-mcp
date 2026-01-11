// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.playerInfo.SetSecurity

package view.module.playerInfo
{
    import mx.containers.Canvas;
    import mx.controls.Button;
    import mx.controls.CheckBox;
    import mx.controls.TextInput;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Text;
    import mx.core.mx_internal;
    import com.evony.util.MinePopupManager;
    import com.evony.util.UIUtil;
    import view.castle.MainFrame;
    import com.evony.client.action.ActionFactory;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.common.GetProtectOptionResponse;
    import flash.events.MouseEvent;
    import flash.events.Event;
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

    public class SetSecurity extends Canvas 
    {

        public static var instance:SetSecurity = new (SetSecurity)();

        private var _2020316904flagSubmitBtn:Button;
        private var _641961740security4:CheckBox;
        private var _106438208pass1:TextInput;
        private var _1039690024notice:Label;
        private var _641961741security3:CheckBox;
        private var _106438209pass2:TextInput;
        private var _1949225773updateBtn:Boolean = false;
        private var _641961742security2:CheckBox;
        private var _3433489pass:TextInput;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":640,
                    "height":460,
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
                                            "text":"Security Code",
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
                                "height":150,
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":500,
                                            "htmlText":"Please select which operations to protect with your Security Code.  Once applied, the selected actions cannot be completed without the Security Code.",
                                            "styleName":"ParamgraphText3",
                                            "selectable":false
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.textAlign = "left";
                                        this.left = "0";
                                        this.top = "60";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"Check the box to adjust the protected options",
                                            "styleName":"focusColor",
                                            "width":350
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"security1",
                                    "events":{"click":"__security1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "50";
                                        this.top = "80";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"label":"Abandon colonies"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"security2",
                                    "events":{"click":"__security2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "250";
                                        this.top = "80";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"label":"Abandon cities"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"security3",
                                    "events":{"click":"__security3_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "400";
                                        this.top = "80";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"label":"Dismiss armies"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"security4",
                                    "events":{"click":"__security4_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "50";
                                        this.top = "110";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"label":"Dismiss heroes"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":CheckBox,
                                    "id":"security5",
                                    "events":{"click":"__security5_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "250";
                                        this.top = "110";
                                        this.fontSize = 12;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"label":"Adjust tax rate"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "220";
                            this.left = "40";
                            this.right = "40";
                            this.bottom = "40";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"canvasGroupBackGround",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.top = "40";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Current Security Code",
                                                        "width":170
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"pass",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "displayAsPassword":true,
                                                        "styleName":"textInput",
                                                        "height":22,
                                                        "maxChars":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.top = "70";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"New Security Code",
                                                        "width":170
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"pass1",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "displayAsPassword":true,
                                                        "styleName":"textInput",
                                                        "height":22,
                                                        "maxChars":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.top = "100";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "height":23,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Confirm Security Code",
                                                        "width":170
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":TextInput,
                                                "id":"pass2",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":100,
                                                        "displayAsPassword":true,
                                                        "styleName":"textInput",
                                                        "height":22,
                                                        "maxChars":10
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalCenter = "0";
                                        this.textAlign = "center";
                                        this.top = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"Change Security Code",
                                            "width":170,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 0xFF0000;
                                        this.textAlign = "center";
                                        this.bottom = "40";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"",
                                            "percentWidth":100,
                                            "styleName":"focusColor"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"flagSubmitBtn",
                                    "events":{"click":"__flagSubmitBtn_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontWeight = "bold";
                                        this.fontSize = 12;
                                        this.bottom = "10";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Save Password",
                                            "styleName":"Blue125",
                                            "width":160
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SetSecurity_Button2_click"},
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
        private var _641961739security5:CheckBox;
        private var _641961743security1:CheckBox;

        public function SetSecurity()
        {
            mx_internal::_document = this;
            this.width = 640;
            this.height = 460;
            this.addEventListener("creationComplete", ___SetSecurity_Canvas1_creationComplete);
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
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            ActionFactory.getInstance().getSecurityCommands().getProtectOption(instance.getprotectResponse);
        }


        public function set pass1(_arg_1:TextInput):void
        {
            var _local_2:Object = this._106438208pass1;
            if (_local_2 !== _arg_1)
            {
                this._106438208pass1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pass1", _local_2, _arg_1));
            };
        }

        public function set pass2(_arg_1:TextInput):void
        {
            var _local_2:Object = this._106438209pass2;
            if (_local_2 !== _arg_1)
            {
                this._106438209pass2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pass2", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        public function get pass():TextInput
        {
            return (this._3433489pass);
        }

        [Bindable(event="propertyChange")]
        public function get flagSubmitBtn():Button
        {
            return (this._2020316904flagSubmitBtn);
        }

        public function getprotectResponse(_arg_1:GetProtectOptionResponse):void
        {
            var _local_2:int;
            var _local_3:int;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_2 = _arg_1.option;
                _local_3 = 0;
                if ((_local_2 & 0x01))
                {
                    security1.selected = true;
                };
                if ((_local_2 & 0x02) != 0)
                {
                    security2.selected = true;
                };
                if ((_local_2 & 0x04) != 0)
                {
                    security3.selected = true;
                };
                if ((_local_2 & 0x08) != 0)
                {
                    security4.selected = true;
                };
                if ((_local_2 & 0x10) != 0)
                {
                    security5.selected = true;
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function __security2_click(_arg_1:MouseEvent):void
        {
            OnSetSecurity();
        }

        public function __security4_click(_arg_1:MouseEvent):void
        {
            OnSetSecurity();
        }

        public function set pass(_arg_1:TextInput):void
        {
            var _local_2:Object = this._3433489pass;
            if (_local_2 !== _arg_1)
            {
                this._3433489pass = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "pass", _local_2, _arg_1));
            };
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

        private function init(_arg_1:Event):void
        {
        }

        public function ___SetSecurity_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function protectResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function set flagSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._2020316904flagSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._2020316904flagSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "flagSubmitBtn", _local_2, _arg_1));
            };
        }

        private function textChange(_arg_1:Event):void
        {
            if (((!(pass1.text == pass2.text)) || (pass1.text == "")))
            {
                notice.text = "Passwords do not match.";
            }
            else
            {
                notice.text = "";
            };
        }

        private function onResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show("Changed successfully!");
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        private function OnSetSecurity():void
        {
            var _local_1:int;
            if (security1.selected)
            {
                _local_1 = (_local_1 + 1);
            };
            if (security2.selected)
            {
                _local_1 = (_local_1 + 2);
            };
            if (security3.selected)
            {
                _local_1 = (_local_1 + 4);
            };
            if (security4.selected)
            {
                _local_1 = (_local_1 + 8);
            };
            if (security5.selected)
            {
                _local_1 = (_local_1 + 16);
            };
            ActionFactory.getInstance().getSecurityCommands().setProtectOption(_local_1, protectResponse);
        }

        private function changeCode():void
        {
            if (((!(pass1.text == pass2.text)) || (pass1.text == "")))
            {
                notice.text = "Passwords do not match.";
                return;
            };
            ActionFactory.getInstance().getSecurityCommands().changeSecurityCode(pass.text, pass1.text, onResponse);
            pass.text = "";
            pass1.text = "";
            pass2.text = "";
        }

        public function __flagSubmitBtn_click(_arg_1:MouseEvent):void
        {
            changeCode();
        }

        [Bindable(event="propertyChange")]
        public function get pass1():TextInput
        {
            return (this._106438208pass1);
        }

        [Bindable(event="propertyChange")]
        public function get pass2():TextInput
        {
            return (this._106438209pass2);
        }

        public function set notice(_arg_1:Label):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get updateBtn():Boolean
        {
            return (this._1949225773updateBtn);
        }

        [Bindable(event="propertyChange")]
        public function get notice():Label
        {
            return (this._1039690024notice);
        }

        public function __security1_click(_arg_1:MouseEvent):void
        {
            OnSetSecurity();
        }

        public function __security3_click(_arg_1:MouseEvent):void
        {
            OnSetSecurity();
        }

        public function __security5_click(_arg_1:MouseEvent):void
        {
            OnSetSecurity();
        }

        public function set security1(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._641961743security1;
            if (_local_2 !== _arg_1)
            {
                this._641961743security1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "security1", _local_2, _arg_1));
            };
        }

        public function set security2(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._641961742security2;
            if (_local_2 !== _arg_1)
            {
                this._641961742security2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "security2", _local_2, _arg_1));
            };
        }

        public function set security4(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._641961740security4;
            if (_local_2 !== _arg_1)
            {
                this._641961740security4 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "security4", _local_2, _arg_1));
            };
        }

        public function set security5(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._641961739security5;
            if (_local_2 !== _arg_1)
            {
                this._641961739security5 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "security5", _local_2, _arg_1));
            };
        }

        public function set security3(_arg_1:CheckBox):void
        {
            var _local_2:Object = this._641961741security3;
            if (_local_2 !== _arg_1)
            {
                this._641961741security3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "security3", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get security1():CheckBox
        {
            return (this._641961743security1);
        }

        [Bindable(event="propertyChange")]
        public function get security2():CheckBox
        {
            return (this._641961742security2);
        }

        [Bindable(event="propertyChange")]
        public function get security3():CheckBox
        {
            return (this._641961741security3);
        }

        [Bindable(event="propertyChange")]
        public function get security4():CheckBox
        {
            return (this._641961740security4);
        }

        [Bindable(event="propertyChange")]
        public function get security5():CheckBox
        {
            return (this._641961739security5);
        }

        public function ___SetSecurity_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init(_arg_1);
        }


    }
}//package view.module.playerInfo

