// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.rank.HallFbNotice

package view.module.rank
{
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.events.MouseEvent;
    import flash.external.ExternalInterface;
    import com.evony.Context;
    import com.evony.data.FbData;
    import com.evony.GameConfig;
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

    public class HallFbNotice extends Canvas 
    {

        public static var instance:HallFbNotice = new (HallFbNotice)();

        private var _1039690024notice:Text;
        private var typename:String;
        private var _1271618531YesSubmitBtn:Button;
        private var isTryUser:Boolean = false;
        private var isFavorite:Boolean = false;
        private var _708816317NoSubmitBtn:Button;
        private var rank:int;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":440,
                    "height":250,
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
                                            "text":"SYSTEM",
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
                            this.top = "43";
                            this.left = "20";
                            this.right = "20";
                            this.bottom = "46";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Text,
                                    "id":"notice",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "40";
                                        this.left = "30";
                                        this.right = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "height":100,
                                            "selectable":false
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"YesSubmitBtn",
                        "events":{"click":"__YesSubmitBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.fontWeight = "bold";
                            this.fontSize = 12;
                            this.bottom = "35";
                            this.left = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Share",
                                "styleName":"b75",
                                "width":75,
                                "height":25
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
                            this.bottom = "35";
                            this.right = "125";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "label":"Cancel",
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___HallFbNotice_Button3_click"},
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

        public function HallFbNotice()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 250;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function show(_arg_1:int, _arg_2:String):void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.rank = _arg_1;
            instance.typename = _arg_2;
            instance.notice.text = (((("Congratulations! You have inducted to Hall of Fame and won Rank " + _arg_1) + " in ") + _arg_2) + " Prestige Class.  Share it and get BONUS reward, for both you and your friends!");
        }


        [Bindable(event="propertyChange")]
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
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

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }

        public function ___HallFbNotice_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }

        private function btnHandle():void
        {
            var _local_1:* = "";
            if (ExternalInterface.available)
            {
                _local_1 = ExternalInterface.call("facebook.fb_getUserName");
            };
            var _local_2:* = (_local_1 + " has inducted in the Hall of Fame!");
            var _local_3:* = (((((_local_1 + " has become a powerful lord and inducted in the Hall of Fame and won Rank ") + instance.rank) + " in ") + instance.typename) + " Class. The Hall of Famers have grown a vast empire and achieved eternal glory for their people in Evony!");
            var _local_4:String = Context.getInstance().GetGuidStr();
            var _local_5:Object = FbData.getInstance().getValue(10003);
            var _local_6:* = (((((('{"name":"' + _local_2) + '","href":"http://www.evony.com/","description":"') + _local_3) + '","media":[{"type":"image","src":"') + _local_5.img) + '"}]}');
            var _local_7:* = "";
            var _local_8:* = (((((((("&StartTime=" + Context.getInstance().getPlayerBean().currentDateTime) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=10003&GUID=") + _local_4) + "&sign=");
            var _local_9:* = "";
            _local_9 = MD5.hash((((("Celebrate" + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
            _local_7 = (((((("{'text':'Celebrate and get a bonus!', 'href':'" + GameConfig.instance.FbActionUrl) + "?T=Celebrate&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_8) + _local_9) + "'}");
            ExternalInterface.call("facebook.fb_streamPublish", "", _local_6, _local_7, "", "", GameConfig.instance.serverID, 10003, _local_4);
            close();
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

        public function set YesSubmitBtn(_arg_1:Button):void
        {
            var _local_2:Object = this._1271618531YesSubmitBtn;
            if (_local_2 !== _arg_1)
            {
                this._1271618531YesSubmitBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "YesSubmitBtn", _local_2, _arg_1));
            };
        }

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }


    }
}//package view.module.rank

