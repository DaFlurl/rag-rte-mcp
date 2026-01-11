// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ui.FacebookToolBar

package view.ui
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import flash.system.LoaderContext;
    import mx.binding.IWatcherSetupUtil;
    import flash.events.EventDispatcher;
    import mx.controls.Image;
    import mx.controls.Button;
    import mx.effects.Move;
    import mx.controls.List;
    import mx.core.UIComponentDescriptor;
    import mx.collections.ArrayCollection;
    import mx.core.mx_internal;
    import flash.events.IEventDispatcher;
    import mx.events.PropertyChangeEvent;
    import com.evony.Context;
    import view.castle.TownView;
    import com.evony.util.UIUtil;
    import com.evony.GameConfig;
    import flash.utils.setTimeout;
    import flash.events.MouseEvent;
    import mx.core.ClassFactory;
    import com.evony.common.beans.GetHelpedPlayerBean;
    import com.evony.common.module.CommandResponse;
    import com.evony.common.module.visit.GetHelpedPlayersResponse;
    import mx.managers.PopUpManager;
    import flash.events.Event;
    import mx.binding.Binding;
    import flash.external.ExternalInterface;
    import com.evony.client.action.ActionFactory;
    import mx.events.EffectEvent;
    import mx.events.FlexEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import flash.utils.getDefinitionByName;
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

    public class FacebookToolBar extends Canvas implements IBindingClient 
    {

        private static var _3317161ldrc:LoaderContext = new LoaderContext(false);
        private static var _watcherSetupUtil:IWatcherSetupUtil;
        private static var _staticBindingEventDispatcher:EventDispatcher = new EventDispatcher();

        private var _1185107047imgBtn:Image;
        public var lastupdatetime:String = "0";
        private var curTooltips:BaseTooltip;
        private var pageSize:int = 3;
        private var _1268093100btnSendGift:Button;
        private var _1053691327moveOther:Move;
        public var bShow:Boolean = true;
        private var _1482715966panelList:Canvas;
        private var _1406478259friendslist:List;
        private var _1057992967moveTitle:Move;
        private var _1125923055curPage:int = 1;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({"childDescriptors":[new UIComponentDescriptor({
                        "type":Image,
                        "id":"imgBtn",
                        "events":{"click":"__imgBtn_click"},
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"images/facebook2_up.png",
                                "doubleClickEnabled":false,
                                "visible":true,
                                "x":0,
                                "toolTip":"You can invite your friends to play Evony with you and send them free gifts and more."
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "id":"panelList",
                        "stylesFactory":function ():void
                        {
                            this.top = "0";
                            this.bottom = "35";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"friendsbg",
                                "width":120,
                                "x":24,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button1_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "5";
                                        this.left = "6";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"friendsbutfirst"});
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button2_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "22";
                                        this.left = "6";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"friendsbutprve",
                                            "width":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button3_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "22";
                                        this.left = "31";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"friendsbutup",
                                            "width":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":List,
                                    "id":"friendslist",
                                    "stylesFactory":function ():void
                                    {
                                        this.top = "39";
                                        this.left = "6";
                                        this.bottom = "41";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "width":53,
                                            "rowHeight":53,
                                            "columnWidth":53,
                                            "columnCount":1,
                                            "rowCount":4,
                                            "styleName":"friendslist",
                                            "verticalScrollPolicy":"off",
                                            "alpha":1,
                                            "itemRenderer":_FacebookToolBar_ClassFactory1_c()
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button4_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "24";
                                        this.left = "31";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"friendsbutdown",
                                            "width":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button5_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "24";
                                        this.left = "6";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"friendsbutnext",
                                            "width":25
                                        });
                                    }
                                }), new UIComponentDescriptor({
                                    "type":Button,
                                    "events":{"click":"___FacebookToolBar_Button6_click"},
                                    "stylesFactory":function ():void
                                    {
                                        this.bottom = "7";
                                        this.left = "6";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({"styleName":"friendsbutlast"});
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Button,
                        "id":"btnSendGift",
                        "events":{"click":"__btnSendGift_click"},
                        "stylesFactory":function ():void
                        {
                            this.bottom = "0";
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"gift",
                                "x":25,
                                "toolTip":"Send Free gifts to your friends!"
                            });
                        }
                    })]});
            }
        });
        private var fbBarTooltip:FbBarTooltip = new FbBarTooltip();
        private var neighborList_arr:Array = new Array();
        private var neighborInfo_arr:Array = new Array();
        private var _2126052102itemArray:ArrayCollection = new ArrayCollection();
        private var neighbor_1_1:Class = FacebookToolBar_neighbor_1_1;
        private var neighbor_1_2:Class = FacebookToolBar_neighbor_1_2;
        private var neighbor_1_3:Class = FacebookToolBar_neighbor_1_3;
        private var neighbor_2_1:Class = FacebookToolBar_neighbor_2_1;
        private var neighbor_2_2:Class = FacebookToolBar_neighbor_2_2;
        private var neighbor_2_3:Class = FacebookToolBar_neighbor_2_3;
        private var neighbor_3_1:Class = FacebookToolBar_neighbor_3_1;
        private var neighbor_3_2:Class = FacebookToolBar_neighbor_3_2;
        private var neighbor_3_3:Class = FacebookToolBar_neighbor_3_3;
        private var neighbor_4_1:Class = FacebookToolBar_neighbor_4_1;
        private var neighbor_4_2:Class = FacebookToolBar_neighbor_4_2;
        private var neighbor_4_3:Class = FacebookToolBar_neighbor_4_3;
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function FacebookToolBar()
        {
            mx_internal::_document = this;
            this.maxHeight = 300;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            _FacebookToolBar_Move1_i();
            _FacebookToolBar_Move2_i();
            this.addEventListener("creationComplete", ___FacebookToolBar_Canvas1_creationComplete);
            this.addEventListener("initialize", ___FacebookToolBar_Canvas1_initialize);
        }

        public static function set ldrc(_arg_1:LoaderContext):void
        {
            var _local_3:IEventDispatcher;
            var _local_2:Object = FacebookToolBar._3317161ldrc;
            if (_local_2 !== _arg_1)
            {
                FacebookToolBar._3317161ldrc = _arg_1;
                _local_3 = FacebookToolBar.staticEventDispatcher;
                if (_local_3 != null)
                {
                    _local_3.dispatchEvent(PropertyChangeEvent.createUpdateEvent(FacebookToolBar, "ldrc", _local_2, _arg_1));
                };
            };
        }

        public static function get staticEventDispatcher():IEventDispatcher
        {
            return (_staticBindingEventDispatcher);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            FacebookToolBar._watcherSetupUtil = _arg_1;
        }

        [Bindable(event="propertyChange")]
        public static function get ldrc():LoaderContext
        {
            return (FacebookToolBar._3317161ldrc);
        }


        [Bindable(event="propertyChange")]
        public function get itemArray():ArrayCollection
        {
            return (this._2126052102itemArray);
        }

        [Bindable(event="propertyChange")]
        public function get moveTitle():Move
        {
            return (this._1057992967moveTitle);
        }

        private function delayLoad():void
        {
            if (Context.getInstance().facebookUser)
            {
                if (((!(TownView.instance == null)) && (TownView.instance.isNormalScene)))
                {
                    UIUtil.loadFile(((((GameConfig.instance.NeighborListUrl + "?fbuid=") + Context.getInstance().userName) + "&update=") + lastupdatetime), loadOk, loadError);
                    setTimeout(delayLoad, 180000);
                }
                else
                {
                    setTimeout(delayLoad, 1000);
                };
            };
        }

        public function set itemArray(_arg_1:ArrayCollection):void
        {
            var _local_2:Object = this._2126052102itemArray;
            if (_local_2 !== _arg_1)
            {
                this._2126052102itemArray = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemArray", _local_2, _arg_1));
            };
        }

        public function set moveTitle(_arg_1:Move):void
        {
            var _local_2:Object = this._1057992967moveTitle;
            if (_local_2 !== _arg_1)
            {
                this._1057992967moveTitle = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "moveTitle", _local_2, _arg_1));
            };
        }

        private function friendsListPosition(_arg_1:String):void
        {
            if (_arg_1 == "up")
            {
                if (friendslist.verticalScrollPosition > 0)
                {
                    friendslist.verticalScrollPosition--;
                };
            }
            else
            {
                if (_arg_1 == "down")
                {
                    if (friendslist.verticalScrollPosition < neighborList_arr.length)
                    {
                        friendslist.verticalScrollPosition++;
                    };
                };
            };
        }

        public function ___FacebookToolBar_Button1_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("up");
        }

        private function _FacebookToolBar_ClassFactory1_c():ClassFactory
        {
            var _local_1:ClassFactory = new ClassFactory();
            _local_1.generator = FacebookToolBar_inlineComponent1;
            _local_1.properties = {"outerDocument":this};
            return (_local_1);
        }

        private function _FacebookToolBar_Move2_i():Move
        {
            var _local_1:Move = new Move();
            moveTitle = _local_1;
            _local_1.addEventListener("effectEnd", __moveTitle_effectEnd);
            return (_local_1);
        }

        public function ___FacebookToolBar_Button5_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("down");
        }

        private function init():void
        {
            this.visible = false;
            delayLoad();
        }

        private function onResponse(_arg_1:GetHelpedPlayersResponse):void
        {
            var _local_2:GetHelpedPlayerBean;
            var _local_3:int;
            var _local_4:int;
            this.visible = true;
            if (_arg_1.ok == CommandResponse.OK_DEFAULT)
            {
                _local_3 = 0;
                while (_local_3 < _arg_1.playersArray.length)
                {
                    _local_2 = (_arg_1.playersArray[_local_3] as GetHelpedPlayerBean);
                    _local_4 = 0;
                    while (_local_4 < itemArray.length)
                    {
                        if (itemArray[_local_4].fbid == _local_2.playerFBID)
                        {
                            itemArray[_local_4].count = 1;
                            break;
                        };
                        _local_4++;
                    };
                    _local_3++;
                };
            };
        }

        public function set imgBtn(_arg_1:Image):void
        {
            var _local_2:Object = this._1185107047imgBtn;
            if (_local_2 !== _arg_1)
            {
                this._1185107047imgBtn = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "imgBtn", _local_2, _arg_1));
            };
        }

        public function __imgBtn_click(_arg_1:MouseEvent):void
        {
            onTitleClick(_arg_1);
        }

        private function hideFbImg():void
        {
            if (imgBtn.visible)
            {
                imgBtn.visible = false;
            };
        }

        private function showTooltip(_arg_1:MouseEvent, _arg_2:BaseTooltip):void
        {
            this.curTooltips = _arg_2;
            this.curTooltips.moveToMouse(_arg_1);
            this.curTooltips.refresh();
            if (!curTooltips.isPopUp)
            {
                PopUpManager.addPopUp(this.curTooltips, this);
            };
        }

        private function onTitleClick(_arg_1:Event):void
        {
            moveOther.xFrom = panelList.x;
            moveTitle.xFrom = imgBtn.x;
            if (bShow)
            {
                moveOther.xTo = (panelList.x + 60);
                moveTitle.xTo = (imgBtn.x + 60);
            }
            else
            {
                moveOther.xTo = (panelList.x - 60);
                moveTitle.xTo = (imgBtn.x - 60);
            };
            moveOther.end();
            moveTitle.end();
            moveOther.play([panelList, btnSendGift]);
            moveTitle.play([imgBtn]);
            bShow = (!(bShow));
        }

        private function preInit():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get btnSendGift():Button
        {
            return (this._1268093100btnSendGift);
        }

        public function ___FacebookToolBar_Button2_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("up");
        }

        private function _FacebookToolBar_Move1_i():Move
        {
            var _local_1:Move = new Move();
            moveOther = _local_1;
            return (_local_1);
        }

        public function ___FacebookToolBar_Button6_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("down");
        }

        private function _FacebookToolBar_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (itemArray);
            }, function (_arg_1:Object):void
            {
                friendslist.dataProvider = _arg_1;
            }, "friendslist.dataProvider");
            result[0] = binding;
            return (result);
        }

        public function hideTooltip():void
        {
            if (this.curTooltips != null)
            {
                PopUpManager.removePopUp(this.curTooltips);
            };
        }

        private function loadOk(_arg_1:Object):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_2:String = _arg_1.toString();
            if (_arg_1.toString() == "E03")
            {
                return;
            };
            if (((_arg_1.toString() == "E01") || (_arg_1.toString() == "E02")))
            {
                _local_2 = "";
            };
            neighborList_arr = _local_2.split(";");
            itemArray.removeAll();
            if (neighborList_arr.length > 0)
            {
                lastupdatetime = neighborList_arr[0];
                _local_4 = 1;
                while (_local_4 < (neighborList_arr.length - 1))
                {
                    neighborInfo_arr = neighborList_arr[_local_4].split(",");
                    if (neighborInfo_arr[1] == "")
                    {
                        neighborInfo_arr[1] = "http://www.evony.com/Dhtml/images/facebook/q_silhouette.gif";
                        if (ExternalInterface.available)
                        {
                            ExternalInterface.call("facebook.fb_flashGetNeighborInfo", neighborInfo_arr[0]);
                        };
                    };
                    itemArray.addItem({
                        "fbid":neighborInfo_arr[0],
                        "image":neighborInfo_arr[1],
                        "name":neighborInfo_arr[2],
                        "title":neighborInfo_arr[3],
                        "prestige":neighborInfo_arr[4],
                        "server":neighborInfo_arr[5],
                        "count":neighborInfo_arr[6],
                        "state":neighborInfo_arr[7]
                    });
                    _local_4++;
                };
            };
            var _local_3:int = itemArray.length;
            if (_local_3 < 14)
            {
                _local_6 = 0;
                while (_local_6 < (14 - _local_3))
                {
                    (_local_5 == (Math.random() * 14));
                    _local_5 = ((_local_5 % 4) + 1);
                    itemArray.addItem({
                        "fbid":0,
                        "image":(("images/neighbor/" + _local_5) + "_1.jpg"),
                        "name":"",
                        "title":"",
                        "prestige":"",
                        "server":"",
                        "count":"",
                        "state":""
                    });
                    _local_6++;
                };
            }
            else
            {
                _local_6 = 0;
                while (_local_6 < 4)
                {
                    (_local_5 == (Math.random() * 14));
                    _local_5 = ((_local_5 % 4) + 1);
                    itemArray.addItem({
                        "fbid":0,
                        "image":(("images/neighbor/" + _local_5) + "_1.jpg"),
                        "name":"",
                        "title":"",
                        "prestige":"",
                        "server":"",
                        "count":"",
                        "state":""
                    });
                    _local_6++;
                };
            };
            ActionFactory.getInstance().getVisitCommands().getHelpedPlayers(onResponse);
        }

        private function showFbImg():void
        {
        }

        public function set friendslist(_arg_1:List):void
        {
            var _local_2:Object = this._1406478259friendslist;
            if (_local_2 !== _arg_1)
            {
                this._1406478259friendslist = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "friendslist", _local_2, _arg_1));
            };
        }

        public function onMouseOut(_arg_1:MouseEvent, _arg_2:Object, _arg_3:Image):void
        {
            if (_arg_2.fbid == 0)
            {
                _arg_2.image = String(_arg_2.image).replace("_3.jpg", "_1.jpg");
                _arg_2.image = String(_arg_2.image).replace("_2.jpg", "_1.jpg");
                if (String(_arg_2.image).indexOf("1_") != -1)
                {
                    _arg_3.source = neighbor_1_1;
                }
                else
                {
                    if (String(_arg_2.image).indexOf("2_") != -1)
                    {
                        _arg_3.source = neighbor_2_1;
                    }
                    else
                    {
                        if (String(_arg_2.image).indexOf("3_") != -1)
                        {
                            _arg_3.source = neighbor_3_1;
                        }
                        else
                        {
                            if (String(_arg_2.image).indexOf("4_") != -1)
                            {
                                _arg_3.source = neighbor_4_1;
                            }
                            else
                            {
                                _arg_3.source = _arg_2.image;
                            };
                        };
                    };
                };
            };
        }

        public function __moveTitle_effectEnd(_arg_1:EffectEvent):void
        {
            showFbImg();
        }

        public function ___FacebookToolBar_Canvas1_initialize(_arg_1:FlexEvent):void
        {
            preInit();
        }

        public function set panelList(_arg_1:Canvas):void
        {
            var _local_2:Object = this._1482715966panelList;
            if (_local_2 !== _arg_1)
            {
                this._1482715966panelList = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panelList", _local_2, _arg_1));
            };
        }

        public function set moveOther(_arg_1:Move):void
        {
            var _local_2:Object = this._1053691327moveOther;
            if (_local_2 !== _arg_1)
            {
                this._1053691327moveOther = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "moveOther", _local_2, _arg_1));
            };
        }

        public function setFbData(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:int;
            while (_local_4 < itemArray.length)
            {
                if (itemArray[_local_4].fbid == _arg_1)
                {
                    if (_arg_2 == "IMG")
                    {
                        itemArray[_local_4].image = _arg_3;
                    }
                    else
                    {
                        if (_arg_2 == "NICKNAME")
                        {
                            itemArray[_local_4].name = _arg_3;
                        };
                    };
                };
                _local_4++;
            };
        }

        private function AddNeighbor():void
        {
            navigateToURL(new URLRequest(((GameConfig.instance.AddNeighborUrl + "?SID=") + GameConfig.instance.serverID)), "_blank");
        }

        override public function initialize():void
        {
            var target:FacebookToolBar;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _FacebookToolBar_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_ui_FacebookToolBarWatcherSetupUtil");
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
        public function get imgBtn():Image
        {
            return (this._1185107047imgBtn);
        }

        public function ___FacebookToolBar_Button3_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("up");
        }

        public function set btnSendGift(_arg_1:Button):void
        {
            var _local_2:Object = this._1268093100btnSendGift;
            if (_local_2 !== _arg_1)
            {
                this._1268093100btnSendGift = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnSendGift", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        public function get friendslist():List
        {
            return (this._1406478259friendslist);
        }

        private function loadError():void
        {
        }

        [Bindable(event="propertyChange")]
        public function get moveOther():Move
        {
            return (this._1053691327moveOther);
        }

        public function onMouseDown(_arg_1:MouseEvent, _arg_2:Object, _arg_3:Image):void
        {
            if (_arg_2.fbid == 0)
            {
                _arg_2.image = String(_arg_2.image).replace("_1.jpg", "_2.jpg");
                _arg_2.image = String(_arg_2.image).replace("_3.jpg", "_2.jpg");
                if (String(_arg_2.image).indexOf("1_") != -1)
                {
                    _arg_3.source = neighbor_1_2;
                }
                else
                {
                    if (String(_arg_2.image).indexOf("2_") != -1)
                    {
                        _arg_3.source = neighbor_2_2;
                    }
                    else
                    {
                        if (String(_arg_2.image).indexOf("3_") != -1)
                        {
                            _arg_3.source = neighbor_3_2;
                        }
                        else
                        {
                            if (String(_arg_2.image).indexOf("4_") != -1)
                            {
                                _arg_3.source = neighbor_4_2;
                            }
                            else
                            {
                                _arg_3.source = _arg_2.image;
                            };
                        };
                    };
                };
            };
        }

        [Bindable(event="propertyChange")]
        public function get panelList():Canvas
        {
            return (this._1482715966panelList);
        }

        private function _FacebookToolBar_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = itemArray;
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

        public function ___FacebookToolBar_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        public function ___FacebookToolBar_Button4_click(_arg_1:MouseEvent):void
        {
            friendsListPosition("down");
        }

        [Bindable(event="propertyChange")]
        private function get curPage():int
        {
            return (this._1125923055curPage);
        }

        public function onClick(_arg_1:MouseEvent, _arg_2:Object):void
        {
            if (_arg_2.fbid != 0)
            {
                this.fbBarTooltip.info = _arg_2;
                showTooltip(_arg_1, this.fbBarTooltip);
            }
            else
            {
                navigateToURL(new URLRequest((((GameConfig.instance.AddNeighborUrl + "?SID=") + GameConfig.instance.serverID) + "#AddAllies")), "_blank");
            };
        }

        public function moveTooltip(_arg_1:MouseEvent):void
        {
            if (this.curTooltips != null)
            {
                this.curTooltips.moveToMouse(_arg_1);
            };
        }

        private function SendGift():void
        {
            navigateToURL(new URLRequest(((GameConfig.instance.SendGiftUrl + "?SID=") + GameConfig.instance.serverID)), "_blank");
        }

        public function MouseOver(_arg_1:Object):void
        {
            if (_arg_1.fbid != 0)
            {
            };
        }

        public function onMouseOver(_arg_1:MouseEvent, _arg_2:Object, _arg_3:Image):void
        {
            if (_arg_2.fbid == 0)
            {
                _arg_2.image = String(_arg_2.image).replace("_1.jpg", "_3.jpg");
                _arg_2.image = String(_arg_2.image).replace("_2.jpg", "_3.jpg");
                if (String(_arg_2.image).indexOf("1_") != -1)
                {
                    _arg_3.source = neighbor_1_3;
                }
                else
                {
                    if (String(_arg_2.image).indexOf("2_") != -1)
                    {
                        _arg_3.source = neighbor_2_3;
                    }
                    else
                    {
                        if (String(_arg_2.image).indexOf("3_") != -1)
                        {
                            _arg_3.source = neighbor_3_3;
                        }
                        else
                        {
                            if (String(_arg_2.image).indexOf("4_") != -1)
                            {
                                _arg_3.source = neighbor_4_3;
                            }
                            else
                            {
                                _arg_3.source = _arg_2.image;
                            };
                        };
                    };
                };
            };
        }

        public function __btnSendGift_click(_arg_1:MouseEvent):void
        {
            SendGift();
        }


    }
}//package view.ui

