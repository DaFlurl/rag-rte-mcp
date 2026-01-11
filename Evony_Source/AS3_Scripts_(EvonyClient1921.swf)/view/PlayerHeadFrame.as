// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.PlayerHeadFrame

package view
{
    import mx.containers.Canvas;
    import mx.binding.IBindingClient;
    import mx.binding.IWatcherSetupUtil;
    import mx.controls.Image;
    import mx.controls.Label;
    import com.evony.common.beans.PlayerInfoBean;
    import mx.effects.Parallel;
    import mx.effects.Glow;
    import mx.core.UIComponentDescriptor;
    import com.evony.util.EvonyImage;
    import view.ui.ServerTimeTooltip;
    import mx.core.mx_internal;
    import flash.events.MouseEvent;
    import com.evony.Context;
    import view.module.playerInfo.PlayerInfoWin;
    import mx.events.PropertyChangeEvent;
    import com.evony.MsgDispacther;
    import flash.external.ExternalInterface;
    import flash.filters.GlowFilter;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
    import mx.binding.Binding;
    import view.module.friendList.FriendList;
    import mx.managers.PopUpManager;
    import com.evony.util.ImageSmooth;
    import view.module.playerInfo.MyTreasure;
    import com.evony.GameConfig;
    import com.evony.util.UIUtil;
    import mx.core.IToolTip;
    import mx.managers.ToolTipManager;
    import mx.core.Application;
    import mx.events.ToolTipEvent;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import view.module.office.Office;
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

    public class PlayerHeadFrame extends Canvas implements IBindingClient 
    {

        private static var _watcherSetupUtil:IWatcherSetupUtil;

        private var _1494871014myPhoto:Image;
        private var _116118ust:Label;
        private var _815231871playerInfoBean:PlayerInfoBean;
        public var _PlayerHeadFrame_Label1:Label;
        private var _1963141581myOutEffect:Parallel;
        private var _1777414718glowImageOver:Glow;
        private var _1858451296glowImageOut:Glow;
        private var _1725544017myOverEffect:Parallel;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({
            "type":Canvas,
            "propertiesFactory":function ():Object
            {
                return ({
                    "width":302,
                    "height":741,
                    "childDescriptors":[new UIComponentDescriptor({
                        "type":EvonyImage,
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/dynamic/ui234.swf@head.png",
                                "x":0,
                                "y":0
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Image,
                        "id":"myPhoto",
                        "events":{
                            "complete":"__myPhoto_complete",
                            "click":"__myPhoto_click",
                            "mouseOut":"__myPhoto_mouseOut",
                            "mouseOver":"__myPhoto_mouseOver"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "x":39,
                                "y":13,
                                "width":100,
                                "height":100
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":EvonyImage,
                        "events":{
                            "click":"___PlayerHeadFrame_EvonyImage2_click",
                            "mouseOut":"___PlayerHeadFrame_EvonyImage2_mouseOut",
                            "mouseOver":"___PlayerHeadFrame_EvonyImage2_mouseOver"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "source":"fla/dynamic/ui234.swf@face_Reflective.png",
                                "x":37,
                                "y":13
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Canvas,
                        "events":{"click":"___PlayerHeadFrame_Canvas2_click"},
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"tcs",
                                "x":205,
                                "y":131,
                                "width":85,
                                "height":30,
                                "childDescriptors":[new UIComponentDescriptor({
                                    "type":Label,
                                    "id":"_PlayerHeadFrame_Label1",
                                    "events":{
                                        "mouseOut":"___PlayerHeadFrame_Label1_mouseOut",
                                        "mouseMove":"___PlayerHeadFrame_Label1_mouseMove",
                                        "mouseOver":"___PlayerHeadFrame_Label1_mouseOver"
                                    },
                                    "stylesFactory":function ():void
                                    {
                                        this.verticalCenter = "0";
                                        this.horizontalCenter = "0";
                                    },
                                    "propertiesFactory":function ():Object
                                    {
                                        return ({
                                            "styleName":"tcs",
                                            "filters":[_PlayerHeadFrame_GlowFilter1_c()]
                                        });
                                    }
                                })]
                            });
                        }
                    }), new UIComponentDescriptor({
                        "type":Label,
                        "id":"ust",
                        "events":{
                            "mouseOut":"__ust_mouseOut",
                            "mouseMove":"__ust_mouseMove",
                            "mouseOver":"__ust_mouseOver"
                        },
                        "propertiesFactory":function ():Object
                        {
                            return ({
                                "styleName":"ust",
                                "x":205,
                                "y":100,
                                "filters":[_PlayerHeadFrame_GlowFilter2_c()]
                            });
                        }
                    })]
                });
            }
        });
        private var serverTimeTooltip:ServerTimeTooltip = new ServerTimeTooltip();
        mx_internal var _bindings:Array = [];
        mx_internal var _watchers:Array = [];
        mx_internal var _bindingsByDestination:Object = {};
        mx_internal var _bindingsBeginWithWord:Object = {};

        public function PlayerHeadFrame()
        {
            mx_internal::_document = this;
            this.width = 302;
            this.height = 741;
            this.verticalScrollPolicy = "off";
            this.horizontalScrollPolicy = "off";
            _PlayerHeadFrame_Parallel2_i();
            _PlayerHeadFrame_Parallel1_i();
            this.addEventListener("creationComplete", ___PlayerHeadFrame_Canvas1_creationComplete);
        }

        public static function set watcherSetupUtil(_arg_1:IWatcherSetupUtil):void
        {
            PlayerHeadFrame._watcherSetupUtil = _arg_1;
        }


        public function __myPhoto_mouseOut(_arg_1:MouseEvent):void
        {
            mouseOutEffect();
        }

        private function openPlayerInfoWin():void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            AllWindows.switchToFuncWindow(PlayerInfoWin.EVENT_SHOW);
        }

        public function set glowImageOver(_arg_1:Glow):void
        {
            var _local_2:Object = this._1777414718glowImageOver;
            if (_local_2 !== _arg_1)
            {
                this._1777414718glowImageOver = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glowImageOver", _local_2, _arg_1));
            };
        }

        private function set playerInfoBean(_arg_1:PlayerInfoBean):void
        {
            var _local_2:Object = this._815231871playerInfoBean;
            if (_local_2 !== _arg_1)
            {
                this._815231871playerInfoBean = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "playerInfoBean", _local_2, _arg_1));
            };
        }

        [Bindable(event="propertyChange")]
        private function get playerInfoBean():PlayerInfoBean
        {
            return (this._815231871playerInfoBean);
        }

        private function mouseOverEffect():void
        {
            this.myOverEffect.play([this.myPhoto]);
        }

        public function __myPhoto_click(_arg_1:MouseEvent):void
        {
            openPlayerInfoWin();
        }

        private function init():void
        {
            playerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
            MsgDispacther.getInstance().addEventListener(Context.EVENT_PLAYER_LOGIN, onPlayerLogin);
            var _local_1:String = Context.getInstance().getPlayerBean().headline;
            if (((ExternalInterface.available) && (!(_local_1 == null))))
            {
                ExternalInterface.call("SetIeTitle", _local_1);
            };
        }

        public function ___PlayerHeadFrame_Canvas2_click(_arg_1:MouseEvent):void
        {
            showServerList();
        }

        private function _PlayerHeadFrame_Parallel2_i():Parallel
        {
            var _local_1:Parallel = new Parallel();
            myOutEffect = _local_1;
            _local_1.children = [_PlayerHeadFrame_Glow2_i()];
            return (_local_1);
        }

        public function ___PlayerHeadFrame_EvonyImage2_mouseOut(_arg_1:MouseEvent):void
        {
            mouseOutEffect();
        }

        [Bindable(event="propertyChange")]
        public function get ust():Label
        {
            return (this._116118ust);
        }

        private function _PlayerHeadFrame_GlowFilter1_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1839886;
            _local_1.strength = 2;
            _local_1.quality = 1;
            return (_local_1);
        }

        public function __myPhoto_mouseOver(_arg_1:MouseEvent):void
        {
            mouseOverEffect();
        }

        public function set myOverEffect(_arg_1:Parallel):void
        {
            var _local_2:Object = this._1725544017myOverEffect;
            if (_local_2 !== _arg_1)
            {
                this._1725544017myOverEffect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myOverEffect", _local_2, _arg_1));
            };
        }

        public function ___PlayerHeadFrame_Label1_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get glowImageOut():Glow
        {
            return (this._1858451296glowImageOut);
        }

        private function onPlayerLogin(_arg_1:Event):void
        {
            playerInfoBean = Context.getInstance().getPlayerBean().playerInfo;
        }

        public function ___PlayerHeadFrame_Label1_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1);
        }

        override public function initialize():void
        {
            var target:PlayerHeadFrame;
            var watcherSetupUtilClass:Object;
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            var bindings:Array = _PlayerHeadFrame_bindingsSetup();
            var watchers:Array = [];
            target = this;
            if (_watcherSetupUtil == null)
            {
                watcherSetupUtilClass = getDefinitionByName("_view_PlayerHeadFrameWatcherSetupUtil");
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

        public function ___PlayerHeadFrame_EvonyImage2_mouseOver(_arg_1:MouseEvent):void
        {
            mouseOverEffect();
        }

        private function showFriendList():void
        {
            AllWindows.switchToFuncWindow(FriendList.EVENT_SHOW);
        }

        public function set ust(_arg_1:Label):void
        {
            var _local_2:Object = this._116118ust;
            if (_local_2 !== _arg_1)
            {
                this._116118ust = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ust", _local_2, _arg_1));
            };
        }

        private function _PlayerHeadFrame_Glow2_i():Glow
        {
            var _local_1:Glow = new Glow();
            glowImageOut = _local_1;
            _local_1.duration = 100;
            _local_1.alphaFrom = 0.7;
            _local_1.alphaTo = 1;
            _local_1.blurXFrom = 10;
            _local_1.blurXTo = 0;
            _local_1.blurYFrom = 10;
            _local_1.blurYTo = 0;
            _local_1.color = 16639114;
            return (_local_1);
        }

        public function set glowImageOut(_arg_1:Glow):void
        {
            var _local_2:Object = this._1858451296glowImageOut;
            if (_local_2 !== _arg_1)
            {
                this._1858451296glowImageOut = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "glowImageOut", _local_2, _arg_1));
            };
        }

        private function _PlayerHeadFrame_Parallel1_i():Parallel
        {
            var _local_1:Parallel = new Parallel();
            myOverEffect = _local_1;
            _local_1.children = [_PlayerHeadFrame_Glow1_i()];
            return (_local_1);
        }

        private function showTooltip(_arg_1:MouseEvent):void
        {
            this.serverTimeTooltip.moveToMouse(_arg_1);
            this.serverTimeTooltip.refresh();
            if (!this.serverTimeTooltip.isPopUp)
            {
                PopUpManager.addPopUp(this.serverTimeTooltip, this);
            };
        }

        [Bindable(event="propertyChange")]
        public function get glowImageOver():Glow
        {
            return (this._1777414718glowImageOver);
        }

        [Bindable(event="propertyChange")]
        public function get myOutEffect():Parallel
        {
            return (this._1963141581myOutEffect);
        }

        public function __ust_mouseMove(_arg_1:MouseEvent):void
        {
            moveTooltip(_arg_1);
        }

        public function __ust_mouseOver(_arg_1:MouseEvent):void
        {
            showTooltip(_arg_1);
        }

        [Bindable(event="propertyChange")]
        public function get myOverEffect():Parallel
        {
            return (this._1725544017myOverEffect);
        }

        public function __myPhoto_complete(_arg_1:Event):void
        {
            ImageSmooth.onLoadComplete(_arg_1);
        }

        public function set myPhoto(_arg_1:Image):void
        {
            var _local_2:Object = this._1494871014myPhoto;
            if (_local_2 !== _arg_1)
            {
                this._1494871014myPhoto = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myPhoto", _local_2, _arg_1));
            };
        }

        public function ___PlayerHeadFrame_Label1_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        private function showServerList():void
        {
            if (!Context.getInstance().bVisitor)
            {
                ServerList.show();
            };
        }

        private function _PlayerHeadFrame_GlowFilter2_c():GlowFilter
        {
            var _local_1:GlowFilter = new GlowFilter();
            _local_1.color = 1056062;
            _local_1.strength = 2;
            _local_1.quality = 1;
            return (_local_1);
        }

        private function hideTooltip():void
        {
            PopUpManager.removePopUp(this.serverTimeTooltip);
        }

        private function showMyTreasureWindow():void
        {
            AllWindows.switchToFuncWindow(MyTreasure.EVENT_SHOW);
        }

        private function mouseOutEffect():void
        {
            this.myOutEffect.play([this.myPhoto]);
        }

        public function __ust_mouseOut(_arg_1:MouseEvent):void
        {
            hideTooltip();
        }

        private function _PlayerHeadFrame_bindingExprs():void
        {
            var _local_1:*;
            _local_1 = this.playerInfoBean.faceUrl;
            _local_1 = GameConfig.instance.strserverAlias;
            _local_1 = ((UIUtil.FormatTwoString(Context.getInstance().serverHours) + ":") + UIUtil.FormatTwoString(Context.getInstance().serverMinutes));
        }

        private function onToolTipShown(_arg_1:ToolTipEvent):void
        {
            var _local_2:IToolTip;
            var _local_3:int;
            if (ToolTipManager.currentToolTip)
            {
                _local_2 = ToolTipManager.currentToolTip;
                _local_3 = Application.application.width;
                if ((_local_2.x + _local_2.width) > _local_3)
                {
                    _local_2.x = (_local_3 - _local_2.width);
                };
            };
        }

        private function showOfficeWindow():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_TOWN_HALL)
                {
                    AllWindows.switchToBuildingWindow(Office.EVENT_SHOW, _local_1);
                    return;
                };
            };
        }

        private function moveTooltip(_arg_1:MouseEvent):void
        {
            if (this.serverTimeTooltip != null)
            {
                this.serverTimeTooltip.moveToMouse(_arg_1);
            };
        }

        public function set myOutEffect(_arg_1:Parallel):void
        {
            var _local_2:Object = this._1963141581myOutEffect;
            if (_local_2 !== _arg_1)
            {
                this._1963141581myOutEffect = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "myOutEffect", _local_2, _arg_1));
            };
        }

        public function ___PlayerHeadFrame_EvonyImage2_click(_arg_1:MouseEvent):void
        {
            openPlayerInfoWin();
        }

        private function _PlayerHeadFrame_Glow1_i():Glow
        {
            var _local_1:Glow = new Glow();
            glowImageOver = _local_1;
            _local_1.duration = 100;
            _local_1.alphaFrom = 1;
            _local_1.alphaTo = 0.7;
            _local_1.blurXFrom = 0;
            _local_1.blurXTo = 10;
            _local_1.blurYFrom = 0;
            _local_1.blurYTo = 10;
            _local_1.color = 16639114;
            return (_local_1);
        }

        private function _PlayerHeadFrame_bindingsSetup():Array
        {
            var binding:Binding;
            var result:Array = [];
            binding = new Binding(this, function ():Object
            {
                return (this.playerInfoBean.faceUrl);
            }, function (_arg_1:Object):void
            {
                myPhoto.source = _arg_1;
            }, "myPhoto.source");
            result[0] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = GameConfig.instance.strserverAlias;
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                _PlayerHeadFrame_Label1.text = _arg_1;
            }, "_PlayerHeadFrame_Label1.text");
            result[1] = binding;
            binding = new Binding(this, function ():String
            {
                var _local_1:* = ((UIUtil.FormatTwoString(Context.getInstance().serverHours) + ":") + UIUtil.FormatTwoString(Context.getInstance().serverMinutes));
                return ((_local_1 == undefined) ? null : String(_local_1));
            }, function (_arg_1:String):void
            {
                ust.text = _arg_1;
            }, "ust.text");
            result[2] = binding;
            return (result);
        }

        [Bindable(event="propertyChange")]
        public function get myPhoto():Image
        {
            return (this._1494871014myPhoto);
        }

        public function ___PlayerHeadFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }


    }
}//package view

