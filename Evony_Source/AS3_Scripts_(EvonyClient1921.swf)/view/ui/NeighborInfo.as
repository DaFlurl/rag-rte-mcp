// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.NeighborInfo

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import mx.binding.Binding;
    import com.evony.Lang;
    import flash.utils.getDefinitionByName;
    import view.ViewMessage;
    import view.RandomEventWin;
    import com.evony.Context;
    import com.evony.GameConfig;
    import flash.external.ExternalInterface;
    import mx.managers.BrowserManager;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.client.action.ActionFactory;
    import com.adobe.crypto.MD5;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.visit.GetAllVisitorCommentsResponse;
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

    public class NeighborInfo extends Canvas implements IBindingClient 
    {

        public static var instance:NeighborInfo = new (NeighborInfo)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1613330801iNotReadCount:int;
        private var pageSize:int = 3;
        public var _NeighborInfo_Image2:Image;
        private var _1125923055curPage:int = 1;
        public var _NeighborInfo_Label3:Label;
        public var _NeighborInfo_Image4:Image;
        public var _NeighborInfo_Label5:Label;
        public var _NeighborInfo_Label6:Label;
        public var _NeighborInfo_Label7:Label;
        public var _NeighborInfo_Label8:Label;
        public var _NeighborInfo_Label9:Label;
        public var _NeighborInfo_Label4:Label;
        public var _NeighborInfo_Label10:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":480,
                    "height":260,
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
                                            "text":"Neighbor Info",
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
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Canvas,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.left = "10";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":53,
                                            "height":53,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.bottom = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/friendsFaceBg.png"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "id":"_NeighborInfo_Image2",
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "width":43,
                                                        "height":43
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Image,
                                                "stylesFactory":function ():void
                                                {
                                                    this.horizontalCenter = "0";
                                                    this.verticalCenter = "0";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"source":"images/friendsFaceGg.png"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.left = "130";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "text":"name:",
                                            "styleName":"PropertyName1"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label3",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "10";
                                        this.left = "230";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label4",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "30";
                                        this.left = "130";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label5",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "30";
                                        this.left = "230";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label6",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "50";
                                        this.left = "130";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label7",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "50";
                                        this.left = "230";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label8",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "70";
                                        this.left = "130";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyName1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label9",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "70";
                                        this.left = "230";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"PropertyValue1"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "5";
                                        this.horizontalGap = 0;
                                        this.horizontalAlign = "center";
                                        this.verticalAlign = "top";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___NeighborInfo_Button1_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Send Gift",
                                                        "styleName":"b95"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___NeighborInfo_Button2_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Messages",
                                                        "styleName":"b95"
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Button,
                                                "events":{"click":"___NeighborInfo_Button3_click"},
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "label":"Visit Empire",
                                                        "styleName":"b95"
                                                    });
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Image,
                                    "id":"_NeighborInfo_Image4",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "10";
                                        this.left = "250";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"source":"images/icon/info/infoCount.png"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_NeighborInfo_Label10",
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "12";
                                        this.left = "234";
                                        this.textAlign = "left";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":28,
                                            "mouseChildren":false,
                                            "mouseEnabled":false,
                                            "styleName":"LabelWhite13"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___NeighborInfo_Button4_click"},
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
        private var _3237038info:Object = new Object();
        private var neighborInfo_arr:Array = new Array();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function NeighborInfo()
        {
            mx_internal::_document = this;
            this.width = 480;
            this.height = 260;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            NeighborInfo._watcherSetupUtil = _arg_1;
        }

        public static function show(_arg_1:Object):void
        {
            instance.info = _arg_1;
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        private function set curPage(_arg_1:int):void
        {
            var _local_2:Object = this._1125923055curPage;
            if (_local_2 !== _arg_1)
            {
                this._1125923055curPage = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "curPage", _local_2, _arg_1));
            };
        }

        public function ___NeighborInfo_Button1_click(_arg_1:MouseEvent):void
        {
            SendGift();
        }

        public function ___NeighborInfo_Button3_click(_arg_1:MouseEvent):void
        {
            VisitEmpire();
        }

        private function _NeighborInfo_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (info.image);
            }, function (_arg_1:Object):void
            {
                _NeighborInfo_Image2.source = _arg_1;
            }, "_NeighborInfo_Image2.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = info.name;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label3.text = _arg_1;
            }, "_NeighborInfo_Label3.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("爵位") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label4.text = _arg_1;
            }, "_NeighborInfo_Label4.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = info.title;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label5.text = _arg_1;
            }, "_NeighborInfo_Label5.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (Lang.msg("声望") + ":");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label6.text = _arg_1;
            }, "_NeighborInfo_Label6.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = info.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label7.text = _arg_1;
            }, "_NeighborInfo_Label7.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = Lang.msg("服务器名称:");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label8.text = _arg_1;
            }, "_NeighborInfo_Label8.text");
            result[6] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = info.server;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label9.text = _arg_1;
            }, "_NeighborInfo_Label9.text");
            result[7] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iNotReadCount == 0) ? false : false);
            }, function (_arg_1:Boolean):void
            {
                _NeighborInfo_Image4.visible = _arg_1;
            }, "_NeighborInfo_Image4.visible");
            result[8] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = iNotReadCount;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _NeighborInfo_Label10.text = _arg_1;
            }, "_NeighborInfo_Label10.text");
            result[9] = binding;
            binding = new Binding(this, function ():Boolean
            {
                return ((iNotReadCount == 0) ? false : false);
            }, function (_arg_1:Boolean):void
            {
                _NeighborInfo_Label10.visible = _arg_1;
            }, "_NeighborInfo_Label10.visible");
            result[10] = binding;
            return (result);
        }

        override public function initialize():void
        {
            var target:NeighborInfo;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _NeighborInfo_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_NeighborInfoWatcherSetupUtil");
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

        public function ReadVisitMessage():void
        {
            ViewMessage.show(info);
        }

        private function _NeighborInfo_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = info.image;
            _local_1 = info.name;
            _local_1 = (Lang.msg("爵位") + ":");
            _local_1 = info.title;
            _local_1 = (Lang.msg("声望") + ":");
            _local_1 = info.prestige;
            _local_1 = Lang.msg("服务器名称:");
            _local_1 = info.server;
            _local_1 = ((iNotReadCount == 0) ? false : false);
            _local_1 = iNotReadCount;
            _local_1 = ((iNotReadCount == 0) ? false : false);
        }

        [Bindable(event="propertyChange")]
        public function get iNotReadCount():int
        {
            return (this._1613330801iNotReadCount);
        }

        private function VisitEmpire():void
        {
            var _local_3:String;
            var _local_4:String;
            RandomEventWin.show(5);
            var _local_1:String = Context.getInstance().fbUrl;
            var _local_2:RegExp = /type=facebook&/gi;
            _local_1 = _local_1.replace("type=facebook&", "type=fbVisit&");
            _local_1 = ((((((_local_1 + "&TargetFbuid=") + info.fbid) + "&TargetFbUserName=") + info.name) + "&FromServer=") + GameConfig.instance.serverID);
            _local_3 = (((("http://" + info.server) + ".evony.com/s.html?loginid=") + Context.getInstance().EncryptParam(_local_1)) + "&adv=www_evony_com_inde&FBS=1&_Vt=NVE");
            if (ExternalInterface.available)
            {
                _local_4 = ExternalInterface.call("getPageUrl");
            };
            if (_local_4 == null)
            {
                _local_4 = ("" + BrowserManager.getInstance().url);
            };
            if (_local_4.indexOf("gsvn.evony.com") >= 0)
            {
                _local_3 = (("/s.html?loginid=" + Context.getInstance().EncryptParam(_local_1)) + "&adv=www_evony_com_inde&FBS=1&_Vt=NVE");
            };
            navigateToURL(new URLRequest(_local_3), "_blank");
        }

        public function set iNotReadCount(_arg_1:int):void
        {
            var _local_2:Object = this._1613330801iNotReadCount;
            if (_local_2 !== _arg_1)
            {
                this._1613330801iNotReadCount = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "iNotReadCount", _local_2, _arg_1));
            };
        }

        public function reFresh():void
        {
            var _local_1:String;
            ActionFactory.getInstance().getVisitCommands().getVisitorComments(info.fbid.toString(), curPage, pageSize, GetVisitorCommentResponse);
            if (info.prestige == "")
            {
                _local_1 = MD5.hash((MD5.hash((info.server + info.fbid)) + "IUGI_md5_key_{djfiji3*4930}-{fjdi3284$9dlld}"));
                UIUtil.loadFile(((((("http://www.evony.com/index.do?PageModule=InterfaceUserGameInfo&SID=" + info.server) + "&U=") + info.fbid) + "&K=") + _local_1), loadOk, loadError);
            };
        }

        [Bindable(event="propertyChange")]
        private function get info():Object
        {
            return (this._3237038info);
        }

        private function GetVisitorCommentResponse(_arg_1:GetAllVisitorCommentsResponse):void
        {
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                iNotReadCount = _arg_1.total;
            };
        }

        public function ___NeighborInfo_Button2_click(_arg_1:MouseEvent):void
        {
            ReadVisitMessage();
        }

        private function loadError():void
        {
        }

        public function ___NeighborInfo_Button4_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function set info(_arg_1:Object):void
        {
            var _local_2:Object = this._3237038info;
            if (_local_2 !== _arg_1)
            {
                this._3237038info = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "info", _local_2, _arg_1));
            };
        }

        private function RecentActivities():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.RecentActivitiesUrl), "_blank");
        }

        private function loadOk(_arg_1:Object):void
        {
            var _local_2:String = _arg_1.toString();
            if (_arg_1.toString() == "E03")
            {
                return;
            };
            if (((_arg_1.toString() == "E01") || (_arg_1.toString() == "E02")))
            {
                _local_2 = "";
            };
            neighborInfo_arr = _local_2.split(",");
            if (neighborInfo_arr.length > 0)
            {
                info.prestige = neighborInfo_arr[1];
                info.title = neighborInfo_arr[2];
            };
        }

        private function SendGift():void
        {
            navigateToURL(new URLRequest(((((((GameConfig.instance.SendGiftUrl + "?SID=") + info.server) + "&TargetFbuid=") + info.fbid) + "&SelfSID=") + GameConfig.instance.serverID)), "_blank");
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }


    }
}//package view.ui

