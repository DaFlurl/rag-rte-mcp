// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.info.Alliance.MemberInfoWin

package autoevony.gui.info.Alliance
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.controls.ComboBox;
    import mx.core.UIComponentDescriptor;
    import autoevony.gui.controls.popup.PopUpWinBase;
    import mx.containers.VBox;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.collections.ArrayCollection;
    import com.evony.common.constants.AllianceConstants;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import autoevony.gui.MainScreen;
    import com.evony.common.module.CommandResponse;
    import autoevony.event.popUpWinShowEvent;
    import com.evony.common.module.alliance.AllianceManagementResponse;
    import com.evony.client.response.ResponseDispatcher;
    import autoevony.common.Utils;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.ImageSmooth;
    import flash.events.Event;
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

    public class MemberInfoWin extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        public var _MemberInfoWin_Text8:Text;
        public var _MemberInfoWin_Text11:Text;
        public var _MemberInfoWin_Text7:Text;
        public var _MemberInfoWin_Text9:Text;
        public var _MemberInfoWin_Text2:Text;
        public var _MemberInfoWin_Text4:Text;
        private var _112621893canChangePower:Boolean = false;
        public var _MemberInfoWin_Button2:Button;
        public var _MemberInfoWin_Button3:Button;
        public var _MemberInfoWin_Image1:Image;
        private var _2067570601isOwner:Boolean;
        private var _1366077706memberLevel:int;
        private var _19962424memberInfoBean:Object;
        private var closeFunc:Function = null;
        private var _1748641499officePostCB:ComboBox;
        public var _MemberInfoWin_Text10:Text;
        private var _497023925curMemberId:int;
        public var _MemberInfoWin_Text1:Text;
        private var _1694398603resetLevel:Button;
        public var _MemberInfoWin_Text3:Text;
        public var _MemberInfoWin_Text5:Text;
        public var _MemberInfoWin_Text6:Text;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "height":350,
                    "width":490,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":PopUpWinBase,
                        "stylesFactory":function ():void
                        {
                            this.left = "0";
                            this.top = "0";
                            this.bottom = "0";
                            this.right = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"windowTitle":"Member Info"});
                        }
                    }), new UIComponentDescriptor({
                        "type":ComboBox,
                        "id":"officePostCB",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.bottom = "30";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":110,
                                "styleName":"ComboBox",
                                "height":22
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "45";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":149,
                                "styleName":"textBackground",
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.left = "5";
                                        this.top = "10";
                                        this.bottom = "10";
                                        this.verticalGap = 5;
                                        this.right = "130";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Lord: ",
                                                                    "height":22,
                                                                    "percentWidth":35,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text1",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Alliance: ",
                                                                    "height":22,
                                                                    "percentWidth":35,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text2",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Position: ",
                                                                    "height":22,
                                                                    "percentWidth":35,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text3",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Rank: ",
                                                                    "height":22,
                                                                    "percentWidth":35,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text4",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Title: ",
                                                                    "height":22,
                                                                    "percentWidth":35,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text5",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":65,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
                                                                });
                                                            }
                                                        })]
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_MemberInfoWin_Image1",
                                    "events":{"complete":"___MemberInfoWin_Image1_complete"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "20";
                                        this.right = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":100,
                                            "width":100
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.right = "40";
                            this.top = "200";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "height":89,
                                "styleName":"textBackground",
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":VBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "5";
                                        this.right = "5";
                                        this.bottom = "5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "horizontalScrollPolicy":"off",
                                            "verticalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":HBox,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalGap = 0;
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Population: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text6",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Ranking: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text7",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Cities: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text8",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Prestige: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text9",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "percentWidth":100,
                                                        "horizontalScrollPolicy":"off",
                                                        "verticalScrollPolicy":"off",
                                                        "childDescriptors":[new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Honor: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text10",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Label,
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "right";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "text":"Position: ",
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "styleName":"focusColor"
                                                                });
                                                            }
                                                        }), new UIComponentDescriptor({
                                                            "type":Text,
                                                            "id":"_MemberInfoWin_Text11",
                                                            "stylesFactory":function ():void
                                                            {
                                                                this.textAlign = "left";
                                                            },
                                                            "propertiesFactory":function ():Object
                                                            {
                                                                return ({
                                                                    "height":22,
                                                                    "percentWidth":25,
                                                                    "selectable":false,
                                                                    "styleName":"labelWithBackGround"
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
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.right = "40";
                            this.bottom = "30";
                            this.horizontalGap = 3;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "horizontalScrollPolicy":"off",
                                "verticalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"resetLevel",
                                    "events":{"click":"__resetLevel_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Change Permission",
                                            "styleName":"REwinBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MemberInfoWin_Button2",
                                    "events":{"click":"___MemberInfoWin_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Expel",
                                            "styleName":"REwinBtn"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "id":"_MemberInfoWin_Button3",
                                    "events":{"click":"___MemberInfoWin_Button3_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Write",
                                            "visible":false,
                                            "styleName":"REwinBtn"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___MemberInfoWin_Button4_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "7";
                            this.right = "7";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"styleName":"close"});
                        }
                    })]
                });
            }
        });
        private var _1443179717dataPCB:ArrayCollection = new ArrayCollection([{
            "label":"Member",
            "data":AllianceConstants.LAST_POWER_FOR_ALLIANCE
        }, {
            "label":"Officer",
            "data":AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE
        }, {
            "label":"Presbyter",
            "data":AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE
        }, {
            "label":"Vice Host",
            "data":AllianceConstants.TOP2_POWER_FOR_ALLIANCE
        }]);
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function MemberInfoWin()
        {
            mx_internal::_document = this;
            this.height = 350;
            this.width = 490;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", this.___MemberInfoWin_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            MemberInfoWin._watcherSetupUtil = _arg_1;
        }


        public function ___MemberInfoWin_Button4_click(_arg_1:MouseEvent):void
        {
            this.close();
        }

        private function getIconUrl(_arg_1:String):String
        {
            return ("http://e2.eimg.us/" + _arg_1);
        }

        override public function initialize():void
        {
            var target:MemberInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(this._documentDescriptor_));
            var bindings:Array = this._MemberInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_autoevony_gui_info_Alliance_MemberInfoWinWatcherSetupUtil");
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
        private function get memberLevel():int
        {
            return (this._1366077706memberLevel);
        }

        private function turnBack():void
        {
            this.close();
        }

        private function getLevelId():int
        {
            return (MainScreen.getPlayer().playerInfo.levelId);
        }

        private function onSetPowerForUser(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Set permission successfully."));
                MainScreen.getInstance()._accountInfo.allianceInfo.members.fetchPage();
                this.close();
            };
        }

        public function close():void
        {
            ResponseDispatcher.getInstance().removeEventListener(ResponseDispatcher.ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE, this.onSetPowerForUser);
            this.closeFunc.apply(null, [this]);
        }

        private function _MemberInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.dataPCB);
            }, function (_arg_1:Object):void
            {
                officePostCB.dataProvider = _arg_1;
            }, "officePostCB.dataProvider");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.canChangePower);
            }, function (_arg_1:Boolean):void
            {
                officePostCB.visible = _arg_1;
            }, "officePostCB.visible");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.userName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text1.text = _arg_1;
            }, "_MemberInfoWin_Text1.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.alliance;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text2.text = _arg_1;
            }, "_MemberInfoWin_Text2.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.allianceLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text3.text = _arg_1;
            }, "_MemberInfoWin_Text3.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.office;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text4.text = _arg_1;
            }, "_MemberInfoWin_Text4.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.titleStr;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text5.text = _arg_1;
            }, "_MemberInfoWin_Text5.text");
            result[6] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.getIconUrl(this.memberInfoBean.faceUrl));
            }, function (_arg_1:Object):void
            {
                _MemberInfoWin_Image1.source = _arg_1;
            }, "_MemberInfoWin_Image1.source");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.memberInfoBean.population);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text6.text = _arg_1;
            }, "_MemberInfoWin_Text6.text");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.memberInfoBean.ranking);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text7.text = _arg_1;
            }, "_MemberInfoWin_Text7.text");
            result[9] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.castleCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text8.text = _arg_1;
            }, "_MemberInfoWin_Text8.text");
            result[10] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.memberInfoBean.prestige);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text9.text = _arg_1;
            }, "_MemberInfoWin_Text9.text");
            result[11] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Utils.formatInt(this.memberInfoBean.honor);
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text10.text = _arg_1;
            }, "_MemberInfoWin_Text10.text");
            result[12] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.memberInfoBean.allianceLevel;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _MemberInfoWin_Text11.text = _arg_1;
            }, "_MemberInfoWin_Text11.text");
            result[13] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.canChangePower);
            }, function (_arg_1:Boolean):void
            {
                resetLevel.visible = _arg_1;
            }, "resetLevel.visible");
            result[14] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((this.memberInfoBean.levelId > this.getLevelId()) ? true : false);
            }, function (_arg_1:Boolean):void
            {
                _MemberInfoWin_Button2.enabled = _arg_1;
            }, "_MemberInfoWin_Button2.enabled");
            result[15] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (this.isOwner);
            }, function (_arg_1:Boolean):void
            {
                _MemberInfoWin_Button3.includeInLayout = _arg_1;
            }, "_MemberInfoWin_Button3.includeInLayout");
            result[16] = binding;
            return (result);
        }

        public function updateInfo(_arg_1:Object=null, _arg_2:Function=null):void
        {
            this.memberInfoBean = _arg_1;
            this.memberLevel = MainScreen.getPlayer().playerInfo.levelId;
            this.canChangePower = this._canChangePower();
            if (MainScreen.getPlayer().playerInfo.userName != _arg_1.userName)
            {
                this.isOwner = true;
            }
            else
            {
                this.isOwner = false;
            };
            switch (_arg_1.levelId)
            {
                case AllianceConstants.LAST_POWER_FOR_ALLIANCE:
                    this.officePostCB.selectedIndex = 0;
                    break;
                case AllianceConstants.MIDDLE2_POWER_FOR_ALLIANCE:
                    this.officePostCB.selectedIndex = 1;
                    break;
                case AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE:
                    this.officePostCB.selectedIndex = 2;
                    break;
                case AllianceConstants.TOP2_POWER_FOR_ALLIANCE:
                    this.officePostCB.selectedIndex = 3;
                    break;
            };
            this.closeFunc = _arg_2;
        }

        public function ___MemberInfoWin_Button2_click(_arg_1:MouseEvent):void
        {
            this.fireMember();
        }

        private function getTitle(_arg_1:int):String
        {
            if (_arg_1 == 0)
            {
                return ("Civilian");
            };
            if (_arg_1 == 1)
            {
                return ("Knight");
            };
            if (_arg_1 == 2)
            {
                return ("Baronet");
            };
            if (_arg_1 == 3)
            {
                return ("Baron");
            };
            if (_arg_1 == 4)
            {
                return ("Viscount");
            };
            if (_arg_1 == 5)
            {
                return ("Earl");
            };
            if (_arg_1 == 6)
            {
                return ("Marquis");
            };
            if (_arg_1 == 7)
            {
                return ("Duke");
            };
            if (_arg_1 == 8)
            {
                return ("Furstin");
            };
            if (_arg_1 == 9)
            {
                return ("Prinzessin");
            };
            return ("");
        }

        private function set memberLevel(_arg_1:int):void
        {
            var _local_2:Object = this._1366077706memberLevel;
            if (_local_2 !== _arg_1)
            {
                this._1366077706memberLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberLevel", _local_2, _arg_1));
            };
        }

        public function __resetLevel_click(_arg_1:MouseEvent):void
        {
            this.changePower();
        }

        private function init():void
        {
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.ALLIANCE_SET_POWER_FOR_USER_BY_ALLIANCE, this.onSetPowerForUser);
        }

        private function set memberInfoBean(_arg_1:Object):void
        {
            var _local_2:Object = this._19962424memberInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._19962424memberInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "memberInfoBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get isOwner():Boolean
        {
            return (this._2067570601isOwner);
        }

        private function changePower():void
        {
            if (this.officePostCB.selectedItem["data"] != this.memberInfoBean.levelId)
            {
                ActionFactory.getInstance().getAllianceManagementCommands().setPowerForUserByAlliance(this.memberInfoBean.userName, this.officePostCB.selectedItem["data"]);
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, (("This player is " + this.officePostCB.selectedLabel) + " already.")));
            };
        }

        private function writeMail():void
        {
            this.close();
        }

        private function set dataPCB(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1443179717dataPCB;
            if (_local_2 !== _arg_1)
            {
                this._1443179717dataPCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "dataPCB", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get curMemberId():int
        {
            return (this._497023925curMemberId);
        }

        public function set officePostCB(_arg_1:ComboBox):void
        {
            var _local_2:Object = this._1748641499officePostCB;
            if (_local_2 !== _arg_1)
            {
                this._1748641499officePostCB = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "officePostCB", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get dataPCB():ArrayCollection
        {
            return (this._1443179717dataPCB);
        }

        [Bindable(event="propertyChange")]
        public function get resetLevel():Button
        {
            return (this._1694398603resetLevel);
        }

        public function ___MemberInfoWin_Button3_click(_arg_1:MouseEvent):void
        {
            this.writeMail();
        }

        [Bindable(event="propertyChange")]
        private function get memberInfoBean():Object
        {
            return (this._19962424memberInfoBean);
        }

        private function set isOwner(_arg_1:Boolean):void
        {
            var _local_2:Object = this._2067570601isOwner;
            if (_local_2 !== _arg_1)
            {
                this._2067570601isOwner = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isOwner", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get canChangePower():Boolean
        {
            return (this._112621893canChangePower);
        }

        public function ___MemberInfoWin_Image1_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get officePostCB():ComboBox
        {
            return (this._1748641499officePostCB);
        }

        private function set canChangePower(_arg_1:Boolean):void
        {
            var _local_2:Object = this._112621893canChangePower;
            if (_local_2 !== _arg_1)
            {
                this._112621893canChangePower = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "canChangePower", _local_2, _arg_1));
            };
        }

        private function _canChangePower():Boolean
        {
            if (this.memberLevel < this.memberInfoBean.levelId)
            {
                this.resetLevel.enabled = true;
            }
            else
            {
                this.resetLevel.enabled = false;
            };
            return ((this.memberInfoBean.userName == MainScreen.getPlayer().playerInfo.userName) ? false : (((this.memberLevel == AllianceConstants.TOP_POWER_FOR_ALLIANCE) || (this.memberLevel == AllianceConstants.TOP2_POWER_FOR_ALLIANCE)) || (this.memberLevel == AllianceConstants.MIDDLE_POWER_FOR_ALLIANCE)));
        }

        public function ___MemberInfoWin_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            this.init();
        }

        private function _MemberInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.dataPCB;
            _local_1 = this.canChangePower;
            _local_1 = this.memberInfoBean.userName;
            _local_1 = this.memberInfoBean.alliance;
            _local_1 = this.memberInfoBean.allianceLevel;
            _local_1 = this.memberInfoBean.office;
            _local_1 = this.memberInfoBean.titleStr;
            _local_1 = this.getIconUrl(this.memberInfoBean.faceUrl);
            _local_1 = Utils.formatInt(this.memberInfoBean.population);
            _local_1 = Utils.formatInt(this.memberInfoBean.ranking);
            _local_1 = this.memberInfoBean.castleCount;
            _local_1 = Utils.formatInt(this.memberInfoBean.prestige);
            _local_1 = Utils.formatInt(this.memberInfoBean.honor);
            _local_1 = this.memberInfoBean.allianceLevel;
            _local_1 = this.canChangePower;
            _local_1 = ((this.memberInfoBean.levelId > this.getLevelId()) ? true : false);
            _local_1 = this.isOwner;
        }

        private function onKickOutMemberFromAlliance(_arg_1:AllianceManagementResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, _arg_1.errorMsg));
            }
            else
            {
                dispatchEvent(new popUpWinShowEvent(popUpWinShowEvent.ALERT_WIN, "Expelled member successfully."));
                MainScreen.getInstance()._accountInfo.allianceInfo.members.fetchPage();
                this.close();
            };
        }

        private function fireMember():void
        {
            ActionFactory.getInstance().getAllianceManagementCommands().kickOutMemberfromAlliance(this.memberInfoBean.userName, this.onKickOutMemberFromAlliance);
        }

        public function set resetLevel(_arg_1:Button):void
        {
            var _local_2:Object = this._1694398603resetLevel;
            if (_local_2 !== _arg_1)
            {
                this._1694398603resetLevel = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resetLevel", _local_2, _arg_1));
            };
        }

        private function set curMemberId(_arg_1:int):void
        {
            var _local_2:Object = this._497023925curMemberId;
            if (_local_2 !== _arg_1)
            {
                this._497023925curMemberId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curMemberId", _local_2, _arg_1));
            };
        }


    }
}//package autoevony.gui.info.Alliance

