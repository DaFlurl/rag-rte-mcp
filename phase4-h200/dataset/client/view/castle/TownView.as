// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.TownView

package view.castle
{
    import mx.containers.Canvas;
    import mx.controls.Image;
    import com.evony.common.beans.CastleBean;
    import view.module.guide.GuideArrow;
    import flash.utils.getTimer;
    import view.EventNotice;
    import flash.events.MouseEvent;
    import com.evony.Context;
    import mx.events.FlexEvent;
    import flash.geom.Point;
    import mx.controls.Alert;
    import com.evony.util.EvonyAnimation;
    import com.evony.common.beans.BuildingBean;
    import com.evony.util.UIUtil;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.events.BuildingChangeEvent;
    import view.castle.building.BuildingSpace;
    import com.evony.util.ResourceLoader;
    import view.module.guide.GuideStep;
    import com.evony.events.GuideStepChangeEvent;
    import flash.events.Event;
    import view.AllWindows;
    import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import view.ui.GameOptionsWin;
    import view.MainWin;
    import mx.events.EffectEvent;
    import mx.effects.Blur;
    import view.RandomEventWin;
    import view.module.quest.AddArmyWin;
    import view.ToolBarFrame;
    import com.evony.MsgDispacther;
    import flash.net.SharedObject;
    import com.evony.common.beans.BuildingQueueBean;
    import flash.display.*;
    import flash.geom.*;
    import flash.events.*;
    import flash.utils.*;

    public class TownView extends Canvas 
    {

        public static const EVENT_BUILDING_CREATED:String = "CastleIn.buildingCreated";
        public static const EVENT_BUILDING_DESTROY:String = "CastleIn.buildingDestroy";
        public static const EVENT_BUILDING_UPDATE:String = "CastleIn.buildingUpdate";
        public static const EVENT_BUILDING_COMPLETE:String = "CastleIn.buildingComplete";
        public static const EVENT_BUILDING_QUEUE_UPDATE:String = "CastleIn.buildingQueueUpdate";
        public static const EVENT_BUILDING_QUEUE_REMOVED:String = "CastleIn.buildingQueueRemoved";
        public static const WIDTH:Number = 2363;
        public static const HEIGHT:Number = 1364;
        public static var instance:TownView = null;
        private static var armyNum:Number = 0;
        private static var produceStatus:Object = new Object();

        private var bSkip:Boolean = false;
        private var img:Image;
        public var isShow:Boolean = false;
        public var curCastle:CastleBean;
        public var pendingLoginSceneAni:Array = null;
        public var isNormalScene:Boolean = false;
        public var guideArrow:GuideArrow;

        public var spaceList:Array = new Array();
        private var lastfps_time:Number = getTimer();
        public var evtNotice:EventNotice = new EventNotice();

        public function TownView()
        {
            this.width = WIDTH;
            this.height = HEIGHT;
            this.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
            curCastle = Context.getInstance().getCurCastle();
            this.addEventListener(FlexEvent.CREATION_COMPLETE, createComplete);
            init(null);
        }

        public static function randsort(_arg_1:Object, _arg_2:Object):Number
        {
            if (Math.random() > 0.7)
            {
                return (-1);
            };
            if (Math.random() < 0.3)
            {
                return (1);
            };
            return (0);
        }

        public static function setBuildingStatus(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            if (produceStatus[_arg_1] == null)
            {
                produceStatus[_arg_1] = new Object();
            };
            var _local_4:Object = produceStatus[_arg_1];
            _local_4[_arg_2] = _arg_3;
        }

        public static function singleton():TownView
        {
            if (instance == null)
            {
                instance = new (TownView)();
            };
            return (instance);
        }

        public static function handleNewArmy(_arg_1:int):void
        {
        }

        public static function handleUnderAttack():void
        {
            if (((((!(MainFrame.instance == null)) && (MainFrame.instance.initialized)) && (!(MainFrame.instance.currentView == null))) && (MainFrame.instance.currentView == MainFrame.instance.townView)))
            {
                MainFrame.instance.townView.stopPlayAll();
                MainFrame.instance.townView.restorePlayAll();
            };
        }


        protected function setTilePos(obj:Object):Array
        {
            var tile_pos:Array = new Array();
            try
            {
                tile_pos[0] = new Point(int(obj.pos0.x), int(obj.pos0.y));
                tile_pos[1] = new Point(int(obj.pos1.x), int(obj.pos1.y));
                tile_pos[2] = new Point(int(obj.pos2.x), int(obj.pos2.y));
                tile_pos[3] = new Point(int(obj.pos3.x), int(obj.pos3.y));
                tile_pos[4] = new Point(int(obj.pos4.x), int(obj.pos4.y));
                tile_pos[5] = new Point(int(obj.pos5.x), int(obj.pos5.y));
                tile_pos[6] = new Point(int(obj.pos6.x), int(obj.pos6.y));
                tile_pos[7] = new Point(int(obj.pos7.x), int(obj.pos7.y));
                tile_pos[8] = new Point(int(obj.pos8.x), int(obj.pos8.y));
                tile_pos[9] = new Point(int(obj.pos9.x), int(obj.pos9.y));
                tile_pos[10] = new Point(int(obj.pos10.x), int(obj.pos10.y));
                tile_pos[11] = new Point(int(obj.pos11.x), int(obj.pos11.y));
                tile_pos[12] = new Point(int(obj.pos12.x), int(obj.pos12.y));
                tile_pos[13] = new Point(int(obj.pos13.x), int(obj.pos13.y));
                tile_pos[14] = new Point(int(obj.pos14.x), int(obj.pos14.y));
                tile_pos[15] = new Point(int(obj.pos15.x), int(obj.pos15.y));
                tile_pos[16] = new Point(int(obj.pos16.x), int(obj.pos16.y));
                tile_pos[17] = new Point(int(obj.pos17.x), int(obj.pos17.y));
                tile_pos[18] = new Point(int(obj.pos18.x), int(obj.pos18.y));
                tile_pos[19] = new Point(int(obj.pos19.x), int(obj.pos19.y));
                tile_pos[20] = new Point(int(obj.pos20.x), int(obj.pos20.y));
                tile_pos[21] = new Point(int(obj.pos21.x), int(obj.pos21.y));
                tile_pos[22] = new Point(int(obj.pos22.x), int(obj.pos22.y));
                tile_pos[23] = new Point(int(obj.pos23.x), int(obj.pos23.y));
                tile_pos[24] = new Point(int(obj.pos24.x), int(obj.pos24.y));
                tile_pos[25] = new Point(int(obj.pos25.x), int(obj.pos25.y));
                tile_pos[26] = new Point(int(obj.pos26.x), int(obj.pos26.y));
                tile_pos[27] = new Point(int(obj.pos27.x), int(obj.pos27.y));
                tile_pos[28] = new Point(int(obj.pos28.x), int(obj.pos28.y));
                tile_pos[29] = new Point(int(obj.pos29.x), int(obj.pos29.y));
                tile_pos[30] = new Point(int(obj.pos30.x), int(obj.pos30.y));
                tile_pos[31] = new Point(int(obj.pos31.x), int(obj.pos31.y));
                tile_pos[32] = new Point(int(obj.pos32.x), int(obj.pos32.y));
                tile_pos[33] = new Point(int(obj.pos33.x), int(obj.pos33.y));
            }
            catch(e:Error)
            {
                Alert.show((("\n---------------------------------------------------\n" + e.getStackTrace()) + "\n"), ("Position point not exists or not named properly in symbol " + EvonyAnimation.getAniFullInfo(this.flootTileId)));
            };
            return (tile_pos);
        }

        private function onBuildingQueueUpdate(_arg_1:BuildingChangeEvent):void
        {
            var _local_4:BuildingBean;
            if (_arg_1.getQueueBean() == null)
            {
                return;
            };
            if (!UIUtil.isInnerBuilding(_arg_1.getQueueBean().positionId))
            {
                return;
            };
            var _local_2:int = mapPos(_arg_1.getQueueBean().positionId);
            if (_local_2 == 33)
            {
                _local_2 = 0;
            }
            else
            {
                _local_2 = (_local_2 + 1);
            };
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

        private function playNormalAnimation():void
        {
            var _local_2:BuildingSpace;
            var _local_1:int;
            while (_local_1 < spaceList.length)
            {
                _local_2 = (spaceList[_local_1] as BuildingSpace);
                _local_2.stopAndRemoveLoginScene();
                _local_2.playNormalAnimtion();
                _local_1++;
            };
            isNormalScene = true;
            adjustCocurrent();
        }

        private function onBuildingComplete(_arg_1:BuildingChangeEvent):void
        {
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(_arg_1.getBean());
            _local_2.stopAndRemoveNormalAnimation();
            _local_2.playNormalAnimtion();
            if (_local_2.getPositionId() == -1)
            {
                if (((!(MainFrame.instance == null)) && (!(MainFrame.instance.cityView == null))))
                {
                    MainFrame.instance.cityView.updateSpace();
                };
            };
        }

        public function init(_arg_1:Event):void
        {
            instance = this;
            var _local_2:EvonyAnimation = new EvonyAnimation();
            this.addChild(_local_2);
            _local_2.addEventListener(EvonyAnimation.SPRITE_LOADED, onFloorTileLoaded);
            _local_2.load(getFloortileId(), -1, ResourceLoader.LOAD_DEMAND, 0, false, true);
            evtNotice.x = 1140;
            evtNotice.y = 680;
            evtNotice.visible = false;
            this.addChild(evtNotice);
            if (Context.getInstance().needUserGuide)
            {
                GuideStep.getInstance().addEventListener(GuideStepChangeEvent.NAME, onGuideChange);
                if (GuideStep.getInstance().currentStep == 10101)
                {
                    if (guideArrow == null)
                    {
                        this.setGuideArrow("buildGuideArrow", (spaceList[14].x + 90), spaceList[14].y);
                    };
                };
            };
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
            evt.target.removeEventListener(EvonyAnimation.SPRITE_LOADED, onFloorTileLoaded);
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
                            return (3);
                        };
                        if (_local_1 < 19)
                        {
                            return (6);
                        };
                        return (30);
                    };
                    break;
            };
            return (0);
        }

        private function onBlurInEnd(_arg_1:Event):void
        {
            _arg_1.target.removeEventListener(EffectEvent.EFFECT_END, onBlurInEnd);
            var _local_2:Blur = new Blur(this);
            _local_2.blurXFrom = 30;
            _local_2.blurYFrom = 30;
            _local_2.duration = 300;
            _local_2.blurXTo = 0;
            _local_2.blurYTo = 0;
            _local_2.addEventListener(EffectEvent.EFFECT_END, onBlurOutEnd);
            _local_2.createInstance(this).startEffect();
            playNormalAnimation();
        }

        private function onBlurOutEnd(_arg_1:Event):void
        {
            var _local_2:Array;
            if (_arg_1)
            {
                _arg_1.target.removeEventListener(EffectEvent.EFFECT_END, onBlurOutEnd);
            };
            playNormalAnimation();
            MainWin.instance.skip_btn.visible = false;
            if (Context.getInstance().needUserGuide)
            {
                MainWin.instance.SkipTutorialBtn.visible = true;
            }
            else
            {
                MainWin.instance.hideTimerOut();
            };
            adjustCocurrent();
            if (!Context.getInstance().needUserGuide)
            {
                if (Context.getInstance().bVisitor == false)
                {
                    MainWin.instance.allWindowsFrame.visible = true;
                    RandomEventWin.show(1);
                    if (Context.getInstance().fbType == "fbUprising")
                    {
                        _local_2 = setXYArray(Context.getInstance().taskXY);
                        AddArmyWin.show(Context.getInstance().taskId, _local_2[0], _local_2[1]);
                    };
                };
            };
        }

        public function getBuildingStatus(_arg_1:int):Boolean
        {
            var _local_2:int = Context.getInstance().getCurCastle().id;
            if (produceStatus[_local_2] == null)
            {
                return (false);
            };
            var _local_3:Object = produceStatus[_local_2];
            if (_local_3[_arg_1] != null)
            {
                return (_local_3[_arg_1]);
            };
            return (false);
        }

        private function setXYArray(_arg_1:String):Array
        {
            var _local_2:Array;
            return (_arg_1.split(","));
        }

        public function adjustCocurrent():void
        {
            if (!isNormalScene)
            {
                return;
            };
            if (spaceList.length == 0)
            {
                return;
            };
            var _local_1:int;
            var _local_2:Array = new Array();
            var _local_3:Array = new Array();
            var _local_4:BuildingSpace;
            var _local_5:int;
            var _local_6:Number = getMaxCocurrentNumber();
            _local_1 = 1;
            for (;_local_1 < spaceList.length;_local_1++)
            {
                _local_4 = spaceList[_local_1];
                if (_local_4.stopped())
                {
                    if (((!(_local_4.bean == null)) && (!(_local_4.bean.status == BuildingConstants.STATUS_NORMAL))))
                    {
                        _local_4.play();
                        continue;
                    };
                    _local_3.push(_local_4);
                }
                else
                {
                    if (_local_4.bean == null)
                    {
                        _local_4.stop();
                        _local_3.push(_local_4);
                    }
                    else
                    {
                        if (_local_4.bean.status == BuildingConstants.STATUS_NORMAL)
                        {
                            if (((_local_4.bean.typeId == BuildingConstants.TYPE_BARRACK) && (!(getBuildingStatus(_local_4.getPositionId())))))
                            {
                                _local_4.stop();
                                _local_3.push(_local_4);
                            }
                            else
                            {
                                if (_local_4.bean.typeId == BuildingConstants.TYPE_SENTRY_BUILDING)
                                {
                                    if (!((!(ToolBarFrame.instance == null)) && (ToolBarFrame.instance.hasEnemy)))
                                    {
                                        _local_4.stop();
                                        _local_3.push(_local_4);
                                    };
                                }
                                else
                                {
                                    if (_local_4.bean.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
                                    {
                                        if (armyNum < 1)
                                        {
                                            _local_4.stop();
                                            _local_3.push(_local_4);
                                        };
                                    }
                                    else
                                    {
                                        _local_2.push(_local_4);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            if (_local_6 < 1)
            {
                return;
            };
            _local_5 = (int(_local_6) - int(_local_2.length));
            if (_local_5 < 0)
            {
                _local_2.sort(randsort);
                _local_5 = (0 - _local_5);
                _local_1 = 0;
                while (((_local_1 < _local_2.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_2[_local_1];
                    if (_local_4.bean == null)
                    {
                        _local_4.stop();
                        _local_5--;
                    }
                    else
                    {
                        if ((((((!(_local_4.bean == null)) && (!(_local_4.bean.typeId == BuildingConstants.TYPE_SENTRY_BUILDING))) && (!(_local_4.bean.typeId == BuildingConstants.TYPE_TOWN_HALL))) && (!(_local_4.bean.typeId == BuildingConstants.TYPE_BARRACK))) && (!(_local_4.bean.typeId == BuildingConstants.TYPE_TRAINNING_FEILD))))
                        {
                            _local_4.stop();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (((_local_1 < _local_2.length) && (_local_5 > 0)))
                {
                    if (!_local_4.stopped())
                    {
                        _local_4 = _local_2[_local_1];
                        if (_local_4.bean != null)
                        {
                            _local_4.stop();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
            }
            else
            {
                _local_3.sort(randsort);
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_3[_local_1];
                    if (((!(_local_4.bean == null)) && (_local_4.bean.typeId == BuildingConstants.TYPE_TOWN_HALL)))
                    {
                        if (_local_4.stopped())
                        {
                            _local_4.play();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_3[_local_1];
                    if ((((!(_local_4.bean == null)) && (_local_4.bean.typeId == BuildingConstants.TYPE_SENTRY_BUILDING)) && (ToolBarFrame.instance.hasEnemy)))
                    {
                        if (_local_4.stopped())
                        {
                            _local_4.play();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_3[_local_1];
                    if ((((!(_local_4.bean == null)) && (_local_4.bean.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)) && (armyNum > 0)))
                    {
                        if (_local_4.stopped())
                        {
                            _local_4.play();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_3[_local_1];
                    if (((!(_local_4.bean == null)) && (_local_4.bean.typeId == BuildingConstants.TYPE_BARRACK)))
                    {
                        if (((_local_4.stopped()) && (getBuildingStatus(_local_4.getPositionId()))))
                        {
                            _local_4.play();
                            _local_5--;
                        };
                    };
                    _local_1++;
                };
                _local_1 = 0;
                while (((_local_1 < _local_3.length) && (_local_5 > 0)))
                {
                    _local_4 = _local_3[_local_1];
                    if (_local_4.bean != null)
                    {
                        if (!((_local_4.bean.typeId == BuildingConstants.TYPE_SENTRY_BUILDING) || (_local_4.bean.typeId == BuildingConstants.TYPE_BARRACK)))
                        {
                            if (_local_4.stopped())
                            {
                                _local_4.play();
                                _local_5--;
                            };
                        };
                    };
                    _local_1++;
                };
            };
        }

        protected function getFloortileId():int
        {
            return (EvonyAnimation.TYPE_TownviewFloorTile);
        }

        private function onWallLoginSceneOver(_arg_1:Event):void
        {
            var _local_3:BuildingSpace;
            spaceList[0].stop();
            pendingLoginSceneAni = new Array();
            var _local_2:int = 1;
            while (_local_2 < spaceList.length)
            {
                if (bSkip) break;
                _local_3 = (spaceList[_local_2] as BuildingSpace);
                _local_3.playLoginScene(2);
                if (_local_3.getPositionId() == -1)
                {
                    _local_3.play();
                }
                else
                {
                    if (_local_3.isPlayingLoginScene())
                    {
                        pendingLoginSceneAni.push(_local_3);
                    };
                };
                _local_3.addEventListener(BuildingSpace.PLAY_LOGINSCENE_OVER, onOtherLoginSceneOver);
                _local_2++;
            };
            pendingLoginSceneAni.sort(randsort);
        }

        public function onCurCastleChange(_arg_1:Event):void
        {
            var _local_2:BuildingSpace;
            trace((this.className + ".onCurCastleChange()"));
            this.curCastle = Context.getInstance().getCurCastle();
            for each (_local_2 in spaceList)
            {
                _local_2.stopAndRemoveLoginScene();
                _local_2.stopAndRemoveNormalAnimation();
                _local_2.bean = null;
            };
            this.refresh();
            for each (_local_2 in spaceList)
            {
                _local_2.playNormalAnimtion();
            };
        }

        private function playNextLoginScene():void
        {
            var _local_3:BuildingSpace;
            if (pendingLoginSceneAni == null)
            {
                return;
            };
            var _local_1:int = 4;
            var _local_2:int;
            while (_local_2 < _local_1)
            {
                if (pendingLoginSceneAni.length == 0)
                {
                    pendingLoginSceneAni = null;
                    return;
                };
                _local_3 = pendingLoginSceneAni.pop();
                _local_3.play();
                _local_2++;
            };
        }

        public function refreshWall():void
        {
            var _local_1:BuildingSpace = getSpaceByPosId(-2);
            if (_local_1 == null)
            {
                return;
            };
            _local_1.stopAndRemoveNormalAnimation();
            _local_1.playNormalAnimtion();
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
            var _local_5:Array;
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_CREATED, onNewBuildingCreated);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_DESTROY, onBuildingDestroy);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_UPDATE, onBuildingUpdate);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_COMPLETE, onBuildingComplete);
            MsgDispacther.getInstance().addEventListener(Context.EVENT_CASTLE_CHANGE, onCurCastleChange);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_QUEUE_UPDATE, onBuildingQueueUpdate);
            MsgDispacther.getInstance().addEventListener(EVENT_BUILDING_QUEUE_REMOVED, onBuildingQueueRemoved);
            var _local_2:BuildingSpace;
            _local_2 = new BuildingSpace(this);
            _local_2.childIndex = 0;
            _local_2.x = _arg_1[33].x;
            _local_2.y = _arg_1[33].y;
            _local_2.setPositionId(unMapPos(33));
            _local_2.addEventListener(BuildingSpace.PLAY_LOGINSCENE_OVER, onWallLoginSceneOver);
            spaceList.push(_local_2);
            var _local_3:int;
            while (_local_3 < 33)
            {
                _local_2 = new BuildingSpace(this);
                _local_2.childIndex = (_local_3 + 1);
                _local_2.x = _arg_1[_local_3].x;
                _local_2.y = _arg_1[_local_3].y;
                _local_2.setPositionId(unMapPos(_local_3));
                spaceList.push(_local_2);
                _local_2.addEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLastFrameOfSpace);
                _local_3++;
            };
            this.curCastle = Context.getInstance().getCurCastle();
            refresh();
            var _local_4:SharedObject = SharedObject.getLocal("skipAnimation", "/");
            if (((_local_4.data.value == true) || (Context.getInstance().needUserGuide)))
            {
                playNormalAnimation();
                adjustCocurrent();
                if (Context.getInstance().bVisitor == false)
                {
                    MainWin.instance.allWindowsFrame.visible = true;
                    if (Context.getInstance().fbType == "fbUprising")
                    {
                        _local_5 = setXYArray(Context.getInstance().taskXY);
                        AddArmyWin.show(int(Context.getInstance().taskId), _local_5[0], _local_5[1]);
                    };
                };
            }
            else
            {
                spaceList[0].playLoginScene(3);
                spaceList[0].play();
            };
            if ((((_local_4.data.value == true) && (!(Context.getInstance().bVisitor))) && (!(Context.getInstance().needUserGuide))))
            {
                RandomEventWin.show(1);
            };
            if (((Context.getInstance().needUserGuide) && (Context.getInstance().bVisitor == false)))
            {
                MainWin.instance.allWindowsFrame.visible = false;
                if (GuideStep.getInstance().currentStep == 1000)
                {
                    GuideStep.getInstance().step1000();
                };
            };
        }

        private function unMapPos(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (0);
                case 1:
                    return (1);
                case 2:
                    return (2);
                case 6:
                    return (3);
                case 7:
                    return (4);
                case 8:
                    return (5);
                case 13:
                    return (6);
                case 17:
                    return (7);
                case 21:
                    return (8);
                case 22:
                    return (9);
                case 23:
                    return (10);
                case 27:
                    return (11);
                case 28:
                    return (12);
                case 29:
                    return (13);
                case 3:
                    return (14);
                case 4:
                    return (15);
                case 5:
                    return (16);
                case 9:
                    return (17);
                case 10:
                    return (18);
                case 11:
                    return (19);
                case 14:
                    return (20);
                case 15:
                    return (21);
                case 16:
                    return (22);
                case 18:
                    return (23);
                case 19:
                    return (24);
                case 20:
                    return (25);
                case 24:
                    return (26);
                case 25:
                    return (27);
                case 26:
                    return (28);
                case 30:
                    return (29);
                case 31:
                    return (30);
                case 32:
                    return (31);
                case 12:
                    return (-1);
                case 33:
                    return (-2);
            };
            return (-1);
        }

        private function createComplete(_arg_1:Event):void
        {
            if (Context.getInstance().needUserGuide)
            {
                MainFrame.instance.doRestore();
            };
        }

        public function clickHandle():void
        {
            if (!this.initialized)
            {
                return;
            };
            if (!isPlayingLoginScene())
            {
                return;
            };
            playNormalAnimation();
            RandomEventWin.show(1);
            bSkip = true;
            if (MainWin.instance != null)
            {
                MainWin.instance.skip_btn.visible = false;
                MainWin.instance.hideTimerOut();
                if (Context.getInstance().needUserGuide)
                {
                    MainWin.instance.SkipTutorialBtn.visible = true;
                };
            };
            if (!Context.getInstance().needUserGuide)
            {
                if (Context.getInstance().bVisitor == false)
                {
                    MainWin.instance.allWindowsFrame.visible = true;
                };
            };
        }

        private function findPos(_arg_1:int, _arg_2:int):int
        {
            var _local_3:int = -1;
            var _local_4:int;
            while (_local_4 < spaceList.length)
            {
                if (spaceList[_local_4].bean != null)
                {
                    if (((spaceList[_local_4].bean.typeId == _arg_1) && (spaceList[_local_4].bean.level == _arg_2)))
                    {
                        _local_3 = _local_4;
                        break;
                    };
                };
                _local_4++;
            };
            return (_local_3);
        }

        private function onBuildingUpdate(_arg_1:BuildingChangeEvent):void
        {
            var _local_2:BuildingSpace = getSpaceByPosId(_arg_1.getBean().positionId);
            _local_2.setBean(_arg_1.getBean());
            _local_2.updateConstructPercent(100);
        }

        private function mapPos(_arg_1:int):int
        {
            switch (_arg_1)
            {
                case 0:
                    return (0);
                case 1:
                    return (1);
                case 2:
                    return (2);
                case 3:
                    return (6);
                case 4:
                    return (7);
                case 5:
                    return (8);
                case 6:
                    return (13);
                case 7:
                    return (17);
                case 8:
                    return (21);
                case 9:
                    return (22);
                case 10:
                    return (23);
                case 11:
                    return (27);
                case 12:
                    return (28);
                case 13:
                    return (29);
                case 14:
                    return (3);
                case 15:
                    return (4);
                case 16:
                    return (5);
                case 17:
                    return (9);
                case 18:
                    return (10);
                case 19:
                    return (11);
                case 20:
                    return (14);
                case 21:
                    return (15);
                case 22:
                    return (16);
                case 23:
                    return (18);
                case 24:
                    return (19);
                case 25:
                    return (20);
                case 26:
                    return (24);
                case 27:
                    return (25);
                case 28:
                    return (26);
                case 29:
                    return (30);
                case 30:
                    return (31);
                case 31:
                    return (32);
                case -1:
                    return (12);
                case -2:
                    return (33);
            };
            return (-1);
        }

        public function restorePlayAll():void
        {
            if (!this.initialized)
            {
                return;
            };
            if (!isNormalScene)
            {
                return;
            };
            if (!isPlayingLoginScene())
            {
                adjustCocurrent();
            };
        }

        public function isPlayingLoginScene():Boolean
        {
            var _local_2:BuildingSpace;
            var _local_1:int;
            while (_local_1 < spaceList.length)
            {
                _local_2 = (spaceList[_local_1] as BuildingSpace);
                if (_local_2.isPlayingLoginScene())
                {
                    return (true);
                };
                _local_1++;
            };
            return (false);
        }

        private function onOtherLoginSceneOver(_arg_1:Event):void
        {
            if (!this.isPlayingLoginScene())
            {
                isNormalScene = true;
                onBlurOutEnd(null);
            }
            else
            {
                playNextLoginScene();
            };
        }

        private function onBuildingQueueRemoved(_arg_1:BuildingChangeEvent):void
        {
            var _local_4:BuildingBean;
            if (_arg_1.getQueueBean() == null)
            {
                return;
            };
            if (!UIUtil.isInnerBuilding(_arg_1.getQueueBean().positionId))
            {
                return;
            };
            var _local_2:int = mapPos(_arg_1.getQueueBean().positionId);
            if (_local_2 == 33)
            {
                _local_2 = 0;
            }
            else
            {
                _local_2 = (_local_2 + 1);
            };
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

        public function stopPlayAll():void
        {
            var _local_2:BuildingSpace;
            if (!isNormalScene)
            {
                return;
            };
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

        private function setGuideArrow(_arg_1:String, _arg_2:Number, _arg_3:Number):void
        {
            guideArrow = new GuideArrow();
            guideArrow.type = _arg_1;
            guideArrow.x = _arg_2;
            guideArrow.y = _arg_3;
            this.addChild(guideArrow);
        }

        protected function refresh():void
        {
            var _local_1:BuildingBean;
            var _local_2:BuildingQueueBean;
            var _local_3:int;
            var _local_4:int;
            var _local_5:BuildingBean;
            var _local_6:BuildingBean;
            if (curCastle == null)
            {
                return;
            };
            for each (_local_1 in curCastle.buildingsArray)
            {
                if (UIUtil.isInnerBuilding(_local_1.positionId))
                {
                    _local_3 = mapPos(_local_1.positionId);
                    if (_local_3 == 33)
                    {
                        _local_3 = 0;
                    }
                    else
                    {
                        _local_3 = (_local_3 + 1);
                    };
                    spaceList[_local_3].setBean(_local_1);
                };
            };
            for each (_local_2 in curCastle.buildingQueuesArray)
            {
                if (UIUtil.isInnerBuilding(_local_2.positionId))
                {
                    _local_4 = mapPos(_local_2.positionId);
                    if (_local_4 == 33)
                    {
                        _local_4 = 0;
                    }
                    else
                    {
                        _local_4 = (_local_4 + 1);
                    };
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

        private function onGuideChange(_arg_1:GuideStepChangeEvent):void
        {
            var _local_2:int;
            if (((!(guideArrow == null)) && (guideArrow.visible)))
            {
                this.removeChild(guideArrow);
                guideArrow = null;
            };
            switch (_arg_1.currentStep)
            {
                case 10101:
                    this.setGuideArrow("buildGuideArrow", (spaceList[14].x + 90), spaceList[14].y);
                    return;
                case 401:
                    _local_2 = findPos(BuildingConstants.TYPE_HOUSE, 1);
                    if (_local_2 != -1)
                    {
                        this.setGuideArrow("arrowLGuide", (spaceList[_local_2].x + 90), spaceList[_local_2].y);
                        guideArrow.visible = false;
                    };
                    return;
                case 9001:
                    this.setGuideArrow("buildGuideArrow", (spaceList[15].x + 90), spaceList[15].y);
                    return;
                case 10001:
                    this.setGuideArrow("buildGuideArrow", (spaceList[18].x + 90), spaceList[18].y);
                    return;
                case 110:
                    _local_2 = findPos(BuildingConstants.TYPE_TAVERN, 1);
                    if (_local_2 != -1)
                    {
                        this.setGuideArrow("arrowLGuide", (spaceList[_local_2].x + 90), spaceList[_local_2].y);
                    };
                    return;
                case 120:
                    _local_2 = findPos(BuildingConstants.TYPE_HEROS_MANSION, 1);
                    if (_local_2 != -1)
                    {
                        this.setGuideArrow("arrowLGuide", (spaceList[_local_2].x + 90), spaceList[_local_2].y);
                    };
                    return;
                case 150:
                    this.setGuideArrow("arrowRGuide", 1312, 558);
                    return;
            };
        }

        private function onMouseWheel(_arg_1:MouseEvent):void
        {
            if (MainFrame.instance != null)
            {
                MainFrame.instance.onMouseWheel(_arg_1);
            };
        }

        private function onLastFrameOfSpace(_arg_1:Event):void
        {
            var _local_2:BuildingSpace = (_arg_1.target as BuildingSpace);
            if (_local_2 != null)
            {
                _local_2.stop();
                adjustCocurrent();
            };
        }

        private function clickStar():void
        {
            this.img.visible = false;
            this.removeChild(img);
        }


    }
}//package view.castle

