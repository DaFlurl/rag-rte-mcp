// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//autoevony.gui.controls.popup.PopUpWinManager

package autoevony.gui.controls.popup
{
    import flash.display.DisplayObject;
    import mx.managers.PopUpManager;
    import autoevony.event.popUpWinShowEvent;
    import autoevony.gui.AlertWin;
    import autoevony.gui.ArmyDetailsWin;
    import autoevony.gui.newarmy.NewArmyWin;
    import autoevony.gui.info.Items.ItemViewWin;
    import autoevony.gui.info.Items.BuyItemWin;
    import autoevony.gui.heroview.HeroViewWin;
    import autoevony.gui.heroview.HistHeroDescWin;
    import autoevony.gui.heroview.ChooseHeroItemWin;
    import autoevony.gui.info.Alliance.AllianceInfoWin;
    import autoevony.gui.info.Alliance.MemberInfoWin;
    import autoevony.gui.info.Alliance.ExpelMemberWin;
    import autoevony.gui.info.Alliance.EditIntroductionWin;
    import autoevony.gui.info.Alliance.AllianceInviteMemberWin;
    import autoevony.gui.info.Alliance.CheckApplyWin;
    import autoevony.gui.info.Alliance.ChangeCovenanterWin;
    import mx.core.IFlexDisplayObject;

    public class PopUpWinManager 
    {

        private var parent:DisplayObject = null;

        public function PopUpWinManager(_arg_1:DisplayObject)
        {
            this.parent = _arg_1;
        }

        public static function bringToFrontAndCenter(_arg_1:*):void
        {
            PopUpManager.centerPopUp(_arg_1);
            bringToFront(_arg_1);
        }

        public static function bringToFront(_arg_1:*):void
        {
            PopUpManager.bringToFront(_arg_1);
            _arg_1.setFocus();
        }


        public function newPopUpWin(_arg_1:popUpWinShowEvent):void
        {
            this.openPopUp(_arg_1);
        }

        private function openPopUp(_arg_1:popUpWinShowEvent):void
        {
            var _local_2:* = null;
            if (_arg_1.popUpType == popUpWinShowEvent.ALERT_WIN)
            {
                if ((_local_2 = new AlertWin()).isPopUp)
                {
                    PopUpManager.bringToFront(_local_2);
                }
                else
                {
                    PopUpManager.addPopUp(_local_2, this.parent, true);
                };
                _local_2.updateInfo(_arg_1.msg, _arg_1.callBack, _arg_1.yesBtnName, _arg_1.noBtnName, _arg_1.args, _arg_1.winTitle, this.closePopUp);
            }
            else
            {
                if (_arg_1.popUpType == popUpWinShowEvent.ARMY_DETAILS_WIN)
                {
                    if ((_local_2 = new ArmyDetailsWin()).isPopUp)
                    {
                        PopUpManager.bringToFront(_local_2);
                    }
                    else
                    {
                        PopUpManager.addPopUp(_local_2, this.parent, false);
                    };
                    _local_2.updateInfo(_arg_1.args, this.closePopUp);
                }
                else
                {
                    if (_arg_1.popUpType == popUpWinShowEvent.TRAINING_FIELD_WIN)
                    {
                        if ((_local_2 = new NewArmyWin()).isPopUp)
                        {
                            PopUpManager.bringToFront(_local_2);
                        }
                        else
                        {
                            PopUpManager.addPopUp(_local_2, this.parent, false);
                        };
                        _local_2.updateInfo(this.closePopUp);
                    }
                    else
                    {
                        if (_arg_1.popUpType == popUpWinShowEvent.VIEW_ITEM_INFO_WIN)
                        {
                            if ((_local_2 = new ItemViewWin()).isPopUp)
                            {
                                PopUpManager.bringToFront(_local_2);
                            }
                            else
                            {
                                PopUpManager.addPopUp(_local_2, this.parent, false);
                            };
                            _local_2.updateInfo(_arg_1.args, this.closePopUp);
                        }
                        else
                        {
                            if (_arg_1.popUpType == popUpWinShowEvent.BUY_ITEM_WIN)
                            {
                                if ((_local_2 = new BuyItemWin()).isPopUp)
                                {
                                    PopUpManager.bringToFront(_local_2);
                                }
                                else
                                {
                                    PopUpManager.addPopUp(_local_2, this.parent, true);
                                };
                                _local_2.updateInfo(_arg_1.args, this.closePopUp);
                            }
                            else
                            {
                                if (_arg_1.popUpType == popUpWinShowEvent.HERO_MANAGEMENT_WIN)
                                {
                                    if ((_local_2 = new HeroViewWin()).isPopUp)
                                    {
                                        PopUpManager.bringToFront(_local_2);
                                    }
                                    else
                                    {
                                        PopUpManager.addPopUp(_local_2, this.parent, true);
                                    };
                                    _local_2.updateInfo(_arg_1.args, this.closePopUp);
                                }
                                else
                                {
                                    if (_arg_1.popUpType == popUpWinShowEvent.HERO_DESC_WIN)
                                    {
                                        if ((_local_2 = new HistHeroDescWin()).isPopUp)
                                        {
                                            PopUpManager.bringToFront(_local_2);
                                        }
                                        else
                                        {
                                            PopUpManager.addPopUp(_local_2, this.parent, true);
                                        };
                                        _local_2.updateInfo(_arg_1.objParam, this.closePopUp);
                                    }
                                    else
                                    {
                                        if (_arg_1.popUpType == popUpWinShowEvent.HERO_APPLY_ITEM_WIN)
                                        {
                                            if ((_local_2 = new ChooseHeroItemWin()).isPopUp)
                                            {
                                                PopUpManager.bringToFront(_local_2);
                                            }
                                            else
                                            {
                                                PopUpManager.addPopUp(_local_2, this.parent, true);
                                            };
                                            _local_2.updateInfo(_arg_1.winTitle, _arg_1.objParam, this.closePopUp);
                                        }
                                        else
                                        {
                                            if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_INFO_WIN)
                                            {
                                                if ((_local_2 = new AllianceInfoWin()).isPopUp)
                                                {
                                                    PopUpManager.bringToFront(_local_2);
                                                }
                                                else
                                                {
                                                    PopUpManager.addPopUp(_local_2, this.parent, true);
                                                };
                                                _local_2.updateInfo(_arg_1.objParam, this.closePopUp);
                                            }
                                            else
                                            {
                                                if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_MEMBER_INFO)
                                                {
                                                    if ((_local_2 = new MemberInfoWin()).isPopUp)
                                                    {
                                                        PopUpManager.bringToFront(_local_2);
                                                    }
                                                    else
                                                    {
                                                        PopUpManager.addPopUp(_local_2, this.parent, true);
                                                    };
                                                    _local_2.updateInfo(_arg_1.objParam, this.closePopUp);
                                                }
                                                else
                                                {
                                                    if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_EXPEL_MEMBER)
                                                    {
                                                        if ((_local_2 = new ExpelMemberWin()).isPopUp)
                                                        {
                                                            PopUpManager.bringToFront(_local_2);
                                                        }
                                                        else
                                                        {
                                                            PopUpManager.addPopUp(_local_2, this.parent, true);
                                                        };
                                                        _local_2.updateInfo(_arg_1.membersArray, this.closePopUp);
                                                    }
                                                    else
                                                    {
                                                        if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_EDIT_INTRO)
                                                        {
                                                            if ((_local_2 = new EditIntroductionWin()).isPopUp)
                                                            {
                                                                PopUpManager.bringToFront(_local_2);
                                                            }
                                                            else
                                                            {
                                                                PopUpManager.addPopUp(_local_2, this.parent, true);
                                                            };
                                                            _local_2.updateInfo(this.closePopUp);
                                                        }
                                                        else
                                                        {
                                                            if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_INVITE_MEMBER)
                                                            {
                                                                if ((_local_2 = new AllianceInviteMemberWin()).isPopUp)
                                                                {
                                                                    PopUpManager.bringToFront(_local_2);
                                                                }
                                                                else
                                                                {
                                                                    PopUpManager.addPopUp(_local_2, this.parent, true);
                                                                };
                                                                _local_2.updateInfo(this.closePopUp);
                                                            }
                                                            else
                                                            {
                                                                if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_PENDING_APPLICATIONS)
                                                                {
                                                                    if ((_local_2 = new CheckApplyWin()).isPopUp)
                                                                    {
                                                                        PopUpManager.bringToFront(_local_2);
                                                                    }
                                                                    else
                                                                    {
                                                                        PopUpManager.addPopUp(_local_2, this.parent, true);
                                                                    };
                                                                    _local_2.updateInfo(this.closePopUp);
                                                                }
                                                                else
                                                                {
                                                                    if (_arg_1.popUpType == popUpWinShowEvent.ALLIANCE_CHANGE_HOST)
                                                                    {
                                                                        if ((_local_2 = new ChangeCovenanterWin()).isPopUp)
                                                                        {
                                                                            PopUpManager.bringToFront(_local_2);
                                                                        }
                                                                        else
                                                                        {
                                                                            PopUpManager.addPopUp(_local_2, this.parent, true);
                                                                        };
                                                                        _local_2.updateInfo(this.closePopUp);
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
                    };
                };
            };
            PopUpManager.centerPopUp(_local_2);
            PopUpManager.bringToFront(_local_2);
            _local_2.addEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW, this.newPopUpWin);
            _local_2.setFocus();
        }

        private function closePopUp(_arg_1:*=null):void
        {
            _arg_1.removeEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW, this.newPopUpWin);
            PopUpManager.removePopUp((_arg_1 as IFlexDisplayObject));
            _arg_1 = null;
        }


    }
}//package autoevony.gui.controls.popup

