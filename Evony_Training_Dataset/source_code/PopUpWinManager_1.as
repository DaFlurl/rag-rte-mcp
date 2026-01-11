package autoevony.gui.controls.popup
{
   import autoevony.event.popUpWinShowEvent;
   import autoevony.gui.AlertWin;
   import autoevony.gui.ArmyDetailsWin;
   import autoevony.gui.heroview.ChooseHeroItemWin;
   import autoevony.gui.heroview.HeroViewWin;
   import autoevony.gui.heroview.HistHeroDescWin;
   import autoevony.gui.info.Alliance.AllianceInfoWin;
   import autoevony.gui.info.Alliance.AllianceInviteMemberWin;
   import autoevony.gui.info.Alliance.ChangeCovenanterWin;
   import autoevony.gui.info.Alliance.CheckApplyWin;
   import autoevony.gui.info.Alliance.EditIntroductionWin;
   import autoevony.gui.info.Alliance.ExpelMemberWin;
   import autoevony.gui.info.Alliance.MemberInfoWin;
   import autoevony.gui.info.Items.BuyItemWin;
   import autoevony.gui.info.Items.ItemViewWin;
   import autoevony.gui.newarmy.NewArmyWin;
   import flash.display.DisplayObject;
   import mx.core.IFlexDisplayObject;
   import mx.managers.PopUpManager;
   
   public class PopUpWinManager
   {
      private var parent:DisplayObject = null;
      
      public function PopUpWinManager(param1:DisplayObject)
      {
         super();
         this.parent = param1;
      }
      
      public static function bringToFrontAndCenter(param1:*) : void
      {
         PopUpManager.centerPopUp(param1);
         bringToFront(param1);
      }
      
      public static function bringToFront(param1:*) : void
      {
         PopUpManager.bringToFront(param1);
         param1.setFocus();
      }
      
      public function newPopUpWin(param1:popUpWinShowEvent) : void
      {
         this.openPopUp(param1);
      }
      
      private function openPopUp(param1:popUpWinShowEvent) : void
      {
         var _loc2_:* = null;
         if(param1.popUpType == popUpWinShowEvent.ALERT_WIN)
         {
            _loc2_ = new AlertWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.msg,param1.callBack,param1.yesBtnName,param1.noBtnName,param1.args,param1.winTitle,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ARMY_DETAILS_WIN)
         {
            _loc2_ = new ArmyDetailsWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,false);
            }
            _loc2_.updateInfo(param1.args,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.TRAINING_FIELD_WIN)
         {
            _loc2_ = new NewArmyWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,false);
            }
            _loc2_.updateInfo(this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.VIEW_ITEM_INFO_WIN)
         {
            _loc2_ = new ItemViewWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,false);
            }
            _loc2_.updateInfo(param1.args,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.BUY_ITEM_WIN)
         {
            _loc2_ = new BuyItemWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.args,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.HERO_MANAGEMENT_WIN)
         {
            _loc2_ = new HeroViewWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.args,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.HERO_DESC_WIN)
         {
            _loc2_ = new HistHeroDescWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.objParam,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.HERO_APPLY_ITEM_WIN)
         {
            _loc2_ = new ChooseHeroItemWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.winTitle,param1.objParam,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_INFO_WIN)
         {
            _loc2_ = new AllianceInfoWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.objParam,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_MEMBER_INFO)
         {
            _loc2_ = new MemberInfoWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.objParam,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_EXPEL_MEMBER)
         {
            _loc2_ = new ExpelMemberWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(param1.membersArray,this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_EDIT_INTRO)
         {
            _loc2_ = new EditIntroductionWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_INVITE_MEMBER)
         {
            _loc2_ = new AllianceInviteMemberWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_PENDING_APPLICATIONS)
         {
            _loc2_ = new CheckApplyWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(this.closePopUp);
         }
         else if(param1.popUpType == popUpWinShowEvent.ALLIANCE_CHANGE_HOST)
         {
            _loc2_ = new ChangeCovenanterWin();
            if(_loc2_.isPopUp)
            {
               PopUpManager.bringToFront(_loc2_);
            }
            else
            {
               PopUpManager.addPopUp(_loc2_,this.parent,true);
            }
            _loc2_.updateInfo(this.closePopUp);
         }
         PopUpManager.centerPopUp(_loc2_);
         PopUpManager.bringToFront(_loc2_);
         _loc2_.addEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW,this.newPopUpWin);
         _loc2_.setFocus();
      }
      
      private function closePopUp(param1:* = null) : void
      {
         param1.removeEventListener(popUpWinShowEvent.POP_UP_WIN_SHOW,this.newPopUpWin);
         PopUpManager.removePopUp(param1 as IFlexDisplayObject);
         param1 = null;
      }
   }
}

