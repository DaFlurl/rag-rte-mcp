// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.CityView

package view.castle
{
    import mx.containers.Canvas;
    import com.evony.events.GuideStepChangeEvent;
    import com.evony.common.beans.CastleBean;
    import view.castle.building.OuterTownHallBuilding;
    import com.evony.common.beans.BuildingBean;
    import view.module.guide.GuideArrow;
    import com.evony.util.EvonyAnimation;
    import com.evony.Context;
    import mx.events.FlexEvent;
    import flash.events.MouseEvent;
    import com.evony.util.ResourceLoader;
    import view.module.guide.GuideStep;
    import view.ui.GameOptionsWin;
    import view.MainWin;
    import flash.geom.Point;
    import view.castle.building.BuildingSpace;
    import flash.events.Event;
    import com.evony.events.BuildingChangeEvent;
    import view.AllWindows;
    import com.evony.MsgDispacther;
    import com.evony.util.UIUtil;
    import com.evony.common.constants.BuildingConstants;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import com.evony.common.beans.BuildingQueueBean;
    import flash.utils.setTimeout;
    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import flash.utils.*;

    public class CityView extends Canvas 
    {

        public static const WIDTH:Number = 2450;
        public static const HEIGHT:Number = 1400;
        public static const EVENT_BUILDING_CREATED:String = "CastleOut.buildingCreated";
        public static const EVENT_BUILDING_DESTROY:String = "CastleOut.buildingDestroy";
        public static const EVENT_BUILDING_UPDATE:String = "CastleOut.buildingUpdate";
        public static const EVENT_BUILDING_COMPLETE:String = "CastleOut.buildingComplete";
        public static const EVENT_BUILDING_QUEUE_UPDATE:String = "CastleOut.buildingQueueUpdate";
        public static const EVENT_BUILDING_QUEUE_REMOVED:String = "CastleOut.buildingQueueRemoved";
        private static var instance:CityView;

        protected var spaceList:Array = new Array();
        public var isShow:Boolean = false;
        private var guidEvent:GuideStepChangeEvent = null;
        public var curCastle:CastleBean;
        private var outerTownhallbuilding:OuterTownHallBuilding = new OuterTownHallBuilding();
        private var townHallbean:BuildingBean;
        private var guideArrow:GuideArrow;
        private var postInited:Boolean = false;
        private var bkImg:EvonyAnimation = new EvonyAnimation();

        public function CityView()
        {
            this.width = WIDTH;
            this.height = HEIGHT;
            curCastle = Context.getInstance().getCurCastle();
            this.addEventListener(FlexEvent.CREATION_COMPLETE, init);
            this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            this.addChild(bkImg);
            bkImg.addEventListener(EvonyAnimation.SPRITE_LOADED, onFloorTileLoaded);
            bkImg.load(getFloortileId(), -1, ResourceLoader.LOAD_DEMAND, 0, false, true);
            if (Context.getInstance().needUserGuide)
            {
                GuideStep.getInstance().addEventListener(GuideStepChangeEvent.NAME, onGuideChange);
                if (GuideStep.getInstance().currentStep == 5001)
                {
                    if (guideArrow == null)
                    {
                        this.setGuideArrow("buildGuideArrow", (spaceList[0].x + 90), spaceList[0].y);
                    };
                };
                if (GuideStep.getInstance().currentStep == 6001)
                {
                    if (guideArrow == null)
                    {
                        this.setGuideArrow("buildGuideArrow", (spaceList[1].x + 90), spaceList[1].y);
                    };
                };
                if (GuideStep.getInstance().currentStep == 7001)
                {
                    if (guideArrow == null)
                    {
                        this.setGuideArrow("buildGuideArrow", (spaceList[2].x + 90), spaceList[2].y);
                    };
                };
                if (GuideStep.getInstance().currentStep == 8001)
                {
                    if (guideArrow == null)
                    {
                        this.setGuideArrow("buildGuideArrow", (spaceList[3].x + 90), spaceList[3].y);
                    };
                };
            };
        }

        public static function singleton():CityView
        {
            if (instance == null)
            {
                instance = new (CityView)();
            };
            return (instance);
        }


        public function getMaxCocurrentNumber():int
        {
            var _local_1:int;
            switch (GameOptionsWin.performanceOpt)
            {
                case GameOptionsWin.OPT_NO_ANIMATION:
                    return (0);
                case GameOptionsWin.OPT_LESS_ANIMATION:
                    return (6);
                case GameOptionsWin.OPT_MORE_ANIMATION:
                    return (15);
                case GameOptionsWin.OPT_AUTOMATIC_BY_FPS:
                    if (MainWin.instance)
                    {
                        _local_1 = MainWin.getCurrentFPS();
                        if (_local_1 < 10)
                        {
                            return (4);
                        };
                        if (_local_1 < 19)
                        {
                            return (8);
                        };
                        return (33);
                    };
                    break;
            };
            return (0);
        }

        private function getCenterPointOfCanvas():Point
        {
            var _local_1:Point = new Point();
            _local_1.x = (this.x + (this.width / 2));
            _local_1.y = (this.y + (this.height / 2));
            return (_local_1);
        }

        private function onCurCastleChange(_arg_1:Event):void
        {
            var _local_2:BuildingSpace;
            var _local_3:int;
            var _local_4:int;
            trace((this.className + ".onCurCastleChange()"));
            this.curCastle = Context.getInstance().getCurCastle();
            this.townHallbean = getTownHallBean();
            for each (_local_2 in spaceList)
            {
                _local_2.stopAndRemoveNormalAnimation();
                _local_2.bean = null;
            };
            this.townHallbean = getTownHallBean();
            _local_3 = (13 + ((townHallbean.level - 1) * 3));
            _local_4 = 0;
            while (_local_4 < spaceList.length)
            {
                _local_2 = spaceList[_local_4];
                if (_local_4 < _local_3)
                {
                    _local_2.visible = true;
                }
                else
                {
                    _local_2.visible = false;
                };
                _local_4++;
            };
            this.refresh();
            for each (_local_2 in spaceList)
            {
                _local_2.playNormalAnimtion();
            };
        }

        protected function setTilePos(_arg_1:Object):Array
        {
            var _local_2:Array = new Array();
            _local_2[0] = new Point(_arg_1.pos0.x, _arg_1.pos0.y);
            _local_2[1] = new Point(_arg_1.pos1.x, _arg_1.pos1.y);
            _local_2[2] = new Point(_arg_1.pos2.x, _arg_1.pos2.y);
            _local_2[3] = new Point(_arg_1.pos3.x, _arg_1.pos3.y);
            _local_2[4] = new Point(_arg_1.pos4.x, _arg_1.pos4.y);
            _local_2[5] = new Point(_arg_1.pos5.x, _arg_1.pos5.y);
            _local_2[6] = new Point(_arg_1.pos6.x, _arg_1.pos6.y);
            _local_2[7] = new Point(_arg_1.pos7.x, _arg_1.pos7.y);
            _local_2[8] = new Point(_arg_1.pos8.x, _arg_1.pos8.y);
            _local_2[9] = new Point(_arg_1.pos9.x, _arg_1.pos9.y);
            _local_2[10] = new Point(_arg_1.pos10.x, _arg_1.pos10.y);
            _local_2[11] = new Point(_arg_1.pos11.x, _arg_1.pos11.y);
            _local_2[12] = new Point(_arg_1.pos12.x, _arg_1.pos12.y);
            _local_2[13] = new Point(_arg_1.pos13.x, _arg_1.pos13.y);
            _local_2[14] = new Point(_arg_1.pos14.x, _arg_1.pos14.y);
            _local_2[15] = new Point(_arg_1.pos15.x, _arg_1.pos15.y);
            _local_2[16] = new Point(_arg_1.pos16.x, _arg_1.pos16.y);
            _local_2[17] = new Point(_arg_1.pos17.x, _arg_1.pos17.y);
            _local_2[18] = new Point(_arg_1.pos18.x, _arg_1.pos18.y);
            _local_2[19] = new Point(_arg_1.pos19.x, _arg_1.pos19.y);
            _local_2[20] = new Point(_arg_1.pos20.x, _arg_1.pos20.y);
            _local_2[21] = new Point(_arg_1.pos21.x, _arg_1.pos21.y);
            _local_2[22] = new Point(_arg_1.pos22.x, _arg_1.pos22.y);
            _local_2[23] = new Point(_arg_1.pos23.x, _arg_1.pos23.y);
            _local_2[24] = new Point(_arg_1.pos24.x, _arg_1.pos24.y);
            _local_2[25] = new Point(_arg_1.pos25.x, _arg_1.pos25.y);
            _local_2[26] = new Point(_arg_1.pos26.x, _arg_1.pos26.y);
            _local_2[27] = new Point(_arg_1.pos27.x, _arg_1.pos27.y);
            _local_2[28] = new Point(_arg_1.pos28.x, _arg_1.pos28.y);
            _local_2[29] = new Point(_arg_1.pos29.x, _arg_1.pos29.y);
            _local_2[30] = new Point(_arg_1.pos30.x, _arg_1.pos30.y);
            _local_2[31] = new Point(_arg_1.pos31.x, _arg_1.pos31.y);
            _local_2[32] = new Point(_arg_1.pos32.x, _arg_1.pos32.y);
            _local_2[33] = new Point(_arg_1.pos33.x, _arg_1.pos33.y);
            _local_2[34] = new Point(_arg_1.pos34.x, _arg_1.pos34.y);
            _local_2[35] = new Point(_arg_1.pos35.x, _arg_1.pos35.y);
            _local_2[36] = new Point(_arg_1.pos36.x, _arg_1.pos36.y);
            _local_2[37] = new Point(_arg_1.pos37.x, _arg_1.pos37.y);
            _local_2[38] = new Point(_arg_1.pos38.x, _arg_1.pos38.y);
            _local_2[39] = new Point(_arg_1.pos39.x, _arg_1.pos39.y);
            _local_2[40] = new Point(_arg_1.pos40.x, _arg_1.pos40.y);
            return (_local_2);
        }

        private function onBuildingComplete(_arg_1:BuildingChangeEvent):void
        {
            trace("cityview onBuildingComplete");
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(_arg_1.getBean());
            _local_2.stopAndRemoveNormalAnimation();
            _local_2.playNormalAnimtion();
        }

        protected function getSpaceByPosId(_arg_1:int):BuildingSpace
        {
            var _local_2:BuildingSpace;
            for each (_local_2 in spaceList)
            {
                if (_local_2.getPositionId() == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function init(_arg_1:FlexEvent):void
        {
            instance = this;
            MainFrame.instance.doAutofit();
        }

        private function onNewBuildingCreated(_arg_1:BuildingChangeEvent):void
        {
            trace((this.className + ".onNewBuildingCreated()"));
            AllWindows.closeAll();
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(_arg_1.getBean());
            _local_2.stopAndRemoveNormalAnimation();
            _local_2.playNormalAnimtion();
        }

        public function updateSpace():void
        {
            var _local_3:BuildingSpace;
            this.townHallbean = getTownHallBean();
            var _local_1:int = (13 + ((townHallbean.level - 1) * 3));
            var _local_2:int;
            while (_local_2 < spaceList.length)
            {
                _local_3 = spaceList[_local_2];
                if (_local_2 < _local_1)
                {
                    _local_3.visible = true;
                    _local_3.playNormalAnimtion();
                }
                else
                {
                    _local_3.visible = false;
                };
                _local_2++;
            };
        }

        private function onBuildingDestroy(_arg_1:BuildingChangeEvent):void
        {
            trace((this.className + ".onBuildingDestroy()"));
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(null);
            _local_2.stopAndRemoveNormalAnimation();
            _local_2.playNormalAnimtion();
        }

        protected function postInit(_arg_1:Array):void
        {
            this.curCastle = Context.getInstance().getCurCastle();
            this.townHallbean = getTownHallBean();
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_CREATED, onNewBuildingCreated);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_DESTROY, onBuildingDestroy);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_UPDATE, onBuildingUpdate);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_COMPLETE, onBuildingComplete);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_QUEUE_UPDATE, onBuildingQueueUpdate);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_QUEUE_REMOVED, onBuildingQueueRemoved);
            var _local_2:int = (13 + ((townHallbean.level - 1) * 3));
            var _local_3:BuildingSpace;
            var _local_4:int;
            _local_4 = 0;
            while (_local_4 < 40)
            {
                _local_3 = new BuildingSpace(this);
                _local_3.childIndex = _local_4;
                _local_3.x = _arg_1[_local_4].x;
                _local_3.y = _arg_1[_local_4].y;
                _local_3.setPositionId((1001 + _local_4));
                if (_local_4 >= _local_2)
                {
                    _local_3.visible = false;
                };
                _local_3.isCityView = true;
                spaceList.push(_local_3);
                _local_3.addEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLastFrameOfSpace);
                _local_4++;
            };
            refresh();
            _local_4 = 0;
            while (_local_4 < spaceList.length)
            {
                _local_3 = spaceList[_local_4];
                _local_3.playNormalAnimtion();
                _local_4++;
            };
            adjustCocurrent();
            outerTownhallbuilding.x = _arg_1[40].x;
            outerTownhallbuilding.y = _arg_1[40].y;
            outerTownhallbuilding.visible = true;
            this.addChild(outerTownhallbuilding);
            postInited = true;
            if (guidEvent != null)
            {
                onGuideChange(guidEvent);
                guidEvent = null;
            };
        }

        private function onBuildingUpdate(_arg_1:BuildingChangeEvent):void
        {
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(_arg_1.getBean());
            _local_2.updateConstructPercent(100);
            trace("cityview onBuildingUpdate");
        }

        private function onBuildingQueueUpdate(_arg_1:BuildingChangeEvent):void
        {
            var _local_4:BuildingBean;
            if (_arg_1.getQueueBean() == null)
            {
                return;
            };
            if (UIUtil.isInnerBuilding(_arg_1.getQueueBean().positionId))
            {
                return;
            };
            var _local_2:int = (_arg_1.getQueueBean().positionId - 1001);
            var _local_3:BuildingBean = spaceList[_local_2].getBean();
            if (_local_3 == null)
            {
                _local_3 = UIUtil.buildingQueueBean2BuildingBean(_arg_1.getQueueBean());
                spaceList[_local_2].setBean(_local_3);
            }
            else
            {
                if (_local_3.status == BuildingConstants.STATUS_NORMAL)
                {
                    _local_4 = new BuildingBean();
                    _local_3.copyTo(_local_4);
                    _local_4.status = BuildingConstants.STATUS_WAITING;
                    spaceList[_local_2].setBean(_local_4);
                };
            };
            spaceList[_local_2].stopAndRemoveNormalAnimation();
            spaceList[_local_2].playNormalAnimtion();
        }

        public function onFloorTileLoaded(evt:Event):void
        {
            var obj:Sprite = evt.target.mc;
            ResourceLoader.traverseMovieClip(obj, 1, function (_arg_1:Object, _arg_2:int):int
            {
                if (((_arg_1 is MovieClip) && (_arg_1.name.indexOf("pos") >= 0)))
                {
                    DisplayObject(_arg_1).visible = false;
                };
                return (_arg_2++);
            });
            var tile_pos:Array = setTilePos(obj);
            postInit(tile_pos);
            bkImg.removeEventListener(EvonyAnimation.SPRITE_LOADED, onFloorTileLoaded);
        }

        private function onArrowShowTimeout():void
        {
            if (GuideStep.getInstance().currentStep == 6001)
            {
                this.setGuideArrow("buildGuideArrow", (spaceList[1].x + 90), spaceList[1].y);
            };
        }

        public function restorePlayAll():void
        {
            adjustCocurrent();
        }

        private function onBuildingQueueRemoved(_arg_1:BuildingChangeEvent):void
        {
            var _local_4:BuildingBean;
            if (_arg_1.getQueueBean() == null)
            {
                return;
            };
            if (UIUtil.isInnerBuilding(_arg_1.getQueueBean().positionId))
            {
                return;
            };
            var _local_2:int = (_arg_1.getQueueBean().positionId - 1001);
            var _local_3:BuildingBean = spaceList[_local_2].getBean();
            if (_local_3 == null)
            {
                return;
            };
            if (!Context.getInstance().isBuildingQueued(_arg_1.getQueueBean().positionId))
            {
                _local_4 = Context.getInstance().getBuildingObjByPosision(_arg_1.getQueueBean().positionId);
                spaceList[_local_2].setBean(_local_4);
            };
            spaceList[_local_2].stopAndRemoveNormalAnimation();
            spaceList[_local_2].playNormalAnimtion();
        }

        protected function refresh():void
        {
            var _local_1:BuildingBean;
            var _local_2:BuildingQueueBean;
            var _local_3:int;
            var _local_4:int;
            var _local_5:BuildingBean;
            var _local_6:BuildingBean;
            for each (_local_1 in curCastle.buildingsArray)
            {
                if (!UIUtil.isInnerBuilding(_local_1.positionId))
                {
                    trace(_local_1.positionId);
                    _local_3 = (_local_1.positionId - 1001);
                    if (spaceList[_local_3] != null)
                    {
                        spaceList[_local_3].setBean(_local_1);
                    }
                    else
                    {
                        trace("wrong position id");
                    };
                };
            };
            for each (_local_2 in curCastle.buildingQueuesArray)
            {
                if (!UIUtil.isInnerBuilding(_local_2.positionId))
                {
                    _local_4 = (_local_2.positionId - 1001);
                    _local_5 = spaceList[_local_4].getBean();
                    if (_local_5 == null)
                    {
                        _local_5 = UIUtil.buildingQueueBean2BuildingBean(_local_2);
                        spaceList[_local_4].setBean(_local_5);
                    }
                    else
                    {
                        if (_local_5.status == BuildingConstants.STATUS_NORMAL)
                        {
                            _local_6 = new BuildingBean();
                            _local_5.copyTo(_local_6);
                            _local_6.status = BuildingConstants.STATUS_WAITING;
                            spaceList[_local_4].setBean(_local_6);
                        };
                    };
                };
            };
        }

        public function stopPlayAll():void
        {
            var _local_2:BuildingSpace;
            var _local_1:int;
            while (_local_1 < spaceList.length)
            {
                _local_2 = (spaceList[_local_1] as BuildingSpace);
                if (_local_2 != null)
                {
                    if (((!(_local_2.bean == null)) && (!(_local_2.bean.status == BuildingConstants.STATUS_NORMAL))))
                    {
                        trace("me");
                    }
                    else
                    {
                        _local_2.stop();
                    };
                };
                _local_1++;
            };
        }

        private function getTownHallBean():BuildingBean
        {
            var _local_1:BuildingBean;
            curCastle = Context.getInstance().getCurCastle();
            for each (_local_1 in this.curCastle.buildingsArray)
            {
                if (_local_1.typeId == BuildingConstants.TYPE_TOWN_HALL)
                {
                    return (_local_1);
                };
            };
            return (null);
        }

        private function onMouseWheel(_arg_1:MouseEvent):void
        {
            if (MainFrame.instance != null)
            {
                MainFrame.instance.onMouseWheel(_arg_1);
            };
        }

        private function setGuideArrow(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            guideArrow = new GuideArrow();
            guideArrow.type = _arg_1;
            guideArrow.x = _arg_2;
            guideArrow.y = _arg_3;
            this.addChild(guideArrow);
        }

        private function onLastFrameOfSpace(_arg_1:Event):void
        {
            var _local_2:BuildingSpace = (_arg_1.target as BuildingSpace);
            if (_local_2 != null)
            {
                adjustCocurrent();
                _local_2.stop();
            };
        }

        private function onGuideChange(_arg_1:GuideStepChangeEvent):void
        {
            if (!this.postInited)
            {
                guidEvent = _arg_1;
                return;
            };
            if (((!(guideArrow == null)) && (guideArrow.visible)))
            {
                this.removeChild(guideArrow);
                guideArrow = null;
            };
            switch (_arg_1.currentStep)
            {
                case 5001:
                    this.setGuideArrow("buildGuideArrow", (spaceList[0].x + 90), spaceList[0].y);
                    return;
                case 6001:
                    setTimeout(onArrowShowTimeout, 100);
                    return;
                case 7001:
                    this.setGuideArrow("buildGuideArrow", (spaceList[2].x + 90), spaceList[2].y);
                    return;
                case 8001:
                    this.setGuideArrow("buildGuideArrow", (spaceList[3].x + 90), spaceList[3].y);
                    return;
            };
        }

        public function adjustCocurrent():void
        {
            var _local_6:BuildingSpace;
            var _local_1:int;
            var _local_2:int = getMaxCocurrentNumber();
            var _local_3:Array = new Array();
            var _local_4:Array = new Array();
            _local_1 = 0;
            for (;_local_1 < spaceList.length;_local_1++)
            {
                _local_6 = spaceList[_local_1];
                if (_local_6.stopped())
                {
                    if (((!(_local_6.bean == null)) && (!(_local_6.bean.status == BuildingConstants.STATUS_NORMAL))))
                    {
                        _local_6.play();
                        continue;
                    };
                    if (((_local_6.visible == true) && (!(_local_6.bean == null))))
                    {
                        _local_4.push(_local_6);
                    };
                }
                else
                {
                    if (!((!(_local_6.bean == null)) && (!(_local_6.bean.status == BuildingConstants.STATUS_NORMAL))))
                    {
                        if (((_local_6.visible == true) && (!(_local_6.bean == null))))
                        {
                            _local_3.push(_local_6);
                        };
                    };
                };
            };
            var _local_5:int;
            _local_5 = (int(_local_2) - int(_local_3.length));
            if (_local_5 < 0)
            {
                _local_5 = -(_local_5);
                _local_3.sort(TownView.randsort);
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    if (_local_3[_local_1].visible)
                    {
                        if (!_local_3[_local_1].stopped())
                        {
                            _local_5--;
                            _local_3[_local_1].stop();
                        };
                    };
                    _local_1++;
                };
            }
            else
            {
                _local_4.sort(TownView.randsort);
                _local_1 = 0;
                while (((_local_1 < _local_4.length) && (_local_5 > 0)))
                {
                    if (_local_4[_local_1].visible)
                    {
                        if (_local_4[_local_1].stopped())
                        {
                            _local_4[_local_1].play();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
            };
        }

        protected function getFloortileId():int
        {
            return (EvonyAnimation.TYPE_CityViewFloorTile);
        }


    }
}//package view.castle

