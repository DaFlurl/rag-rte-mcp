// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.alliance.AllianceWin

package view.module.alliance
{
    import view.ui.BaseFunctionWindow;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.CheckApply;
    import mx.controls.Button;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.Diplomatic;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.InviteMember;
    import mx.containers.Canvas;
    import mx.containers.ViewStack;
    import com.evony.common.beans.IndexAllianceInfoBean;
    import view.module.alliance.oldAlliance.allianceList.AllianceList;
    import view.module.alliance.oldAlliance.allianceMember.AllianceMemberMc;
    import view.module.alliance.oldAlliance.AllianceExist;
    import view.module.alliance.newAlliance.BeginAlliance;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.Introduct;
    import view.module.alliance.oldAlliance.allianceManage.allianceExchange.AllianceSendMail;
    import view.module.alliance.oldAlliance.allianceEventList.AllianceEventList;
    import mx.controls.ToggleButtonBar;
    import view.module.alliance.oldAlliance.militarySituationList.MilitarySituationList;
    import mx.core.UIComponentDescriptor;
    import mx.containers.HBox;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import com.evony.MsgDispacther;
    import view.AllWindows;
    import view.module.alliance.oldAlliance.allianceManage.AllianceManageView;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import com.evony.Context;
    import com.evony.events.WindowChangeEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import mx.events.ItemClickEvent;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import view.ui.AlertWin;
    import mx.binding.BindingManager;
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

    public class AllianceWin extends BaseFunctionWindow implements IBindingClient 
    {

        public static const EVENT_SHOW:String = "AllianceWin.open";
        public static const SUBWINDOW_CLOSE:String = "subWindow_close";
        public static const CALL_OTHER_VIEW:String = "callOtherView";
        public static const SUBWIN_GET_DATA:String = "subWinGetData";
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _546139322checkApply:CheckApply;
        private var _1032494288officalLevel:int = 0;
        public var _AllianceWin_Button1:Button;
        public var _AllianceWin_Button2:Button;
        private var _894308639allianceDiplomacy:Diplomatic;
        public var _AllianceWin_Array1:Array;
        private var _101874435inviteMember:InviteMember;
        private var _11548985buttonBox:Canvas;
        private var _946505330viewstack1:ViewStack;
        private var _1672186937indexAllianceInfoBean:IndexAllianceInfoBean;
        private var _1606089077allianceList:AllianceList;
        private var _2006572527allianceMemberList:AllianceMemberMc;
        private var _1756873472allianceExist:AllianceExist;
        private var _1760212302allianceBegin:BeginAlliance;
        private var _1753466763allianceIntro:Introduct;
        private var _1606110862allianceMail:AllianceSendMail;
        private var _486453495allianceHappening:AllianceEventList;
        private var _386434289hasAlliance:Boolean = false;
        private var _108156002togButton:ToggleButtonBar;
        private var _2005492607allianceWarInfo:MilitarySituationList;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":BaseFunctionWindow,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"buttonBox",
                        "stylesFactory":function ():void
                        {
                            this.left = "33";
                            this.right = "33";
                            this.top = "52";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":ToggleButtonBar,
                                    "id":"togButton",
                                    "events":{"itemClick":"__togButton_itemClick"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":0,
                                            "y":0,
                                            "width":600,
                                            "dataProvider":_AllianceWin_Array1_i()
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "x":605,
                                            "y":0,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceWin_Button1",
                                                "events":{"click":"___AllianceWin_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"b75",
                                                        "width":70
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"_AllianceWin_Button2",
                                                "events":{"click":"___AllianceWin_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"b75",
                                                        "width":70
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"viewstack1",
                        "stylesFactory":function ():void
                        {
                            this.left = "33";
                            this.top = "60";
                            this.right = "33";
                            this.bottom = "15";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":BeginAlliance,
                                    "id":"allianceBegin",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllianceExist,
                                    "id":"allianceExist",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllianceMemberMc,
                                    "id":"allianceMemberList"
                                }), new UIComponentDescriptor({
                                    "type":MilitarySituationList,
                                    "id":"allianceWarInfo",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "percentHeight":100
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":AllianceEventList,
                                    "id":"allianceHappening"
                                }), new UIComponentDescriptor({
                                    "type":AllianceList,
                                    "id":"allianceList"
                                }), new UIComponentDescriptor({
                                    "type":InviteMember,
                                    "id":"inviteMember"
                                }), new UIComponentDescriptor({
                                    "type":CheckApply,
                                    "id":"checkApply"
                                }), new UIComponentDescriptor({
                                    "type":Introduct,
                                    "id":"allianceIntro"
                                }), new UIComponentDescriptor({
                                    "type":Diplomatic,
                                    "id":"allianceDiplomacy"
                                }), new UIComponentDescriptor({
                                    "type":AllianceSendMail,
                                    "id":"allianceMail"
                                })]});
                        }
                    })]});
            }
        });
        private var _2145012720friendlyListArray:ArrayCollection = new ArrayCollection();
        private var _1900069446middleListArray:ArrayCollection = new ArrayCollection();
        private var _1429287501enemyListArray:ArrayCollection = new ArrayCollection();
        private var subBean:Object = {};
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function AllianceWin()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___AllianceWin_BaseFunctionWindow1_creationComplete);
            this.addEventListener("removedFromStage", ___AllianceWin_BaseFunctionWindow1_removedFromStage);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            AllianceWin._watcherSetupUtil = _arg_1;
        }


        [Bindable(event="propertyChange")]
        public function get allianceExist():AllianceExist
        {
            return (this._1756873472allianceExist);
        }

        [Bindable(event="propertyChange")]
        public function get inviteMember():InviteMember
        {
            return (this._101874435inviteMember);
        }

        public function set inviteMember(_arg_1:InviteMember):void
        {
            var _local_2:Object = this._101874435inviteMember;
            if (_local_2 !== _arg_1)
            {
                this._101874435inviteMember = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "inviteMember", _local_2, _arg_1));
            };
        }

        public function set allianceExist(_arg_1:AllianceExist):void
        {
            var _local_2:Object = this._1756873472allianceExist;
            if (_local_2 !== _arg_1)
            {
                this._1756873472allianceExist = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceExist", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceHappening():AllianceEventList
        {
            return (this._486453495allianceHappening);
        }

        public function ___AllianceWin_Button1_click(_arg_1:MouseEvent):void
        {
            manageViewCall();
        }

        public function set allianceHappening(_arg_1:AllianceEventList):void
        {
            var _local_2:Object = this._486453495allianceHappening;
            if (_local_2 !== _arg_1)
            {
                this._486453495allianceHappening = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceHappening", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get hasAlliance():Boolean
        {
            return (this._386434289hasAlliance);
        }

        public function set allianceMail(_arg_1:AllianceSendMail):void
        {
            var _local_2:Object = this._1606110862allianceMail;
            if (_local_2 !== _arg_1)
            {
                this._1606110862allianceMail = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceMail", _local_2, _arg_1));
            };
        }

        private function init():void
        {
            MsgDispacther.getInstance().addEventListener(AllWindows.EVENT_CHANGE, onWindowChange);
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

        private function manageViewCall():void
        {
            AllianceManageView.show();
        }

        private function allianceForum():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.allianceForum), "_blank");
        }

        [Bindable(event="propertyChange")]
        private function get officalLevel():int
        {
            return (this._1032494288officalLevel);
        }

        [Bindable(event="propertyChange")]
        public function get buttonBox():Canvas
        {
            return (this._11548985buttonBox);
        }

        public function set togButton(_arg_1:ToggleButtonBar):void
        {
            var _local_2:Object = this._108156002togButton;
            if (_local_2 !== _arg_1)
            {
                this._108156002togButton = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "togButton", _local_2, _arg_1));
            };
        }

        private function onWindowChange(_arg_1:WindowChangeEvent):void
        {
            var _local_2:Object;
            if (_arg_1.getId() == SUBWINDOW_CLOSE)
            {
                hasAlliance = ((!(Context.getInstance().getPlayerBean().playerInfo.alliance == null)) && (!(Context.getInstance().getPlayerBean().playerInfo.alliance == "")));
                if (hasAlliance)
                {
                    this.onGotoView(" ");
                }
                else
                {
                    this.onGotoView("allianceBegin");
                };
            }
            else
            {
                if (_arg_1.getId() == CALL_OTHER_VIEW)
                {
                    _local_2 = _arg_1.getEventData().id;
                    this.onGotoView(String(_local_2));
                    subBean[_local_2] = _arg_1.getEventData();
                }
                else
                {
                    if (_arg_1.getId() == SUBWIN_GET_DATA)
                    {
                        if (Canvas(this[_arg_1.getEventData().id]).initialized)
                        {
                            this[_arg_1.getEventData().id].beanObj = subBean[_arg_1.getEventData().id].data;
                        };
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get checkApply():CheckApply
        {
            return (this._546139322checkApply);
        }

        [Bindable(event="propertyChange")]
        private function get middleListArray():ArrayCollection
        {
            return (this._1900069446middleListArray);
        }

        public function ___AllianceWin_Button2_click(_arg_1:MouseEvent):void
        {
            allianceForum();
        }

        private function _AllianceWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                this.title = _arg_1;
            }, "this.title");
            result[0] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return (((((viewstack1.selectedChild == this.allianceWarInfo) || (viewstack1.selectedChild == this.allianceHappening)) || (viewstack1.selectedChild == this.allianceMemberList)) || (viewstack1.selectedChild == this.allianceExist)) || (viewstack1.selectedChild == this.allianceList));
            }, function (_arg_1:Boolean):void
            {
                buttonBox.visible = _arg_1;
            }, "buttonBox.visible");
            result[1] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("联盟信息"));
            }, function (_arg_1:*):void
            {
                _AllianceWin_Array1[0] = _arg_1;
            }, "_AllianceWin_Array1[0]");
            result[2] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("联盟成员"));
            }, function (_arg_1:*):void
            {
                _AllianceWin_Array1[1] = _arg_1;
            }, "_AllianceWin_Array1[1]");
            result[3] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("联盟军情"));
            }, function (_arg_1:*):void
            {
                _AllianceWin_Array1[2] = _arg_1;
            }, "_AllianceWin_Array1[2]");
            result[4] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("联盟事件"));
            }, function (_arg_1:*):void
            {
                _AllianceWin_Array1[3] = _arg_1;
            }, "_AllianceWin_Array1[3]");
            result[5] = binding;
            binding = new Binding(this, function ():*
            {
                return (Lang.msg("联盟列表"));
            }, function (_arg_1:*):void
            {
                _AllianceWin_Array1[4] = _arg_1;
            }, "_AllianceWin_Array1[4]");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟管理");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceWin_Button1.label = _arg_1;
            }, "_AllianceWin_Button1.label");
            result[7] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("联盟论坛");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _AllianceWin_Button2.label = _arg_1;
            }, "_AllianceWin_Button2.label");
            result[8] = binding;
            binding = new Binding(this, function ():IndexAllianceInfoBean
            {
                return (this.indexAllianceInfoBean);
            }, function (_arg_1:IndexAllianceInfoBean):void
            {
                allianceIntro._unionArray = _arg_1;
            }, "allianceIntro._unionArray");
            result[9] = binding;
            return (result);
        }

        private function set enemyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1429287501enemyListArray;
            if (_local_2 !== _arg_1)
            {
                this._1429287501enemyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enemyListArray", _local_2, _arg_1));
            };
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

        public function set allianceBegin(_arg_1:BeginAlliance):void
        {
            var _local_2:Object = this._1760212302allianceBegin;
            if (_local_2 !== _arg_1)
            {
                this._1760212302allianceBegin = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceBegin", _local_2, _arg_1));
            };
        }

        public function set buttonBox(_arg_1:Canvas):void
        {
            var _local_2:Object = this._11548985buttonBox;
            if (_local_2 !== _arg_1)
            {
                this._11548985buttonBox = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "buttonBox", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceList():AllianceList
        {
            return (this._1606089077allianceList);
        }

        [Bindable(event="propertyChange")]
        public function get allianceIntro():Introduct
        {
            return (this._1753466763allianceIntro);
        }

        [Bindable(event="propertyChange")]
        public function get allianceWarInfo():MilitarySituationList
        {
            return (this._2005492607allianceWarInfo);
        }

        private function TogBarClickHandler(_arg_1:ItemClickEvent):void
        {
            switch (_arg_1.index)
            {
                case 0:
                    this.onGotoView("");
                    return;
                case 1:
                    this.onGotoView("allianceMemberList");
                    return;
                case 2:
                    this.onGotoView("allianceWarInfo");
                    return;
                case 3:
                    this.onGotoView("allianceHappening");
                    return;
                case 4:
                    this.onGotoView("allianceList");
                    return;
            };
        }

        public function set checkApply(_arg_1:CheckApply):void
        {
            var _local_2:Object = this._546139322checkApply;
            if (_local_2 !== _arg_1)
            {
                this._546139322checkApply = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "checkApply", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceMail():AllianceSendMail
        {
            return (this._1606110862allianceMail);
        }

        override public function initialize():void
        {
            var target:AllianceWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _AllianceWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_module_alliance_AllianceWinWatcherSetupUtil");
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

        private function set middleListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._1900069446middleListArray;
            if (_local_2 !== _arg_1)
            {
                this._1900069446middleListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "middleListArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get viewstack1():ViewStack
        {
            return (this._946505330viewstack1);
        }

        private function set indexAllianceInfoBean(_arg_1:IndexAllianceInfoBean):void
        {
            var _local_2:Object = this._1672186937indexAllianceInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._1672186937indexAllianceInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "indexAllianceInfoBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get togButton():ToggleButtonBar
        {
            return (this._108156002togButton);
        }

        private function onGotoView(_arg_1:String):void
        {
            var _local_2:* = "";
            switch (_arg_1)
            {
                case "allianceBegin":
                    viewstack1.selectedChild = allianceBegin;
                    _local_2 = "allianceBegin";
                    break;
                case "allianceList":
                    viewstack1.selectedChild = allianceList;
                    togButton.selectedIndex = 4;
                    _local_2 = "allianceList";
                    break;
                case "allianceHappening":
                    viewstack1.selectedChild = allianceHappening;
                    togButton.selectedIndex = 3;
                    _local_2 = "allianceHappening";
                    break;
                case "allianceMemberList":
                    viewstack1.selectedChild = allianceMemberList;
                    togButton.selectedIndex = 1;
                    _local_2 = "allianceMemberList";
                    break;
                case "allianceWarInfo":
                    viewstack1.selectedChild = allianceWarInfo;
                    togButton.selectedIndex = 2;
                    _local_2 = "allianceWarInfo";
                    break;
                case "allianceDiplomacy":
                    viewstack1.selectedChild = allianceDiplomacy;
                    _local_2 = "allianceDiplomacy";
                    break;
                case "inviteMember":
                    viewstack1.selectedChild = this.inviteMember;
                    _local_2 = "inviteMember";
                    break;
                case "checkApply":
                    viewstack1.selectedChild = this.checkApply;
                    _local_2 = "checkApply";
                    break;
                case "allianceIntro":
                    viewstack1.selectedChild = allianceIntro;
                    _local_2 = "allianceIntro";
                    break;
                case "allianceMail":
                    viewstack1.selectedChild = allianceMail;
                    _local_2 = "allianceMail";
                    break;
                default:
                    viewstack1.selectedChild = allianceExist;
                    togButton.selectedIndex = 0;
                    _local_2 = "allianceExist";
            };
            if (Canvas(this[_local_2]).initialized)
            {
                this[_local_2].refresh();
            };
        }

        [Bindable(event="propertyChange")]
        private function get enemyListArray():ArrayCollection
        {
            return (this._1429287501enemyListArray);
        }

        public function ___AllianceWin_BaseFunctionWindow1_removedFromStage(_arg_1:Event):void
        {
            destroy();
        }

        [Bindable(event="propertyChange")]
        public function get allianceBegin():BeginAlliance
        {
            return (this._1760212302allianceBegin);
        }

        public function set allianceDiplomacy(_arg_1:Diplomatic):void
        {
            var _local_2:Object = this._894308639allianceDiplomacy;
            if (_local_2 !== _arg_1)
            {
                this._894308639allianceDiplomacy = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceDiplomacy", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get indexAllianceInfoBean():IndexAllianceInfoBean
        {
            return (this._1672186937indexAllianceInfoBean);
        }

        override public function refresh():void
        {
            if (((hasAlliance == true) && (Context.getInstance().getPlayerBean().playerInfo.alliance == null)))
            {
                AlertWin.show(Lang.msg("尚未有联盟"));
            };
            hasAlliance = ((!(Context.getInstance().getPlayerBean().playerInfo.alliance == null)) && (!(Context.getInstance().getPlayerBean().playerInfo.alliance == "")));
            officalLevel = Context.getInstance().getPlayerBean().playerInfo.levelId;
            if (hasAlliance)
            {
                this.onGotoView(" ");
            }
            else
            {
                this.onGotoView("allianceBegin");
            };
        }

        public function set allianceMemberList(_arg_1:AllianceMemberMc):void
        {
            var _local_2:Object = this._2006572527allianceMemberList;
            if (_local_2 !== _arg_1)
            {
                this._2006572527allianceMemberList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceMemberList", _local_2, _arg_1));
            };
        }

        private function set friendlyListArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2145012720friendlyListArray;
            if (_local_2 !== _arg_1)
            {
                this._2145012720friendlyListArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendlyListArray", _local_2, _arg_1));
            };
        }

        private function _AllianceWin_Array1_i():Array
        {
            var _local_1:Array = [null, null, null, null, null];
            _AllianceWin_Array1 = _local_1;
            BindingManager.executeBindings(this, "_AllianceWin_Array1", _AllianceWin_Array1);
            return (_local_1);
        }

        [Bindable(event="propertyChange")]
        public function get allianceDiplomacy():Diplomatic
        {
            return (this._894308639allianceDiplomacy);
        }

        private function set hasAlliance(_arg_1:Boolean):void
        {
            var _local_2:Object = this._386434289hasAlliance;
            if (_local_2 !== _arg_1)
            {
                this._386434289hasAlliance = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hasAlliance", _local_2, _arg_1));
            };
        }

        public function set allianceList(_arg_1:AllianceList):void
        {
            var _local_2:Object = this._1606089077allianceList;
            if (_local_2 !== _arg_1)
            {
                this._1606089077allianceList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceList", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get allianceMemberList():AllianceMemberMc
        {
            return (this._2006572527allianceMemberList);
        }

        [Bindable(event="propertyChange")]
        private function get friendlyListArray():ArrayCollection
        {
            return (this._2145012720friendlyListArray);
        }

        public function set allianceIntro(_arg_1:Introduct):void
        {
            var _local_2:Object = this._1753466763allianceIntro;
            if (_local_2 !== _arg_1)
            {
                this._1753466763allianceIntro = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceIntro", _local_2, _arg_1));
            };
        }

        private function _AllianceWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = Lang.msg("联盟");
            _local_1 = (((((viewstack1.selectedChild == this.allianceWarInfo) || (viewstack1.selectedChild == this.allianceHappening)) || (viewstack1.selectedChild == this.allianceMemberList)) || (viewstack1.selectedChild == this.allianceExist)) || (viewstack1.selectedChild == this.allianceList));
            _local_1 = Lang.msg("联盟信息");
            _local_1 = Lang.msg("联盟成员");
            _local_1 = Lang.msg("联盟军情");
            _local_1 = Lang.msg("联盟事件");
            _local_1 = Lang.msg("联盟列表");
            _local_1 = Lang.msg("联盟管理");
            _local_1 = Lang.msg("联盟论坛");
            _local_1 = this.indexAllianceInfoBean;
        }

        public function __togButton_itemClick(_arg_1:ItemClickEvent):void
        {
            this.TogBarClickHandler(_arg_1);
        }

        override public function destroy():void
        {
            if (AllianceManageView.instance)
            {
                AllianceManageView.instance.destroy();
            };
        }

        public function set allianceWarInfo(_arg_1:MilitarySituationList):void
        {
            var _local_2:Object = this._2005492607allianceWarInfo;
            if (_local_2 !== _arg_1)
            {
                this._2005492607allianceWarInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceWarInfo", _local_2, _arg_1));
            };
        }

        public function ___AllianceWin_BaseFunctionWindow1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view.module.alliance

