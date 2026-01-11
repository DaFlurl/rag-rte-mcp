// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.MainFrame

package view.castle
{
    import mx.containers.Canvas;
    import com.evony.common.beans.BuffBean;
    import flash.utils.Timer;
    import flash.display.DisplayObject;
    import mx.core.UIComponent;
    import flash.display.MovieClip;
    import mx.core.UIComponentDescriptor;
    import flash.utils.getTimer;
    import flash.geom.Point;
    import mx.core.mx_internal;
    import com.evony.eum.ItemEumDefine;
    import com.evony.common.module.common.GetItemDefResponse;
    import com.evony.events.ShowCityEvent;
    import com.evony.Context;
    import flash.events.TimerEvent;
    import com.evony.client.response.ResponseDispatcher;
    import com.evony.client.action.ActionFactory;
    import flash.events.Event;
    import com.evony.Lang;
    import com.evony.events.ShowMapEvent;
    import mx.events.PropertyChangeEvent;
    import mx.collections.ArrayCollection;
    import com.evony.util.UIUtil;
    import view.RandomEventWin;
    import com.evony.common.server.events.VisitorHelpEvent;
    import view.MainWin;
    import com.evony.common.MouseManager;
    import flash.events.MouseEvent;
    import com.evony.util.EvonyAnimation;
    import mx.events.FlexEvent;
    import com.evony.common.server.events.GetPlayerVoteInfro;
    import com.evony.events.ChangeSizeEvent;
    import view.doubleBuilding;
    import view.OffSale;
    import view.digiTask;
    import view.module.playerInfo.StageChangeWin;
    import com.evony.common.server.events.GetTopVotesPlayer;
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

    public class MainFrame extends Canvas 
    {

        public static var instance:MainFrame;

        private const zoomOutRate:Number = 0.9;
        private const zoomInRate:Number = 1.1;
        private var _693640971isPlayerNew:Boolean;
        private var bShowCityFlag:Boolean = false;
        public var bAutoFit:Boolean = true;
        private var iCount:int = 0;
        private var _496366315peacebeans:BuffBean;
        private var _93610691beans:BuffBean;
        public var nextView:Canvas = null;
        private var _102420391btnBottom:int = 32;
        private var cityX:int;
        private var cityY:int;
        public var townView:TownView = null;
        private var bShowMapFlag:Boolean = false;
        private var dragTimer:Timer;
        private var myTimer_peace:Timer;
        private var _710198602isUniteBuff:Boolean = false;
        private var isCallBack:Boolean = false;
        public var cityView:CityView = null;
        public var currentView:Canvas = null;
        private var moveTarget:DisplayObject;
        private var UIComp:UIComponent = null;
        public var mapWin:Map = null;
        private var myTimer:Timer;
        private var moveTimer:Timer;
        private var miniLoginMovie:MovieClip = null;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Canvas});
        private var lastZoomTime:Number = getTimer();
        private var randomEvent4:Timer = new Timer(360000);
        private var dblTimer:Timer = new Timer(500, 1);
        private var mouseStartPoint:Point = new Point();
        private var moveStartPoint:Point = new Point();

        public function MainFrame()
        {
            mx_internal::_document = this;
            this.percentWidth = 100;
            this.percentHeight = 100;
            this.autoLayout = false;
            this.horizontalScrollPolicy = "off";
            this.verticalScrollPolicy = "off";
            this.addEventListener("creationComplete", ___MainFrame_Canvas1_creationComplete);
        }

        private function onItemDefXml(_arg_1:GetItemDefResponse):*
        {
            ItemEumDefine.addPacketItem(_arg_1.itemXml);
        }

        private function showCity(_arg_1:ShowCityEvent):void
        {
            if (((bShowCityFlag) || (this.cityView == null)))
            {
                return;
            };
            if (((!(currentView == null)) && (!(currentView == CityView.singleton()))))
            {
                this.removeChild(currentView);
            };
            this.nextView.visible = true;
            this.currentView = this.nextView;
            bShowCityFlag = true;
            doCenter();
            stopLoginMovie();
            if (this.cityView != null)
            {
                this.cityView.restorePlayAll();
                this.cityView.isShow = true;
            };
        }

        public function onAutoFit():void
        {
            if (!bAutoFit)
            {
                doAutofit();
            }
            else
            {
                doRestore();
            };
        }

        private function randomEvent4Handler(_arg_1:TimerEvent):void
        {
            trace("in town 6 mins.");
            if (!Context.getInstance().facebookUser)
            {
                return;
            };
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            var _local_2:Array = new Array(5, 7, 9, 11, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 30, 31, 32, 33, 37, 39);
            var _local_3:int = int((Math.random() * 40));
            _local_3 = (_local_3 % _local_2.length);
            _local_3 = _local_2[_local_3];
            this.townView.evtNotice.img.source = (("images/feed/star" + _local_3) + ".png");
            this.townView.evtNotice.visible = true;
        }

        private function init():void
        {
            trace((this.className + ".init()"));
            instance = this;
            addBuffBean();
            myTimer = new Timer(1000, 0);
            myTimer.addEventListener(TimerEvent.TIMER, timerHandler);
            myTimer.start();
            addpeaceBuffBean();
            myTimer_peace = new Timer(1000, 0);
            myTimer_peace.addEventListener(TimerEvent.TIMER, timerHandler_peace);
            myTimer_peace.start();
            randomEvent4.addEventListener(TimerEvent.TIMER, randomEvent4Handler);
            randomEvent4.start();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_VISITOR_HELP_EVENT, onVisitorEvent);
            dblTimer.addEventListener(TimerEvent.TIMER, dbTimerHandler);
            dblTimer.start();
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_GET_PLAYER_VOTE_INFRO, onVoteNotice);
            ResponseDispatcher.getInstance().addEventListener(ResponseDispatcher.SERVER_GET_TOP_VOTES_PLAYER, onTopVoteNotice);
            ActionFactory.getInstance().getCommonCommands().getItemDefXml(onItemDefXml);
        }

        [Bindable(event="propertyChange")]
        private function get peacebeans():BuffBean
        {
            return (this._496366315peacebeans);
        }

        private function onZoomIn(_arg_1:Event):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            if (((!(this.currentView == null)) && (!(this.currentView == MainFrame.instance.mapWin))))
            {
                if ((getTimer() - lastZoomTime) < 100)
                {
                    return;
                };
                lastZoomTime = getTimer();
                _local_2 = (this.currentView.scaleX * zoomInRate);
                if (_local_2 > 1.6)
                {
                    _local_2 = 1.6;
                };
                _local_3 = (((this.currentView.width / this.currentView.scaleX) * _local_2) - this.currentView.width);
                _local_4 = (((this.currentView.height / this.currentView.scaleY) * _local_2) - this.currentView.height);
                this.currentView.x = (this.currentView.x - (_local_3 / 2));
                this.currentView.y = (this.currentView.y - (_local_4 / 2));
                this.currentView.scaleX = _local_2;
                this.currentView.scaleY = _local_2;
            };
        }

        private function getBuffBean():BuffBean
        {
            var _local_1:BuffBean = new BuffBean();
            _local_1.descName = Lang.msg("新手提示");
            _local_1.endTime = 0;
            _local_1.typeId = "playerNewBuff";
            return (_local_1);
        }

        public function lateCallFunction(_arg_1:int, _arg_2:int):void
        {
            this.isCallBack = true;
            this.cityX = _arg_1;
            this.cityY = _arg_2;
        }

        private function showMap(_arg_1:ShowMapEvent):void
        {
            if (((bShowMapFlag) || (this.nextView == null)))
            {
                return;
            };
            if (((!(currentView == null)) && (!(currentView == MainFrame.instance.mapWin))))
            {
                this.removeChild(currentView);
            };
            this.nextView.visible = true;
            this.currentView = this.nextView;
            bShowMapFlag = true;
            this.mapWin.restorePlayAll();
            stopLoginMovie();
        }

        [Bindable(event="propertyChange")]
        private function get isPlayerNew():Boolean
        {
            return (this._693640971isPlayerNew);
        }

        private function set peacebeans(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._496366315peacebeans;
            if (_local_2 !== _arg_1)
            {
                this._496366315peacebeans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "peacebeans", _local_2, _arg_1));
            };
        }

        private function addpeaceBuffBean():void
        {
            var _local_3:BuffBean;
            var _local_1:ArrayCollection = Context.getInstance().getPlayerBean().buffsArray;
            var _local_2:Boolean;
            for each (_local_3 in _local_1)
            {
                if (((((_local_3.typeId == PLayerBuffConstants.PLAYERPEACE_BUFF) || (_local_3.typeId == PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF)) || (_local_3.typeId == "PlayerPeaceUniteServerBuff")) || (_local_3.typeId == "TruceAgreementBuff")))
                {
                    _local_2 = true;
                };
            };
            if (!_local_2)
            {
                peacebeans = getBuffpeaceBean();
            };
        }

        private function getCenterPointOfCanvas():Point
        {
            var _local_1:Point = new Point();
            _local_1.x = (this.currentView.x + (this.currentView.width / 2));
            _local_1.y = (this.currentView.y + (this.currentView.height / 2));
            return (_local_1);
        }

        private function timerHandler(_arg_1:TimerEvent):void
        {
            if (UIUtil.checkOffice())
            {
                this.beans = null;
                myTimer.stop();
            };
        }

        public function showMapYet():void
        {
            if (isCallBack == true)
            {
                this.isCallBack = false;
                this.mapWin.viewPoint(cityX, cityY);
            };
        }

        [Bindable(event="propertyChange")]
        private function get isUniteBuff():Boolean
        {
            return (this._710198602isUniteBuff);
        }

        private function onVisitorEvent(_arg_1:VisitorHelpEvent):void
        {
            RandomEventWin.show(6);
        }

        private function set btnBottom(_arg_1:int):void
        {
            var _local_2:Object = this._102420391btnBottom;
            if (_local_2 !== _arg_1)
            {
                this._102420391btnBottom = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "btnBottom", _local_2, _arg_1));
            };
        }

        public function switchToWorldMap():void
        {
            MainWin.instance.addMoneyPic.visible = false;
            MainWin.instance.allWindowsFrame.visible = false;
            if (mapWin == null)
            {
                mapWin = Map.singleton();
            };
            this.nextView = Map.singleton();
            onChange(Map.singleton());
            if (townView != null)
            {
                townView.stopPlayAll();
                townView.isShow = false;
            };
            if (this.cityView != null)
            {
                this.cityView.stopPlayAll();
                this.cityView.isShow = false;
            };
            this.mapWin.isShow = true;
            if (Map.singleton().initialized)
            {
                if (MainWin.instance != null)
                {
                    MainWin.instance.showNew.visible = false;
                };
            }
            else
            {
                MouseManager.setBusy();
            };
            Map.singleton().refresh();
            MainWin.instance.mapPosBox.visible = true;
        }

        private function moveHandle(_arg_1:MouseEvent):void
        {
            moveTarget.x = (moveStartPoint.x + (stage.mouseX - mouseStartPoint.x));
            moveTarget.y = (moveStartPoint.y + (stage.mouseY - mouseStartPoint.y));
            if (moveTarget.x >= UIUtil.getTopLeftPoint().x)
            {
                moveTarget.x = UIUtil.getTopLeftPoint().x;
            };
            if (moveTarget.y >= UIUtil.getTopLeftPoint().y)
            {
                moveTarget.y = UIUtil.getTopLeftPoint().y;
            };
            if ((moveTarget.x + moveTarget.width) <= UIUtil.getBottomRightPoint().x)
            {
                moveTarget.x = (UIUtil.getBottomRightPoint().x - moveTarget.width);
            };
            if ((moveTarget.y + moveTarget.height) <= UIUtil.getBottomRightPoint().y)
            {
                moveTarget.y = (UIUtil.getBottomRightPoint().y - moveTarget.height);
            };
        }

        private function addBuffBean():void
        {
            if (!UIUtil.checkOffice())
            {
                beans = getBuffBean();
            };
        }

        private function downHandle(_arg_1:MouseEvent):void
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandle);
            stage.removeEventListener(MouseEvent.MOUSE_UP, upHandle);
            moveTarget = (_arg_1.currentTarget as DisplayObject);
            mouseStartPoint.x = stage.mouseX;
            mouseStartPoint.y = stage.mouseY;
            moveStartPoint.x = moveTarget.x;
            moveStartPoint.y = moveTarget.y;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandle);
            stage.addEventListener(MouseEvent.MOUSE_UP, upHandle);
            Context.getInstance().iCurrentBuilding = 0;
        }

        private function onChange(_arg_1:Canvas):void
        {
            if (currentView != null)
            {
                this.removeChild(currentView);
            };
            this.currentView = _arg_1;
            this.addChild(currentView);
        }

        public function showTownView():void
        {
            var _local_1:EvonyAnimation;
            if (Context.getInstance().needUserGuide)
            {
                _local_1 = new EvonyAnimation();
                _local_1.load(EvonyAnimation.TYPE_CityViewFloorTile, -1, 1, 0, false, true);
            };
            switchToInner();
        }

        public function doRestore():void
        {
            if (((!(this.currentView == null)) && (!(this.currentView == Map.instance))))
            {
                bAutoFit = false;
                this.currentView.scaleX = 1;
                this.currentView.scaleY = 1;
                this.callLater(doCenter);
            };
            bAutoFit = false;
        }

        public function ___MainFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        private function set beans(_arg_1:BuffBean):void
        {
            var _local_2:Object = this._93610691beans;
            if (_local_2 !== _arg_1)
            {
                this._93610691beans = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "beans", _local_2, _arg_1));
            };
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        private function set isUniteBuff(_arg_1:Boolean):void
        {
            var _local_2:Object = this._710198602isUniteBuff;
            if (_local_2 !== _arg_1)
            {
                this._710198602isUniteBuff = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isUniteBuff", _local_2, _arg_1));
            };
        }

        private function getBuffpeaceBean():BuffBean
        {
            var _local_1:BuffBean = new BuffBean();
            _local_1.descName = Lang.msg("可以免战");
            _local_1.endTime = 0;
            _local_1.typeId = PLayerBuffConstants.PLAYERNOPEACE_BUFF;
            return (_local_1);
        }

        public function playLoginMovie():void
        {
            MainWin.instance.cityInBtn.enabled = false;
            MainWin.instance.cityOutBtn.enabled = false;
            MainWin.instance.mapBtn.enabled = false;
            MouseManager.setBusy();
        }

        private function onVoteNotice(_arg_1:GetPlayerVoteInfro):void
        {
            Context.getInstance().getPlayerBean().playerInfo.getvotes = _arg_1.curdayvotes;
            RandomEventWin.show(9);
        }

        private function upHandle(_arg_1:MouseEvent):void
        {
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandle);
            stage.removeEventListener(MouseEvent.MOUSE_UP, upHandle);
            Context.getInstance().iCurrentBuilding = 1;
        }

        private function onSetSize(_arg_1:ChangeSizeEvent):void
        {
            btnBottom = (_arg_1.sizeNum + 32);
        }

        [Bindable(event="propertyChange")]
        private function get btnBottom():int
        {
            return (this._102420391btnBottom);
        }

        private function onZoomOut(_arg_1:Event):void
        {
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:int;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Number;
            if (((!(this.currentView == null)) && (!(this.currentView == MainFrame.instance.mapWin))))
            {
                if ((getTimer() - lastZoomTime) < 100)
                {
                    return;
                };
                lastZoomTime = getTimer();
                _local_2 = (this.currentView.scaleX * zoomOutRate);
                _local_3 = _local_2;
                _local_4 = (UIUtil.getBottomRightPoint().x - UIUtil.getTopLeftPoint().x);
                _local_5 = (UIUtil.getBottomRightPoint().y - UIUtil.getTopLeftPoint().y);
                if (((this.currentView.width / this.currentView.scaleX) * _local_2) < _local_4)
                {
                    _local_2 = (_local_4 / (this.currentView.width / this.currentView.scaleX));
                };
                if (((this.currentView.height / this.currentView.scaleY) * _local_3) < _local_5)
                {
                    _local_3 = (_local_5 / (this.currentView.height / this.currentView.scaleY));
                };
                if (_local_2 < _local_3)
                {
                    _local_2 = _local_3;
                };
                _local_6 = (Math.abs((this.currentView.scaleX - _local_2)) / 20);
                if (_local_6 < 1E-7)
                {
                    return;
                };
                _local_7 = 0;
                while (_local_7 < 20)
                {
                    _local_8 = ((this.currentView.width / this.currentView.scaleX) * _local_2);
                    _local_9 = ((this.currentView.height / this.currentView.scaleY) * _local_2);
                    _local_10 = (((this.currentView.width / this.currentView.scaleX) * _local_2) - this.currentView.width);
                    _local_11 = (((this.currentView.height / this.currentView.scaleY) * _local_2) - this.currentView.height);
                    _local_12 = (this.currentView.x - (_local_10 / 2));
                    _local_13 = (this.currentView.y - (_local_11 / 2));
                    if (((((_local_12 > UIUtil.getTopLeftPoint().x) || ((_local_12 + _local_8) < UIUtil.getBottomRightPoint().x)) || (_local_13 > UIUtil.getTopLeftPoint().y)) || ((_local_13 + _local_9) < UIUtil.getBottomRightPoint().y)))
                    {
                        _local_2 = (_local_2 + _local_6);
                    }
                    else
                    {
                        this.currentView.x = _local_12;
                        this.currentView.y = _local_13;
                        this.currentView.scaleX = _local_2;
                        this.currentView.scaleY = _local_2;
                        return;
                    };
                    _local_7++;
                };
            };
        }

        public function switchToInner():void
        {
            if (MainWin.instance != null)
            {
                MainWin.instance.allWindowsFrame.visible = false;
            };
            if (townView == null)
            {
                townView = TownView.singleton();
            };
            onChange(TownView.singleton());
            townView.addEventListener(MouseEvent.MOUSE_DOWN, downHandle);
            if (townView != null)
            {
                townView.restorePlayAll();
                townView.isShow = true;
            };
            if (this.cityView != null)
            {
                this.cityView.stopPlayAll();
                this.cityView.isShow = false;
            };
            if (this.mapWin != null)
            {
                this.mapWin.stopPlayAll();
                this.mapWin.isShow = false;
            };
        }

        [Bindable(event="propertyChange")]
        private function get beans():BuffBean
        {
            return (this._93610691beans);
        }

        public function doCenter():void
        {
            var _local_1:Point = getCenterPointOfCanvas();
            var _local_2:Point = UIUtil.getCenterPointOfUI();
            var _local_3:Number = (_local_2.x - _local_1.x);
            var _local_4:Number = (_local_2.y - _local_1.y);
            if (((!(this.currentView == null)) && (!(this.currentView == Map.instance))))
            {
                this.currentView.x = Math.round((this.currentView.x + _local_3));
                this.currentView.y = Math.round((this.currentView.y + _local_4));
            };
        }

        public function switchToOutside():void
        {
            MainWin.instance.addMoneyPic.visible = false;
            MainWin.instance.allWindowsFrame.visible = false;
            if (cityView == null)
            {
                cityView = CityView.singleton();
            };
            this.nextView = CityView.singleton();
            CityView(cityView).updateSpace();
            onChange(CityView.singleton());
            doCenter();
            cityView.addEventListener(MouseEvent.MOUSE_DOWN, downHandle);
            if (townView != null)
            {
                townView.stopPlayAll();
                townView.isShow = false;
            };
            if (this.cityView != null)
            {
                this.cityView.restorePlayAll();
                this.cityView.isShow = true;
            };
            if (this.mapWin != null)
            {
                this.mapWin.stopPlayAll();
                this.mapWin.isShow = false;
            };
        }

        private function dbTimerHandler(_arg_1:TimerEvent):void
        {
            if (!Context.getInstance().needUserGuide)
            {
                if (UIUtil.judgeTime() < 3)
                {
                    doubleBuilding.show();
                };
            };
            if (Context.getInstance().getPlayerBean().disconnectvotes > 0)
            {
                Context.getInstance().getPlayerBean().playerInfo.getvotes = Context.getInstance().getPlayerBean().disconnectvotes;
                RandomEventWin.show(9);
            };
            OffSale.show();
            digiTask.show();
        }

        private function onClick():void
        {
            StageChangeWin.show("Normal");
        }

        private function set isPlayerNew(_arg_1:Boolean):void
        {
            var _local_2:Object = this._693640971isPlayerNew;
            if (_local_2 !== _arg_1)
            {
                this._693640971isPlayerNew = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isPlayerNew", _local_2, _arg_1));
            };
        }

        public function setMapYet(_arg_1:uint, _arg_2:uint):void
        {
            if (Map.instance != null)
            {
                this.mapWin.viewPoint(_arg_1, _arg_2);
            }
            else
            {
                this.lateCallFunction(_arg_1, _arg_2);
            };
        }

        public function stopLoginMovie():void
        {
            MainWin.instance.cityInBtn.enabled = true;
            MainWin.instance.cityOutBtn.enabled = true;
            MainWin.instance.mapBtn.enabled = true;
            MouseManager.setNormal();
        }

        private function timerHandler_peace(_arg_1:TimerEvent):void
        {
            var _local_4:BuffBean;
            var _local_2:ArrayCollection = Context.getInstance().getPlayerBean().buffsArray;
            var _local_3:Boolean;
            for each (_local_4 in _local_2)
            {
                if (((((_local_4.typeId == PLayerBuffConstants.PLAYERPEACE_BUFF) || (_local_4.typeId == PLayerBuffConstants.PLAYERPEACECOOLDOWN_BUFF)) || (_local_4.typeId == "PlayerPeaceUniteServerBuff")) || (_local_4.typeId == "TruceAgreementBuff")))
                {
                    _local_3 = true;
                    peacebeans = _local_4;
                };
                if (((_local_4.typeId == "PlayerPeaceUniteServerBuff") || (_local_4.typeId == "TruceAgreementBuff")))
                {
                    isUniteBuff = true;
                };
            };
        }

        public function onMouseWheel(_arg_1:MouseEvent):void
        {
            if (_arg_1.delta > 0)
            {
                this.onZoomIn(_arg_1);
            }
            else
            {
                this.onZoomOut(_arg_1);
            };
        }

        public function doAutofit():void
        {
            var _local_1:Number;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            iCount++;
            if (iCount <= 2)
            {
                return;
            };
            if (((!(this.currentView == null)) && (!(this.currentView == Map.instance))))
            {
                _local_1 = (TownView.WIDTH * MainWin.instance.scaleX);
                _local_2 = (TownView.HEIGHT * MainWin.instance.scaleY);
                if (this.currentView == this.cityView)
                {
                    _local_1 = (CityView.WIDTH * MainWin.instance.scaleX);
                    _local_2 = (CityView.HEIGHT * MainWin.instance.scaleY);
                };
                if (((Math.abs(((_local_2 / MainWin.instance.height) - 1)) > 0.01) && (Math.abs(((_local_1 / MainWin.instance.width) - 1)) > 0.01)))
                {
                    _local_3 = 1;
                    _local_4 = (MainWin.instance.height / _local_2);
                    _local_5 = (MainWin.instance.width / _local_1);
                    _local_3 = ((_local_4 > _local_5) ? _local_4 : _local_5);
                    this.currentView.scaleX = _local_3;
                    this.currentView.scaleY = _local_3;
                };
                this.callLater(doCenter);
            };
            bAutoFit = true;
        }

        private function onTopVoteNotice(_arg_1:GetTopVotesPlayer):void
        {
            RandomEventWin.show(10);
        }


    }
}//package view.castle

