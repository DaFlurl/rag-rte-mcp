// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.IncreaseProduct

package view
{
    import mx.containers.Canvas;
    import mx.controls.Text;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Button;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import com.evony.common.module.CommandResponse;
    import flash.external.ExternalInterface;
    import com.evony.data.FbData;
    import com.evony.Context;
    import com.adobe.crypto.MD5;
    import com.evony.GameConfig;
    import view.ui.AlertWin;
    import mx.events.PropertyChangeEvent;
    import com.evony.client.action.ActionFactory;
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

    public class IncreaseProduct extends Canvas 
    {

        public static var instance:IncreaseProduct = new (IncreaseProduct)();

        private var _1039690024notice:Text;
        private var fbName:String = "";
        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":400,
                    "height":200,
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
                        "type":Text,
                        "id":"notice",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.textAlign = "left";
                            this.top = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "width":300,
                                "text":"Your friend will be happy when knowing that you helped him increase his resources production. Help him and get a small reward now?",
                                "styleName":"ParamgraphText1"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "30";
                            this.horizontalCenter = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___IncreaseProduct_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"yes",
                                            "styleName":"subTitleButton"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___IncreaseProduct_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"no",
                                            "styleName":"subTitleButton"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___IncreaseProduct_Button3_click"},
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

        public function IncreaseProduct()
        {
            mx_internal::_document = this;
            this.width = 400;
            this.height = 200;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        public function ___IncreaseProduct_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function helpIncreaseResponse(_arg_1:CommandResponse):void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                if (ExternalInterface.available)
                {
                    fbName = ExternalInterface.call("facebook.fb_getUserName");
                };
                _local_2 = FbData.getInstance().getValue(10004);
                _local_3 = (((fbName + " is such a great lord and just maximized ") + Context.getInstance().bVisitHostName) + "'s resources production in Evony.");
                _local_4 = (((((((fbName + " just visited ") + Context.getInstance().bVisitHostName) + "'s empire and maximized the resources production on all of ") + Context.getInstance().bVisitHostName) + "'s cities and got a small reward.") + fbName) + " would be very happy if his kind neighbors do this favor for him.");
                _local_5 = (((((('{"name":"' + _local_3) + '","href":"http://www.evony.com/","description":"') + _local_4) + '","media":[{"type":"image","src":"') + _local_2.img) + '","href":"http://www.evony.com/"}]}');
                _local_6 = Context.getInstance().GetGuidStr();
                _local_7 = MD5.hash((((("PlayEvony" + Context.getInstance().getPlayerBean().playerInfo.sex) + Context.getInstance().userName) + GameConfig.instance.serverID) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                _local_8 = (((((((((((((((("{'text':'Play Evony with " + fbName) + "!', 'href':'") + GameConfig.instance.FbActionUrl) + "?T=PlayEvony&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&Fbuid=") + Context.getInstance().userName) + "&SID=") + GameConfig.instance.serverID) + "&FEEDID=") + _local_2.id) + "&GUID=") + _local_6) + "&sign=") + _local_7) + "'}");
                Context.getInstance().fbPublishEx(_local_5, _local_8, GameConfig.instance.serverID, "10004", _local_6, Context.getInstance().TargetFbuid);
                onClose();
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
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

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function sure():void
        {
            if (ExternalInterface.available)
            {
                fbName = ExternalInterface.call("facebook.fb_getUserName");
            };
            ActionFactory.getInstance().getVisitCommands().helpIncreaseProduction(Context.getInstance().VisitSelfSID, fbName, helpIncreaseResponse);
            onClose();
        }

        public function ___IncreaseProduct_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function onClose():void
        {
            PopUpManager.removePopUp(this);
        }

        public function ___IncreaseProduct_Button1_click(_arg_1:MouseEvent):void
        {
            sure();
        }

        [Bindable(event="propertyChange")]
        public function get notice():Text
        {
            return (this._1039690024notice);
        }


    }
}//package view

