// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castleList.SuzerainInfoWin

package view.castleList
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Label;
    import view.module.office.ColonizeActionBtn;
    import mx.containers.HBox;
    import com.evony.common.beans.ColonyBean;
    import com.evony.common.beans.CastleBean;
    import mx.core.UIComponentDescriptor;
    import controls.MyWindow;
    import mx.controls.Image;
    import mx.controls.Button;
    import mx.containers.VBox;
    import mx.core.mx_internal;
    import mx.managers.PopUpManager;
    import com.evony.util.UIUtil;
    import com.evony.util.MinePopupManager;
    import view.castle.MainFrame;
    import mx.events.PropertyChangeEvent;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import flash.events.MouseEvent;
    import com.evony.util.ImageSmooth;
    import mx.events.FlexEvent;
    import com.evony.common.module.CommandResponse;
    import view.ui.AlertWin;
    import com.evony.Context;
    import flash.external.ExternalInterface;
    import com.evony.data.FbData;
    import com.adobe.crypto.MD5;
    import com.evony.GameConfig;
    import com.evony.common.constants.ColonyConstants;
    import com.evony.client.action.ActionFactory;
    import view.MainWin;
    import view.AllWindows;
    import view.module.quest.QuestWin;
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

    public class SuzerainInfoWin extends Canvas implements IBindingClient 
    {

        public static var instance:SuzerainInfoWin = new (SuzerainInfoWin)();
        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1962855648lordName:Label;
        private var _1264534986isCanUprise:Boolean = true;
        public var _SuzerainInfoWin_ColonizeActionBtn1:ColonizeActionBtn;
        private var _1421682026cityName:Label;
        private var _631681575enableBtn:Boolean = true;
        private var _70341312levyBtn:HBox;
        private var _1197684682colonyBean:ColonyBean;
        private var _113836232castleBean:CastleBean;
        private var _1197902024colonyInfo:String;
        private var _94845685coord:Label;
        private var _1276224445prestige:Label;
        private var _1606140770allianceName:Label;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":450,
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
                            this.top = "6";
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
                                            "text":"Suzerain Information",
                                            "styleName":"funtionWindowTitle"
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "events":{"creationComplete":"___SuzerainInfoWin_Image1_creationComplete"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":30,
                                "y":59,
                                "source":"images/EmbedImages/field/colonizationCity.png",
                                "width":98,
                                "height":98
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":HBox,
                        "id":"levyBtn",
                        "stylesFactory":function ():void
                        {
                            this.left = "50";
                            this.right = "50";
                            this.bottom = "35";
                            this.horizontalGap = 10;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":ColonizeActionBtn,
                                    "id":"_SuzerainInfoWin_ColonizeActionBtn1",
                                    "events":{"click":"___SuzerainInfoWin_ColonizeActionBtn1_click"}
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___SuzerainInfoWin_Button1_click"},
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "label":"issue commission quest",
                                            "styleName":"y165"
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":VBox,
                        "stylesFactory":function ():void
                        {
                            this.left = "130";
                            this.top = "70";
                            this.verticalGap = 0;
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({"childDescriptors":[new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"City: ",
                                                        "styleName":"PropertyName1",
                                                        "width":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"cityName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"coord",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Lord: ",
                                                        "styleName":"PropertyName1",
                                                        "width":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"lordName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Prestige: ",
                                                        "styleName":"PropertyName1",
                                                        "width":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"prestige",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":HBox,
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalAlign = "middle";
                                        this.horizontalGap = 3;
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "percentWidth":100,
                                            "childDescriptors":[new UIComponentDescriptor({
                                                "type":Label,
                                                "stylesFactory":function ():void
                                                {
                                                    this.textAlign = "left";
                                                },
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({
                                                        "text":"Alliance: ",
                                                        "styleName":"PropertyName1",
                                                        "width":100
                                                    });
                                                }
                                            }), new UIComponentDescriptor({
                                                "type":Label,
                                                "id":"allianceName",
                                                "propertiesFactory":function ():Object
                                                {
                                                    return ({"styleName":"contentheader1"});
                                                }
                                            })]
                                        });
                                    }
                                })]});
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "events":{"click":"___SuzerainInfoWin_Button2_click"},
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
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function SuzerainInfoWin()
        {
            mx_internal::_document = this;
            this.width = 450;
            this.height = 250;
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            SuzerainInfoWin._watcherSetupUtil = _arg_1;
        }

        public static function close():void
        {
            PopUpManager.removePopUp(instance);
        }

        public static function getInstance():void
        {
            if (!instance.isPopUp)
            {
                UIUtil.setPopopHelpWindowStye(instance);
                MinePopupManager.instance.addPopup(instance, MainFrame.instance, true);
                MinePopupManager.instance.centerPopUp();
            };
        }


        public function set levyBtn(_arg_1:HBox):void
        {
            var _local_2:Object = this._70341312levyBtn;
            if (_local_2 !== _arg_1)
            {
                this._70341312levyBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levyBtn", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get colonyInfo():String
        {
            return (this._1197902024colonyInfo);
        }

        [Bindable(event="propertyChange")]
        private function get isCanUprise():Boolean
        {
            return (this._1264534986isCanUprise);
        }

        public function set prestige(_arg_1:Label):void
        {
            var _local_2:Object = this._1276224445prestige;
            if (_local_2 !== _arg_1)
            {
                this._1276224445prestige = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "prestige", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            var target:SuzerainInfoWin;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _SuzerainInfoWin_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_castleList_SuzerainInfoWinWatcherSetupUtil");
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
        public function get cityName():Label
        {
            return (this._1421682026cityName);
        }

        public function ___SuzerainInfoWin_Button2_click(_arg_1:MouseEvent):void
        {
            close();
        }

        private function _SuzerainInfoWin_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Boolean
            {
                return (this.enableBtn);
            }, function (_arg_1:Boolean):void
            {
                _SuzerainInfoWin_ColonizeActionBtn1.enabled = _arg_1;
            }, "_SuzerainInfoWin_ColonizeActionBtn1.enabled");
            result[0] = binding;
            binding = new Binding(this, function ():Object
            {
                return (this.colonyBean);
            }, function (_arg_1:Object):void
            {
                _SuzerainInfoWin_ColonizeActionBtn1.action = _arg_1;
            }, "_SuzerainInfoWin_ColonizeActionBtn1.action");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.cityName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                cityName.text = _arg_1;
            }, "cityName.text");
            result[2] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = (("(" + this.colonyBean.position) + ")");
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                coord.text = _arg_1;
            }, "coord.text");
            result[3] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.lordName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                lordName.text = _arg_1;
            }, "lordName.text");
            result[4] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.prestige;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                prestige.text = _arg_1;
            }, "prestige.text");
            result[5] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = this.colonyBean.allianceName;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                allianceName.text = _arg_1;
            }, "allianceName.text");
            result[6] = binding;
            return (result);
        }

        private function init():void
        {
        }

        private function set colonyBean(_arg_1:ColonyBean):void
        {
            var _local_2:Object = this._1197684682colonyBean;
            if (_local_2 !== _arg_1)
            {
                this._1197684682colonyBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyBean", _local_2, _arg_1));
            };
        }

        private function set castleBean(_arg_1:CastleBean):void
        {
            var _local_2:Object = this._113836232castleBean;
            if (_local_2 !== _arg_1)
            {
                this._113836232castleBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "castleBean", _local_2, _arg_1));
            };
        }

        private function _SuzerainInfoWin_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.enableBtn;
            _local_1 = this.colonyBean;
            _local_1 = this.colonyBean.cityName;
            _local_1 = (("(" + this.colonyBean.position) + ")");
            _local_1 = this.colonyBean.lordName;
            _local_1 = this.colonyBean.prestige;
            _local_1 = this.colonyBean.allianceName;
        }

        [Bindable(event="propertyChange")]
        public function get lordName():Label
        {
            return (this._1962855648lordName);
        }

        public function ___SuzerainInfoWin_Image1_creationComplete(_arg_1:FlexEvent):void
        {
            ImageSmooth.onCreationComplete(_arg_1);
        }

        private function set enableBtn(_arg_1:Boolean):void
        {
            var _local_2:Object = this._631681575enableBtn;
            if (_local_2 !== _arg_1)
            {
                this._631681575enableBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enableBtn", _local_2, _arg_1));
            };
        }

        public function set cityName(_arg_1:Label):void
        {
            var _local_2:Object = this._1421682026cityName;
            if (_local_2 !== _arg_1)
            {
                this._1421682026cityName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityName", _local_2, _arg_1));
            };
        }

        private function set colonyInfo(_arg_1:String):void
        {
            var _local_2:Object = this._1197902024colonyInfo;
            if (_local_2 !== _arg_1)
            {
                this._1197902024colonyInfo = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colonyInfo", _local_2, _arg_1));
            };
        }

        private function set isCanUprise(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1264534986isCanUprise;
            if (_local_2 !== _arg_1)
            {
                this._1264534986isCanUprise = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isCanUprise", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get prestige():Label
        {
            return (this._1276224445prestige);
        }

        public function set allianceName(_arg_1:Label):void
        {
            var _local_2:Object = this._1606140770allianceName;
            if (_local_2 !== _arg_1)
            {
                this._1606140770allianceName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "allianceName", _local_2, _arg_1));
            };
        }

        private function upriseResponse(_arg_1:CommandResponse):void
        {
            var _local_2:String;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            var _local_9:String;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                this.isCanUprise = false;
                AlertWin.show("Uprise started!  Your city's army fight your suzerain’s suppression army in 30 minutes. Prepare yourself!");
                if (Context.getInstance().facebookUser)
                {
                    _local_2 = "";
                    if (ExternalInterface.available)
                    {
                        _local_2 = ExternalInterface.call("facebook.fb_getUserName");
                    };
                    _local_3 = FbData.getInstance().getValue(10001);
                    _local_4 = (_local_2 + " is preparing for an Uprising in Evony!");
                    _local_5 = (("Your friend " + _local_2) + " needs your help in overthrowing his occupier Lord. Help him bring freedom to his people by aiding in the uprising battle.");
                    _local_6 = (((((('{"name":"' + _local_4) + '","href":"http://www.evony.com/","description":"') + _local_5) + '","media":[{"type":"image","src":"') + _local_3.img) + '"}]}');
                    _local_7 = Context.getInstance().GetGuidStr();
                    _local_8 = MD5.hash((((((Context.getInstance().userName + Context.getInstance().getCurCastle().id) + GameConfig.instance.serverID) + Context.getInstance().getPlayerBean().currentDateTime) + Context.getInstance().getPlayerBean().playerInfo.sex) + "TAO_{313-894*&*($*#-FDIU(430}-{facebook_dioe(&*%$l}"));
                    _local_9 = (((((((((((((((("{'text':'Help him out!', 'href':'" + GameConfig.instance.FbUprisingUrl) + "?F=") + Context.getInstance().userName) + "&C=") + Context.getInstance().getCurCastle().id) + "&SID=") + GameConfig.instance.serverID) + "&T=") + Context.getInstance().getPlayerBean().currentDateTime) + "&SX=") + Context.getInstance().getPlayerBean().playerInfo.sex) + "&FEEDID=10001&GUID=") + _local_7) + "&k=") + _local_8) + "'}");
                    Context.getInstance().fbPublish(_local_6, _local_9, GameConfig.instance.serverID, "10001", _local_7);
                };
            }
            else
            {
                AlertWin.show(_arg_1.errorMsg);
            };
        }

        [Bindable(event="propertyChange")]
        public function get levyBtn():HBox
        {
            return (this._70341312levyBtn);
        }

        public function set lordName(_arg_1:Label):void
        {
            var _local_2:Object = this._1962855648lordName;
            if (_local_2 !== _arg_1)
            {
                this._1962855648lordName = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "lordName", _local_2, _arg_1));
            };
        }

        public function ___SuzerainInfoWin_Button1_click(_arg_1:MouseEvent):void
        {
            onQuestBtnClick();
        }

        public function setCastleBean(_arg_1:ColonyBean, _arg_2:CastleBean):void
        {
            this.colonyBean = _arg_1;
            this.castleBean = _arg_2;
            if (this.colonyBean.status != ColonyConstants.COLONY_STATUS_OCCUPIED)
            {
                this.enableBtn = false;
            };
        }

        [Bindable(event="propertyChange")]
        private function get castleBean():CastleBean
        {
            return (this._113836232castleBean);
        }

        [Bindable(event="propertyChange")]
        public function get allianceName():Label
        {
            return (this._1606140770allianceName);
        }

        private function uprise():void
        {
            this.enableBtn = false;
            ActionFactory.getInstance().getColonyCommands().uprise(Context.getInstance().getCurCastle().id, upriseResponse);
        }

        [Bindable(event="propertyChange")]
        private function get enableBtn():Boolean
        {
            return (this._631681575enableBtn);
        }

        public function set coord(_arg_1:Label):void
        {
            var _local_2:Object = this._94845685coord;
            if (_local_2 !== _arg_1)
            {
                this._94845685coord = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "coord", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get coord():Label
        {
            return (this._94845685coord);
        }

        [Bindable(event="propertyChange")]
        private function get colonyBean():ColonyBean
        {
            return (this._1197684682colonyBean);
        }

        public function ___SuzerainInfoWin_ColonizeActionBtn1_click(_arg_1:MouseEvent):void
        {
            uprise();
        }

        private function onQuestBtnClick():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            MainWin.instance.issueQuestPos = this.castleBean.fieldId;
            AllWindows.switchToFuncWindow(QuestWin.EVENT_SHOW);
        }


    }
}//package view.castleList

