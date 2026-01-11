// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.AllianceInfoWin

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.controls.Button;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.core.UIComponentDescriptor;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.utils.ObjectProxy;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import autoevony.gui.MainScreen;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.client.action.ActionFactory;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;
    import mx.binding.Binding;
    import autoevony.common.Utils;
    import flash.utils.getDefinitionByName;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import mx.events.FlexEvent;
    import flash.events.*;
    import flash.display.*;
    import flash.geom.*;
    import mx.styles.*;
    import flash.text.*;
    import flash.media.*;
    import mx.binding.*;
    import flash.utils.*;
    import flash.accessibility.*;
    import flash.system.*;
    import flash.net.*;
    import flash.xml.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.debugger.*;
    import flash.errors.*;
    import flash.filters.*;
    import flash.printing.*;
    import flash.profiler.*;

    use namespace mx_internal;

    public class AllianceInfoWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1176657665_AllianceInfo_Label8:Label;
        private var _1770687502_AllianceInfo_Text6:Text;
        private var _1176657670_AllianceInfo_Label3:Label;
        private var _1032494288officalLevel:int = 0;
        private var _1812093596_AllianceInfo_Button1:Button;
        private var _832584058makeMid:Button;
        private var _1770687498_AllianceInfo_Text2:Text;
        private var _1770687500_AllianceInfo_Text4:Text;
        private var _689501127makeFriends:Button;
        private var _1176657669_AllianceInfo_Label4:Label;
        private var _1770687503_AllianceInfo_Text7:Text;
        private var _1176657666_AllianceInfo_Label7:Label;
        private var _1176657667_AllianceInfo_Label6:Label;
        private var _1176657668_AllianceInfo_Label5:Label;
        public var _AllianceInfoWin_PopUpWinBase1:PopUpWinBase;
        private var _1125982860curRank:int = 0;
        private var _1770687499_AllianceInfo_Text3:Text;
        private var _1176657671_AllianceInfo_Label2:Label;
        private var _602853347unionInfo:Canvas;
        private var _1770687501_AllianceInfo_Text5:Text;
        private var _1180125369isShow:Boolean = false;
        private var _1770687497_AllianceInfo_Text1:Text;
        private var _39953579makeArmy:Button;
        private var closeFunc:Function = null;
        private var _1606140770allianceName:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":290,
                    "width":440,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "id":"_AllianceInfoWin_PopUpWinBase1",
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"unionInfo",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":290,
                                "horizontalScrollPolicy":"off",
                                "percentWidth":100,
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AllianceInfo_Button1",
                                    "events":{"click":"___AllianceInfo_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "15";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Apply",
                                            "styleName":"REwinOkayBtn",
                                            "width":68
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "21";
                                        this.top = "67";
                                        this.right = "215";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"textBackground",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":VBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.left = "5";
                                                    this.top = "5";
                                                    this.bottom = "5";
                                                    this.right = "5";
                                                    this.horizontalAlign = "center";
                                                    this.horizontalGap = 3;
                                                    this.verticalAlign = "middle";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"childDescriptors":[new UIComponentDescriptor({
                                                            "type":HBox,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.horizontalGap = 0;
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Host: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text1",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
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
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Founder: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
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
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Members: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
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
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Ranking: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
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
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label6",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Honor: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
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
                                                                this.verticalAlign = "middle";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "percentHeight":100,
                                                                    "percentWidth":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "text":"Prestige: ",
                                                                                "height":22,
                                                                                "styleName":"focusColor",
                                                                                "width":75
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text6",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "height":22,
                                                                                "selectable":false,
                                                                                "styleName":"labelWithBackGround",
                                                                                "width":105
                                                                            });
                                                                        }
                                                                    })]
                                                                });
                                                            }
                                                        })]});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "45";
                                        this.bottom = "45";
                                        this.right = "15";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":200,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"_AllianceInfo_Label8",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "5";
                                                    this.textAlign = "center";
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Introduction",
                                                        "percentWidth":100,
                                                        "styleName":"focusColor"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Text,
                                                "id":"_AllianceInfo_Text7",
                                                "stylesFactory":function ():void
                                                {
                                                    this.top = "30";
                                                    this.left = "5";
                                                    this.right = "5";
                                                    this.bottom = "0";
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "selectable":false,
                                                        "styleName":"ParamgraphText1"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 2;
                                        this.verticalGap = 0;
                                        this.verticalAlign = "middle";
                                        this.bottom = "15";
                                        this.left = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":210,
                                            "height":25,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeFriends",
                                                "events":{"click":"__makeFriends_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Friendly",
                                                        "styleName":"REwinOkayBtn",
                                                        "width":67
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeMid",
                                                "events":{"click":"__makeMid_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Neutral",
                                                        "styleName":"REwinBtn",
                                                        "width":67
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeArmy",
                                                "events":{"click":"__makeArmy_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Hostile",
                                                        "styleName":"REwinCancelBtn",
                                                        "width":67
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AllianceInfoWin_Button5_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "2";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1605786759allianceBean:ObjectProxy = new ObjectProxy();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceInfoWin()
        {
            mx_internal::_document = this;
            this.height = 290;
            this.width = 440;
            this.addEventListener("creationComplete", this.___AllianceInfoWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceInfoWin._watcherSetupUtil = _arg_1;
        }


        public function ___AllianceInfoWin_Button5_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        public function set _AllianceInfo_Label5(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657668_AllianceInfo_Label5;
            if (_local_2 !== _arg_1)
            {
                this._1176657668_AllianceInfo_Label5 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label5", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text1():Text
        {
            return (this._1770687497_AllianceInfo_Text1);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text2():Text
        {
            return (this._1770687498_AllianceInfo_Text2);
        }

        public function set _AllianceInfo_Label7(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657666_AllianceInfo_Label7;
            if (_local_2 !== _arg_1)
            {
                this._1176657666_AllianceInfo_Label7 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label7", _local_2, _arg_1));
            };
        }

        public function ___AllianceInfo_Button1_click(_arg_1:MouseEvent):void
        {
            this.joinUnion();
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text4():Text
        {
            return (this._1770687500_AllianceInfo_Text4);
        }

        public function set _AllianceInfo_Text2(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687498_AllianceInfo_Text2;
            if (_local_2 !== _arg_1)
            {
                this._1770687498_AllianceInfo_Text2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text2", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Label3(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657670_AllianceInfo_Label3;
            if (_local_2 !== _arg_1)
            {
                this._1176657670_AllianceInfo_Label3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label3", _local_2, _arg_1));
            };
        }

        public function updateInfo(_arg_1:Object=null, _arg_2:Function=null):void
        {
            this.curRank = _arg_1.rank;
            this.allianceBean.honor = _arg_1.honor;
            this.allianceName = _arg_1.name;
            this.officalLevel = MainScreen.getPlayer().playerInfo.levelId;
            var _local_3:String = MainScreen.getPlayer().playerInfo.alliance;
            if (((!(_local_3 == null)) && (!(_local_3 == _arg_1.name))))
            {
                if ((((this.officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.officalLevel == AllianceConstants.MIDDLE_ALLIANCE)))
                {
                    this.isShow = true;
                };
            };
            if (!this._AllianceInfo_Button1.enabled)
            {
                this._AllianceInfo_Button1.enabled = true;
            };
            this.closeFunc = _arg_2;
            ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(this.allianceName, this.onGetAllianceInfo);
        }

        public function set _AllianceInfo_Label4(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657669_AllianceInfo_Label4;
            if (_local_2 !== _arg_1)
            {
                this._1176657669_AllianceInfo_Label4 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label4", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Text1(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687497_AllianceInfo_Text1;
            if (_local_2 !== _arg_1)
            {
                this._1770687497_AllianceInfo_Text1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text1", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text3():Text
        {
            return (this._1770687499_AllianceInfo_Text3);
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE, this.onUserWantInAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP, this.onSetAllianceFriendship);
        }

        [Bindable(event="propertyChange")]
        public function get unionInfo():Canvas
        {
            return (this._602853347unionInfo);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text6():Text
        {
            return (this._1770687502_AllianceInfo_Text6);
        }

        public function set _AllianceInfo_Text5(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687501_AllianceInfo_Text5;
            if (_local_2 !== _arg_1)
            {
                this._1770687501_AllianceInfo_Text5 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text5", _local_2, _arg_1));
            };
        }

        private function onGetAllianceInfo(_arg_1:AllianceInfoResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.allianceBean["leader"] = _arg_1.leader;
                this.allianceBean["creator"] = _arg_1.creator;
                this.allianceBean["memberCount"] = _arg_1.memberCount;
                this.allianceBean["prestigeCount"] = _arg_1.prestigeCount;
                this.allianceBean["allinaceInfo"] = _arg_1.allinaceInfo;
            };
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text5():Text
        {
            return (this._1770687501_AllianceInfo_Text5);
        }

        public function __makeFriends_click(_arg_1:MouseEvent):void
        {
            this.submitRelation(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Text7():Text
        {
            return (this._1770687503_AllianceInfo_Text7);
        }

        private function submitRelation(_arg_1:MouseEvent):void
        {
            switch (_arg_1.currentTarget)
            {
                case this.makeFriends:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.FRIEND_ALLIANCE);
                    return;
                case this.makeArmy:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.ENEMY_ALLIANCE);
                    return;
                case this.makeMid:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.MIDDLE_ALLIANCE);
                    return;
            };
        }

        public function set _AllianceInfo_Text7(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687503_AllianceInfo_Text7;
            if (_local_2 !== _arg_1)
            {
                this._1770687503_AllianceInfo_Text7 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text7", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Label8(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657665_AllianceInfo_Label8;
            if (_local_2 !== _arg_1)
            {
                this._1176657665_AllianceInfo_Label8 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label8", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Text3(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687499_AllianceInfo_Text3;
            if (_local_2 !== _arg_1)
            {
                this._1770687499_AllianceInfo_Text3 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text3", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Text4(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687500_AllianceInfo_Text4;
            if (_local_2 !== _arg_1)
            {
                this._1770687500_AllianceInfo_Text4 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text4", _local_2, _arg_1));
            };
        }

        public function set _AllianceInfo_Text6(_arg_1:Text):void
        {
            var _local_2:Object = this._1770687502_AllianceInfo_Text6;
            if (_local_2 !== _arg_1)
            {
                this._1770687502_AllianceInfo_Text6 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Text6", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get officalLevel():int
        {
            return (this._1032494288officalLevel);
        }

        public function set unionInfo(_arg_1:Canvas):void
        {
            var _local_2:Object = this._602853347unionInfo;
            if (_local_2 !== _arg_1)
            {
                this._602853347unionInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "unionInfo", _local_2, _arg_1));
            };
        }

        private function set curRank(_arg_1:int):void
        {
            var _local_2:Object = this._1125982860curRank;
            if (_local_2 !== _arg_1)
            {
                this._1125982860curRank = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curRank", _local_2, _arg_1));
            };
        }

        private function set allianceBean(_arg_1:ObjectProxy):void
        {
            var _local_2:Object = this._1605786759allianceBean;
            if (_local_2 !== _arg_1)
            {
                this._1605786759allianceBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceBean", _local_2, _arg_1));
            };
        }

        public function set makeArmy(_arg_1:Button):void
        {
            var _local_2:Object = this._39953579makeArmy;
            if (_local_2 !== _arg_1)
            {
                this._39953579makeArmy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "makeArmy", _local_2, _arg_1));
            };
        }

        private function _AllianceInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfoWin_PopUpWinBase1.windowTitle = _arg_1;
            }, "_AllianceInfoWin_PopUpWinBase1.windowTitle");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.officalLevel == AllianceConstants.SAME_ALLIANCE);
            }, function (_arg_1:Boolean):void
            {
                _AllianceInfo_Button1.visible = _arg_1;
            }, "_AllianceInfo_Button1.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceBean.leader;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text1.text = _arg_1;
            }, "_AllianceInfo_Text1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceBean.creator;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text2.text = _arg_1;
            }, "_AllianceInfo_Text2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceBean.memberCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text3.text = _arg_1;
            }, "_AllianceInfo_Text3.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.curRank;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text4.text = _arg_1;
            }, "_AllianceInfo_Text4.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.allianceBean.honor);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text5.text = _arg_1;
            }, "_AllianceInfo_Text5.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.allianceBean.prestigeCount);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text6.text = _arg_1;
            }, "_AllianceInfo_Text6.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceBean.allinaceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text7.text = _arg_1;
            }, "_AllianceInfo_Text7.text");
            result[8] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeFriends.visible = _arg_1;
            }, "makeFriends.visible");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeFriends.includeInLayout = _arg_1;
            }, "makeFriends.includeInLayout");
            result[10] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeMid.visible = _arg_1;
            }, "makeMid.visible");
            result[11] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeMid.includeInLayout = _arg_1;
            }, "makeMid.includeInLayout");
            result[12] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeArmy.visible = _arg_1;
            }, "makeArmy.visible");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeArmy.includeInLayout = _arg_1;
            }, "makeArmy.includeInLayout");
            result[14] = binding;
            return (result);
        }

        public function set _AllianceInfo_Label6(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657667_AllianceInfo_Label6;
            if (_local_2 !== _arg_1)
            {
                this._1176657667_AllianceInfo_Label6 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label6", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isShow():Boolean
        {
            return (this._1180125369isShow);
        }

        private function set officalLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1032494288officalLevel;
            if (_local_2 !== _arg_1)
            {
                this._1032494288officalLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officalLevel", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get allianceName():String
        {
            return (this._1606140770allianceName);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Button1():Button
        {
            return (this._1812093596_AllianceInfo_Button1);
        }

        public function set makeMid(_arg_1:Button):void
        {
            var _local_2:Object = this._832584058makeMid;
            if (_local_2 !== _arg_1)
            {
                this._832584058makeMid = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "makeMid", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get allianceBean():ObjectProxy
        {
            return (this._1605786759allianceBean);
        }

        [Bindable(event="propertyChange")]
        private function get curRank():int
        {
            return (this._1125982860curRank);
        }

        override public function initialize():void
        {
            var target:AllianceInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._AllianceInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_AllianceInfoWinWatcherSetupUtil");
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
        public function get makeMid():Button
        {
            return (this._832584058makeMid);
        }

        public function set makeFriends(_arg_1:Button):void
        {
            var _local_2:Object = this._689501127makeFriends;
            if (_local_2 !== _arg_1)
            {
                this._689501127makeFriends = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "makeFriends", _local_2, _arg_1));
            };
        }

        public function __makeMid_click(_arg_1:MouseEvent):void
        {
            this.submitRelation(_arg_1);
        }

        private function onUserWantInAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
                this._AllianceInfo_Button1.enabled = true;
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("Application for joining alliance " + this.allianceName) + " is submitted. Please wait for approval.")));
            };
        }

        private function set isShow(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1180125369isShow;
            if (_local_2 !== _arg_1)
            {
                this._1180125369isShow = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isShow", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get makeArmy():Button
        {
            return (this._39953579makeArmy);
        }

        private function set allianceName(_arg_1:String):void
        {
            var _local_2:Object = this._1606140770allianceName;
            if (_local_2 !== _arg_1)
            {
                this._1606140770allianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _local_2, _arg_1));
            };
        }

        private function joinUnion():void
        {
            this._AllianceInfo_Button1.enabled = false;
            ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(this.allianceName);
        }

        private function _AllianceInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.allianceName;
            _local_1 = (this.officalLevel == AllianceConstants.SAME_ALLIANCE);
            _local_1 = this.allianceBean.leader;
            _local_1 = this.allianceBean.creator;
            _local_1 = this.allianceBean.memberCount;
            _local_1 = this.curRank;
            _local_1 = Utils.formatInt(this.allianceBean.honor);
            _local_1 = Utils.formatInt(this.allianceBean.prestigeCount);
            _local_1 = this.allianceBean.allinaceInfo;
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = this.isShow;
        }

        public function set _AllianceInfo_Button1(_arg_1:Button):void
        {
            var _local_2:Object = this._1812093596_AllianceInfo_Button1;
            if (_local_2 !== _arg_1)
            {
                this._1812093596_AllianceInfo_Button1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Button1", _local_2, _arg_1));
            };
        }

        public function ___AllianceInfoWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function onSetAllianceFriendship(_arg_1:AllianceManagementResponse):void
        {
            if (this.isPopUp)
            {
                if (_arg_1.ok != CommandResponse.OK_DEFAULT)
                {
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
                }
                else
                {
                    dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Diplomatic Relationship is changed successfully."));
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get makeFriends():Button
        {
            return (this._689501127makeFriends);
        }

        public function __makeArmy_click(_arg_1:MouseEvent):void
        {
            this.submitRelation(_arg_1);
        }

        public function set _AllianceInfo_Label2(_arg_1:Label):void
        {
            var _local_2:Object = this._1176657671_AllianceInfo_Label2;
            if (_local_2 !== _arg_1)
            {
                this._1176657671_AllianceInfo_Label2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "_AllianceInfo_Label2", _local_2, _arg_1));
            };
        }

        public function close():void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE, this.onUserWantInAlliance);
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP, this.onSetAllianceFriendship);
            this.closeFunc.apply(null, [this]);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label2():Label
        {
            return (this._1176657671_AllianceInfo_Label2);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label3():Label
        {
            return (this._1176657670_AllianceInfo_Label3);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label4():Label
        {
            return (this._1176657669_AllianceInfo_Label4);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label5():Label
        {
            return (this._1176657668_AllianceInfo_Label5);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label6():Label
        {
            return (this._1176657667_AllianceInfo_Label6);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label7():Label
        {
            return (this._1176657666_AllianceInfo_Label7);
        }

        [Bindable(event="propertyChange")]
        public function get _AllianceInfo_Label8():Label
        {
            return (this._1176657665_AllianceInfo_Label8);
        }


    }
}//package autoevony.gui.info.Alliance

