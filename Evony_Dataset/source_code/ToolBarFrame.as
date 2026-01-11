// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.ToolBarFrame

package view
{
    import mx.containers.Canvas;
    import mx.core.UIComponentDescriptor;
    import com.evony.Context;
    import com.evony.MsgDispacther;
    import flash.utils.Timer;
    import mx.core.mx_internal;
    import mx.styles.CSSStyleDeclaration;
    import flash.events.Event;
    import flash.display.MovieClip;
    import com.evony.common.server.events.FriendArmysUpdate;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import com.evony.GameConfig;
    import mx.events.FlexEvent;
    import com.evony.client.response.ResponseDispatcher;
    import flash.events.TimerEvent;
    import view.module.info.InfoWin;
    import view.module.rank.RankWin;
    import com.evony.common.beans.ArmyBean;
    import view.castle.TownView;
    import view.module.shop.ShopWin;
    import view.module.alliance.AllianceWin;
    import mx.events.PropertyChangeEvent;
    import com.evony.events.HasQuestEvent;
    import view.module.mail.MailWin;
    import com.evony.common.server.events.EnemyArmysUpdate;
    import com.evony.common.server.events.NewReport;
    import com.evony.common.server.events.NewMail;
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

    public class ToolBarFrame extends Canvas 
    {

        public static const HAS_TASK_SUCCESS:String = "hasTaskSuccess";
        public static var instance:ToolBarFrame;

        public var hasNewReport:Boolean = false;
        public var hasNewMail:Boolean = false;
        public var hasEnemy:Boolean = false;
        private var _1505671950newRedReportNumber:int;

        private var _documentDescriptor_:UIComponentDescriptor = new UIComponentDescriptor({"type":Canvas});
        private var context:Context = Context.getInstance();
        private var msgDispatcher:MsgDispacther = MsgDispacther.getInstance();
        private var delayRefreshReport:Timer = new Timer(5000);

        public function ToolBarFrame()
        {
            super();
            mx_internal::_document = this;
            if (!this.styleDeclaration)
            {
                this.styleDeclaration = new CSSStyleDeclaration();
            };
            this.styleDeclaration.defaultFactory = function ():void
            {
                this.backgroundAlpha = 0;
            };
            this.addEventListener("creationComplete", ___ToolBarFrame_Canvas1_creationComplete);
        }

        private function onHelpUrlClick():void
        {
        }

        private function delayCheckEnemy(_arg_1:Event):void
        {
            this.delayRefreshReport.stop();
            this.delayRefreshReport = null;
            this.checkEnemy();
        }

        private function btnMouseUp(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop("up");
        }

        public function onFriendArmysUpdate(_arg_1:FriendArmysUpdate):void
        {
            if (_arg_1.armysArray.length > 0)
            {
                this.hasNewReport = true;
                this.refreshLogo();
            };
        }

        private function onForumUrlClick():void
        {
            navigateToURL(new URLRequest(GameConfig.instance.forum), "_blank");
        }

        override public function initialize():void
        {
            (mx_internal::setDocumentDescriptor(_documentDescriptor_));
            super.initialize();
        }

        public function ___ToolBarFrame_Canvas1_creationComplete(_arg_1:FlexEvent):void
        {
            init();
        }

        [Bindable(event="propertyChange")]
        private function get newRedReportNumber():int
        {
            return (this._1505671950newRedReportNumber);
        }

        private function init():void
        {
            instance = this;
            var _local_1:ResponseDispatcher = ResponseDispatcher.getInstance();
            _local_1.addEventListener(ResponseDispatcher.SERVER_NEW_MAIL, onHasNewMail);
            _local_1.addEventListener(ResponseDispatcher.SERVER_ENEMY_ARMYS_UPDATE, onEnemyArmysUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_FRIEND_ARMYS_UPDATE, onFriendArmysUpdate);
            _local_1.addEventListener(ResponseDispatcher.SERVER_NEW_REPORT, onHasNewReport);
            msgDispatcher.addEventListener("CheckEnemy", reCheckEnemy);
            if (context.getPlayerBean().friendArmysArray.length > 0)
            {
                this.hasNewReport = true;
            };
            this.checkEnemy();
            if (this.delayRefreshReport != null)
            {
                this.delayRefreshReport.addEventListener(TimerEvent.TIMER, delayCheckEnemy);
                this.delayRefreshReport.start();
            };
        }

        private function onInfoBtnClick():void
        {
            AllWindows.switchToFuncWindow(InfoWin.EVENT_SHOW);
            this.hasNewReport = false;
            this.refreshLogo();
        }

        private function onRankBtnClick():void
        {
            AllWindows.switchToFuncWindow(RankWin.EVENT_SHOW);
        }

        private function checkEnemy():void
        {
            var _local_2:ArmyBean;
            this.hasEnemy = false;
            var _local_1:int;
            while (_local_1 < context.getPlayerBean().enemyArmysArray.length)
            {
                _local_2 = context.getPlayerBean().enemyArmysArray[_local_1];
                if (!_local_2.selected)
                {
                    this.hasEnemy = true;
                    break;
                };
                _local_1++;
            };
            this.refreshLogo();
            TownView.handleUnderAttack();
        }

        private function onShopBtnClick():void
        {
            AllWindows.switchToFuncWindow(ShopWin.EVENT_SHOW);
        }

        private function onAllianceBtnClick():void
        {
            AllWindows.switchToFuncWindow(AllianceWin.EVENT_SHOW);
        }

        private function set newRedReportNumber(_arg_1:int):void
        {
            var _local_2:Object = this._1505671950newRedReportNumber;
            if (_local_2 !== _arg_1)
            {
                this._1505671950newRedReportNumber = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "newRedReportNumber", _local_2, _arg_1));
            };
        }

        private function btnMouseOver(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop("up");
        }

        private function btnMouseOut(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop("over");
        }

        private function refreshLogo():void
        {
            if (MainWin.instance != null)
            {
                if (this.hasEnemy)
                {
                    MainWin.instance.report.visible = true;
                }
                else
                {
                    MainWin.instance.report.visible = false;
                };
            };
        }

        public function onHasTask(_arg_1:HasQuestEvent):void
        {
            if (_arg_1.isHasQuest)
            {
                MainWin.instance.setMyQuestBtnTooltipVisible(true);
            };
            MainWin.instance.newQuestNumber = _arg_1.jobDone;
            if (MainWin.instance.newQuestNumber > 0)
            {
            };
        }

        private function onMailBtnClick():void
        {
            AllWindows.switchToFuncWindow(MailWin.EVENT_SHOW);
            this.hasNewMail = false;
            this.refreshLogo();
        }

        private function btnMouseDown(_arg_1:MovieClip):void
        {
            _arg_1.gotoAndStop("down");
        }

        public function refreshReportNumber():void
        {
            MainWin.instance.newUsualReportNumber = context.getPlayerBean().newReportCount;
            if (MainWin.instance.newUsualReportNumber > 99)
            {
                MainWin.instance.newUsualReportNumber = 99;
            };
            if (this.newRedReportNumber > 99)
            {
                this.newRedReportNumber = 99;
            };
        }

        private function reCheckEnemy(_arg_1:Event):void
        {
            checkEnemy();
        }

        public function onEnemyArmysUpdate(_arg_1:EnemyArmysUpdate):void
        {
            this.checkEnemy();
        }

        private function onHasNewReport(_arg_1:NewReport):void
        {
            this.hasNewReport = true;
            this.refreshLogo();
            refreshReportNumber();
            context.getPlayerBean().newReportCount = _arg_1.count;
            context.getPlayerBean().newReportCount_army = _arg_1.army_count;
            context.getPlayerBean().newReportCount_scout = _arg_1.scout_cout;
            context.getPlayerBean().newReportCount_trade = _arg_1.trade_count;
            context.getPlayerBean().newReportCount_other = _arg_1.other_count;
            MainWin.instance.newUsualReportNumber = context.getPlayerBean().newReportCount;
        }

        private function onHasNewMail(_arg_1:NewMail):void
        {
            MainWin.instance.newEmailNumber = _arg_1.count;
            this.refreshLogo();
            context.getPlayerBean().newMaileCount_inbox = _arg_1.count_inbox;
            context.getPlayerBean().newMaileCount_system = _arg_1.count_system;
        }

        private function onQuestBtnClick():void
        {
            AllWindows.switchToFuncWindow(QuestWin.EVENT_SHOW);
            MainWin.instance.setMyQuestBtnTooltipVisible(false);
        }


    }
}//package view

