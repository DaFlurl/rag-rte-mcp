// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.RandomEventWin

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.collections.ArrayCollection;
    import mx.controls.Text;
    import mx.containers.ViewStack;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.controls.Image;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import com.evony.Context;
    import flash.external.ExternalInterface;
    import mx.managers.PopUpManager;
    import flash.utils.setTimeout;
    import mx.events.PropertyChangeEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import flash.events.MouseEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import com.evony.common.beans.RandomEventBean;
    import com.evony.GameConfig;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.net.SharedObject;
    import view.module.rank.VoteWin;
    import com.evony.client.action.ActionFactory;
    import com.evony.util.UIUtil;
    import view.module.playerInfo.SecurityCodeNotice;
    import com.evony.util.MinePopupManager;
    import com.evony.data.FbData;
    import view.ui.FacebookNoticeWin;
    import com.adobe.crypto.MD5;
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

    public class RandomEventWin extends Canvas implements IBindingClient 
    {

        public static var instance:RandomEventWin = new (RandomEventWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _2007048382strNeighborId:String = "";
        public var randomEventArray:ArrayCollection;
        private var _1969552851strYesBtnText:String = "Share";
        private var _110843960type2:Canvas;
        private var iPopTypeId:int;
        private var _1039690024notice:Text;
        private var _109757064stack:ViewStack;
        public var _RandomEventWin_Label1:Label;
        private var _110843959type1:Canvas;
        private var _1271618531YesSubmitBtn:Button;
        private var iCurId:int = 0;
        private var _442266934strNoticeText:String = "";
        private var _1545744759strNoBtnText:String = "Skip";
        private var bNoHandle:Boolean = false;
        private var _1775479463strTitle:String = "EVENT";
        private var _1290918176evtImg:Image;
        private var _708816317NoSubmitBtn:Button;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":650,
                    "height":500,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "89";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"randeventTextbg",
                                "verticalScrollPolicy":"off",
                                "horizontalScrollPolicy":"off",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_RandomEventWin_Label1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "y":73,
                                            "styleName":"randEventTitle",
                                            "x":208
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"iconBg",
                                            "width":115,
                                            "height":115,
                                            "x":67,
                                            "y":51,
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"evtImg",
                                                "stylesFactory":function ():void
                                                {
                                                    this.verticalCenter = "0";
                                                    this.horizontalCenter = "0";
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.color = 5312268;
                                        this.fontSize = 14;
                                        this.top = "187";
                                        this.left = "65.5";
                                        this.right = "65.5";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "height":170,
                                            "selectable":false
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":ViewStack,
                        "id":"stack",
                        "stylesFactory":function ():void
                        {
                            this.bottom = "19";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":640,
                                "height":60,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"type1",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "verticalScrollPolicy":"off",
                                            "horizontalScrollPolicy":"off",
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___RandomEventWin_Button1_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Accept",
                                                        "styleName":"randEventGreen"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Canvas,
                                    "id":"type2",
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"YesSubmitBtn",
                                                "events":{"click":"__YesSubmitBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"randEventGreen",
                                                        "x":50
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "id":"NoSubmitBtn",
                                                "events":{"click":"__NoSubmitBtn_click"},
                                                "stylesFactory":function ():void
                                                {
                                                    this.fontWeight = "bold";
                                                    this.fontSize = 12;
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "styleName":"randEventGrey",
                                                        "x":339
                                                    });
                                                }
                                            })]});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___RandomEventWin_Button4_click"},
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
        private var _1738686659strNeighborIdArr:Array = new Array();
        private var Type1Arr:Array = [1];
        private var Type2Arr:Array = new Array(1, 2, 3, 4, 5, 6, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 38, 39, 40);
        private var Type3Arr:Array = [37];
        private var Type4Arr:Array = new Array(5, 7, 9, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 37, 39);
        private var Type5Arr:Array = new Array(6, 8);
        private var Type6Arr:Array = [8];
        private var Type7Arr:Array = [41];
        private var Type8Arr:Array = [42];
        private var Type9Arr:Array = [43];
        private var Type10Arr:Array = [44];
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function RandomEventWin()
        {
            mx_internal::_document = this;
            this.width = 650;
            this.height = 500;
            this.styleName = "MyWindow";
        }

        private static function showTimeOut():void
        {
            var _local_4:int;
            var _local_2:int = arguments[0];
            instance.randomEventArray = Context.getInstance().getPlayerBean().randomEventsArray;
            if (instance.randomEventArray.length == 0)
            {
                return;
            };
            if (Context.getInstance().needUserGuide)
            {
                return;
            };
            instance.iPopTypeId = _local_2;
            var _local_3:int = int((Math.random() * 40));
            if (_local_2 == 1)
            {
                _local_3 = (_local_3 % instance.Type1Arr.length);
                _local_3 = instance.Type1Arr[_local_3];
                if (!instance.CheckEvent(_local_3))
                {
                    _local_3 = instance.GetValidEventId(1);
                };
                instance.showContent(_local_3);
            }
            else
            {
                if (_local_2 == 2)
                {
                    _local_3 = (_local_3 % instance.Type2Arr.length);
                    _local_3 = instance.Type2Arr[_local_3];
                    if (!instance.CheckEvent(_local_3))
                    {
                        _local_3 = instance.GetValidEventId(2);
                    };
                    instance.showContent(_local_3);
                }
                else
                {
                    if (_local_2 == 4)
                    {
                        _local_3 = (_local_3 % instance.Type4Arr.length);
                        _local_3 = instance.Type4Arr[_local_3];
                        if (!instance.CheckEvent(_local_3))
                        {
                            _local_3 = instance.GetValidEventId(4);
                        };
                        instance.showContent(_local_3);
                    }
                    else
                    {
                        if (_local_2 == 5)
                        {
                            _local_3 = (_local_3 % instance.Type5Arr.length);
                            _local_3 = instance.Type5Arr[_local_3];
                            if (!instance.CheckEvent(_local_3))
                            {
                                _local_3 = instance.GetValidEventId(5);
                            };
                            instance.showContent(_local_3);
                        }
                        else
                        {
                            if (_local_2 == 6)
                            {
                                _local_3 = (_local_3 % instance.Type6Arr.length);
                                _local_3 = instance.Type6Arr[_local_3];
                                if (!instance.CheckEvent(_local_3))
                                {
                                    _local_3 = instance.GetValidEventId(6);
                                };
                                instance.showContent(_local_3);
                            }
                            else
                            {
                                if (_local_2 == 7)
                                {
                                    _local_4 = Context.getInstance().getPlayerBean().playerInfo.userId;
                                    if (((((Context.getInstance().facebookUser) && (_local_4 > 0)) && ((_local_4 % 10) == 2)) && ((_local_4 % 100) < 50)))
                                    {
                                        _local_3 = (_local_3 % instance.Type7Arr.length);
                                        _local_3 = instance.Type7Arr[_local_3];
                                        if (!instance.CheckEvent(_local_3))
                                        {
                                            _local_3 = instance.GetValidEventId(7);
                                        };
                                        instance.showContent(_local_3);
                                        if (ExternalInterface.available)
                                        {
                                            ExternalInterface.call("log_user_action", Context.getInstance().getPlayerBean().playerInfo.accountName, 1);
                                        };
                                    }
                                    else
                                    {
                                        return;
                                    };
                                }
                                else
                                {
                                    if (_local_2 == 8)
                                    {
                                        instance.showContent(42);
                                    }
                                    else
                                    {
                                        if (_local_2 == 9)
                                        {
                                            instance.showContent(43);
                                        }
                                        else
                                        {
                                            if (_local_2 == 10)
                                            {
                                                instance.showContent(44);
                                            }
                                            else
                                            {
                                                if (_local_2 == 11)
                                                {
                                                    instance.shareHandle(45);
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            RandomEventWin._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            if (instance.isPopUp)
            {
                PopUpManager.removePopUp(instance);
            };
        }

        public static function show(_arg_1:int):void
        {
            if (instance.isPopUp)
            {
                return;
            };
            setTimeout(showTimeOut, 1000, _arg_1);
        }


        private function GetValidEventId(_arg_1:int):int
        {
            var _local_2:int;
            if (_arg_1 == 1)
            {
                for each (_local_2 in this.Type1Arr)
                {
                    if (CheckEvent(_local_2))
                    {
                        return (_local_2);
                    };
                };
            }
            else
            {
                if (_arg_1 == 2)
                {
                    for each (_local_2 in this.Type2Arr)
                    {
                        if (CheckEvent(_local_2))
                        {
                            return (_local_2);
                        };
                    };
                }
                else
                {
                    if (_arg_1 == 4)
                    {
                        for each (_local_2 in this.Type4Arr)
                        {
                            if (CheckEvent(_local_2))
                            {
                                return (_local_2);
                            };
                        };
                    }
                    else
                    {
                        if (_arg_1 == 5)
                        {
                            for each (_local_2 in this.Type5Arr)
                            {
                                if (CheckEvent(_local_2))
                                {
                                    return (_local_2);
                                };
                            };
                        }
                        else
                        {
                            if (_arg_1 == 6)
                            {
                                for each (_local_2 in this.Type6Arr)
                                {
                                    if (CheckEvent(_local_2))
                                    {
                                        return (_local_2);
                                    };
                                };
                            }
                            else
                            {
                                if (_arg_1 == 7)
                                {
                                    for each (_local_2 in this.Type7Arr)
                                    {
                                        if (CheckEvent(_local_2))
                                        {
                                            return (_local_2);
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            close();
            return (0);
        }

        public function set stack(_arg_1:ViewStack):void
        {
            var _local_2:Object = this._109757064stack;
            if (_local_2 !== _arg_1)
            {
                this._109757064stack = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stack", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }

        [Bindable(event="propertyChange")]
        private function get strNoticeText():String
        {
            return (this._442266934strNoticeText);
        }

        [Bindable(event="propertyChange")]
        public function get type1():Canvas
        {
            return (this._110843959type1);
        }

        private function onComplete():void
        {
        }

        public function set YesSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1271618531YesSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1271618531YesSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "YesSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get type2():Canvas
        {
            return (this._110843960type2);
        }

        private function onResponse(_arg_1:CommandResponse):void
        {
            if (_arg_1.ok != CommandResponse.OK_DEFAULT)
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
        }

        private function set strTitle(_arg_1:String):void
        {
            var _local_2:Object = this._1775479463strTitle;
            if (_local_2 !== _arg_1)
            {
                this._1775479463strTitle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strTitle", _local_2, _arg_1));
            };
        }

        public function ___RandomEventWin_Button4_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function set strNoticeText(_arg_1:String):void
        {
            var _local_2:Object = this._442266934strNoticeText;
            if (_local_2 !== _arg_1)
            {
                this._442266934strNoticeText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strNoticeText", _local_2, _arg_1));
            };
        }

        public function set type1(_arg_1:Canvas):void
        {
            var _local_2:Object = this._110843959type1;
            if (_local_2 !== _arg_1)
            {
                this._110843959type1 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type1", _local_2, _arg_1));
            };
        }

        public function set type2(_arg_1:Canvas):void
        {
            var _local_2:Object = this._110843960type2;
            if (_local_2 !== _arg_1)
            {
                this._110843960type2 = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type2", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get strNoBtnText():String
        {
            return (this._1545744759strNoBtnText);
        }

        private function set strNeighborId(_arg_1:String):void
        {
            var _local_2:Object = this._2007048382strNeighborId;
            if (_local_2 !== _arg_1)
            {
                this._2007048382strNeighborId = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strNeighborId", _local_2, _arg_1));
            };
        }

        public function set NoSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._708816317NoSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._708816317NoSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "NoSubmitBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get stack():ViewStack
        {
            return (this._109757064stack);
        }

        override public function initialize():void
        {
            var target:RandomEventWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _RandomEventWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_RandomEventWinWatcherSetupUtil");
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

        private function set strNeighborIdArr(_arg_1:Array):void
        {
            var _local_2:Object = this._1738686659strNeighborIdArr;
            if (_local_2 !== _arg_1)
            {
                this._1738686659strNeighborIdArr = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strNeighborIdArr", _local_2, _arg_1));
            };
        }

        private function CheckEvent(_arg_1:int):Boolean
        {
            var _local_2:RandomEventBean;
            var _local_3:int;
            while (_local_3 < randomEventArray.length)
            {
                _local_2 = randomEventArray[_local_3];
                if (_local_2.id == _arg_1)
                {
                    return (true);
                };
                _local_3++;
            };
            return (false);
        }

        private function _RandomEventWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():String
            {
                var _local_1:* = strTitle;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _RandomEventWin_Label1.text = _arg_1;
            }, "_RandomEventWin_Label1.text");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = strNoticeText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                notice.text = _arg_1;
            }, "notice.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = strYesBtnText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                YesSubmitBtn.label = _arg_1;
            }, "YesSubmitBtn.label");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = strNoBtnText;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                NoSubmitBtn.label = _arg_1;
            }, "NoSubmitBtn.label");
            result[3] = binding;
            return (result);
        }

        public function ___RandomEventWin_Button1_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        private function VisitEmpire():void
        {
            var _local_6:String;
            var _local_1:int = MainWin.instance.fbBar.itemArray.length;
            var _local_2:int = int((Math.random() * _local_1));
            if (_local_2 >= _local_1)
            {
                _local_2--;
            };
            var _local_3:Object = MainWin.instance.fbBar.itemArray[_local_2];
            if (_local_3.fbid == 0)
            {
                _local_3 = MainWin.instance.fbBar.itemArray[0];
            };
            var _local_4:String = Context.getInstance().fbUrl;
            var _local_5:RegExp = /type=facebook&/gi;
            _local_4 = _local_4.replace("type=facebook&", "type=fbVisit&");
            _local_4 = ((((((_local_4 + "&TargetFbuid=") + _local_3.fbid) + "&TargetFbUserName=") + _local_3.name) + "&FromServer=") + GameConfig.instance.serverID);
            _local_6 = (((("http://" + _local_3.server) + ".evony.com/s.html?loginid=") + Context.getInstance().EncryptParam(_local_4)) + "&adv=www_evony_com_inde&FBS=1&_Vt=NVE");
            navigateToURL(new URLRequest(_local_6), "_blank");
        }

        private function btnHandle():void
        {
            var _local_1:SharedObject;
            if (iCurId == 42)
            {
                AllWindows.switchToFuncWindow(VoteWin.EVENT_SHOW);
                close();
                return;
            };
            ActionFactory.getInstance().getCommonCommands().setEventDone(iCurId, onResponse);
            if (iCurId != 8)
            {
                if (iCurId == 2)
                {
                    shareHandle(2);
                }
                else
                {
                    if (iCurId == 3)
                    {
                        shareHandle(3);
                    }
                    else
                    {
                        if (iCurId == 4)
                        {
                            VisitEmpire();
                        }
                        else
                        {
                            if (iCurId == 5)
                            {
                                SendGift();
                            }
                            else
                            {
                                if (iCurId == 7)
                                {
                                    shareHandle(7);
                                }
                                else
                                {
                                    if (iCurId == 9)
                                    {
                                        shareHandle(9);
                                    }
                                    else
                                    {
                                        if (iCurId == 41)
                                        {
                                            shareHandle(41);
                                            if (ExternalInterface.available)
                                            {
                                                ExternalInterface.call("log_user_action", Context.getInstance().getPlayerBean().playerInfo.accountName, 4);
                                            };
                                        }
                                        else
                                        {
                                            if (iCurId != 1)
                                            {
                                                shareHandle(iCurId);
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            close();
            if (iCurId == 1)
            {
                if (((UIUtil.checkOffice()) || (UIUtil.judgeTime() >= 7)))
                {
                    _local_1 = SharedObject.getLocal("SecurityCodeNotice", "/");
                    if (_local_1.data.value == null)
                    {
                        SecurityCodeNotice.show();
                        _local_1.data.value = "SecurityCodeNotice";
                        _local_1.flush();
                    };
                    if ((((((GameConfig.instance.serverID == "beta") || (GameConfig.instance.serverID.toLowerCase() == "na43")) || (GameConfig.instance.serverID.toLowerCase() == "na44")) || (GameConfig.instance.serverID.toLowerCase() == "na45")) || (GameConfig.instance.serverID == "NA44")))
                    {
                        digiTask.show();
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        private function get strTitle():String
        {
            return (this._1775479463strTitle);
        }

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function set strYesBtnText(_arg_1:String):void
        {
            var _local_2:Object = this._1969552851strYesBtnText;
            if (_local_2 !== _arg_1)
            {
                this._1969552851strYesBtnText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strYesBtnText", _local_2, _arg_1));
            };
        }

        public function set notice(_arg_1:Text):void
        {
            var _local_2:Object = this._1039690024notice;
            if (_local_2 !== _arg_1)
            {
                this._1039690024notice = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "notice", _local_2, _arg_1));
            };
        }

        private function showContent(_arg_1:int):void
        {
            var _local_3:RandomEventBean;
            if (((_arg_1 == 0) || (_arg_1 == 8)))
            {
                return;
            };
            if ((((!(Context.getInstance().facebookUser)) && (_arg_1 > 1)) && (!(_arg_1 == 42))))
            {
                return;
            };
            if (_arg_1 == 5)
            {
                MainWin.instance.gift.visible = true;
            };
            if (_arg_1 == 37)
            {
                MainWin.instance.shoe.visible = true;
            };
            if (!instance.isPopUp)
            {
                if (OffSale.instance.isPopUp)
                {
                    return;
                };
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainWin.instance.allWindowsFrame, true);
                MinePopupManager.instance.centerPopUp();
            };
            iCurId = _arg_1;
            var _local_2:Object = FbData.getInstance().getValue((20000 + _arg_1));
            if (_local_2 == null)
            {
                close();
                return;
            };
            this.evtImg.source = _local_2.img;
            strTitle = _local_2.title;
            strNoticeText = _local_2.desc;
            if (((_arg_1 == 43) || (_arg_1 == 44)))
            {
                strNoticeText = FacebookNoticeWin.repaceStrAll(_local_2.desc, "", 0, "");
            };
            strYesBtnText = _local_2.strYesBtnText;
            strNoBtnText = _local_2.strNoBtnText;
            if (strNoBtnText.length != 0)
            {
                if (iCurId != 42)
                {
                    if (iCurId == 41)
                    {
                        strNoBtnText = "Be selfish";
                    };
                }
                else
                {
                    strYesBtnText = _local_2.strYesBtnText;
                };
                this.stack.selectedChild = this.type2;
            }
            else
            {
                this.stack.selectedChild = this.type1;
            };
            var _local_4:int;
            while (_local_4 < randomEventArray.length)
            {
                _local_3 = randomEventArray[_local_4];
                if (_local_3.id == _arg_1)
                {
                    randomEventArray.removeItemAt(_local_4);
                    return;
                };
                _local_4++;
            };
        }

        [Bindable(event="propertyChange")]
        private function get strNeighborId():String
        {
            return (this._2007048382strNeighborId);
        }

        public function set evtImg(_arg_1:Image):void
        {
            var _local_2:Object = this._1290918176evtImg;
            if (_local_2 !== _arg_1)
            {
                this._1290918176evtImg = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "evtImg", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get strNeighborIdArr():Array
        {
            return (this._1738686659strNeighborIdArr);
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        [Bindable(event="propertyChange")]
        private function get strYesBtnText():String
        {
            return (this._1969552851strYesBtnText);
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        [Bindable(event="propertyChange")]
        public function get evtImg():Image
        {
            return (this._1290918176evtImg);
        }

        private function shareHandle(_arg_1:int):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:Object;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            if (ExternalInterface.available)
            {
                _local_2 = Context.getInstance().GetGuidStr();
                _local_3 = "";
                _local_4 = "";
                _local_5 = FbData.getInstance().getValue((20000 + _arg_1));
                if (_local_5 == null)
                {
                    return;
                };
                _local_6 = (((((((((((("?T=" + _arg_1.toString()) + "&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&StartTime=") + Context.getInstance().getPlayerBean().currentDateTime) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=10006&GUID=") + _local_2) + "&sign=");
                _local_7 = "";
                _local_8 = "";
                _local_8 = Context.getInstance().facebookNickName;
                if (((_local_8 == "") || (_local_8 == null)))
                {
                    if (ExternalInterface.available)
                    {
                        Context.getInstance().facebookNickName = ExternalInterface.call("facebook.fb_getUserName");
                        _local_8 = Context.getInstance().facebookNickName;
                    };
                };
                _local_7 = MD5.hash((((((_arg_1.toString() + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                _local_9 = FacebookNoticeWin.replaceStr(_local_5.contentA, _local_8);
                _local_10 = FacebookNoticeWin.replaceStr(_local_5.contentB, _local_8);
                _local_11 = "";
                _local_11 = ((GameConfig.instance.FbEventActionUrl + _local_6) + _local_7);
                _local_4 = (((((((((('{"name":"' + _local_9) + '","href":"') + _local_11) + '","description":"') + _local_10) + '","media":[{"type":"image","src":"') + _local_5.img) + '","href":"') + _local_11) + '"}]}');
                if (((_local_8 == "") || (_local_8 == null)))
                {
                    _local_8 = Context.getInstance().getPlayerBean().playerInfo.userName;
                };
                if (_arg_1 == 2)
                {
                    _local_3 = (((("{'text':'Visit the market!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                }
                else
                {
                    if (_arg_1 == 3)
                    {
                        _local_3 = (((("{'text':'Send Troops!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                    }
                    else
                    {
                        if (_arg_1 == 6)
                        {
                            _local_3 = (((("{'text':'Join the feast!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                        }
                        else
                        {
                            if (_arg_1 == 7)
                            {
                                _local_3 = (((("{'text':'Accept the treasure!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                            }
                            else
                            {
                                if (_arg_1 == 9)
                                {
                                    _local_3 = (((("{'text':'Supply medicine!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                }
                                else
                                {
                                    if (_arg_1 == 11)
                                    {
                                        _local_3 = (((("{'text':'Join the celebration!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                    }
                                    else
                                    {
                                        if (_arg_1 == 12)
                                        {
                                            _local_3 = (((("{'text':'Send water aid!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                        }
                                        else
                                        {
                                            if (_arg_1 == 13)
                                            {
                                                _local_3 = (((("{'text':'Accept the reinforcements!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                            }
                                            else
                                            {
                                                if (_arg_1 == 14)
                                                {
                                                    _local_3 = (((("{'text':'Send Assistance!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                }
                                                else
                                                {
                                                    if (_arg_1 == 15)
                                                    {
                                                        _local_3 = (((("{'text':'Help train!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                    }
                                                    else
                                                    {
                                                        if (_arg_1 == 16)
                                                        {
                                                            _local_3 = (((("{'text':'Pick up a few!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                        }
                                                        else
                                                        {
                                                            if (_arg_1 == 17)
                                                            {
                                                                _local_3 = (((("{'text':'Accept stone!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                            }
                                                            else
                                                            {
                                                                if (_arg_1 == 18)
                                                                {
                                                                    _local_3 = (((("{'text':'Accept equipment!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                }
                                                                else
                                                                {
                                                                    if (_arg_1 == 19)
                                                                    {
                                                                        _local_3 = (((("{'text':'Attend the parade!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                    }
                                                                    else
                                                                    {
                                                                        if (_arg_1 == 20)
                                                                        {
                                                                            _local_3 = (((("{'text':'Accept offer!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                        }
                                                                        else
                                                                        {
                                                                            if (_arg_1 == 21)
                                                                            {
                                                                                _local_3 = (((("{'text':'Participate the Joust!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                            }
                                                                            else
                                                                            {
                                                                                if (_arg_1 == 22)
                                                                                {
                                                                                    _local_3 = (((("{'text':'Visit the Famous!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                }
                                                                                else
                                                                                {
                                                                                    if (_arg_1 == 23)
                                                                                    {
                                                                                        _local_3 = (((("{'text':'View artifact!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                        if (_arg_1 == 24)
                                                                                        {
                                                                                            _local_3 = (((("{'text':'Get a tool!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (_arg_1 == 25)
                                                                                            {
                                                                                                _local_3 = (((("{'text':'Accept lumber!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                            }
                                                                                            else
                                                                                            {
                                                                                                if (_arg_1 == 26)
                                                                                                {
                                                                                                    _local_3 = (((("{'text':'Listen to stories!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                    if (_arg_1 == 27)
                                                                                                    {
                                                                                                        _local_3 = (((("{'text':'Watch the event!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (_arg_1 == 28)
                                                                                                        {
                                                                                                            _local_3 = (((("{'text':'Try food!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                        }
                                                                                                        else
                                                                                                        {
                                                                                                            if (_arg_1 == 30)
                                                                                                            {
                                                                                                                _local_3 = (((("{'text':'Offer Assistance!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                            }
                                                                                                            else
                                                                                                            {
                                                                                                                if (_arg_1 == 31)
                                                                                                                {
                                                                                                                    _local_3 = (((("{'text':'Attend the Tournament!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                }
                                                                                                                else
                                                                                                                {
                                                                                                                    if (_arg_1 == 32)
                                                                                                                    {
                                                                                                                        _local_3 = (((("{'text':'Attend the Archery Games!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                    }
                                                                                                                    else
                                                                                                                    {
                                                                                                                        if (_arg_1 == 33)
                                                                                                                        {
                                                                                                                            _local_3 = (((("{'text':'Accept invitation!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                        }
                                                                                                                        else
                                                                                                                        {
                                                                                                                            if (_arg_1 == 37)
                                                                                                                            {
                                                                                                                                _local_3 = (((("{'text':'Enjoy the meal', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                            }
                                                                                                                            else
                                                                                                                            {
                                                                                                                                if (_arg_1 == 38)
                                                                                                                                {
                                                                                                                                    _local_3 = (((((("{'text':'Help " + _local_8) + " now!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                                }
                                                                                                                                else
                                                                                                                                {
                                                                                                                                    if (_arg_1 == 39)
                                                                                                                                    {
                                                                                                                                        _local_3 = (((((("{'text':'Gamble with " + _local_8) + "!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                                    }
                                                                                                                                    else
                                                                                                                                    {
                                                                                                                                        if (_arg_1 == 40)
                                                                                                                                        {
                                                                                                                                            _local_3 = (((("{'text':'Join for some fun!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                                        }
                                                                                                                                        else
                                                                                                                                        {
                                                                                                                                            if (_arg_1 == 41)
                                                                                                                                            {
                                                                                                                                                _local_3 = (((("{'text':'Get a free amulet!', 'href':'" + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "'}");
                                                                                                                                            }
                                                                                                                                            else
                                                                                                                                            {
                                                                                                                                                if (_arg_1 == 43)
                                                                                                                                                {
                                                                                                                                                    _local_3 = (((((((("{'text':'Vote for " + _local_8) + "!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "&UserName=") + Context.getInstance().getPlayerBean().playerInfo.userName) + "'}");
                                                                                                                                                }
                                                                                                                                                else
                                                                                                                                                {
                                                                                                                                                    if (_arg_1 == 44)
                                                                                                                                                    {
                                                                                                                                                        _local_3 = (((((((("{'text':'Play with " + _local_8) + "!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "&UserName=") + Context.getInstance().getPlayerBean().playerInfo.userName) + "'}");
                                                                                                                                                    }
                                                                                                                                                    else
                                                                                                                                                    {
                                                                                                                                                        if (_arg_1 == 45)
                                                                                                                                                        {
                                                                                                                                                            if (Context.getInstance().isSpeedType == 0)
                                                                                                                                                            {
                                                                                                                                                                _local_7 = MD5.hash((((((((((_arg_1.toString() + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + Context.getInstance().isSpeedType) + Context.getInstance().getCurCastle().id) + Context.getInstance().buidwithhelpLevel) + Context.getInstance().positionId) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                                                                                                                                                                _local_11 = ((((((((((GameConfig.instance.FbEventActionUrl + _local_6) + _local_7) + "&SpeedID=") + Context.getInstance().positionId) + "&SpeedType=") + Context.getInstance().isSpeedType) + "&castleid=") + Context.getInstance().getCurCastle().id) + "&SpeedLevel=") + Context.getInstance().buidwithhelpLevel);
                                                                                                                                                                _local_9 = (((("I need friends to help me build my Level " + Context.getInstance().buidwithhelpLevel) + " ") + Context.getInstance().buidwithhelpName) + " in Evony!");
                                                                                                                                                                _local_3 = (((((((((((((((("{'text':'Help " + _local_8) + "!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "&SpeedType=") + Context.getInstance().isSpeedType) + "&UserName=") + Context.getInstance().getPlayerBean().playerInfo.userName) + "&SpeedID=") + Context.getInstance().positionId) + "&SpeedLevel=") + Context.getInstance().buidwithhelpLevel) + "&castleid=") + Context.getInstance().getCurCastle().id) + "'}");
                                                                                                                                                            }
                                                                                                                                                            else
                                                                                                                                                            {
                                                                                                                                                                _local_7 = MD5.hash(((((((((_arg_1.toString() + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + Context.getInstance().isSpeedType) + Context.getInstance().getCurCastle().id) + Context.getInstance().buidwithhelpLevel) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                                                                                                                                                                _local_11 = ((((((((GameConfig.instance.FbEventActionUrl + _local_6) + _local_7) + "&castleid=") + Context.getInstance().getCurCastle().id) + "&SpeedType=") + Context.getInstance().isSpeedType) + "&SpeedLevel=") + Context.getInstance().buidwithhelpLevel);
                                                                                                                                                                _local_9 = (((("I need friends to help me research my Level " + Context.getInstance().buidwithhelpLevel) + " ") + Context.getInstance().buidwithhelpName) + " in Evony!");
                                                                                                                                                                _local_3 = (((((((((((((((("{'text':'Help " + _local_8) + "!', 'href':'") + GameConfig.instance.FbEventActionUrl) + _local_6) + _local_7) + "&SpeedType=") + Context.getInstance().isSpeedType) + "&UserName=") + Context.getInstance().getPlayerBean().playerInfo.userName) + "&SpeedID=") + 0) + "&SpeedLevel=") + Context.getInstance().buidwithhelpLevel) + "&castleid=") + Context.getInstance().getCurCastle().id) + "'}");
                                                                                                                                                            };
                                                                                                                                                            _local_10 = "Do you want to help me and get some resources as reward?";
                                                                                                                                                            _local_4 = (((((((((('{"name":"' + _local_9) + '","href":"') + _local_11) + '","description":"') + _local_10) + '","media":[{"type":"image","src":"') + _local_5.img) + '","href":"') + _local_11) + '"}]}');
                                                                                                                                                        };
                                                                                                                                                    };
                                                                                                                                                };
                                                                                                                                            };
                                                                                                                                        };
                                                                                                                                    };
                                                                                                                                };
                                                                                                                            };
                                                                                                                        };
                                                                                                                    };
                                                                                                                };
                                                                                                            };
                                                                                                        };
                                                                                                    };
                                                                                                };
                                                                                            };
                                                                                        };
                                                                                    };
                                                                                };
                                                                            };
                                                                        };
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
                Context.getInstance().fbPublish(_local_4, _local_3, GameConfig.instance.serverID, ("101" + _arg_1), _local_2);
                close();
            };
        }

        private function _RandomEventWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = strTitle;
            _local_1 = strNoticeText;
            _local_1 = strYesBtnText;
            _local_1 = strNoBtnText;
        }

        private function set strNoBtnText(_arg_1:String):void
        {
            var _local_2:Object = this._1545744759strNoBtnText;
            if (_local_2 !== _arg_1)
            {
                this._1545744759strNoBtnText = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "strNoBtnText", _local_2, _arg_1));
            };
        }

        private function SendGift():void
        {
            navigateToURL(new URLRequest(((GameConfig.instance.SendGiftUrl + "?SID=") + GameConfig.instance.serverID)), "_blank");
        }


    }
}//package view

