// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ServerList

package view
{
    import mx.containers.Canvas;
    import mx.containers.Tile;
    import mx.controls.Label;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Button;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import flash.external.ExternalInterface;
    import mx.managers.BrowserManager;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
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

    public class ServerList extends Canvas 
    {

        public static var instance:ServerList = new (ServerList)();

        private var _1699899637serverListUi:Tile;
        private var _1721972741nametxt:Label;
        private var strEncryptParam:String;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":840,
                    "height":500,
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
                                            "text":"Select Your World",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"nametxt",
                        "stylesFactory":function ():void
                        {
                            this.left = "40";
                            this.top = "55";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "text":"Last Login Server",
                                "styleName":"funtionWindowTitle"
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "stylesFactory":function ():void
                        {
                            this.top = "80";
                            this.left = "40";
                            this.right = "40";
                            this.bottom = "60";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"textBackground",
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Tile,
                                    "id":"serverListUi",
                                    "stylesFactory":function ():void
                                    {
                                        this.horizontalGap = 6;
                                        this.verticalGap = 19;
                                        this.top = "5";
                                        this.right = "5";
                                        this.left = "5";
                                        this.bottom = "5";
                                        this.backgroundAlpha = 0;
                                        this.borderStyle = "none";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"greyBackground"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "stylesFactory":function ():void
                        {
                            this.bottom = "20";
                            this.horizontalAlign = "center";
                            this.verticalAlign = "top";
                            this.horizontalGap = 8;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "percentWidth":100,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ServerList_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"Play Now!",
                                            "styleName":"b95"
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___ServerList_Button2_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"return",
                                            "styleName":"b95"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___ServerList_Button3_click"},
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
        private var serverList_arr:Array = new Array();
        private var serverInfo_arr:Array = new Array();
        private var _2126052102itemArray:ArrayCollection = new ArrayCollection();

        public function ServerList()
        {
            mx_internal::_document = this;
            this.width = 840;
            this.height = 500;
        }

        public static function show():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
            instance.reFresh();
        }


        [Bindable(event="propertyChange")]
        public function get nametxt():Label
        {
            return (this._1721972741nametxt);
        }

        private function EncryptParam(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:int;
            strEncryptParam = "";
            while (_local_3 < _arg_1.length)
            {
                _local_2 = _arg_1.charCodeAt(_local_3);
                strEncryptParam = (strEncryptParam + _local_2.toString(16));
                _local_3++;
            };
        }

        private function loadError():void
        {
        }

        public function ___ServerList_Button2_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        public function ___ServerList_Button3_click(_arg_1:MouseEvent):void
        {
            onClose();
        }

        private function set itemArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2126052102itemArray;
            if (_local_2 !== _arg_1)
            {
                this._2126052102itemArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArray", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get itemArray():ArrayCollection
        {
            return (this._2126052102itemArray);
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function set nametxt(_arg_1:Label):void
        {
            var _local_2:Object = this._1721972741nametxt;
            if (_local_2 !== _arg_1)
            {
                this._1721972741nametxt = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "nametxt", _local_2, _arg_1));
            };
        }

        private function Play():void
        {
            if (((Context.getInstance().selectServerId == null) || (Context.getInstance().selectServerId == "")))
            {
                return;
            };
            var _local_1:* = "";
            if (ExternalInterface.available)
            {
                _local_1 = ExternalInterface.call("getPageUrl");
            };
            if (_local_1 == null)
            {
                _local_1 = ("" + BrowserManager.getInstance().url);
            };
            var _local_2:int = _local_1.indexOf(".");
            _local_1 = _local_1.substring(_local_2);
            _local_1 = (("http://" + Context.getInstance().selectServerId) + _local_1);
            navigateToURL(new URLRequest(_local_1), "_parent");
        }

        public function ___ServerList_Button1_click(_arg_1:MouseEvent):void
        {
            Play();
        }

        private function onClose():void
        {
            MinePopupManager.instance.removePopup();
        }

        private function loadOk(_arg_1:Object):void
        {
            var _local_3:int;
            var _local_4:ServerItem;
            trace(_arg_1.toString());
            var _local_2:String = _arg_1.toString();
            if ((((_arg_1.toString() == "IFULS::E01") || (_arg_1.toString() == "IFULS::E02")) || (_arg_1.toString() == "IFULS::E03")))
            {
                _local_2 = "";
            };
            serverList_arr = _local_2.split("\r\n");
            if (serverList_arr.length > 0)
            {
                serverListUi.removeAllChildren();
                _local_3 = 0;
                while (_local_3 < (serverList_arr.length - 1))
                {
                    serverInfo_arr = serverList_arr[_local_3].split(",");
                    itemArray.addItem({
                        "name":serverInfo_arr[0],
                        "serverid":serverInfo_arr[1],
                        "time":serverInfo_arr[2],
                        "state":serverInfo_arr[3]
                    });
                    _local_4 = new ServerItem();
                    _local_4.ServerName = serverInfo_arr[0];
                    _local_4.ServerId = serverInfo_arr[1];
                    _local_4.Time = serverInfo_arr[2];
                    serverListUi.addChild(_local_4);
                    _local_3++;
                };
            };
        }

        public function set serverListUi(_arg_1:Tile):void
        {
            var _local_2:Object = this._1699899637serverListUi;
            if (_local_2 !== _arg_1)
            {
                this._1699899637serverListUi = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "serverListUi", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get serverListUi():Tile
        {
            return (this._1699899637serverListUi);
        }

        private function reFresh():void
        {
            var _local_1:String = MD5.hash((Context.getInstance().userName + "TAO_{313-894*&*($*#-FDIU(430}_SL"));
            if (Context.getInstance().facebookUser)
            {
                UIUtil.loadFile(((("http://pay.evony.com/index.do?PageModule=InterfaceGetUserLoginServer&T=CLIENT&Fbuid=" + Context.getInstance().userName) + "&mk=") + _local_1), loadOk, loadError);
            }
            else
            {
                UIUtil.loadFile(((("http://pay.evony.com/index.do?PageModule=InterfaceGetUserLoginServer&T=CLIENT&UserName=" + Context.getInstance().userName) + "&mk=") + _local_1), loadOk, loadError);
            };
        }


    }
}//package view

