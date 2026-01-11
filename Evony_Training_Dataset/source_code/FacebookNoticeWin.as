// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FacebookNoticeWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import mx.core.mx_internal;
    import flash.external.ExternalInterface;
    import com.evony.Context;
    import com.evony.GameConfig;
    import com.adobe.crypto.MD5;
    import com.evony.common.beans.PlayerInfoBean;
    import com.evony.factory.PlayerInfoTypeManager;
    import com.evony.data.FbData;
    import mx.events.PropertyChangeEvent;
    import flash.display.BitmapData;
    import mx.core.Application;
    import mx.managers.PopUpManager;
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

    public class FacebookNoticeWin extends Canvas 
    {

        public static var instancePopup:FacebookNoticeWin;
        private static var ss:Array = new Array("", "0", "00", "000", "0000", "00000", "000000");

        private var action_link:Object;
        private var fbName:String;
        private var _3079825desc:String;
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":555,
                    "height":250
                });
            }
        });
        private var fbObject:Object;

        public function FacebookNoticeWin()
        {
            mx_internal::_document = this;
            this.width = 555;
            this.height = 250;
        }

        public static function doSendFeed(_arg_1:Object, _arg_2:String):void
        {
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            if (ExternalInterface.available)
            {
                _local_3 = replaceStr(_arg_1.contentA, _arg_2);
                _local_4 = replaceStr(_arg_1.contentB, _arg_2);
                _local_5 = Context.getInstance().GetGuidStr();
                _local_6 = "";
                _local_7 = "";
                _local_8 = "";
                _local_9 = (((((((((("&StartTime=" + Context.getInstance().getPlayerBean().currentDateTime) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=") + _arg_1.id) + "&GUID=") + _local_5) + "&sign=");
                _local_10 = "";
                if (_arg_1.action_link_type == 1)
                {
                    _local_10 = MD5.hash(((((("EarnPrestige" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                    _local_8 = ((((GameConfig.instance.FbActionUrl + "?T=EarnPrestige&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10);
                    _local_6 = (((((((((('{"name":"' + _local_3) + '","href":"') + _local_8) + '","description":"') + _local_4) + '","media":[{"type":"image","src":"') + _arg_1.img) + '","href":"') + _local_8) + '"}]}');
                    _local_7 = (((((("{'text':'Earn some Prestige!', 'href':'" + GameConfig.instance.FbActionUrl) + "?T=EarnPrestige&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10) + "'}");
                }
                else
                {
                    if (_arg_1.action_link_type == 2)
                    {
                        _local_10 = MD5.hash(((((("VisitAndReward" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                        _local_8 = ((((GameConfig.instance.FbActionUrl + "?T=VisitAndReward&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10);
                        _local_6 = (((((((((('{"name":"' + _local_3) + '","href":"') + _local_8) + '","description":"') + _local_4) + '","media":[{"type":"image","src":"') + _arg_1.img) + '","href":"') + _local_8) + '"}]}');
                        _local_7 = (((((("{'text':'Visit him and get reward!', 'href':'" + GameConfig.instance.FbActionUrl) + "?T=VisitAndReward&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10) + "'}");
                    }
                    else
                    {
                        if (_arg_1.action_link_type == 3)
                        {
                            _local_10 = MD5.hash(((((("Celebrate" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                            _local_8 = ((((GameConfig.instance.FbActionUrl + "?T=Celebrate&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10);
                            _local_6 = (((((((((('{"name":"' + _local_3) + '","href":"') + _local_8) + '","description":"') + _local_4) + '","media":[{"type":"image","src":"') + _arg_1.img) + '","href":"') + _local_8) + '"}]}');
                            _local_7 = (((((("{'text':'Celebrate and get a bonus!', 'href':'" + GameConfig.instance.FbActionUrl) + "?T=Celebrate&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + _local_9) + _local_10) + "'}");
                        }
                        else
                        {
                            _local_10 = MD5.hash((((("PlayEvony" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                            _local_8 = ((((((((((((GameConfig.instance.FbActionUrl + "?T=PlayEvony&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=") + _arg_1.id) + "&GUID=") + _local_5) + "&sign=") + _local_10);
                            _local_6 = (((((((((('{"name":"' + _local_3) + '","href":"') + _local_8) + '","description":"') + _local_4) + '","media":[{"type":"image","src":"') + _arg_1.img) + '","href":"') + _local_8) + '"}]}');
                            _local_7 = (((((((((((((((("{'text':'Play Evony with " + _arg_2) + "!', 'href':'") + GameConfig.instance.FbActionUrl) + "?T=PlayEvony&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=") + _arg_1.id) + "&GUID=") + _local_5) + "&sign=") + _local_10) + "'}");
                        };
                    };
                };
                ExternalInterface.call("facebook.fb_streamPublish", "", _local_6, _local_7, "", "", GameConfig.instance.serverID, _arg_1.id, _local_5, _arg_2);
            };
        }

        public static function replaceStr(_arg_1:String, _arg_2:String):String
        {
            if (((_arg_2 == "") || (_arg_2 == null)))
            {
                _arg_2 = Context.getInstance().getPlayerBean().playerInfo.userName;
            };
            var _local_3:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            return (repaceStrAll(_arg_1, _arg_2, _local_3.sex, PlayerInfoTypeManager.getTitle(_local_3.titleId)));
        }

        public static function repaceStrAll(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:String):String
        {
            var _local_5:Array = ["his", "her"];
            var _local_6:Array = ["He", "She"];
            var _local_7:Array = ["him", "her"];
            _arg_1 = _arg_1.replace(new RegExp("{him/her}", "ig"), _local_7[_arg_3]);
            _arg_1 = _arg_1.replace(new RegExp("{his/her}", "ig"), _local_5[_arg_3]);
            _arg_1 = _arg_1.replace(new RegExp("{He/She}", "ig"), _local_6[_arg_3]);
            _arg_1 = _arg_1.replace(new RegExp("{name}", "ig"), _arg_2);
            _arg_1 = _arg_1.replace(new RegExp("{title}", "ig"), _arg_4);
            _arg_1 = _arg_1.replace(new RegExp('"', "ig"), "\\'");
            return (_arg_1.replace(new RegExp("{votecount}", "ig"), Context.getInstance().getPlayerBean().playerInfo.getvotes.toString()));
        }

        public static function show(_arg_1:Object):void
        {
            if (instancePopup == null)
            {
                instancePopup = new (FacebookNoticeWin)();
            };
            instancePopup.fbObject = _arg_1;
            instancePopup.action_link = FbData.getInstance().getActionLink(_arg_1.action_link_id);
            instancePopup.refresh();
        }


        private function refresh():void
        {
            fbName = Context.getInstance().facebookNickName;
            if (((fbName == "") || (fbName == null)))
            {
                if (ExternalInterface.available)
                {
                    Context.getInstance().facebookNickName = ExternalInterface.call("facebook.fb_getUserName");
                    fbName = Context.getInstance().facebookNickName;
                };
            };
            desc = fbObject.desc;
            doSendFeed(fbObject, fbName);
        }

        private function set desc(_arg_1:String):void
        {
            var _local_2:Object = this._3079825desc;
            if (_local_2 !== _arg_1)
            {
                this._3079825desc = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "desc", _local_2, _arg_1));
            };
        }

        private function setItemCurValue():void
        {
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        [Bindable(event="propertyChange")]
        private function get desc():String
        {
            return (this._3079825desc);
        }

        private function makeScreenShot():void
        {
            var _local_4:int;
            var _local_5:uint;
            var _local_6:String;
            var _local_7:int;
            var _local_1:BitmapData = new BitmapData(EvonyClient(Application.application).width, EvonyClient(Application.application).height, false);
            _local_1.draw(EvonyClient(Application.application));
            var _local_2:* = "";
            var _local_3:int;
            while (_local_3 < _local_1.height)
            {
                _local_4 = 0;
                while (_local_4 < _local_1.width)
                {
                    if ((((_local_4 % 16) == 0) && ((_local_3 % 16) == 0)))
                    {
                        _local_5 = (_local_1.getPixel(_local_4, _local_3) & 0xFFFFFF);
                        _local_6 = _local_5.toString(16);
                        _local_7 = (6 - _local_6.length);
                        if (_local_7 != 0)
                        {
                            _local_6 = (ss[_local_7] + _local_6);
                        };
                        _local_2 = (_local_2 + _local_6);
                    };
                    _local_4++;
                };
                _local_3++;
            };
            ExternalInterface.call("showScreenShotString", _local_1.width, _local_1.height, _local_2);
        }

        public function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        private function shareHandle():void
        {
            doSendFeed(this.fbObject, this.fbName);
            if (ExternalInterface.available)
            {
                onClose();
            };
        }


    }
}//package view.ui

