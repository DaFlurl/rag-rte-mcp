// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.AddFavoriteWin

package view.ui
{
    import mx.containers.Canvas;
    import mx.controls.Button;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.containers.HBox;
    import mx.controls.Label;
    import mx.controls.Text;
    import flash.net.SharedObject;
    import mx.core.mx_internal;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.managers.PopUpManager;
    import mx.events.PropertyChangeEvent;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import com.evony.Context;
    import com.evony.common.beans.PlayerInfoBean;
    import flash.events.MouseEvent;
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

    public class AddFavoriteWin extends Canvas 
    {

        public static var instance:AddFavoriteWin = new (AddFavoriteWin)();
        private static const FUNCTION_REFRESH:String = ((("document.insertScript = function ()" + "{ ") + "window.location.reload();") + "}");

        private var _708816317NoSubmitBtn:Button;
        private var _1271618531YesSubmitBtn:Button;
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
                            this.top = "4";
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
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "30";
                                        this.left = "30";
                                        this.right = "30";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"ParamgraphText1",
                                            "text":"Please access www.evony.com to continue your game next time, or you can add this page to your bookmark list by clicking yes.",
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
                                "label":"YES",
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
                                "label":"NO",
                                "styleName":"b75",
                                "width":75,
                                "height":25
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___AddFavoriteWin_Button3_click"},
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
        private var addFavoriteSo:SharedObject = SharedObject.getLocal("addFavorite");

        public function AddFavoriteWin()
        {
            mx_internal::_document = this;
            this.width = 440;
            this.height = 250;
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

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
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
        public function get NoSubmitBtn():Button
        {
            return (this._708816317NoSubmitBtn);
        }

        private function btnHandle():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call("addFavorite", "Evony game", GameConfig.instance.homePage);
            };
            var _local_1:PlayerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            addFavoriteSo.data.accountName = _local_1.accountName;
            addFavoriteSo.data.isFavorite = true;
            PopUpManager.removePopUp(instance);
            refreshPage();
        }

        public function __YesSubmitBtn_click(_arg_1:MouseEvent):void
        {
            btnHandle();
        }

        public function ___AddFavoriteWin_Button3_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function refreshPage():void
        {
            if (ExternalInterface.available)
            {
                ExternalInterface.call(FUNCTION_REFRESH);
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
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

        public function __NoSubmitBtn_click(_arg_1:MouseEvent):void
        {
            close();
        }

        [Bindable(event="propertyChange")]
        public function get YesSubmitBtn():Button
        {
            return (this._1271618531YesSubmitBtn);
        }


    }
}//package view.ui

