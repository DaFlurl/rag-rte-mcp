// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.oldAlliance.allianceList.AllianceInfo

package view.module.alliance.oldAlliance.allianceList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.containers.VBox;
    import mx.utils.ObjectProxy;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import com.evony.Context;
    import com.evony.common.constants.AllianceConstants;
    import com.evony.client.action.ActionFactory;
    import com.evony.common.beans.RankAllianceBean;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import mx.managers.PopUpManager;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Lang;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.alliance.AllianceInfoResponse;
    import view.ui.AlertWin;
    import com.evony.common.module.alliance.AllianceManagementResponse;
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

    public class AllianceInfo extends Canvas implements IBindingClient 
    {

        public static var instance:AllianceInfo;
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _AllianceInfo_Label6:Label;
        public var _AllianceInfo_Label8:Label;
        public var _AllianceInfo_Text1:Text;
        public var _AllianceInfo_Text2:Text;
        public var _AllianceInfo_Text3:Text;
        public var _AllianceInfo_Text4:Text;
        public var _AllianceInfo_Text5:Text;
        public var _AllianceInfo_Text6:Text;
        public var _AllianceInfo_Text7:Text;
        private var _1032494288officalLevel:int = 0;
        private var _1125982860curRank:int = 0;
        private var _602853347unionInfo:Canvas;
        private var _832584058makeMid:Button;
        private var _1180125369isShow:Boolean = false;
        private var _39953579makeArmy:Button;
        private var _689501127makeFriends:Button;
        public var _AllianceInfo_Button1:Button;
        private var _1606140770allianceName:String;
        public var _AllianceInfo_Label1:Label;
        public var _AllianceInfo_Label2:Label;
        public var _AllianceInfo_Label3:Label;
        public var _AllianceInfo_Label4:Label;
        public var _AllianceInfo_Label5:Label;
        public var _AllianceInfo_Label7:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":310,
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
                                    "id":"_AllianceInfo_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":8,
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"unionInfo",
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "height":290,
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_AllianceInfo_Button1",
                                    "events":{"click":"___AllianceInfo_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.fontFamily = "Arial";
                                        this.fontWeight = "bold";
                                        this.color = 0;
                                        this.bottom = "15";
                                        this.right = "20";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"b95",
                                            "width":95
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "21";
                                        this.top = "62";
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
                                                    this.horizontalGap = 5;
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
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
                                                                                "width":95,
                                                                                "styleName":"labelWithBackGround",
                                                                                "height":22,
                                                                                "selectable":false
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text2",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":95,
                                                                                "height":22,
                                                                                "styleName":"labelWithBackGround",
                                                                                "selectable":false
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text3",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":95,
                                                                                "height":22,
                                                                                "styleName":"labelWithBackGround",
                                                                                "selectable":false
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text4",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":95,
                                                                                "height":22,
                                                                                "styleName":"labelWithBackGround",
                                                                                "selectable":false
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label6",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text5",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":95,
                                                                                "height":22,
                                                                                "styleName":"labelWithBackGround",
                                                                                "selectable":false
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
                                                                    "percentWidth":100,
                                                                    "percentHeight":100,
                                                                    "childDescriptors":[new UIComponentDescriptor({
                                                                        "type":Label,
                                                                        "id":"_AllianceInfo_Label7",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "right";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":85,
                                                                                "height":22,
                                                                                "styleName":"focusColor"
                                                                            });
                                                                        }
                                                                    }), new UIComponentDescriptor({
                                                                        "type":Text,
                                                                        "id":"_AllianceInfo_Text6",
                                                                        "stylesFactory":function ():void
                                                                        {
                                                                            this.color = 0;
                                                                            this.textAlign = "left";
                                                                        },
                                                                        "propertiesFactory":function ():Object
                                                                        {
                                                                            return ({
                                                                                "width":95,
                                                                                "height":22,
                                                                                "styleName":"labelWithBackGround",
                                                                                "selectable":false
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
                                        this.top = "40";
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
                                                    this.color = 0xFFFFFF;
                                                    this.top = "5";
                                                    this.textAlign = "center";
                                                    this.horizontalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"focusColor",
                                                        "percentWidth":100
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
                                                        "styleName":"ParamgraphText1",
                                                        "selectable":false
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "15";
                                        this.left = "20";
                                        this.horizontalGap = 2;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeMid",
                                                "events":{"click":"__makeMid_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeFriends",
                                                "events":{"click":"__makeFriends_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"makeArmy",
                                                "events":{"click":"__makeArmy_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"b75"});
                                                }
                                            })]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AllianceInfo_Button5_click"},
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
        private var _1605786759allianceBean:ObjectProxy = new ObjectProxy();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceInfo()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 310;
            this.addEventListener("creationComplete", ___AllianceInfo_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceInfo._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:RankAllianceBean=null):void
        {
            if (instance == null)
            {
                instance = new (AllianceInfo)();
            };
            UIUtil.setPopopHelpWindowStye(instance);
            MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
            MinePopupManager.instance.centerPopUp();
            instance.isShow = false;
            instance.curRank = _arg_1.rank;
            instance.allianceBean.honor = _arg_1.honor;
            instance.allianceName = _arg_1.name;
            instance.officalLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
            if (Context.getInstance().getPlayerBean().playerInfo.alliance != _arg_1.name)
            {
                if ((((instance.officalLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (instance.officalLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (instance.officalLevel == AllianceConstants.MIDDLE_ALLIANCE)))
                {
                    instance.isShow = true;
                };
            };
            ActionFactory.getInstance().getAllianceCommands().getAllianceInfo(_arg_1.name, instance.onGetAllianceInfo);
        }


        [Bindable(event="propertyChange")]
        private function get allianceBean():ObjectProxy
        {
            return (this._1605786759allianceBean);
        }

        override public function initialize():void
        {
            var target:AllianceInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_oldAlliance_allianceList_AllianceInfoWatcherSetupUtil");
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

        public function ___AllianceInfo_Button5_click(_arg_1:MouseEvent):void
        {
            PopUpManager.removePopUp(this);
        }

        [Bindable(event="propertyChange")]
        private function get curRank():int
        {
            return (this._1125982860curRank);
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

        private function _AllianceInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.allianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label1.text = _arg_1;
            }, "_AllianceInfo_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("申请加入");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Button1.label = _arg_1;
            }, "_AllianceInfo_Button1.label");
            result[1] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (officalLevel == AllianceConstants.SAME_ALLIANCE);
            }, function (_arg_1:Boolean):void
            {
                _AllianceInfo_Button1.visible = _arg_1;
            }, "_AllianceInfo_Button1.visible");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("联盟盟主") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label2.text = _arg_1;
            }, "_AllianceInfo_Label2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.leader;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text1.text = _arg_1;
            }, "_AllianceInfo_Text1.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("创始人") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label3.text = _arg_1;
            }, "_AllianceInfo_Label3.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.creator;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text2.text = _arg_1;
            }, "_AllianceInfo_Text2.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("人数") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label4.text = _arg_1;
            }, "_AllianceInfo_Label4.text");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.memberCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text3.text = _arg_1;
            }, "_AllianceInfo_Text3.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("排名") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label5.text = _arg_1;
            }, "_AllianceInfo_Label5.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = curRank;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text4.text = _arg_1;
            }, "_AllianceInfo_Text4.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("荣誉") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label6.text = _arg_1;
            }, "_AllianceInfo_Label6.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.honor;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text5.text = _arg_1;
            }, "_AllianceInfo_Text5.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ": ");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label7.text = _arg_1;
            }, "_AllianceInfo_Label7.text");
            result[13] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.prestigeCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text6.text = _arg_1;
            }, "_AllianceInfo_Text6.text");
            result[14] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟介绍");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Label8.text = _arg_1;
            }, "_AllianceInfo_Label8.text");
            result[15] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = allianceBean.allinaceInfo;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceInfo_Text7.text = _arg_1;
            }, "_AllianceInfo_Text7.text");
            result[16] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("中立");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                makeMid.label = _arg_1;
            }, "makeMid.label");
            result[17] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeMid.visible = _arg_1;
            }, "makeMid.visible");
            result[18] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeMid.includeInLayout = _arg_1;
            }, "makeMid.includeInLayout");
            result[19] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("友好");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                makeFriends.label = _arg_1;
            }, "makeFriends.label");
            result[20] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeFriends.visible = _arg_1;
            }, "makeFriends.visible");
            result[21] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeFriends.includeInLayout = _arg_1;
            }, "makeFriends.includeInLayout");
            result[22] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("敌对");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                makeArmy.label = _arg_1;
            }, "makeArmy.label");
            result[23] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeArmy.visible = _arg_1;
            }, "makeArmy.visible");
            result[24] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isShow);
            }, function (_arg_1:Boolean):void
            {
                makeArmy.includeInLayout = _arg_1;
            }, "makeArmy.includeInLayout");
            result[25] = binding;
            return (result);
        }

        private function _AllianceInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.allianceName;
            _local_1 = Lang.msg("申请加入");
            _local_1 = (officalLevel == AllianceConstants.SAME_ALLIANCE);
            _local_1 = (Lang.msg("联盟盟主") + ": ");
            _local_1 = allianceBean.leader;
            _local_1 = (Lang.msg("创始人") + ": ");
            _local_1 = allianceBean.creator;
            _local_1 = (Lang.msg("人数") + ": ");
            _local_1 = allianceBean.memberCount;
            _local_1 = (Lang.msg("排名") + ": ");
            _local_1 = curRank;
            _local_1 = (Lang.msg("荣誉") + ": ");
            _local_1 = allianceBean.honor;
            _local_1 = (Lang.msg("声望") + ": ");
            _local_1 = allianceBean.prestigeCount;
            _local_1 = Lang.msg("联盟介绍");
            _local_1 = allianceBean.allinaceInfo;
            _local_1 = Lang.msg("中立");
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = Lang.msg("友好");
            _local_1 = this.isShow;
            _local_1 = this.isShow;
            _local_1 = Lang.msg("敌对");
            _local_1 = this.isShow;
            _local_1 = this.isShow;
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

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_USER_WANT_IN_ALLIANCE, onUserWantInAlliance);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_ALLIANCE_FRIENDSHIP, onSetAllianceFriendship);
        }

        public function __makeMid_click(_arg_1:MouseEvent):void
        {
            submitRelation(_arg_1);
        }

        private function onGetAllianceInfo(_arg_1:AllianceInfoResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                allianceBean["leader"] = _arg_1.leader;
                allianceBean["creator"] = _arg_1.creator;
                allianceBean["memberCount"] = _arg_1.memberCount;
                allianceBean["prestigeCount"] = _arg_1.prestigeCount;
                allianceBean["allinaceInfo"] = _arg_1.allinaceInfo;
            };
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

        public function __makeFriends_click(_arg_1:MouseEvent):void
        {
            submitRelation(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get makeArmy():Button
        {
            return (this._39953579makeArmy);
        }

        private function submitRelation(_arg_1:MouseEvent):void
        {
            switch (_arg_1.currentTarget)
            {
                case makeFriends:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.FRIEND_ALLIANCE);
                    return;
                case makeArmy:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.ENEMY_ALLIANCE);
                    return;
                case makeMid:
                    ActionFactory.getInstance().getAllianceManagementCommands().setAllianceFriendship(this.allianceName, AllianceConstants.MIDDLE_ALLIANCE);
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get unionInfo():Canvas
        {
            return (this._602853347unionInfo);
        }

        [Bindable(event="propertyChange")]
        public function get makeMid():Button
        {
            return (this._832584058makeMid);
        }

        private function onUserWantInAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(Lang.msg("申请成功{0}", allianceName));
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        public function ___AllianceInfo_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___AllianceInfo_Button1_click(_arg_1:MouseEvent):void
        {
            joinUnion();
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
            ActionFactory.getInstance().getAllianceManagementCommands().userWantInAlliance(allianceName);
        }

        [Bindable(event="propertyChange")]
        public function get makeFriends():Button
        {
            return (this._689501127makeFriends);
        }

        private function onSetAllianceFriendship(_arg_1:AllianceManagementResponse):void
        {
            if (this.isPopUp)
            {
                if (_arg_1.ok == CommandResponse.OK_DEFAULT)
                {
                    AlertWin.show(Lang.msg("联盟设置成功"));
                }
                else
                {
                    AlertWin.show(_arg_1.errorMsg);
                };
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

        public function __makeArmy_click(_arg_1:MouseEvent):void
        {
            submitRelation(_arg_1);
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
        private function get allianceName():String
        {
            return (this._1606140770allianceName);
        }


    }
}//package view.module.alliance.oldAlliance.allianceList

