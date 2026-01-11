// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//view.module.guide.GuideStep

package view.module.guide
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import com.evony.Context;
    import com.evony.MsgDispacther;
    import com.evony.common.beans.BuildingBean;
    import com.evony.common.constants.BuildingConstants;
    import com.evony.client.action.ActionFactory;
    import flash.events.Event;
    import view.MainWin;
    import flash.external.ExternalInterface;
    import com.evony.GameConfig;
    import com.evony.PreContext;
    import mx.core.Application;
    import flash.events.TimerEvent;
    import mx.events.PropertyChangeEvent;
    import com.evony.events.GuideStepChangeEvent;
    import com.evony.common.module.quest.QuestRewardRespone;
    import view.questWizard.Questwizard;
    import com.evony.common.module.CommandResponse;
    import flash.utils.setTimeout;
    import view.AllWindows;
    import flash.utils.*;

    public class GuideStep extends EventDispatcher 
    {

        private static var instance:GuideStep;

        private var _752714953townTask:Boolean;
        private var _1421503088cityTask:Boolean;
        private var _1757709207hideViewHere:Boolean = false;
        private var _601215973currentStep:int = 1000;
        private var currentQuestId:int;
        private var guideTaskList:Array;
        private var visibleTime:Timer;

        private var buildingSteps:Dictionary = new Dictionary();
        private var townTaskList:Array = [1000, 10101, 1, 2, 301, 3, 401, 4, 90001, 9001, 901, 9, 10001, 101, 10, 110, 11, 120, 12, 1300, 130, 13, 140, 14, 150, 15];
        private var cityTaskList:Array = [50001, 5001, 501, 5, 6001, 601, 6, 7001, 701, 7, 8001, 801, 8];

        public function GuideStep()
        {
            if (Context.getInstance().getPlayerBean().tutorialStepId != 0)
            {
                currentStep = Context.getInstance().getPlayerBean().tutorialStepId;
            };
            checkTownTask();
            guideTaskList = [{
                "step":1000,
                "nextStep":10101
            }, {
                "step":10101,
                "nextStep":1
            }, {
                "step":1,
                "nextStep":2
            }, {
                "step":2,
                "nextStep":301
            }, {
                "step":301,
                "nextStep":3
            }, {
                "step":3,
                "nextStep":401
            }, {
                "step":401,
                "nextStep":4
            }, {
                "step":4,
                "nextStep":50001
            }, {
                "step":50001,
                "nextStep":5001
            }, {
                "step":5001,
                "nextStep":501
            }, {
                "step":501,
                "nextStep":5
            }, {
                "step":5,
                "nextStep":6001
            }, {
                "step":6001,
                "nextStep":601
            }, {
                "step":601,
                "nextStep":6
            }, {
                "step":6,
                "nextStep":7001
            }, {
                "step":7001,
                "nextStep":701
            }, {
                "step":701,
                "nextStep":7
            }, {
                "step":7,
                "nextStep":8001
            }, {
                "step":8001,
                "nextStep":801
            }, {
                "step":801,
                "nextStep":8
            }, {
                "step":8,
                "nextStep":90001
            }, {
                "step":90001,
                "nextStep":9001
            }, {
                "step":9001,
                "nextStep":901
            }, {
                "step":901,
                "nextStep":9
            }, {
                "step":9,
                "nextStep":10001
            }, {
                "step":10001,
                "nextStep":101
            }, {
                "step":101,
                "nextStep":10
            }, {
                "step":10,
                "nextStep":110
            }, {
                "step":110,
                "nextStep":11
            }, {
                "step":11,
                "nextStep":120
            }, {
                "step":120,
                "nextStep":12
            }, {
                "step":12,
                "nextStep":1300
            }, {
                "step":1300,
                "nextStep":130
            }, {
                "step":130,
                "nextStep":13
            }, {
                "step":13,
                "nextStep":140
            }, {
                "step":140,
                "nextStep":14
            }, {
                "step":14,
                "nextStep":150
            }, {
                "step":150,
                "nextStep":15
            }, {
                "step":15,
                "nextStep":999
            }];
            buildingSteps[1] = step1;
            buildingSteps[2] = step2;
            buildingSteps[401] = step401;
            buildingSteps[4] = step4;
            buildingSteps[501] = step501;
            buildingSteps[5] = step5;
            buildingSteps[601] = step601;
            buildingSteps[6] = step6;
            buildingSteps[701] = step701;
            buildingSteps[7] = step7;
            buildingSteps[801] = step801;
            buildingSteps[8] = step8;
            buildingSteps[901] = step901;
            buildingSteps[9] = step9;
            buildingSteps[101] = step101;
            buildingSteps[10] = step10;
            MsgDispacther.getInstance().addEventListener("cityInNewBuilding", onCityIn);
            MsgDispacther.getInstance().addEventListener("cityOutNewBuilding", onCityOut);
        }

        public static function getInstance():GuideStep
        {
            if (instance == null)
            {
                instance = new (GuideStep)();
            };
            return (instance);
        }


        public function step130():void
        {
            nextStep();
        }

        public function step10():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_HEROS_MANSION) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 81, awardResponse);
                    currentQuestId = 81;
                    nextStep();
                };
            };
        }

        private function onCityOut(_arg_1:Event):void
        {
            switch (currentStep)
            {
                case 5001:
                    step5001();
                    return;
                case 6001:
                    step6001();
                    return;
                case 7001:
                    step7001();
                    return;
                case 8001:
                    step8001();
                    return;
            };
        }

        public function step9():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_TAVERN) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 80, awardResponse);
                    currentQuestId = 80;
                    nextStep();
                };
            };
        }

        public function step90001():void
        {
            nextStep();
        }

        public function step6001():void
        {
            nextStep();
        }

        public function preStep():void
        {
        }

        private function endTimeHandle(_arg_1:TimerEvent):void
        {
            visibleTime.stop();
            MainWin.instance.SkipTutorialBtn.visible = false;
            Context.getInstance().needUserGuide = false;
            if (((Context.getInstance().saveGame == false) && (EvonyClient.isTryUser)))
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("tour_by_flash", Context.getInstance().iPicId, "finished", GuideStep.getInstance().currentStep, "", GameConfig.instance.serverID);
                };
                if (!PreContext.getInstance().bHasLordName)
                {
                    SaveGameStep1Win.getInstance().show();
                };
            }
            else
            {
                if (((!(EvonyClient(Application.application).isOutLogin)) && (!(PreContext.getInstance().bHasLordName))))
                {
                    SaveGameStep2Win.getInstance().show();
                };
            };
            visibleTime.removeEventListener(TimerEvent.TIMER_COMPLETE, endTimeHandle);
            MainWin.instance.guideLady.visible = false;
        }

        public function step12():void
        {
            if (Context.getInstance().needUserGuide)
            {
                if (currentStep == 12)
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 83, awardResponse);
                    currentQuestId = 83;
                    nextStep();
                };
            };
        }

        public function step1300():void
        {
            nextStep();
        }

        [Bindable(event="propertyChange")]
        public function get currentStep():int
        {
            return (this._601215973currentStep);
        }

        [Bindable(event="propertyChange")]
        public function get cityTask():Boolean
        {
            return (this._1421503088cityTask);
        }

        public function set cityTask(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1421503088cityTask;
            if (_local_2 !== _arg_1)
            {
                this._1421503088cityTask = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cityTask", _local_2, _arg_1));
            };
        }

        public function step140():void
        {
            if (currentStep == 140)
            {
                nextStep();
            };
        }

        public function setCurrentStep(_arg_1:int):void
        {
            currentStep = _arg_1;
            this.dispatchEvent(new GuideStepChangeEvent(this.currentStep, GuideStepChangeEvent.NAME));
            ActionFactory.getInstance().getCommonCommands().step(currentStep);
            if (_arg_1 == 999)
            {
                Context.getInstance().needUserGuide = false;
            };
        }

        public function step9001():void
        {
            nextStep();
        }

        public function step10101():void
        {
            nextStep();
        }

        public function step5001():void
        {
            nextStep();
        }

        public function step501():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_FARM_LAND) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step701():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_STONE_MINE) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step101():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_HEROS_MANSION) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step901():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_TAVERN) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step301():void
        {
            nextStep();
        }

        public function step1000():void
        {
            nextStep();
        }

        public function step13():void
        {
            if (Context.getInstance().needUserGuide)
            {
                ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 223, awardResponse);
                currentQuestId = 223;
                nextStep();
            };
        }

        public function set hideViewHere(_arg_1:Boolean):void
        {
            var _local_2:Object = this._1757709207hideViewHere;
            if (_local_2 !== _arg_1)
            {
                this._1757709207hideViewHere = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "hideViewHere", _local_2, _arg_1));
            };
        }

        private function onCityIn(_arg_1:Event):void
        {
            switch (currentStep)
            {
                case 10101:
                    step10101();
                    return;
                case 9001:
                    step9001();
                    return;
                case 10001:
                    step10001();
                    return;
            };
        }

        [Bindable(event="propertyChange")]
        public function get hideViewHere():Boolean
        {
            return (this._1757709207hideViewHere);
        }

        public function step150():void
        {
            nextStep();
        }

        public function set townTask(_arg_1:Boolean):void
        {
            var _local_2:Object = this._752714953townTask;
            if (_local_2 !== _arg_1)
            {
                this._752714953townTask = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "townTask", _local_2, _arg_1));
            };
        }

        private function awardItemsResponse(_arg_1:QuestRewardRespone):void
        {
            AwardWin.show(_arg_1, currentQuestId);
        }

        private function awardResponse(_arg_1:CommandResponse):void
        {
            ActionFactory.getInstance().getQuestCommands().getAwardItems(currentQuestId, awardItemsResponse);
            if (Context.getInstance().need_QuestGuid)
            {
                Questwizard.instance.GetQuestList();
            };
        }

        [Bindable(event="propertyChange")]
        public function get townTask():Boolean
        {
            return (this._752714953townTask);
        }

        public function set currentStep(_arg_1:int):void
        {
            var _local_2:Object = this._601215973currentStep;
            if (_local_2 !== _arg_1)
            {
                this._601215973currentStep = _arg_1;
                this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "currentStep", _local_2, _arg_1));
            };
        }

        public function step110():void
        {
            nextStep();
        }

        public function step8001():void
        {
            nextStep();
        }

        public function checkStepBuilding():void
        {
            if (Context.getInstance().needUserGuide)
            {
                if (buildingSteps[currentStep] != null)
                {
                    var _local_1:* = this.buildingSteps;
                    (_local_1[currentStep]());
                };
            };
        }

        private function checkTownTask():void
        {
            var _local_1:int;
            var _local_2:int;
            townTask = false;
            cityTask = false;
            for each (_local_1 in townTaskList)
            {
                if (this.currentStep == _local_1)
                {
                    townTask = true;
                    break;
                };
            };
            for each (_local_2 in cityTaskList)
            {
                if (this.currentStep == _local_2)
                {
                    cityTask = true;
                    break;
                };
            };
        }

        public function step120():void
        {
            nextStep();
        }

        public function step1():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_HOUSE) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                    setTimeout(onHideViewHereTimeout, 5000);
                };
            };
        }

        public function step3():void
        {
            if (Context.getInstance().needUserGuide)
            {
                ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 1, awardResponse);
                currentQuestId = 1;
                nextStep();
            };
        }

        public function step4():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_HOUSE) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 2)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 2, awardResponse);
                    currentQuestId = 2;
                    nextStep();
                };
            };
        }

        public function step401():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                AllWindows.closeAll();
                if ((((_local_1.typeId == BuildingConstants.TYPE_HOUSE) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)) && (_local_1.level == 1)))
                {
                    nextStep();
                };
            };
        }

        public function step6():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_LUMBER_MILL) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 16, awardResponse);
                    currentQuestId = 16;
                    nextStep();
                };
            };
        }

        public function step601():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_LUMBER_MILL) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step8():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_IRON_MINE) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 18, awardResponse);
                    currentQuestId = 18;
                    nextStep();
                };
            };
        }

        public function step7001():void
        {
            nextStep();
        }

        public function step14():void
        {
            if (Context.getInstance().needUserGuide)
            {
                ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 535, awardResponse);
                currentQuestId = 535;
                nextStep();
            };
        }

        public function step5():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_FARM_LAND) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 15, awardResponse);
                    currentQuestId = 15;
                    setTimeout(onHideViewHereTimeout, 5000);
                    nextStep();
                };
            };
        }

        public function step7():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_STONE_MINE) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 17, awardResponse);
                    currentQuestId = 17;
                    nextStep();
                };
            };
        }

        public function step11():void
        {
            if (Context.getInstance().needUserGuide)
            {
                if (currentStep == 11)
                {
                    ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 82, awardResponse);
                    currentQuestId = 82;
                    nextStep();
                };
            };
        }

        public function step801():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if (((_local_1.typeId == BuildingConstants.TYPE_IRON_MINE) && (_local_1.status == BuildingConstants.STATUS_UPGRADING)))
                {
                    nextStep();
                };
            };
        }

        public function step2():void
        {
            var _local_1:BuildingBean;
            for each (_local_1 in Context.getInstance().getCurCastle().buildingsArray)
            {
                if ((((_local_1.typeId == BuildingConstants.TYPE_HOUSE) && (_local_1.status == BuildingConstants.STATUS_NORMAL)) && (_local_1.level == 1)))
                {
                    nextStep();
                };
            };
        }

        public function nextStep():void
        {
            var _local_1:Object;
            for each (_local_1 in guideTaskList)
            {
                if (currentStep == _local_1.step)
                {
                    currentStep = _local_1.nextStep;
                    break;
                };
            };
            checkTownTask();
            this.dispatchEvent(new GuideStepChangeEvent(this.currentStep, GuideStepChangeEvent.NAME));
            ActionFactory.getInstance().getCommonCommands().step(currentStep);
            if (currentStep == 999)
            {
                visibleTime = new Timer(38000, 1);
                visibleTime.addEventListener(TimerEvent.TIMER_COMPLETE, endTimeHandle);
                visibleTime.start();
                MainWin.instance.guideLady.height = (MainWin.instance.guideLady.height + 80);
                MainWin.instance.guideLady.ladybotom = (MainWin.instance.guideLady.ladybotom + 80);
                MainWin.instance.guidLadyBottom = 0;
            };
            MainWin.instance.guideLady.b_paly = true;
            MainWin.instance.guideLady.guideLadyStep = currentStep;
        }

        public function step50001():void
        {
            nextStep();
        }

        private function onHideViewHereTimeout():void
        {
            this.hideViewHere = true;
        }

        public function step10001():void
        {
            nextStep();
        }

        public function step15():void
        {
            if (currentStep == 15)
            {
                ActionFactory.getInstance().getQuestCommands().award(Context.getInstance().getCurCastle().id, 19, awardResponse);
                currentQuestId = 19;
                nextStep();
            };
        }


    }
}//package view.module.guide

