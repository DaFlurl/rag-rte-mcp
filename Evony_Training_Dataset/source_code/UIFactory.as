// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//com.evony.factory.UIFactory

package com.evony.factory
{
    import com.evony.util.EvonyAnimation;
    import view.ui.ConditionTooltip;
    import view.castle.building.SpaceTooltip;
    import view.castle.building.BuildingTooltip;
    import view.ui.CastleBuildTip;
    import view.ui.TimeUITip;
    import view.ui.EquipConditionTooltip;
    import com.evony.util.ResourceLoader;

    public class UIFactory 
    {

        private static var instance:UIFactory = new (UIFactory)();

        private var constructFrontUp:EvonyAnimation = null;
        private var townHallConstructFrontUp:EvonyAnimation = null;
        private var constructBackUp:EvonyAnimation = null;
        private var townHallConstructBackUp:EvonyAnimation = null;
        private var buildingHammerMovie:EvonyAnimation = null;

        private var conditionTooltip:ConditionTooltip = new ConditionTooltip();
        private var spaceTooltip:SpaceTooltip = new SpaceTooltip();
        private var buildingTooltip:BuildingTooltip = new BuildingTooltip();
        private var castleBuildTip:CastleBuildTip = new CastleBuildTip();
        private var timeUITip:TimeUITip = new TimeUITip();
        private var equipConditionTooltip:EquipConditionTooltip = new EquipConditionTooltip();


        public static function getInstance():UIFactory
        {
            return (instance);
        }


        public function getBuildingHammerMovie():EvonyAnimation
        {
            if (buildingHammerMovie == null)
            {
                buildingHammerMovie = new EvonyAnimation();
                buildingHammerMovie.load(EvonyAnimation.TYPE_HammerIn, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
            };
            buildingHammerMovie.mouseChildren = false;
            buildingHammerMovie.mouseEnabled = false;
            return (buildingHammerMovie);
        }

        public function getEquipConditionTooltip():EquipConditionTooltip
        {
            return (this.equipConditionTooltip);
        }

        public function getConstructFrontUp():EvonyAnimation
        {
            if (constructFrontUp == null)
            {
                constructFrontUp = new EvonyAnimation();
                constructFrontUp.load(EvonyAnimation.TYPE_constructFrontUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
            };
            return (constructFrontUp);
        }

        public function getTimeUITip():TimeUITip
        {
            return (this.timeUITip);
        }

        public function getTownHallConstructFrontUp():EvonyAnimation
        {
            if (townHallConstructFrontUp == null)
            {
                townHallConstructFrontUp = new EvonyAnimation();
                townHallConstructFrontUp.load(EvonyAnimation.TYPE_constructTWFrontUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
            };
            return (townHallConstructFrontUp);
        }

        public function getSpaceTooltip():SpaceTooltip
        {
            return (this.spaceTooltip);
        }

        public function getCastleBuildTip():CastleBuildTip
        {
            return (this.castleBuildTip);
        }

        public function getConditionTooltip():ConditionTooltip
        {
            return (this.conditionTooltip);
        }

        public function getConstructBackUp():EvonyAnimation
        {
            if (constructBackUp == null)
            {
                constructBackUp = new EvonyAnimation();
                constructBackUp.load(EvonyAnimation.TYPE_constructBackUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
            };
            return (constructBackUp);
        }

        public function getBuildingTooltip():BuildingTooltip
        {
            return (this.buildingTooltip);
        }

        public function getTownHallConstructBackUp():EvonyAnimation
        {
            if (townHallConstructBackUp == null)
            {
                townHallConstructBackUp = new EvonyAnimation();
                townHallConstructBackUp.load(EvonyAnimation.TYPE_constructTWBackUp, -1, ResourceLoader.LOAD_BACKGROUND_DEMAND, 0, false, true);
            };
            return (townHallConstructBackUp);
        }


    }
}//package com.evony.factory

