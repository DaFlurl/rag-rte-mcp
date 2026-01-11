// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.castle.building.BuildingSpace

package view.castle.building
{
    import flash.events.EventDispatcher;
    import com.evony.util.EvonyAnimation;
    import mx.core.UIComponent;
    import com.evony.common.beans.BuildingBean;
    import com.evony.factory.UIFactory;
    import com.evony.Context;
    import com.evony.common.constants.BuildingConstants;
    import view.AllWindows;
    import view.module.barrack.Barrack;
    import view.module.warehouse.WareHouse;
    import view.module.workshop.Workshop;
    import view.module.tavern.Tavern;
    import view.module.market.Market;
    import view.module.technology.Technology;
    import view.module.herosMansion.HerosMansion;
    import view.module.embassy.Embassy;
    import view.module.trainningField.TrainningField;
    import view.module.office.Office;
    import view.module.wall.Wall;
    import view.castle.MainFrame;
    import flash.events.MouseEvent;
    import mx.collections.ArrayCollection;
    import com.evony.util.ResourceLoader;
    import view.castle.MainFramePlayerBuff;
    import com.evony.common.beans.BuffBean;
    import flash.utils.setTimeout;
    import flash.events.Event;
    import view.castle.NewWallBuilding;
    import com.evony.MsgDispacther;
    import com.evony.events.OpenNewBuildingWindowEvent;
    import view.castle.NewInnerBuilding;
    import view.castle.NewOutsideBuilding;
    import mx.managers.PopUpManager;
    import flash.events.*;
    import flash.utils.*;

    public class BuildingSpace extends EventDispatcher 
    {

        public static const PLAY_LOGINSCENE_OVER:String = "BuildingSpace_PlayLoginScene_finished";

        public var y:Number = 0;
        private var isMoveOver:Boolean = false;
        private var constructFront:EvonyAnimation = null;
        public var childIndex:int = 0;
        private var mc:EvonyAnimation = null;
        private var tooltipsShown:Boolean = false;
        public var height:Number = 0;
        private var iOldX:Number = 0;
        private var parent:UIComponent = null;
        public var positionId:int;
        public var bean:BuildingBean = null;
        private var currentLoginSceneMc:EvonyAnimation = null;
        private var bPlayingLoginScene:Boolean = false;
        public var width:Number = 0;
        private var loginSceneDuration:Number = 0;
        private var constructBack:EvonyAnimation = null;
        public var visible:Boolean = true;
        public var x:Number = 0;
        public var isCityView:Boolean = false;

        private var spaceTooltip:SpaceTooltip = UIFactory.getInstance().getSpaceTooltip();
        private var buildingTooltip:BuildingTooltip = UIFactory.getInstance().getBuildingTooltip();
        private var mcHammerIn:EvonyAnimation = UIFactory.getInstance().getBuildingHammerMovie();
        private var lvlPic:BuildingLevelUC = new BuildingLevelUC();

        public function BuildingSpace(_arg_1:UIComponent)
        {
            parent = _arg_1;
        }

        public static function showBuildingWindows(_arg_1:BuildingBean):void
        {
            if (Context.getInstance().bVisitor)
            {
                return;
            };
            if (_arg_1.typeId == BuildingConstants.TYPE_BARRACK)
            {
                AllWindows.switchToBuildingWindow(Barrack.EVENT_SHOW, _arg_1);
            }
            else
            {
                if (_arg_1.typeId == BuildingConstants.TYPE_WAREHOUSE)
                {
                    AllWindows.switchToBuildingWindow(WareHouse.EVENT_SHOW, _arg_1);
                }
                else
                {
                    if (_arg_1.typeId == BuildingConstants.TYPE_WORKSHOP)
                    {
                        AllWindows.switchToBuildingWindow(Workshop.EVENT_SHOW, _arg_1);
                    }
                    else
                    {
                        if (_arg_1.typeId == BuildingConstants.TYPE_TAVERN)
                        {
                            AllWindows.switchToBuildingWindow(Tavern.EVENT_SHOW, _arg_1);
                        }
                        else
                        {
                            if (_arg_1.typeId == BuildingConstants.TYPE_MARKET)
                            {
                                AllWindows.switchToBuildingWindow(Market.EVENT_SHOW, _arg_1);
                            }
                            else
                            {
                                if (_arg_1.typeId == BuildingConstants.TYPE_ACADEMY)
                                {
                                    AllWindows.switchToBuildingWindow(Technology.EVENT_SHOW, _arg_1);
                                }
                                else
                                {
                                    if (_arg_1.typeId == BuildingConstants.TYPE_HEROS_MANSION)
                                    {
                                        AllWindows.switchToBuildingWindow(HerosMansion.EVENT_SHOW, _arg_1);
                                    }
                                    else
                                    {
                                        if (_arg_1.typeId == BuildingConstants.TYPE_EMBASSY)
                                        {
                                            AllWindows.switchToBuildingWindow(Embassy.EVENT_SHOW, _arg_1);
                                        }
                                        else
                                        {
                                            if (_arg_1.typeId == BuildingConstants.TYPE_TRAINNING_FEILD)
                                            {
                                                AllWindows.switchToBuildingWindow(TrainningField.EVENT_SHOW, _arg_1);
                                            }
                                            else
                                            {
                                                if (_arg_1.typeId == BuildingConstants.TYPE_TOWN_HALL)
                                                {
                                                    AllWindows.switchToBuildingWindow(Office.EVENT_SHOW, _arg_1);
                                                }
                                                else
                                                {
                                                    if (_arg_1.typeId == BuildingConstants.TYPE_WALL)
                                                    {
                                                        AllWindows.switchToBuildingWindow(Wall.EVENT_SHOW, _arg_1);
                                                    }
                                                    else
                                                    {
                                                        if ((((((_arg_1.typeId == BuildingConstants.TYPE_HOUSE) || (_arg_1.typeId == BuildingConstants.TYPE_STABLE)) || (_arg_1.typeId == BuildingConstants.TYPE_BLACKSMITH)) || (_arg_1.typeId == BuildingConstants.TYPE_TRANSPORT_STATION)) || (_arg_1.typeId == BuildingConstants.TYPE_SENTRY_BUILDING)))
                                                        {
                                                            AllWindows.switchToBuildingWindow("", _arg_1);
                                                        }
                                                        else
                                                        {
                                                            AllWindows.switchToBuildingWindow("", _arg_1);
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }


        private function downClick(_arg_1:MouseEvent):void
        {
            iOldX = MainFrame.instance.townView.x;
            if (((!(MainFrame.instance.cityView == null)) && (MainFrame.instance.cityView.isShow == true)))
            {
                iOldX = MainFrame.instance.cityView.x;
            };
        }

        public function playNormalAnimtion():void
        {
            var _local_4:ArrayCollection;
            var _local_5:int;
            var _local_6:Number;
            var _local_7:int;
            if (!this.visible)
            {
                return;
            };
            var _local_1:int;
            stopAndRemoveLoginScene();
            if (this.mc == null)
            {
                this.mc = new EvonyAnimation();
                this.parent.addChild(this.mc);
            };
            this.mc.x = this.x;
            this.mc.y = this.y;
            stopAndRemoveNormalAnimation();
            if (this.bean == null)
            {
                if (this.parent.contains(this.lvlPic))
                {
                    this.parent.removeChild(this.lvlPic);
                };
                if (this.getPositionId() == -2)
                {
                    _local_1 = EvonyAnimation.TYPE_WallCLv1;
                    this.mc = createEvonyAnimation(_local_1, this.positionId, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                }
                else
                {
                    if (isCityView)
                    {
                        _local_1 = EvonyAnimation.TYPE_OuterSpace;
                        this.mc = createEvonyAnimation(_local_1, this.positionId, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                    }
                    else
                    {
                        _local_1 = EvonyAnimation.TYPE_LOZENGE_BIG;
                        this.mc = createEvonyAnimation(_local_1, this.positionId, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                        this.mc.x = (this.x - 110);
                        this.mc.y = (this.y - 55);
                    };
                };
                addAnimationEffect(this.mc);
                return;
            };
            if (!this.parent.contains(this.lvlPic))
            {
                addChildByPos(this.lvlPic, 1);
                lvlPic.x = this.x;
                lvlPic.y = this.y;
                if (positionId == -2)
                {
                    lvlPic.x = (lvlPic.x + 548);
                    lvlPic.y = (lvlPic.y + -254);
                };
            };
            if (this.bean.status == BuildingConstants.STATUS_WAITING)
            {
                _local_1 = EvonyAnimation.getAniIdFromCityAndTownBuildingType(bean.typeId, BuildingConstants.STATUS_NORMAL, bean.level, bean.appearance);
            }
            else
            {
                _local_1 = EvonyAnimation.getAniIdFromCityAndTownBuildingType(bean.typeId, bean.status, bean.level, bean.appearance);
            };
            if (BuildingConstants.TYPE_WALL == bean.typeId)
            {
                if (((MainFramePlayerBuff.instance) && (MainFramePlayerBuff.instance.bar)))
                {
                    _local_4 = MainFramePlayerBuff.instance.bar.buffsArray;
                    _local_5 = 0;
                    while (_local_5 < _local_4.length)
                    {
                        if (((BuffBean(_local_4[_local_5]).typeId == "HauntedCastleBuf") || (BuffBean(_local_4[_local_5]).typeId == "HauntedCastleAdvBuf")))
                        {
                            this.mc.name = "hallowStyle";
                            _local_1 = 266;
                            break;
                        };
                        _local_5++;
                    };
                };
            };
            var _local_2:Number = 0;
            var _local_3:Boolean;
            if (((!(bean.status == BuildingConstants.STATUS_NORMAL)) && (!(this.bean.status == BuildingConstants.STATUS_WAITING))))
            {
                _local_6 = new Date().valueOf();
                _local_7 = Context.getInstance().getTimeDiff();
                _local_2 = (((bean.endTime + _local_7) - _local_6) / 1000);
            };
            if (bean.status == BuildingConstants.STATUS_DESTRUCTING)
            {
                _local_3 = true;
            };
            if (bean.status != BuildingConstants.STATUS_NORMAL)
            {
                if (bean.typeId == BuildingConstants.TYPE_WALL)
                {
                    if (constructFront == null)
                    {
                        constructFront = new EvonyAnimation();
                        constructFront.load(EvonyAnimation.TYPE_WallWorker, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                    };
                    if (constructBack == null)
                    {
                        constructBack = new EvonyAnimation();
                        constructBack.load(EvonyAnimation.TYPE_WallWorker, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                    };
                }
                else
                {
                    if (bean.typeId != BuildingConstants.TYPE_TOWN_HALL)
                    {
                        constructFront = new EvonyAnimation();
                        constructFront.load(EvonyAnimation.TYPE_constructFrontUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                        constructBack = new EvonyAnimation();
                        constructBack.load(EvonyAnimation.TYPE_constructBackUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
                    }
                    else
                    {
                        constructFront = UIFactory.getInstance().getTownHallConstructFrontUp();
                        constructBack = UIFactory.getInstance().getTownHallConstructBackUp();
                    };
                };
                constructFront.x = this.x;
                constructFront.y = this.y;
                constructBack.x = this.x;
                constructBack.y = this.y;
                if (bean.typeId == BuildingConstants.TYPE_WALL)
                {
                    constructFront.x = (this.x - 700);
                    constructFront.y = (this.y - 100);
                    constructBack.x = (this.x - 100);
                    constructBack.y = (this.y - 400);
                };
                constructBack.play();
                constructFront.play();
            };
            this.mc = createEvonyAnimation(_local_1, bean.positionId, ResourceLoader.LOAD_BACKGROUND_DEMAND, _local_2, _local_3, ((bean.status == BuildingConstants.STATUS_NORMAL) || (this.bean.status == BuildingConstants.STATUS_WAITING)));
            if (constructBack != null)
            {
                addChildByPos(constructBack, -1);
            };
            if (constructFront != null)
            {
                addChildByPos(constructFront, 1);
            };
            lvlPic.buildingBean = this.bean;
            addAnimationEffect(this.mc);
        }

        public function stop():void
        {
            if (!this.visible)
            {
                return;
            };
            if (((!(this.mc == null)) && (this.mc is EvonyAnimation)))
            {
                EvonyAnimation(this.mc).stop();
            }
            else
            {
                if (((!(this.currentLoginSceneMc == null)) && (this.currentLoginSceneMc is EvonyAnimation)))
                {
                    EvonyAnimation(this.currentLoginSceneMc).stop();
                };
            };
        }

        public function skipLoginScene():void
        {
            bPlayingLoginScene = false;
            playNormalAnimtion();
        }

        private function removeAnimationEffect(_arg_1:UIComponent):void
        {
            _arg_1.removeEventListener(MouseEvent.MOUSE_UP, onClick);
            _arg_1.removeEventListener(MouseEvent.ROLL_OUT, outHandler);
            _arg_1.removeEventListener(MouseEvent.ROLL_OVER, overHandler);
            _arg_1.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        private function playHammers():void
        {
            removeHammers();
            mcHammerIn.x = this.x;
            mcHammerIn.y = this.y;
            mcHammerIn.play();
            addChildByPos(mcHammerIn, 1);
        }

        public function getPositionId():int
        {
            return (positionId);
        }

        private function outHandler(_arg_1:MouseEvent):void
        {
            isMoveOver = false;
            removeHammers();
            removeTooltips();
            Context.getInstance().iCurrentBuilding = -1;
            _arg_1.updateAfterEvent();
        }

        public function setPositionId(_arg_1:int):void
        {
            positionId = _arg_1;
        }

        public function getBean():BuildingBean
        {
            return (this.bean);
        }

        public function play():void
        {
            if (!this.visible)
            {
                return;
            };
            if (((!(this.mc == null)) && (this.mc is EvonyAnimation)))
            {
                EvonyAnimation(this.mc).play();
            }
            else
            {
                if (((!(this.currentLoginSceneMc == null)) && (this.currentLoginSceneMc is EvonyAnimation)))
                {
                    if (this.currentLoginSceneMc.visible != true)
                    {
                        this.currentLoginSceneMc.visible = true;
                    };
                    EvonyAnimation(this.currentLoginSceneMc).play();
                };
            };
        }

        public function setBean(_arg_1:BuildingBean):void
        {
            if (((_arg_1 == null) || ((_arg_1.level == 0) && (_arg_1.status == BuildingConstants.STATUS_NORMAL))))
            {
                this.bean = null;
                lvlPic.buildingBean = null;
            }
            else
            {
                this.bean = _arg_1;
                if (lvlPic != null)
                {
                    lvlPic.buildingBean = this.bean;
                };
            };
        }

        private function onMouseMove(_arg_1:MouseEvent):void
        {
            if (this.bean == null)
            {
                this.spaceTooltip.x = (_arg_1.stageX + 20);
                this.spaceTooltip.y = (_arg_1.stageY + 10);
            }
            else
            {
                this.buildingTooltip.buildingBean = this.bean;
                this.buildingTooltip.x = (_arg_1.stageX + 20);
                this.buildingTooltip.y = (_arg_1.stageY + 10);
            };
            _arg_1.updateAfterEvent();
        }

        public function stopAndRemoveNormalAnimation():void
        {
            if (!this.visible)
            {
                return;
            };
            if (this.mc != null)
            {
                if (lvlPic != null)
                {
                    lvlPic.buildingBean = null;
                    if (this.parent.contains(lvlPic))
                    {
                        this.parent.removeChild(lvlPic);
                    };
                };
                if (constructFront != null)
                {
                    constructFront.gotoAndStop(true);
                    if (this.parent.contains(constructFront))
                    {
                        this.parent.removeChild(constructFront);
                    };
                    constructFront = null;
                };
                if (constructBack != null)
                {
                    constructBack.gotoAndStop(true);
                    if (this.parent.contains(constructBack))
                    {
                        this.parent.removeChild(constructBack);
                    };
                    constructBack = null;
                };
                destroyEvonyAnimation((this.mc as EvonyAnimation));
                removeAnimationEffect(this.mc);
            };
        }

        public function addChildByPos(_arg_1:UIComponent, _arg_2:int):void
        {
            var _local_3:int = -1;
            if (this.mc != null)
            {
                _local_3 = this.parent.getChildIndex(this.mc);
            };
            if (_local_3 < 0)
            {
                this.parent.addChild(_arg_1);
            }
            else
            {
                if (_arg_2 < 0)
                {
                    this.parent.addChildAt(_arg_1, _local_3);
                }
                else
                {
                    this.parent.addChildAt(_arg_1, (_local_3 + 1));
                };
            };
        }

        public function stopped():Boolean
        {
            if (!this.visible)
            {
                return (true);
            };
            if ((this.mc is EvonyAnimation))
            {
                return (EvonyAnimation(this.mc).stopped());
            };
            if (((!(this.currentLoginSceneMc == null)) && (this.currentLoginSceneMc is EvonyAnimation)))
            {
                return (EvonyAnimation(this.currentLoginSceneMc).stopped());
            };
            return (true);
        }

        private function removeHammers():void
        {
            if (this.parent.contains(mcHammerIn))
            {
                mcHammerIn.gotoAndStop(true);
                this.parent.removeChild(mcHammerIn);
            };
        }

        private function overHandler(_arg_1:MouseEvent):void
        {
            if (((this.bean == null) && (!(this.positionId == -2))))
            {
                if (!Context.getInstance().bVisitor)
                {
                    playHammers();
                    spaceTooltip.isInner = true;
                    Context.getInstance().iCurrentBuilding = -2;
                };
            }
            else
            {
                if (this.mc != null)
                {
                    removeHammers();
                    this.mc.alpha = 0.5;
                    Context.getInstance().iCurrentBuilding = ((this.bean == null) ? -2 : bean.positionId);
                };
            };
            isMoveOver = true;
            setTimeout(showTooltips, 200, _arg_1.stageX, _arg_1.stageY);
            _arg_1.updateAfterEvent();
        }

        public function updateConstructPercent(_arg_1:Number):void
        {
        }

        private function onLastFrame(_arg_1:Event):void
        {
            this.dispatchEvent(_arg_1);
        }

        private function addAnimationEffect(_arg_1:UIComponent):void
        {
            _arg_1.addEventListener(MouseEvent.MOUSE_DOWN, downClick);
            _arg_1.addEventListener(MouseEvent.MOUSE_UP, onClick);
            _arg_1.addEventListener(MouseEvent.ROLL_OUT, outHandler);
            _arg_1.addEventListener(MouseEvent.ROLL_OVER, overHandler);
            _arg_1.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        public function stopAndRemoveLoginScene():void
        {
            this.bPlayingLoginScene = false;
            if (!this.visible)
            {
                return;
            };
            if (currentLoginSceneMc != null)
            {
                currentLoginSceneMc.removeEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLoginSceneLastFrame);
                this.parent.removeChild(currentLoginSceneMc);
                currentLoginSceneMc.destroy();
                currentLoginSceneMc = null;
            };
        }

        private function onLoginSceneLastFrame(_arg_1:Event):void
        {
            var _local_2:EvonyAnimation;
            if (bPlayingLoginScene)
            {
                _local_2 = currentLoginSceneMc;
                _local_2.stop();
                bPlayingLoginScene = false;
                this.dispatchEvent(new Event(BuildingSpace.PLAY_LOGINSCENE_OVER));
            }
            else
            {
                if (((!(currentLoginSceneMc == null)) && (!(currentLoginSceneMc.stopped()))))
                {
                    currentLoginSceneMc.stop();
                };
            };
        }

        public function isPlayingLoginScene():Boolean
        {
            return (bPlayingLoginScene);
        }

        public function onClick(_arg_1:MouseEvent):void
        {
            if (MainFrame.instance.townView.isShow == true)
            {
                if (MainFrame.instance.townView.x != iOldX)
                {
                    iOldX = MainFrame.instance.townView.x;
                    return;
                };
            }
            else
            {
                if (((!(MainFrame.instance.cityView == null)) && (MainFrame.instance.cityView.isShow == true)))
                {
                    if (MainFrame.instance.cityView.x != iOldX)
                    {
                        return;
                    };
                };
            };
            if (this.bean == null)
            {
                if (Context.getInstance().bVisitor)
                {
                    return;
                };
                if (this.positionId == -2)
                {
                    AllWindows.switchToFuncWindow(NewWallBuilding.EVENT_SHOW);
                }
                else
                {
                    if (this.positionId < 32)
                    {
                        MsgDispacther.getInstance().dispatchEvent(new OpenNewBuildingWindowEvent(NewInnerBuilding.EVENT_SHOW, this.getPositionId()));
                    }
                    else
                    {
                        MsgDispacther.getInstance().dispatchEvent(new OpenNewBuildingWindowEvent(NewOutsideBuilding.EVENT_SHOW, this.getPositionId()));
                    };
                };
            }
            else
            {
                BuildingSpace.showBuildingWindows(this.bean);
            };
        }

        private function destroyEvonyAnimation(_arg_1:EvonyAnimation):void
        {
            _arg_1.removeEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLastFrame);
            _arg_1.destroy();
        }

        public function playLoginScene(_arg_1:int):void
        {
            if (((this.bean == null) && (!(this.positionId == -2))))
            {
                return;
            };
            bPlayingLoginScene = true;
            loginSceneDuration = _arg_1;
            var _local_2:int;
            if (((this.positionId == -2) && (this.bean == null)))
            {
                _local_2 = EvonyAnimation.getLoginAniIdFromTownBuildingType(BuildingConstants.TYPE_WALL, BuildingConstants.STATUS_NORMAL, 1, 0);
            }
            else
            {
                _local_2 = EvonyAnimation.getLoginAniIdFromTownBuildingType(bean.typeId, bean.status, bean.level, bean.appearance);
            };
            var _local_3:EvonyAnimation = new EvonyAnimation();
            currentLoginSceneMc = _local_3;
            _local_3.addEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLoginSceneLastFrame);
            _local_3.load(_local_2, this.childIndex, ResourceLoader.LOAD_BACKGROUND_DEMAND, _arg_1, false, true);
            _local_3.x = this.x;
            _local_3.y = this.y;
            _local_3.visible = false;
            this.parent.addChild(_local_3);
        }

        private function removeTooltips():void
        {
            PopUpManager.removePopUp(this.spaceTooltip);
            PopUpManager.removePopUp(this.buildingTooltip);
            if (this.mc != null)
            {
                this.mc.alpha = 1;
            };
            tooltipsShown = false;
        }

        private function showTooltips():void
        {
            if (!isMoveOver)
            {
                return;
            };
            var _local_2:int = arguments[0];
            var _local_3:int = arguments[1];
            if (tooltipsShown)
            {
                return;
            };
            if (this.bean == null)
            {
                this.spaceTooltip.x = _local_2;
                this.spaceTooltip.y = _local_3;
                PopUpManager.addPopUp(this.spaceTooltip, this.parent);
            }
            else
            {
                this.buildingTooltip.x = _local_2;
                this.buildingTooltip.y = _local_3;
                PopUpManager.addPopUp(this.buildingTooltip, this.parent);
            };
            tooltipsShown = true;
        }

        private function createEvonyAnimation(_arg_1:int, _arg_2:int, _arg_3:int=1, _arg_4:Number=0, _arg_5:Boolean=false, _arg_6:Boolean=false):EvonyAnimation
        {
            var _local_7:EvonyAnimation;
            _local_7 = (this.mc as EvonyAnimation);
            _local_7.addEventListener(EvonyAnimation.EVENT_LAST_FRAME, onLastFrame);
            _local_7.load(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
            return (_local_7);
        }


    }
}//package view.castle.building

